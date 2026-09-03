Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0091D477291;
	Thu,  3 Sep 2026 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430092; cv=none; b=kZE5CIAuHZAh88a7Sh/evIQ8uqYc98ihfU5dGvkJ3u4D9T7Vc8FWm5oMcxzf0xoSJiz955K6+monYqzvBFyit0Rk6ZXZn/XG1j3GRnmDyvyAObP38NxmIC26Hwr65yGyxen2Rhs3bcIYeSb5FN8vJiTENzkGNLv/64J3qDG4yUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430092; c=relaxed/simple;
	bh=F7N1V1PomxhMIlIA8KbFRWP5UdjKSTsO0EqRYiyfBDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lay8TPRYmt4ycVYsEW85SATJvAQGy+Q2IupzPJxclktdj0fSqxigll4q1izM+5mxZKTMiDsbChy1HFD7JJOGirHmoJyVlpn+VKzxuUP56PL5917o+fPkkVj+qq4pHwqxquEsjq766+SbqVguxqz5PBNxZGjK8/fFHD3f1DTs7Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M5HVmqiH; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M5HVmqiH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788430087; x=1819966087;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F7N1V1PomxhMIlIA8KbFRWP5UdjKSTsO0EqRYiyfBDM=;
  b=M5HVmqiHhYdTX04mTfomzu4o1Vqn4/ggVQ7o7gcIPN9e3bh3gI/snwEP
   ug6iTOPyLC8ij8BQJ54TK3FivPer+3hNyClqCWKkwPhYj3xgE9+qp7dtg
   dx+d0X5H5MWQyLAR4LlP0ZA/CC01j/ygQJqyP+jrofg6LsnUm8p4NNxl7
   6XWYsxKfXJhFcLpHiP9zn+yNE6AT20NiIs6oL9C6q2uUno81RyTw8WEZB
   4zjzMkJlkEGu5snZRWF5vvOkKup979D0CMbGcpgYnomjCJLApMMDRM39M
   7g1ZR4aRDFiKBne2CUUSvyrATiQWhw4StW4O4ohIm2nzFsAL/oVcIuogr
   w==;
X-CSE-ConnectionGUID: y/tHxHNLRSSAZLwrEO4u2w==
X-CSE-MsgGUID: RDS0PBamQWGfv2FbmujE7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88960020"
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; 
   d="scan'208";a="88960020"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 03:08:05 -0700
X-CSE-ConnectionGUID: 5KGVZcZpR/ej0q4aBQ/Agw==
X-CSE-MsgGUID: Ob0NTpkxRxKBa/LNohzswg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,259,1779174000"; 
   d="scan'208";a="273828705"
Received: from jjgreens-desk24.amr.corp.intel.com (HELO alaakso-desk.kioski) ([10.125.110.157])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 03:08:03 -0700
From: Antti Laakso <antti.laakso@linux.intel.com>
To: linux-media@vger.kernel.org,
	sakari.ailus@linux.intel.com,
	miguel.vadillo@intel.com
Cc: stable@vger.kernel.org
Subject: [PATCH] media: i2c: cvs: Add sensor node in bound callback
Date: Thu,  3 Sep 2026 13:07:53 +0300
Message-ID: <20260903100753.3176233-1-antti.laakso@linux.intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sensor device nodes are created in the complete callback, which is only
called when all devices are successfully registered. If any device fails
to register, e.g. due to a missing driver, the complete callback is
never invoked and sensor nodes are not created.

Create sensor device nodes in the bound callback instead, ensuring they
are available as soon as sensor is bound regardless of other devices
registration status.

Fixes: 8e2b43d2c10b ("media: i2c: cvs: Add driver of Intel Computer Vision Sensing Controller(CVS)")
Cc: stable@vger.kernel.org
Signed-off-by: Antti Laakso <antti.laakso@linux.intel.com>
---
 drivers/media/i2c/cvs/v4l2.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/media/i2c/cvs/v4l2.c b/drivers/media/i2c/cvs/v4l2.c
index 9fadca7a3bee..863112cde266 100644
--- a/drivers/media/i2c/cvs/v4l2.c
+++ b/drivers/media/i2c/cvs/v4l2.c
@@ -13,6 +13,7 @@
 #include <media/v4l2-async.h>
 #include <media/v4l2-common.h>
 #include <media/v4l2-ctrls.h>
+#include <media/v4l2-device.h>
 #include <media/v4l2-event.h>
 #include <media/v4l2-fwnode.h>
 #include <media/v4l2-mc.h>
@@ -400,7 +401,7 @@ static int cvs_csi_notify_bound(struct v4l2_async_notifier *notifier,
 				struct v4l2_async_connection *asc)
 {
 	struct icvs *ctx = notifier_to_csi(notifier);
-	int pad;
+	int pad, ret;
 
 	pad = media_entity_get_fwnode_pad(&sd->entity, asc->match.fwnode,
 					  MEDIA_PAD_FL_SOURCE);
@@ -409,9 +410,13 @@ static int cvs_csi_notify_bound(struct v4l2_async_notifier *notifier,
 
 	ctx->remote = &sd->entity.pads[pad];
 
-	return media_create_pad_link(&sd->entity, pad, &ctx->subdev.entity,
-				     ICVS_CSI_PAD_SINK, MEDIA_LNK_FL_ENABLED |
-				     MEDIA_LNK_FL_IMMUTABLE);
+	ret = media_create_pad_link(&sd->entity, pad, &ctx->subdev.entity,
+				    ICVS_CSI_PAD_SINK, MEDIA_LNK_FL_ENABLED |
+				    MEDIA_LNK_FL_IMMUTABLE);
+	if (ret)
+		return ret;
+
+	return v4l2_device_register_subdev_nodes(sd->v4l2_dev);
 }
 
 /**
-- 
2.55.0

