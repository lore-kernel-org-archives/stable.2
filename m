Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088114FB9C0
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 17:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790791084; cv=none; b=n4bY+CImqaGCVqqjt7iSdeeRF+7fiB2YrIHfQQszpYltXUPwWk1P0LrBgF0el8SURVosBooapLnefjhsRWkUnDbyAC3+EsQ9pD4EgZHQgkfr3W+Dl+eTlZrmfiggXRcWBdgRVeOUQjoa2zM7Kxlhz1pQ15eSRVor7TNNW/IHu7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790791084; c=relaxed/simple;
	bh=+PFS+aouN++FP99YakQlILPwOQI/3jQKdtAO9iLGUHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrnlltZoiubPY5Gfh6+ejMiK4PMoMy5wiqqm21oss4Bcp6l/f+ltY+5OzccJVs2Bl1fdY+/gYcI87a6vlIdqKs45sTgb6M+bo8mZN6XUiJwkWb2dxqFuffQUVJLZs1MjH3fFJu465b15lPQAeYuaBsKPDr7bxX7NEVcgyrgvrS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPulzSZe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPulzSZe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CE731F00898;
	Wed, 30 Sep 2026 17:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790791082;
	bh=87E7vMYo772e3km+LEm1s3fiVEmzicTNPx0S0gRh1VY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dPulzSZeqlc586es5T1PiFO+CWlYHJdAWSM2+y8tI783R7VWCzFQZXkiE51t7uk45
	 DCdX6b+ebxp9BF5CiUhggfPqBSvl6+tGgUQGBh3Jo5Jz7HGSuI0T0F8ZLV0pcW3JqE
	 X7lcFWVrAOsmr95WRL4/O8XDpTL7JL69OZqO0C+C1qGj6syKEpcXCktVkky2IQ/Vlr
	 fyct318yHmvVyJFPbiyteqdDCOPSWh37O/T1ET/k2vI9/BtvQQ4neLnPdSUoSqrgYi
	 V82lYeJrkY40Kj1gFc13ZwGQzHM1oAYpirEWd+ejOL+ZcQUkXmqeIUydIBVuH6GeEv
	 vpJDtgVkWCwgQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] xfs: don't let memory failures leak blocks and kill repairs
Date: Wed, 30 Sep 2026 13:58:00 -0400
Message-ID: <20260930175800.3938387-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092928-handstand-epidermal-33bb@gregkh>
References: <2026092928-handstand-epidermal-33bb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit ab1c416d2377cdc16123ef521aac4da1c468c3d4 ]

LOLLM complains that a memory allocation failure in
xrep_newbt_add_blocks results in online repair leaking blocks that were
previously allocated to write a new btree, but the problem is worse than
that -- a limitation of the codebase is that the callers cannot undo the
transaction /and/ return the error -- either you undo all changes and
commit the transaction, or you error out and the filesystem goes down.

However, the new btree space reservation object isn't that big (~48
bytes).  Let's just do a NOFAIL allocation and the problem goes away.

Cc: stable@vger.kernel.org # v6.8
Fixes: be408417630427 ("xfs: implement block reservation accounting for btrees we're staging")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ Changed kmalloc_obj() to kmalloc(sizeof(struct xrep_newbt_resv), ...) to preserve the branch’s existing allocation syntax. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/newbt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/scrub/newbt.c b/fs/xfs/scrub/newbt.c
index 2aa14b7ab6306..1e362e6eb87a0 100644
--- a/fs/xfs/scrub/newbt.c
+++ b/fs/xfs/scrub/newbt.c
@@ -147,9 +147,11 @@ xrep_newbt_add_blocks(
 	struct xrep_newbt_resv		*resv;
 	int				error;
 
-	resv = kmalloc(sizeof(struct xrep_newbt_resv), XCHK_GFP_FLAGS);
-	if (!resv)
-		return -ENOMEM;
+	/*
+	 * We have no way to clean up the allocated space *and* return an
+	 * ENOMEM if we fail to allocate this control structure.
+	 */
+	resv = kmalloc(sizeof(struct xrep_newbt_resv), GFP_KERNEL | __GFP_NOFAIL);
 
 	INIT_LIST_HEAD(&resv->list);
 	resv->agbno = XFS_FSB_TO_AGBNO(mp, args->fsbno);
-- 
2.53.0

