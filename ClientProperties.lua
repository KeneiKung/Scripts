local data = {};
local FrameTimer = tick();
local FrameCounter = 0;
local FPS = 60;
getgenv().FrameCounter = 0;
FrameCounter =  FrameCounter + 1;
if (tick() - FrameTimer) >= 1 then
    FPS = FrameCounter;
    FrameTimer = tick();
    FrameCounter = 0;
    table.insert(data, FPS)
    table.insert(data, game:GetService('Stats').Network.ServerStatsItem['Data Ping']:GetValue())
end;
return data;
