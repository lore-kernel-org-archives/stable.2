Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792490774;
	b=grJOQfaalMEIga/Pfj0jMsJWveE8abDt6+bJO6vFQRic+0szEsRU0oHBlU8R3oejdfWK
	 HVhRgzfkl8CWedTQDekFdy2xcl/CfcpwfgiceOq36gJzmWppHTrr/dWmF1CWwsteeup64
	 4JX5GRLb1+wvAAIVPt2dxIHqqBwEuurFGoALhP0SSwhlMuPb8i8LBwTPc7dJoIdRPw03V
	 i3g1Rfh8CdkYhZPhySA/l1+m2I/KhgxU4YueRNctADfIJtpm5BDaVRh9W4oV0GWXgECKS
	 b7lLGRxsXGQLxuqQAYyrqIcauLkGKQuE1tNTDWXUFAbt5UJIXPC3VoMmiirZGqfeJOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792490774;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=iRxSR+4fRQLej6TOIvAsY+nQOj/Ngzq1621z8+mGblo=;
	b=eAwmi70cemwnpbU8RMHVOss9nh+/kIoOSzfF+uuxrzzv5NdS3pJ0PH85ZrLVySKQjD3w
	 3WnOP4oUrH7v7oHsJBn0r8+AlXUcXwfyfo9CC0iBRFbqXfh4f5oiL4ghCn5flY/AiLbFh
	 9PXsQNj8p0f+YDVIew2r0NvhV4Hu+g9YpNWHOJk/TX6RG7HNxD0NGwQa63tiqPzRBH7XB
	 zX2XCM1IilSYzeXj6nZL5dvQiID2zHS84mrlEyTNdTvXaLLqJw9pm2SYAVqlGU/90qnBt
	 QhBcXjpX912/Ey7j4R1wMwc3GbXrW7Yuhhwn60g7KwmbIMA6QRI+LXTG9eT7q2yLKFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bAaYOIPO;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B12B606A31B
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 10:06:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B12B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bAaYOIPO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792490774; x=1824026774;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P9qmvMICNbNzcg0hoAKj6GtNRTe3bKBCLMXFRMhWMBU=;
  b=bAaYOIPOmnsP61G0QIxzTlozVB0iwb2v7O9sWdaQdeYSP5cpMxVTd7N0
   8M6YwLkktlWPmkqzggPhLEylHqavqWdWez9x3fea4og7t/ZlIoJDYrQoB
   ibn5qiXqzVKaXS/AdaulgD5wDU5/vzcwrKZ1KvebuxJ3vKUOL8meh160X
   J4zqYzOcXJkelZvxbVomPShmCQON+ReeZXzTbPCfgiQ4flGTi3SxqOadU
   mt27KIg1WtOIS+8RzCknjhnyROgKBGHAYJ17QTEis1H1x1MlOuRXulLFL
   NfUe/1CW/zQagxWyiaRgE1T2jFhMnFPIGJOFk3OFgl1GO/RIy7xVSDe5u
   w==;
X-CSE-ConnectionGUID: pyh6MzdiRoWbWBplj7AhGg==
X-CSE-MsgGUID: GS6JzRUTSUKy42y5FpDbUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1291786"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1291786"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 03:06:13 -0700
X-CSE-ConnectionGUID: Dyc/mZz9Tse5HK/Fa3xHDw==
X-CSE-MsgGUID: XbZ8EXV3QxKXg1Zf6xyCnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="3179357"
Received: from abityuts-desk1.ger.corp.intel.com (HELO fedora) ([10.245.244.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 03:06:11 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: Don't fail runtime suspend permanently on VRAM eviction -ENOMEM
Date: Tue, 20 Oct 2026 12:05:45 +0200
Message-ID: <20261020100545.46715-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If evicting VRAM to system memory fails with -ENOMEM during runtime
suspend to D3cold, the error is returned to the runtime PM core.
Runtime PM treats any error other than -EAGAIN or -EBUSY from the
->runtime_suspend() callback as fatal, records it in
dev->power.runtime_error, and refuses further runtime PM operations
on the device until the error is cleared.

Memory shortage is a transient condition, and with eviction now using
__GFP_RETRY_MAYFAIL it is also more likely to occur. Convert -ENOMEM
from the eviction to -EAGAIN so that the device stays active and
runtime suspend is retried at a later idle transition.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-xe@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.8+
Assisted-by: LLM
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_pm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_pm.c b/drivers/gpu/drm/xe/xe_pm.c
index daa7ba2df317..9bf57ed1ea59 100644
--- a/drivers/gpu/drm/xe/xe_pm.c
+++ b/drivers/gpu/drm/xe/xe_pm.c
@@ -649,8 +649,16 @@ int xe_pm_runtime_suspend(struct xe_device *xe)
 
 	if (xe->d3cold.allowed) {
 		err = xe_bo_evict_all(xe);
-		if (err)
+		if (err) {
+			/*
+			 * Runtime PM treats errors other than -EAGAIN and
+			 * -EBUSY as fatal, so report memory shortage as
+			 * transient to allow a later retry.
+			 */
+			if (err == -ENOMEM)
+				err = -EAGAIN;
 			goto out_resume;
+		}
 	}
 
 	for_each_gt(gt, xe, id) {
-- 
2.56.0

