Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046888;
	b=pn+PiTl/yrmK7YOjZ+VGHNwBFlQj/NQHkC2CSalGaedRKY42LHfht4dOGuiRH1AK8sQG
	 zi0M9gLfcoT6tSAGAk7ns1/DlhGvPl9Wyz+ez7R3tOvHfW40T0wcuttbJfCqpgoTHiZ1v
	 p9MzXMe8FbQYLG3gCY1xUBHlf7WqEVilVpsuULSAyMv86I9NkMzbJZZUZlyZT+ZnkWdGs
	 BEGdY1s6xVORBWb6nwFNXyTq7cfAgzayT08agZlf+d4ZOK+8TstyAdMHr79lL8Mk9Yb5P
	 h9rEAWxEi87Ju4Fv0KXm2KUHDZlXvUXyPV1Xf9g8M5MbA+DVeYPrt47xXF9V3riGDCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046888;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CEMM0bDPWLWmwi8eg+M92KZpjF7N37P8/NYFT+rsxmo=;
	b=KQCiKr4+mmUNX6REJSnxF2aFQuZMIYf6CtZ/iO/7pYTckRhx0VD/uqWY6wxvph5BpgfR
	 OQUZI1/eb0KegGtRh5EjcRSawiuIEU66plcSaEORGb/ln2uUlsFz4/KzC6dXzFh3hph8g
	 o8RnAxSoIVPN4myRTVRfRqkiMLcFp8/NSvP//YMFabTGDlJ0ZrTrhraO4x6/79ukKhH/L
	 0At4eguzGlPOIte2igZIN9TuZ1aCztRmZH45/5eQW5xcsk5g7ivnyzo6AkhMiyGFoPIU5
	 MsHAs0fueAyBHALyz2C0+DciBb60T3zyB0B5F3ITC/MeqD7Yafd2WBuqO8fFOKmHW+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItczIdie;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC726082BD5
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ItczIdie
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33BB1F008A1;
	Sat,  7 Nov 2026 10:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046887;
	bh=CEMM0bDPWLWmwi8eg+M92KZpjF7N37P8/NYFT+rsxmo=;
	h=From:To:Cc:Subject:Date;
	b=ItczIdierab32RTtry/LaoeiHQSy+0hQOYdSjfEo0AbvDi2uG4KBaIjWXG4CG3qTw
	 sCtK0yDjmk/cbwiybCC6iIy9F1TNGVUqxgI8xdtTS+hDdQ3X1gzd4oW8kFxKHreUSV
	 MD6Qk0XcZPoZXeJ30IPyXkpgs/MtEvG07iMOKE6MBKOJoA6B7ExnVE1LHYIIfBiGm9
	 jGFdidIgQ+QE0c5g183q7UDzwxsgV6GU7JvzbV5lEVON+Hp5tsQ8cnof6xnnGe9b0v
	 Ip9oELNlL7FUHW6EtlU7qzIrFSyYKhEZ1OP+NHS7/PFDgiKP6YFnkm6Zw+Y1kmhkHJ
	 TfN9xRxZQXCqg==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/core-kunit: extend damos_commit_filter_for() for wrong input" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:21:25 -0500
Message-ID: <20261107052125-failed-6.12-a1c7fdaf1657@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a1c7fdaf165755fff928a6c25b69d7e0966b6910
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052125-failed-6.12-a1c7fdaf1657@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




