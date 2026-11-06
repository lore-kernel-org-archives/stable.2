Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979594;
	b=l3DjC6kQZssuehf2cLT+a5CqmCqFY10Pc9Po+40F7kEE1IF771iQX5PC4u63c8XUSAa0
	 yp6OOy+Ikw+qSYq7AoxT/NA5l4rwr5g9MhLhXxdvA/mfTdN3kC7s9BZiMeZK1I3Br2RRy
	 ApCfJVzqfz4wzTlJZ1qCc1zsKjLP19tRMZGHP0QUer0uQTpCUBXPi6YtRrdtek3HvNqkd
	 nnlOobtTgS9gVjIR+bH4KfFhphDYLvmY8hxp6g6Mp/WOn+vJo2v/98huA8g4v7HGV/IKH
	 xdbNEvLCt2gFf5zD02ZD29cZwQkALP5JwHAr6dEW+K/TFNfScbj6zyVD1jUtl4Qg/9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979594;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=72dhPHd4WBhPIQghSIWyyc2JN2E4/ifchxxNZweNup8=;
	b=g+FWobH2SDiqxWuUwbMgNrMZnvwSS60Y6ePDaCqSS9LdYRUwZj/WZ5AtUlKtiaKtTefA
	 UjMgeZrVDQX1xAr9mRpm20Ke0UVn3EaFLYKDA6gtRK7Xe0l0dIVAVtuKp2T9tIlr5Rrih
	 iD9GADtJenwnRWrubAc6mTKtjBXyRMsgWZEeJi1wQvMy6x1m17krqMD4/H7oxpa3n7ALm
	 esdv5g+PsdCZ0Ci3BG6vqNiIMrtHz4Tbx21jl2iRII66vtIHa527FCI0aQmQWmWlE2uAg
	 OMpnjbrvYthIrkCjlBvCogcT3nDohjyd5cV7RvspTbOGYQTKfQ9SXg8lzTpjACt/bsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foxmail.com;
	spf=pass smtp.mailfrom=foxmail.com;
	dkim=pass header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=IPWinYrl;
	arc=none smtp.remote-ip=162.62.57.137
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA554606A326;
	Fri,  6 Nov 2026 15:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA554606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=IPWinYrl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1793979586;
	bh=72dhPHd4WBhPIQghSIWyyc2JN2E4/ifchxxNZweNup8=;
	h=From:To:Cc:Subject:Date;
	b=IPWinYrlfsip2SQCRzp7kMuxsy/SA1Ufj6+L2RWgri0R1G0ZiJrxvXkMjgf/vzReD
	 k0K2D4vkbZWerAXVPnCje3wJo2xlTup8+3hkitBknne7Xg467EhX09gYPOqh4DMkSB
	 XRvlpKZmnaYWs0ScR9SDAOJAKD+m78Xgsy631h+c=
Received: from KernelDevBox.byted.org ([240e:83:200::a6])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 9EA9A806; Fri, 06 Nov 2026 23:39:42 +0800
X-QQ-mid: xmsmtpt1793979582tv4o5erxa
Message-ID: <tencent_C156772B062CD403424112354682F1E6B805@qq.com>
X-QQ-XMAILINFO: NHTNowOA4hJd7B15tE22RqWdK0w43iQEgOXuLtQP1vQrMao0FsnDgqKzSA5A1h
	 MelHTD29NBjddhm6NgMjKa9Uq1efYOe3SSgIvvrQ3U0ekaiI15PduQMe0VKjH9dPdEuN3XyvP5Y1
	 ZtS0bCHi6t5zI5i76z/KYrukLKcCic/C1MLzdMilHvzeoEv41qOnzULzZygbvEg556V/5GdhVBCJ
	 EvosULC9w8/CArdv+L+XKXkSG0yTxVifhyHDL4Kp90FlARVC0KhuHcdCqhGJR45KmFeqmjALkfYz
	 P1/f5JhZZxM7R1qPF+GosFCfyorOfDPSdoTHSLlcomsvZ+VQeNq/BZZGige94OFSd1hNBGbjwdpy
	 srI16ZpYlY0sTDvCfbF42KlH36bbf6YsUzTAaVn2olPqpa/iKLrBo7+7elYPIbyI0UmVN2P5uNn9
	 RASjRJ5V8bdYelJeDLNt2psbYPr1Ek5qOFmwDmfGZ844VmOlwueOAaUMybvT4Om02SBq2MAgJ2GA
	 cLZFEvU9BZkQ9xAmhaSVPFcBtWdGunFlj+uhDSn69G/1LJq+nsH3kFvtcFUAk5OdAN+lFzMQJxwk
	 MNQ42SJe7EwlsrOpiiZXsA2pJL3Edb/Qc8KxbbDp+n+PiEDyy7aKh3PYZjiR+iOXnL4i1dZy+/GR
	 /KaYh3/2WoHHlAYKXqQjnXNJYGcd17i0T9r9TfkaA8RHdPIH2ItWgcxepXOvXkwHbWTbAB/nFSSX
	 /9PBBIvzmHK//nYDLOtaYLOoPvWym7U1oP3Wjves9A6JwyyOyf1z41F7cgbk4hLhRPT1pfLCb85b
	 CLjDaNqgMiaSUMMmHl6kd0FKsfJju3pWwjPQTV+TMUv0bGCxZzhtaHFpuOgpoSDR6P2hlISQhSaq
	 taIRUXlTJn4ju7/SLycxTxOmwF9d9Jkafrd4mhgm3mv+LsYYwar/qrg0ueyV9xQ0PueTiy7DPpex
	 tw5vk5q/oflyH9yYCmlhAdLldZS1pF12Eth/iOVD/62n7UuJ/Ie4SxrTOfdX9vKy308TYDlgfKwG
	 cA0ZKhOEzIhe1myl9hIZjnVxFvy/+a2CV4QqwL3R/H2hSAAVZps3K2XsA3Pdr2o3B4gcIHxORX84
	 IjX3tOXnUMU9W9n4E=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Zhang Shurong <zhang_shurong@foxmail.com>
To: dmitry.torokhov@gmail.com
Cc: sanjay.govind9@gmail.com,
	krisfur@proton.me,
	byt.es@mailbox.org,
	zoliviragh@gmail.com,
	francesco.orlando99@libero.it,
	wiagn233@outlook.com,
	roberts.kursitis@azeron.eu,
	contact@zharov.dev,
	elliotctester@gmail.com,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Shurong <zhang_shurong@foxmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] Input: xpad - fix use-after-free in probe error path
Date: Fri,  6 Nov 2026 23:39:38 +0800
X-OQ-MSGID: <20261106153938.1947025-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.39.5
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xpad_probe() creates the input device asynchronously for wireless
(XTYPE_XBOX360W) controllers: xpad360w_start_input() submits the interrupt
URB, and its completion handler queues xpad->work, which calls
xpad_init_input() and registers the input device. It then submits a
presence packet on the output URB; if that submission fails,
xpad360w_start_input() returns an error after the interrupt URB has
already been submitted and may have completed. The err_deinit_output
label then only tears down the output URBs and frees the xpad structure.
It never cancels the pending work nor unregisters an input device that the
work may already have created.

Consequently, after kfree(xpad) the input device can remain registered and
input_dev->phys still points into the freed xpad->phys[64] array. A
userspace EVIOCGPHYS ioctl on the corresponding event node then reads the
dangling pointer:

  BUG: KASAN: slab-use-after-free in strlen
  Read of size 1 at ...
  Call Trace:
   strlen
   str_to_user
   evdev_do_ioctl
   evdev_ioctl
   __x64_sys_ioctl

The same window also allows the queued work or the output URB callbacks to
run after xpad has been freed, which can instead report a use-after-free in
xpad_init_input() or xpad_prepare_next_out_packet().

Make the error path mirror xpad_disconnect(): stop the wireless input URB
(which also flushes the queued work), unregister the input device if it was
created, stop the output URB, release the output resources, and clear the
interface data before freeing the xpad structure.

This use-after-free has been reproduced and the fix has been verified on a
KASAN-enabled kernel. The original syzbot report's allocation and free
stacks show the address later reused by tmpfs; the xpad owner was
established by local reproduction.

Fixes: 09c8b00ae3e1 ("Input: xpad - handle "present" and "gone" correctly")
Link: https://syzkaller.appspot.com/bug?id=04f471e8f027835f49842bbc7694e723d2289d7d
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/input/joystick/xpad.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 53fd3b562f41..3951b4b05740 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -2224,7 +2224,12 @@ static int xpad_probe(struct usb_interface *intf, const struct usb_device_id *id
 	return 0;
 
 err_deinit_output:
+	if (xpad->xtype == XTYPE_XBOX360W)
+		xpad360w_stop_input(xpad);
+	xpad_deinit_input(xpad);
+	xpad_stop_output(xpad);
 	xpad_deinit_output(xpad);
+	usb_set_intfdata(intf, NULL);
 err_free_in_urb:
 	usb_free_urb(xpad->irq_in);
 err_free_idata:
-- 
2.39.5

