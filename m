Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B7553A8A6
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872212; cv=none; b=r5O+wR/EgNCAxayxTGoRJZYs8hsiilatyizjHxvWeSUSxmpJD8rQwxwAwCi5lopvjv28dYiFDFQZwgLbfBIU6Hq3pQuttRIyjowKWd/RKjdrVjQ3WDkRRY6dgy5iZEu9KLP1pa/3T/xwhYnFHfkPxDJGU/Ucid1lzI77Fds8ENA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872212; c=relaxed/simple;
	bh=8+Ew1SS4/XZdmzNFjO/uNZw453MSShtbjz3ZRGPEfn0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IrH3Ms6APLk93eBlC0SNPZxlDmeWiwj2xtlf+FGCgAXZWbsOpGUwkYTf/RzzAsBvSY1CcRjdI4Lh0xYjE8bQFRdgKiaweKjaG/EnqrCEL2n/dKMSEfSKYxg9ZvAQ+HF/fMQLyGsF4/bownnyVNDBPERtE1zze2lQAk8zef3LTAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bJtaNO1A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bJtaNO1A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8A61F00A3A;
	Tue,  8 Sep 2026 12:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788872211;
	bh=NrvnyhqX+j0ifT3uu5/V15LUgrQH3rVgH/TM0ByNe9A=;
	h=Subject:To:Cc:From:Date;
	b=bJtaNO1AEiwLrBe7zeB0oRhQG5bDNzd9dECn5fSXFCoCGIVMZyL8C/T6eox4TkUNY
	 3ufQr7aIrvdYejmLPfSlAYYBoaQGh7OXa3b2AYSLDPg8AhG7EKRbY6UGeljA87/zTF
	 OL7jDLxNgspE5m1bB4ob2B+sSCtdQwtj7F9YnfGI=
Subject: FAILED: patch "[PATCH] mm/damon/core-kunit: handle region split failure in" failed to apply to 6.6-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,brendan.higgins@linux.dev,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:51:31 +0200
Message-ID: <2026090831-operative-attribute-934e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 3423fe70395210e2f0cd795270292f6a27cd57b5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090831-operative-attribute-934e@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

