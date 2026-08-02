Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFD23C4562;
	Sun,  2 Aug 2026 16:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785688004; cv=none; b=DXvQ9kcpsu0Q5jOF1/Vwk8vt7A0dhk92XrjcOhwD4R/wgobhyi5RrCFfTPscoZJiepAeu5UvfPOdrXp8pEvCEqDory7uNcX8VRfSuAAlDmnpupPKLrDW63tqNBWaYkyzBMxuXmcQ9jyF/ygntJ2qtyH59JMql3B1mxAUGoZFuY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785688004; c=relaxed/simple;
	bh=WmQs425Ef+xSSAMNq/UxNBdA3EHvev2EgnxOjd6G0UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nHN6Qs+GaWoWiVIUmDqsgUf7+/HkucXpoelU9V5xHJSVPRcmWhEEjm6BSCRXXO+CR0NgmWEs24UjzqtcLcWyxVQfsNYcg3XrCn0go8ODdyie6Nq2XWA4Ychhp/wnxe2ZTCpJUUbiaSk8s0kc/dtRg5Yl93RNGT4Hp0b2IgCap9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i93KIxE6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i93KIxE6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096EC1F00A3A;
	Sun,  2 Aug 2026 16:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785688003;
	bh=UlahV7MXYAlqB2Rb+2/EWA2ZT0Z/bDkXZ3DtwrXgJX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i93KIxE6IhKofsUKUjSvoeTgC+o3fRHexLU8S91bisem0Lp1CY8/A9/xz5YySiK0Q
	 DbxNTTvq6m2hy8D8QfWt79E95h9+vbIKCtq0dp65YKgGjRYF056e6++4Qo1uxQCrTB
	 d5R+gLEHMfovUlT5Zh17788JeytKKcbJADVpsmuVsXtpqrcyEAmLbAFUUfPP8wMG86
	 VdV22kxE5i5yj+U2mmK1zZRiAQSM/YwnrWzamUK4AqKjapmqCXHb6gEhrQj2Yn114h
	 YT3pGUA7OGqhLWE0GigIzBIlukKcgYSz8r+HAqrrXcwT3lNbzDmzopv7g175tufi4C
	 6fNpVrcK2xMGg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 8/9] mm/damon/core: handle extreme memory state in get_node_memcg_used_bp()
Date: Sun,  2 Aug 2026 09:26:29 -0700
Message-ID: <20260802162631.90304-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260802162631.90304-1-sj@kernel.org>
References: <20260802162631.90304-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In extreme unlikely situations, total memory might be zero.  In less
extreme but still very unlikely situations, lruvec_page_state() calls
might let the caller show used memory larger than total memory.  In the
two cases, damos_get_node_memcg_used_bp() could cause division by zero,
or return underflowed value, respectively.  Handle the cases by
returning 100% and 0% for the two cases, respectively.

This issue was discovered [1] by Sashiko.

[1] https://lore.kernel.org/20260329154813.47382-1-sj@kernel.org

Fixes: b74a120bcf50 ("mm/damon/core: implement DAMOS_QUOTA_NODE_MEMCG_USED_BP")
Cc: <stable@vger.kernel.org> # 6.19.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index e3f3ee75a3d33..67ad1f07c29a4 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2862,10 +2862,16 @@ static unsigned long damos_get_node_memcg_used_bp(
 	mem_cgroup_put(memcg);
 
 	si_meminfo_node(&i, goal->nid);
-	if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP)
+	if (!i.totalram)
+		return 10000;
+	if (goal->metric == DAMOS_QUOTA_NODE_MEMCG_USED_BP) {
 		numerator = used_pages;
-	else	/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
+	} else {
+		/* DAMOS_QUOTA_NODE_MEMCG_FREE_BP */
+		if (i.totalram < used_pages)
+			return 0;
 		numerator = i.totalram - used_pages;
+	}
 	return mult_frac(numerator, 10000, i.totalram);
 }
 
-- 
2.47.3
