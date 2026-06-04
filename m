Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D5B409104
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570313; cv=none; b=ZpYZKvtD/xcQIHXUbwV21ujZqrrKQJWTGrixRTcGueOCfboh81SW8T3CfjIYBeURY+mzl38SLSfQIjYl6Re/JuqQkv/Qvco4kn8jpWZmrEUj0T5biNy7uwBZpxhhUVNrqXH0I+/gO1jsshPvnAR5N8bl2pMAkP/FNpwGTSoxjVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570313; c=relaxed/simple;
	bh=9e7e84DqHm3vusvTtpCa14bI6FNkRDaSKeF+HA0Uthw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=i6AbLWlG6opnZ8da1hugOg8XXJxYdjcaxCstgkt1OXZO48vWg2B8zz7ukgpBPR2iEV9XA264prDvXc4qRjpIL6W01FFskwXok/6evhtnODR2T/zmDb/62dKOrdCpGyh66DaJssXJduLBx0LLumPIv/iAi6Tg48tmkNKeQkfPuLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bHZct7NR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bHZct7NR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABB31F00898;
	Thu,  4 Jun 2026 10:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780570311;
	bh=fIj+MIb5jrAdsxIs1IVgvAhOLweQONPlKbvyOHlL2KM=;
	h=Subject:To:Cc:From:Date;
	b=bHZct7NRSTlzSDhyeAYRbpMj3u88znN77xUB60srnXb57JQ2PEwroIPYAnoHjtjLp
	 BPxsXPeD73TNTqT9ejAtoU5eEebo+NFPI3Rx53oe3+7hNnsLOI65RyVYnVhcxwD7yg
	 qtAYJw+ptwOue6qADar1QUcsvxAw59Rqps+NatLU=
Subject: FAILED: patch "[PATCH] drm/hyperv: validate resolution_count and fix WIN8 fallback" failed to apply to 5.15-stable tree
To: me@berkoc.com,hamzamahfooz@linux.microsoft.com,mhklinux@outlook.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:50:54 +0200
Message-ID: <2026060454-destitute-bulb-134a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 13d33b9ef67066c77c84273fac5a1d3fde3533d1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060454-destitute-bulb-134a@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 13d33b9ef67066c77c84273fac5a1d3fde3533d1 Mon Sep 17 00:00:00 2001
From: Berkant Koc <me@berkoc.com>
Date: Tue, 19 May 2026 22:08:17 +0200
Subject: [PATCH] drm/hyperv: validate resolution_count and fix WIN8 fallback

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

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index 051ecc526832..c3d0ff229e3d 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -391,8 +391,11 @@ static int hyperv_get_supported_resolution(struct hv_device *hdev)
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
 
@@ -508,9 +511,13 @@ int hyperv_connect_vsp(struct hv_device *hdev)
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

