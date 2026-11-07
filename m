Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050428;
	b=MT9XrDizIodzoEKQJLBGQ59XTLk+b9JoozSdR5lchsOGVhTxfWEcfQ3aKqDWqHgz7J6t
	 3q5wHOR8sIhmTjjOxekZIE7eKjvdnXYo8mE0aPCd8r+iULmxLvdyfy0Ncz4PRUneD1vKK
	 16ii7ktmC6NFkvJVSDCBCoBJieClCV7ULpjR43DUpnBVyCBOVzuo4nhzvwes50zCxi80c
	 Uep4rWgA789u9dg3TsHzGBgAmfddG/YEtyCDR8tOGluHdJgXXLqRJbYc7xmwXciSfZZNT
	 ++0Eug36UOj6y3dR6BGI5Mq3T/rprUxaOjXiLOxeoUPVifsYEtJo9vliiJmUnGa27ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050428;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XbqbFJun+4M8P/XRlznmSVHHc4WbUtUjiOTV2yce58Q=;
	b=wF0rnjX/1pHF961aG5n65Au6S8Vr8vVaLlrHhjliy5BaVF2dvnomjhQWCeZKVnvNqr/D
	 q9etmAdQqtM4MuirtBgqv7I12USq7ALYaTvUz8fbVZYZadmKYdutl8vkU+LXGfi1w3oGk
	 aji8hgTd/APG378RTTdxaCST8dmu1fo5ySI/c5csuUFpbeD9K0HtzIpR+hyiThMIXhNSV
	 fm5R9S9uhYA1iTvzzNoy3W9Ns0AXcAZgsJWWGR5Z1SapVOLHJgPZIrtZO6nt947YajYHG
	 BaGwbRt+H0KXoBNqt1EG2Yp54ZP8hKagMLdRAcTIJpikyjniAGo1mV1Mt6XDlGnj7AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e5mzHUHM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2743606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e5mzHUHM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CF91F0089F;
	Sat,  7 Nov 2026 11:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050427;
	bh=XbqbFJun+4M8P/XRlznmSVHHc4WbUtUjiOTV2yce58Q=;
	h=From:To:Cc:Subject:Date;
	b=e5mzHUHMSYYriD4kxtvIwo3bgPCePlw4qVesW3vrWFYJCmCTiRQVc6kog9yFFvrH6
	 g7qKR7uiote13hyVgxocIi3i3qE2jxRrJ944tPYhCSvcGQdGy+6HCgSOxAVtOiM4Rv
	 NyB2a6jqTHxd1Ue/+KSXpObVWoYHebYkDcRcH3K1CTapCjCjSxBIKvQzjnYn/3D+I1
	 kUzufT2pQITU5xEspJOTHG+lwN9rgU2TyRtDrItSI9EwijhIrtYJH2CRrAyHEjD1IW
	 e9Gq5EMWQWH3nsooPm3WGmS/j2Ou6z8Qcm/62AZy25T78G1rjC0O9H5XbpDbEQcLaN
	 nmNPstTGzVTsw==
From: Sasha Levin <sashal@kernel.org>
To: jesse.zhang@amd.com,
	christian.koenig@amd.com,
	arunpravin.paneerselvam@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/ttm: return an error when kmapping a BO without pages" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:20:25 -0500
Message-ID: <20261107062025-failed-5.10-fd485d47437b@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x fd485d47437ba1700dd47205a63b9f389a00aa36
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062025-failed-5.10-fd485d47437b@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




