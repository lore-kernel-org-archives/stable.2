Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050489;
	b=Jcp236GXAyqEfOmySOjF3Ct3vxFqxagopatYbwNjQd/qgxoju/Lkvw67G6rKGXBv+vJU
	 AvQGzyZgu5yhEqLExpRyI0VeauPBu/ITYYEFLZhvCf1t8RDIsiwcbMJajc0dAeJbYdJs3
	 lUfJVdtW+fy8pJU/RwfrE+nYcmT9xMEgjvGLiqr615C5RKLG3TilFTMamW/OZFWv5Fkvv
	 hmNreiCatOKInpbzbP85/zn2/dUmrsCEwIByPkNIyWLV8VWzjcQe7EjTCfQ7V0OX4s4Qh
	 z2KFCtG6JkIR2k7HgtYr108ft4ZdPG6qfH1y0d7Y5+SX3FEWV5+F9zL6dVcPsdByc3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050489;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EvOV87/xQz4TRY/AWvSTbwercTHOLnqc6A98cs+lJ5k=;
	b=f5C+0JhJozZg7ji2WaVSIehaqtoy0oFvvblBhnP4Ug5SNY86ENSIzi/XJ8wQyIreUaPY
	 Ask3Z7/zB86Vd3YSzUUuKl0b2e6u1BLXXLigyE6sdMddAytp7G9p+iy5C24+t6T9yfV/d
	 iHF4zpFEL8Q1jSJ5r2rK6KgUXdHcoAN9K3WinvD4gncYkK4WqUuaVzjxJk+QtW0+NkvbO
	 YmyBpWcOE9U7215rC7ffRDW1OcTjoRJijFGedtRdI5/tBlvjpWKwY1igYyzjlp9zNcRz9
	 UqvZJV0OFVQCE2KFASWsG/xY3+8LM3PB6O/3bTHZETbB7rU17r98HxwwUWUhNOaFKTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X7odF26v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607E1606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X7odF26v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2261F008A2;
	Sat,  7 Nov 2026 11:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050489;
	bh=EvOV87/xQz4TRY/AWvSTbwercTHOLnqc6A98cs+lJ5k=;
	h=From:To:Cc:Subject:Date;
	b=X7odF26v/bYwTRUYaO2PQ669mLCM7nDkCVFdiK8+4PalA2vcSBTTcwed7My7KF5iK
	 schoEtX4V0u/Fz/1pHLdnZ1exSmEjB7cHnR/SWekMREhHSNyHrZ+LwkNz0JbIV3ScV
	 huoOGV+8zbkLionvSaGt1/H9HHY+Hj/Fgr2SmqDn2p00pg4rUodsWmD8v029GL2/+y
	 0ia35xBtuucSExAjTZWY08h+5nQbCaUKgL87ygYfLndxhyzZpDR6Tcg60QdGPx7GSJ
	 +LA0Lu7zrZ+6enYQAoin7tMhjTIJAXsOFMVh3fxwlGVMSRz985s7CSk9Yk2W+bn6zp
	 ZU4h1Oye0DUxA==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/core-kunit: extend damos_commit_filter_for() for wrong input" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:21:27 -0500
Message-ID: <20261107062127-failed-5.10-a1c7fdaf1657@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a1c7fdaf165755fff928a6c25b69d7e0966b6910
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062127-failed-5.10-a1c7fdaf1657@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a1c7fdaf165755fff928a6c25b69d7e0966b6910 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Mon, 14 Sep 2026 07:23:24 -0700
Subject: [PATCH] mm/damon/core-kunit: extend damos_commit_filter_for() for
 wrong input

damos_commit_filter_for() supposes damos_commit_filter() to always succeed
with given inputs.  damos_commit_filter() could return an error for
invalid inputs.  Existing callers always pass only valid inputs, but they
may pass invalid inputs in future, for test purposes.  Extend the function
to be able to be used for wrong inputs-caused error testing.

Link: https://lore.kernel.org/20260914142327.92510-8-sj@kernel.org
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@davidgow.net>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: <stable@vger.kernel.org>
---
 mm/damon/tests/core-kunit.h | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index c01e6a75cadc1..2b0931cf6fb32 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -1116,9 +1116,15 @@ static void damos_test_commit_dests(struct kunit *test)
 }
 
 static void damos_test_commit_filter_for(struct kunit *test,
-		struct damos_filter *dst, struct damos_filter *src)
+		struct damos_filter *dst, struct damos_filter *src,
+		bool expect_fail)
 {
-	damos_commit_filter(dst, src);
+	int err;
+
+	err = damos_commit_filter(dst, src);
+	KUNIT_EXPECT_EQ(test, err != 0, expect_fail);
+	if (expect_fail)
+		return;
 	KUNIT_EXPECT_EQ(test, dst->type, src->type);
 	KUNIT_EXPECT_EQ(test, dst->matching, src->matching);
 	KUNIT_EXPECT_EQ(test, dst->allow, src->allow);
@@ -1157,47 +1163,47 @@ static void damos_test_commit_filter(struct kunit *test)
 			.type = DAMOS_FILTER_TYPE_ANON,
 			.matching = true,
 			.allow = true,
-			});
+			}, false);
 	damos_test_commit_filter_for(test, &dst,
 			&(struct damos_filter){
 			.type = DAMOS_FILTER_TYPE_MEMCG,
 			.matching = false,
 			.allow = false,
 			.memcg_id = 123,
-			});
+			}, false);
 	damos_test_commit_filter_for(test, &dst,
 			&(struct damos_filter){
 			.type = DAMOS_FILTER_TYPE_YOUNG,
 			.matching = true,
 			.allow = true,
-			});
+			}, false);
 	damos_test_commit_filter_for(test, &dst,
 			&(struct damos_filter){
 			.type = DAMOS_FILTER_TYPE_HUGEPAGE_SIZE,
 			.matching = false,
 			.allow = false,
 			.sz_range = {.min = 234, .max = 345},
-			});
+			}, false);
 	damos_test_commit_filter_for(test, &dst,
 			&(struct damos_filter){
 			.type = DAMOS_FILTER_TYPE_UNMAPPED,
 			.matching = true,
 			.allow = true,
-			});
+			}, false);
 	damos_test_commit_filter_for(test, &dst,
 			&(struct damos_filter){
 			.type = DAMOS_FILTER_TYPE_ADDR,
 			.matching = false,
 			.allow = false,
 			.addr_range = {.start = 456, .end = 567},
-			});
+			}, false);
 	damos_test_commit_filter_for(test, &dst,
 			&(struct damos_filter){
 			.type = DAMOS_FILTER_TYPE_TARGET,
 			.matching = true,
 			.allow = true,
 			.target_idx = 6,
-			});
+			}, false);
 }
 
 static void damos_test_help_initailize_scheme(struct damos *scheme)
-- 
2.53.0




