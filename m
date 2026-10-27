Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106282;
	b=G8psgmuykC9a8wUU4laa/kFlggoNza4IzrkTYMwY/qTVrO3dz5fyjQpp8w8aR5JIEcaf
	 OGnoP41CXWTKepqewYyQL2OEF79t4Rtao7rZHaeFIkp0Yk0/7+21/v0ZEdIIUQ1a+GBsK
	 pDRpAG17vCstAn9IHeY1lw03J8v3d2k60qgfBA8najBIraFo6zF1AnvXH+f6iLLWegkKL
	 umK1FOtzDWRPPiwKUTt4Kb8B30/gviZM72ZFKE0rUhMAfDZ7/h+CrgOkudohoNwX3BbeL
	 Fv4aJNTq+lk0WHoiYbJ9i92EvmtCeX4Hfi7q+keJHq6SI8Ajew2xOqFVFmSOkqZveVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106282;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=T5v5cRepOrsBtlr314Avjpusrkb5y4iwoU07gbK7WHQ=;
	b=E4+Re/pT+uDBmtTLUa07iFuo306BkGfaJnS+GZg8iBxAV7wXnr6DmP2haZ6ONIYO5dt0
	 fZY+WcHBb5eCrN9K9od3SdWXt939lyaT+VZHdbmY26IN17GDV+esG5a0iTScxhYLAkgFG
	 HFm+UHqLT8gyeXqigHqSlyxAL0qHRyp3pofBjumNQREiNdaeyv9jq5fJu6LJBtt3L17lf
	 p3ERkmNqyP2SErC96Q4NTW8LE3YSWi61uF7nqFhd1rec9LlA5BJB1Yq9vuqb6G9ou8hPX
	 NEfCvlP4NXRt7ibIKC9VYtVAnz2UTBvRYVgF/gX6slsVxsQpF71MTpPvNIyayuVXdgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AkarBh22;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E84606A322;
	Tue, 27 Oct 2026 13:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AkarBh22
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB94F1F01828;
	Tue, 27 Oct 2026 13:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793106276;
	bh=T5v5cRepOrsBtlr314Avjpusrkb5y4iwoU07gbK7WHQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AkarBh22x4+jVEY7agkIPV8RfXkGZDIb0Y4ylixEHIv+R/GiP56wB1jYdxsk//gnc
	 47FfnMlhIP6wFqaCi8HXhlesPeiFi4W9n5Lm2pb/Z0vIwgauFCD7hEANoPvdTCSKOO
	 UYAAN9u4/CzepyWqdA49RZI8xwO3FKyn6eYI13mQE+9yfwHIwmtIYC2YyFmQBmYlIx
	 a8mh7nOL3b1NI4HnYM4u6tp0unx2t7ef85Tg/O2g+5V4GKclkz+O7xG6HXjvoSoFw4
	 0hGI5IJ8nqgH6eN+GbEUkYJLbhWcQxFFbivAgMppibCqMIcr5xhDn3+grwlKAtMAck
	 v/APXrY4m2oqQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 14:03:14 +0100
Subject: [PATCH v2 09/14] mm/shmem: rescan after nonuniform folio splitting
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
Message-Id: <20261027-fixes_shmem-v2-9-86a00952acb9@kernel.org>
References: <20261027-fixes_shmem-v2-0-86a00952acb9@kernel.org>
In-Reply-To: <20261027-fixes_shmem-v2-0-86a00952acb9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2025; i=david@kernel.org;
 h=from:subject:message-id; bh=JlceDwOL/xhFvttSFqMpneZSe3wIGnOX8j/++/Na1FI=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeLBTcmJntoTir8Vu6yep283/MMWavN1qorLMRfTr9y
 s6PzpwsHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAExkdgbDH46tZVpFNvtOM4dz
 idqXsYuZ/ftZ7HpKu8z7N5vQek8fEYY/fLpMDT8PdNo9ufF+VuyOPnOXojKu+6xRexmqPYzKpRe
 yAwA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

The final scan in shmem_undo_range() restarts after a successful split
only if the original folio is no longer large. A nonuniform split can
leave that folio large, so the scan skips the newly created folios.
Hole punching then leaves pages within the hole allocated even though
they could be discarded.

For example, a fault below the hole can allocate a 2 MiB folio after
boundary handling. Punching a 1 MiB hole at offset 64 KiB splits the
folio successfully but leaves the original folio at order 4. The scan
continues past all 512 pages, leaving 2 MiB allocated instead of 1 MiB.
The hole reads as zero, but the pages and their block charges remain.

Fixes: 7460b470a131 ("mm/truncate: use folio_split() in truncate operation")
Cc: stable@vger.kernel.org
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index e6532c9b0cbdf..d7cc45d7077a5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1478,18 +1478,12 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 				} else if (truncate_inode_partial_folio(folio,
 						lstart, lend, NULL, NULL)) {
 					/*
-					 * If we split a page, reset the loop so
-					 * that we pick up the new sub pages.
-					 * Otherwise the THP was entirely
-					 * dropped or the target range was
-					 * zeroed, so just continue the loop as
-					 * is.
+					 * The folio was split. Retry the scan
+					 * to find the split folios.
 					 */
-					if (!folio_test_large(folio)) {
-						folio_unlock(folio);
-						index = start;
-						break;
-					}
+					folio_unlock(folio);
+					index = start;
+					break;
 				} else if (folio->mapping) {
 					/*
 					 * Splitting failed, but the part in the

-- 
2.43.0

