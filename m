Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD3E53D0DB
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872206; cv=none; b=nX1kk7FNsar44WaMmajhXDY51V1VNOn7dEZg1kJ+hUNg+jqQIRxoPlvPMHrTBDOZC8Pl8pqTjlidA3NUncxzooczCNuUCSxTKkz484mbTevWy2Ihfnu5UrZS6assbX7SBUTV2jQi0sP58hY3YbeZOdN91k3s8UnoT6GC68Dx6Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872206; c=relaxed/simple;
	bh=i40F9scCWpdd+lndskCaA6UvOGg0nPbParg9jHVYILI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jn+mBNfXWRYuYBR9C9zfgxVOGILOIzX2axRGRyPEy3CJqc6KZtOzp9p70/a0REhfn/Gi6e0FJryDaU7pooa4gatR6bWX6sD0bIBFhqCVotejN7PvoZ6sFtc8IpnO7qwp3l4Wx6dM5le1C75WKsqmR/DH0Hvl/t9VXv5QsSGL4y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2jxA/ddg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2jxA/ddg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985FE1F00A3A;
	Tue,  8 Sep 2026 12:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788872205;
	bh=tPzYqmdUaxCtmn28G0+UrkzpOFchQwmRmZ7aODcke98=;
	h=Subject:To:Cc:From:Date;
	b=2jxA/ddgqqviEMDLgn3T+yBBafDlP9JZktwtaUqIk68yOPQN2YxoBBr9zbsqazxJ/
	 P7oQV2JtkrsVN6mZ44qscUDKaTc3CuF9GyROK5dP9IfZn9fl3FkJlhJ7TSJf6TWT5Z
	 8ZtR5XsFc4cWPxzLCslbG28bRUtjnja1GXlM/qSo=
Subject: FAILED: patch "[PATCH] mm/damon/core-kunit: check region count before testing in" failed to apply to 5.15-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,brendan.higgins@linux.dev,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:51:21 +0200
Message-ID: <2026090821-graded-oversold-80b2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9b18ef3c3aa1ce24176e340061caf15fa2742564
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090821-graded-oversold-80b2@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9b18ef3c3aa1ce24176e340061caf15fa2742564 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Fri, 17 Jul 2026 17:14:36 -0700
Subject: [PATCH] mm/damon/core-kunit: check region count before testing in
 split_at()

damon_test_split_at() test next region that is assumed to be created by
damon_split_region_at() invocation.  But the split might fail.  In this
case, the succeeding test may dereference invalid pointers returned by
damon_next_region().

The invalid pointer may not cause a really bad user impact, because of the
implementation detail.  It would only read wrong contents in the belonging
damon_target struct.  Depending on the future change of the offset from
the link header to the accessing field, this could also be really
dangerous, though.  Still, the realistic user impact would be limited.  It
would affect only test run setups.

Fix it by testing if the number of regions was also changed as expected
and exit early for the failure.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260718001442.87129-3-sj@kernel.org
Link: https://lore.kernel.org/20260714142352.100478-1-sj@kernel.org [1]
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index eba643762132..322a295ac2ce 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -155,6 +155,10 @@ static void damon_test_split_at(struct kunit *test)
 	r->age = 10;
 	damon_add_region(r, t);
 	damon_split_region_at(t, r, 25);
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 2);
+	if (damon_nr_regions(t) != 2)
+		goto out;
+
 	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 25ul);
 
@@ -166,6 +170,7 @@ static void damon_test_split_at(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r->last_nr_accesses, r_new->last_nr_accesses);
 	KUNIT_EXPECT_EQ(test, r->age, r_new->age);
 
+out:
 	damon_free_target(t);
 }
 

