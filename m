Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D823B95E7
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 14:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026158; cv=none; b=C2xw0K3FbAKLyzydUmK1BaZxQ17iD/+E+BxNVMA+O7X/o5Sh7ZAADrPLPpUg/d3fu/hzZ3CgBPeuwGQNPmrv1smseybN/CFhxm/YrFyanSNZR/6EEAhiWMagt19b+RD/be/RkhjzE/mpBqRFNM1XSCfeyGfwhaU28G1CnE1HkZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026158; c=relaxed/simple;
	bh=oMybLOdbof07bbjevt8vozJZOOAvQlRxqKrEwaM5+gc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kvtAjii+ameVYbl1N2sBY0wz240hiSPMMMxYH3CZO6/UDOhKJm26m1+XCjJH4huU5Wbhhv4WT/PZyVqjYbO6mv7KWfgQXolB3z/C5NMrzF9GolSjdMPFu7gukCdZGELgwVYyTeR6ZXNIPR9ypwdYGc9N3OpD/zUzUzDLpE87k8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGW7wg/e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGW7wg/e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFF01F000E9;
	Thu,  6 Aug 2026 14:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786026157;
	bh=YpvOEtTn0HVjhYFnCmr0zP0Gb1fAZVbNJHPL8TqGSlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HGW7wg/eLHiZ2MyJ+/vtwW5nvAYGQc6abd8cMAbEh9VQME9Xr2mIoxLhOAhXVRLOK
	 x9LDhYW/5iEKZrnFJgiE+T2R4HQ92auliTksyV1ouU8ylRa9glXErxlK1hldVwV5zl
	 8eJNR2n4dtwV1uNEMKDVty9PZEEdFO8gcLbSTUYozEJRWGMWCQ3Q24x8iFubOVvXy9
	 j2+5a9GI2dY21DqzBpyHRMxc2IfIDrVAJn1oaMaYJmgVaXQ69E79oBLV21KEHEtMzd
	 2g7iynQDpBzoBX3FLQA/I4j6rlm7QVmzEG4Iae2jJz4oJ4uvoC4bG0e2ABZUJF6fgl
	 m5Q8/AHlYJ5iw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] media: v4l: async: Set owner for async sub-devices
Date: Thu,  6 Aug 2026 10:22:33 -0400
Message-ID: <20260806142234.786485-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072937-overbill-reflector-662e@gregkh>
References: <2026072937-overbill-reflector-662e@gregkh>
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
index cd9e78c63791b..4ca07fc74cfb6 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -705,7 +705,7 @@ __v4l2_async_notifier_add_i2c_subdev(struct v4l2_async_notifier *notifier,
 }
 EXPORT_SYMBOL_GPL(__v4l2_async_notifier_add_i2c_subdev);
 
-int v4l2_async_register_subdev(struct v4l2_subdev *sd)
+int __v4l2_async_register_subdev(struct v4l2_subdev *sd, struct module *module)
 {
 	struct v4l2_async_notifier *subdev_notifier;
 	struct v4l2_async_notifier *notifier;
@@ -719,6 +719,8 @@ int v4l2_async_register_subdev(struct v4l2_subdev *sd)
 	if (!sd->fwnode && sd->dev)
 		sd->fwnode = dev_fwnode(sd->dev);
 
+	sd->owner = module;
+
 	mutex_lock(&list_lock);
 
 	INIT_LIST_HEAD(&sd->async_list);
@@ -769,9 +771,11 @@ int v4l2_async_register_subdev(struct v4l2_subdev *sd)
 
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
index fa4901162663b..dd8203632f314 100644
--- a/include/media/v4l2-async.h
+++ b/include/media/v4l2-async.h
@@ -283,7 +283,9 @@ void v4l2_async_notifier_cleanup(struct v4l2_async_notifier *notifier);
  *
  * @sd: pointer to &struct v4l2_subdev
  */
-int v4l2_async_register_subdev(struct v4l2_subdev *sd);
+#define v4l2_async_register_subdev(sd) \
+	__v4l2_async_register_subdev(sd, THIS_MODULE)
+int __v4l2_async_register_subdev(struct v4l2_subdev *sd, struct module *module);
 
 /**
  * v4l2_async_register_subdev_sensor - registers a sensor sub-device to the
-- 
2.53.0

