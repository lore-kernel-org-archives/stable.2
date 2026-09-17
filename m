Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E92560AB1
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653729; cv=none; b=PxETUou+uZW95P4RhZFRnW/pMCJrrXVOhEBHO1l0YEBr7oJNfzU39p1Q6h/O3dnuZs1DkR3RSJcInPGUhYpt0qv0xKHLMGjSjXyhOm3x7xLh2rAygSilIJhWJW//pXw+OIvr8BwfIxCcv5PUPsMd+LfXWFYmqTQb1Gg+5Pla+s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653729; c=relaxed/simple;
	bh=Rjl5k8SWyA+MJuRKrltsMw+43OIgPWiGUUCncJAgTnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMlpXpiLYuWRmSGop+bLIcBUfZ2j5ZaQITUBDTVbjxACOe482xXqo+uRmFPCIDd2nqvf0gI/CnyWttokEnBDSFB+mNICZeB7hdmwx1F4LqvaWAwMge6sfRpB2vQTYRVQw3Q2SWMiM3k/kb67f14oMVMh6OHfUK6TDZQvxVlqnek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jH3dgglw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jH3dgglw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023921F000FF;
	Thu, 17 Sep 2026 14:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789653727;
	bh=mhnXxn/RJ9+npyQAyk8vMf8YaBW0kyLYeFzKC17YB10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jH3dgglwKidnKna5pTUxdnapECR6NRLwfOcrIKdc2R18/51pOPULtaI1m5Q41pcj2
	 pOn7tCcj7AdCuI0JYAtXd+wZk+Kb5ErJNu+AZba+SV0YZ6GsCiLlde5H9lyaI3of1P
	 6U8NOzF2E+8DfxSOQtFQTEiLic2W0/VFF/mKBEuk40t6EPafduuDZquIcn+UK+3yLm
	 y1q1SDaZ5vkLvw8hS5fWahkMb3g6riKGauCKmN3up1a20xEVF4XwcrCoNrOPO9wCce
	 nIE7mYUTg97YlYLcm2iRiuypXhUBuOPsjUO2IB5ZIIeYQIUYEQHbGvOgPySq8T5F9a
	 Un/5GIAIcK+OA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] xfs: fix short ifork reaping computation in xreap_bmapi_binval
Date: Thu, 17 Sep 2026 10:02:05 -0400
Message-ID: <20260917140205.505194-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091658-cornball-gerbil-7e76@gregkh>
References: <2026091658-cornball-gerbil-7e76@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit eacb8479507756c3305994e87fb2fb1183827e98 ]

LOLLM got really confused about the update to imap->br_blockcount in
xreap_bmapi_binval if xreap_inc_binval returns false.  The intent of
this code is that we shorten the imap to whatever length of space we
invalidated so that the next iteration through the loop will start
wherever we left off.  Unfortunately, the calculation sets br_blockcount
to the amount of *unfinished* work, which means that we pointlessly
re-scan blocks that we already reaped.  This is benign, but we should
fix the computation anyway.

Cc: stable@vger.kernel.org # v6.10
Fixes: 5befb047b9f4de ("xfs: add the ability to reap entire inode forks")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ Adjusted context to retain `invalidated > XREAP_MAX_BINVAL` instead of `xreap_inc_binval(rs)`. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/reap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/reap.c b/fs/xfs/scrub/reap.c
index 8688edec58755..adce759f1bff3 100644
--- a/fs/xfs/scrub/reap.c
+++ b/fs/xfs/scrub/reap.c
@@ -861,7 +861,7 @@ xreap_bmapi_binval(
 			 * much of the mapping we've seen so far.
 			 */
 			if (invalidated > XREAP_MAX_BINVAL) {
-				imap->br_blockcount = agbno_next - bno;
+				imap->br_blockcount = bno - agbno;
 				goto out;
 			}
 		}
-- 
2.53.0

