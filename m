Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049431;
	b=Ui9COSmXr7EDItBKxj3Drkct3Uw/nlusDT0cJi/ZWq6JR4OopLxXf/edOvrw0SIz3WKH
	 xjBcFJ5WEXv8C1af7XxbCYZUDD2tXfIijY7W5AlLY/rrYL+qp7I0jta4c5jHf+6SNgooS
	 31VZLdtPeGqSLRrjlqJnx4fgSjZiIG8PQMfI/NF5bYwJsm8WE9X3EmrHf69r8EUNcnjNG
	 6MVEqhEeaVbSCicTiQLfl2nOxH/w+e8mDPtKJ8hdGxrtC0mdr45K+/VhRBdVNPO3TNdcg
	 cLtsOUu0pxoKIvA9ajgNkuZD8G8wYHdgXt6CUSCTFef/FU/A5HOO3DP+XEaWSaOJWfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049431;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gLIaKGXkg1YH+d+gvBLL66gK9eh/EaErc0CM6SmFq18=;
	b=I51DxkCwEMyoB2539gdnQ5uDb16sJ2jNGS4hYtfZtQceIYLgqFTRnY6ZIMYeY9mPb7p/
	 25Z63PPSBsSRmTCKnQScCD/wurEnyXUXnNa/0BZlv03Zr53jhG1kpApQV03+xVY+Q53mK
	 /7Ej4tn7Ei27BXxs0dIVqr2SPnr247wY8x0Hu8iT4X8By4zv2Gw+qJQrkpYuW9KlFt5h2
	 DYveIq6jYEfAgDrBjzLv0zifu/36gOKhSFQJlbpsPcXgiFZAtpChsfsyLIo/J0FF+c59g
	 27mSb3XBgqi9Fcrpr8clCZSmpofAAl3d10oCUhw6HzEl0jYUkvdabKQjl98sW9xSx7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=clu4l3ze;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3C9606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=clu4l3ze
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E6A1F0089F;
	Sat,  7 Nov 2026 11:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049431;
	bh=gLIaKGXkg1YH+d+gvBLL66gK9eh/EaErc0CM6SmFq18=;
	h=From:To:Cc:Subject:Date;
	b=clu4l3ze9QuDjfauUEE1D6hoUHO2y3y7Y2GTmGKFnVDNJJOajUbvORXX/2t4LH5qu
	 gXjz4a1Q4pc+9ASZAqd48KNR4NbaveKXKKvnODLGafHj+Ydt/nIbKVZRACqM2lDwxG
	 bLsT+vVkb0Ddfz8PEaUfgJv8seo7m73zVHiiOvMrR5m8qjEcb3YgAXrnqftsGdniz4
	 TnKDIRe8L+sjLsUniStgApDTyKaSd+O03Yf7WVZPrGlQOj5P//+4SVcXw0KAtiAdae
	 /ziBEDF2/U+nP9dmfVtdTsc66RLFgmIdcvCGWW4DYbMCUgdbfcehShegzqCI1FzVtN
	 qzAM/KcFqO77w==
From: Sasha Levin <sashal@kernel.org>
To: jesse.zhang@amd.com,
	christian.koenig@amd.com,
	arunpravin.paneerselvam@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/ttm: return an error when kmapping a BO without pages" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:03:49 -0500
Message-ID: <20261107060349-failed-5.15-fd485d47437b@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x fd485d47437ba1700dd47205a63b9f389a00aa36
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060349-failed-5.15-fd485d47437b@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




