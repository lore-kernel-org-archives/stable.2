Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106268;
	b=IkrTSj3vDUYxGxQ6mzl16af4zPGN5Ug6H64KWmsXSsgEvbOWhWkPISHRxWQwts30kWMc
	 RRHjhYT9ONqOuQU/wSfc9rBjjJ+xIr5ZAoc9oTcKXBi8gtSLC3AYG40NzVNKEulr+5C/N
	 bdQFemQVh7g9AQ6YJUlJY9U705raPz7CC4L9dPCzKqFIegWTBfEF1Vjl8EIz6x6OxGHd+
	 APJ4ernzVgrmEYsVlcdeb7z5FUbbD9qNxrSsztDqzbN2Khn5QXx9yvTrAByWg9/D59pJf
	 mGQAFkM/r9WeXVnlPEc4Ct7Gcas0TVdpmUSy/vF9Fc+ZX7usP9mc0/j62FwquU5sAJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106268;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=NOESXTHj7ZHJ0QSzwAvNg5THsJXn1CEoruRa5FHdNnM=;
	b=Mj0TlHQGD2vZ+rMnzOjKa1koNdiM99kFPRLgqSN27ja90rXtAsc/Ik6xaGD9Jub0pwjN
	 SVkOHHL+W8RhNFKSEhfBnl0HYTiHVTAJ+eAjZujML9NiYWXn3WKtCKhVtzLRU86Ifp172
	 7hkX/13TS740pAHoH6ERfcuFMTqi6md9TAybiuLBIjGnovqeGj2XIzemoDDIEgvkE3p2S
	 gVLzxFnrIBgGlGRJgpmFH9hscvJV33P9azwKQTEpbpYhvFjjds5G+s8eY73Bx1jhv9PVQ
	 /LQp71tb87e3IZDuQiBlYiNY5TWtCXFgfdfRN/YGbXdEa7mZ3YWm79SJEPNvwJdLu8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y99aIv3d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6691C606A324;
	Tue, 27 Oct 2026 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y99aIv3d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77491F01825;
	Tue, 27 Oct 2026 13:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793106268;
	bh=NOESXTHj7ZHJ0QSzwAvNg5THsJXn1CEoruRa5FHdNnM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Y99aIv3dpJ5iCx+yDapSlDEzrTGUQU6aM5QKk9+CnMu9PBVS8s7zcUkvWvFNdbRww
	 e1hTCxxzpD0X1JpZc6hIkncozeWfy25BfWvcEQnvf/qG+Nu32EHm9/50Z5i9JoB76D
	 YLFdfbMkcTbTSNXvB3EvFpZhmBs10lAT3aeetcoliHAEln7qHXCK17cwYyTCvlDlle
	 oltykfwmn9+/1XIXl/kMUPK2DuhUN0cRYIbfJtXQdjFuruPRwLSIMfD2F4a45pLCJC
	 DtnjUkzQULHjKCDN8rJxCFP2fPJXDMUuF8KNHhir/Zx6ZpHnfyPrMryZfhmEIIo5R2
	 L1q+M7lOrgFpw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 14:03:13 +0100
Subject: [PATCH v2 08/14] mm/shmem: discard whole new large folios on
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
Message-Id: <20261027-fixes_shmem-v2-8-86a00952acb9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1590; i=david@kernel.org;
 h=from:subject:message-id; bh=oPg88T3p1DTSdeYY5B0XA24Ulyfbj8Z+CfGvtqwsdVM=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeLBQsadu8ylJBw3LrBCsxnovvDSaVHlw5wf24Zt6j3
 J1s7Uc0O0pZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZhIzS1Ghuec3AJcmd9DFnX+
 LNsU4aw5Y+lv9ulqLT63V/+dGeTYfoWRYWv33yV9E2vnfp12TWShXYT+CdlzIW37SlRPhu6KXcl
 gzQ0A
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
index b615301a311e0..e6532c9b0cbdf 100644
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

