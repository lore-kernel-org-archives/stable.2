Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41ED556BBE
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658273; cv=none; b=eSCidM7ViAZO33Upu3Xkc1KyYCSdaH7BR/WUIgy6cyCWgoKru0pctppdWZwgRCP17dEmgvKoQQ05paFbWdW7doV9l5KVCu6DIMnw5bk+u1Z1VD0h8NE2K1rne+k3N5PtuiyfqjAXt99pRGzItyO0VzrAxMNOSRMVvA/T0DDNhgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658273; c=relaxed/simple;
	bh=LJrtq0dSuy/ijpPEwKYx0lqY9JapWYpUR8iNva8opNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DXYP1cJHMKSceL8TK3InqfL388WtvF2IDn9u/cyECEAzcJZTcMIZiVrQ90nAJRP6rTi7bbWbOX2hLtSLLh97RMEOJKKsC0cG9fZcBl7P9R/UVHma455JP3bVnbGKrIa9nGF/eH1ZCIEOTmGxPqY3vMF9ESHttwuo4oxqpqLcxqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQH+vyCA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQH+vyCA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6FD1F008BE;
	Thu, 17 Sep 2026 15:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789658247;
	bh=xGzKIMSHzOzUJ1LX0u85o5Itjpkeg99VeQtinB3IoQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XQH+vyCADxl02WaoctdYdTR+PTwcyW+nUpDl0XAo/YoszNPw6RrMbnU3NXMWs8Db0
	 80xrxWZ2MuMJKrbEptNwlFJTEuSTuqnTNxHy+s1+DNR0KWskvExUxGoYLYog+2LMuZ
	 FI3CsaTU8O1rWVEZ5Kawr6Z8M76XBy1kf7NzN4KD7KbAPMvAk7biuKIuS2G12pm4sm
	 TPYxqcD9j9bmfUUHuwhNpLGlcaDaWlp/VVTl8l4tHc/tESbepW7t9bCWcQghUzscfw
	 gRD71n9eEpK4jJpiwndnNCtRPnd91UpV1Lv3yiRnHaaqwEcaStHNkyvIjBDUgNuzW2
	 DAbpy/q1Z0nkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xfs: strengthen the "is cow staging" helpers in scrub
Date: Thu, 17 Sep 2026 11:17:25 -0400
Message-ID: <20260917151725.693708-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091609-tables-doodle-600b@gregkh>
References: <2026091609-tables-doodle-600b@gregkh>
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
index dd672e6bbc75c..feb5e2cc80a8e 100644
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

