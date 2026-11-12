Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794449976;
	b=03+2k02GDya9ydjxBJFbaHm2ZNWzfrRukNqOab8ZKI9fwXFLDXffqpMdMKGvzpVdLsok
	 K2NoNYsceqmO/NIyn6lqVbRS4PgBSg7KopJmXHjVd8tisLecWj9Jy4hFlc5KRX7NxF66S
	 jbWiUlGHjW2WxTqYJQ9qERM1Q/ByHrukIydMLBvGr7wcTj0jz/7MToQSGeOPbpVfcTtcq
	 5ycXQ2YgBbxR+z23f8NriDrSfc+rNMQDm+ZCkqjoaC/isOqICjvwofjCROglTB21AhOFV
	 lwbQ23WTryQXMy+AxUfJVjnWHNaLhOOClk3+XM4aAP09z+cy0VsYFKefugyEra+lArA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449976;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WflW9j/gm4j/klrpr3v1cKaSD4ONC2U5fxfdeDu0LpU=;
	b=jVwTuuU7MoY2bD5pL9TxR0gk+1L/E4DH5NbRyU1bcorXIetE4cRUi9Vb5L2gv3YEY+Rp
	 CLHNo3x3xc+b6O/3RT0OzWaDepQY0CasgDed1Laylnr/srRzyHjPPpd1EN7jiMbrZpBAZ
	 et13CmvXWoBPxzpPplxfCprH9Rev3tSpU6UHFzBUGjpUSf8g2WloQ6H/DEXHSdptGJnlV
	 dBiU5fzj58cejXSrvRt+Hpl/FDB1lDVF9CKAXfvYi9C1YHZWDHeXghZKUTIYnFy1l9kRl
	 Jikb7Md8OBDz2tkxlgzRyjfwHoOGyv5hGhbIiBuiqAZBKjRgW61bt3uoEylshxTa8tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KG3jhoRg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F1B606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 02:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KG3jhoRg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F5621F00A08;
	Thu, 12 Nov 2026 02:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794449976;
	bh=WflW9j/gm4j/klrpr3v1cKaSD4ONC2U5fxfdeDu0LpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KG3jhoRgmU+/he7RwD8d1Thxp5bOvEh/xYAdpmQKsL2bnLqgTybbA4iAS//MXV4WF
	 4jiDp+nhfg3d+95o1VpaepZd97HgObIXgMC+QloY/smKmNqdCtOob+4Z6jaulj6x/4
	 h5ko2lrh/n+69fmSuigSnTZZXIP+vQc38v+4UCE6tvZHnJ5FxVo2dDkGqqe8ywu7XY
	 Q/OiIoKWbvAqfM9AAQ/1JmSQfM8YVadtYbBXJKWpk3574fnP5XHB3/V1Gh5qOmYxJZ
	 n7yNx0MRnFQH3DsGuYeF+gie6eSTBQovY7oL3fdYlt/OLpjaQowJglHqEkSpoo4onQ
	 Qm7HV1hukUAtg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qi Zheng <zhengqi.arch@bytedance.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/2] mm: shmem: move unused huge shrinklist queuing past the truncation check
Date: Wed, 11 Nov 2026 21:19:31 -0500
Message-ID: <20261112021641.1245345-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200119-failed-7.3-8f59173b5ca3@kernel.org>
References: <20261109200119-failed-7.3-8f59173b5ca3@kernel.org>
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

From: Qi Zheng <zhengqi.arch@bytedance.com>

[ Upstream commit 948715f5866cc5b91c096a0308dd5a93b1a7d79b ]

The shmem_get_folio_gfp() adds the inode to the unused huge shrinker list
at the alloced label, but a subsequent truncation check may still fail and
remove the folio, leaving the inode on the list with a stale folio.

The original code works because the shrinker re-looks-up the folio and
drops stale entries, but it is cleaner to queue the inode only after all
checks that might remove the folio have passed.

So just make the pure structural move with no functional change, and it
serves as preparation for the memcg-aware shrinker conversion.

Link: https://lore.kernel.org/17fcf64faec0dfbbe6cf8a97924e3f39cd3c51a4.1786955972.git.zhengqi.arch@bytedance.com
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Stable-dep-of: 8f59173b5ca3 ("mm/shmem: hold off eviction in shmem_writeout()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/shmem.c | 48 +++++++++++++++++++++++++++---------------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index efc99d5f86588..bb5d24e7202dd 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2560,27 +2560,6 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 
 alloced:
 	alloced = true;
-	if (folio_test_large(folio) &&
-	    DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE) <
-					folio_next_index(folio)) {
-		struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
-		struct shmem_inode_info *info = SHMEM_I(inode);
-		/*
-		 * Part of the large folio is beyond i_size: subject
-		 * to shrink under memory pressure.
-		 */
-		spin_lock(&sbinfo->shrinklist_lock);
-		/*
-		 * _careful to defend against unlocked access to
-		 * ->shrink_list in shmem_unused_huge_shrink()
-		 */
-		if (list_empty_careful(&info->shrinklist)) {
-			list_add_tail(&info->shrinklist,
-				      &sbinfo->shrinklist);
-			sbinfo->shrinklist_len++;
-		}
-		spin_unlock(&sbinfo->shrinklist_lock);
-	}
 
 	if (sgp == SGP_WRITE)
 		folio_set_referenced(folio);
@@ -2610,6 +2589,33 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		error = -EINVAL;
 		goto unlock;
 	}
+
+	/*
+	 * Queue the inode on the shrink list only after all checks that might
+	 * remove the folio have passed. Otherwise the inode could be left on
+	 * the shrinker list with a stale folio.
+	 */
+	if (alloced && folio_test_large(folio) &&
+	    DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE) < folio_next_index(folio)) {
+		struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
+		struct shmem_inode_info *info = SHMEM_I(inode);
+		/*
+		 * Part of the large folio is beyond i_size: subject
+		 * to shrink under memory pressure.
+		 */
+		spin_lock(&sbinfo->shrinklist_lock);
+		/*
+		 * _careful to defend against unlocked access to
+		 * ->shrink_list in shmem_unused_huge_shrink()
+		 */
+		if (list_empty_careful(&info->shrinklist)) {
+			list_add_tail(&info->shrinklist,
+				      &sbinfo->shrinklist);
+			sbinfo->shrinklist_len++;
+		}
+		spin_unlock(&sbinfo->shrinklist_lock);
+	}
+
 out:
 	*foliop = folio;
 	return 0;
-- 
2.53.0

