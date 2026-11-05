Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890939;
	b=VeZ/c0dEPE+JdfJCI9gEmye82Eb3rO6q6i8plsGeS8NxVpnhdS4102fV+jPnnC1FbNWw
	 oxUrYKx/af88OOOKqUHk9aw86iYyNDh2pnMKkCcgWNpTQb4mclLhy/EfaBZI+KMcoDalF
	 iSHuGBPQzPoM+bf6Kc/unMgtj8N94T/UGh0SUB33vC2bkEm5KI4rZBtjXQXTxSFzzwppu
	 dPVxQm1wR25DVLJprciSdD2+o6fsHL7gz+kYwHJC+WflLnTafy89eMcxIYRV9HAAfKugg
	 SlUlZfw0htHZjOyniTljAt1QMXn3FcoZN4GoFtx3FlAxz7OztQDjAy4jRylCWhSeR0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890939;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ixCVT93bZaTNeOx4Am48PMYfOqT+BPUN0teQBsYh70s=;
	b=hR4Du6/9ktr3eiQAQqNq0J8xJGC4EmOFLbOEMn7LL+KJ6PecPdFBHtuJDoAbbrH8inIC
	 /3R5V00cXwCyOv+ryCU38IvdihRdtk1QPP5PsnUrZMlYolqHMc7Np/VVIPvcMpIPHuu9v
	 C+Gx59UtGfUhrI7gssv+xQ9s0TlD56w0TQjNjuKFLXIUpRspMWUJuPPEUeSJPXGJ1bhUh
	 JTdk81AoZoqRJ2mMkSj9zlfes4IlPoUdu4Ttz3+AVhhDCvi5VFtFxvST/3BD7OOPsccnx
	 8u6V+72wnIEubA1LtczaFSHK3i4yyaegUyFmXst/uIM9W1MFNGE4WRyfMLxamg09OfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kY4+qsZf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2226606A33B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kY4+qsZf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14671F0093A;
	Thu,  5 Nov 2026 15:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793890938;
	bh=ixCVT93bZaTNeOx4Am48PMYfOqT+BPUN0teQBsYh70s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kY4+qsZf148NeWusgmPhq29uK4lBc87eQ4iQbn6V350LBAbwzDtWHLX7g83wKvyNs
	 S+qOiQAMhLXmeWPEJu7am7fNdVAFDk09qn3p7SKqhZ1oGFJGroz6jLuTzEdSjsNInb
	 BrkCjaCBPoX1wTsSUBKNspqYCSVr/Kbjrxt4qNddqfI7JirkwKAuJBYpobxfIoGNUm
	 7AgcRr9dEN5U8yyzWL1K6z7KBsvXK/3/yChdY0Divt5OyTaSfIxgTbLtRBCB5YSC5m
	 zzmRbKR+fuUcbvAjBVz2SxEmo31vTMTNn+nZFSLdmzvE2u5qSBzclbOcHZ6tBsAZua
	 K1+hDbIBC2G3g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] xfs: complain loudly when dirtree checker finds broken links
Date: Thu,  5 Nov 2026 10:02:16 -0500
Message-ID: <20261105150119.1835271-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110432-statue-level-5b8e@gregkh>
References: <2026110432-statue-level-5b8e@gregkh>
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

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit e09438cab72c2c6a32665829d4186155346bfee8 ]

LOLLM observed that the directory tree walk code bails out if it finds
broken parent pointers along the way.  However, it flattens the return
code to zero, which means that we can end up in the repair code having
not completed the scan.  We should never proceed with a repair in this
state, so let's mark the scrub incomplete and exit.

Cc: stable@vger.kernel.org # v6.10
Fixes: 928b721a11789a ("xfs: teach online scrub to find directory tree structure problems")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: Retained xchk_ino_xref_set_corrupt(sc, sc->ip->i_ino) instead of upstream's xchk_ip_xref_set_corrupt(sc, sc->ip). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/dirtree.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/dirtree.c b/fs/xfs/scrub/dirtree.c
index 8933506c4830a..35848cbfae929 100644
--- a/fs/xfs/scrub/dirtree.c
+++ b/fs/xfs/scrub/dirtree.c
@@ -849,7 +849,8 @@ xchk_dirtree_find_paths_to_root(
 				 * A parent pointer of @sc->ip is bad, don't
 				 * bother continuing.
 				 */
-				break;
+				xchk_set_incomplete(sc);
+				return error;
 			}
 			if (error == -ESTALE) {
 				/* This had better be an invalidation. */
@@ -970,6 +971,7 @@ xchk_dirtree(
 		 * parent pointers are corrupt; this scan cannot be completed
 		 * without full information.
 		 */
+		xchk_set_incomplete(sc);
 		xchk_ino_xref_set_corrupt(sc, sc->ip->i_ino);
 		error = 0;
 		goto out_scanlock;
-- 
2.53.0

