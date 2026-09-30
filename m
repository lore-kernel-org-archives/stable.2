Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC31A51EDF1
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 17:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789657; cv=none; b=TgG2dUaxtUdLBKTY34ryn6FkCkjzV5wFtUuWXkFpPptRG1spoegJ6xSwbRTMzxMWqH9COjql26IN3mEH5t8A2AwbFKA1ddvG62eaYLbhs0NIx3pJGy/r5Y4cqFj8dTs2XvmzUwX4xja6q/7CpCyOZmhCAPXkooVjzlTfJ9Th8Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789657; c=relaxed/simple;
	bh=SeJLcHSa1UU1HuiiAt6ShTENKLfmDB5EHwB//8VWXkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iV68dsCBo8VO7Lu7EQ+W59T10gamawYiVZwgcS83akSmDyBurKR4rwUqGs4DY0S1a4kML5LmtuYlnG6YudB/kz+nrye5bLS1MvBzoIb3ot5xNWtYTSTNZOyhLWx+dDCrsoeQzJx4V7tY3/+pSVza7fEoHyG9pc0oAd6e9KOc28I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JzeJWmc5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JzeJWmc5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE701F000FF;
	Wed, 30 Sep 2026 17:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790789655;
	bh=zpj4YbffJ67kCLEPuCG3B7IE1jjHGsSNaHGvWWHNRdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JzeJWmc5zlsvbcgfH886l2nncU43LofiUa+PYfXTzrRJ/8dECuHz8AvzHJ68qs6lA
	 qx4VIMD/kH00i5zn0I75TRJcOh2S4ZWQ+NcBkEOx2KW3G83Z1TnoKpfc4KO0g42+37
	 nPFl5DgWoiKaSYEiezN8U1K9vWOwFpQedToHVZkaH+CLa/vuB35NHJWiBXMEb5ZVED
	 6SblOEeMMuJhWXySk59BRVlpuqkkhQZbScBVO6kXtVvle9Xgl/hBouxnSPmTTjlFhp
	 9Vgvkdxc8x2P2VmZ5fIbK0ZKmj+3EooPSt2jzYS3G8YlTBcEZOKig00jjO+w71mrUi
	 rAYdsGfpJvqPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] xfs: don't let memory failures leak blocks and kill repairs
Date: Wed, 30 Sep 2026 13:34:13 -0400
Message-ID: <20260930173413.3642887-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092928-daydream-aroma-1dc5@gregkh>
References: <2026092928-daydream-aroma-1dc5@gregkh>
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
index 951ae8b71566c..2a9547789c5c1 100644
--- a/fs/xfs/scrub/newbt.c
+++ b/fs/xfs/scrub/newbt.c
@@ -195,9 +195,11 @@ xrep_newbt_add_blocks(
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

