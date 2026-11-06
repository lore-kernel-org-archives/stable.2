Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793941173;
	b=aBFX+FZPpQxkdoWXHxqF4aDDyAiJtnYQ7PE5Mkw0eYe6+bEw606KjrZFUu1Tp71nShpW
	 SgNLUT4OUWEIfVHwyEEesWRDAalS7UppD846rFpcBCfxdrn+ygjxo+YpwIvq/P6tb+cUe
	 GFPsiHzAmutpp456UJNRIe5mYW0ZbEkD6uj9M7hTNcWrkxwmlAGruWnY5fUjZ+T7pl4m0
	 zlNQTqOLEIdN3NML2tQrKyDFi1g3sTu5Ylun3FSKkk3oZsRuaHJP3Jn+s0/Nk825yBUhf
	 OonRkgnDwhTJsz0OsUujJYGQf5ZmuPtcX8ikQT1ID9ZjTv93HeR+7EVAmDDeWrR8gZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793941173;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=nk53h9xGi0i8b4U2D9YQl5+MCk7G9ktrexEt257Eljk=;
	b=Yx8uiqLvmdzwD3K7aRq0qQJo9Y15sQWRVUX7y+J19MnMOAbHLVbC8uozvDRoXdZhbyz1
	 dm9cSRgwvJec6yN5kd+kLpikq0pyAWUgQ2wx2UjAtYxL2AHgSz/y5/qHQQi3/TYDRv619
	 6vlO9EJ6+jqSUky4EDSfQzBdR1WCxtYGW4nAdXF5zCxl2jA8ph8HrdQhL8/MiKXH/LnrI
	 RCNJktbygsoQ/bYKuC8ltnpFR/XppA3+XRpWjIbxTKBMYK6Cgv3JXzG2A0F0bkj385xy5
	 vBWWc7A3pTWhA2hIpg4yE+8oMnEN+wXDn1X/jp1iaDFYqV83wNWfd5wxacWSx/t6CKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ESnQB5SX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649E2606A32C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 04:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 649E2606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ESnQB5SX
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4cac7a7d3cso23942066b.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 20:59:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793941172; cv=none;
        d=google.com; s=arc-20260327;
        b=eSsXwjxksQlCSfsHLHTJuqM4bj2zOJxuF3nJ15OreOasTd9iDyZ/xu8wzJrG+XuKjH
         lTexmnv57P70j/459kRFFYMZ3lwRYs+5hjKNT5D9POny4vWf6/1dGnR07YYbXMzLW/B9
         lJ9z3q/25M95lb6rRsH73Qj46mSSj/7f7HhZ+I0ijwlFGr5N741cg5A2Q9vL5PNvMU6X
         lSlLirK/j7RceRQpz7HeT0HIe0y3Ea2WZ4oYiRbEx5SeTTQsEQfXohdIV0/4jb+7YsA4
         wwD1NGtoM97vVJSHml14E3zM0bkK2O/S2xj0j1XYIa4KOnjrqbS6d5u8t4qDuC8dwD4p
         9L2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=nk53h9xGi0i8b4U2D9YQl5+MCk7G9ktrexEt257Eljk=;
        fh=sy8jaBg8s7jHR/eZQkgmnmP2wR1HIGPK3DBKB5o9wu0=;
        b=VCHthKsgyzojXwonRaCV3oLZEWwMvjfy8B/cSOXLTT0VMCupcmJyemC3MmCe7StCtF
         REugJRW2gBqUjCyOnDk2sjtGadH83EPqRVq/UmdwsKqJ/aW/JZqF4tomBjVCX4dTAuZl
         HDod5HzWxS3tQt2ZxvGU4ulynjHsX3LWIzSsXPgb+soWkpBTdk4YX2/ZXC1GjRAN6E03
         ngio9LbHAk6J7mfKMS3Jx+1z9cEJcwm3t5MWp3GcriKfW3NpVMVfPTkmNM0IFMPHD/Um
         JdujLfLHBzCwxKMUh3a+5LLka1jFV/ziDMZV4L6KqCtEKUM5ZGn8NlXx9VEeGxR//Jvw
         X7kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793941172; x=1794545972; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nk53h9xGi0i8b4U2D9YQl5+MCk7G9ktrexEt257Eljk=;
        b=ESnQB5SXngposlYGfWXteZKpzmQdpN2v3wkEdKkj7ePkswkwBH40yzRKijfjaHGfoG
         BZH5RS1JoUo3wQfDbxoqJoS1J3KrBLHk9+EpgI2sqWqWG51cvTdMckyoXb+hiKxwbQqd
         sEvUF0l9ZI/QIsqyznngu0pWX5hHCaed3T1HKNaAJMipa5uyh7IAB8y36+82bMN0DL81
         0syn1FJTN+2Xre42vGhxcIIgN4c0YSBWkxCGXWlhy84NsOma8DOz9uYsLkvoGhXJPiCt
         QHFcJ8lcLaz8VXa1fWMALzF5myV3GwSD3km8ydMpSl3FQcLUjMa0gk4g7BgWhBvUf+sI
         /f5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793941172; x=1794545972;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nk53h9xGi0i8b4U2D9YQl5+MCk7G9ktrexEt257Eljk=;
        b=Vbyc0N7WYvLmiPp7pN7YfNr0c1Rzer/UQMfiM7EIw1Sy41NUQYBfs4wtxU4FflPjT9
         +Bmc2JHCPKPbTGrM3ws57hFHbhmmO7a9JQgOnaa5nbVsBcDCkf4Ocvsb077AF0+FiMRL
         //TrbY5gwrMq2NGBNY9MC/lwEkv701vXETBmi1Us9cPd5dCpqkRA2vK0p5DLhfwogU2o
         5O3gh2pV0VGFU1b6vKWX/4TijeC42OBjlF1YSU/dcRtFCcPCAynE/kuamCIDQ8/UpLW+
         38lzq/i2GyhN4qxrV5FZcN6P5E40Lgx9rHDUfPxuxfqG+Ej1CSu9fXelX/2F6SxEgAX0
         U+rw==
X-Forwarded-Encrypted: i=1; AKwUvBxBkCCrdanL+mLx9yLMBVi9lb50XHo1WWRxl2KBCxYgtmAsXf3XDM/Se/9LBaDTMcv50fyeWnQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HO4aZFW5NHQIForOp2mcpaqv2mWbVCNYY+lyAi14jjhHo98zT
	LmQqNYMWwZFhgVuTA/bTZcHkgp+aTNWnfqSK+hWe/8Rn1z+VfmQJnMCvI+CHwJUmjY6u+u4iY33
	MSwyyYM27+nWp0lYDhuGhEPF7/DAyyos=
X-Gm-Gg: AYBFou1h5HRYDumyl05ouk/PFlpYDbpM/FifjxP3moVLbhbYgBD3+1WN81oXdR9SsGl
	6PENPAOPNjTV4P/LOdwTC4mZyIofFOPmoPp0+OsV3+akqO3j5mQc2RmJZbgOB2sjwoBPjJuObQP
	t7RP0rvMVuMMBo8oVh+V3/+S1EiWg0PhuPrIa7X2A3+Xnhzbor4ubBpJE8lMgRTnYxKHBLiRwzj
	IlPdnffrXfQlj5dxiW1bTznS9eYbgyiytCYYnfjNfTliLckyXdXzsqTax0nX+B4CSghYvXvYI12
	V2vfdd/+/lltc8rGnALzZ7UOHH0W/18paaHamy/U0l/ZcT+vdjKvmsz82K9VtNC3O44hfi2dRxy
	33nZr9OeLHNET2OYMpBjq7FhyaEdlXaSGx0Fjnw==
X-Received: by 2002:a17:907:d03:b0:c41:1e13:8891 with SMTP id
 a640c23a62f3a-c4d34a64653mr110110366b.9.1793941171526; Thu, 05 Nov 2026
 20:59:31 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Shantanu Sarkar <shantanu.connect58@gmail.com>
Date: Fri, 6 Nov 2026 10:29:14 +0530
X-Gm-Features: AclHuK_6yVfvd4MvFxvFI_KwNC62wXAmnA8mSmYy2zvtvvaMyEA2xYUb-GFYXG0
Message-ID: <CAK8Z4SCRhWcbL5i6NgwiLWDCX48YbMfcJ_+nFrGxKMZiN1vG3w@mail.gmail.com>
Subject: [REGRESSION] media: em28xx: list_del corruption on dual-TS disconnect
To: "Jiangong.Han" <jiangong.han@windriver.com>, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Commit 826915b6b65e ("media: em28xx: fix use-after-free of
dev_next->devlist on disconnect"), merged for v7.3 and backported to
stable, makes em28xx_close_extension() unconditionally do

if (dev->dev_next)
list_del(&dev->dev_next->devlist);

On a dual-TS board whose secondary device is not audio-only (the
normal DVB case), dev_next->devlist was never added to em28xx_devlist.
em28xx_duplicate_dev() kmemdup()s the zero-allocated primary in
em28xx_usb_probe() before request_modules() links the primary, so
dev_next->devlist is {NULL, NULL}, and the list_del() on disconnect
crashes. On current mainline (7.4.0-rc1, 05441d697f7f), with
CONFIG_DEBUG_LIST=y:

  em28xx 5-1:0.244: Closing input extension
  list_del corruption, ffff88810de88250->next is NULL
  ------------[ cut here ]------------
  kernel BUG at lib/list_debug.c:53!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  CPU: 1 UID: 0 PID: 32 Comm: kworker/1:1 Not tainted 7.4.0-rc1 #1 PREEMPT(full)
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009)
  Workqueue: usb_hub_wq hub_event
  Call Trace:
   em28xx_close_extension+0x15a/0x390
   em28xx_usb_disconnect+0x16b/0x2f0
   usb_unbind_interface+0x295/0x9c0
   device_release_driver_internal+0x48d/0x7d0
   bus_remove_device+0x444/0x560
   device_del+0x523/0x8f0
   usb_disable_device+0x3d4/0x8d0
   usb_disconnect+0x346/0x9a0
   hub_event+0x1bd6/0x4d10

Reproducer: syzbot's C reproducer for the bug the commit fixes
(https://syzkaller.appspot.com/bug?extid=99d6c66dbbc484f50e1c), with
one byte changed so the emulated 2040:026d device (WinTV-dualHD
01595) exposes a DVB isoc endpoint 0x84 instead of the audio endpoint
0x83, i.e. in the memcpy of the extra endpoint descriptor:

-"\x83\x99\x35\x19\x1f"
+"\x84\x99\x35\x19\x1f"

Results in QEMU (x86_64, syzbot's upstream config, 5 min per boot):
  - tree at 826915b6b65e^ (before the commit):  no crash (3 of 3 boots)
  - same tree with 826915b6b65e applied:         crash above (3 of 3)
  - mainline 05441d697f7f (7.4.0-rc1):           crash above (2 of 2)
The unmodified syzbot reproducer (audio-only secondary) is fixed by
the commit, as intended. I have not tested real hardware or the stable
backports (6.12.y, 6.18.y, 7.2.y, 7.3.y carry the same change).

How this was found: we were testing AI coding agents on old syzbot
bugs, and an AI-assisted review of the candidate patches flagged this
path; I then confirmed it with the reproducer above. No AI-written
patch is included.

#regzbot introduced: 826915b6b65e

Thanks,
Shantanu
