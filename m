Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3773270EC3
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 09:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787478962; cv=pass; b=IWGPl5K4iTrpVRW7P9wYZCE97yf6L5WmGie08l9GeorqYTU6oFvxNx+Dqx3d2+tQRcr7y72YX3qY0SQvY9WxpI14TF6rLze0Knlx2a/tKk/YDyiccFEMb9zGlbfMlfW0B0Nt1zEtNtPT6IsTE4k2Yxh7KAIAPJvbuB2vtDY53lY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787478962; c=relaxed/simple;
	bh=Nw74la8wgtHJmZcuHFXYMTg8iPzT/6DbNZCXgT2YXgU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=psUFH29hQ2JNiu9rXIiN76IktuVez2izWNJ/7TPJSes6CoyKN3miRV7Gfr0o/HU3Qq1NVq4Ab1xvAWQlcTCfBnqdLLEWA121CjfSyAlsnWtFbRi+KjQHXs0OKoBbU4Rat87vjDBbCGXS/S4+AU3YpR4GqHLAkgSVft4VLUhpHxg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YR+b5aHw; arc=pass smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YR+b5aHw"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39c8e65e3f5so21337301fa.0
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 02:55:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787478956; cv=none;
        d=google.com; s=arc-20260327;
        b=puqek1vPpF710TX4tgrkA9LRX0Qy/r0xOBQ39zDR9WXDxs88bRrEy3vJDaFFEgazrk
         hxIzKvqQNw6c5U7LcDAlQe40hxPDyNYzn3U4dS4UAT//84slVsTvRITWLhodl0EXBmIC
         7zUh1MwGcPb6AkTDbK1q7xcstx182YhEXX0FnNxbMx5gcWj9PIuTj+vwpHfeCoAVQ2A4
         /GcQgPCHA3bZvQNCxiDWUgiB8Pt+MC43vyTrpDhclEDGfOKCFwEjJGajAWeOxEbFZkZ/
         Od5rUepaGcwO481JsmbRDNUbZk9BQoX0uWLs59KWKRsZZc4+zNaXetsECWf1q1C81/nj
         oTqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=FlTbrrUggaqMyw+bgqwhmY78qq8sF81Rm+Hrcy3EG6g=;
        fh=8l1ueQdVyTpZR8uIZbLkuehpRfC6VYtXNzkot+pp+h0=;
        b=gDOBTpIe7GV81eedp/V+VV8A5SsWfLzlJsLAbW//NfwuO5y9VJm25u5ODljSg0aPGK
         oW03i4ED1Lq6xZgNj0uUztVnRCf2MAKdbPtqbqj44AdWbns1qgmNBJAFtQXLNKp+zeCc
         6WvjXOKCjSYsWvb8LTcPyUQT4O7IMyXrrJaTfBkhhXsUwVRCmgfg8KhvvX6OQcig3gyb
         +NDhiiLm0sS10NJuZzCRWYkB707JVGGSMMw0GPLYVmsMM/3QQuWYiqQPNrbcRKc/Hos8
         HivWB8L0M9BmnEet/vfOhm9sNxhdKJIWI35QwwGaImoUJ9cUkitXISkc07hfurfRQcvR
         s80g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787478956; x=1788083756; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FlTbrrUggaqMyw+bgqwhmY78qq8sF81Rm+Hrcy3EG6g=;
        b=YR+b5aHwzP/y1Sxx14SN0C9ehdaILCgLvIzdD7TVRtY93tQmUU0M9+a8mQGnEdbV6T
         9MFcWGmW+DDBzDgB5MXuv+58MBfjCC/hXcA+CD7F6l/zuOHuIxTLb6hD/NJ1VVJzE248
         y9oTTfG5QeBhPR5qfwnHXqHn+mbA+tZBUQSxXYgcHQGuOFx+Gqrngicm7vWUFEfEihl+
         437JSSEGZAEjSyuW4pKeS/Ab/RR/5JwvHUOI9J6kLDyoaQSH8EMhVlogg8qPX8U9b9Rt
         t7cRs1nX+HAGy3spZkdr0L4QaIIm4Nu2ho8OpiwMTIZQxQOOECKo12deQqm4BN5JxiRl
         XMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787478956; x=1788083756;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FlTbrrUggaqMyw+bgqwhmY78qq8sF81Rm+Hrcy3EG6g=;
        b=E00LA3G4z5CEi1iwO7EvQHfKzY4oIcX/FQ90L3fASU/ZMLsjnGOshWJsz8VzNzff/y
         LzwW12rC5wlqA7UbmyeEzIqUzVzw5gTE15gyHP/bQVR3q+4dZTl+SyIANBFc7MEIqdya
         MAtKZN86n0wu+S35dEQnLg2w+bf8UvU7iOfxKq2la2q0HhIYbYVO+6Zve5lDyr4ArM16
         oZhqSR924OYfWYbmli6TDKTf+Hd9oY1nEiDhsx1KGzkWDE+wQ7KZdxNvahKxIhgV97Op
         Or32FiVrjvohEjEEZK47V7HzqVgR7Wogqi6NHj2wGDuBhtfRY1wJZ/MmaA+dyUiV9UGO
         WDZw==
X-Forwarded-Encrypted: i=1; AHgh+Rpxf/kGXjg9fKTFUAKM+Zz+xTwbMTVuXO4BHNUQXQGFqlGZRfJbhZZvDjEsFwXJhIS0qJ6+How=@vger.kernel.org
X-Gm-Message-State: AFuF++k6o8DXM7E1gl01LeU5IjJTa+exyy3l/1sXtFFcucCHnsN3mD3B
	b+oYvt7IT6U8hHLhs9+0k8bCzvvYWzd7Yqm95VteoYsGR3v820w4n/zVHGOCqZkUZ39oHp8v1XV
	HfJqWItF7bowcMZg+ca3swXsnCOFLcf4=
X-Gm-Gg: AR+sD13Qb5V/ZqeP/kcjV6ZKBH+zNkk2psT//gq1M+wCkJzD9TzLYpRylH/R6e3ufFS
	/yla6VOFgh84mrUgWq2UE1zg48EjiKqnUchwbprD7rIx8EJNdVnsIl8l6/g+Mv3T2yLhZPP9c+A
	KhCVnkNH0YN82cS+ksJ6Kdiic0/Wp3jNNrtPRjI/R/WeiNbCXbI9M8irRR104IcmXFtP+XENIFB
	17x4fxcrHvOHxCSq/NIKoilHzmRCecDNK5zRhI2IQecywgiA3NEGK7o3tWn/+DHULhzr2bP09TH
	2MQZ80ga3ka+qQwGeVNZg5c5hcntX5daPjU0FVvn/eckNmMz/a5DRwZ4XJhjAVc5ykJfCwFl7mx
	ZBNT69lp8Zjw=
X-Received: by 2002:a2e:bc24:0:b0:39c:7ae9:daa4 with SMTP id
 38308e7fff4ca-3a1aebfa043mr45890701fa.6.1787478956256; Sun, 23 Aug 2026
 02:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mathieu Fluhr <mathieu.fluhr@gmail.com>
Date: Sun, 23 Aug 2026 11:55:44 +0200
X-Gm-Features: AcwNN1WG1zr6pt-Fj0EIx9LKjxg42unheW4r6mklpNWhf3diH2GqnZH4wrwOwE4
Message-ID: <CAPyJwA_D9qw0T72f8zwM1yKjP+To=maVANbcdsWM7yRmbBxYvw@mail.gmail.com>
Subject: 
To: mathias.nyman@linux.intel.com
Cc: stern@rowland.harvard.edu, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,

I'm reporting a regression that causes a hard platform reset on my workstation,
But, before digging into the technical details, I would like to first re-trace
how I came to this particular commit.

As an AOSP developer I am compiling daily different versions of AOSP on it,
mostly building an Android (Automotive) emulator for quick "code-build-test"
runs. I use Ubuntu 24.04 LTS for that, updating to the latest HWE kernels that
Ubuntu provide there (6.8, 6.11, 6.14 etc. until 7.0 recently), with no manual
modifications applied.

3 weeks ago, I needed to analyze and issue happening inside Android 11,
building an emulator for a simple Android phone [1]. But when I started using
this emulator, first with the latest 7.0 kernel I noticed several hard crashes,
sometimes just freezing my workstation (with fans full on, but sometimes fans
full off), but also sometimes automatically rebooting it.

After a few days of deep investigations (To be honest, I first suspected an
issue with the nivida driver), I found out that a pattern to reproduce this
quickly was to let the computer idle with the emulator running. The crash was
always occurring under 20/25 minutes, most of the time letting it idle for less
than 10 was even sufficient.

This made me a bit curious, and looking a bit deeper (and with a little help
of AI) I was able to find a workaround. forbidding my CPU to enter C2 state,
using "processor.max_cstate=1" argument. Using this, I was not able to
reproduce the crash for more than an hour, but I did not pursue there very
much: As a developer I hate workarounds :)

I instead started to get "back in time" on a clean and up-to-date fresh Ubuntu
24.04 install, reverting back to "good old" kernel versions, since I could not
convince myself that first my CPU was dying and second that the issue has always
been there. I confirmed that 6.8 and 6.11 (again Ubuntu HWE packages) work
fine, but the crash was reproducible using 6.14 and above.

I then got my hands dirty, and started to test different mainline kernel
prebuilt packages up to a point where I confirmed that 6.12.35 worked fine, but
6.12.40 not. I then bisected both versions, ensuring a good case meant the
emulator was idling without any crash for 1 hour minimum. This lead at the end
to the following commit:

  aec11e5f9c452ef64e2c113637ab89a67a5ceb62
  ("usb: hub: fix detection of high tier USB3 devices behind suspended hubs")
  [mainline: 8f5b7e2bec1c36578fdaa74a6951833541103e27]

Being quite astonished that something related to C2 state was triggered by an
USB patch, I then tested the latest 7.0 kernel, this time using the
"usbcore.autosuspend=-1" argument instead. To my surprise, I could not
reproduce the crash, even with the exact same emulator idling for 2 hours.

Also, something very astonishing, that I still cannot fully understand today:
 1. "priming" my system with a 30 seconds (!) run of a modern Android
     emulator [2] cleared the issue: After closing the 15 emulator and starting
     the 11, I could let it idle for again more than an hour. It seems even not
     be related to the 'kvm' kernel modules, since removing the module and
     re-inserting it between both emulator did not change a thing.
 2. A few times (I did not really invest debugging this TBH), the crash even
    occurred shortly (2-3 minutes) after I closed the Android 11 emulator.

Now, the technical details of my setup...

Hardware / software
===================

CPU:        AMD Ryzen Threadripper 7970X (Storm Peak, family 19h)
Microcode:  0x0a10810c
Board:      ASUS Pro WS TRX50-SAGE WIFI, BIOS 1203 and 1317 (both affected)
Memory:     128 GB DDR5 ECC RDIMM @ 4800 MT/s (JEDEC, no XMP/EXPO)
GPU:        NVIDIA RTX 3080 Ti (also reproduced with RTX 5080)
Distro:     Ubuntu 24.04 and 26.04 with 595-open NVIDIA driver
USB:        8 onboard xHCI controllers; only a USB keyboard and mouse
            attached

Error signature
===============

On the boot following each crash I could always see the following lines in
the dmesg logs:
---8<-------------------------------------------------------------------------
  x86/amd: Previous system reset reason [0x88000800]: an uncorrected
           error caused a data fabric sync flood event
  x86/amd: Previous system reset reason [0x88000800]: a software sync
           flood event occurred
---8<-------------------------------------------------------------------------

When I was fortunate enough and had an automatic reboot, this was also inside:
---8<-------------------------------------------------------------------------
  [Hardware Error]: event severity: fatal
  [Hardware Error]:   section_type: IA32/X64 processor error
  [Hardware Error]:    Error Structure Type: cache error
  [Hardware Error]:    Check Information: 0x000000000602001f
  [Hardware Error]:     Transaction Type: 2, Generic
  [Hardware Error]:     Level: 0
  [Hardware Error]:     Processor Context Corrupt: true
  [Hardware Error]:     Uncorrected: true
  mce: [Hardware Error]: CPU 34: Machine Check: 0 Bank 5: aea0000000000108
  mce: [Hardware Error]: TSC 0 ADDR 1ffffff98e8ee38 MISC d0150fff00000000
       SYND 4d000000 IPID 500b020049b00
---8<-------------------------------------------------------------------------

The signature is bit-identical across every occurrence except for the
reporting CPU, which varies (observed on CPUs 1, 3, 7, 16, 32, 34, 35).


Reproducer
==========

1. Boot an affected kernel with default idle settings (C2 available,
   no max_cstate restriction).
2. Start an old and/or 32/64-bit Android emulator (QEMU/KVM guest) and leave it
   idle on the launcher screen. Nothing else running.
3. System hard-resets within 20 minutes.

Under sustained CPU load the fault never occurs; it requires the system to be
idle. turbostat confirms ~99% C2 residency across all cores in the crashing
condition.


Bisection
=========

---8<-------------------------------------------------------------------------
git bisect start
# status: waiting for both good and bad commits
# good: [783cd2c3dca8b6c434e955b84c20c8940588dc68] Linux 6.12.35
git bisect good 783cd2c3dca8b6c434e955b84c20c8940588dc68
# status: waiting for bad commit, 1 good commit known
# bad: [d90ecb2b1308b3e362ec4c21ff7cf0a051b445df] Linux 6.12.40
git bisect bad d90ecb2b1308b3e362ec4c21ff7cf0a051b445df
# good: [3ce57d493dd81ecc27033c7a918cc0d0ddaa8edc] ata: libata-acpi:
Do not assume 40 wire cable if no devices are enabled
git bisect good 3ce57d493dd81ecc27033c7a918cc0d0ddaa8edc
# good: [bbd385b65f9e56cab1243e753510a99a59110083] net/mlx5e: Add new
prio for promiscuous mode
git bisect good bbd385b65f9e56cab1243e753510a99a59110083
# good: [2a76bc2b24ed889a689fb1c9015307bf16aafb5b] smb: client: fix
use-after-free in crypt_message when using async crypto
git bisect good 2a76bc2b24ed889a689fb1c9015307bf16aafb5b
# good: [95a13b0a6b042ac5333b67f59af1dffe7b71137b] riscv:
traps_misaligned: properly sign extend value in misaligned load
handler
git bisect good 95a13b0a6b042ac5333b67f59af1dffe7b71137b
# good: [40b5b4ba8ed87c0bfb6268c10589777652ebde4c] drm/mediatek: Add
wait_event_timeout when disabling plane
git bisect good 40b5b4ba8ed87c0bfb6268c10589777652ebde4c
# bad: [affb46db59f908474a211f23953c3b9109f0d647] net: libwx: fix
multicast packets received count
git bisect bad affb46db59f908474a211f23953c3b9109f0d647
# good: [ee56da95f8962b86fec4ef93f866e64c8d025a58] btrfs: fix block
group refcount race in btrfs_create_pending_block_groups()
git bisect good ee56da95f8962b86fec4ef93f866e64c8d025a58
# bad: [bf71baa3cfe754c6e99ad62711b9fb3e3da33517] usb: hub: Fix
flushing of delayed work used for post resume purposes
git bisect bad bf71baa3cfe754c6e99ad62711b9fb3e3da33517
# bad: [e11359640090ab26e4153cce583f50e0b8979f0d] usb: hub: Fix
flushing and scheduling of delayed work that tunes runtime pm
git bisect bad e11359640090ab26e4153cce583f50e0b8979f0d
# bad: [aec11e5f9c452ef64e2c113637ab89a67a5ceb62] usb: hub: fix
detection of high tier USB3 devices behind suspended hubs
git bisect bad aec11e5f9c452ef64e2c113637ab89a67a5ceb62
# first bad commit: [aec11e5f9c452ef64e2c113637ab89a67a5ceb62] usb:
hub: fix detection of high tier USB3 devices behind suspended hubs
---8<-------------------------------------------------------------------------

(Please note that I did not perform a full "revert test", since the aec11e5f9c45
commit could not be cleanly reverted on both 6.12.40 and 7.0.0)


Workarounds
===========

Either of these prevents the crash on an affected kernel:
  usbcore.autosuspend=-1     (disables USB runtime PM)
  processor.max_cstate=1     (prevents C2 entry)


Ruled out
=========

- GPU/driver: reproduced with RTX 5080 (595-open module) and RTX 3080 Ti
              (both 595-open and 595 proprietary modules)
- ASUS USB4 PCIe add-in card: reproduces in ~5 min with the card physically
                              removed
- AVIC: kvm_amd avic=N on both good and bad kernels
- TSA mitigation: tsa=off verified applied
  (/sys/devices/system/cpu/vulnerabilities/tsa = "Vulnerable"), still crashes
- Memory: stock JEDEC 4800, no XMP/EXPO, no ECC errors logged
  (ras-mc-ctl reports zero CE/UE)
- Thermal/power: ~47-50 C at time of crash, system idle; 1600W Seasonic PSU
- Hardware health: multi-hour AOSP compiles (all 64 threads, heavy cache
  load) and repeated GPU stress runs complete without error


I hope this gives you enough details to start looking at what could cause this
weird behavior. Just FYI, when asked about hardware damage, AI suggested more
something like "a CPU-level microcode erratum in the deep-idle path on this
platform", but being old-school, I tend to always triple-check what AI tells
before claiming it myself :)

Thanks and Kind Regards,
Mathieu

------
[1] using android-11.0.0_r46 release tag and "sdk_phone_x86_64" as lunch target
[3] using android-15.0.0_r32 release tag and "sdk_phone64_x86_64" as lunch
    target this time, since Google only releases 64-bit only today
