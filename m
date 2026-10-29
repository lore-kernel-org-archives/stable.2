Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270711;
	b=3f7L2lEZDMRuLBLj2cOWIwnaZbHzwhDG9TNWS9n9qQAm8nGlX5Xkf1fc/+k5SXtGWr8a
	 nvYXBGVtA5VRvjxTW/QoSw/4W72p4c0B33GUn214Z5ex/DS2fqHE0hyfiP0rBgGpiBLBk
	 huNuSa2exBQZRQqoUhDcpbdtJi0gIGD6pORZB6V5mhPOplYU3mCUnkBjUFvWWY/tuD5DY
	 O3JRcitL2x6cgyeVq3Vd6F2/qseOGsRdlTpJvn2o44pIeyGU7amXzqO/0KkabWd4eXnwq
	 FzO4teGucQEFk5v4Ax4t+2OxWIujrSQFRM5s1/IGmKDaFGHsfcdryxc2Bsf/LoaE05Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270711;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=AEPuOS39iMOT1AtyD14etoYTLMUy392NJap8KxtSbSA=;
	b=xQQ26Chv+NTJ9GAzoL1YMV6xwOyHIRZY0f4CnHqiyo+VecYrRl0shAPprJMQCTl1Z8Sy
	 JB37Hmsgtdf8Rj5X50NVp2Pe0NW15LwrOo/6RVI2UdMMiLEYi05Not/o4Zu3JVJImKQzl
	 GVK4/HHxilRVuOGwmBxDroxWXf9lK97Hlc8P6QN8x8UzVncrtYWwyTMQ3g9d7kASoys6T
	 EnIuURVXhbt76F36ezPSmOlQCtmjbnHVCCJ5Hv+yChRFpfDqG3rgjIKa+Cx2D7J70RpZ0
	 cbBc8vDWlnmb31BYcA3oPazIVT0pqigp2fe3qw9R3M3oB5ncdf6G9OhSi4EQ33j034A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W8E+Cden;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D04606A31C;
	Thu, 29 Oct 2026 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W8E+Cden
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2161F01828;
	Thu, 29 Oct 2026 10:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793270710;
	bh=AEPuOS39iMOT1AtyD14etoYTLMUy392NJap8KxtSbSA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=W8E+CdenzSDdHs45AxnPumF3FatOKMf8gv/+2TZlirGjhixsHG/6GJqoiygMaICKz
	 fRQsV7/5KRmuV4I3WM1BlhFfuj6drND5kRzsRagDA+8XA3v2ymwpbQM46g08Y3AFay
	 znjg7ecOfoAq0NSNXQlN/mg6qoFRidmHdYjkq9l7KGxAReBYWK6h9x6ZtwwWSuw7nx
	 sRI6MovwXTg9yt6so/m5g94v/X+lqUoIfO4oAc4UBXnlOU8rS590UTuyWcEPErpOHM
	 9tXNFp/UXX98xctwvVqWL/o8A8Ve249k8phQDGzxcmEDsZ6M6KI80u+ogxbCYALfnc
	 ejw7KACrCpXfQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 11:43:30 +0100
Subject: [PATCH v4 09/15] mm/shmem: discard whole new large folios on
 fallocate rollback
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-fixes_shmem-v4-9-392fc715d8f6@kernel.org>
References: <20261029-fixes_shmem-v4-0-392fc715d8f6@kernel.org>
In-Reply-To: <20261029-fixes_shmem-v4-0-392fc715d8f6@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Lukas Czerner <lczerner@redhat.com>, Carlos Maiolino <cmaiolino@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Stevens <stevensd@chromium.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 William Kucharski <william.kucharski@oracle.com>, 
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org, 
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1588; i=david@kernel.org;
 h=from:subject:message-id; bh=EsQBDFsf4HLOrrUjsCbpKGaKH12qFBA6scTqE8mNROk=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeK4d3vldzN/NYt3nr0a4Juquurqz0Sp5iuXKW8jr+Y
 0qfS3nyO0pZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZjIUT5GhkUnNOMfHgjZFi0Y
 cizh/+nOL6e5dp/JVeW7YSN//95rw0WMDDeX+t4VfmdiI+P+fDfHoY/MsTpC5XvmJxzVTKyNrSn
 UYAEA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

When undoing a failed fallocate(), shmem_undo_range() must discard each
newly allocated folio. Its second scan instead passes large
folios to truncate_inode_partial_folio(), which does not necessarily
discard the entire large folio, but instead tries splitting it to
discard only the requested range.

For example, with huge=always, a failed allocation starting at offset
4 KiB can leave page 0 allocated in an otherwise empty file.

Discard the whole folio when unfalloc is set. Note that we enter this
path only for folios that are not uptodate, and can consequently be
dropped without losing any data.

Fixes: 55ac8bbe358b ("mm/shmem: fix race in shmem_undo_range w/THP")
Cc: stable@vger.kernel.org
Reviewed-by: Zi Yan <ziy@nvidia.com>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 11c3e6b1aa76..151704b2091d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1473,7 +1473,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 				if (!unfalloc && folio_test_large(folio))
 					folio_mark_dirty(folio);
 
-				if (!folio_test_large(folio)) {
+				if (unfalloc || !folio_test_large(folio)) {
 					truncate_inode_folio(mapping, folio);
 				} else if (truncate_inode_partial_folio(folio,
 						lstart, lend, NULL, NULL)) {

-- 
2.43.0

