Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046581;
	b=m/uwb4sC1gbJasA9hmj5gkBTh6FdXfxp97xpm+ZRdnIetdynxh1nRDy6+SjbGIltlVrG
	 7H96mSgJLfw+8t5VwdgwqneoVHMvrl9IJwQRlT6IJ6ARL6d6dS/P/kTu+JSN2AHWM8D3/
	 Lt22MN1MPRnAkeGbsgyp9NzNEchQ/1ENpe15O4ZhOJt6BKysKnFPGk3Ht7Oj+3Q35v9uU
	 amnvorTwZmbpp40j7GVDU9P8QUUphwpFR169Rn6L0KSrB66qhUEDEx4mFmSRQH043NK24
	 R65kbZyg47MeIUOib9cQKjIhs7cz6JVkwa+9lqhERI7I1+dvYbP0ktpEBTnueEePLUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046581;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1Iv9n3plIpczFmIxXoj+rOfHG5T/9gh8MwjUCU4bo4o=;
	b=M7FWa8DJBsMgnmiXQgWZlF2BxXV2j9cgl3g2tYkxbWjWWVrQQttE+tSgZcqhbsLuZWhn
	 u8F0CVlawlJjMViif51sg7iAeJcZhVFMTeYBKVppWPLI5Au+Z3IpHTeBXtDPXHdefo4Ub
	 1yERWaHsHumEUog+YWTwRFkuLmxRyF/u2h/HM3bcormwQe2yhcIKd1XCF+cKhIc0vlfD7
	 hKxLkxhM+KN4wK4wpeEyxPGxzeFd1tGLSWmxUgY61ZlZkX0/a/CILjeg2vBFNd+gIylbt
	 CSLJ7yoYKlB77Nx8oyUgX/oLDkKRgYz69tOUC6fCV7Kyg2HYEejhW6oePJmzDbneq4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBVeFW0y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0892D606A331
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBVeFW0y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640001F0089F;
	Sat,  7 Nov 2026 10:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046580;
	bh=1Iv9n3plIpczFmIxXoj+rOfHG5T/9gh8MwjUCU4bo4o=;
	h=From:To:Cc:Subject:Date;
	b=UBVeFW0y10J7DT5sLijLKvQ5NOziYQZyRJTRe0333ZAtmcAq4FUwyE6uB4dpMLj2j
	 ER+7wxrCotsA6mmRa/kYlFnTAbu51VBMFR/b/zkbVddgXqFfCuQvgoXKSKiJef7GVb
	 /qRqOHpogyr3EN2+ABpRsLyigRj6Wk39h4K4+q0lLY2an56dJbbtImcLdSknbtHfCE
	 iOMLlTwSpbyYwDqceDEY8MKlVpVhxUx4yCtviyS53bL8GQe8LJ5eOV63ConfhSonYd
	 odvDywmDrzvym1zbYUwauPAH889nMc2NrtDTKu/EPu2W9VzEpMHgVezLC4cDI+oAzM
	 mAf/+8nBoO4Vg==
From: Sasha Levin <sashal@kernel.org>
To: jia.yao@intel.com,
	gwan-gyeong.mun@intel.com,
	matthew.auld@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/xe/guc_ads: use uncached mapping for UM queue BO" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:16:19 -0500
Message-ID: <20261107051619-failed-6.12-9daa302a8259@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9daa302a82590eeee7bdc68023ddad302df4b88c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051619-failed-6.12-9daa302a8259@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9daa302a82590eeee7bdc68023ddad302df4b88c Mon Sep 17 00:00:00 2001
From: Jia Yao <jia.yao@intel.com>
Date: Tue, 4 Aug 2026 16:50:57 +0000
Subject: [PATCH] drm/xe/guc_ads: use uncached mapping for UM queue BO

On Pre-Xe3p platform, the GAM write the UM queue through DPA using UC.
if GuC reads the queue via GGTT (WB), stale data may be observed
when the cacheline has been polluted by another agent.

To match the GAM's UC writes, configure the GuC mapping as UC as well.

Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
Signed-off-by: Jia Yao <jia.yao@intel.com>
Reviewed by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patch.msgid.link/20260804165057.129529-4-jia.yao@intel.com
---
 drivers/gpu/drm/xe/xe_guc_ads.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index 77429ff4d2a9a..ff8eee3831aa2 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -458,7 +458,8 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
 		u32 um_flags = XE_BO_FLAG_VRAM_IF_DGFX(tile) |
 			       XE_BO_FLAG_GGTT |
 			       XE_BO_FLAG_GGTT_INVALIDATE |
-			       XE_BO_FLAG_PINNED_NORESTORE;
+			       XE_BO_FLAG_PINNED_NORESTORE |
+			       XE_BO_FLAG_NEEDS_UC;
 
 		bo = xe_managed_bo_create_pin_map(xe, tile, um_size, um_flags);
 		if (IS_ERR(bo))
-- 
2.53.0




