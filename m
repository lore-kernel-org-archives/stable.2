Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8E52D7398
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787479935; cv=pass; b=sfIUz4TpRKO6ZbITQWG70rP+pdg/Hj69Tl4r+ZnA0odPLOuDGUArwri9tMXHuK3fLdhNLJBkqkOthYqG6uXHStXOiRGM9YGHQA5DCDcN3vfyh/oM5Hg451ChsMLzFNVLLZE21UarymHy85eiIDkVg5oy6Fuwaa51ttqX9SZtD7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787479935; c=relaxed/simple;
	bh=yO6gfRS/aF6iHwp0DGSLLFy9hfvxt74hPXFk+hL/rm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSZGUEiL+xlFNy0+MBnotYoi49DNYvkLrAfbTvoB4feOgoHFkmSim5GdzsTlmjCVAwGVHb/ZRPO5ZF6uGaOUkwPCgKvfV+ifEaLtRs2q3SW1gO5N4tEM4uRneTu4Zk0ep7rwrLbyo0EtoGTlAqh0v4QEl9IYnskwIJODxvH4mV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ue824Ay3; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue824Ay3"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-499ac87c92bso20060915e9.1
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 03:12:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787479932; cv=none;
        d=google.com; s=arc-20260327;
        b=Wr7bM5bzhipp7AZYEP5C5F+DA1A10XUZ/G3prxPL3/SslJhKL3ixUU4Uw0W0aCUskO
         e2iI3o3zT++izWwoE6OzgWDrXFXANTvHuV7YPCEo3qNrr9ZJcDadIIujq1wBzY/aE0tA
         Nwlxn/1Ax8xGgTnf7NA7igTwt34ees3xI0vpUxcyIcS8yx43KX/Z74Yc1BSLFipY0iE0
         L6DIZlDAOycYJTwnnv4wlJKZPguUxW2J+26v8/4CUTyQIONcMzdxsY3R1bLx7xNuPSOO
         DvnqJ6aapspIsOmNVVCSX+OsXU8PSevD/r5zJYs8o2ccU3QBMZYgpojkaiqSXjuR6Ouq
         1P2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eEs2/q79DjHkHb7DAsjTXVLRHFO2vBhzPhdP7u4tRhM=;
        fh=CKBo7BDA85vORHuF3/QsQBU1DASzPUn8ZCd2pJ6cP2o=;
        b=EcZDF/ZsMYOGrDfQ0Y+rYOV3XjJPgOUlkXh7VT3chA6yI+nECfLbvYy3viGXzpci2L
         ozx8PoZ0P4FaQ+e14iuuOrbdQIjJx4FsULgu5QIr1+gjPBFu7qL0IQ4SHSjYovQGDOCL
         GWWMGJxarZUevwbz7JvtoKBpLIMejJfUCaC6qvTrsnqSLGTtq52GTZsUa25U2X6cnEQn
         +9HH8fNOjtR2XYZJZNr3axLzZ/cyPfQ6M3SOP2i9CEWLvEhJlGj0tRe7Gl+LD286yFn2
         gEBeBhQ6z9onZwgb88TphbNY6CJurLGsSqvm2Ps7PsSiKIye7WnV1mMcRrBaSUz7nFxS
         VYEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787479932; x=1788084732; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eEs2/q79DjHkHb7DAsjTXVLRHFO2vBhzPhdP7u4tRhM=;
        b=Ue824Ay3uL7CZmj9u6krg8rBZeDW29qgKgaCpdox3NaiHwqSKVmCfrNyHN3bAJUu0I
         gnebDu/vToKiXELu0xP8yAQDiM/xytGdvO9dqwQlHTMrobZKrEpB3YUOIrD3Nn/ViDZO
         cCci2gOxsYNTyghxkYP/3Ed4cGZXCycftBrJkfi1KxrkofzKm9TyTfJbEs77aMCtM3Sp
         OnaRTiMh7ip7VhlJHgkc1dLhdhQANYPT/Bkez0Hb340iSjE+Fzznlq7erFfnghmFKFUi
         ygnMbH6OXcmT5kbGaiFv2wuJcHO9slo8BTT6TEQ5UerInUxpGSIluJqn1Bz2QrvGkLDk
         QV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787479932; x=1788084732;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eEs2/q79DjHkHb7DAsjTXVLRHFO2vBhzPhdP7u4tRhM=;
        b=M88cT58514IEOi9ULiJ5eScIyhXhCr6OUvAPqP2Es9H1MYktBWosl7nnvIl2YFHa3G
         0ui9pqpPsxwsKDfpoGQyoCevzMcqA62nPXqoSVDmtemFp5UXp9XXJVFXvVYVXlUj7kDH
         6EgHVi6Pyz328EoGgoyzzOmZKE5+93PueYMCgnoEQsXwdSvw/mJOSPAvVhdzhLGOigKb
         5jJlCsoqobpJBSboPY59BIlx4METuJFbik1qyyM01CogZOB/eAskOXE9h2RAr8gtAywg
         1gBtydQoMpvgJH5Cojs7+u8GhqsZDHZDmiDFOsqocaPj5f3lt/0qsA0wtimCtCT2IO0y
         MMYQ==
X-Forwarded-Encrypted: i=1; AHgh+Rrt5vnEPS367kI5/twqEmqX/Ax00C//hhrO9AMS82And3tYqXRJWIvPHoB8UxYdaKarBrDImq4=@vger.kernel.org
X-Gm-Message-State: AFuF++nql+mgumzMIl6+eBHGHnW2xEPs98acZxdzARPdz5XKS5EQOMnC
	LFR7eK1ksI65vsVv8MMDvUmVGQeLQxnz5ClVcQ3/1yRvmAECCBgGccb4GQtlosedqn9YrRlXD3d
	ruMxEh3rKRVN7q2+L/WOsNej3JE0YR9w=
X-Gm-Gg: AR+sD10kYLJkuoKSnBN/6Vflw8kGANX0bZFdLETP7souxpSHHdImyQyyABjHFljSJkW
	Ho8WmQs/ibe4wtH7SJ+MIEWFJtmocmdzdJuRNOoOVMCO3dok2TGgp95b+oItNIJnkG/E21DNZkQ
	KskxEfvS7LsF11XpwPyn9f6gT+yZJoElYXTQUSzBL2e2AwJTiPk3E6WLlmrM8bqy+ctYxQJgn35
	nU+0KeqoKiL4kRuZsG0g4biesn1hXmyJtAkYj35/BeJfNEmS6pTMIT2CexRhbZmvR+34q7gLLSi
	8SQObaO92pyADm2XRdzRKxwPXnkcZnKQBmg1RjVpSX6lNVy/Zd2WLCcYPMI7TpZav7LuOi4Yd1p
	T
X-Received: by 2002:a05:600c:6211:b0:495:4d88:e630 with SMTP id
 5b1f17b1804b1-499b8465f7dmr242423775e9.10.1787479931575; Sun, 23 Aug 2026
 03:12:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPyJwA_D9qw0T72f8zwM1yKjP+To=maVANbcdsWM7yRmbBxYvw@mail.gmail.com>
In-Reply-To: <CAPyJwA_D9qw0T72f8zwM1yKjP+To=maVANbcdsWM7yRmbBxYvw@mail.gmail.com>
From: Mathieu Fluhr <mathieu.fluhr@gmail.com>
Date: Sun, 23 Aug 2026 12:12:00 +0200
X-Gm-Features: AcwNN1UXv1goIs8T1qqO8KPVBGHhVEvTrquMvvMSQtFnLcRylQvTfFrPDg5SYgY
Message-ID: <CAPyJwA9R=p8_uxyYODb00g_nUq26SRsWHBGgAAJnR0YMTRRo4A@mail.gmail.com>
Subject: Re:
To: mathias.nyman@linux.intel.com
Cc: stern@rowland.harvard.edu, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[REGRESSION] 6.12.36+: usb: hub: post-resume delayed work triggers
uncorrected MCE / data fabric sync flood on Threadripper 7970X
(bisected to aec11e5f9c45)

.... this time with the correct subject too.
(apologies for that stupid mistake)

On Sun, Aug 23, 2026 at 11:55=E2=80=AFAM Mathieu Fluhr <mathieu.fluhr@gmail=
.com> wrote:
>
> Hi all,
>
> I'm reporting a regression that causes a hard platform reset on my workst=
ation,
> But, before digging into the technical details, I would like to first re-=
trace
> how I came to this particular commit.
>
> As an AOSP developer I am compiling daily different versions of AOSP on i=
t,
> mostly building an Android (Automotive) emulator for quick "code-build-te=
st"
> runs. I use Ubuntu 24.04 LTS for that, updating to the latest HWE kernels=
 that
> Ubuntu provide there (6.8, 6.11, 6.14 etc. until 7.0 recently), with no m=
anual
> modifications applied.
>
> 3 weeks ago, I needed to analyze and issue happening inside Android 11,
> building an emulator for a simple Android phone [1]. But when I started u=
sing
> this emulator, first with the latest 7.0 kernel I noticed several hard cr=
ashes,
> sometimes just freezing my workstation (with fans full on, but sometimes =
fans
> full off), but also sometimes automatically rebooting it.
>
> After a few days of deep investigations (To be honest, I first suspected =
an
> issue with the nivida driver), I found out that a pattern to reproduce th=
is
> quickly was to let the computer idle with the emulator running. The crash=
 was
> always occurring under 20/25 minutes, most of the time letting it idle fo=
r less
> than 10 was even sufficient.
>
> This made me a bit curious, and looking a bit deeper (and with a little h=
elp
> of AI) I was able to find a workaround. forbidding my CPU to enter C2 sta=
te,
> using "processor.max_cstate=3D1" argument. Using this, I was not able to
> reproduce the crash for more than an hour, but I did not pursue there ver=
y
> much: As a developer I hate workarounds :)
>
> I instead started to get "back in time" on a clean and up-to-date fresh U=
buntu
> 24.04 install, reverting back to "good old" kernel versions, since I coul=
d not
> convince myself that first my CPU was dying and second that the issue has=
 always
> been there. I confirmed that 6.8 and 6.11 (again Ubuntu HWE packages) wor=
k
> fine, but the crash was reproducible using 6.14 and above.
>
> I then got my hands dirty, and started to test different mainline kernel
> prebuilt packages up to a point where I confirmed that 6.12.35 worked fin=
e, but
> 6.12.40 not. I then bisected both versions, ensuring a good case meant th=
e
> emulator was idling without any crash for 1 hour minimum. This lead at th=
e end
> to the following commit:
>
>   aec11e5f9c452ef64e2c113637ab89a67a5ceb62
>   ("usb: hub: fix detection of high tier USB3 devices behind suspended hu=
bs")
>   [mainline: 8f5b7e2bec1c36578fdaa74a6951833541103e27]
>
> Being quite astonished that something related to C2 state was triggered b=
y an
> USB patch, I then tested the latest 7.0 kernel, this time using the
> "usbcore.autosuspend=3D-1" argument instead. To my surprise, I could not
> reproduce the crash, even with the exact same emulator idling for 2 hours=
.
>
> Also, something very astonishing, that I still cannot fully understand to=
day:
>  1. "priming" my system with a 30 seconds (!) run of a modern Android
>      emulator [2] cleared the issue: After closing the 15 emulator and st=
arting
>      the 11, I could let it idle for again more than an hour. It seems ev=
en not
>      be related to the 'kvm' kernel modules, since removing the module an=
d
>      re-inserting it between both emulator did not change a thing.
>  2. A few times (I did not really invest debugging this TBH), the crash e=
ven
>     occurred shortly (2-3 minutes) after I closed the Android 11 emulator=
.
>
> Now, the technical details of my setup...
>
> Hardware / software
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> CPU:        AMD Ryzen Threadripper 7970X (Storm Peak, family 19h)
> Microcode:  0x0a10810c
> Board:      ASUS Pro WS TRX50-SAGE WIFI, BIOS 1203 and 1317 (both affecte=
d)
> Memory:     128 GB DDR5 ECC RDIMM @ 4800 MT/s (JEDEC, no XMP/EXPO)
> GPU:        NVIDIA RTX 3080 Ti (also reproduced with RTX 5080)
> Distro:     Ubuntu 24.04 and 26.04 with 595-open NVIDIA driver
> USB:        8 onboard xHCI controllers; only a USB keyboard and mouse
>             attached
>
> Error signature
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> On the boot following each crash I could always see the following lines i=
n
> the dmesg logs:
> ---8<--------------------------------------------------------------------=
-----
>   x86/amd: Previous system reset reason [0x88000800]: an uncorrected
>            error caused a data fabric sync flood event
>   x86/amd: Previous system reset reason [0x88000800]: a software sync
>            flood event occurred
> ---8<--------------------------------------------------------------------=
-----
>
> When I was fortunate enough and had an automatic reboot, this was also in=
side:
> ---8<--------------------------------------------------------------------=
-----
>   [Hardware Error]: event severity: fatal
>   [Hardware Error]:   section_type: IA32/X64 processor error
>   [Hardware Error]:    Error Structure Type: cache error
>   [Hardware Error]:    Check Information: 0x000000000602001f
>   [Hardware Error]:     Transaction Type: 2, Generic
>   [Hardware Error]:     Level: 0
>   [Hardware Error]:     Processor Context Corrupt: true
>   [Hardware Error]:     Uncorrected: true
>   mce: [Hardware Error]: CPU 34: Machine Check: 0 Bank 5: aea000000000010=
8
>   mce: [Hardware Error]: TSC 0 ADDR 1ffffff98e8ee38 MISC d0150fff00000000
>        SYND 4d000000 IPID 500b020049b00
> ---8<--------------------------------------------------------------------=
-----
>
> The signature is bit-identical across every occurrence except for the
> reporting CPU, which varies (observed on CPUs 1, 3, 7, 16, 32, 34, 35).
>
>
> Reproducer
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> 1. Boot an affected kernel with default idle settings (C2 available,
>    no max_cstate restriction).
> 2. Start an old and/or 32/64-bit Android emulator (QEMU/KVM guest) and le=
ave it
>    idle on the launcher screen. Nothing else running.
> 3. System hard-resets within 20 minutes.
>
> Under sustained CPU load the fault never occurs; it requires the system t=
o be
> idle. turbostat confirms ~99% C2 residency across all cores in the crashi=
ng
> condition.
>
>
> Bisection
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> ---8<--------------------------------------------------------------------=
-----
> git bisect start
> # status: waiting for both good and bad commits
> # good: [783cd2c3dca8b6c434e955b84c20c8940588dc68] Linux 6.12.35
> git bisect good 783cd2c3dca8b6c434e955b84c20c8940588dc68
> # status: waiting for bad commit, 1 good commit known
> # bad: [d90ecb2b1308b3e362ec4c21ff7cf0a051b445df] Linux 6.12.40
> git bisect bad d90ecb2b1308b3e362ec4c21ff7cf0a051b445df
> # good: [3ce57d493dd81ecc27033c7a918cc0d0ddaa8edc] ata: libata-acpi:
> Do not assume 40 wire cable if no devices are enabled
> git bisect good 3ce57d493dd81ecc27033c7a918cc0d0ddaa8edc
> # good: [bbd385b65f9e56cab1243e753510a99a59110083] net/mlx5e: Add new
> prio for promiscuous mode
> git bisect good bbd385b65f9e56cab1243e753510a99a59110083
> # good: [2a76bc2b24ed889a689fb1c9015307bf16aafb5b] smb: client: fix
> use-after-free in crypt_message when using async crypto
> git bisect good 2a76bc2b24ed889a689fb1c9015307bf16aafb5b
> # good: [95a13b0a6b042ac5333b67f59af1dffe7b71137b] riscv:
> traps_misaligned: properly sign extend value in misaligned load
> handler
> git bisect good 95a13b0a6b042ac5333b67f59af1dffe7b71137b
> # good: [40b5b4ba8ed87c0bfb6268c10589777652ebde4c] drm/mediatek: Add
> wait_event_timeout when disabling plane
> git bisect good 40b5b4ba8ed87c0bfb6268c10589777652ebde4c
> # bad: [affb46db59f908474a211f23953c3b9109f0d647] net: libwx: fix
> multicast packets received count
> git bisect bad affb46db59f908474a211f23953c3b9109f0d647
> # good: [ee56da95f8962b86fec4ef93f866e64c8d025a58] btrfs: fix block
> group refcount race in btrfs_create_pending_block_groups()
> git bisect good ee56da95f8962b86fec4ef93f866e64c8d025a58
> # bad: [bf71baa3cfe754c6e99ad62711b9fb3e3da33517] usb: hub: Fix
> flushing of delayed work used for post resume purposes
> git bisect bad bf71baa3cfe754c6e99ad62711b9fb3e3da33517
> # bad: [e11359640090ab26e4153cce583f50e0b8979f0d] usb: hub: Fix
> flushing and scheduling of delayed work that tunes runtime pm
> git bisect bad e11359640090ab26e4153cce583f50e0b8979f0d
> # bad: [aec11e5f9c452ef64e2c113637ab89a67a5ceb62] usb: hub: fix
> detection of high tier USB3 devices behind suspended hubs
> git bisect bad aec11e5f9c452ef64e2c113637ab89a67a5ceb62
> # first bad commit: [aec11e5f9c452ef64e2c113637ab89a67a5ceb62] usb:
> hub: fix detection of high tier USB3 devices behind suspended hubs
> ---8<--------------------------------------------------------------------=
-----
>
> (Please note that I did not perform a full "revert test", since the aec11=
e5f9c45
> commit could not be cleanly reverted on both 6.12.40 and 7.0.0)
>
>
> Workarounds
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Either of these prevents the crash on an affected kernel:
>   usbcore.autosuspend=3D-1     (disables USB runtime PM)
>   processor.max_cstate=3D1     (prevents C2 entry)
>
>
> Ruled out
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> - GPU/driver: reproduced with RTX 5080 (595-open module) and RTX 3080 Ti
>               (both 595-open and 595 proprietary modules)
> - ASUS USB4 PCIe add-in card: reproduces in ~5 min with the card physical=
ly
>                               removed
> - AVIC: kvm_amd avic=3DN on both good and bad kernels
> - TSA mitigation: tsa=3Doff verified applied
>   (/sys/devices/system/cpu/vulnerabilities/tsa =3D "Vulnerable"), still c=
rashes
> - Memory: stock JEDEC 4800, no XMP/EXPO, no ECC errors logged
>   (ras-mc-ctl reports zero CE/UE)
> - Thermal/power: ~47-50 C at time of crash, system idle; 1600W Seasonic P=
SU
> - Hardware health: multi-hour AOSP compiles (all 64 threads, heavy cache
>   load) and repeated GPU stress runs complete without error
>
>
> I hope this gives you enough details to start looking at what could cause=
 this
> weird behavior. Just FYI, when asked about hardware damage, AI suggested =
more
> something like "a CPU-level microcode erratum in the deep-idle path on th=
is
> platform", but being old-school, I tend to always triple-check what AI te=
lls
> before claiming it myself :)
>
> Thanks and Kind Regards,
> Mathieu
>
> ------
> [1] using android-11.0.0_r46 release tag and "sdk_phone_x86_64" as lunch =
target
> [3] using android-15.0.0_r32 release tag and "sdk_phone64_x86_64" as lunc=
h
>     target this time, since Google only releases 64-bit only today
