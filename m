Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347ED5437E1
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872190; cv=none; b=VR01UctGPeX95qPoFevo5J+GzRtTv5+DZ/vClJKEC8skYDRB5rggzkrUnPrX30F+iNNRDBoBKARUWNethZp4ZMMdjeQfjrYu2rJPYxlgYzisO6pZ9LvgckplhAmH7ZAesOZmguNJ3nSUr5Go3Kc05aoX+WyRNANVxknCx4DCrzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872190; c=relaxed/simple;
	bh=q1FSh6C2plQPJhBXrt8XsN61N6D7SFGGSROHeLF0Qz0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=XJXKJilxakajNk/MAIyZ7/x9H+dBCmaJr3ZZKdrEwqnySD8aIdFGKIjTqLAL8t2Ca86RRhlEoBUYOQqkwuz0lcD91RZaeG3wCsyKFLP73BEgGdP9xb6dPY3v90JYvF7WViaLVlNSYs52elhtFzKCmLivE1juetmjp7s48VYeAoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qar457vU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qar457vU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D29F1F00A3D;
	Tue,  8 Sep 2026 12:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788872187;
	bh=iEK17uDE7xPrA3qk1cAzRc5HpsWcRYJrMdhx58AphO4=;
	h=Subject:To:Cc:From:Date;
	b=qar457vUkDT1EWf1Xfk5ZogNUhv9XAyRnxxCCqXuqRxYu2/3Rd1ErpAQYRz0xiHus
	 8MOtQVvO76qO8n0DLlQXRXgzbXgK7D4Pz/O79YJ5Q3WanVzxfIzQ9qSBLqEfbX8SyI
	 42tdJntCEPFsCmxVb3sg0N7WTIfQXjacq2DopPpo=
Subject: FAILED: patch "[PATCH] mm/damon/vaddr-kunit: check region count in three_regions" failed to apply to 6.1-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,brendan.higgins@linux.dev,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:49:20 +0200
Message-ID: <2026090820-flakily-douche-e51f@gregkh>
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
git cherry-pick -x 5fea07e460874c8c7cf00f728efbe22abc62c8d8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090820-flakily-douche-e51f@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5fea07e460874c8c7cf00f728efbe22abc62c8d8 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Fri, 17 Jul 2026 17:14:37 -0700
Subject: [PATCH] mm/damon/vaddr-kunit: check region count in three_regions
 test

damon_do_test_apply_three_regions() iterates regions after
damon_set_regions() call assuming the function would succeed at setting
the number of regions the same to the expected one.  It might have failed.
In this case, __nth_region_of() in the iteration could return NULL and
NULL dereference can happen in the test.

The consequent user impact (NULL dereference) is quite bad.  The realistic
user impact would be limited, though.  It would affect only test run
setups.

Fix it by testing if the number of regions was also changed as expected
and exit early for the failure.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260718001442.87129-4-sj@kernel.org
Link: https://lore.kernel.org/20260713144757.39740-1-sj@kernel.org [1]
Fixes: 17ccae8bb5c9 ("mm/damon: add kunit tests")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: <stable@vger.kernel.org> # 5.15.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/tests/vaddr-kunit.h b/mm/damon/tests/vaddr-kunit.h
index 61f844336ffb..6a95441d193a 100644
--- a/mm/damon/tests/vaddr-kunit.h
+++ b/mm/damon/tests/vaddr-kunit.h
@@ -158,12 +158,17 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
 		kunit_skip(test, "second damon_set_regions() fail");
 	}
 
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), nr_expected / 2);
+	if (damon_nr_regions(t) != nr_expected / 2)
+		goto out;
+
 	for (i = 0; i < nr_expected / 2; i++) {
 		r = __nth_region_of(t, i);
 		KUNIT_EXPECT_EQ(test, r->ar.start, expected[i * 2]);
 		KUNIT_EXPECT_EQ(test, r->ar.end, expected[i * 2 + 1]);
 	}
 
+out:
 	damon_destroy_target(t, NULL);
 }
 

