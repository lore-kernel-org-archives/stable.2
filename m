Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C2E4B7A43
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657755; cv=none; b=d1LEA9OPzgHZBDlpR6g6aGaWWJus5f5GkJC5c3iRLbSnm3ildL9iIYyno00K2OaE+nj0xgI2XH3XR4sTjXHPXHpV4RrTBrBxOKxGzOKWIkdkINuSlLzrDrME5am8mPCItGy2upzNB71tjyxqyFXL7gCmgS9H41Rwj6LWM4+q9Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657755; c=relaxed/simple;
	bh=Qf/2XXNTiJ954lOYbKq+UVIFPtzqH+q5h/q1mIlFU9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8tLjAPpb8XvN8IaQwXMPUFJG78yKGVXKGqb6P7H3dhTyo14X/QDng29M8Lr8Ng1cvrcG2x1a84aJVNNEVhgwElQ5JLSLG/w2YBFeAYSuPvvuJ+7ZMrc0z8WglDqRwxNmADUQlETuiWWCQ1yiSXaVuVFbnX+16x541HE+jzZKl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GK84NXYk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GK84NXYk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612F51F0089E;
	Thu, 17 Sep 2026 15:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789657740;
	bh=UXxxLQG7pOlSCvtEvnPDRbWNQedfyHWEc7iQoL1muJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GK84NXYkQBSoOMRBqt6vFxLm98pi9GRc/9aE+6C2BcDqmq65vV7kI5i7ru5rsV3r7
	 9PvbxCG0ifErwX6A30Mq1XqfkCPt+l+X06tTrK6D9Hgsc+KSHA6y7HGuRrYOPrjP3t
	 GcMKyMjmmNJEQnWYj5UH9bachitomrM4Lw6qSTf6I0+8YNPfAGQs8gOTEY4F/rsQIq
	 reHlR7QjGp9ZYDyjKbT+Su1kuh1MC6Lp9ExopCjDf0rYkPQa5/JlGKW9iIjU+/+WRb
	 KM/G51EUj9XEPlVvdZUf0cs1XWObzL9I94DFcIKWfBNuX9UYCRrJu/igyI+5V3i/M0
	 2WFq2mBfg3N8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] xfs: strengthen the "is cow staging" helpers in scrub
Date: Thu, 17 Sep 2026 11:08:57 -0400
Message-ID: <20260917150857.682062-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091609-voting-wager-2b45@gregkh>
References: <2026091609-voting-wager-2b45@gregkh>
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
index 2744eecdbaf01..660af9b1acb05 100644
--- a/fs/xfs/scrub/refcount.c
+++ b/fs/xfs/scrub/refcount.c
@@ -455,8 +455,12 @@ xchk_xref_is_cow_staging(
 	if (!has_cowflag || rc.rc_refcount != 1)
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

