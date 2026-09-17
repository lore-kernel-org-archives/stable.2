Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BED4848B3
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657337; cv=none; b=EeHgzB9jxRT2wdbOzr4Nd65bGWV0YLE6umsbLpnd02mDzwWLuFTCSTyTu0zGUBicY2o+WHnb8rSJn6l1IdvTbOjzHC4Ewdqwhs4Yz2/aEmytQ4aMqy/epF/ibGtlI7PmvY/TrR2TmD3YdmtbZQNiYZ/ow8zvJbbh6hAv4dgurBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657337; c=relaxed/simple;
	bh=CusmJzgAM/myAWoV3RvvprVVmamJ03mi1FHyu4jRh7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMkv2QBhiiMWQMn9Aj2NBSUED75DCSTftePoZnHVxB766+bUWYqzlzQVqhURwUEC2NghBLFjt/wg+zlr4BceNExv8vAwCS8LwmAMY0/tUebAEwcixEDzl0L+1x8ODFabJcP89X35bWdZbe1r1y42xF5szhnWoLj9n4yRqehXKRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mhcy0Ty7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mhcy0Ty7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13B51F0089D;
	Thu, 17 Sep 2026 15:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789657310;
	bh=ypfZYr5NoLmMXnV6QO6t/z96qPM73ie3Gbtu9q0/9Vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mhcy0Ty76J6FV5BaJqF9ghQW6v6iFQrhQ8VDrrS1iIKuAUCPMl4rskf9yp8uKGVjq
	 mU29Ak2I0R4CiJqhYE2fIWY/SLkcdPdw0Tk7OH84rPhU514eWvVeMPcKNrgpQPCFFZ
	 A/cYh2H0swB5w0/4/7zn8LOjetnNllh4rK+ItBVv2R9GNSF+h0mGPob3JMmLPtFoak
	 7sVSdcTzuaYadS/HLEP10T11jnzuqfjekNJoCyl2NBKdv70qa/kclOTzhcT6xKKktv
	 Jq/GGS8/gGtUNhOIGFVaRTwp0PU/Ut8uqAX9cF0W6Fcjb4R4nyt26AZ/diPd7yOy1h
	 ZgL/oA8bvZ5wA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] xfs: strengthen the "is cow staging" helpers in scrub
Date: Thu, 17 Sep 2026 11:01:48 -0400
Message-ID: <20260917150148.671295-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091608-femur-diaper-50fe@gregkh>
References: <2026091608-femur-diaper-50fe@gregkh>
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
index a26ee0f24ef2a..17db5f8bdcd7d 100644
--- a/fs/xfs/scrub/refcount.c
+++ b/fs/xfs/scrub/refcount.c
@@ -443,8 +443,12 @@ xchk_xref_is_cow_staging(
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

