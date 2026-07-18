Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895253D955A
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784389693; cv=none; b=flYzreZpxXiBJZO+V5bTA9XBzCxumOiRaWwaIgXOr9s0D6YCdBodwJmKkNxrVN4O9qGQCXPkJOLtGk1opgSw+ax15CKL7Dhc0XgICpD4t65MRXkTitsVyQkLw+RDXuhYV6FUSB9vBjz9AV0m6Qlg9xy7UXg+6+2HAOk2VxNuI4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784389693; c=relaxed/simple;
	bh=HPbv4Ql2zG7kzz5gw0wyR4cHAW5Xmd98YwCyyqoAh/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHaq9l1w+aN9Sd552Ug51botVap6L4zWWh8m18XyE6C+HfpcV7pJ+jAJpKpIxq8WOWiMYb9VGWztEENgvIs4aapzpk/NQGE3LZGDCghYvbmwccOHGgdjKk5DTdza8LlIqNPbnkr9Do2M6pg7Q/BrDb847Qk1bJ2k1qDJrOQvFaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiBujsB4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiBujsB4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10921F000E9;
	Sat, 18 Jul 2026 15:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784389681;
	bh=HwZpUdwA8LQm6PadOuzgCG7gYRsGiTnF6fcQGcg/0w0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fiBujsB4cK7W5IFDfmekuZTjoYP7ujWZ9njgijTIvyO0V08HJUFyF8GW9zLBihnUv
	 eWHQc8ZMTVoOPEGohW4BaCEVE7Va+vvitNM/uXlvHlaMLKX8nJv1VK0xu8zWZtMoC6
	 JYsaaVe2JThbM4RiQmfYIKQdFw0kZ+6f/0apfZBLbX7XYHoBSUPEaCT4fzOZt11PVS
	 uu50Vt3sWZoDPukL4i1MLAnMO7HQYCfjFAOJZPUK2+zkyUCkhJLdDGRE1qGkwxDmpO
	 Kh3XFQeJdmVL6a45oxkcw+x9obpnPl+JD9MrqNgnbR29X16d1C2A1qay6fMd67YkHj
	 00cEBtdTIjDsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Hans Holmberg <hans.holmberg@wdc.com>,
	Carlos Maiolino <cmaiolino@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/8] xfs: use bio_reuse in the zone GC code
Date: Sat, 18 Jul 2026 11:47:52 -0400
Message-ID: <20260718154759.3315619-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071416-estranged-decree-ecfc@gregkh>
References: <2026071416-estranged-decree-ecfc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 0506d32f7c52e41f6e8db7c337e0ce6374c6ffbb ]

Replace our somewhat fragile code to reuse the bio, which caused a
regression in the past with the block layer bio_reuse helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hans Holmberg <hans.holmberg@wdc.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: open-coded the bio_reuse logic at the call site as 6.18 lacks
  commit 7ca44303f9f6 ("block: add a bio_reuse helper") ]
Stable-dep-of: ae3692c7f440 ("xfs: add newly added RTGs to the free pool in growfs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_zone_gc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/xfs_zone_gc.c b/fs/xfs/xfs_zone_gc.c
index d18c43598d4b39..9ea9166c76d277 100644
--- a/fs/xfs/xfs_zone_gc.c
+++ b/fs/xfs/xfs_zone_gc.c
@@ -813,9 +813,8 @@ xfs_zone_gc_write_chunk(
 {
 	struct xfs_zone_gc_data	*data = chunk->data;
 	struct xfs_mount	*mp = chunk->ip->i_mount;
-	phys_addr_t		bvec_paddr =
-		bvec_phys(bio_first_bvec_all(&chunk->bio));
 	struct xfs_gc_bio	*split_chunk;
+	unsigned short		vcnt, i;
 
 	if (chunk->bio.bi_status)
 		xfs_force_shutdown(mp, SHUTDOWN_META_IO_ERROR);
@@ -827,10 +826,11 @@ xfs_zone_gc_write_chunk(
 	WRITE_ONCE(chunk->state, XFS_GC_BIO_NEW);
 	list_move_tail(&chunk->entry, &data->writing);
 
+	vcnt = chunk->bio.bi_vcnt;
 	bio_reset(&chunk->bio, mp->m_rtdev_targp->bt_bdev, REQ_OP_WRITE);
-	bio_add_folio_nofail(&chunk->bio, chunk->scratch->folio, chunk->len,
-			offset_in_folio(chunk->scratch->folio, bvec_paddr));
-
+	for (i = 0; i < vcnt; i++)
+		chunk->bio.bi_iter.bi_size += chunk->bio.bi_io_vec[i].bv_len;
+	chunk->bio.bi_vcnt = vcnt;
 	while ((split_chunk = xfs_zone_gc_split_write(data, chunk)))
 		xfs_zone_gc_submit_write(data, split_chunk);
 	xfs_zone_gc_submit_write(data, chunk);
-- 
2.53.0

