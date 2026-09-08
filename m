Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94C35437D5
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872184; cv=none; b=EzTdvi0T+NJD5wuLDLB3SMqSx7VAz0nJGULdOj1NreajpjHZVhXUJt32Pk2S7fQsLkDldvBcm/uG6zc3x0NjQmP0ESX6r53nL/39ZL0bEGsPnmEV4NW1sdFd3gT6rnV7ndWkuadqa0nSWO0asqhEVyD1JfIvtlWhBJPRL3/+ZGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872184; c=relaxed/simple;
	bh=+7Uc8vL8nNnOYhR1jkRBrTBLmas4dB/Iz4eRjAtMwbc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VWlKxAv/5KQm2Sq2RFrkKqNrVZpJrmklk/DszGod7IM0ufYm0mTRJuDqStal8tpz/2CJ4+NYvD68JcJpEgcNdmtlLG5aEYwAs5l1UUZd+JLVbjuq1H2MunYDPplDb9HK0ZHLBtdQeJkMR+x4G2NdeQYWkIUVZ2tsh2Rmed73GgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i7J3VXBx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i7J3VXBx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AA71F00A3A;
	Tue,  8 Sep 2026 12:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788872182;
	bh=DZbSR9DBChGg0cAxdfvlTSoUTq7SbON6uygBOiB5PWg=;
	h=Subject:To:Cc:From:Date;
	b=i7J3VXBxhEflQN4ILFojtRBia+cxHJIQ0DznJYhzPYzT4gX0JUHpBrV30cnbsOG/H
	 pQin1X77azkAWwhHdFgb0wSS/oNoDdlCgCTruXiDJdf0owHTAVEEM8KbOHo6dKfqwm
	 ngbIU8y5qpGZPuRyE1ZxfCY7QFwK3nsfzJxZt12Q=
Subject: FAILED: patch "[PATCH] mm/damon/tests/core-kunit: catch test failure in" failed to apply to 6.1-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:49:09 +0200
Message-ID: <2026090809-vice-ribbon-cf5a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b640708929aa956235866bf7717d89018c661083
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090809-vice-ribbon-cf5a@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b640708929aa956235866bf7717d89018c661083 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Tue, 14 Jul 2026 20:09:57 -0700
Subject: [PATCH] mm/damon/tests/core-kunit: catch test failure in
 test_merge_regions_of()

KUNIT_EXPECT_EQ() does not abort the execution of test code when the
expectation is not met.  But damon_test_merge_regions_of() code after its
initial KUNIT_EXPECT_EQ() call assumes the expectation is met.  It does a
per-region test with a hard-coded number of regions that is correct only
if the expectation was met.  As a result, __nth_region_of() could return
NULL, and the test code can dereference NULL pointers.  Fix the issue by
catching the expectation failure and skip the per-region tests.

The user impact on realistic setups should be negligible, as it is a unit
test.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260715031002.108504-3-sj@kernel.org
Link: https://lore.kernel.org/20260710144937.26981-1-sj@kernel.org [1]
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 485472ddebd1..eba643762132 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -260,11 +260,14 @@ static void damon_test_merge_regions_of(struct kunit *test)
 	damon_merge_regions_of(t, 9, 9999, ctx, true);
 	/* 0-112, 114-130, 130-156, 156-170, 170-230, 230-10170 */
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 6u);
+	if (damon_nr_regions(t) != 6)
+		goto out;
 	for (i = 0; i < 6; i++) {
 		r = __nth_region_of(t, i);
 		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
 		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);
 	}
+out:
 	damon_free_target(t);
 	damon_destroy_ctx(ctx);
 }

