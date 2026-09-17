Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89CE45921F5
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654145; cv=none; b=Ed+fozThIo93O3BNSFa9z8ZVCxSXjDxDWkx7cnJYT5UodYkoBFb+eG0k1ZK9XYx2Cekngq8DSuiT+Sw8ApLDhsTGSU9beFtAQhBRd18GZ9GcXK4p/tMUmY2zaXQMsTp2eeKlPuH+2Rezw27vyRzXar2dSBVT4DBQv2ldgubDqnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654145; c=relaxed/simple;
	bh=5VBaW+t0g1L3Vb1XJudNrTSonwSLLuDrKkzqjgZTCf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsyqD/ABuQwYDa169x7TcYmm4nmt1s4H8ruGjk/enLs7ixavrBsAiy2IYextrVW5ZCmxRUTwBgQJg3smNvCQuuquv6WldFlbCKiC4utQB/1H8CnLtrVUDrEXIFAr0xewIZ8AkhGpBoOW0Hv+X10y7TBW0nWPgU7E8wf6uKqlLQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jW9WlxJH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jW9WlxJH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E80E51F00898;
	Thu, 17 Sep 2026 14:08:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789654135;
	bh=9oXHucm6HiBZEY/uzNOczsJZStTkEQWu6RkdCGlCDz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jW9WlxJHwYFB/5dXNM5B9ubGjN0/hl+PdPilbY8LP3KNOfHNMrUM/mbBlVtxnXsmF
	 faTE+7gEHb4Ws/cYs1sv/Y2NOqfBMe34Y5ZhJhvmd4pbqk/u/vVaXd/EG7gYxiY8Gd
	 ikZdmWYU+EFoVj/Q4af61amk+uLra/Zm06/tYklZYatgGx5Wi18mTWAymYU7y8a2xb
	 ap2s2HqCcDmokrRqWmQ4R3Ko/67wY364Dtp+KhjDOhCbD/cPmG/k3C4jLOI/7HwPVQ
	 47KAAuSDJMLhgt1/CecQYLOChJD6CRBtXim2iFWAzm+dTxH2GqeWChjYXkBNWdKuoj
	 hq/IxHvZMaTXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] xfs: strengthen the "is cow staging" helpers in scrub
Date: Thu, 17 Sep 2026 10:08:53 -0400
Message-ID: <20260917140853.514422-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091607-platonic-empathic-c32b@gregkh>
References: <2026091607-platonic-empathic-c32b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 0d43368844a75ad13561a1198a3b027940730756 ]

LOLLM pointed out a bug in both of the refcount scrub predicates that
determine if a range of blocks is marked as CoW staging in the btree.
While it compares blockcount < len, this isn't enough to determine that
the CoW staging record is at least as large as the range passed into the
helper.  Fix both of them.

Cc: stable@vger.kernel.org # v4.16
Fixes: f6d5fc21fdc713 ("xfs: cross-reference refcount btree during scrub")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ Omitted the rtrefcount.c hunk because Linux 6.12 lacks realtime refcount scrub support. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/refcount.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/refcount.c b/fs/xfs/scrub/refcount.c
index 304ea1e1bfb08..807785a2e2467 100644
--- a/fs/xfs/scrub/refcount.c
+++ b/fs/xfs/scrub/refcount.c
@@ -569,8 +569,12 @@ xchk_xref_is_cow_staging(
 	if (rc.rc_domain != XFS_REFC_DOMAIN_COW)
 		xchk_btree_xref_set_corrupt(sc, sc->sa.refc_cur, 0);
 
+	/* Can't start after bno */
+	if (rc.rc_startblock > agbno)
+		xchk_btree_xref_set_corrupt(sc, sc->sa.refc_cur, 0);
+
 	/* Must be at least as long as what was passed in */
-	if (rc.rc_blockcount < len)
+	if (rc.rc_startblock + rc.rc_blockcount < agbno + len)
 		xchk_btree_xref_set_corrupt(sc, sc->sa.refc_cur, 0);
 }
 
-- 
2.53.0

