Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07F7409298
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783685866; cv=none; b=s6Yn4Ae/TcG3I8p8/G7KTVcX21tJzk8p2np1koKAnvr5n4hxLF5KsbFz+HggqG9lLIEqImjwQSGzODtsvpok6j+8MJ3bPyvr62tVbutcZ6HOSwMiFTc1cH7GDmmvLp14JRa+uyIhcW5IyvOQDVZPmgGHJgHGbN40GGCWbkdYrhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783685866; c=relaxed/simple;
	bh=Xd+LIjsrX1OWvnvYe+x0CfkSqvNfwoaRAv8uAYDV1Gw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6HEtPMO8O1ESf43AplMweUCbk/LLrgvsmGPUenKFI52+t862V2kHq7i003eRga5RHhW4VdTddhEOyiyl2jTJLN9zyyA2C00EDazMwgq18AMv8RPDs139LczZu+KFUoZQ3YhR65+0jx7gHE7MYGFe6M35+Q8ux3JGEVzKlAYJvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kZnlcEJh; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kZnlcEJh"
Message-ID: <98dc115b-1dec-4fbb-bab7-2588e8b74bf8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783685861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xd+LIjsrX1OWvnvYe+x0CfkSqvNfwoaRAv8uAYDV1Gw=;
	b=kZnlcEJhPS0dndovJ7ijsJHEXiC6pXcs7enFkBE4YGba1fowC4m68Jr2RGpcL6KWSSW1yI
	cgY3ib5TWg5iSn3yfhU2whuWvGM1uUbWchrq0fv0AHg2nBdNRsSGfladGK5T8nxY/vCMjJ
	dPv2PLuYiRpKeGoNCD1nn8u3/p074VI=
Date: Fri, 10 Jul 2026 14:17:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: Bug#1141604: linux-image-6.12.94+deb13-amd64: does not detect
 ScreenPad on ASUS VivoBook
To: Salvatore Bonaccorso <carnil@debian.org>, Ponali <ponali2k@gmail.com>,
 Luke Jones <luke@ljones.dev>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Corentin Chary <corentin.chary@gmail.com>,
 Hans de Goede <hansg@kernel.org>
Cc: 1141604@bugs.debian.org, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org
References: <178340264407.17924.10135409461303815312.reportbug@ananaspc>
 <178362762638.911488.8564892548331679884@eldamar.lan>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Denis Benato <denis.benato@linux.dev>
In-Reply-To: <178362762638.911488.8564892548331679884@eldamar.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 7/9/26 22:08, Salvatore Bonaccorso wrote:
> Control: forwarded -1 https://lore.kernel.org/regressions/178362762638.911488.8564892548331679884@eldamar.lan
> Control: tags -1 + upstream
>
> Hi,
>
> Ponali reported in Debian (https://bugs.debian.org/1141604) the
> following issue after updating from 6.12.90 to 6.12.94. First quoting
> the report:
>
> On Tue, Jul 07, 2026 at 07:37:24AM +0200, Ponali wrote:
>> Package: src:linux
>> Version: 6.12.94-1
>> Severity: normal
>> Tags: upstream, regression
>> X-Debbugs-Cc: ponali2k@gmail.com
>>
>> Last known working kernel: 6.12.90-1
>> First known broken kernel: 6.12.94-1
>>
>>
>> Dear Maintainer,
>>
>> I upgraded all my packages through apt, which also upgraded the linux image
>> from 6.12.90 to 6.12.94.
>>
>> I expected the ScreenPad display to continue to be detected and exposed as a
>> DRM output, like on 6.12.90. The ScreenPad being the trackpad with a screen,
>> which came with my computer (ASUS VivoBook X532FA_S532FA).
>>
>> After upgrading and rebooting, the new kernel caused a regression where the
>> display of the ScreenPad fails to get recognized by the kernel. The touchpad
>> functionality still works. Usually, the ScreenPad would appear as "HDMI-A-1".
>> The DRM connector for it still exists (/sys/class/drm/card0-HDMI-A-1), but
>> "status" reports "disabled"
>>
>> I could not get the ScreenPad display to be recognized again on the new kernel,
>> so I configured GRUB to automatically boot to the 6.12.90 kernel through the
>> "Advanced Options". The ScreenPad is recognized on older kernel versions, so I
>> am still able to use it (until a new LPE comes around).
>>
>> To replicate:
>> 1. Boot with 6.12.90. The ScreenPad display is detected as HDMI-A-1.
>> 2. Boot with 6.12.94 with the exact same hardware.
>> 3. The ScreenPad display is no longer usable.
>>
>>
>> My main display is eDP-1 (1920x1080), though it isn't essential. My GPU is an
>> integrated Intel iGPU, and the driver used for both screens is i915. I have
>> booted to the new kernel for reportbug to get all the information
>> automatically, but i will continue to use the old one until the appropriate
>> time.
> Now, Ponali did bisect the changes between 6.12.90 and 6.12.94 and
> found that the backport of the commit 8d95d1f4aa5c ("platform/x86:
> asus-wmi: fix screenpad brightness range") changed the behaviour.
> Bisect log is at: https://bugs.debian.org/1141604#22
>
> As this change was backported to other stable series as well I asked
> Ponali to please test 7.0.y and 7.1.y and confirmed that both 7.0.13
> and as well 7.1.3 show the hehaviour.
>
> #regzbot introduced: 8d95d1f4aa5c76202b0833a70998769384612488
> #regzbot link: https://bugs.debian.org/1141604
>
> Is there anything Ponali can report back to further debug the issue?
Hi Salvatore,

The commit incriminated is this one: https://lore.kernel.org/all/20260302174431.349816-3-denis.benato@linux.dev/

As you can see that commit changes min/max of the brightness range, but does not touch the detection at all,
while the user is complaining about "the display of the ScreenPad fails to get recognised by the kernel" and I can only thing about two things:
- I got the range wrong and the kernel is rejecting the device due to wrong min/max
- It's not true that the kernel fails to recognise the device and instead it's userspace refusing to expose it (this happened recently with upower for the battery so it can very well be a possibility)

From the dmesg logs I don't see kernel being angry and rejecting the screenpad so I am leaning on the second option: may I ask for the user to try identify the sysfs attribute responsible to control the brightness and get me the range of min/max? Also I would be curious to know if changing desktop like KDE or GNOME changes something.

> Regards,
> Salvatore
