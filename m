Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794384927;
	b=J7aSQ2vPA8Xq4MVzjFHYEs6VXetVJLqe0fVkxeTekdOvOR3q9x3PdZWy1x0jFA1YX8lQ
	 XJsvRN9H8biciBZzmrStkc4ZpnpVGDaUFQ5OgMYtrjs9HySH/8SKsLuexNrK5Gc+lRvD5
	 hULKVsFhpa9nla/de/YnPNjJieJ8rpyEHL1/YLVaOoudn3PVHKrnuMinOhX/6lpvOK+b8
	 gF9W7akjerwxtR3/mrPEirMgZ6nGWjZt567tQeWPlNN8QZAeQR6el9ieN5Hih+SUz4Rbm
	 gYBDP8IDK0bPHO2YfRJ/5E/PgNj63AAbEEl8FNv+cldXGdj7/ehDXYrw977qi9V+teg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384927;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AniNH7vBkjZ81jPIGkygTkY1tLPixcJPXpEKPibhbUU=;
	b=XObiD9qbnBIVcBb5vO4TecJlTGEWTLrhIUOjYd9ugonSFiE3z9fTRR9Xf9st0Annlq71
	 t6M7tt2TX6umX3Uq+huFqwYQ92XRhVEILC2kxLlZdnL7udVL5pQs90dMvJYaB9/V1+DzY
	 N0eEFlRgbESZMc/GGe+w+NVvkGnQ1M03879m/5TfnD4JG5vaDhjN5HmLx2GFVaQZsGNJJ
	 zSlXtnVGgzp4giUDyRaq6lgy5VqCKCqJRe6TwhUo4TTOieHzlEfg8mFbMrsYvrEm0Femj
	 trZILFKw9HAozCCB95qHXFaoDC59fEOS/ZmrjszFH0w2OiEl5YcOk1gacrqCaewUgYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kxcufjRx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBED2606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kxcufjRx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415031F00A05;
	Wed, 11 Nov 2026 08:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794384927;
	bh=AniNH7vBkjZ81jPIGkygTkY1tLPixcJPXpEKPibhbUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kxcufjRxyQMwY9kLU11b1kmAnP4mV1EA1WBVYguiCDZlLLzCiiR0rvSz+antPdxSl
	 sRRWix20y25TA10em5T1MIVqgVdb/BPi2vkeDhs/UKTtgCbQhvb+CdKEKR3mwQl/nt
	 YQhPTb5vpDH5N8njdo4v3Z1qiq5RsdcBU+9F91YqiKXyVSO9tXfL6YAEWATZCdAFO8
	 JIcMBaNkFpP0fFxdiEB6ld5N/2dRubVRza2IGKUdBME4H+vd+mQ3f5DSthOPof0nJc
	 b2cIZL6VVKSLQMmGPS/+tXpZnULD/LN6E9hIgm1CUIkKXtyqkswyusingBPA5FTgUj
	 Bt5opxZGGbIKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Caleb Kan <ckan@cloudflare.com>,
	Matt Fleming <mfleming@cloudflare.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Caleb Kan <calebkan1106@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] stackdepot: stop preallocating after the final pool
Date: Wed, 11 Nov 2026 03:15:25 -0500
Message-ID: <20261111081338.1418886-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052548-failed-6.12-8f56ea8e0706@kernel.org>
References: <20261107052548-failed-6.12-8f56ea8e0706@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Caleb Kan <ckan@cloudflare.com>

[ Upstream commit 8f56ea8e0706d92774603260779c7032f03ef3ac ]

depot_init_pool() decides whether another pool is needed before it
increments pools_num. When it registers the last allowed pool, pools_num
is still one below stack_max_pools, so the existing comparison clears
new_pool.

With new_pool cleared, stack_depot_save_flags() can allocate another
order-2 pool after a lookup miss. depot_keep_new_pool() retains its pointer
in the global new_pool, so the allocation is not lost. However, pools_num
has already reached stack_max_pools, and depot_init_pool() rejects every
attempt to register the pool. It remains allocated and unusable until
reboot. The non-NULL pointer prevents later saves from allocating more
spare pools.

Account for the pool being registered in the limit check so registering
the final pool installs STACK_DEPOT_POISON and prevents the extra
allocation.

Link: https://lore.kernel.org/20261022083330.3159793-1-matt@readmodwrite.com
Fixes: 31639fd6cebd ("stackdepot: use variable size records for non-evictable entries")
Signed-off-by: Caleb Kan <ckan@cloudflare.com>
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc: Caleb Kan <calebkan1106@gmail.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
[ sashal: Used the existing DEPOT_MAX_POOLS constant instead of upstream's stack_max_pools variable. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/stackdepot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 245d5b4166999..1f1d63d21f26b 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -273,7 +273,7 @@ static bool depot_init_pool(void **prealloc)
 	 * NULL; do not reset to NULL if we have reached the maximum number of
 	 * pools.
 	 */
-	if (pools_num < DEPOT_MAX_POOLS)
+	if (pools_num + 1 < DEPOT_MAX_POOLS)
 		WRITE_ONCE(new_pool, NULL);
 	else
 		WRITE_ONCE(new_pool, STACK_DEPOT_POISON);
-- 
2.53.0

