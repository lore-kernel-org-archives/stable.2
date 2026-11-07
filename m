Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048434;
	b=Ql4uu7D0wlbDOBJAIEuZPMvLJ3R0TRb5VSQ+w6Ctzl2zF7zYV2ejSlCw8wJqohaUo4fc
	 G4mGGimtvrFiK26KawgTY+bWCw9vIcrZ3CxmbpHEdlXb4X46t71dAueEgcscvO8DxnH4W
	 DYIaF43MgxKG96DZEbNyMt9qoTTEFrqlko0zKCVvYIULSVeaNyaEmcsJFKV863hE09P4d
	 E8hdyrkv8lrXGe21cpY7kv1EM+a/rltvOcyQvuECh/akaxLQRja9o6tcVB7RX0Fplcpma
	 jTBCSUDmppVPjlRVuRNuqV8spjJmNZi/xPUrHYugbY6XH5sfqG4Lto/tQxPegy24E+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048434;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=e0XsY88RfbVKUczZPmgW/bG2UMvXsZhbmPIbcbgXYNM=;
	b=Q2zN1MZMXLESDmn350Riq0j43PcfiIG0S5qHzo0Evs9GMYmKAYkzMdCvtYP9TlXAjS8W
	 Q/DNNR5jO5boPWcSrKv0OjK9Gndu76a6PttTO0tmW7u44I3FKhZPBJuh6kEfJAOr1w1JJ
	 GFJbVZTWwUv3623UxmJCeUX9oTVLCqCOGrcLNe2yovEf3pLk9dV9clnDnL1PvMvpFtqHZ
	 bf2/PE1LInZMyLrNGoPHEGOclWMtyVxkRpntj99nNALi4BN0pn9wCRINhURB14XzRDWrc
	 eJXC438WjrbeoXRtnQqY8oIjrxilU8X1ap9r4+4pWUOzgy5zlm6XjmfdIfV1UT20hJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=emkPc2iQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36D0606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=emkPc2iQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA901F0089F;
	Sat,  7 Nov 2026 10:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048433;
	bh=e0XsY88RfbVKUczZPmgW/bG2UMvXsZhbmPIbcbgXYNM=;
	h=From:To:Cc:Subject:Date;
	b=emkPc2iQMOYnA4iNDtSa73QMtnqf/uHerR3U5TJHqePpwR/ZyX19M6JZsY6uelCcB
	 VXCYgSrjDI6IIrbER+fiOL41nYqljvrWx3n4uldATfg6FnXefDwYcXJAtSxsQvodWN
	 odAiSzBBKLAT2ETPMYknTLcaDOrNdV2/kev2Y+BBPp2QzvQnZQAD606JihrQS0cnz8
	 V5Wp0B2bENCLY1p9y998vrA/39cF5uH6MraViQkqWeK7MWLsGwWB22P4nUDUjtjHDI
	 JgXbhSBa9lmiIsJibxe9CAfEm5BX7n8ENHoMJUHE+4ThrFAGIdxrba9cnuqxjwfkor
	 nWb/pH4PEBLnQ==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/core-kunit: test invalid damos filter commits" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:47:11 -0500
Message-ID: <20261107054711-failed-6.1-409d2ab6d982@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 409d2ab6d98209c30d45123920721710475a30b4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054711-failed-6.1-409d2ab6d982@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 409d2ab6d98209c30d45123920721710475a30b4 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Mon, 14 Sep 2026 07:23:25 -0700
Subject: [PATCH] mm/damon/core-kunit: test invalid damos filter commits

Add test cases for testing the validation of damos filter arguments in
commit time.

Link: https://lore.kernel.org/20260914142327.92510-9-sj@kernel.org
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@davidgow.net>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: <stable@vger.kernel.org>
---
 mm/damon/tests/core-kunit.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 2b0931cf6fb32..527abc2570616 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1184,6 +1184,13 @@ static void damos_test_commit_filter(struct kunit *test)
 			.allow = false,
 			.sz_range = {.min = 234, .max = 345},
 			}, false);
+	damos_test_commit_filter_for(test, &dst,
+			&(struct damos_filter){
+			.type = DAMOS_FILTER_TYPE_HUGEPAGE_SIZE,
+			.matching = false,
+			.allow = false,
+			.sz_range = {.min = 456, .max = 123},
+			}, true);
 	damos_test_commit_filter_for(test, &dst,
 			&(struct damos_filter){
 			.type = DAMOS_FILTER_TYPE_UNMAPPED,
@@ -1197,6 +1204,13 @@ static void damos_test_commit_filter(struct kunit *test)
 			.allow = false,
 			.addr_range = {.start = 456, .end = 567},
 			}, false);
+	damos_test_commit_filter_for(test, &dst,
+			&(struct damos_filter){
+			.type = DAMOS_FILTER_TYPE_ADDR,
+			.matching = false,
+			.allow = false,
+			.addr_range = {.start = 567, .end = 456},
+			}, true);
 	damos_test_commit_filter_for(test, &dst,
 			&(struct damos_filter){
 			.type = DAMOS_FILTER_TYPE_TARGET,
-- 
2.53.0




