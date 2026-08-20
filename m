Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20313BAD9C
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 19:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787254591; cv=none; b=SnY+Z/9qLr5NywXaEQgF+/o5PApfeQnbUFDWge/XZjhUbXrJkS0Zhl4jy7T4XZD67IQzrtfBfV/FGzmur9l1SZzuBcf1bVnjz/ptlNjTkHNldeZkMAW/thA1CSxQav5qZu9R2B7geXZLrQErMq+zFHW3eb051ekFE2y1k49OIgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787254591; c=relaxed/simple;
	bh=HmE++w3i3QULWuq6vYGHVYU3fNrAqE6vZBf7JyfC1AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTManphKNrVhcMplAgjhQv4LrmbNQM1anRS+wIx548frxNwF1R7w92ANP3w5amnD1jSGTv/NWYk+lAdLCDgXItwMsbHSy1YkLFHJOf+j4Bbofu6ouKUqmpQKBTcPTGCCBKX3vO19B9X2O7GMr7DjLQXLDHkB0cxndwkILC7bunE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D23wAGYt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D23wAGYt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A821F000E9;
	Thu, 20 Aug 2026 19:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787254589;
	bh=LAGAiLY/dRUCxfk8kVPoLM4uV7klW7ILrxoDLBBCBX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D23wAGYtmdKMsbdFgd3Xr3P5tfXHJecqwrbskaJQWXAZbuBU+5mvm8OYFqOdtgK6K
	 nZkqD5Zqm2XX2EDMUpQN31IkxF5TvK8UYP8/jzwEUTDqOnCdE80ZPpoaroHi54Y43A
	 +XhWoAgMU8+2fU1BWY7PX1hC8hSZFAie5+dajdEDbfSyaHbyDdwOShejAA4nSXNG4P
	 OoaUe2DMlVecQgx6Velb7JKZGNmqBiKSyWyGXvKfTTw+MW6yh4jGDzyvw+xYVxpNQ8
	 ZYJAvHp4yxWh4iXKNIplCQrx4mLgql/011BAlULXRDwmXHWIRjABbQhvVXoTcoKTf2
	 tk/ew63yCGebg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] misc: fastrpc: separate fastrpc device from channel context
Date: Thu, 20 Aug 2026 15:36:24 -0400
Message-ID: <20260820193626.2274224-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081715-crucial-stammer-2659@gregkh>
References: <2026081715-crucial-stammer-2659@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit 965602eabb57d086466ad749e81941e3dd66b595 ]

Currently fastrpc misc device instance is within channel context struct
with a kref. So we have 2 structs with refcount, both of them managing the
same channel context structure.

Separate fastrpc device from channel context and by adding a dedicated
fastrpc_device structure, this should clean the structures a bit and also help
when adding secure device node support.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20220214161002.6831-2-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 6102ceb4eab8 ("misc: fastrpc: Remove buffer from list prior to unmap operation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/fastrpc.c | 46 +++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index 3c461e3fc8b8c..5c90d965765d0 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -78,7 +78,7 @@
 #define USER_PD		(1)
 #define SENSORS_PD	(2)
 
-#define miscdev_to_cctx(d) container_of(d, struct fastrpc_channel_ctx, miscdev)
+#define miscdev_to_fdevice(d) container_of(d, struct fastrpc_device, miscdev)
 
 static const char *domains[FASTRPC_DEV_MAX] = { "adsp", "mdsp",
 						"sdsp", "cdsp"};
@@ -212,9 +212,14 @@ struct fastrpc_channel_ctx {
 	spinlock_t lock;
 	struct idr ctx_idr;
 	struct list_head users;
-	struct miscdevice miscdev;
 	struct kref refcount;
 	u64 dma_mask;
+	struct fastrpc_device *fdevice;
+};
+
+struct fastrpc_device {
+	struct fastrpc_channel_ctx *cctx;
+	struct miscdevice miscdev;
 };
 
 struct fastrpc_user {
@@ -1250,10 +1255,14 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
 
 static int fastrpc_device_open(struct inode *inode, struct file *filp)
 {
-	struct fastrpc_channel_ctx *cctx = miscdev_to_cctx(filp->private_data);
+	struct fastrpc_channel_ctx *cctx;
+	struct fastrpc_device *fdevice;
 	struct fastrpc_user *fl = NULL;
 	unsigned long flags;
 
+	fdevice = miscdev_to_fdevice(filp->private_data);
+	cctx = fdevice->cctx;
+
 	fl = kzalloc(sizeof(*fl), GFP_KERNEL);
 	if (!fl)
 		return -ENOMEM;
@@ -1651,6 +1660,27 @@ static struct platform_driver fastrpc_cb_driver = {
 	},
 };
 
+static int fastrpc_device_register(struct device *dev, struct fastrpc_channel_ctx *cctx,
+				   const char *domain)
+{
+	struct fastrpc_device *fdev;
+	int err;
+
+	fdev = devm_kzalloc(dev, sizeof(*fdev), GFP_KERNEL);
+	if (!fdev)
+		return -ENOMEM;
+
+	fdev->cctx = cctx;
+	fdev->miscdev.minor = MISC_DYNAMIC_MINOR;
+	fdev->miscdev.fops = &fastrpc_fops;
+	fdev->miscdev.name = devm_kasprintf(dev, GFP_KERNEL, "fastrpc-%s", domain);
+	err = misc_register(&fdev->miscdev);
+	if (!err)
+		cctx->fdevice = fdev;
+
+	return err;
+}
+
 static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 {
 	struct device *rdev = &rpdev->dev;
@@ -1680,11 +1710,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	if (!data)
 		return -ENOMEM;
 
-	data->miscdev.minor = MISC_DYNAMIC_MINOR;
-	data->miscdev.name = devm_kasprintf(rdev, GFP_KERNEL, "fastrpc-%s",
-					    domains[domain_id]);
-	data->miscdev.fops = &fastrpc_fops;
-	err = misc_register(&data->miscdev);
+	err = fastrpc_device_register(rdev, data, domains[domain_id]);
 	if (err) {
 		kfree(data);
 		return err;
@@ -1729,7 +1755,9 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
 		fastrpc_notify_users(user);
 	spin_unlock_irqrestore(&cctx->lock, flags);
 
-	misc_deregister(&cctx->miscdev);
+	if (cctx->fdevice)
+		misc_deregister(&cctx->fdevice->miscdev);
+
 	of_platform_depopulate(&rpdev->dev);
 
 	fastrpc_channel_ctx_put(cctx);
-- 
2.53.0

