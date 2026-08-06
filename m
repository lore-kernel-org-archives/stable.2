Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78E1CA6B
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786023383; cv=none; b=mFYA64LslsfsHxNPsQv09lj3kUcfdJjD/ObVQUPdiJwOzvXlDVclGo7nk5Qo4pEEOEwMVmPArCkOyRDmkAqGGx0nlmyASm9l86eSilYE6tJgYmBtjo0hqhUNjs9Gq9W5s56LLJTdTCfqxCZQ1T5/DbdFf/UXJfAue04kcedDUFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786023383; c=relaxed/simple;
	bh=DrGULCw5ItIEiGPeKrMi0n3lkrOinUTV9v6LudjQnVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B7GLxu2Bf9nkf/4UZzDXa1BXWrVL7uagMwpXey0DlKH4Ce8U3ugxNsn1aoxz9W2M9F1VKYvOGg4qEcRlDd8uKImdLhyD/HxJy+TJZMqLYVuGVNTcddplNMsGRI1tJvZNmdoJ+hD/XdeChyRn0QSric4KxVslJkXy4lEBmqHxOrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrfHiLs7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrfHiLs7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DDC31F000E9;
	Thu,  6 Aug 2026 13:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786023378;
	bh=nAZuYVVvPj0AmaywVYQ7/CC7z5ELxI4Ms0nFuptRBs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lrfHiLs7UmuvlpLU7LJszaA5NBJ1Hul1tpZ1Tcl2yxVSD66ry1f+alKeqxmhphtP8
	 z+TMm+IygStDdGaf8Wnvdk4yuCB25GwNun0yWtu3eQ0ALEDWe6Yp35BFQhbPlQKbhS
	 mcj9XjRz9EdWAoey9F38SdC6zJF+1d93ML+EY2bnZyB+tBrDVsR7ldrufwSrbxmMGK
	 lA7oDTPnTQO+jtmdBzuY3hLmrRvSL4GVZw6dFl31jWBj0fWNvVwbcidMHRXMheD0h8
	 kZ92e9EcJ3hpClCqD0aQu5IeJn90d8obBf/MycJZxxqzY9w4B48b+x8Va2J3geHF0D
	 3wBobvolY1CgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] media: v4l: async: Set owner for async sub-devices
Date: Thu,  6 Aug 2026 09:36:14 -0400
Message-ID: <20260806133615.470300-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072936-heroism-pelican-745d@gregkh>
References: <2026072936-heroism-pelican-745d@gregkh>
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
index cf2923dea84b3..36df65475dad2 100644
--- a/drivers/media/v4l2-core/v4l2-async.c
+++ b/drivers/media/v4l2-core/v4l2-async.c
@@ -798,7 +798,7 @@ v4l2_async_connection_unique(struct v4l2_subdev *sd)
 }
 EXPORT_SYMBOL_GPL(v4l2_async_connection_unique);
 
-int v4l2_async_register_subdev(struct v4l2_subdev *sd)
+int __v4l2_async_register_subdev(struct v4l2_subdev *sd, struct module *module)
 {
 	struct v4l2_async_notifier *subdev_notifier;
 	struct v4l2_async_notifier *notifier;
@@ -822,6 +822,8 @@ int v4l2_async_register_subdev(struct v4l2_subdev *sd)
 		return -EINVAL;
 	}
 
+	sd->owner = module;
+
 	mutex_lock(&list_lock);
 
 	list_for_each_entry(notifier, &notifier_list, notifier_entry) {
@@ -869,9 +871,11 @@ int v4l2_async_register_subdev(struct v4l2_subdev *sd)
 err_unlock:
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
index 9bd326d311812..f26c323e9c963 100644
--- a/include/media/v4l2-async.h
+++ b/include/media/v4l2-async.h
@@ -310,7 +310,9 @@ void v4l2_async_nf_cleanup(struct v4l2_async_notifier *notifier);
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

