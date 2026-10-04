Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4BE1F91F6
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791109093; cv=none; b=TwmXxXNcHDNF47WhXcZnMsCrHfL3WD3yLhuhuMXAQmbuqT6lcie2Evl/v9xTA1Xa9vaM+H5R0WgidN+aYfFfaCdWJmWWsmJGZUKKaTSpihIS+JAVqQ+3zmz0gSJhR+hfyX1ZzDNtDrokiDHLPxsk6Gmof8eu6OX5Cwlw6Pn1ddA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791109093; c=relaxed/simple;
	bh=t36RkkzvpjbqOsEJ+B5MNz/BQjgRMPDqpthxaCGbwhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kQghdeBaB7PPZh1BPZuXQRhUQ9kGoC2jYUZ74NEoY4JoCTMcV/udnIDWCnqQG/Tbr8NzQcnqrGd2DH8N0QMo2A/i7U4BJptGjSkh/STsZxfy+U0K646yTdpUz0flrsjFR81R0ICDx1LqDgUo07Db8B4DFVQfpTXc078Z5jlmPSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgSoWqA4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgSoWqA4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E201F00898;
	Sun,  4 Oct 2026 10:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791109092;
	bh=1ip88zzvnlfJ9ElI4k8H1DXEmi+syR/voXTaVKoHNUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IgSoWqA4s92WKRJYZVezDDI6atYN6LYdTAN2y5KTriS90Tw/UbbvRAXxFGSlYZPMo
	 lSlw+SVIhJDz1eE4H1ixSogbZCA3TwzxqrPff0dZnjgKzymE7bl1Ssex/Dt+pHGWT7
	 DnXY9PQf+ArONohFxhQrpmPHIBfM1xsRFhR7rIy55HRqMPEr9nc3niW9il0d79BXH7
	 BAN6tRsV8rFvihiHMdatCjXVztl78t5SKw6RVLoexA6aK1H3jcRQ5zlswpolflZTWg
	 QiZvGx2gmkfZ7TcQnhlA+sFin4d6KCIVodie0hyyLbqN5WBa/5NyYkoCVrjvqqPiTu
	 oigDwRsLLZwDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Lance Yang <lance.yang@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Qi Zheng <qi.zheng@linux.dev>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Hugh Dickins <hughd@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] mm: shmem: ignore sysfs configs for shmem forced collapse
Date: Sun,  4 Oct 2026 06:17:57 -0400
Message-ID: <20261004101724.1697042-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004101724.1697042-1-sashal@kernel.org>
References: <2026100338-roundworm-goatskin-a51b@gregkh>
 <20261004101724.1697042-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Baolin Wang <baolin.wang@linux.alibaba.com>

[ Upstream commit 72c3d682c165b836b54a3d07a01f72e39c47022c ]

According to Documentation/mm/transhuge.rst, MADV_COLLAPSE is expected to
ignore any THP or mTHP interface settings.

However, after commit 26c7d8413aaf ("mm: thp: support "THPeligible"
semantics for mTHP with anonymous shmem"), performing MADV_COLLAPSE on
shmem will depend on /sys/.../hugepages-2048kB/shmem_enabled being set to
"inherit" (although that is the default), which can cause MADV_COLLAPSE to
fail unexpectedly.

This could cause a userspace-visible performance regression.

Fix this by returning the result of shmem_huge_global_enabled() directly
when MADV_COLLAPSE is requested, allowing PMD-order collapse while
ignoring shmem THP/mTHP settings.

Link: https://lore.kernel.org/063f655b4d6c4234f3aa27ed6ecab10283ecb880.1789351825.git.baolin.wang@linux.alibaba.com
Fixes: 26c7d8413aaf ("mm: thp: support "THPeligible" semantics for mTHP with anonymous shmem")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Closes: https://lore.kernel.org/all/20260908125105.1510704-7-kirill@shutemov.name/
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Barry Song <baohua@kernel.org>
Acked-by: Qi Zheng <qi.zheng@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: <stable@vger.kernel.org>
[ sashal: Kept the shmem_huge_global_enabled() call without upstream’s extra vma argument. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/shmem.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 1a5932bda558f..9166d9c455abd 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1713,13 +1713,12 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 
 	global_orders = shmem_huge_global_enabled(inode, index, write_end,
 						  shmem_huge_force, vm_flags);
-	if (!vma || !vma_is_anon_shmem(vma)) {
-		/*
-		 * For tmpfs, we now only support PMD sized THP if huge page
-		 * is enabled, otherwise fallback to order 0.
-		 */
+	/*
+	 * Tmpfs huge pages allocation or forced collapse ignores
+	 * sysfs configs.
+	 */
+	if (!vma || !vma_is_anon_shmem(vma) || shmem_huge_force)
 		return global_orders;
-	}
 
 	/*
 	 * Following the 'deny' semantics of the top level, force the huge
-- 
2.53.0

