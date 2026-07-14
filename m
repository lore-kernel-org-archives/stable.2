Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F983F9F4C
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 08:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016949; cv=none; b=UPBQtfnuKKWIRFSReA7OFNTSWjfDCnovQMEDEWjPMyuEqk/fx0Od3ErHQhHOmBzM7G16J46LBVQUFaOKWzblOYB0hNn+YgXP+r0RjLe94B15pd6sYLahqYfYJ57r6VUR27yegwpdUXdmXa0WiC29hxi+PfAMl7xQW5tpkrytqVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016949; c=relaxed/simple;
	bh=RmrTguKVjxq+QIse/ROJuq25wzI7h7cDgXR48/b+tIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JBaHxGVrmDy13GSmH3BTI2Xc6EalN6cuIpDU3G6AIppfhnzBjzkOO2oZDdGEMC8pcAnBasurOeqFZJS5QqZe+ifhXOv6YhrRvjPrfbM7XTgAQSyucQEANhU96r2S51cpmWcvaKR7auVTygKNKZtaStt1k6e9sVU/jDy/0NKW+yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYcg1Nli; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYcg1Nli"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3811f512167so4732064a91.3
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 01:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784016945; x=1784621745; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5f2zwwfkcjVdLU+tnkGLj6NeYVD1qAWbI5zgmwCL7z4=;
        b=aYcg1NlidWx54BwKndl7c8L4xz4iLrhwunPLNe3R9TeGkbqXGXEavAtd7JnBfl9Dgy
         vw4aR6g2vk++G2E7mlI4oSnXNUFD4Eh1d+36aTH7zG7E7aI2+fRuGxb9eftQRZhfPyXc
         uyP6SIvPONuQ+6TWAb/4JD3AINyyh0Re9t5EdGBq5SUZQoE/QeW38PkhrDCeE8ENGolY
         zHFVz9dXWgVfOcBTrbTEIdu0CYWXkKEqGuwmOEbAwZCjm/mmsBNztRwYMma32kj0IV8T
         PHNQFpig2soLJ4T0UHQkwyuv+gvDGmQ2iCPxaMpMwweMWSArbtoFzZZ9v8EUn0mDqeP0
         bKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784016945; x=1784621745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5f2zwwfkcjVdLU+tnkGLj6NeYVD1qAWbI5zgmwCL7z4=;
        b=cjRUm6/ZFkaYMdLUbvZJQDQYzpnTIZczsgt7UroROoH4KRXrmljtUePUhvaGJ8zRQW
         gydzbugEAR6TkHiyXG1HkTUofu/Nz4rWJpJyzKbeId4TCNFcAJt0R34nCJfiLRVdU1Xe
         34Ra2oPGvhj9wz7glftqFitAxmHegAWSSxkKDHjDFnnttgWOqieuH66TpcOVzkaY6gBn
         itlF4vMwlV+MJNC0yRciCx1xp9Bv7vf124R3pY0oHh68SDKnTpretxpIIo5QCXbZQzMS
         BG1euXfdYxUbqX4p6QkpKpU9aQ4INSCk5m66h8WjSQAXF1MmaEVJwFBKkOaCUd6rJ2jw
         Upfg==
X-Forwarded-Encrypted: i=1; AHgh+RoZSWCUPTYBNUTERgMTI2tXCrhNte7873div+PTJp5NQe3j5idAhXyw1081IdwHHXu+mI2x2bA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8kz+TqezJKVHtQM1YfNDr7KHSEWUfGyffIMp7rM+/VYAdR/2m
	By3IyRt3MSr+lWeiDLnrEF18V9k5MEoh+YkDZKhnIHSuG+LiZrM2BaaN
X-Gm-Gg: AfdE7cn8jEfybKdrAB91B3lAKoVdWi7VwpIQ21SMgjSqvz+fGONdvJ/7Ae1uzn0VzS3
	VjKyPFukKrXjZSOk/69Vk9DNVme4Mxly2bFlRmlasmElk8AS/G4haQI3OJoE5FIsSGd68M/H/pA
	g2MFv4GLXIcVQ0MvbizoqANLxkTXkKk169VkFy/DCWW1p7volAWlhktesB5aQrZxMk6qw2SzjTf
	1W1fExdjUW1G+c8rH+A/ToGLUqYe2L6IKEm3J1P38dWfo3Jn34moeV3kYl/n8xQgzCpdNXQfq5F
	W3pB6jpL19TuTzkjgCwtwZnGKANok6QP8W3n2ofVHmGVJGg9qhkC22RnyvYTkI+swblv3syL1um
	ebmg+Df2x7zjwYPlfrYNAGbgGycq4oEQK/kQ8tL0oJMAOyMOth81G2VPwNqAX7/liKN2DWC+lVB
	D/ZwnFnpwhlD2VpWob5LtSnariN9+9YpI5brptnW7a9OF0AR2sU0I=
X-Received: by 2002:a17:90b:4a90:b0:37f:d262:1e0a with SMTP id 98e67ed59e1d1-38e1ae9fc51mr1541369a91.12.1784016944718;
        Tue, 14 Jul 2026 01:15:44 -0700 (PDT)
Received: from localhost.localdomain ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e17443f4fsm1091008a91.11.2026.07.14.01.15.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Jul 2026 01:15:44 -0700 (PDT)
From: Hao Jia <jiahao.kernel@gmail.com>
To: akpm@linux-foundation.org,
	tj@kernel.org,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	mhocko@kernel.org,
	yosry@kernel.org,
	mkoutny@suse.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Hao Jia <jiahao1@lixiang.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] mm/zswap: Fix global shrinker when memory cgroup is disabled
Date: Tue, 14 Jul 2026 16:15:09 +0800
Message-Id: <20260714081510.16895-2-jiahao.kernel@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260714081510.16895-1-jiahao.kernel@gmail.com>
References: <20260714081510.16895-1-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hao Jia <jiahao1@lixiang.com>

When memory cgroup is disabled, mem_cgroup_iter() always returns NULL.
Therefore, the global shrinker shrink_worker() always takes the !memcg
branch. After MAX_RECLAIM_RETRIES empty walks, the worker simply gives up,
so it fails to write back anything.

Therefore, when memory cgroup is disabled, fall through with the !memcg
branch and shrink the root memcg directly.

With memcg disabled, shrink_memcg() only returns -ENOENT when the root
LRU is empty, which means the total pages are already below thr. The
loop then safely bails out via the zswap_total_pages() <= thr check.
For any other return value from shrink_memcg(), the loop is guaranteed
to terminate, either after MAX_RECLAIM_RETRIES failures or once the
threshold is met.

Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
Cc: stable@vger.kernel.org
Suggested-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Yosry Ahmed <yosry@kernel.org>
Reported-by: Yosry Ahmed <yosry@kernel.org>
Closes: https://lore.kernel.org/all/CAO9r8zPVzMKFbCixxD-qgtRrkFxWVrHiZZeLc=eyTPKPVQgX4g@mail.gmail.com
Signed-off-by: Hao Jia <jiahao1@lixiang.com>
---
 mm/zswap.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index b5a17ea20237..3d697a1a5365 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1356,11 +1356,12 @@ static void shrink_worker(struct work_struct *w)
 		} while (memcg && !mem_cgroup_tryget_online(memcg));
 		spin_unlock(&zswap_shrink_lock);
 
-		if (!memcg) {
-			/*
-			 * Continue shrinking without incrementing failures if
-			 * we found candidate memcgs in the last tree walk.
-			 */
+		/*
+		 * A NULL memcg ends a full hierarchy pass (except when memcg is
+		 * disabled, where it is always NULL: fall through to the root LRU).
+		 * Count a failure only if the last pass found no candidates.
+		 */
+		if (!memcg && !mem_cgroup_disabled()) {
 			if (!attempts && ++failures == MAX_RECLAIM_RETRIES)
 				break;
 
-- 
2.34.1

