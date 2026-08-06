Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0926456DF9
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030012; cv=none; b=NyxOBhHPaX6lMClC/Mz1w7qxaFRI9tmgrL6JhXnIQpNTGp6U5BCnfDJYQtHYxA4eG2HUNqdtCPtOLM7DWep/9EzdETAw4DSK3qnJAFxTXGRf5ztV7oUUsksvialdZrpeZ/aIviicXzdE7myPEhn1dLivEeYb0++zS+sQ/Z2LLI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030012; c=relaxed/simple;
	bh=rEKbF591oxpYluV1Rb9cPJoVO7RLz34iR6wASlguTEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OeOx28nPi7/OxPO+6+pa2U6jnA3+Q6UegF72Mt9+PQjKEf2PfwRKHWeWh546CtFVhQYUDSpAGBs893EcOWwBIYApWeztWO1OU538IW6itGKeyJgsBAJMZD7jzg4QLLn8GkgENo6RDe/CzIIUbx5zVlZhGzobF9oiTWRtppqHb0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYTCftCO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYTCftCO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD3D1F000E9;
	Thu,  6 Aug 2026 15:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786030010;
	bh=T2DjkZWfoGohKa9+r4hNqj+y/nzZV0XH9XfY24aU/cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DYTCftCOvpUpcE+A7ux4Jx09q4C+tkhCF+GHh1ooh9UVYFHYqJ9P7OVmStyBOGgKP
	 rB71nPCH3Yp/ZfSiPwPDxrPr6HWZglX+bnCD0MV8FCUtZrZ0PCGKW5tADvrlL+WHJM
	 87UGNNwqMCsreWyE43AHHtjNpDJAjh0Ynd9OP/62k0ETEWQ87aJvPnAhpciib0Kr5D
	 fUFL07OjeTuvz3QRuYFlgXOo4l4uEmXz+CE2rzhgjYFqOTUbzErVCfFvul5n31fRSd
	 8sGjBdTtpXSQr3Q/1lRwrknWaZRbm4fZbLtxYoKy+TB8pWpd6KicYW/zz0wUC5QYHi
	 k6louWIwVoouQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] media: v4l: async: Set owner for async sub-devices
Date: Thu,  6 Aug 2026 11:26:47 -0400
Message-ID: <20260806152648.913828-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072929-fresh-parsley-3ec6@gregkh>
References: <2026072929-fresh-parsley-3ec6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sakari Ailus <sakari.ailus@linux.intel.com>

[ Upstream commit 8a718752f5c339137c5b05e54f116cd26d5a4143 ]

Set the owner field of the async sub-devices by making
v4l2_async_register_subdev() a macro and obtaining THIS_MODULE that way.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Stable-dep-of: 06cb687a5132 ("media: v4l2-fwnode: Fix subdev owner overwritten in v4l2_async_register_subdev_sensor()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/v4l2-core/v4l2-async.c | 8 ++++++--
 include/media/v4l2-async.h           | 4 +++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-async.c b/drivers/media/v4l2-core/v4l2-async.c
index 33babe6e8b3a2..fc741182f2d9b 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -747,7 +747,7 @@ v4l2_async_notifier_add_devname_subdev(struct v4l2_async_notifier *notifier,
 }
 EXPORT_SYMBOL_GPL(v4l2_async_notifier_add_devname_subdev);
 
-int v4l2_async_register_subdev(struct v4l2_subdev *sd)
+int __v4l2_async_register_subdev(struct v4l2_subdev *sd, struct module *module)
 {
 	struct v4l2_async_notifier *subdev_notifier;
 	struct v4l2_async_notifier *notifier;
@@ -761,6 +761,8 @@ int v4l2_async_register_subdev(struct v4l2_subdev *sd)
 	if (!sd->fwnode && sd->dev)
 		sd->fwnode = dev_fwnode(sd->dev);
 
+	sd->owner = module;
+
 	mutex_lock(&list_lock);
 
 	INIT_LIST_HEAD(&sd->async_list);
@@ -811,9 +813,11 @@ int v4l2_async_register_subdev(struct v4l2_subdev *sd)
 
 	mutex_unlock(&list_lock);
 
+	sd->owner = NULL;
+
 	return ret;
 }
-EXPORT_SYMBOL(v4l2_async_register_subdev);
+EXPORT_SYMBOL(__v4l2_async_register_subdev);
 
 void v4l2_async_unregister_subdev(struct v4l2_subdev *sd)
 {
diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
index 92cd9f038fed8..9f474d4e277a1 100644
--- a/include/media/v4l2-async.h
+++ b/include/media/v4l2-async.h
@@ -298,7 +298,9 @@ void v4l2_async_notifier_cleanup(struct v4l2_async_notifier *notifier);
  *
  * @sd: pointer to &struct v4l2_subdev
  */
-int v4l2_async_register_subdev(struct v4l2_subdev *sd);
+#define v4l2_async_register_subdev(sd) \
+	__v4l2_async_register_subdev(sd, THIS_MODULE)
+int __v4l2_async_register_subdev(struct v4l2_subdev *sd, struct module *module);
 
 /**
  * v4l2_async_register_subdev_sensor_common - registers a sensor sub-device to
-- 
2.53.0

