Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674662;
	b=XaVq88gJ8mJuPzNvFws9rJGeGZGx8CpxVDkbIwYC3mBqRZoWj+9ym5n/1pxYRBAdfTeG
	 WO6YTOw2gHlIO2q9eOyFamkwpf8FhwYgdlFfmYM6yWlVgywNR5SEQacsYLNIIxAGNw7ij
	 Sgr8AOuT0W09P1kqjFnB+DiHRUNt+BgbdatT//GvVoZBHpvJDSfhDchWFMuVX4Ja2oLzz
	 ExJLpofOuZtfF4lMim5StpAukIptgSn/pFjwhdVsLOmim1Y24XKadHwyB/nALKBpkOFuZ
	 YyaHv71D3oj8/9SxiiVqQAYAjU/53sVs8CKdgAwdkRaVBeNkOUUHXfB6Za60qT8//uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674662;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GKZPU2RuBFoCmLqvHIjJFs9zfkqhAXtbaF3mPdMLOCg=;
	b=Yj1v5EYJLFN0GgscBZTjqJnqb01XeWpYPBCOy4/un79VFpTVgUCP5nwlgUjOVddxR3u1
	 QMXKl5uKJb/s06q4sAFTaQchFX8nX/yFKgyyD8+SuaeuuqUzN4txdjHxFIE2ZiqIFFuLd
	 ZV1VsuPTpfTvNSkAd6aYC02ZeitHVQCJQAo1+4wBal4JnA6DgxaGJWxoiUNB0vptMiC4K
	 tUoHCw01OdQItXs1MGVgUZEz7ic4R1/9fobHTvNH8G9o4YVnE8DZX8lZ3TCshcDLoRxmM
	 CGif5gjHTV78XQbmblfSHZr43qWU4T0bl6ZvmOlT8NlUJRIu03NdxN4kgpervq47yQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bOfg0BWa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6004D606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bOfg0BWa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588461F000C4;
	Sat, 14 Nov 2026 16:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794674661;
	bh=GKZPU2RuBFoCmLqvHIjJFs9zfkqhAXtbaF3mPdMLOCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bOfg0BWahHqzEj9Oz4cHohZatXbnEwY7+R0RPlA8/vv283shyeqlRiIipx79hHMWx
	 xynTf9/U07GBNhSXaGrms+DuqLk5W3z5VcU8JRH9YAJXJUUlv6Ax3y9qeNHIovLn6R
	 50Xs6kE+WVM8DJT65fWmBWfAcl6qVS2hcuf1AQTIrNXvP0Cs13H05iT14hEo/+FALr
	 seqb6DCRp5s+/ra1DmYHlRmlTe3n9MOQstmYE7Ujb6SWci6ip0LyApKVnEAnnZ3Vuy
	 /5wvX8bgdx6c0+OSZywdo0XDobfAtXNUKUxsVuPw/qH6Xysu7t2NskrOFgCKAJ5g+5
	 xFE/KABKEytaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Gregory Price (Meta)" <gourry@gourry.net>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/shmem: fix accounting of swapin-error markers
Date: Sat, 14 Nov 2026 11:44:19 -0500
Message-ID: <20261114164402.4112032-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201550-failed-6.1-66ce68a249f4@kernel.org>
References: <20261109201550-failed-6.1-66ce68a249f4@kernel.org>
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

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit 66ce68a249f4ac56cd6968aa6d8ded20fb4b7d09 ]

A failed swap read replaces the swap entry with a swapin-error marker in
the page-cache and subtracts its pages from "alloced" and "swapped";
however, it leaves their block charge in place.

Removing the marker during truncate then subtracts from "swapped" again.
This can underflow the counters or make swapped reach zero while other
pages remain swapped out, causing swapoff to loop without finding them.

When installing the marker, subtract only from "swapped" and let
shmem_recalc_inode() reduce "alloced" and release the block charge.

Make shmem_free_swap() report successful removal separately from the
number of swap pages freed, so removing a swapin-error marker does not
subtract from "swapped" again.

It's a bit confusing, but replacing a swapped out page by a swapin-error
marker in shmem_set_folio_swapin_error() behaves as follows:

Initially:
	alloced=1, swapped=1, nrpages=0
Calling shmem_recalc_inode(inode, 0, -1)
	-> swapped = 0
	-> freed =  1 - 0 - 0 = 1
	-> alloced -= freed
	-> alloced=0, swapped=0, block charge released

Fixes: 6cec2b95dadf ("mm/shmem: fix infinite loop when swap in shmem error at swapoff time")
Cc: stable@vger.kernel.org
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Link: https://patch.msgid.link/20261029-fixes_shmem-v4-14-392fc715d8f6@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[ sashal: adapted newer swap-entry and accounting APIs to existing single-page swap handling with explicit inode locking ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/shmem.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 9db6a2488f456..40397c848b3d1 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -782,18 +782,24 @@ static void shmem_delete_from_page_cache(struct folio *folio, void *radswap)
 }
 
 /*
- * Remove swap entry from page cache, free the swap and its page cache.
+ * Remove a swap entry or swapin-error marker at index.
+ * Return whether it was removed, counting freed swap pages in nr_swaps_freed.
  */
-static int shmem_free_swap(struct address_space *mapping,
-			   pgoff_t index, void *radswap)
+static bool shmem_free_swap(struct address_space *mapping,
+		pgoff_t index, void *radswap, long *nr_swaps_freed)
 {
+	const swp_entry_t swp = radix_to_swp_entry(radswap);
 	void *old;
 
 	old = xa_cmpxchg_irq(&mapping->i_pages, index, radswap, NULL, 0);
 	if (old != radswap)
-		return -ENOENT;
-	free_swap_and_cache(radix_to_swp_entry(radswap));
-	return 0;
+		return false;
+	/* A swapin-error marker holds no swap slot, so just drop it. */
+	if (!non_swap_entry(swp)) {
+		free_swap_and_cache(swp);
+		(*nr_swaps_freed)++;
+	}
+	return true;
 }
 
 /*
@@ -939,8 +945,8 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			if (xa_is_value(folio)) {
 				if (unfalloc)
 					continue;
-				nr_swaps_freed += !shmem_free_swap(mapping,
-							indices[i], folio);
+				shmem_free_swap(mapping, indices[i], folio,
+						&nr_swaps_freed);
 				continue;
 			}
 
@@ -1009,12 +1015,12 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			if (xa_is_value(folio)) {
 				if (unfalloc)
 					continue;
-				if (shmem_free_swap(mapping, index, folio)) {
+				if (!shmem_free_swap(mapping, index, folio,
+						     &nr_swaps_freed)) {
 					/* Swap was replaced by page: retry */
 					index--;
 					break;
 				}
-				nr_swaps_freed++;
 				continue;
 			}
 
@@ -1756,11 +1762,9 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 	delete_from_swap_cache(folio);
 	spin_lock_irq(&info->lock);
 	/*
-	 * Don't treat swapin error folio as alloced. Otherwise inode->i_blocks won't
-	 * be 0 when inode is released and thus trigger WARN_ON(inode->i_blocks) in
-	 * shmem_evict_inode.
+	 * Let shmem_recalc_inode() reduce alloced and release the block charge
+	 * for the freed swap pages.
 	 */
-	info->alloced--;
 	info->swapped--;
 	shmem_recalc_inode(inode);
 	spin_unlock_irq(&info->lock);
-- 
2.53.0

