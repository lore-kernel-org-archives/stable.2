Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A763F825A
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 15:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030012; cv=none; b=Tc6fSd9KBFRXnBhtDjNvLygbkglP67GSZH9MCD+xW448JlKsQ5IAAQiy+DlfWwYQxyUbTNjWIcXjAF8O8RyBJeplpMUbvvz74Id9LcpcG10tscfdRg10WOdKohh1IlzeVv2PE24K55pZ8le3b6iPEXem79gjJyGiJWbAde2dkYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030012; c=relaxed/simple;
	bh=itnzEYrQrOo+c19LpFOEJuVhdKnxsMTsS3Ok8euGdXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YplpZ4UkHSGCLq+ioXxvOeZXTNzEhUPG+5MqAH7KYAB/3yWIfBSPrHDKl08T0bCwu7HWQEbiA+7SwMvI2At4TPKOS7ZR/tLuYeWr7gvfZBHOL1wRADqvAlPJdWyIgqh4/q/9b72X+vMu9HuFsSQTQooa/qcx6D2lqMKbjz4zWxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwR85ODN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwR85ODN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9931F00A3D;
	Thu,  6 Aug 2026 15:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786030011;
	bh=1evaVOy906OoxDD1wURPMAKEK01HnJMsyFxKOStJvk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RwR85ODNBlYt7Y/KMm9LeBOV6zxgjga08ncZrqSO9dzaZtenQQ54+uM2QJCACbPUm
	 LEhC5Av42SEE5G3Cx2lo31eD80rb84gUmm2vDvnezzVot258YDNxMx3VSKAcm9VrOB
	 9XhEyf0xtu01+ivAPe0jO48sHPvrwCMD8WWrKvGWpwFEkTI+FcLIqd1dZbXP8RCMLb
	 iYT5rpilsWJ7V3ftQAl7KThd3CtqKYcFcC2/CcYKodm3Crhk01W9lYehWqgsRlpz37
	 3uAnIVtcUMBjUrDJAbEDbVQFOlYh3bRN3rSbG0dkV5nhq3Ztn4u3qzUg2grpH75ZEV
	 3DJIyNBtaDScg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mirela Rabulea <mirela.rabulea@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] media: v4l2-fwnode: Fix subdev owner overwritten in v4l2_async_register_subdev_sensor()
Date: Thu,  6 Aug 2026 11:26:48 -0400
Message-ID: <20260806152648.913828-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806152648.913828-1-sashal@kernel.org>
References: <2026072929-fresh-parsley-3ec6@gregkh>
 <20260806152648.913828-1-sashal@kernel.org>
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
 drivers/media/v4l2-core/v4l2-fwnode.c | 7 ++++---
 include/media/v4l2-async.h            | 5 ++++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-fwnode.c b/drivers/media/v4l2-core/v4l2-fwnode.c
index 1977ce0195fee..754ee332f6894 100644
--- a/drivers/media/v4l2-core/v4l2-fwnode.c
+++ b/drivers/media/v4l2-core/v4l2-fwnode.c
@@ -1337,7 +1337,8 @@ int v4l2_async_notifier_parse_fwnode_sensor_common(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(v4l2_async_notifier_parse_fwnode_sensor_common);
 
-int v4l2_async_register_subdev_sensor_common(struct v4l2_subdev *sd)
+int __v4l2_async_register_subdev_sensor_common(struct v4l2_subdev *sd,
+					       struct module *module)
 {
 	struct v4l2_async_notifier *notifier;
 	int ret;
@@ -1360,7 +1361,7 @@ int v4l2_async_register_subdev_sensor_common(struct v4l2_subdev *sd)
 	if (ret < 0)
 		goto out_cleanup;
 
-	ret = v4l2_async_register_subdev(sd);
+	ret = __v4l2_async_register_subdev(sd, module);
 	if (ret < 0)
 		goto out_unregister;
 
@@ -1377,7 +1378,7 @@ int v4l2_async_register_subdev_sensor_common(struct v4l2_subdev *sd)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(v4l2_async_register_subdev_sensor_common);
+EXPORT_SYMBOL_GPL(__v4l2_async_register_subdev_sensor_common);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Sakari Ailus <sakari.ailus@linux.intel.com>");
diff --git a/include/media/v4l2-async.h b/include/media/v4l2-async.h
index 9f474d4e277a1..4174a7ea3f1e3 100644
--- a/include/media/v4l2-async.h
+++ b/include/media/v4l2-async.h
@@ -321,8 +321,11 @@ int __v4l2_async_register_subdev(struct v4l2_subdev *sd, struct module *module);
  * An error is returned if the module is no longer loaded on any attempts
  * to register it.
  */
+#define v4l2_async_register_subdev_sensor_common(sd) \
+	__v4l2_async_register_subdev_sensor_common(sd, THIS_MODULE)
 int __must_check
-v4l2_async_register_subdev_sensor_common(struct v4l2_subdev *sd);
+__v4l2_async_register_subdev_sensor_common(struct v4l2_subdev *sd,
+					   struct module *module);
 
 /**
  * v4l2_async_unregister_subdev - unregisters a sub-device to the asynchronous
-- 
2.53.0

