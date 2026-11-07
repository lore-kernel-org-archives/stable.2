Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048380;
	b=hAKnmzuxDGzsQNlAamouNTP1MdknWLRc27zUWow+xp9oz5ohaSYuqdILW5GllIZmD22k
	 xU0LWACfYhbzTi4DCSbfIOsrmP06MJPNBezwQuu3bl9lg2s9wZSRRbbVLbRbGACakWrMW
	 DFbVC8Jvw899KXy9ylRLIyH2moE8FHDItCaZ6SgLmBtpVxFukJ7q2EdK6uPiMIGiWI5Ft
	 BbGfhXA8H1XQZllwGbQToQV8JXBM8WRgCC1ZapP+shqzXctSLFovcsYreEeGHektH5a+y
	 GiN8LHDtlULsPoOUKrTYB3yB9boDkyyvr1TE5HLvYoSnxjN/hjyzxVwpPhcVBar8r5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048380;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Om/PMZppHyZlUoSVY1KwU2Uqa5p7xLaexa63JcfnGT4=;
	b=ycx6ovKqRcOcdx5vQWx7xML0KQmR33HRjYYeBQYrSL7Ln0rkZ/GO3WZJ1QZoPhK/Mf5t
	 GB7J6RJnLjAEUtsoPltQTJKl3b20sC5ZBKBrIqUz85fL7stZocQpeFadovUwYr36yuLsV
	 prDGyX8OFL2wvfx1ykeU0FaItmOJGRc/p3ueqJoRp3WFptxUfBDidJg7PTshHJkaml0Kk
	 HCin/AN0lNuh0G7/eIBVg2YpNM33wGBDmEWksctnIMbM9ezmSCz0IoM0Ap8H12FLX/Ii2
	 g0lz+h4hIZebYOOGKGSLsLMuiC/Z0/fz2xBKdfZ2DbpmGcBEN6dCgoho9zvjkPXxExg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OLZw0N5Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07398606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OLZw0N5Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA4A1F0089F;
	Sat,  7 Nov 2026 10:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048379;
	bh=Om/PMZppHyZlUoSVY1KwU2Uqa5p7xLaexa63JcfnGT4=;
	h=From:To:Cc:Subject:Date;
	b=OLZw0N5YZRQE6y4+85PcG0CuvsLzwdRVH5HV8uFN15ciyf8AMy/rWHnafjjvUXY9I
	 EtYws/CmKgrzKWT0dhlXjjh7Ey5jwBulF6pjWFjJPAtq1m4ePnCW1D4PNgPAxe08+p
	 E9ctMi9IBKsyXkxZPR1WTKluEw3ywAifO3JgXsnFZ+XYqTIY1rxM5T85UysjWH5Qo4
	 +oJVGPv33ZYSS8kYe4AymbrUjKWYPXAVekARjCtrnlr5rt8sTS/Om5GRvnxbXi9z4w
	 dQtRQbP4l87bhMqgmoemV3rL+jJ7OIxHaPvBUYbcy6t/bTsgHun95RynjzaNhbbUAv
	 J9GGfp2RPFdKQ==
From: Sasha Levin <sashal@kernel.org>
To: jesse.zhang@amd.com,
	christian.koenig@amd.com,
	arunpravin.paneerselvam@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/ttm: return an error when kmapping a BO without pages" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:46:18 -0500
Message-ID: <20261107054617-failed-6.1-fd485d47437b@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x fd485d47437ba1700dd47205a63b9f389a00aa36
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054617-failed-6.1-fd485d47437b@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From fd485d47437ba1700dd47205a63b9f389a00aa36 Mon Sep 17 00:00:00 2001
From: Jesse Zhang <Jesse.Zhang@amd.com>
Date: Fri, 9 Oct 2026 18:33:39 +0800
Subject: [PATCH] drm/ttm: return an error when kmapping a BO without pages
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ttm_tt objects for imported sg tables (ttm_bo_type_sg, set up by
ttm_sg_tt_init() with TTM_TT_FLAG_EXTERNAL) only have DMA addresses and
no pages array. ttm_bo_kmap() and ttm_bo_vmap() still dereference
ttm->pages for them, so a driver that tries to CPU map such a BO oopses
instead of getting an error:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:ttm_bo_kmap+0x26c/0x300 [ttm]
  Call Trace:
   amdgpu_bo_kmap+0x89/0xb0 [amdgpu]
   amdgpu_userq_fence_read_wptr+0x116/0x170 [amdgpu]
   amdgpu_userq_signal_ioctl+0x3fe/0xbb0 [amdgpu]

Return -EINVAL in that case, like ttm_bo_kmap_try_from_panic() already
checks for a missing pages array.

Fixes: 75a57669cbc8 ("drm/ttm: add ttm_sg_tt_init")
Cc: stable@vger.kernel.org
Suggested-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Link: https://patch.msgid.link/20261009103419.4122940-1-Jesse.Zhang@amd.com
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index bd0b23ac2cc4b..f9458a4d5a09d 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -356,6 +356,10 @@ static int ttm_bo_kmap_ttm(struct ttm_buffer_object *bo,
 	if (ret)
 		return ret;
 
+	/* Imported sg tables only come with DMA addresses, no pages to map. */
+	if (!ttm->pages)
+		return -EINVAL;
+
 	if (num_pages == 1 && ttm->caching == ttm_cached &&
 	    !(man->use_tt && (ttm->page_flags & TTM_TT_FLAG_DECRYPTED))) {
 		/*
@@ -419,7 +423,7 @@ EXPORT_SYMBOL(ttm_bo_kmap_try_from_panic);
  *
  * Returns
  * -ENOMEM: Out of memory.
- * -EINVAL: Invalid range.
+ * -EINVAL: Invalid range or the BO has no pages to map.
  */
 int ttm_bo_kmap(struct ttm_buffer_object *bo,
 		unsigned long start_page, unsigned long num_pages,
@@ -493,7 +497,7 @@ EXPORT_SYMBOL(ttm_bo_kunmap);
  *
  * Returns
  * -ENOMEM: Out of memory.
- * -EINVAL: Invalid range.
+ * -EINVAL: Invalid range or the BO has no pages to map.
  */
 int ttm_bo_vmap(struct ttm_buffer_object *bo, struct iosys_map *map)
 {
@@ -537,6 +541,9 @@ int ttm_bo_vmap(struct ttm_buffer_object *bo, struct iosys_map *map)
 		if (ret)
 			return ret;
 
+		if (!ttm->pages)
+			return -EINVAL;
+
 		/*
 		 * We need to use vmap to get the desired page protection
 		 * or to make the buffer object look contiguous.
-- 
2.53.0




