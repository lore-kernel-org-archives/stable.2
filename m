Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795371583;
	b=sNYcFJTX2CZxMjk7ZsPXRaNGg4+ZExqa9tQEv+vhUPA3CXl3iYfZl6REmf/7nzTH8xaZ
	 ilc/cumOHngOvV0PLZwD2stEmdbV4hxydY+G72JvpLQJDW1eU6FVc7KTTJCjwX2p3sNSZ
	 7Mc5mnHDxf2MuNWsTWt1o+/HW1isnKjS5f9lMDioVGPstBsJj+1t0RAYUbNbD0IfLeChU
	 CTqZnHLYcq8CGdXfrz4rt+y084Up3chIjLplZy4vA2pet9mTZOQFw+JURog/QfCrEiM1u
	 upfG/i1cGuKmtlf2aAuNgy6eseFk9qy9vcBaBfqsKp3On1Tay2vG19cKFPjTpVzniUg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795371583;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7oQB3/O/c4dFGNnygzjgJHN8nXWsiGK/1pYzsrZRsWo=;
	b=poRirNnD9rY68bSCfRHk+5yqUWW3Ar9RYfIlpHtWeqC96EHjKCv7ifhyQJv2o8+GmdaM
	 CXAVVD+uFs+3XD9d3mq9fbqLFhRmYvlhm0KNdjfNcC6oOsHmmhYC0uB1+mwjgCqnBg+i2
	 Ll0PbzfRu6DRDwFAbVcE6EJ/cXzRoq91IwqG6oR0D6+gCRhvlmPSX6phUgwisbOaUPCGL
	 0+ibmA+MpzNjRKHOeU1BLWzfg4p8aUALIWzv+wAeifq6AdVK9FGeImjH/bN3pHCrvWE4c
	 98YDaVvbs52dpWdn8EljzyJ86tCM0AanPHx8BL9Mf1k5d8p86uibOIFKAFQvMpMKOww==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LnPr5l4M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEE8606A320;
	Sun, 22 Nov 2026 18:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LnPr5l4M
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795371583;
	b=vRdG3KoFSu6XRebj9AiPAhViDKw2UdTyV5RNVhKz20OLMomjWUAhh3I/ZxPWufKAhzVV
	 q2+w1iOe8lgsRN64fDnbdhi9MFDN5PAemJ/OfPLP+hMm1p2KZ5/0sq0n0oL0lpDtUjG2w
	 mH/OcFFoRrJdRpfku9ZgI2OPO1N/aFy3CzxFBoz8eJpT/Blbjrrzn5RWTXazy/RkOzHB+
	 F3iQrK1ZTBTg+LvwrLrEKvuMOokbRUalRVkloC+tp5bpQLCKy/2M9RH6sQGzT2PX0J87l
	 qDWMO0JbDpAJIb41sJYcxSzqSKZL/3RJ8mjsX2f3h3vakBN/KUYfZrZ0dDaw1j81Z5g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795371583;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=7oQB3/O/c4dFGNnygzjgJHN8nXWsiGK/1pYzsrZRsWo=;
	b=FkMG2caQ/CSTpD424280DSWbMwJFHocujW8Go4bfaPZ99IHCh+3LbBlTzsBaPPGLSAv1
	 0BLBw7Q1EFcXNBpjtq14dVtLD1BWmKFnqR48Eo/0cmNOiZL9rHn5bUiDqEH04jJ2/lwLk
	 JaRWgbD+B6+s8SAD1m/4tS8jowGMflJ2YLLRoHCCUiGbZ1i6O9Ia0UJ+gQz/SPCKWl/+X
	 ECarO0P0G0GDf4Ih6vFVAFu6X+lYHM/1/Ppyv6TXrRWIclpfQbWApj9Zf2nXvC1EJ/wQB
	 u7xePuTJIu0gomb/oYbrS59lha1qcK5pZgZLdl2hMbTLQHI8wl0E/X2E1aWqsyuRBSg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 18ADD1F000CA;
	Sun, 22 Nov 2026 18:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795371582;
	bh=7oQB3/O/c4dFGNnygzjgJHN8nXWsiGK/1pYzsrZRsWo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=LnPr5l4MVl/WBTctWsGBV2HvZcZIukVEPQKWUD57xBAvydn1/8vPaqe3pJPdQgmyJ
	 1rXGf49el+7SAqsN7thQvPY45jiNYiQInmacX50IX51TZs1O7zOeVaoUIjuefXLfPb
	 aOEzrvo7p/hqaWhPmCNSUA3a8V3GQ6WekU+UxHiGhMTGfMw+MqMpa0Xd4g/eZfTGNP
	 wusgcpvw7jITS43w32TwECbTP2Rr5TOi3teeRUej40s3SOFvrBLsn6KtlS2NLMBpAd
	 6rUTBteKEazK9uo/uIcooxXkQLEQUgIBsTIXxVk1xj8LLWzj4CBsn/RQSjZDbrVsZo
	 d0P2Vku+Ifcig==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9045F4C175;
	Sun, 22 Nov 2026 18:19:38 +0000 (UTC)
From: Ernest Borowski via B4 Relay <devnull+ernest.borowski.git.proton.me@kernel.org>
Date: Sun, 22 Nov 2026 19:19:37 +0100
Subject: [PATCH 1/7] ntfs: release delalloc reservations cut off by
 truncate
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
Message-Id: <20261122-b4-ntfs-delalloc-fixes-v1-1-0726f0dce403@proton.me>
References: <20261122-b4-ntfs-delalloc-fixes-v1-0-0726f0dce403@proton.me>
In-Reply-To: <20261122-b4-ntfs-delalloc-fixes-v1-0-0726f0dce403@proton.me>
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, 
 Baolin Liu <liubaolin12138@163.com>
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Zhan Xusheng <zhanxusheng1024@gmail.com>, stable@vger.kernel.org, 
 Ernest Borowski <ernest.borowski.git@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3407;
 i=ernest.borowski.git@proton.me; s=default; h=from:subject:message-id;
 bh=3nT+zUonqfx2kvoDVZIlPQfmCvPmSP51Ad2wiF9F3AM=;
 b=owGbwMvMwCVWzJ65uCpJ5D/jabUkhmxmIwu/cw/s2LYc4p8keqf/7MdHmhn5plfylyX//5Ttr
 rKrTiaxo5SFQYyLQVZMkaXj/40Qn5Bvn5bFafXBzGFlAhnCwMUpABMp/MPwP6xkV/Pcrjv++XNq
 zzRkf7jv7h8TMD/r87KrAsGO694pczMyTFXbq1OxddnKVW27eRfcufNyVf/s79pJZx/cUTPgqbi
 azw4A
X-Developer-Key: i=ernest.borowski.git@proton.me; a=openpgp;
 fpr=88FFD8544C54F6F2A65E2A8E730769A37A6214FF
X-Endpoint-Received: by B4 Relay for ernest.borowski.git@proton.me/default
 with auth_id=1589
X-Original-From: Ernest Borowski <ernest.borowski.git@proton.me>
Reply-To: ernest.borowski.git@proton.me
Content-Transfer-Encoding: 7bit

From: Ernest Borowski <ernest.borowski.git@proton.me>

A buffered write into a hole turns the hole into an LCN_DELALLOC run and
reserves its clusters in vol->dirty_clusters
(ntfs_write_simple_iomap_begin_non_resident()).  Writeback hands the
reservation back when ntfs_cluster_alloc() allocates the run.

A truncate that cuts off delalloc runs before writeback drops their
dirty folios, frees the clusters of the attribute with
ntfs_cluster_free(), which skips everything that is not a real cluster,
and removes the runs with ntfs_rl_truncate_nolock().  Nothing gives the
reservation back, so the free space reported by statfs() and used by
ntfs_available_clusters_count() shrinks by that many clusters until the
volume is unmounted.  $Bitmap is not affected.

Workloads that rewrite files (open(O_TRUNC) + write) or truncate freshly
written data lose free space quickly: a test that writes, truncates and
punches holes in six 400 KiB files on a 128 MiB volume sees statfs()
free space drop from 79 MB to zero in 80 seconds, after which writes
fail with ENOSPC or come back short.  A 1 MiB buffered write followed by
ftruncate(fd, 0) and sync leaves 256 (4 KiB) clusters reserved.

Release the reservation of the delalloc runs that the shrink cuts off,
before the runlist is truncated.

Fixes: 495e90fa3348 ("ntfs: update attrib operations")
Cc: stable@vger.kernel.org
Signed-off-by: Ernest Borowski <ernest.borowski.git@proton.me>
---
 fs/ntfs/attrib.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
index 6ee6b6bcac..4028c310fc 100644
--- a/fs/ntfs/attrib.c
+++ b/fs/ntfs/attrib.c
@@ -4383,6 +4383,37 @@ static int ntfs_attr_make_resident(struct ntfs_inode *ni, struct ntfs_attr_searc
 	return 0;
 }
 
+/*
+ * ntfs_release_delalloc_from - give back the reservation of delalloc runs
+ * @ni:		non-resident ntfs attribute whose runlist is about to be truncated
+ * @start_vcn:	first vcn that is cut off
+ *
+ * Delayed allocation reserves vol->dirty_clusters for every LCN_DELALLOC
+ * cluster when the buffered write is done and only gives it back when
+ * writeback allocates the clusters.  Runs cut off by a truncate never reach
+ * writeback (their dirty folios are dropped from the page cache), so their
+ * reservation has to be released here or it is lost until unmount.
+ *
+ * The runlist must be mapped completely and locked for writing.
+ */
+static void ntfs_release_delalloc_from(struct ntfs_inode *ni, s64 start_vcn)
+{
+	struct runlist_element *rl = ni->runlist.rl;
+	s64 nr = 0;
+
+	lockdep_assert_held_write(&ni->runlist.lock);
+
+	for (; rl && rl->length; rl++) {
+		if (rl->lcn != LCN_DELALLOC || rl->vcn + rl->length <= start_vcn)
+			continue;
+		nr += rl->vcn + rl->length - max(rl->vcn, start_vcn);
+	}
+	if (!nr)
+		return;
+	ntfs_release_dirty_clusters(ni->vol, nr);
+	ni->i_dealloc_clusters -= min_t(s64, nr, ni->i_dealloc_clusters);
+}
+
 /*
  * ntfs_non_resident_attr_shrink - shrink a non-resident, open ntfs attribute
  * @ni:		non-resident ntfs attribute to shrink
@@ -4479,6 +4510,8 @@ static int ntfs_non_resident_attr_shrink(struct ntfs_inode *ni,
 		}
 		ntfs_attr_put_search_ctx(ctx);
 
+		ntfs_release_delalloc_from(ni, first_free_vcn);
+
 		/* Truncate the runlist itself. */
 		if (ntfs_rl_truncate_nolock(vol, &ni->runlist, first_free_vcn)) {
 			/*

-- 
2.56.1


