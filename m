Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.34.181.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794225987;
	b=2xVh4y/jwCi83EM0tLqYRnNIEfTclWCAicgJFebbzkJgl+Oo/se8zbcTI1iJ7JDCSmN3
	 GlgVZpIDceIYS/wg7Wljc2tETXN/0c7YJjJ/4iesIUcAVREiIeDJPSXpYbXMamHL9o0au
	 fzbUsjgpdDF8W5DR+9DTYBAEKBH1DIkqRIMBJZ5y4fG16V0FBp134xwto4mMUQHZf8TT5
	 Rlae/atr2e/2Jbi95w+TtO1LSx1jZyOt69YuqIESLD55bC0tLe7jw0mXtrxzHpsV60WfT
	 ILvdbRVY80ff1KSYuRc60rUKS3XzLkbjXGh8W8TUQ08zQ0bJ85Qe2H08P3ySmMEizQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794225987;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=0VuVVg34SVhh19lc0M2prCmknCi1Yv0FJcvaWZscTnY=;
	b=WuMgZfYA4AzWL0aT38KcyH+f0gh7o79Y8zJqGEfC4cZ2d5UiZcxfK5p8maiN7rs9spvQ
	 0LR0YM6iqrdjdYRC2HfVFAFKCU0lePa4TW+tGGwXL6hH5Wvsju/C7R7r+CZKfXTcQ1pPL
	 ZID9F0LqM8a5N7TLKphrgpfCwm6ofc/yyiTDFYuyl9QlFYLUN9GipCewP/n+cV56yN2z1
	 46vf0dtnJ6NOhnfSxug8cPBwJ1eal43mTWL14gTMykOUErMnZ6M/IyGq7yzVkrbxAaNCy
	 FxJMzt+/zy7wbHc6/WVnq3kw/8PIC9dGDVRBhZ7dWeiXdVUrjDsxPv/0vGV4xjZ0RWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b="Gow/JqYX";
	arc=none smtp.remote-ip=52.34.181.151
Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D4C606A323
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 12:06:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7D4C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=Gow/JqYX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1794225986; x=1825761986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0VuVVg34SVhh19lc0M2prCmknCi1Yv0FJcvaWZscTnY=;
  b=Gow/JqYXTFuyCbiRJ0e/hx/fuI8uBcQ2r4NAnNfwQ6psL0X5pK42lszZ
   T/CY0C8yCUUpu9OnUoVNwsCpKXMnk4VoH0jpynenFAXdnj7LClG7Y8+xH
   M5yh7rWGr/LD99wpTLbphFhHoaMzFCfRYOPb51mZpmbVPVZ+UqUFAAuj8
   6ydE4GbeGdFz/ZooQwJ8yao6HPc7l2BpYLaciuE7Mdlr7Itnyy/fE1NaP
   Urr8xf3hAyykyqGdX6EvvM79lW7v8hAZCTXFGwFCG6kUyhd9lq0miGDdX
   KqJEvETPXItAdcVMSt5R1m6YOyaKXPv/NSxTbBUH6ek82dWMAj215/nF6
   g==;
X-CSE-ConnectionGUID: WMzDlmkiRUiT8x7urzJsLg==
X-CSE-MsgGUID: 762jorwVRNqtmIVbP0U9pg==
X-IronPort-AV: E=Sophos;i="6.27,203,1787011200"; 
   d="scan'208";a="33505359"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 12:06:24 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:25046]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.21:2525] with esmtp (Farcaster)
 id a7557aed-3d29-4892-9a86-197b78983ed1; Mon, 9 Nov 2026 12:06:23 +0000 (UTC)
X-Farcaster-Flow-ID: a7557aed-3d29-4892-9a86-197b78983ed1
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Mon, 9 Nov 2026 12:06:23 +0000
Received: from dev-dsk-simonlie-1b-ad174abf.eu-west-1.amazon.com
 (172.19.78.185) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Mon, 9 Nov 2026
 12:06:22 +0000
From: Simon Liebold <simonlie@amazon.de>
To: <stable@vger.kernel.org>
CC: Eric Sandeen <sandeen@redhat.com>, Simon Liebold <simonlie@amazon.de>, "Al
 Viro" <viro@zeniv.linux.org.uk>, "Christian Brauner (Amutable)"
	<brauner@kernel.org>
Subject: [PATCH 6.18.y 2/2] devtmpfs: restore mount option reconfiguration on get_tree
Date: Mon, 9 Nov 2026 12:05:50 +0000
Message-ID: <20261109120550.1776888-2-simonlie@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261109120550.1776888-1-simonlie@amazon.de>
References: <20261107050610-failed-6.18-1c7df6fa838a@kernel.org>
 <20261109120550.1776888-1-simonlie@amazon.de>
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
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Eric Sandeen <sandeen@redhat.com>

[ Upstream commit 1c7df6fa838a46f0d5090ef134f67511f0592f33 ]

commit cb0e0a8bf4e1 ("devtmpfs: replace ->mount with ->get_tree in
public instance") converted the public devtmpfs instance to the new
mount API but broke the ability to reconfigure the shared superblock
options via subsequent mount() calls, as had been fixed once in
a6097180d884 ("devtmpfs regression fix: reconfigure on each mount")

This makes boot-time defaults permanent.

Fix this using an approach suggested by Al Viro: at init_fs_context
time, create a reconfigure-mode context via fs_context_for_reconfigure()
and save it in fc->fs_private. The devtmpfs parse ops can then use
this context to parse options appropriately for the underlying filesystem.

This also removes the devtmpfs_configure_context() one-time ops-copying
approach and the global mutable ops table it required.

Fixes: cb0e0a8bf4e1 ("devtmpfs: replace ->mount with ->get_tree in public instance")
Reported-by: Simon Liebold <simonlie@amazon.de>
Cc: stable@vger.kernel.org
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Eric Sandeen <sandeen@redhat.com>
Link: https://patch.msgid.link/b1bd3b15-78ea-4487-b6a8-aad0b05dd3bb@redhat.com
Tested-by: Simon Liebold <simonlie@amazon.de>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Simon Liebold <simonlie@amazon.de>
---
 drivers/base/devtmpfs.c | 108 ++++++++++++++++++++++++----------------
 1 file changed, 64 insertions(+), 44 deletions(-)

diff --git a/drivers/base/devtmpfs.c b/drivers/base/devtmpfs.c
index 0bf3232b3ec14..645c9f2674e99 100644
--- a/drivers/base/devtmpfs.c
+++ b/drivers/base/devtmpfs.c
@@ -73,39 +73,90 @@ static struct file_system_type internal_fs_type = {
 	.kill_sb = kill_litter_super,
 };
 
-/* Simply take a ref on the existing mount */
+struct devtmpfs_context {
+	struct fs_context *fc;
+};
+
+static void devtmpfs_free(struct fs_context *fc)
+{
+	struct devtmpfs_context *ctx = fc->fs_private;
+
+	if (ctx) {
+		put_fs_context(ctx->fc);
+		kfree(ctx);
+	}
+}
+
+static int devtmpfs_parse_param(struct fs_context *fc, struct fs_parameter *param)
+{
+	struct devtmpfs_context *ctx = fc->fs_private;
+
+	return ctx->fc->ops->parse_param(ctx->fc, param);
+}
+
+static int devtmpfs_parse_monolithic(struct fs_context *fc, void *data)
+{
+	struct devtmpfs_context *ctx = fc->fs_private;
+
+	if (ctx->fc->ops->parse_monolithic)
+		return ctx->fc->ops->parse_monolithic(ctx->fc, data);
+	return generic_parse_monolithic(ctx->fc, data);
+}
+
 static int devtmpfs_get_tree(struct fs_context *fc)
 {
+	struct devtmpfs_context *ctx = fc->fs_private;
 	struct super_block *sb = mnt->mnt_sb;
+	int err;
 
 	atomic_inc(&sb->s_active);
 	down_write(&sb->s_umount);
+
+	if (ctx->fc->ops->reconfigure) {
+		err = ctx->fc->ops->reconfigure(ctx->fc);
+		if (err) {
+			deactivate_locked_super(sb);
+			return err;
+		}
+	}
+
 	fc->root = dget(sb->s_root);
 	return 0;
 }
 
-/* Ops are filled in during init depending on underlying shmem or ramfs type */
-static struct fs_context_operations devtmpfs_context_ops = {};
+static const struct fs_context_operations devtmpfs_context_ops = {
+	.free		  = devtmpfs_free,
+	.parse_param	  = devtmpfs_parse_param,
+	.parse_monolithic = devtmpfs_parse_monolithic,
+	.get_tree	  = devtmpfs_get_tree,
+};
 
-/* Call the underlying initialization and set to our ops */
 static int devtmpfs_init_fs_context(struct fs_context *fc)
 {
-	int ret;
-#ifdef CONFIG_TMPFS
-	ret = shmem_init_fs_context(fc);
-#else
-	ret = ramfs_init_fs_context(fc);
-#endif
-	if (ret < 0)
-		return ret;
+	struct devtmpfs_context *ctx;
+	int err;
+
+	ctx = kzalloc_obj(struct devtmpfs_context);
+	if (!ctx)
+		return -ENOMEM;
+
+	/* Each mount will reconfigure the shared superblock w/ new options */
+	ctx->fc = fs_context_for_reconfigure(mnt->mnt_root,
+					     mnt->mnt_sb->s_flags, MS_RMT_MASK);
+	if (IS_ERR(ctx->fc)) {
+		err = PTR_ERR(ctx->fc);
+		kfree(ctx);
+		return err;
+	}
 
+	fc->fs_private = ctx;
 	fc->ops = &devtmpfs_context_ops;
 
 	return 0;
 }
 
 static struct file_system_type dev_fs_type = {
-	.name = "devtmpfs",
+	.name		 = "devtmpfs",
 	.init_fs_context = devtmpfs_init_fs_context,
 };
 
@@ -443,31 +494,6 @@ static int __ref devtmpfsd(void *p)
 	return 0;
 }
 
-/*
- * Get the underlying (shmem/ramfs) context ops to build ours
- */
-static int devtmpfs_configure_context(void)
-{
-	struct fs_context *fc;
-
-	fc = fs_context_for_reconfigure(mnt->mnt_root, mnt->mnt_sb->s_flags,
-					MS_RMT_MASK);
-	if (IS_ERR(fc))
-		return PTR_ERR(fc);
-
-	/* Set up devtmpfs_context_ops based on underlying type */
-	devtmpfs_context_ops.free	      = fc->ops->free;
-	devtmpfs_context_ops.dup	      = fc->ops->dup;
-	devtmpfs_context_ops.parse_param      = fc->ops->parse_param;
-	devtmpfs_context_ops.parse_monolithic = fc->ops->parse_monolithic;
-	devtmpfs_context_ops.get_tree	      = &devtmpfs_get_tree;
-	devtmpfs_context_ops.reconfigure      = fc->ops->reconfigure;
-
-	put_fs_context(fc);
-
-	return 0;
-}
-
 /*
  * Create devtmpfs instance, driver-core devices will add their device
  * nodes here.
@@ -483,12 +509,6 @@ int __init devtmpfs_init(void)
 		return PTR_ERR(mnt);
 	}
 
-	err = devtmpfs_configure_context();
-	if (err) {
-		pr_err("unable to configure devtmpfs type %d\n", err);
-		return err;
-	}
-
 	err = register_filesystem(&dev_fs_type);
 	if (err) {
 		pr_err("unable to register devtmpfs type %d\n", err);
-- 
2.50.1

