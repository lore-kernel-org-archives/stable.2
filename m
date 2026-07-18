Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7E62DB794
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 11:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784375467; cv=none; b=GrD25hxWTjkPtA3U2LO172eos9RdGSlsWA3FsT8y6dXthzPU6hMYW8c9mKaKxaSohxa2p++BsDMzltrxBZzN4PWImLW2KPm61evDVlSc63dsUARFQ5HdqZuPG9PoTSj55fxcWX3xh44d8fkPBUpEaA6NTsGfA/XUEy6EgS+pTcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784375467; c=relaxed/simple;
	bh=fwezdNMXgH63n739nHL+zAPjma0pC8ZODbFr8whO4s0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IWsthVNfxu2bl8IkH7BV8nflBUF20CPPYVRDA5Z+BqjptyMHt9AorQE1VI+6omO0uFFtRRC8z3Y3op4EFCBjq0ZIIJIQeLIIcB7slZdMMc6yk2Dkc6C74xXmCj0wEu8l636lBK1tOpF0hYE98/8AVvCSUjegknRQwaQYJCRYz6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6a5Qq8n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6a5Qq8n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8BE31F00AC4;
	Sat, 18 Jul 2026 11:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784375466;
	bh=4CrtiV/7M3SytfYLri43iBfZ4YBGH4npxSbkJBw2BJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d6a5Qq8nP0PX/iK8AZTvPoFT7KCLP2korYq1lGIOIGLf/jf89BU/IYjH4PVhuEj46
	 NACHX5ZZKw7mIjhb1GjSN7PzvG+2B/+86ImY/JrcQX46UXBdtThNLdQtteiHZZ1lUE
	 69m0AXUdzBRjs4/m+GhwtewvIdSz3NK699HnfYujPMk89FGaMOubfZ4gNgaUeYRFIU
	 ATnPND1wsoBzV8UWudacIwYd9H+/3cT4AxW0gWx1XgN/SXiA8Ko+l/Xj7drpUPWfr1
	 G0JqC3seF5j7OqW9LuCyY03SOaDWnNYVi533aaoHSStSVoYFwv9Z7nDlEKiXSBE1SH
	 a1BEcIqSwPWbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 2/2] xfs: add newly added RTGs to the free pool in growfs
Date: Sat, 18 Jul 2026 07:51:03 -0400
Message-ID: <20260718115103.3085836-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718115103.3085836-1-sashal@kernel.org>
References: <2026071416-friend-sanctuary-1a9b@gregkh>
 <20260718115103.3085836-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit ae3692c7f440c1ff577aae1a51202415ec4a794b ]

When growing a zoned RT section, the newly added RTGs also need to be
tagged as free in the radix tree and add to the nr_free_zones counters.
Call xfs_add_free_zone to do that, otherwise using up the newly added
space will wait for free zones forever.

Fixes: 01b71e64bb87 ("xfs: support growfs on zoned file systems")
Cc: stable@vger.kernel.org # v6.15
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_rtalloc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 153f3c378f9fb7..debbcefdf07f72 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -933,6 +933,14 @@ xfs_growfs_rt_zoned(
 	mp->m_features |= XFS_FEAT_REALTIME;
 	xfs_rtrmapbt_compute_maxlevels(mp);
 	xfs_rtrefcountbt_compute_maxlevels(mp);
+
+	/*
+	 * Finally add the newly added zone to the freelist and add the space
+	 * to the available counter.  The order is important here: only add
+	 * the available space after the zones, as available space guarantees
+	 * that zones to back it are available.
+	 */
+	xfs_zone_mark_free(rtg);
 	xfs_zoned_add_available(mp, freed_rtx);
 out_free:
 	kfree(nmp);
-- 
2.53.0

