Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E6D37BE85;
	Tue, 21 Jul 2026 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642530; cv=none; b=MwmYrjSdWFfpk/ve2tcIEutsizhSzaqTUapQ++fa/z8j+xkkv+HYklmQCytSjmS1lGlQXOvuaOGWs464QtQZdBRFIzgluVwSWYuZ7hntAM96uSfVtH7T0oclalUYEZiNgU+3rAtap2kJxhqzul0Xj3p5xGNI9qp4aDCMNsKlaAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642530; c=relaxed/simple;
	bh=9q4hEDJwnjbwsRow6xuQwL7e3ZD3pKxUYZLSk9ynxSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dXZCo49uZtDUbsXXawXFVj3oFP4iOFmgsvWzgTqPKA5qtRn70/BhBleFg46T0c6bB8eZ7z3tYv1TPmfW0Zylgk3VWvIrumDuQP0mWQV35jDES9ZH5pNqTP8NQBNsqhtmjlJr7d7mcW5o7Vj74feQptN8VXrUcUXXzqmujHxIdjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=NTK3GR3F; arc=none smtp.client-ip=188.68.61.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="NTK3GR3F"
Received: from mors-relay-8403.netcup.net (localhost [127.0.0.1])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4h4Jk91yqzz87j3;
	Tue, 21 Jul 2026 15:53:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1784641985;
	bh=9q4hEDJwnjbwsRow6xuQwL7e3ZD3pKxUYZLSk9ynxSU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NTK3GR3FcIsS7rOGbAv7rhONsLHUTi97PuceDtcdep07/eJja3Ng7F4EhrKucuMQD
	 BSRxRFYIQs3mwY9PP9MH11pDkLAH7hkHjlBVgkley/Tr8wr7dGsgHVOZwHfZAmWZEw
	 Cdx85GB82quTzAm54zwOBZp9JpUuVct6vVMI2Xdj/Ck2Heqo1TgugOoPGORUbDP7Bt
	 nkmYQKthnE+Iyz9oBkJUzGwC3Onbkrz/NV3Je2PCSL0DzeJ66BJYBojxL2AWverHML
	 Ok5iUgPv2wiVVXzQy34uPe+wVHnk0qgVV5/t++k9XMiG1tRlv5RExZ8gomHUc1wZjC
	 ZWKeks0MbDJIg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8403.netcup.net (Postfix) with ESMTPS id 4h4Jk91FMvz8FgP;
	Tue, 21 Jul 2026 15:53:05 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4h4Jk81NXDz8sbB;
	Tue, 21 Jul 2026 15:53:04 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 4FCE85FB8F;
	Tue, 21 Jul 2026 15:53:03 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <02595315-7971-4ec5-9d5d-d5b567ed52af@leemhuis.info>
Date: Tue, 21 Jul 2026 15:53:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bug#1141604: linux-image-6.12.94+deb13-amd64: does not detect
 ScreenPad on ASUS VivoBook
To: Denis Benato <denis.benato@linux.dev>,
 Salvatore Bonaccorso <carnil@debian.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Ponali <ponali2k@gmail.com>, Luke Jones <luke@ljones.dev>,
 Corentin Chary <corentin.chary@gmail.com>, Hans de Goede <hansg@kernel.org>,
 1141604@bugs.debian.org, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, regressions@lists.linux.dev,
 stable@vger.kernel.org
References: <178340264407.17924.10135409461303815312.reportbug@ananaspc>
 <178362762638.911488.8564892548331679884@eldamar.lan>
 <98dc115b-1dec-4fbb-bab7-2588e8b74bf8@linux.dev>
 <0ff0385e-50b0-bfae-cedc-05cfe9c6cbc7@linux.intel.com>
 <alE92R40JwcluApW@eldamar.lan>
 <a7b0db75-439f-4ae8-8721-da1d5fe86123@linux.dev>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <a7b0db75-439f-4ae8-8721-da1d5fe86123@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <178464198374.2561815.11447565488880481093@mxe9fb.netcup.net>
X-NC-CID: zYBHvL3LGbW3ro8tYT5vmokDcXDs2Uvpm2U+SKxCbzqcAUMprJk=

On 7/11/26 18:46, Denis Benato wrote:
> On 7/10/26 20:45, Salvatore Bonaccorso wrote:
>> On Fri, Jul 10, 2026 at 03:31:08PM +0300, Ilpo Järvinen wrote:
>>> On Fri, 10 Jul 2026, Denis Benato wrote:
>>>> On 7/9/26 22:08, Salvatore Bonaccorso wrote:
>>>>> Control: forwarded -1 https://lore.kernel.org/regressions/178362762638.911488.8564892548331679884@eldamar.lan
>>>>>
>>>>> Ponali reported in Debian (https://bugs.debian.org/1141604) the
>>>>> following issue after updating from 6.12.90 to 6.12.94. First quoting
>>>>> the report:
>>>>>
>>>>> On Tue, Jul 07, 2026 at 07:37:24AM +0200, Ponali wrote:
>>>>>> Package: src:linux
>>>>>> Version: 6.12.94-1
>>>>>> Severity: normal
>>>>>> Tags: upstream, regression
>>>>>> X-Debbugs-Cc: ponali2k@gmail.com
>>>>>>
>>>>>> Last known working kernel: 6.12.90-1
>>>>>> First known broken kernel: 6.12.94-1
>>>>>>
>>>>>> I upgraded all my packages through apt, which also upgraded the linux image
>>>>>> from 6.12.90 to 6.12.94.
>>>>>>
>>>>>> I expected the ScreenPad display to continue to be detected and exposed as a
>>>>>> DRM output, like on 6.12.90. The ScreenPad being the trackpad with a screen,
>>>>>> which came with my computer (ASUS VivoBook X532FA_S532FA).
>>>>>>
>>>>>> After upgrading and rebooting, the new kernel caused a regression where the
>>>>>> display of the ScreenPad fails to get recognized by the kernel. The touchpad
>>>>>> functionality still works. Usually, the ScreenPad would appear as "HDMI-A-1".
>>>>>> The DRM connector for it still exists (/sys/class/drm/card0-HDMI-A-1), but
>>>>>> "status" reports "disabled"
>>>>>>
>>>>>> I could not get the ScreenPad display to be recognized again on the new kernel,
>>>>>> so I configured GRUB to automatically boot to the 6.12.90 kernel through the
>>>>>> "Advanced Options". The ScreenPad is recognized on older kernel versions, so I
>>>>>> am still able to use it (until a new LPE comes around).
>>>>>>
>>>>>> To replicate:
>>>>>> 1. Boot with 6.12.90. The ScreenPad display is detected as HDMI-A-1.
>>>>>> 2. Boot with 6.12.94 with the exact same hardware.
>>>>>> 3. The ScreenPad display is no longer usable.
>>>>>>
>>>>>>
>>>>>> My main display is eDP-1 (1920x1080), though it isn't essential. My GPU is an
>>>>>> integrated Intel iGPU, and the driver used for both screens is i915. I have
>>>>>> booted to the new kernel for reportbug to get all the information
>>>>>> automatically, but i will continue to use the old one until the appropriate
>>>>>> time.
>>>>> Now, Ponali did bisect the changes between 6.12.90 and 6.12.94 and
>>>>> found that the backport of the commit 8d95d1f4aa5c ("platform/x86:
>>>>> asus-wmi: fix screenpad brightness range") changed the behaviour.
>>>>> Bisect log is at: https://bugs.debian.org/1141604#22
>>>>>
>>>>> As this change was backported to other stable series as well I asked
>>>>> Ponali to please test 7.0.y and 7.1.y and confirmed that both 7.0.13
>>>>> and as well 7.1.3 show the hehaviour.
>>>>>
>>>>> #regzbot introduced: 8d95d1f4aa5c76202b0833a70998769384612488
>>>>> #regzbot link: https://bugs.debian.org/1141604
>>>>>
>>>>> Is there anything Ponali can report back to further debug the issue?
>>>> Hi Salvatore,
>>>>
>>>> The commit incriminated is this one: https://lore.kernel.org/all/20260302174431.349816-3-denis.benato@linux.dev/
>>>>
>>>> As you can see that commit changes min/max of the brightness range, but 
>>>> does not touch the detection at all, 
>>> To be more precise, it DOES change read_screenpad_backlight_power() -> 
>>> asus_wmi_get_devstate_simple() but AFAICT that cannot make things worse 
>>> because asus_wmi_get_devstate_simple() used in both cases, so I was 
>>> left to wonder the same thing as you.
>>>
>>> That being said, it's hard to see how bisect could point this to a wrong 
>>> commit either because good/bad should be pretty obvious.
>>>
>>> Did reverting the suspect commit on top of 6.12.94 result in a working 
>>> system?
>> Ponali did test, and reported back in the Debian bug at
>> https://bugs.debian.org/1141604#60, quoting:
>>
>>> I have found the sysfs attribute for brightness control to be in
>>> /sys/class/backlight/asus_screenpad, and it appears on both 6.12.90 and
>>> 6.12.94.
>>>
>>> On 6.12.90, max_brightness reports 235.
>>>
>>> On 6.12.94, max_brightness reports 255.
>>>
>>>
>>> I have checked out to v6.12.94, reverted the suspect commit, and found
>>> the ScreenPad to be working as intended.
>>>
> The only reason I see is the the minimum might be greater than the maximum
> or negative and the kernel is rejecting it.
> 
> Can you also report back on the minimum?
> 
> Also if you could print a few values that would be helpful since I am not really seeing much here.
Ponali for some reason and afaics answered out-of-thread without you
among the recipients:
https://lore.kernel.org/all/5e456d33-7e8f-4e54-9149-ac3cff229445@gmail.com/

To quote:

"""
I have made a list of everything that the sysfs attribute can return in
6.12.90:


actual_brightness: 70
bl_power: 4
brightness: 70
max_brightness: 235
scale: unknown
type: raw
device/driver_override: (null)
device/modalias: platform:asus-nb-wmi
device/uevent: DRIVER=asus-nb-wmi
                MODALIAS=platform:asus-nb-wmi
power/async: disabled
power/control: auto
power/runtime_active_kids: 0
power/runtime_active_time: 0
power/runtime_enabled: disabled
power/runtime_status: unsupported
power/runtime_suspended_time: 0
power/runtime_usage: 0


In 6.12.94, only these files change:

bl_power: 0

max_brightness: 255


These files do not report any information:

uevent: [Blank file]
device/cpufv: [Permission denied]
power/autosuspend_delay_ms: [Input/output error]


For both kernels, setting the brightness to 0 has both brightness and
actual_brightness report 0.

I cannot check the minimum brightness through uevent because it shows up
as blank.


Regards,

Ponali
"""
