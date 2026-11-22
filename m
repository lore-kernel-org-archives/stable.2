Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795344750;
	b=wGlaaXb1fADcKMHL6W/pfGapFki99jNg273tPO/Rjny2XkuNaW9SBtoCCsAIniWc39v6
	 lESiZbF83LdOrazporF61jgfIJ12hsnvuGIyYBFojv1GT567I3g6kwaZagF3S8USFFaES
	 Yccf27hDzbqDyGKow8wxpT1r6Ywic+WLXzklUrUaQu/eR4k5o3pCwVvdNhstyWQOh/5vi
	 Tpz+7WqmLSEaaKxyxJo+4e9DffcSIIUinCF8+Xs9FqHQAFEc9sli3q376AujvxVDJDwMA
	 f8NNSAoLxqB7Dh8A6D/1Nnlmxg5ReB4Zoe0w37k9ky0Natb0PT0vmLe3pp1V/EvtMRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795344750;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=UAqUUG+uJGPdeDnCBEIvoKUTIOnssMLWS4UgPSuy47Q=;
	b=DmkSzFvfyZ4cpgsfXOdPpZLSCR4hd8xIHcN1JJjnZvsqkNzRONXEWSYz64Azp3tRYo+e
	 M4X9oCR2zneKKFetdoGWVHsmnjRzlsFUzioL46ePGyX88NHbvGL4fJFmjIUWu7eNo65eh
	 hJ7TxB7kAyEGq91La2s1dkktTbQ97kRgKDloxEGlHQE9UBKvSGJyBU4L+sH7dTyt3xVmx
	 ueQfuFpPtk1caC0cYnDm2FoKpvJ2Qirg+uBl4DROrG1n+bl2aixzQsUwzyezGwVMK0eEn
	 gRxsq9FVmiQ80MTOhjV5JKv+71tcFophIrY5QE2bb3sqNEnu7q6QroW3X7CFU1guq9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6A9606A32A;
	Sun, 22 Nov 2026 10:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC6A9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=UAqUUG+uJGPdeDnCBEIvoKUTIOnssMLWS4
	UgPSuy47Q=; b=FW6C89H526SNi/DA58Fz5h5PVjnoKEgr8PiA4Hp2KyUSu04pk3
	4bgGXNLoE/JPeU5xRFkEBEs9acKN6xytlTWDy4czgj2oCD6uyCwlHcf0LLdaHqCI
	s+TflVy6w2KQ9tG5lXM984ErqDt+4SEbP6cKn+QyOuNKnEMKVn2k8WAg0=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.70])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkAGRfpeyQJru3oPAg--.38485S2;
	Sun, 22 Nov 2026 18:52:15 +0800 (CST)
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
Subject: [PATCH v4] media: rc: fix use-after-free of rc_map.name on register error path
Date: Sun, 22 Nov 2026 18:52:13 +0800
Message-Id: <20261122105213.10146-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261122092155.11550-1-25031212351@stu.xidian.edu.cn>
References: <20261027014144.9144-1-25031212351@stu.xidian.edu.cn>
 <20261027021718.14264-1-25031212351@stu.xidian.edu.cn>
 <20261030.pref-04.ec83d43911ee476d@stu.xidian.edu.cn>
 <auRsPM9YO4aXd8qL@extorris.mess.org>
 <20261030130535.2921-1-25031212351@stu.xidian.edu.cn>
 <awIShD1k89rEsIc5@extorris.mess.org>
 <20261122092155.11550-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkAGRfpeyQJru3oPAg--.38485S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr15Ary5ZFWDtF1xJFy8Grg_yoWrWr47pa
	98KFW5t3yDKF4jqws8XF47Wa45uw4fAan8ury8J3yjgw45uryftFW5JFyUWa4DAr97CFy7
	tF98J3y8CrWUCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r
	15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4DMxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8-tx3UUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUFD2sBtklaRwAAsF

If rc_register_device() fails after device_add() - for example when=0D
ir_raw_event_register() cannot create its kthread - the unwind path=0D
frees the keymap via rc_free_rx_device() while the device is still=0D
visible in sysfs.=0D
=0D
A userspace reader of the uevent attribute then enters rc_dev_uevent(),=0D
passes the registered check under dev->lock and dereferences the already=0D
freed dev->rc_map.name:=0D
=0D
  BUG: KASAN: slab-use-after-free in string+0x483/0x4c0=0D
  lib/vsprintf.c:737=0D
  Read of size 1 at addr ffff888007ca9d80=0D
   rc_dev_uevent+0xd7/0x1d0 drivers/media/rc/rc-main.c:1628=0D
   dev_uevent+0x28d/0x570 drivers/base/core.c:2709=0D
   uevent_show+0x1af/0x380 drivers/base/core.c:2756=0D
=0D
Clearing dev->registered before the teardown is not enough: it makes=0D
rc_dev_uevent() return -ENODEV, dev_uevent() fails and kobject_uevent_env()=
=0D
drops the event, so the KOBJ_REMOVE of device_del() is never delivered.=0D
The device has already been announced with KOBJ_ADD, so the remove event=0D
has to be sent as well, and it needs the keymap and the driver strings.=0D
=0D
Keep the keymap alive until device_del() has been called instead: only=0D
unregister the input device at out_rx, since it is a child of dev->dev,=0D
and let out_free_table free the keymap afterwards, as it already does for=0D
the other error paths.  device_del() drains the sysfs readers, so=0D
rc_dev_uevent() cannot run once it has returned and the keymap can be=0D
freed there.=0D
=0D
dev->registered is still cleared so that open lirc file descriptors=0D
cannot reach the driver callbacks, but only after device_del() has sent=0D
the remove uevent.=0D
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
this is a rebase of v3 on the media tree: media-ci rejected v3 because it=0D
was not based on a media-committers branch.  I have based it on fixes;=0D
the function names and the structure follow what is there now, so the=0D
helper from v2 is gone and the clear after device_del() folds into the=0D
existing scoped_guard.=0D
=0D
The rest of the media-ci report (coccinelle, smatch, sparse and the rc=0D
keymap checks) comes from the tree itself, none of it touches rc-main.c.=0D
=0D
Thanks,=0D
YuanZhe=0D
=0D
v4:=0D
 - Rebased on the media-committers fixes branch, as media-ci requires a=0D
   media tree ancestor (v3 was based on v7.2.10).=0D
 - The keymap is kept until device_del() has sent the remove uevent, so=0D
   the KOBJ_REMOVE is not suppressed by rc_dev_uevent() returning -ENODEV.=
=0D
=0D
v3:=0D
 - Keep the keymap until the remove uevent has been sent instead of=0D
   clearing dev->registered before freeing it.=0D
 - Clear dev->registered after device_del() on the register error paths.=0D
 - Rename the helper to set_unregistered() and drop the explanatory=0D
   comment (Sean Young).=0D
---=0D
 drivers/media/rc/rc-main.c | 15 ++++++++++-----=0D
 1 file changed, 10 insertions(+), 5 deletions(-)=0D
=0D
diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c=0D
index a867bf9e8416..a2a6ad2a7b0c 100644=0D
--- a/drivers/media/rc/rc-main.c=0D
+++ b/drivers/media/rc/rc-main.c=0D
@@ -2013,14 +2013,19 @@ int rc_register_device(struct rc_dev *dev)=0D
 	return 0;=0D
 =0D
 out_rx:=0D
-	rc_free_rx_device(dev);=0D
+	/*=0D
+	 * The input device is a child of dev->dev, so it has to be=0D
+	 * unregistered before device_del(); the keymap is still needed=0D
+	 * by the uevent attribute until then.=0D
+	 */=0D
+	if (dev->input_dev)=0D
+		input_unregister_device(dev->input_dev);=0D
 out_lirc:=0D
-	scoped_guard(mutex, &dev->lock)=0D
-		dev->registered =3D false;=0D
-=0D
 	lirc_unregister(dev);=0D
 	device_del(&dev->dev);=0D
-	/* registered already cleared above */=0D
+=0D
+	scoped_guard(mutex, &dev->lock)=0D
+		dev->registered =3D false;=0D
 	goto out_free_table;=0D
 out_rx_free:=0D
 	scoped_guard(mutex, &dev->lock)=0D
-- =0D
2.34.1=0D
=0D

