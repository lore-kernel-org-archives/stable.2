Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888921;
	b=L/tJKkKU0OaYMxtOrqkpgZJJ9XgD8mwt3y2NZE7zB7BcYITw73F1N4ZnMg+0JBTarLYy
	 IodNzX28ita1yokJwjKoWfBYl8GCU/nqPkXg3euXuEcH8OY56Mwzz5r+YgtPyW6QtmDBS
	 Us3+j0JvfIWfo+BTDLEnqAB0b2UHdVGYpTIVaoGoMRQ9VB4d7++oc/e7hRLDX4Jl7KG/0
	 fnvp6dW3fdBWfHxLx/QcEgMQwJSs7+d42DP5Pw8CNN5FqnyRfU4yb52mkWKzY3S3DvNcO
	 2W0NOnIzxrWb7QvtPFOaZmEPaap/qjRDeKwRirDqqcfCmZ9Bu4vBjITLzd1CVyiTtMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888921;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RgH3UwRvF41iq/qjpgElHCTtllMU8b9ZvKncDkWdsMY=;
	b=QW9zSFUdKR8zSt7a60P1ge0McjQ3IK58dsfrUrrpvpjmtOQ0J25G+WkHg+L3Zf+llGhT
	 txzHjOY29zihJtI3AlGk6GnyCqWWpIUKO1f3uWmoDznDJ4KxpphgdueyVe7IbpITHmbCR
	 0nuLQ7/hoPpiAi/ITKAk2CQqW2ZH5BgwoO+YfbcLgUAEfr47wizfauounIWNLVjHXEdVQ
	 QPGogoPBvjtR8uFiMBxNkmPi55n6d4pynTm7YeKqVvsfR7IJSuVdesXVYumfk6fu9iFFM
	 8PxEp/gvbkZQ1zxxb+79BhumeoxmwAsmWIYkWa2Bo3oDW5AfvleFM+nqjy+TqyE7jwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BuG2w9Qm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D3B606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BuG2w9Qm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68571F000C1;
	Thu,  5 Nov 2026 14:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793888920;
	bh=RgH3UwRvF41iq/qjpgElHCTtllMU8b9ZvKncDkWdsMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BuG2w9QmdS41zqq7oW+ufxMLlDGv3dF94oF2qFGbT2ZBt2wgORV+B1psIDGamgnRb
	 4dbTDoPFtAibdECa5L/Gecej5X5n7MoQ/vt5oBoFwVYANzE9qoVLN5olAdtavczLyu
	 5Ws8RAI6U3Cp/lvs/Ovkt4k2r97L+B4KZRRYFVDNi+Vig93FeMlluHEBfABlHal6jy
	 rSbFgMSkfUyP8oW/tlbcpOwxy6L7u6S0LRtd8biWAHyj6VbCApj9qfdPQjY6qyyTN5
	 qP6UnAsRk4Yp7cHrf2WvB+dj6xbUER3R47Dvl22xZfUBgJrRLH+HVIbPJVWPAjI1fC
	 IVbThX+9b0p1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] xfs: reduce new btree slack factor if free space is negative
Date: Thu,  5 Nov 2026 09:28:38 -0500
Message-ID: <20261105142748.1658134-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110420-rocklike-immovable-51bc@gregkh>
References: <2026110420-rocklike-immovable-51bc@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 80f13dc7225eec318da7499c7a562d7a34d25e6a ]

LOLLM points out that if the incore fdblocks counter is negative, the
assignment to uint64_t will mask this possibly low space situation and
we don't pack the btree blocks as tightly as we probably ought to.  If
it's the case that there's some free space and fdblocks is too low due
to an error in the superblock field, then we can end up failing btree
rebuilds due to ENOSPC unnecessarily.  This is a corner case, but let's
fix it anyway.

Cc: stable@vger.kernel.org # v6.8
Fixes: be408417630427 ("xfs: implement block reservation accounting for btrees we're staging")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: Replaced upstream’s xfs_sum_freecounter() call with percpu_counter_sum_positive() on m_fdblocks to match the existing counter API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/newbt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/newbt.c b/fs/xfs/scrub/newbt.c
index b818d9b215788..80f9bf7e399b4 100644
--- a/fs/xfs/scrub/newbt.c
+++ b/fs/xfs/scrub/newbt.c
@@ -60,7 +60,7 @@ xrep_newbt_estimate_slack(
 		free = sc->sa.pag->pagf_freeblks;
 		sz = xfs_ag_block_count(sc->mp, sc->sa.pag->pag_agno);
 	} else {
-		free = percpu_counter_sum(&sc->mp->m_fdblocks);
+		free = percpu_counter_sum_positive(&sc->mp->m_fdblocks);
 		sz = sc->mp->m_sb.sb_dblocks;
 	}
 
-- 
2.53.0

