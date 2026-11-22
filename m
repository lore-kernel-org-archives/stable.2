Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795339334;
	b=2oqTVB6RbLZTAMZ8PQz/nYRwGkwlQVJuMeviRZfkAz77w1EmUetmklCT1/coFF0/GML6
	 ZY2rS31E3r8t/iP0/sT2+gijYKE2zXFl82IW5wlOl6x2kiJJHedGEf/6/Bj1QJsrIigMh
	 te2ai2BIcRoOLGaul+U4WKkMB/Z/+VUDHehaVWxO173uijbiSM8c7xIjmPHyf5vsBbml1
	 lizIA04tl8LCI9Jx23c9Qr0dplbB02pX9G0tkn3Ljf2e4bWt8kmUyY1CGxYSnqcd2KxMy
	 x8ucsAYD6YXZELK19eYbfZxAqt+RC/VnLfXotJwE1HXLgS9e3pRflbrKZ/+VwBAIyQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795339334;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=gOkWR6H5HKpidkAAlJBE2KrMxAp78SnPQgYFiW8dD9k=;
	b=EZqj3FEIW0tsBBcc+EnZ/5EeNXCU/5uQUwSdWbvOJ9Uqy+R+8Gz908R2Ud9Gqr9UIfKk
	 SL00HbY/A3/7tJb5rbGXW9f0TxzGlSr/aa39qFJ7P8i4uUcNVLt/Z0G//1xSCk6bfNf2I
	 lCSIwYqYC/J3W6e2wc0SYMfPlYNh+yUpJQCXnKbl+8DjYolSHF/5VBXOvdtob2quOjtCu
	 CI87TPIirkky8FAK6H2LgkZ9gah0w6sNk2Tt/Em+jex1knD3fsP3xPc0gtDqy6OfMr0+4
	 gLqeiWnXfc/ofZRzCpGOIkjayoAPEp4raOKuN8IAuzxLZ0eMzigm0LOjIGhiad6H/xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA6F606A320;
	Sun, 22 Nov 2026 09:22:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDA6F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=gOkWR6H5HKpidkAAlJBE2KrMxAp78SnPQg
	YFiW8dD9k=; b=gaJ6sms7dR4j5XW0mj8jW1UcmoIE/4QUtyWKfLH74PoTqkDXFX
	CvJjg3s/9Rs1lPMzYTUNhKxagsvgXwV+NWylp5w9Q6hVU074sUkbNdq89rPS4jEu
	Wm0f6WgnNJUX4qYAQE8BFj2xpDh+YfakGjO9y/VssA2SZBAMezyX2Ud78=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.70])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkA2PP8ztAJrzxsOAg--.17246S2;
	Sun, 22 Nov 2026 17:21:56 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Sean Young <sean@mess.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	=?UTF-8?q?David=20H=C3=A4rdeman?= <david@hardeman.nu>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v3] media: rc: fix use-after-free of rc_map.name on register error path
Date: Sun, 22 Nov 2026 17:21:55 +0800
Message-Id: <20261122092155.11550-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <awIShD1k89rEsIc5@extorris.mess.org>
References: <20261027014144.9144-1-25031212351@stu.xidian.edu.cn>
 <20261027021718.14264-1-25031212351@stu.xidian.edu.cn>
 <20261030.pref-04.ec83d43911ee476d@stu.xidian.edu.cn>
 <auRsPM9YO4aXd8qL@extorris.mess.org>
 <20261030130535.2921-1-25031212351@stu.xidian.edu.cn>
 <awIShD1k89rEsIc5@extorris.mess.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:BbQMCkA2PP8ztAJrzxsOAg--.17246S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKrWDKw4rKF13Xr4DKF17Jrb_yoW7ZF4fpa
	98Gas8trWDKr4UXwsxXw47Xa45ur4xJws8Zry8G34j9398CryftFWUJFyUWa4UJFyxCFWU
	tr98X3y8uFWUCFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5p5l7UUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUFD2sBs9hVeAABsj

If rc_register_device() fails after device_add() - for example when=0D
ir_raw_event_register() cannot create its kthread - the unwind path=0D
frees the keymap via rc_free_rx_device() while the device is still=0D
visible in sysfs, and never clears dev->registered.=0D
=0D
A userspace reader of the uevent attribute then enters=0D
rc_dev_uevent(), passes the registered check under dev->lock and=0D
dereferences the already freed dev->rc_map.name:=0D
=0D
  BUG: KASAN: slab-use-after-free in string+0x483/0x4c0=0D
  lib/vsprintf.c:737=0D
  Read of size 1 at addr ffff888007ca9d80=0D
   rc_dev_uevent+0xd7/0x1d0 drivers/media/rc/rc-main.c:1628=0D
   dev_uevent+0x28d/0x570 drivers/base/core.c:2709=0D
   uevent_show+0x1af/0x380 drivers/base/core.c:2756=0D
=0D
Clearing dev->registered before the teardown would make=0D
rc_dev_uevent() return -ENODEV, which makes dev_uevent() fail and=0D
suppresses the KOBJ_REMOVE uevent of device_del() altogether.  The=0D
device has already been announced with KOBJ_ADD, so the remove event=0D
has to be delivered as well, and it needs the keymap and the driver=0D
strings.=0D
=0D
Instead, keep the keymap alive until device_del() has been called:=0D
only unregister the input device at the out_rx label, since it is a=0D
child of dev->dev, and let out_rx_free free the keymap afterwards, as=0D
it already does for the other error paths.  device_del() drains the=0D
sysfs readers, so rc_dev_uevent() cannot run once it has returned and=0D
the keymap can be freed there.=0D
=0D
The registered flag still has to be cleared so that lirc file=0D
descriptors which are still open cannot reach the driver callbacks,=0D
but that now happens after the remove uevent has been sent; this also=0D
covers the lirc_register() and rc_setup_rx_device() failures.  Factor=0D
the lock/close/clear sequence into set_unregistered() and share it=0D
with rc_unregister_device().=0D
=0D
Fixes: f56928abaa6d ("[media] rc-core: cleanup rc_register_device")=0D
Cc: stable@vger.kernel.org=0D
Co-developed-by: Bin Yu <byu@xidian.edu.cn>=0D
Signed-off-by: Bin Yu <byu@xidian.edu.cn>=0D
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>=0D
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>=0D
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>=0D
---=0D
=0D
Hi Sean,=0D
=0D
thanks for the review.  I have dropped the comment and renamed the helper=0D
to set_unregistered().=0D
=0D
One correction on the lirc_register() error path: it goes to out_dev, not=0D
out_lirc, so neither lirc nor the input device is registered when it is=0D
taken, and the keymap is already freed after device_del() there.  With=0D
this version the flag is cleared after device_del() on every error path,=0D
so that path is covered as well.=0D
=0D
That also answers the point you made earlier about the remove uevent: a=0D
cleared dev->registered makes rc_dev_uevent() return -ENODEV, dev_uevent()=
=0D
fails and kobject_uevent_env() drops the event, so the KOBJ_REMOVE is=0D
never delivered.  Instead of clearing before the teardown, the keymap now=0D
stays alive until device_del() has sent the uevent, and the flag is=0D
cleared afterwards - device_del() has drained the sysfs readers by then,=0D
so rc_dev_uevent() cannot run any more.=0D
=0D
The patch below is against v7.2.10; I can rebase it on your series in the=0D
media tree if you prefer.=0D
=0D
v3:=0D
 - Keep the keymap until device_del() has sent the remove uevent instead=0D
   of clearing dev->registered before freeing it, so that the KOBJ_REMOVE=0D
   event is not suppressed.=0D
 - Clear dev->registered after device_del() on the register error paths,=0D
   which also covers the lirc_register() and rc_setup_rx_device()=0D
   failures.=0D
 - Rename the helper to set_unregistered() and drop the explanatory=0D
   comment (Sean Young).=0D
=0D
v2:=0D
 - Clear dev->registered on the rc_setup_rx_device() error path too;=0D
   lirc is already registered there and open file descriptors can=0D
   still reach driver callbacks.=0D
 - Factor the lock/close/clear sequence into rc_unregister_device_state()=0D
   and share it with rc_unregister_device().=0D
---=0D
 drivers/media/rc/rc-main.c | 26 ++++++++++++++++++++------=0D
 1 file changed, 20 insertions(+), 6 deletions(-)=0D
=0D
diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c=0D
index dda3479ea3ad..ff3149415e45 100644=0D
--- a/drivers/media/rc/rc-main.c=0D
+++ b/drivers/media/rc/rc-main.c=0D
@@ -1888,6 +1888,15 @@ static void rc_free_rx_device(struct rc_dev *dev)=0D
 	ir_free_table(&dev->rc_map);=0D
 }=0D
 =0D
+static void set_unregistered(struct rc_dev *dev)=0D
+{=0D
+	mutex_lock(&dev->lock);=0D
+	if (dev->users && dev->close)=0D
+		dev->close(dev);=0D
+	dev->registered =3D false;=0D
+	mutex_unlock(&dev->lock);=0D
+}=0D
+=0D
 int rc_register_device(struct rc_dev *dev)=0D
 {=0D
 	const char *path;=0D
@@ -1970,12 +1979,21 @@ int rc_register_device(struct rc_dev *dev)=0D
 	return 0;=0D
 =0D
 out_rx:=0D
-	rc_free_rx_device(dev);=0D
+	/*=0D
+	 * The input device has to be unregistered before its parent goes=0D
+	 * away, but the keymap is still needed by the uevent attribute=0D
+	 * until device_del() has been called.=0D
+	 */=0D
+	if (dev->input_dev) {=0D
+		input_unregister_device(dev->input_dev);=0D
+		dev->input_dev =3D NULL;=0D
+	}=0D
 out_lirc:=0D
 	if (dev->allowed_protocols !=3D RC_PROTO_BIT_CEC)=0D
 		lirc_unregister(dev);=0D
 out_dev:=0D
 	device_del(&dev->dev);=0D
+	set_unregistered(dev);=0D
 out_rx_free:=0D
 	ir_free_table(&dev->rc_map);=0D
 out_raw:=0D
@@ -2024,11 +2042,7 @@ void rc_unregister_device(struct rc_dev *dev)=0D
 	timer_delete_sync(&dev->timer_keyup);=0D
 	timer_delete_sync(&dev->timer_repeat);=0D
 =0D
-	mutex_lock(&dev->lock);=0D
-	if (dev->users && dev->close)=0D
-		dev->close(dev);=0D
-	dev->registered =3D false;=0D
-	mutex_unlock(&dev->lock);=0D
+	set_unregistered(dev);=0D
 =0D
 	rc_free_rx_device(dev);=0D
 =0D
-- =0D
2.34.1=0D
=0D

