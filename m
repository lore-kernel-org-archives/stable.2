Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410443;
	b=a9PklZOPXKfe3S6NUDs9FpnNByAK0jdn3Hrsl/43A+r3B4hIeBexzK4nTsR2CeNYbSDJ
	 gcU8JMTjw9GGI2MlBZilnvOeqB44lYOZn+xsXwUGNFHkzv0MoVlXL/2PDbbTvrFgLtdkB
	 T5HpZ8Y2fXnrOD8OxMPgJ7pRaadi4BT5d8PdvUVWJIzwnYs2ndQWyw3DnUwwMwaDL9VU6
	 f4tK1NACxECrIRskakx9xh6UMBsxwgRwB0z5FrpZ6tbO9zsSSjS/ABXy+pF0IUR/HxRRp
	 et1iOCeElWUkUeJCYxiI3fDfYX828j55tuvUki0cIqICWubuWYEsatPcHFFl9seii3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410443;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=a5RnG8HqesJ+zD+D1bSONlv6Lwf+6gsZd5wF2JM36x4=;
	b=KP/pt3uPs3CyZFGIpEWUv5kqfUyTrWnrQfUZN6Jh1OTLOIP3AUDRsjTmCZco5udKBwkn
	 V41NZ9aH6/5EzjqrFG1hqyC8pzXYwA0C3Dt6OJ0iAN6U1cHJKVUGnaog4RXqV43UgF6Pm
	 1oJa7Y3QDPBghGhIeJOKy5PFoK7SWxxLkp/9iPhchaeXzoCD/9Lpj6j7hehwMUxl0kLEQ
	 rtU3Zsk1Mi/x+lVyx47Wbu9rp2XMCuPERnu4fi+3HjvcfZBAzNunnjMn6r7FYERj1f4OV
	 jZJ8zNKu1UpakGl7rRIRLIeanIEZuVWmnsD0wXWEWgJfcS0J4pyg0P3BbpabVyzQtqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OxwJT32K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C723606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OxwJT32K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33AC1F00A07;
	Wed, 11 Nov 2026 15:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794410442;
	bh=a5RnG8HqesJ+zD+D1bSONlv6Lwf+6gsZd5wF2JM36x4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OxwJT32KxgMuQ2jdZsIhlofERdn9YK3k79tMxgJR3V1HZGclrGg8LaeOuQTEguF2k
	 V/8fc48G4f02xHUbk99XiZPL/Ye9mavEMM8aJi1nK7ZKr49c0+TK13B5DG6rQ9U+e/
	 WEOXSh1Lbo265dp9Kh5QNqz65z58UTAw/LuS2uemnDjmW4H2t9QffVPCUwld9Umc11
	 Npvoez4ASCAxtN9d+zWkUQIwHfq+r5K24FJMI8guxSSBFCiWk94bYWM9YI3221bYNm
	 v7gnFnAxcQQmp6zl/L7Ld3VSukfKelpmblugWmzk8M5reeGWzUbmwysLBd3rr9/oY3
	 u/4IrRWmHRUfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/ttm: return an error when kmapping a BO without pages
Date: Wed, 11 Nov 2026 10:20:40 -0500
Message-ID: <20261111152017.2588015-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054617-failed-6.1-fd485d47437b@kernel.org>
References: <20261107054617-failed-6.1-fd485d47437b@kernel.org>
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

From: Jesse Zhang <Jesse.Zhang@amd.com>

[ Upstream commit fd485d47437ba1700dd47205a63b9f389a00aa36 ]

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
[ sashal: Applied the return-value documentation changes to header comments instead of comments beside the implementations. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 7 +++++++
 include/drm/ttm/ttm_bo_api.h      | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index 7f97c97b49bd2..02d07f4c29b5c 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -335,6 +335,10 @@ static int ttm_bo_kmap_ttm(struct ttm_buffer_object *bo,
 	if (ret)
 		return ret;
 
+	/* Imported sg tables only come with DMA addresses, no pages to map. */
+	if (!ttm->pages)
+		return -EINVAL;
+
 	if (num_pages == 1 && ttm->caching == ttm_cached &&
 	    !(man->use_tt && (ttm->page_flags & TTM_TT_FLAG_DECRYPTED))) {
 		/*
@@ -455,6 +459,9 @@ int ttm_bo_vmap(struct ttm_buffer_object *bo, struct iosys_map *map)
 		if (ret)
 			return ret;
 
+		if (!ttm->pages)
+			return -EINVAL;
+
 		/*
 		 * We need to use vmap to get the desired page protection
 		 * or to make the buffer object look contiguous.
diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
index 44a538ee5e2a6..7da454640c991 100644
--- a/include/drm/ttm/ttm_bo_api.h
+++ b/include/drm/ttm/ttm_bo_api.h
@@ -360,7 +360,7 @@ static inline void *ttm_kmap_obj_virtual(struct ttm_bo_kmap_obj *map,
  *
  * Returns
  * -ENOMEM: Out of memory.
- * -EINVAL: Invalid range.
+ * -EINVAL: Invalid range or the BO has no pages to map.
  */
 int ttm_bo_kmap(struct ttm_buffer_object *bo, unsigned long start_page,
 		unsigned long num_pages, struct ttm_bo_kmap_obj *map);
@@ -386,7 +386,7 @@ void ttm_bo_kunmap(struct ttm_bo_kmap_obj *map);
  *
  * Returns
  * -ENOMEM: Out of memory.
- * -EINVAL: Invalid range.
+ * -EINVAL: Invalid range or the BO has no pages to map.
  */
 int ttm_bo_vmap(struct ttm_buffer_object *bo, struct iosys_map *map);
 
-- 
2.53.0

