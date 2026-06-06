Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79721917CD
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 02:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780712345; cv=none; b=AUA3hV3Dwt6IvwhVur99MJc2w1OGpKIXZFoGkO0+wRkh1fP3fw7Dw0MwxrtDwrq+HWEziDp8mYyAKRYHgZz385JMcJb5xnxxKtUr4QJIvT6L/K11C3uXmUDZl6EQHFBgr1BzFh6nxydvJMarbHE1FSIhnqzRv83/458N1RDTLLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780712345; c=relaxed/simple;
	bh=w7+6ZO6LXsnxH/ko9T9GsLQIw/kCT2TRzKeSDJhtcr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j6YTdLm4l4fDZ5EEQgoIZkIbnjdqq/aF3ZU0pwwi4IMCpzfJTMBNvZ6yEFB9Ti9rjkzNoVpw3tVVhW/gLZsG4OWSQxEwNzmG72BLQ09lPDmy9JOE0iSSRRgSd2SoBPqAV8K3xCtLPgUUYIN4UuTLuv+jXUFJ98veC50ecw5u3xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJLHQi+q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJLHQi+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369E71F00898;
	Sat,  6 Jun 2026 02:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780712344;
	bh=GI17eMV66eEz9AzMW84+S9V3lUjCSqimFRVGMMVGTSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PJLHQi+qMaLaUuMC7IKyx+/mvBL0HmtGXJQGYskziKSYsqN7bX0Pzl3mq6gJqjicj
	 4oIMUwc26FKKMTp/v1xrMnZyX+xQ2esBbdD/djBMMLUNYQhoOTrTEH9FMbMDMALE+A
	 CdPrQ9N643BWxGu8UDGN9rMnxKgnyHi6G+6DvbtZG/uV/wuSOnigMlb9Gk/sb2ZkuN
	 s2sPlwvlPTK7cSGeJ6MXq3xK8m+xP8t8BJnshO831B7xnWjhFfS8Ffyphotl8EZvyy
	 3VpozwokzWibzBIaxqOepo9jslUMoQ78AYMayiU9oS7rx9RJZzGBjizgLIzjaAIgIW
	 8zV7I3gQQrL8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Berkant Koc <me@berkoc.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] drm/hyperv: validate resolution_count and fix WIN8 fallback
Date: Fri,  5 Jun 2026 22:19:01 -0400
Message-ID: <20260606021901.2488724-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606021901.2488724-1-sashal@kernel.org>
References: <2026060454-destitute-bulb-134a@gregkh>
 <20260606021901.2488724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Berkant Koc <me@berkoc.com>

[ Upstream commit 13d33b9ef67066c77c84273fac5a1d3fde3533d1 ]

A SYNTHVID_RESOLUTION_RESPONSE with resolution_count > 64 walks past
the supported_resolution[SYNTHVID_MAX_RESOLUTION_COUNT] array in the
parse loop. Bound resolution_count against the array size, folded
into the existing zero-check.

When the WIN10 resolution probe fails, the caller in
hyperv_connect_vsp() left hv->screen_*_max / preferred_* unpopulated,
which sets mode_config.max_width / max_height to 0 and makes
drm_internal_framebuffer_create() reject every userspace framebuffer
with -EINVAL. The pre-WIN10 branch had the same gap for
preferred_width / preferred_height. Use a single post-probe fallback
guarded by screen_width_max == 0 so both paths converge on the WIN8
defaults.

Signed-off-by: Berkant Koc <me@berkoc.com>
Assisted-by: Claude:claude-opus-4-7 berkoc-pipeline
Fixes: 76c56a5affeb ("drm/hyperv: Add DRM driver for hyperv synthetic video device")
Cc: stable@vger.kernel.org # 5.14+
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Link: https://patch.msgid.link/6945b22419c7d404b4954a113de2ac9c900dba93.1779542874.git.me@berkoc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index 76a182a9a76547..68def142491a09 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -396,8 +396,11 @@ static int hyperv_get_supported_resolution(struct hv_device *hdev)
 		return -ETIMEDOUT;
 	}
 
-	if (msg->resolution_resp.resolution_count == 0) {
-		drm_err(dev, "No supported resolutions\n");
+	if (msg->resolution_resp.resolution_count == 0 ||
+	    msg->resolution_resp.resolution_count >
+	    SYNTHVID_MAX_RESOLUTION_COUNT) {
+		drm_err(dev, "Invalid resolution count: %d\n",
+			msg->resolution_resp.resolution_count);
 		return -ENODEV;
 	}
 
@@ -513,9 +516,13 @@ int hyperv_connect_vsp(struct hv_device *hdev)
 		ret = hyperv_get_supported_resolution(hdev);
 		if (ret)
 			drm_err(dev, "Failed to get supported resolution from host, use default\n");
-	} else {
+	}
+
+	if (!hv->screen_width_max) {
 		hv->screen_width_max = SYNTHVID_WIDTH_WIN8;
 		hv->screen_height_max = SYNTHVID_HEIGHT_WIN8;
+		hv->preferred_width = SYNTHVID_WIDTH_WIN8;
+		hv->preferred_height = SYNTHVID_HEIGHT_WIN8;
 	}
 
 	hv->mmio_megabytes = hdev->channel->offermsg.offer.mmio_megabytes;
-- 
2.53.0

