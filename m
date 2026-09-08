Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7890053A893
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872209; cv=none; b=kESRykXYRfL5/AL7Fq7b+/8udaVKmWZx7k1+6NS443KKl33UA55Uo6p4Ud4IitkIwV4et2pNZvs4gbThcfOQiOsjegD9JSfp4ANoP+sxi2qKD53YAQyMQSFWCwWZa2M0RbJ3/YWYH/LiitZw0IDMY0QBVuZ8m7w63VouaYfqQvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872209; c=relaxed/simple;
	bh=5Vv5OH5hMPqHvogbtc7HogGsjIQvGsCBYuRaoVmWIKk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=JKZKNP4/TgcCvEH27i4WPdoc73NDvMwhsjhzpzAMnF64ME6pcjNCLZxG5n6DeXnoj7OZtXZBSLy5OcDZJx4WfwbMQygHK7hv8QvvZqDpU1gmAKDBt2KPK09LHRalEqwuWzbIFUhb6YKLwMdnIYhzuspXuwsWdR237spjbrPWPps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GolFuD4i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GolFuD4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D376B1F00A3A;
	Tue,  8 Sep 2026 12:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788872208;
	bh=qkMoSlxAwNucx9h3VPppR/rG58dGbh9+1Hr4zaA6v9A=;
	h=Subject:To:Cc:From:Date;
	b=GolFuD4iiBImYKCTe+wRlTzi6/j9EJZYxpfhACjrrKQ9DCmfKqJg3Kd5d4qZF2sAu
	 8Ozxg0fpOvDTjEZg1RhZnZlCumkXVcFss7eM6/hUBFp2nCZf8lD/IXhVGyAwAvmxOh
	 hJtBaGP1lNm8Y+Y4guuLzIq901C+2DPhqxeLG12s=
Subject: FAILED: patch "[PATCH] mm/damon/core-kunit: handle region split failure in" failed to apply to 6.18-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,brendan.higgins@linux.dev,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:51:30 +0200
Message-ID: <2026090830-think-magical-cf80@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 3423fe70395210e2f0cd795270292f6a27cd57b5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090830-think-magical-cf80@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3423fe70395210e2f0cd795270292f6a27cd57b5 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Fri, 17 Jul 2026 17:14:38 -0700
Subject: [PATCH] mm/damon/core-kunit: handle region split failure in
 filter_out()

damos_test_filter_out() test checks if damos_filter_match() of an address
filter splits the region as expected under a given condition.  But, the
test continued regardless of the split successes.  As a result, the later
part of the test could dereference invalid pointers that returned from
damon_next_region().  Further, it could corrupt memory from
damon_destroy_region().

The consequent user impact (memory corruption) is quite bad.  The
realistic user impact would be limited, though.  It would affect only test
run setups.

Fix it by exiting early for the number of regions test failure.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260718001442.87129-5-sj@kernel.org
Link: https://lore.kernel.org/20260714142352.100478-1-sj@kernel.org [1]
Fixes: 26713c890875 ("mm/damon/core-test: add a unit test for __damos_filter_out()")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: <stable@vger.kernel.org> # 6.6.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 322a295ac2ce..eddf3a048458 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1365,6 +1365,8 @@ static void damos_test_filter_out(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r->ar.start, 1);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 2);
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
+	if (damon_nr_regions(t) != 2)
+		goto out;
 	r2 = damon_next_region(r);
 	KUNIT_EXPECT_EQ(test, r2->ar.start, 2);
 	KUNIT_EXPECT_EQ(test, r2->ar.end, 4);
@@ -1379,11 +1381,14 @@ static void damos_test_filter_out(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r->ar.start, 2);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 6);
 	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
+	if (damon_nr_regions(t) != 2)
+		goto out;
 	r2 = damon_next_region(r);
 	KUNIT_EXPECT_EQ(test, r2->ar.start, 6);
 	KUNIT_EXPECT_EQ(test, r2->ar.end, 8);
 	damon_destroy_region(r2, t);
 
+out:
 	damon_free_target(t);
 	damos_free_filter(f);
 }

