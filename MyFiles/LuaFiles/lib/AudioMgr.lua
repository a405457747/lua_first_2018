
-- Author: skyAllen
-- Date: 2023-09-07 15:01:08
-- Email: 894982165@qq.com
-- Copyright: © 2023 skyAllen

---@class AudioMgr
local AudioMgr = class("AudioMgr");

local musicDefaultVolume;
local _musicAudioSource;
local _soundAudioSources;
local user_data;

function AudioMgr.Init()
    musicDefaultVolume = 0.3;
    _musicAudioSource = Main.RootGo():AddComponent(typeof(AudioSource));--这个放在InitConfig会出错的哦
    _soundAudioSources = {};
    user_data = saveData.userSet;
    --print("i am Audio and data is ", data._musicEnable, data._soundEnable)
end

function AudioMgr.SwitchMusic()
    if not user_data._musicEnable then
        AudioMgr.PauseMusic()
    else
        AudioMgr.RecoverMusic()
    end
end

local function audioSourceCommon(audioSource, audioName, isLoop, volume, isPlayOneShot)
    audioSource.clip = ue.loadAudio(audioName);
    audioSource.loop = isLoop;
    audioSource.volume = volume;

    if isPlayOneShot then
        audioSource:PlayOneShot(audioSource.clip);
    else
        audioSource:Play();
    end
end

function AudioMgr.PlaySound(audioName, isLoop, volume, isPlayOneShot)
    if not user_data._soundEnable then
        do
            return
        end ;
    end

    local isLoop = isLoop or false;
    local volume = volume or 1;
    local isPlayOneShot = isPlayOneShot or false;

    if _soundAudioSources[audioName] ~= nil then
        if isPlayOneShot then
            _soundAudioSources[audioName]:PlayOneShot(_soundAudioSources[audioName].clip);
        else
            _soundAudioSources[audioName]:Play();
        end
    else
        local tempAudioSource = Main.RootGo():AddComponent(typeof(AudioSource));

        audioSourceCommon(tempAudioSource, audioName, isLoop, volume, isPlayOneShot);

        _soundAudioSources[audioName] = tempAudioSource;
    end

end

function AudioMgr.PlayMusic(audioName, isLoop, volume, isPlayOneShot)
    local isLoop = isLoop or true;
    local volume = volume or musicDefaultVolume;--这里设置了没用，一旦恢复就回到原点了。
    local isPlayOneShot = isPlayOneShot or false;

    audioSourceCommon(_musicAudioSource, audioName, isLoop, volume, isPlayOneShot);
end

function AudioMgr.PauseMusic()
    _musicAudioSource.volume = 0;
end

function AudioMgr.RecoverMusic()
    _musicAudioSource.volume = musicDefaultVolume;
end

return AudioMgr
