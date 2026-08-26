Received: from sg-2-2.ptr.blmpb.com (sg-2-2.ptr.blmpb.com [71.18.227.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3B54582DC
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787777003; cv=none; b=Z3NN6ZDUQuRtbW2MsbON3xZhk/AIkTnECAZft/ChWgvH2XbGm2VwfTVsrQRD2UP3nhkyWk0f+mhVKv2QOpVWSNBUHevp7l4ti5fb7kqpqgw+vM3PHBQHUfysjPCy8alqoxfU2LK7JWZNyOHjPn1aUtPpV2aIcXCjpNxg5+WiGg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787777003; c=relaxed/simple;
	bh=MNr3wW/tyxTB+PPtDJWefKcfvYxZvgVDR2f+8LqUwQo=;
	h=Cc:Subject:Mime-Version:From:Content-Type:To:Message-Id:Date; b=AtKhqUFfJTEJ9N9FhDuISHc3BxvcdyVBmwP7dwrU2binNlkyJIzvpmG50bgTDzxcGm2muxs6GZdMF4ZbMNvPbbJVigBHYX09VDuXSWmm7mA/U5ZpR8aiLxbu/tS0agfVtftkzSLb2ioEEAXWn5E3HqA8WvhnxqjFjCKxh19W+g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=Xhdbi5Ok; arc=none smtp.client-ip=71.18.227.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="Xhdbi5Ok"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1787776995; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=duR+QaYr/cmAp2T658fmRswYV963j2wminAqFLl7a44=;
 b=Xhdbi5OkQojdqs39PhdH6We5mqSFqYahmDuMv2Sth0PQuXfj4S8QUxzH/wXMJ5S2Y9ognt
 Y+56zZF6u99hhA6iVV8tdU52MsY/CJpvLwSkfqU5RriEMx1R6MlaAnIUEFk0EsLv4eboWm
 iYvTbfoMw/7hwOiSVrDG55RkkKw5Z+kXI5Djd7mYfYtvdJrqly1zboM/DceULEs9YFOCZs
 PQSg77Xum43Cluy6lKAzqRpxcK/KhEkbd4V98i25oXTbbojq1itWhpHM1u0/KtQpodGL7t
 mCxaWghTgMgaySe8VpxuTFhanygXoFmbhfqURiNWHM0CRwhBVyH/obWvO0k8qQ==
Cc: <stable@vger.kernel.org>, "Shengzhuo Wei" <me@cherr.cc>
Subject: [PATCH] HSI: hsi_char: Fix use-after-free on device removal
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Shengzhuo Wei <me@cherr.cc>
From: "Shengzhuo Wei" <me@cherr.cc>
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+26a8f4fe1+26c430+vger.kernel.org+me@cherr.cc>
To: <sre@kernel.org>, <kees@kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Andras Domokos" <andras.domokos@nokia.com>, 
	"Carlos Chinea" <carlos.chinea@nokia.com>
Message-Id: <20260827-hsi-char-uaf-v1-1-4f824216a541@cherr.cc>
X-Mailer: b4 0.14.2
X-Change-Id: 20260827-hsi-char-uaf-4013a742dcd9
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANxPj2oC/x2MQQqAMAzAvjJ6tjCrOPUr4mG4TntR6VAE2d8dH kNIXkiswglG84LyLUmOvUBdGVg2v6+MEgoDWepsTw63JFiM4uUjtrZuvGspLGGAkpzKUZ5/N80 5f1U7PnBeAAAA
Date: Thu, 27 Aug 2026 04:43:08 +0800
Received: from [192.168.9.107] ([111.42.148.52]) by smtp.feishu.cn with ESMTPS; Thu, 27 Aug 2026 04:43:12 +0800

hsc_open() stores a pointer to a channel embedded in the hsc_client_data
in file->private_data, but hsc_remove() frees the whole hsc_client_data
right after cdev_del(). If the HSI client device is removed while a
channel is open, the next access from the file descriptor (a read, an
ioctl or the final close) dereferences freed memory:

CPU0                                CPU1
hsc_remove                          hsc_read
  cdev_del(&cl_data->cdev);           channel->cl->rx_cfg ...
  kfree(cl_data);                     // use after free

Fix it by tracking the hsc_client_data with a kref: each open file
descriptor takes a reference, and hsc_remove() drops the initial one,
so the object is freed only after the last descriptor is closed.

Fixes: 4e69fc22753f ("HSI: hsi_char: Add HSI char device driver")
Cc: stable@vger.kernel.org
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
 drivers/hsi/clients/hsi_char.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/hsi/clients/hsi_char.c b/drivers/hsi/clients/hsi_char.c
index a31cc1466dd3ddf73762ce3d0213c96d64a190fd..479e5d6e94c8c03489464c4b39d81d697d104ce0 100644
--- a/drivers/hsi/clients/hsi_char.c
+++ b/drivers/hsi/clients/hsi_char.c
@@ -96,6 +96,7 @@ struct hsc_channel {
  * @usecnt: Use count for claiming the HSI port (mutex protected)
  * @cl: Referece to the HSI client
  * @channels: Array of channels accessible by the client
+ * @kref: Reference count for the client data lifetime
  */
 struct hsc_client_data {
 	struct cdev		cdev;
@@ -104,6 +105,7 @@ struct hsc_client_data {
 	unsigned int		usecnt;
 	struct hsi_client	*cl;
 	struct hsc_channel	channels[HSC_DEVS];
+	struct kref		kref;
 };
 
 /* Stores the major number dynamically allocated for hsi_char */
@@ -576,6 +578,11 @@ static long hsc_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return ret;
 }
 
+static void hsc_client_data_release(struct kref *kref)
+{
+	kfree(container_of(kref, struct hsc_client_data, kref));
+}
+
 static inline void __hsc_port_release(struct hsc_client_data *cl_data)
 {
 	BUG_ON(cl_data->usecnt == 0);
@@ -613,10 +620,12 @@ static int hsc_open(struct inode *inode, struct file *file)
 		hsi_setup(cl_data->cl);
 	}
 	cl_data->usecnt++;
+	kref_get(&cl_data->kref);
 
 	ret = hsc_msgs_alloc(channel);
 	if (ret < 0) {
 		__hsc_port_release(cl_data);
+		kref_put(&cl_data->kref, hsc_client_data_release);
 		goto out;
 	}
 
@@ -650,6 +659,8 @@ static int hsc_release(struct inode *inode __maybe_unused, struct file *file)
 	wake_up(&channel->tx_wait);
 	mutex_unlock(&cl_data->lock);
 
+	kref_put(&cl_data->kref, hsc_client_data_release);
+
 	return 0;
 }
 
@@ -703,6 +714,7 @@ static int hsc_probe(struct device *dev)
 		goto out1;
 	}
 	mutex_init(&cl_data->lock);
+	kref_init(&cl_data->kref);
 	hsi_client_set_drvdata(cl, cl_data);
 	cdev_init(&cl_data->cdev, &hsc_fops);
 	cl_data->cdev.owner = THIS_MODULE;
@@ -739,7 +751,7 @@ static int hsc_remove(struct device *dev)
 	cdev_del(&cl_data->cdev);
 	unregister_chrdev_region(hsc_dev, HSC_DEVS);
 	hsi_client_set_drvdata(cl, NULL);
-	kfree(cl_data);
+	kref_put(&cl_data->kref, hsc_client_data_release);
 
 	return 0;
 }

---
base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
change-id: 20260827-hsi-char-uaf-4013a742dcd9

Best regards,
-- 
Shengzhuo Wei <me@cherr.cc>
