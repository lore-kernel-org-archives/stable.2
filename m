Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793826182;
	b=WDs+4vd/f6SzntAWUqw/xjHc1v40OWZUpHknzWSEQzIyjEnFv4uJP/cYEVRFgRguN8L1
	 iuCxBaTz7OtUDkkB+AcqJKqQWv3BFkG+SzcXZxfeeO+DbDwtGSfSyb1+GiGF7xK2ueqQY
	 Rf+XqjfjYHDfLbTm0/+OlYQNtvk5zdxlvKhuiB/vdRXRNJsGiP1uvibIyaYDQat2p6Tfh
	 tTtWlq9Ie/AWsIK9vCr/UCMW6JjfZtQjioLtXVSrzPhjL+OK/eLMO75qXur3KOIa2I2Dy
	 IojydYDdZWDLwIuLAvgtEmcZA4TE9ShX/bmflyAS3LexG1OFVuvqhAW/IgJgdIPLLZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793826182;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lxjwYeMZZmbD2QPsM83M/jtb8Csa4HQuEoxr2o/RPk8=;
	b=EBsS0xPkR3P8k5iIdYmcPT/IdEm3zhp0UVCw/otNeyse4B6VmirQ4No0vw5OL3h2gpGn
	 IQV8AW2DZvteuopbHwoZvO0bOvZRXhkCaZyPybPSdlphqKNj/4y2eBrSLY2nI3wLEeLGr
	 AoUGEXULlXDjSWDsasrtLaZRqvvrd/fLLyIz1Zs9gFjPYwTvrw2kDEx8sk0M02D4i1KKI
	 m2y8VNqRP7EOU5RN0QL/Pgojc71F85sX5eTV0RZNSM9i2fLWoMb9fSBwPqpVrKFN6lH4a
	 zWw+vgGDc/vLaMXApO7hBThOkh3fWsSiOb5pzjnX6+9I0af+PkxbIIpQsLe0p+yZJAA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cj1c23zQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C04C606D4DF;
	Wed,  4 Nov 2026 21:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cj1c23zQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793826182;
	b=o3iDM3ikeauvXsMbRVu6HmlMCtI2ea0WY+z+ddYDEJt+JkuIOKAcWlHMX8ujhrJDJx7y
	 GheB1P2krmtS73aJOSL/M4olTQzAX08kKJnoTq+ikDe1mpE9opPtA3oActDGZVwm9KRX1
	 aIzwLeZPfOXfFxjEHgYllN4Pyhy5qKHouOkurKtBCYXgwk29T7aRaYQ/vRft5ZNpjArOF
	 S2BeCyCyCKSzxj3lIxUvqg/gW8LDzPu5Rfg2+tlKbwebQb55kL/fAPLZzdscEYG7CGPUR
	 s6LbI8A0VATnXzeJctJ25KeR85EByPXoq6Njn1/mYFq0eHEHu4lv1BYcBT5QutApzew==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793826182;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=lxjwYeMZZmbD2QPsM83M/jtb8Csa4HQuEoxr2o/RPk8=;
	b=x6U1Ww5ZkQTdTHnIVmqwxaNXzhdES1y+uF5ZsHFcqxn+Rpgm7J6cbNDOi1Nkk3/ypBcY
	 d00MLHj9fVHLWEV8od5vq3jgRjd5wb+WIsufp1sGOqJ5qXeN2q1J+KUAXZm64GZBFHrSX
	 Q4RbVGQZz0+nKS+8iplYdnAPKpQKBmaBfvuTwXqXHVxrScd8zxKEdDiVgrB3sB60nXbmx
	 KyMTyJv4w1W4Zekda9eO3otkZPTz4BB74sAfjKscLGuuRN8EC5x+3Ei59MLswHEuc1r+z
	 wo32nvRBJEpa6Pw4qq/yOUfbEr1McwQZUeA2doUg1S9+6Ed31ap5UMnASjTvLlxAEqA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 85EBE1F0093A;
	Wed,  4 Nov 2026 21:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793826182;
	bh=lxjwYeMZZmbD2QPsM83M/jtb8Csa4HQuEoxr2o/RPk8=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Cj1c23zQnK2yuu/V4c/a91FDwHq14tMijCBIjiO8ZyL9q+fqaIge/wgvhOsgiRjTD
	 35dqeRKYYM7/ZFhuKxKkern9tS4ip6P4oP5ZLS9gzYo+TDuBvs6WA3sZUvgfBuxRx4
	 E9tKWsrrc13Zpg7QEXnN+Fqxz9zLoxi+LXfTgOSjEE7zwk8hXEBIn4yWjNAAh0Y2AU
	 Au/V+W8E8M0+rNw79KtIv3sxtVOfdeKaPzbMYYQb64tj4N43dGQRkjVWP+b/V+hswy
	 G9qXoJt3OPlEbr8zOnUsbRnIKPk7QTY2c6wWNxPBB/OtI3qt5HKSzTX46VQOwtGHnx
	 VlW2GZsGXe6Yg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DB06146F91;
	Wed,  4 Nov 2026 21:03:00 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Wed, 04 Nov 2026 21:03:01 +0000
Subject: [PATCH] media: rc: redrat3: fix use-after-free of input device
 name/phys strings
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261104-redrat3-input-uaf-v1-1-b882e43d9803@gmail.com>
X-B4-Tracking: v=1; b=H4sIAISd62oC/x3MPQqAMAxA4atIZgOtlfpzFXGoNmqWKqmKIL27x
 fEb3nshkjBF6IsXhG6OvIcMXRYwby6shOyzoVKV1VrVKOTFnQY5HNeJl1twst40bUfWzB3k7hB
 a+Pmfw5jSB8kKYj1jAAAA
To: Sean Young <sean@mess.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 syzbot+aec1962419768c5caf88@syzkaller.appspotmail.com, 
 Joas Antonio dos Santos <joasantonio108@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793826180; l=3240;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=c68HohiFSurQ192KfXE2Kl4zIbGHGZyY1chc3A+cUM8=;
 b=ILJCTmi2LPNHZiDhY7hZLunAi84A/UWCfPjunPtMwwTdAoHe90uITNQ1TaMibVa9A+Mm4AS8A
 AhGIDO/2g90AiLeApxlWYYeWMLde/tj808aR2QUoaXzpVg9dvNpcH6k
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com
Content-Transfer-Encoding: 7bit

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

redrat3_init_rc_dev() sets rc->device_name and rc->input_phys to point
at the name[] and phys[] arrays embedded in struct redrat3_dev.
rc_prepare_rx_device() then copies these pointers into input_dev->name
and input_dev->phys without duplicating the strings.

When redrat3_dev_disconnect() runs, it calls redrat3_delete() which
kfrees the redrat3_dev struct, freeing the embedded name and phys
arrays.  If an evdev client still holds the input device open, a
subsequent EVIOCGNAME or EVIOCGPHYS ioctl calls str_to_user() which
reads the freed string via strlen(), triggering a KASAN
slab-use-after-free on the freed kmalloc-2k object.

Fix by allocating the name and phys strings with devm_kasprintf() and
devm_kzalloc() respectively, tied to the USB interface device lifetime.
This ensures the strings outlive the input device, since the USB
interface device (and its devres) is not released until all references
to it are dropped.

Found by LLM-assisted code review of syzbot-reported crash patterns.

Reported-by: syzbot+aec1962419768c5caf88@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=aec1962419768c5caf88
Fixes: 2154be651bfd ("[media] redrat3: new driver")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
redrat3_init_rc_dev() stores pointers to the name[] and phys[] arrays
embedded in struct redrat3_dev into rc->device_name and rc->input_phys.
These are copied into input_dev->name/phys without duplication.

When the device disconnects, kfree(rr3) frees the strings while evdev
may still hold the input device open.  A subsequent EVIOCGNAME ioctl
dereferences the freed string via str_to_user() -> strlen(), triggering
a KASAN slab-use-after-free.

syzbot link: https://syzkaller.appspot.com/bug?extid=aec1962419768c5caf88
---
 drivers/media/rc/redrat3.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/media/rc/redrat3.c b/drivers/media/rc/redrat3.c
index 3e82b5e66..d9e37ede2 100644
--- a/drivers/media/rc/redrat3.c
+++ b/drivers/media/rc/redrat3.c
@@ -229,8 +229,8 @@ struct redrat3_dev {
 
 	u32 carrier;
 
-	char name[64];
-	char phys[64];
+	char *name;
+	char *phys;
 };
 
 static void redrat3_dump_fw_error(struct redrat3_dev *rr3, int code)
@@ -943,11 +943,16 @@ static struct rc_dev *redrat3_init_rc_dev(struct redrat3_dev *rr3)
 	if (!rc)
 		return NULL;
 
-	snprintf(rr3->name, sizeof(rr3->name),
-		 "RedRat3%s Infrared Remote Transceiver",
-		 prod == USB_RR3IIUSB_PRODUCT_ID ? "-II" : "");
+	rr3->name = devm_kasprintf(rr3->dev, GFP_KERNEL,
+				   "RedRat3%s Infrared Remote Transceiver",
+				   prod == USB_RR3IIUSB_PRODUCT_ID ? "-II" : "");
+	if (!rr3->name)
+		goto out;
 
-	usb_make_path(rr3->udev, rr3->phys, sizeof(rr3->phys));
+	rr3->phys = devm_kzalloc(rr3->dev, 64, GFP_KERNEL);
+	if (!rr3->phys)
+		goto out;
+	usb_make_path(rr3->udev, rr3->phys, 64);
 
 	rc->device_name = rr3->name;
 	rc->input_phys = rr3->phys;

---
base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
change-id: 20261104-redrat3-input-uaf-b6d3789e63c9

Best regards,
-- 
Joas Antonio dos Santos <joasantonio108@gmail.com>


