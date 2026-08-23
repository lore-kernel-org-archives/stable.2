Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990C735975
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 18:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787508255; cv=none; b=IqzpBbBI/vMgyMWtk5C9w7E6tUKtvjjmJEbHcN5ppxQNxD8Mm8EaXEXBKUM7wKfTLCqkXnj/CulswfXNJKphQBGLARZY9AgRkMOOTM4jIaS4VmBZDO1/lNLX897eIyVh0knx+8/hQQAx4e1PjB3KCVql5Jm270KNlG7FxJlJSrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787508255; c=relaxed/simple;
	bh=lrAYkzx4cAEP7Oto2qChwArApuX9hfnNYdIVz6ADCkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3Rk7lpVup+NhGT3cXsrBOf/Ig8Dqs9ishz10odPRYeKKJYGEAKE0GNBhdWiB6DxEwieEch72Q+lXBJfDLLHogjztCdiHd4jpZV7cHiJ7Q4jZBY6p7siycATcTcU3jBQ/m/CJIo+0LbxjkNqBPQHL/R1RsTo1DcgGG/5HdM63mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0pyS3Zp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0pyS3Zp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B82F71F00A3D;
	Sun, 23 Aug 2026 18:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787508254;
	bh=QbE+gUrtiaAyw17SP+6cF75PKm6+lsJl7RZ/dIbBf7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h0pyS3ZpxR18tjy2NnkgK/JLkR+Rcp02D1q1JOmkQ/aWIiY0SJzkE0LK/5TeWSCmw
	 EWnS2Dj9DSNBsSzzHzl5e8OKISDC8G+KRiixTjv++guJteWQmiLYlDvKdOFDrYVjnl
	 vvFqiPM3FSBZPlE3S5iS6LUZR/q4QGDEsMT72ZySyKDWv6aXs5bnQ0skjMuj8S+PU4
	 OtMzDg9zlJSmM8RJ1J6XWDimWz+9xshkCTwzeqiCF9sy1i/fAfxqv1vDrGEfDfQroR
	 /s+AXvfwEPwZaa5nAY6Zc9Hdhs5X1ATvwM+2SK72SvuNFZQduPCfJdOH1VYK4rNI9e
	 Fwhfpn5tV94CQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 2/2] xfs: rtsummary scrub should treat rtbitmap corruption errors as an xref error
Date: Sun, 23 Aug 2026 14:04:11 -0400
Message-ID: <20260823180411.1424993-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260823180411.1424993-1-sashal@kernel.org>
References: <2026082037-faceted-nearby-f8fe@gregkh>
 <20260823180411.1424993-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 8ed78104722b57df69478b0b1608a408c1036085 ]

LOLLM notes the discrepancy between the comment saying that this is an
xref error and the code, which marks a (non-xref) corruption error.
This appears to be a regression.

Cc: stable@vger.kernel.org # v6.13
Fixes: e3088ae2dcae3c ("xfs: move RT bitmap and summary information to the rtgroup")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ changed `xchk_ip_xref_set_corrupt(sc, rbmip)` to `xchk_ino_xref_set_corrupt(sc, rbmip->i_ino)` since the renamed helper is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/rtsummary.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/rtsummary.c b/fs/xfs/scrub/rtsummary.c
index 18074c1ff166a..8decb4b1484b5 100644
--- a/fs/xfs/scrub/rtsummary.c
+++ b/fs/xfs/scrub/rtsummary.c
@@ -358,7 +358,7 @@ xchk_rtsummary(
 		 * EFSCORRUPTED means the rtbitmap is corrupt, which is an xref
 		 * error since we're checking the summary file.
 		 */
-		xchk_ip_set_corrupt(sc, rbmip);
+		xchk_ino_xref_set_corrupt(sc, rbmip->i_ino);
 		return 0;
 	}
 	if (error)
-- 
2.53.0

