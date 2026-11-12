Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453323;
	b=Y8DD1w1l1WvhPuwpEE1Ok3wXy948C/v/8vOrk873NHxunsw9si1mqhdlSIpeozgroF2a
	 oi4dt981udRzwsTH2UzLA4l9sSHCIVgLL/EWXK1h9+UYGr1AWsTxBT4l7g4fuh9AzER2l
	 vbJ33/SRU8JEYp1BnmaqCEbLdsKYHsox1/Tu6XlpXygKafNdet7m7BrcDJQSGs9l1PrF4
	 WzIu2jxnO9uYPiU7aIQW+VFC3WcPJ2Zjwl6uMG3hyv1PXeAwgQNfRJ86xGSUVMXhMRO2T
	 flzuP0fhBfA6ikdkBF2wWpyMTVAvzR1gb5iV2NQRvthc6wkej0wJpeNONEjJugpJ+BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453323;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AMbxGEB4K0FIDjH9zZGIWmbNqMKi7oLppT7HJ2/GKu8=;
	b=OJN8kbf23pUY24mI9m1G2r2WrmLho+LxtqDne8j2kjXnVYH1hiZk1RgUH5pZqERtAzlD
	 QgDbEXD8p51iT6jizeeFv49ov9mMX/0jmNt6hCRGXzhNyRXXGC7E9PJ+uUfk6cpcf44xq
	 WipDXw5JPs78yJ0joM3JHXC9mAMQFSTx5Ck19t2MMF7MRH2kghwWfMDq2ZeBm9jD3EnZJ
	 pQ3nfuKM+s0VdTSdvMla/UP0tr4R+rVUX/wan13fCXbGE3cRDgfx0IBIoF1cZINAW9zyG
	 qLrFXSOJXM8UNQ1PZ5b1NO6JKwxN3VRG8sRUq+sqnkNfT0LWEvBKFqgB/V2xH5eErwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+yQ+GTM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E7F606A323
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+yQ+GTM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6441F00A05;
	Thu, 12 Nov 2026 03:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794453323;
	bh=AMbxGEB4K0FIDjH9zZGIWmbNqMKi7oLppT7HJ2/GKu8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T+yQ+GTMTfJEmT7ssmP0V1wXep9HkjR69+EB3f3v/M0+XTxELI2nXoQQHuE/nzyQq
	 bF3EjF13ukuoOQMLuPLRXDDZHWxRs1tzuCpF5jswML+0HAajWOBnlkjUgMLUk11XKY
	 vMKjJk1+IQx1nE9m1h0QZ9/WAnxfp5p7NlnHZ4bPGCLP/+rWkOk6726/6i23x+kX8B
	 jRy/XtIL2ZxY4wUz/pzTW5g8U3ZT9SbeqXUavQVmfjnqBlLBjBv5gW9Mw3ERq/YUcM
	 mJCYHA1pb1XSoH5oQcxyMLGL0Xqzwzw1EvIaJgBnjYEkxRt8PlerCHPMerpcfyc8oH
	 jj3GBZeAXfbAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Dave Chinner <dgc@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] xfs: don't skip free extents of the longest length in a whole-AG FITRIM
Date: Wed, 11 Nov 2026 22:15:21 -0500
Message-ID: <20261112031458.1527264-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202127-failed-5.15-5745f4f10a1a@kernel.org>
References: <20261109202127-failed-5.15-5745f4f10a1a@kernel.org>
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

From: Daejun Park <daejun7.park@samsung.com>

[ Upstream commit 5745f4f10a1a16aa5bb020acc38afa33f2d5ff99 ]

Since commit a66d636385d6 ("xfs: fix fstrim offset calculations"), the
by-length walk of an AG in FITRIM starts with
xfs_alloc_lookup_ge(cur, 0, pagf_longest) and walks down. The lookup
lands on the longest free extent with the lowest block number. The
other free extents of that length sort after it and are never
discarded.

Start every by-length batch with xfs_alloc_lookup_le() at restart_bno.

Suggested-by: Dave Chinner <dgc@kernel.org>
Link: https://lore.kernel.org/r/ZgiJWxVcVwag0fIP@dread.disaster.area
Cc: stable@vger.kernel.org
Fixes: a66d636385d6 ("xfs: fix fstrim offset calculations")
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: adapted the change to xfs_trim_extents(), using agf_longest directly instead of the batched trim cursor ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_discard.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
index 0191de8ce9ced..0bde81c6bb457 100644
--- a/fs/xfs/xfs_discard.c
+++ b/fs/xfs/xfs_discard.c
@@ -53,9 +53,10 @@ xfs_trim_extents(
 	cur = xfs_allocbt_init_cursor(mp, NULL, agbp, pag, XFS_BTNUM_CNT);
 
 	/*
-	 * Look up the longest btree in the AGF and start with it.
+	 * Start at the last record of the longest length.
 	 */
-	error = xfs_alloc_lookup_ge(cur, 0, be32_to_cpu(agf->agf_longest), &i);
+	error = xfs_alloc_lookup_le(cur, NULLAGBLOCK,
+				    be32_to_cpu(agf->agf_longest), &i);
 	if (error)
 		goto out_del_cursor;
 
-- 
2.53.0

