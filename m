Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552CD544891
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872173; cv=none; b=H+auOb9hL0V+inXLTsnmvQOmj9LYpjeAcpqkv6iXqvHXO1BvKPOjVId8NasklwntjpXA7FCG3H8dSQW43xxlE8JL9kYj3OfFYX3kgfrZLDgMbfEEy3opwpllXQCp/fb6rCMnz/TjHniMyxz63PPBnqWFQCy5Dhl9N0EMbStbHvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872173; c=relaxed/simple;
	bh=5ngK5CifS2c4MJxhTkJTLCxy3YIcvXiJs33FKglIrlc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=St2bbNX36kz9rL9FZivVjPBmzFXwxBqF/PBQyMZrh53Wrh1Ea5pz4lXhDh6dcdwW6Ex7gs3YqxF+rQpW1P7CKb5AaLwcXCDNSccgugiHdQlSgRE7kNIEJQw16OlwGYbK6FYxDGli4Aek+uxNz1qauzVEAUQXkuVUlPYXcYd2jlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Xx5WFzbx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Xx5WFzbx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8050B1F00A3A;
	Tue,  8 Sep 2026 12:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788872172;
	bh=yG0nMDV1LvcT9d+8F0w34ypm3y5EpTUSUoo4F31mu0E=;
	h=Subject:To:Cc:From:Date;
	b=Xx5WFzbxUbfqRk+ktyPLgh5wZSteeJxR64nm+WkrCRig/XEimwKt/05lQ2eaGdqdv
	 ykvh/ljFbR18+5nLQzMKyu5qrqUPzYYimFL97u8YTAMAQuV6v5qoD5j9XZDint4GHQ
	 pqgPLMVBhlDN7Lc7gnxwoCOhZvxY8DSyYbjauAkc=
Subject: FAILED: patch "[PATCH] mm/damon/tests/core-kunit: catch test failure in" failed to apply to 6.6-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:49:08 +0200
Message-ID: <2026090808-subscript-extortion-d6f9@gregkh>
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
git cherry-pick -x b640708929aa956235866bf7717d89018c661083
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090808-subscript-extortion-d6f9@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

