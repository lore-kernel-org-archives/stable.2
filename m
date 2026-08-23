Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [46.38.247.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781C1350298;
	Sun, 23 Aug 2026 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.38.247.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787481434; cv=none; b=ogHkVZod0WJy87qAkHlwiX4+/Hq4Jh56I/H9MgpXB38hL9E5mDqTlpRs0cxbjXJrkt6Pimmufoh361rt1MOXiGqCC73UxPTHv2kMo2y4daOjZMryV/MFf4tSFnxVorlq3Sm0qfsO4Fzw/KZLyJE3vGO9iUW+wq6ms44kWE5D3vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787481434; c=relaxed/simple;
	bh=09ExjRwEniqAyCZArbfV9HxRNdEC8kmThudrM5PgKuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JWlJZ9N0DcWS2MXGU1Y+ml9P+8Sf2jq0KZ+O2XoCyKpHOnpeeHPtkcHhyWAHWvopimzbR5slR2I+XWesmpYbo89KP35Btm309hJRisL5RgFNWiVmeP4hj91PsGD5uputB+VgaQQ/lBk0CUPd1KFK0lWG0WQQ9JNvba/u7j4dHIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=NsUj6y86; arc=none smtp.client-ip=46.38.247.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="NsUj6y86"
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4hSVpl4GN2z85WD;
	Sun, 23 Aug 2026 12:37:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1787481423;
	bh=09ExjRwEniqAyCZArbfV9HxRNdEC8kmThudrM5PgKuY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NsUj6y86DyEPaIP9XEFmA1JIUiI3gV9YWifmZgGrr5No07iJTYy9sSUsvbRqVs1px
	 EQd6BgZ4DUISbU3xaecmpeBNskamwCVZbTDj3Frr9OPIMYfeDMOLewM2NbK/7HC45p
	 n9BBRnvruL7MnBDqH3JIjKFLiQDF+cS+jc9biRlsEseDmAJQQeKl/Xo+rYHxueZUxd
	 z/phEOqWHjpZM2/qImlUK8WT6jg5q5+S+iPvxFyQ93OzHUtI68eRIYNBGWm74URakE
	 wVBeGEI80oKiTr54OWf4NebMrM94U+dxd7/Tj6JgWXm790aMSqrgSk1AT6cF3btfU4
	 tfu2n2wTvhJ9w==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4hSVpg3mSxz4ysv;
	Sun, 23 Aug 2026 12:36:59 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4hSVpd5ms5z8tcv;
	Sun, 23 Aug 2026 12:36:57 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id F3DA15FA9D;
	Sun, 23 Aug 2026 12:36:56 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <07435e6b-ee30-4c85-8c8b-0ce3a4ead1d9@leemhuis.info>
Date: Sun, 23 Aug 2026 12:36:55 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 6.12.36+: usb: hub: post-resume delayed work
 triggers > uncorrected MCE / data fabric sync flood on Threadripper 7970X >
 (bisected to aec11e5f9c45)
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: linux-usb@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>, Forest <forestix@gaga.casa>,
 Slavik Dev <developer.slavik@gmail.com>,
 Michal Pecio <michal.pecio@gmail.com>,
 Mathieu Fluhr <mathieu.fluhr@gmail.com>
References: 
 <CAPyJwA_D9qw0T72f8zwM1yKjP+To=maVANbcdsWM7yRmbBxYvw@mail.gmail.com>
 <CAPyJwA9R=p8_uxyYODb00g_nUq26SRsWHBGgAAJnR0YMTRRo4A@mail.gmail.com>
 <CAPyJwA9P48LDcOr7u_iT1WPFBCHxh9w6cxFvyi5GS3syM6crbQ@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CAPyJwA9P48LDcOr7u_iT1WPFBCHxh9w6cxFvyi5GS3syM6crbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <178748141745.2582893.17484614157422637338@mxe9fb.netcup.net>
X-NC-CID: oKDvubEgYe2okif0FtvNI3xLF2u1aHMJSpfCOi7NR4UdqTW5HSE=

On 8/23/26 12:15, Mathieu Fluhr wrote:
> On Sun, Aug 23, 2026 at 12:12 PM Mathieu Fluhr <mathieu.fluhr@gmail.com> wrote:
>> On Sun, Aug 23, 2026 at 11:55 AM Mathieu Fluhr <mathieu.fluhr@gmail.com> wrote:
>>>
>>> I'm reporting a regression that causes a hard platform reset on my workstation,
>>> But, before digging into the technical details, I would like to first re-trace
>>> how I came to this particular commit.

Thx for the report. Side note: mentioning the essence at the top before
explaining backstory and details is usually the way better approach to
get people interested in a bug report, especially if it's more that one
or two paras.

Anyway, as you mentioned later and quoted below, your problems are
caused by a 6.12.y backport of 8f5b7e2bec1c36 ("usb: hub: fix detection
of high tier USB3 devices behind suspended hubs") [v6.16-rc5 (2025-07-06
23:10:26)], authored by Mathias Nyman (now CCed).

There were at least three earlier reports about problems caused by that
commit, all mentioning adb (which I assume you use, too):

https://lore.kernel.org/all/qc0nhk9c6l0a08bkfeplrm3qjssgrjkvkp@sonic.net/
https://lore.kernel.org/all/CAGQo=TJXef-QzbkFEpTcJ138j0k6WYnV4=tNY8Q7s3U7DUOY+Q@mail.gmail.com/
https://bugzilla.kernel.org/show_bug.cgi?id=221103

FWIW, https://bugzilla.kernel.org/show_bug.cgi?id=221103#c16 mentions
the workaround you apparently found, too. The patch Mario (now CCed,
just like the authors of the two mailed reports linked above; and
Michael, too, who seems to be involved) proposed in the last comment of
that ticket apparently didn't help. And no other fix is in sight, or am
I missing something?

Mathias reverting the culprit in mainline a option to resolve this (I
assume it is not, but I'm asking just to be sure)?

Ideally this would have been fixed months ago, but seems to have fallen
through the cracks (partly my fault for not prodding people when this
stalled).

Ciao, Thorsten

>>> As an AOSP developer I am compiling daily different versions of AOSP on it,
>>> mostly building an Android (Automotive) emulator for quick "code-build-test"
>>> runs. I use Ubuntu 24.04 LTS for that, updating to the latest HWE kernels that
>>> Ubuntu provide there (6.8, 6.11, 6.14 etc. until 7.0 recently), with no manual
>>> modifications applied.
>>>
>>> 3 weeks ago, I needed to analyze and issue happening inside Android 11,
>>> building an emulator for a simple Android phone [1]. But when I started using
>>> this emulator, first with the latest 7.0 kernel I noticed several hard crashes,
>>> sometimes just freezing my workstation (with fans full on, but sometimes fans
>>> full off), but also sometimes automatically rebooting it.
>>>
>>> After a few days of deep investigations (To be honest, I first suspected an
>>> issue with the nivida driver), I found out that a pattern to reproduce this
>>> quickly was to let the computer idle with the emulator running. The crash was
>>> always occurring under 20/25 minutes, most of the time letting it idle for less
>>> than 10 was even sufficient.
>>>
>>> This made me a bit curious, and looking a bit deeper (and with a little help
>>> of AI) I was able to find a workaround. forbidding my CPU to enter C2 state,
>>> using "processor.max_cstate=1" argument. Using this, I was not able to
>>> reproduce the crash for more than an hour, but I did not pursue there very
>>> much: As a developer I hate workarounds :)
>>>
>>> I instead started to get "back in time" on a clean and up-to-date fresh Ubuntu
>>> 24.04 install, reverting back to "good old" kernel versions, since I could not
>>> convince myself that first my CPU was dying and second that the issue has always
>>> been there. I confirmed that 6.8 and 6.11 (again Ubuntu HWE packages) work
>>> fine, but the crash was reproducible using 6.14 and above.
>>>
>>> I then got my hands dirty, and started to test different mainline kernel
>>> prebuilt packages up to a point where I confirmed that 6.12.35 worked fine, but
>>> 6.12.40 not. I then bisected both versions, ensuring a good case meant the
>>> emulator was idling without any crash for 1 hour minimum. This lead at the end
>>> to the following commit:
>>>
>>>   aec11e5f9c452ef64e2c113637ab89a67a5ceb62
>>>   ("usb: hub: fix detection of high tier USB3 devices behind suspended hubs")
>>>   [mainline: 8f5b7e2bec1c36578fdaa74a6951833541103e27]
>>>
>>> Being quite astonished that something related to C2 state was triggered by an
>>> USB patch, I then tested the latest 7.0 kernel, this time using the
>>> "usbcore.autosuspend=-1" argument instead. To my surprise, I could not
>>> reproduce the crash, even with the exact same emulator idling for 2 hours.
>>>
>>> Also, something very astonishing, that I still cannot fully understand today:
>>>  1. "priming" my system with a 30 seconds (!) run of a modern Android
>>>      emulator [2] cleared the issue: After closing the 15 emulator and starting
>>>      the 11, I could let it idle for again more than an hour. It seems even not
>>>      be related to the 'kvm' kernel modules, since removing the module and
>>>      re-inserting it between both emulator did not change a thing.
>>>  2. A few times (I did not really invest debugging this TBH), the crash even
>>>     occurred shortly (2-3 minutes) after I closed the Android 11 emulator.
>>>
>>> Now, the technical details of my setup...
>>>
>>> Hardware / software
>>> ===================
>>>
>>> CPU:        AMD Ryzen Threadripper 7970X (Storm Peak, family 19h)
>>> Microcode:  0x0a10810c
>>> Board:      ASUS Pro WS TRX50-SAGE WIFI, BIOS 1203 and 1317 (both affected)
>>> Memory:     128 GB DDR5 ECC RDIMM @ 4800 MT/s (JEDEC, no XMP/EXPO)
>>> GPU:        NVIDIA RTX 3080 Ti (also reproduced with RTX 5080)
>>> Distro:     Ubuntu 24.04 and 26.04 with 595-open NVIDIA driver
>>> USB:        8 onboard xHCI controllers; only a USB keyboard and mouse
>>>             attached
>>>
>>> Error signature
>>> ===============
>>>
>>> On the boot following each crash I could always see the following lines in
>>> the dmesg logs:
>>> ---8<-------------------------------------------------------------------------
>>>   x86/amd: Previous system reset reason [0x88000800]: an uncorrected
>>>            error caused a data fabric sync flood event
>>>   x86/amd: Previous system reset reason [0x88000800]: a software sync
>>>            flood event occurred
>>> ---8<-------------------------------------------------------------------------
>>>
>>> When I was fortunate enough and had an automatic reboot, this was also inside:
>>> ---8<-------------------------------------------------------------------------
>>>   [Hardware Error]: event severity: fatal
>>>   [Hardware Error]:   section_type: IA32/X64 processor error
>>>   [Hardware Error]:    Error Structure Type: cache error
>>>   [Hardware Error]:    Check Information: 0x000000000602001f
>>>   [Hardware Error]:     Transaction Type: 2, Generic
>>>   [Hardware Error]:     Level: 0
>>>   [Hardware Error]:     Processor Context Corrupt: true
>>>   [Hardware Error]:     Uncorrected: true
>>>   mce: [Hardware Error]: CPU 34: Machine Check: 0 Bank 5: aea0000000000108
>>>   mce: [Hardware Error]: TSC 0 ADDR 1ffffff98e8ee38 MISC d0150fff00000000
>>>        SYND 4d000000 IPID 500b020049b00
>>> ---8<-------------------------------------------------------------------------
>>>
>>> The signature is bit-identical across every occurrence except for the
>>> reporting CPU, which varies (observed on CPUs 1, 3, 7, 16, 32, 34, 35).
>>>
>>>
>>> Reproducer
>>> ==========
>>>
>>> 1. Boot an affected kernel with default idle settings (C2 available,
>>>    no max_cstate restriction).
>>> 2. Start an old and/or 32/64-bit Android emulator (QEMU/KVM guest) and leave it
>>>    idle on the launcher screen. Nothing else running.
>>> 3. System hard-resets within 20 minutes.
>>>
>>> Under sustained CPU load the fault never occurs; it requires the system to be
>>> idle. turbostat confirms ~99% C2 residency across all cores in the crashing
>>> condition.
>>>
>>>
>>> Bisection
>>> =========
>>>
>>> ---8<-------------------------------------------------------------------------
>>> git bisect start
>>> # status: waiting for both good and bad commits
>>> # good: [783cd2c3dca8b6c434e955b84c20c8940588dc68] Linux 6.12.35
>>> git bisect good 783cd2c3dca8b6c434e955b84c20c8940588dc68
>>> # status: waiting for bad commit, 1 good commit known
>>> # bad: [d90ecb2b1308b3e362ec4c21ff7cf0a051b445df] Linux 6.12.40
>>> git bisect bad d90ecb2b1308b3e362ec4c21ff7cf0a051b445df
>>> # good: [3ce57d493dd81ecc27033c7a918cc0d0ddaa8edc] ata: libata-acpi:
>>> Do not assume 40 wire cable if no devices are enabled
>>> git bisect good 3ce57d493dd81ecc27033c7a918cc0d0ddaa8edc
>>> # good: [bbd385b65f9e56cab1243e753510a99a59110083] net/mlx5e: Add new
>>> prio for promiscuous mode
>>> git bisect good bbd385b65f9e56cab1243e753510a99a59110083
>>> # good: [2a76bc2b24ed889a689fb1c9015307bf16aafb5b] smb: client: fix
>>> use-after-free in crypt_message when using async crypto
>>> git bisect good 2a76bc2b24ed889a689fb1c9015307bf16aafb5b
>>> # good: [95a13b0a6b042ac5333b67f59af1dffe7b71137b] riscv:
>>> traps_misaligned: properly sign extend value in misaligned load
>>> handler
>>> git bisect good 95a13b0a6b042ac5333b67f59af1dffe7b71137b
>>> # good: [40b5b4ba8ed87c0bfb6268c10589777652ebde4c] drm/mediatek: Add
>>> wait_event_timeout when disabling plane
>>> git bisect good 40b5b4ba8ed87c0bfb6268c10589777652ebde4c
>>> # bad: [affb46db59f908474a211f23953c3b9109f0d647] net: libwx: fix
>>> multicast packets received count
>>> git bisect bad affb46db59f908474a211f23953c3b9109f0d647
>>> # good: [ee56da95f8962b86fec4ef93f866e64c8d025a58] btrfs: fix block
>>> group refcount race in btrfs_create_pending_block_groups()
>>> git bisect good ee56da95f8962b86fec4ef93f866e64c8d025a58
>>> # bad: [bf71baa3cfe754c6e99ad62711b9fb3e3da33517] usb: hub: Fix
>>> flushing of delayed work used for post resume purposes
>>> git bisect bad bf71baa3cfe754c6e99ad62711b9fb3e3da33517
>>> # bad: [e11359640090ab26e4153cce583f50e0b8979f0d] usb: hub: Fix
>>> flushing and scheduling of delayed work that tunes runtime pm
>>> git bisect bad e11359640090ab26e4153cce583f50e0b8979f0d
>>> # bad: [aec11e5f9c452ef64e2c113637ab89a67a5ceb62] usb: hub: fix
>>> detection of high tier USB3 devices behind suspended hubs
>>> git bisect bad aec11e5f9c452ef64e2c113637ab89a67a5ceb62
>>> # first bad commit: [aec11e5f9c452ef64e2c113637ab89a67a5ceb62] usb:
>>> hub: fix detection of high tier USB3 devices behind suspended hubs
>>> ---8<-------------------------------------------------------------------------
>>>
>>> (Please note that I did not perform a full "revert test", since the aec11e5f9c45
>>> commit could not be cleanly reverted on both 6.12.40 and 7.0.0)
>>>
>>>
>>> Workarounds
>>> ===========
>>>
>>> Either of these prevents the crash on an affected kernel:
>>>   usbcore.autosuspend=-1     (disables USB runtime PM)
>>>   processor.max_cstate=1     (prevents C2 entry)
>>>
>>>
>>> Ruled out
>>> =========
>>>
>>> - GPU/driver: reproduced with RTX 5080 (595-open module) and RTX 3080 Ti
>>>               (both 595-open and 595 proprietary modules)
>>> - ASUS USB4 PCIe add-in card: reproduces in ~5 min with the card physically
>>>                               removed
>>> - AVIC: kvm_amd avic=N on both good and bad kernels
>>> - TSA mitigation: tsa=off verified applied
>>>   (/sys/devices/system/cpu/vulnerabilities/tsa = "Vulnerable"), still crashes
>>> - Memory: stock JEDEC 4800, no XMP/EXPO, no ECC errors logged
>>>   (ras-mc-ctl reports zero CE/UE)
>>> - Thermal/power: ~47-50 C at time of crash, system idle; 1600W Seasonic PSU
>>> - Hardware health: multi-hour AOSP compiles (all 64 threads, heavy cache
>>>   load) and repeated GPU stress runs complete without error
>>>
>>>
>>> I hope this gives you enough details to start looking at what could cause this
>>> weird behavior. Just FYI, when asked about hardware damage, AI suggested more
>>> something like "a CPU-level microcode erratum in the deep-idle path on this
>>> platform", but being old-school, I tend to always triple-check what AI tells
>>> before claiming it myself :)
>>>
>>> Thanks and Kind Regards,
>>> Mathieu
>>>
>>> ------
>>> [1] using android-11.0.0_r46 release tag and "sdk_phone_x86_64" as lunch target
>>> [3] using android-15.0.0_r32 release tag and "sdk_phone64_x86_64" as lunch
>>>     target this time, since Google only releases 64-bit only today
> 

