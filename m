Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046583;
	b=Laozvqf6ygDV5VW6cTo+mG6Q/jdlGh9VhIcaaBVA2QkqWAeBbSTTEdlhvpU/boLEwCCb
	 w2CZ7Kixy2XzfHOXPaNJeJ+Z824iv49Swi3OY9jAOcbTfWdd4Dis2wTnRDKEG/DpvYu9J
	 jbNNmK2D1wkSflqRSbWxSb2NwK0owfnU7xhdmSx9wCMIMdBw+5ldiEEiYVGqj3g+0m2EI
	 Aq+rQMElQfQqM6lenL6N2JaEZV/TFGpHIlVF5N1sakkRK4xtv/FviO6DQACzA61P9F7yZ
	 fkkp4qY1f10MnDwSRDKoklR+4YdJhxsAGL9lEqGYjK1wfF3qhI7c8qo2tydKX1HhbuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046583;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=eFKsaJDQB9gTFJyhUEefVYnrBIgAWOKXPUkjrTF/tYM=;
	b=j/gg2pBKj+c/eFun/bbyXiZ083/gy5PyMuj/uKmjUp4zaoOZ+UJKNsEnpFkPUNgE/X3w
	 hwA5qlAgISusFK7UFnO6MT6VrtRDMyiKIDNE8aDrOPONo3UeILaC96MtuuOeOObfoeb9w
	 F/Qutm+EdINQuIElUPCeuFOZJmE1rDvQsyDaxzQsQt2JbL+8wLwFE/qE7y4IQJ1rqz67A
	 hbDCyDvXbsfICO+GT2xSqR1/N1tg7g2ePw1/JlG1tqbSOq4dmkILadI3Xthwtbm+QypXO
	 5/NOJLjamiSJRI47QrjV6ivaz+BKeE9A6j7v21QHZ9mqU8gZ/dnDcXYKLlCTch4xpPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vw1FDuGT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD8D606D803
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vw1FDuGT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9E661F008A4;
	Sat,  7 Nov 2026 10:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046583;
	bh=eFKsaJDQB9gTFJyhUEefVYnrBIgAWOKXPUkjrTF/tYM=;
	h=From:To:Cc:Subject:Date;
	b=Vw1FDuGTGRTTG0wr6LWLY5rxSjBGA5W946XZ5wWFa7vf0ivVVH8CAPc9gxwOui3ix
	 CLO0z3aP3gfTgzDfANBFZmMstU9wft7JUywP+llzOQ4/MF04R7vGKDoUXrhxjsny2x
	 5oq2mpsWgqxxMy7qfdSXXCKxnivUy41Pe7ke0rwtEgvbfkfMTU1khCgKopAKcL4zkY
	 pPZyqfjSU1FEYhbwjExpOkAo/EbR0DpzNWFxmGdQlYzOObh4iIfE/OCbZ3th3y4UMR
	 YZBJQIByD5tgUEQJy9RZSW30Hh9OWzUQOMai5luntEl1t+e8V52mJ8sFi3udmYqnoB
	 o2Rvt6Yl4yK2g==
From: Sasha Levin <sashal@kernel.org>
To: jia.yao@intel.com,
	gwan-gyeong.mun@intel.com,
	matthew.auld@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/xe/guc_ads: allocate UM queues in VRAM on dGFX" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:16:21 -0500
Message-ID: <20261107051621-failed-6.12-ace076ef0a85@kernel.org>
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
git cherry-pick -x ace076ef0a854ab5940bacc539bf66afd61d118c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051621-failed-6.12-ace076ef0a85@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




