Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045762;
	b=pax2IuVQOI5WaoknXfn6fJ2tksJaggv1PkTVpYiqfVfPTA7nSF3IXT09Cq0ZSoxPQVEd
	 eQ7K8TXvV9wvNkK71rcSPhnOpW2qMcvHXJ2/AFSAjjawDePHYdRM/o520hkgGodSRHMK+
	 PdGX1M2Ig61VAQCakuKBHyhiLhxLdkC7CrExRjxp6Ht2UMzMQmSaL2z2/RRTKacw8p5b6
	 jlzQMHRrVSoPIc9JvvZlrBLSt6y5xj1zHb8KxnbSfDFWJOJ8t2AQIaqdmzTOIjxSOHJFF
	 jRxqNfeiPuVv+2xvCbguw4ZE4/1hQKoNKHLJID645OP0YsTVUHB2FpNYj5fv5RP7yRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045762;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=oaA2Apj022opC+sBLotOeWDRJHe782U/OKSUO7MnIOw=;
	b=3eAbxkyScb/z+E+ps8Sw2aIcYEPx0pNY+rzvWmQTcf2KxpBN5ojCr5uS+Ayh04/cer8S
	 owyH7I67we7nk+8kBQxfXQsohEP5Ngk+ptO58Ti1Jdb71pmB7mHmOLqAqZRHKT1AGSiDB
	 W1gT8OwEBGp4prSPfiNIAvRw+87frGi2wqmQ3aN7YGgvp0HjeM6Uy3EPg6z6uEnzle/vD
	 /POa/r83va7WH+nU6TEAZWl2hZNUPlWbGkFGN7ueyVN4mRsF5M5ONkKAB6bzyU9mIeJRE
	 xqCbvajPsP4qehEd3u+GX+8lMnyoEQphpKRIPD8joaW6p9D54FNAiCLFlyHqjwiXg/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mIossZ/1";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA86606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIossZ/1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752501F0089F;
	Sat,  7 Nov 2026 10:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045762;
	bh=oaA2Apj022opC+sBLotOeWDRJHe782U/OKSUO7MnIOw=;
	h=From:To:Cc:Subject:Date;
	b=mIossZ/1mBRh5iJ0M7BF3Ev7RJ7XditPW+CMbkci1qsRm/EBozLPabPc7Hsn1IMlf
	 D1pCxSB/tZEbkVkmqF0/ExnGYJpZO1055LW5DRdPRpU4y8NQQw5KgzRLOh9nWUZFza
	 2JHCyENoWjFe2dp2hii3TwkO7MahlOy5Ie4XN7sXwLtMAJrfbYEDoxWXibq8PBUH21
	 pAstMySdnix0v7ioiv+IEdCtCoBIiUVklavOFLYUtkClQBB1C2DWZueLl3htUPQTIt
	 Bw02ATBByT8HW2mTHHf3efd2gfP7yB8dMjUocHQ0lZkecVUM92fWLQhjKKp4fd9th9
	 qpj26xKfmCLtg==
From: Sasha Levin <sashal@kernel.org>
To: jia.yao@intel.com,
	gwan-gyeong.mun@intel.com,
	matthew.auld@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/xe/guc_ads: allocate UM queues in VRAM on dGFX" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:02:40 -0500
Message-ID: <20261107050240-failed-7.3-ace076ef0a85@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x ace076ef0a854ab5940bacc539bf66afd61d118c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050240-failed-7.3-ace076ef0a85@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ace076ef0a854ab5940bacc539bf66afd61d118c Mon Sep 17 00:00:00 2001
From: Jia Yao <jia.yao@intel.com>
Date: Tue, 4 Aug 2026 16:50:56 +0000
Subject: [PATCH] drm/xe/guc_ads: allocate UM queues in VRAM on dGFX

On iGPU, the UM queue BO is allocated in system memory. On dGFX, the BO
was previously created in system memory and later reallocated in
xe_guc_realloc_post_hwconfig().  Allocate the UM queue BO directly in
VRAM on dGFX, where it is ultimately required.

Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
Signed-off-by: Jia Yao <jia.yao@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patch.msgid.link/20260804165057.129529-3-jia.yao@intel.com
---
 drivers/gpu/drm/xe/xe_guc.c     | 6 ------
 drivers/gpu/drm/xe/xe_guc_ads.c | 8 +++++---
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
index 4f132bf8539da..4286bd05c6861 100644
--- a/drivers/gpu/drm/xe/xe_guc.c
+++ b/drivers/gpu/drm/xe/xe_guc.c
@@ -732,12 +732,6 @@ static int xe_guc_realloc_post_hwconfig(struct xe_guc *guc)
 	if (ret)
 		return ret;
 
-	if (guc->ads.um_queue_bo) {
-		ret = xe_managed_bo_reinit_in_vram(xe, tile, &guc->ads.um_queue_bo);
-		if (ret)
-			return ret;
-	}
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index f8c679cef0039..77429ff4d2a9a 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -445,15 +445,17 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
 		/*
 		 * Allocate a separate BO for the HW fault ring (UM queues).
 		 *
-		 * Round the size up to the next power of two so that
+		 * Round the size up to the next power of two so that on iGPU
 		 * (system memory, no IOMMU) the TTM pool issues a single
 		 * alloc_pages(order=N) call, maximising the chance of getting
 		 * a physically contiguous block.  GuC requires contiguous DPA.
 		 */
-		size_t um_size = roundup_pow_of_two(GUC_UM_QUEUE_SIZE *
+		size_t um_size = IS_DGFX(xe) ?
+				 GUC_UM_QUEUE_SIZE * GUC_UM_HW_QUEUE_MAX :
+				 roundup_pow_of_two(GUC_UM_QUEUE_SIZE *
 						    GUC_UM_HW_QUEUE_MAX);
 
-		u32 um_flags = XE_BO_FLAG_SYSTEM |
+		u32 um_flags = XE_BO_FLAG_VRAM_IF_DGFX(tile) |
 			       XE_BO_FLAG_GGTT |
 			       XE_BO_FLAG_GGTT_INVALIDATE |
 			       XE_BO_FLAG_PINNED_NORESTORE;
-- 
2.53.0




