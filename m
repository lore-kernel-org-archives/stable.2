Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C98B4B7A2E
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657748; cv=none; b=oNyzcKcim5YaOyzHsAHmTRAV9TN35+38ph7KvCyp3djzDUpgAk040p+YUv4BEnaAu2oCUajIKUWm8WFZlrWSdNetO1AQU2u36BtBA5vo5A+dBCQ16OISNSexAzH4dl3q0+Nes7MbCixq/deVc/jEYQ/nu7KEIIEbOgISUGJ7sb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657748; c=relaxed/simple;
	bh=DKAea4hLw/vHKN3BqrHIx/FQBAtGlleEpEGH/9SaogQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ufZhrA36yshsQkfc3na+fCfhp5PtJOljiRmTC9bUL3PtUgHnu+MygJjjNShXyIKDqueTYEqvrNB5PZVjhrvu5ivPvu20NC2oYCVjl8XeZelOb0QGwO2GNHzgzRX2P2yLqxMJRrmus+1NHqVU8k2Gb5SJNTd24cMxp40Dz7upPss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7yMQvI6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7yMQvI6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D8A1F00893;
	Thu, 17 Sep 2026 15:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789657737;
	bh=BpHICbLUPXpQ7udgiSC7il2Qm93b8aIDuqCYjPmihJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j7yMQvI6iJKTLIlR4PNRj8z7THcCHxmsy+3AQPQSFSnc09qFQNdWHHH0n8BA5Sn0g
	 hJqLbj8YIi78u8LvGMAX9M0zmYkCobLuF866CtEkvZ3DleMHa0ng9OS3tTcSBlzsR2
	 BqiIb9kPX/24XiecyIQgwTWagri8MVjYe4WbAY42Qw+LjGE42Itfs1dOquCrBRPuo1
	 1vlSXHcikL3sdumSsNFFKwQv9uuZFDuSuW6lmDsZ5CsAAq79fBOVHZGtDlSbGTRLBu
	 1qzH1udXNRLKOYlTJFMNNRYM4Fi1Z2Gc8jQtyXHP9oQ8iZXHDZbdQjpfWyAMiftOt9
	 Cxk8VnhPl+Mrg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] xfs: fix backwards mergeability logic in refcount scrubber
Date: Thu, 17 Sep 2026 11:08:55 -0400
Message-ID: <20260917150855.681851-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091615-operating-mutt-0936@gregkh>
References: <2026091615-operating-mutt-0936@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit e8b01aaafffe6b852325debdf1ef4b13ccea1cd7 ]

When we start the refcount or rtrefcount btree scanners, prev_rec is
initialized to all zeroes.  This is done so that the record mergeability
checks skip the first record because you must have two records to
compare.  Unfortunately, I got the logic backwards, so scrub has never
complained about mergeable refcountbt records.  Fix this bug that LOLLM
noticed.

Cc: stable@vger.kernel.org # v6.4
Fixes: db0502b39c21d1 ("xfs: flag refcount btree records that could be merged")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ omitted the rtrefcount.c hunk because the file does not exist in Linux 6.12. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/refcount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/refcount.c b/fs/xfs/scrub/refcount.c
index 304ea1e1bfb08..dd2c52807e40b 100644
--- a/fs/xfs/scrub/refcount.c
+++ b/fs/xfs/scrub/refcount.c
@@ -399,7 +399,7 @@ xchk_refcount_mergeable(
 	const struct xfs_refcount_irec	*r1 = &rrc->prev_rec;
 
 	/* Ignore if prev_rec is not yet initialized. */
-	if (r1->rc_blockcount > 0)
+	if (r1->rc_blockcount == 0)
 		return false;
 
 	if (r1->rc_domain != r2->rc_domain)
-- 
2.53.0

