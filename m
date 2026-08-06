Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BD13B5E19
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026159; cv=none; b=r8tbjjWfQKW10aVDJ7b4zHXxhtFwgmEmW5thUn2MpWQ29BU5/zIP3QvunzPMk0TpVeZCNSsF8q9o3nxglUsilNgMsLhgODS795QFbbzwO1ADWzT8n75riEcc0Ufjksa1vQG5ZT0b6uvvu4OBHGqkrgy2ALlzcxYeDuK5h23+Ao8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026159; c=relaxed/simple;
	bh=0+goeThpA2AV/JpijTCyxuRuAQtfj9KXaDoeE9gYA6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axABDok1MCkIPWFC34xUx6u0WYf54uNwQKF3aTb5JqFwpe6IUtM2QlCUrPm8sxzg+mOs1+BQnPV5S/YXgrPA9f4uHNstanDHL43OIFh7wq/iIQrpGGZ+7W59XHDe6m9uOYo2be6sOozO5kPT3p4ysfKtbYYJaU5pu+eqQArUqd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBrHEPUO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBrHEPUO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4FD1F00A3D;
	Thu,  6 Aug 2026 14:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786026158;
	bh=DIpuMmxcoDOYM5jr+QjEyjojw8EmAmaZ9jzXXBErDi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NBrHEPUOjIm+FEqvc3AnkU7tijN8Y9tgJGgNbNQkCBAu05dD9thuXwy2vle6UhBAF
	 wymZiErWSbgq0PZyrqSvUcIWcL4hdbDASyFyGO46cws2CzdIqh47T3BS1QjbgJUqlS
	 0HTvx0CANPmuL4OPXSROD4crrqvk8BY+0+TwNMVIqsjDIBtF4XXtU1hvFF3x18r3FS
	 DOyuSxKJIeIPkZdKK/DdpipVcYNBBGDjWGv/HhS/iyTcQbMCxLY+V/I21I5E6XWGs5
	 dHJ51MD/BHjF2PVH5QiekDY7vnWw/36sTfJ8NNK6dkrCQDklUeAIN3c/SBEkQxD5zH
	 8KZscKqD22XRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mirela Rabulea <mirela.rabulea@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] media: v4l2-fwnode: Fix subdev owner overwritten in v4l2_async_register_subdev_sensor()
Date: Thu,  6 Aug 2026 10:22:34 -0400
Message-ID: <20260806142234.786485-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806142234.786485-1-sashal@kernel.org>
References: <2026072937-overbill-reflector-662e@gregkh>
 <20260806142234.786485-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mirela Rabulea <mirela.rabulea@nxp.com>

[ Upstream commit 06cb687a5132fcffe624c0070576ab852ac6b568 ]

The v4l2 helper v4l2_async_register_subdev_sensor() calls
v4l2_async_register_subdev(), which is a macro that expands to
__v4l2_async_register_subdev(sd,THIS_MODULE). Since the macro is expanded
inside v4l2-fwnode.c, THIS_MODULE resolves to the v4l2-fwnode module
rather than the sensor driver module that originally set sd->owner. When
v4l2-fwnode is built-in, THIS_MODULE evaluates to NULL, which then
overwrites the sensor driver's owner with NULL.

This causes the problem that the sensor module's reference count is never
incremented during async registration, so the module can be removed while
the subdevice is still in use by a notifier (e.g., a CSI-2 receiver
bridge driver).

Fix this by renaming v4l2_async_register_subdev_sensor() to
__v4l2_async_register_subdev_sensor() with an added explicit module
argument and introducing a wrapper macro:
    #define v4l2_async_register_subdev_sensor(sd) \
        __v4l2_async_register_subdev_sensor(sd, THIS_MODULE)

This ensures the sensor driver module is properly referenced even when
the sensor driver does not init the owner field before calling
v4l2_async_register_subdev_sensor() and prevents premature module removal.

Fixes: aef69d54755d ("media: v4l: fwnode: Add a convenience function for registering sensors")
Cc: stable@vger.kernel.org
Suggested-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/linux-media/20240315073125.275501-2-sakari.ailus@linux.intel.com/
Signed-off-by: Mirela Rabulea <mirela.rabulea@nxp.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/v4l2-core/v4l2-fwnode.c | 6 +++---
 include/media/v4l2-async.h            | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 5d2eaad1fa684..93dbc00bf37a8 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -1318,7 +1318,7 @@ v4l2_async_notifier_parse_fwnode_sensor(struct device *dev,
 	return 0;
 }
 
-int v4l2_async_register_subdev_sensor(struct v4l2_subdev *sd)
+int __v4l2_async_register_subdev_sensor(struct v4l2_subdev *sd, struct module *module)
 {
 	struct v4l2_async_notifier *notifier;
 	int ret;
@@ -1340,7 +1340,7 @@ int v4l2_async_register_subdev_sensor(struct v4l2_subdev *sd)
 	if (ret < 0)
 		goto out_cleanup;
 
-	ret = v4l2_async_register_subdev(sd);
+	ret = __v4l2_async_register_subdev(sd, module);
 	if (ret < 0)
 		goto out_unregister;
 
@@ -1357,7 +1357,7 @@ int v4l2_async_register_subdev_sensor(struct v4l2_subdev *sd)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(v4l2_async_register_subdev_sensor);
+EXPORT_SYMBOL_GPL(__v4l2_async_register_subdev_sensor);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Sakari Ailus <sakari.ailus@linux.intel.com>");
diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
index dd8203632f314..dd0d347be07b0 100644
--- a/include/media/v4l2-async.h
+++ b/include/media/v4l2-async.h
@@ -306,8 +306,10 @@ int __v4l2_async_register_subdev(struct v4l2_subdev *sd, struct module *module);
  * An error is returned if the module is no longer loaded on any attempts
  * to register it.
  */
+#define v4l2_async_register_subdev_sensor(sd) \
+	__v4l2_async_register_subdev_sensor(sd, THIS_MODULE)
 int __must_check
-v4l2_async_register_subdev_sensor(struct v4l2_subdev *sd);
+__v4l2_async_register_subdev_sensor(struct v4l2_subdev *sd, struct module *module);
 
 /**
  * v4l2_async_unregister_subdev - unregisters a sub-device to the asynchronous
-- 
2.53.0

