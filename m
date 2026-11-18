Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795038967;
	b=CG6atZI6OCVkUIgMgOHOvb3gHGuJPyjN8255eCYvPBI7kK4mI6hWM90jJLu2pFUSgZno
	 h6/fCy0rBBOdUeMghAMBBrC2Y07rsjJtBLD+vKgze9fRF3LnK3W2Nvavlgtufu/FOORQB
	 xQw81yMMgqE3Eu66wKiitLfbVWwpg0O8/ah/GD7EH/EmZywX6dd/6sJkAnwRqRRYNlc8k
	 ZyKKKSj5iIlxA9QtBjddAE7uOcfGRdjxlGZ7pwtywaWBzVIBqi1XQKqkg7p/nS36LOxLL
	 6bx2vPZTop7+LnDHuK56nxlal5arSwEAGT8+q3aNzECc2hZwOVKqcwY+coYb+L0Xw4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038967;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Content-Language:To:Cc:From:
	 Subject:Autocrypt:Content-Type:Content-Transfer-Encoding;
	bh=JP9DJ/6BgMEo7F/Go2s9zrWYqCykmDDtvRywOW1eMrI=;
	b=SHjGwjjWpRJa8VAPYjevf/fkSBUHOG3KgY7G26KfKMLvSCbiqNjPCwS4IIEH+AN33nbQ
	 MMqNwrk6y0v1FxM3NnJi3mqTVPRBL6YPNyWN9oH+I+xOBQfVfBdb47lNpk66FN1odvnbJ
	 baTVOgLQ4FDJkmOHOqqu6n48PSXzrUa4NU1A7ME2zXKiFZCEIpFwHkY/41OV+19tp4hKF
	 ERWgn/F86upSs9a0e2w6Ydbc9AbJO2p1u7mNfMEyRbG+VQ1aaAqxsPp88SdxNmtRAsiQY
	 71jU9TPlu1k56yBpTPeTzIZWm10Z81uTuhUvEX+YXx97QP6G5zAXCj4MZVWqRMEdCjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sp5KGuKY;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4382A606A320
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 21:56:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4382A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sp5KGuKY
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c5118deebcfso170135066b.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 13:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795038966; x=1795643766; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JP9DJ/6BgMEo7F/Go2s9zrWYqCykmDDtvRywOW1eMrI=;
        b=Sp5KGuKYr/IfuTF4KdTL6TsoU6ufqWrL0mg2eL7SwR6Qfw5IX91SykqE9Q55xZ29za
         cdpvyKguonGTEuoT1UkXDSehEyfTPa277GUP5hWU9sY9o/szpWwkHz1cqDVj7ZuL8mHm
         zW4IxUZCAKciPotqri4vyKp+Zu2KNGf/z+q/r2iGLvizkBuwMp0BZY3qjJfTfmWAdiPV
         GkrDUZ8aSWqgwDpn9dtDvMLSBONFhw2ZcjC5KnD0nbcATW7Df7Bor51OpNIkVjm41LI7
         a07VCyGDWex1pIrSzAV4YcLkf9ud4/MKpcY8k84/sBwHvUSPVFgBQSV67BLLpXeWJzwz
         /EZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795038966; x=1795643766;
        h=content-transfer-encoding:content-type:autocrypt:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JP9DJ/6BgMEo7F/Go2s9zrWYqCykmDDtvRywOW1eMrI=;
        b=MYuWuJzNP3r81W+EWYrzzbUxiJy8s7Z+SvPFmGJrgneiRQMhOpxPbA/Kp1GBONPvXt
         2UcWNIJGunv82FyAYJfwXpjGCkbJuyw7Zq9lTTvCENE+QI7SSjPhAjOCqy3sN1B1j20y
         TcT15pUa/Rg78n1EeHnAidlmiO/jURjVCooqN/RycXacm7OvviAqmhgHZngV5jLuMbMZ
         Bs4f4F1RTEH/QWzwdoEout/v6H/D4cAO5PaiYHWkP8e0eIXIse6l+YLmi2u5VVhmYbob
         QK6OowK/poSdNzMjTKkxhnhXgNfcJB7zPaVTvmyB8b6sR4Qer37bm5flk5LL2pC/t/WR
         yJTQ==
X-Forwarded-Encrypted: i=1; AL+hErHW0O1PVVaJYYsaoAC2goH/jRRdk7FeJVsN8VNbIQWRpB+DST/k+eZhFwZaw8+fVb6Tsnpnj1w=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8OF1frPvgO+/iGfWTZmK1cKgkGgfzTJC/lTBEpEzg4Ms3Ktxk
	RfU3Hb6Y04isPAdQXVDulyuOfauzM97MQXBt3Lbc2xOb+gdOq2Zul0Gh
X-Gm-Gg: AYBFou0cXUBARsmXYX5J+6ToRzouYisZg8S29QLJMfJyIquhXJCPRb7ATvIaenSTCfJ
	GBQa8fcTGSunBFk/RTFCtAvXJx6yB/EZHdLOce0ZTfH59zoEpdgersz1rVwr2eIzyyOqWdjkkFS
	6o3Uo/SYfEmqQMRZrLcA6RF8ATBqTP4lkatXlug/BDM7/B5HYUUMffb7t1ovazNaiD7mAQdL7DR
	GMbtyYvXtoqTsivQ7d0dK24iME+2QiHxBwSROTK/N3KlxISa1NYXZMMO0PkDnpDfgLPbiJvCLsU
	8peYk65QIbLteCjeOruB2Zgg+VrJQds0U3fXyPgOpAL/t4iphnAVE+OBsKoh/lwavM3EwKlzNLp
	CracuRbrhejJPzt7scQLlQr/HjJtIu8RQLUs1S/334+CzhBhW5utPZ6xsNOZBXSvJp2tFEJ6wjJ
	DwMK7VrNZKxAf04J0f0Dk9CACOgfcIaE8Plrl1uAbY6Wq+sq5fjlSAd4wmT56mt8VLAu1sv9jbf
	EXELAEw+sEsxP/Rw527mLRGIRO30edACBtoWCubF3MEzD0C6zgAurEBNXft72WqqcGOy9Jek+84
	XrkAqy4ztX+RmJJ4w8kCGQB9ORiWRRstGMK5XlxzKR2wB2keb4CzLvdHMyvoOQ==
X-Received: by 2002:a17:907:1c83:b0:c46:9ca9:f522 with SMTP id a640c23a62f3a-c510e1a6e2fmr380900066b.26.1795038965405;
        Wed, 18 Nov 2026 13:56:05 -0800 (PST)
Received: from [192.168.2.32] (clk-166.netdrive.pl. [185.24.27.166])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c512341e0adsm41316366b.36.2026.11.18.13.56.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 13:56:04 -0800 (PST)
Message-ID: <ec1ffcbb-1625-4925-ae6b-f2b04dca1e1a@gmail.com>
Date: Wed, 18 Nov 2026 22:56:01 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linux-media@vger.kernel.org, regressions@lists.linux.dev
Cc: jiangong.han@windriver.com, hverkuil+cisco@kernel.org,
 mchehab@kernel.org, stable@vger.kernel.org
From: =?UTF-8?Q?Pawe=C5=82_Ziemniak?= <pziemniak@gmail.com>
Subject: [REGRESSION] media: em28xx: NULL pointer dereference in
 em28xx_close_extension() on disconnect/unload
Autocrypt: addr=pziemniak@gmail.com; keydata=
 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 Yt7+
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

Commit 826915b6b65e ("media: em28xx: fix use-after-free of 
dev_next->devlist on disconnect",
CVE-2026-89891) introduces a 100% reproducible kernel NULL pointer 
dereference in
em28xx_close_extension() on real dual-TS hardware (Hauppauge 
WinTV-dualHD, USB ID 2040:8265)
whenever the device disconnects or the em28xx module is unloaded.

#regzbot introduced: 826915b6b65e

Impact
------
When triggered by a USB disconnect, the Oops kills the kworker thread on
usb_hub_wq (hub_event -> usb_disconnect -> usb_disable_device ->
usb_unbind_interface -> em28xx_usb_disconnect -> em28xx_close_extension)
while the USB device/hub lock is held. This permanently deadlocks USB
enumeration/lsusb and container/device teardown until a full host reboot.

When triggered by `modprobe -r em28xx_dvb em28xx_rc em28xx`, modprobe is
killed (SIGKILL) leaving em28xx stuck in initstate "going" (refcnt -1).

Hardware & Kernels Affected
---------------------------
- Hardware: Dell Inc. OptiPlex 3070 (Intel Cannon Lake PCH xHCI 
0000:00:14.0)
- USB Device: Hauppauge WinTV-dualHD (2040:8265, has_dual_ts = 1, 
is_audio_only = 0)
- Observed identically on Proxmox VE kernels (in-tree em28xx module; taint
   flags are only from ZFS/r8125 OOT modules and are unrelated):
   - 7.0.14-23-pve (2026-10-27, usb_hub_wq disconnect)
   - 7.0.14-26-pve (2026-10-28, usb_hub_wq disconnect)
   - 7.0.14-28-pve (2026-11-07, usb_hub_wq disconnect)
   - 7.0.14-29-pve (2026-11-18, modprobe -r reproducer)

Reproducer
----------
With a Hauppauge WinTV-dualHD (2040:8265) attached (and no userspace holding
/dev/dvb/*):
   # modprobe -r em28xx_dvb em28xx_rc em28xx
(or physically unplugging / resetting the USB stick).

Root Cause Analysis
-------------------
For normal dual-TS devices (has_dual_ts = 1, is_audio_only = 0), only the
primary `dev` is inserted into `em28xx_devlist`; `dev->dev_next->devlist`
is never added to `em28xx_devlist` (and remains zero-initialized with
next == NULL, prev == NULL).

Disassembly of the crashing Code bytes at 
`em28xx_close_extension+0x80/0x140`:

   mov    0x17a0(%r12),%rbx   ; rbx = dev->dev_next (ffff8ba4513fe000)
   test   %rbx,%rbx           ; if (!dev->dev_next)
   je     +0x4b
   mov    0x1f0(%rbx),%rax    ; rax = dev->dev_next->devlist.prev == 0x0
   mov    0x1e8(%rbx),%rdx    ; rdx = dev->dev_next->devlist.next == 0x0
   lea    0x1e8(%rbx),%rdi    ; rdi = &dev->dev_next->devlist 
(ffff8ba4513fe1e8)
   cmp    (%rax),%rdi         ; <-- #PF CR2=0x0 in 
list_del(&dev->dev_next->devlist)

Because `dev->dev_next->devlist.next` and `.prev` are NULL (0x0),
`list_del(&dev->dev_next->devlist)` unconditionally dereferences NULL
inside `__list_del_entry_valid()`.

If `em28xx_devlist` is only supposed to hold primary devices (as 
addressed by
commit 95f76f51937f "media: em28xx: defer audio-only extension 
registration"),
`list_del(&dev->dev_next->devlist)` should either be removed or guarded
(e.g., initialized with `INIT_LIST_HEAD(&dev_next->devlist)` and checked 
with
`!list_empty(&dev->dev_next->devlist)` or `dev->dev_next->devlist.next`).

Trace 1: Spontaneous USB Disconnect (deadlocks usb_hub_wq)
----------------------------------------------------------
usb 1-2: USB disconnect, device number 2
em28xx 1-2:1.0: Disconnecting em28xx #1
em28xx 1-2:1.0: Disconnecting em28xx
em28xx 1-2:1.0: Closing DVB extension
em28xx 1-2:1.0: Closing DVB extension
em28xx 1-2:1.0: Closing input extension
em28xx 1-2:1.0: Closing input extension
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: Oops: 0000 [#1] SMP PTI
CPU: 4 UID: 0 PID: 3086307 Comm: kworker/4:1 Tainted: P S  OE      
  7.0.14-28-pve #2 PREEMPT(lazy)
Tainted: [P]=PROPRIETARY_MODULE, [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE, 
[E]=UNSIGNED_MODULE
Hardware name: Dell Inc. OptiPlex 3070/02N3WF, BIOS 1.33.0 03/26/2025
Workqueue: usb_hub_wq hub_event
RIP: 0010:em28xx_close_extension+0x80/0x140 [em28xx]
Code: 81 fb 50 82 3c c1 75 cd 49 8b 9c 24 a0 17 00 00 48 85 db 74 4b 48 
8b 83 f0 01 00 00 48 8b 93 e8 01 00 00 48 8d bb e8 01 00 00 <48> 3b 38 
0f 85 fa 26 00 00 48 3b 7a 08 0f 85 f0 26 00 00 48 89 42
RSP: 0000:ffffcf6822097af8 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8ba4513fe000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8ba4513fe1e8
RBP: ffffcf6822097b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8ba45576c000
R13: ffff8ba4461dd8e0 R14: ffffffffc13c8590 R15: ffff8ba4461dd850
FS:  0000000000000000(0000) GS:ffff8babd7908000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000005f5b86004 CR4: 00000000003726f0
Call Trace:
  <TASK>
  em28xx_usb_disconnect.cold+0x71/0xbf [em28xx]
  usb_unbind_interface+0x9b/0x2e0
  device_remove+0x68/0x80
  device_release_driver_internal+0x206/0x270
  device_release_driver+0x12/0x20
  bus_remove_device+0xfd/0x1c0
  ? device_remove_attrs+0xb6/0x100
  device_del+0x160/0x3c0
  usb_disable_device+0xea/0x240
  usb_disconnect+0xe6/0x2e0
  hub_event+0xe8c/0x1a40
  process_one_work+0x1a9/0x3c0
  worker_thread+0x1b8/0x360
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xf7/0x130
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x2da/0x3a0
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
note: kworker/4:1[3086307] exited with irqs disabled

Trace 2: Deterministic Reproducer (`modprobe -r em28xx_dvb em28xx_rc 
em28xx`)
-----------------------------------------------------------------------------
em28xx 1-2:1.0: Closing DVB extension
em28xx 1-2:1.0: Closing DVB extension
em28xx: Removed (Em28xx dvb Extension) extension
em28xx 1-2:1.0: Closing input extension
em28xx 1-2:1.0: Closing input extension
em28xx: Removed (Em28xx Input Extension) extension
usbcore: deregistering interface driver em28xx
em28xx 1-2:1.0: Disconnecting em28xx #1
em28xx 1-2:1.0: Disconnecting em28xx
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: Oops: 0000 [#1] SMP PTI
CPU: 3 UID: 0 PID: 151085 Comm: modprobe Tainted: P S         OE     
  7.0.14-29-pve #1 PREEMPT(lazy)
Tainted: [P]=PROPRIETARY_MODULE, [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE, 
[E]=UNSIGNED_MODULE
Hardware name: Dell Inc. OptiPlex 3070/02N3WF, BIOS 1.33.0 03/26/2025
RIP: 0010:em28xx_close_extension+0x80/0x140 [em28xx]
Code: 81 fb 50 f2 14 c1 75 cd 49 8b 9c 24 a0 17 00 00 48 85 db 74 4b 48 
8b 83 f0 01 00 00 48 8b 93 e8 01 00 00 48 8d bb e8 01 00 00 <48> 3b 38 
0f 85 fa 26 00 00 48 3b 7a 08 0f 85 f0 26 00 00 48 89 42
RSP: 0018:ffffcadcb18d3b80 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8a28c5d92000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff8a28c5d921e8
RBP: ffffcadcb18d3b90 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8a28c5d96000
R13: ffff8a28df3b60e0 R14: ffffffffc114f590 R15: ffff8a28df3b6050
FS:  0000747342ef1640(0000) GS:ffff8a304b888000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000049f936006 CR4: 00000000003726f0
Call Trace:
  <TASK>
  em28xx_usb_disconnect.cold+0x71/0xbf [em28xx]
  usb_unbind_interface+0x9b/0x2e0
  device_remove+0x68/0x80
  device_release_driver_internal+0x206/0x270
  driver_detach+0x4a/0xa0
  bus_remove_driver+0x83/0x120
  driver_unregister+0x2f/0x60
  usb_deregister+0x81/0x109
  em28xx_usb_driver_exit+0x10/0xf90 [em28xx]
  __do_sys_delete_module.isra.0+0x1c3/0x2f0
  __x64_sys_delete_module+0x12/0x20
  x64_sys_call+0x20c3/0x2390
  do_syscall_64+0x10b/0x14c0
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
  </TASK>
note: modprobe[151085] exited with irqs disabled

Happy to test a patch on this hardware.


Regards,

   Paweł Ziemniak

