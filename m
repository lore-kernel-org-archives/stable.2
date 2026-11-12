Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453066;
	b=LkwOyf8ctgTqsskHrd1FwMlDI44NcS8GSL7G8wMNLFkqIe53F+Xp9olWMEqrPFPtrta8
	 4c1O6kE8P4GFihA+lNjX3mkrEh/e71bbdd3MQFRnn0tkThQaivFukfP9jCNlzXTGUgSjC
	 U5wJ9pVF2IdJr9Jocm5wCDKtVpnMXHUwPW+LkleIsk5S7JkI62U3g8I2VXjS83tVlRfVz
	 z3HochiBzlnYJ1iZ5VaUgEfM7oz92aUCyij8xlFDEjfQt6Xjv+nIKxvRlxuQQvGD7+oO7
	 03Z6yr8/tUZE4Phj46g4g0LJHQp9OhkaOzPszmB2KpsLeEdejr+ferkZydycD9E+YOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453066;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vY8GWq58G5MHySgcXqs3ebJL7nhtbVPdFZMqopTL/xY=;
	b=WOc3bEhBqPisJE8gVmXuN72s6WWhB6DBMryh+cRLEVW1j2Sn0M1brXx8fjSewmoXzB5S
	 aE8x1koUPJA0kKGDzuX7lEB/9cBOJUmP9JTFWnmRvVdnUKqLqwvnqEsY5buogoswjhTvW
	 FFa/A9CMrpy3H2ACADRf21GgG1QC3v6+5tQx3jNNtaOv2FtBTAUPfPY0gTFJxACnwxRra
	 5pF8R62PMM7+qBfvcZKtu0PfnSFoOGzQdvEg/Yj0IP2cVdne9ZnveSf0MVn1qKqmEcb2n
	 yzOFwyQTVujc1VoeflpvQRMn3H6dmHeXgLL09VwUy4K858oF8n8yWUEB1HqvpFVwncw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GL5Wpa+F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A73606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GL5Wpa+F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913D41F00A05;
	Thu, 12 Nov 2026 03:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794453066;
	bh=vY8GWq58G5MHySgcXqs3ebJL7nhtbVPdFZMqopTL/xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GL5Wpa+FDHqiY+J4la9f7QgWSwtVV8xZYpW418rPyEuCa+XFTJf2m05ZM1FnYhVSS
	 nQ6h3drNZCRqL2Y9mFvThdve1PUAjwN/uokB9lCYYFFPTS33smlDW8IE6AwjMUCH/c
	 7v+HnwZ+iZT9404DjKsCsFePEy1MVREVfVMiJVMwq28GBPIvvE6ZGTFwqb171T0f8I
	 iP98w7oEWKcm6RDXIolY/MduYcWsQfyazGUiLMYOjzmudkVa1VM+pNg5teZU8n4OJK
	 R8Vu5uEcgv17uJhCbQMqJnEG30VFZ5KPXWq6aGLF9BnU4IklvLkOKKRTBM0ErAvx58
	 sq9VTxX3JGxaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Dave Chinner <dgc@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] xfs: don't skip free extents of the longest length in a whole-AG FITRIM
Date: Wed, 11 Nov 2026 22:11:04 -0500
Message-ID: <20261112031044.1469518-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201606-failed-6.1-5745f4f10a1a@kernel.org>
References: <20261109201606-failed-6.1-5745f4f10a1a@kernel.org>
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
[ sashal: adapted the batched xfs_trim_gather_extents() lookup to the unbatched xfs_trim_extents() loop ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_discard.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
index bfc829c07f035..f6305377add4b 100644
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

