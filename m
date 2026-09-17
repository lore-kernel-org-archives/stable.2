Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A9D340283
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 20:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789676380; cv=none; b=IoesJBZ588t56a6mcDr0AacwnFGpss17wMLQvAkz812ArHrlhtELYTV7WCyBKCr2roYQCDAhlRiJOj8uJTPR9b0sTJSpWvgd7uERqGpMakeO/HTV2Xk8powLPWSDx3eeObDhhyLbh7+2bby4LDufQWggrcJrrK7LYb+8plx3Q5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789676380; c=relaxed/simple;
	bh=lkBCe19wrYZR7mU0rtOnw+1CEbw1V+s4AT8qTmaXXLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QBGUQtHjqVE+jc+E32Ej/ylyzy7f69ks1hJcuRQOfrSV4rO3Od9heB1F8WGAZJfahw+bzyH1LdduT01Z+4Z65l8yVu7Vg3R2kVmjYkg312JtcIvP2CbHoplfD63pDW5bJeS/hsQaLqp+nZSjV6LZbQsnNyC9By3x3xCIdY4N/To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=emosMGdx; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="emosMGdx"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so252945e9.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 13:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1789676374; x=1790281174; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vvyw1hUxEYyKdZiT9gVegzLSKBVlWv4Z31vaRdr8Cqo=;
        b=emosMGdxErtc/9d2Kck7I2L8i4KuyCnyiz4A3Uvsutx8ECPLw4jT+X+3wWi9SE8omD
         Me1SqAY9NiQPrUYVjl16YidiW0pfl7lYYH9H/G3vjLGreMBvOvk1GdZ3dnRVb9G/ylDl
         3vXVz8rnOMX+vsMv3XxQ9J9bf450xjS7l2L3wZ6ImwsHnA6rZRsdDBaWBIuQvKifIJXB
         Y2dYNvrXFU4Cc/kFAug3ub3UhsBXul+ukv/fBBl1fGhIG7UXo0s5nvsouGby6D0qhxX5
         y1KBt+BRsLGdEzul5n3JWRISItxnCG4TbwXigce8oGePL9i0Ia1BvkNc1+Dnzpe36Cgw
         B0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789676374; x=1790281174;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vvyw1hUxEYyKdZiT9gVegzLSKBVlWv4Z31vaRdr8Cqo=;
        b=Esl0exUyf6MKKoe9GYnBFixImfynE4eYzbTX6ejvBOtvZ7tQIl7vjcAfcbLcHNE+aL
         LK/4Qr2w6UGfZhqbRNK5FSHySo+FOc4ScwJUqIy7nnfQ06zwinZ3xRBFdh9KbKwQZh8n
         BEqUnaQCTdVUGG33Iz4akgzuC5JKer8rraQhrHtvX/Wrjxt4nQuT8XDSym9pJUyUgrmg
         CIq+ifR12ICRrshMFN7GC2eBRuieKGLhwqLFAv5V2m+WVv5dPofNWDnE2pX9deYxvFOY
         smNa2vdZ4pxQSCMranzSWDBXXSO6M1OkS8kp92gHa5Rb5Lzzz4z/lJ0aLe5/ld7Q8p4r
         AJkA==
X-Gm-Message-State: AFuF++mMfAJRfLySNtFOzs+aR0hB8gbtLlllRxEmXX11KFHH4IS2s7Gt
	d+J/aO/L/e/ReCIW8SKoky2fpHsD18PtOguNPTYy57K6qYX/D7P8UFY=
X-Gm-Gg: AYBFou1BU3OgpiyrHoEeMdo78NQ/2Jiu4JC969gAm29Gh2U3xa3/tZdakMqMxTxKLi2
	aQl5GOd7zRHYY0DWBYkO0VfAqN58YxzH5Ml7f6aPQLSDu8R4w4+0GRpRWcKaiMNZdyibvB9x8Qb
	CvYZocJSsBzOLbzFluEYWAHEep2xxpSuA3//xKDs9Tpjwqdm4n+mKuYiHhjGlW1MlZIecQNQSKt
	7hzztofzqCRuQMM63pFz1ycw0HLVLjRwPBuOvmPlxMll/hWxn3PUqgLK+6+sbUS3OfDip2mPi7I
	SwfSYslmUDlBEu/y3yMIeh6ThW1WxZcd2Mtlm6XnbucAxxmua+1PTuc69XMw7iJpHXeGpSVeGDl
	4oSSCJDSpFWM75FkpuMeSvDjs7CP/rKekVGNKFMVF4GLEb8JShmBuz3wsoFOJYlMS7bjt0ccerG
	5iqDHRZ19gciHK5j99nWS8TyEO11qEk3F2zD3D+EoqpI/lYybjK7rOvF0E8VkYWl7zy2mEZkHfo
	BVjIpI/4nIy3BcEMZWxpVrpPj7MBH5aLfqfWklTikHNDRI=
X-Received: by 2002:a05:600c:6211:b0:49f:bc28:e8b1 with SMTP id 5b1f17b1804b1-49fc5735be7mr1280205e9.14.1789676374041;
        Thu, 17 Sep 2026 13:19:34 -0700 (PDT)
Received: from [192.168.1.3] (p5b057001.dip0.t-ipconnect.de. [91.5.112.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd23f4e6sm121830885e9.8.2026.09.17.13.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 13:19:33 -0700 (PDT)
Message-ID: <0dc35fd5-ee4c-4140-b154-78a49981ddb7@googlemail.com>
Date: Thu, 17 Sep 2026 22:19:33 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH 6.12 0000/1102] 6.12.111-rc1 review
Content-Language: de-DE
To: Brett A C Sheffield <bacs@librecast.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260917151539.408551884@linuxfoundation.org>
 <aqxBBu5GXVhHcqTz@auntie.librecast.net>
From: Peter Schneider <pschneider1968@googlemail.com>
In-Reply-To: <aqxBBu5GXVhHcqTz@auntie.librecast.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 17.09.2026 um 21:35 schrieb Brett A C Sheffield:
> # first 'bad' commit: [22ae428b0045981bd19f8c75f700a67198062f32] mm/hugetlb: initialize gigantic bootmem hugepage struct pages earlier

Yes, that's what I found, too.

When I revert 22ae428b0045981bd19f8c75f700a67198062f32 from rc1, the boot crash goes away and my machine boots successfully.

However, then I have another weirdo in the dmesg output:

[   65.573304] ------------[ cut here ]------------
[   65.573307] WARNING: CPU: 14 PID: 0 at kernel/sched/fair.c:5303 place_entity+0x13b/0x140
[   65.573316] Modules linked in: uas usbhid usb_storage hid isci psmouse igb crc32_pclmul libsas aacraid serio_raw 
i2c_i801 ioatdma ahci ehci_pci i2c_mux ehci_hcd i2c_algo_bit libahci i2c_smbus scsi_transport_sas lpc_ich dca wmi
[   65.573336] CPU: 14 UID: 0 PID: 0 Comm: swapper/14 Not tainted 6.12.111-rc1+ #1
[   65.573339] Hardware name: ASUSTeK COMPUTER INC. Z9PE-D16 Series/Z9PE-D16 Series, BIOS 5601 06/11/2015
[   65.573342] RIP: 0010:place_entity+0x13b/0x140
[   65.573345] Code: 41 5d 41 5e 5d 31 c0 31 d2 31 c9 31 f6 31 ff c3 cc cc cc cc be 02 00 00 00 48 c1 e9 0a 48 39 f1 48 
0f 42 ce 48 8d 34 11 eb a9 <0f> 0b eb b6 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f
[   65.573347] RSP: 0018:ffffd09188287cd8 EFLAGS: 00010046
[   65.573350] RAX: 0000000000000000 RBX: ffff8bc1cb32ce00 RCX: 00000000000003cb
[   65.573352] RDX: 0000000000000000 RSI: 00000000000003cb RDI: 00000000002d0e7f
[   65.573353] RBP: ffffd09188287cf8 R08: 0000000000000000 R09: 0000000000000000
[   65.573355] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000037e492a9
[   65.573356] R13: ffff8be13f337280 R14: 0000000000000000 R15: 0000000000000000
[   65.573357] FS:  0000000000000000(0000) GS:ffff8be13f300000(0000) knlGS:0000000000000000
[   65.573359] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   65.573361] CR2: 0000650f5b7d2118 CR3: 000000208ccca006 CR4: 00000000001706f0
[   65.573363] Call Trace:
[   65.573366]  <TASK>
[   65.573368]  reweight_entity+0x1d2/0x200
[   65.573372]  update_cfs_group+0xb4/0xf0
[   65.573374]  enqueue_task_fair+0x285/0x8f0
[   65.573377]  enqueue_task+0x3b/0x220
[   65.573383]  ttwu_do_activate+0x75/0x270
[   65.573386]  sched_ttwu_pending+0xfe/0x1e0
[   65.573389]  __flush_smp_call_function_queue+0x155/0x440
[   65.573394]  flush_smp_call_function_queue+0x37/0x80
[   65.573397]  do_idle+0x15d/0x2c0
[   65.573401]  ? complete+0x6d/0x80
[   65.573406]  cpu_startup_entry+0x29/0x30
[   65.573409]  start_secondary+0x119/0x140
[   65.573414]  common_startup_64+0x13e/0x141
[   65.573420]  </TASK>
[   65.573421] ---[ end trace 0000000000000000 ]---



Beste Grüße,
Peter Schneider

-- 
Climb the mountain not to plant your flag, but to embrace the challenge,
enjoy the air and behold the view. Climb it so you can see the world,
not so the world can see you.                    -- David McCullough Jr.

OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.asc
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@googlemail.com
https://keys.mailvelope.com/pks/lookup?op=get&search=pschneider1968@gmail.com
