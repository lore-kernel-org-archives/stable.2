Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046237;
	b=xA5Zk9DT36f7BGsMLlzpBJQQwmB4ETt3jExWsoRR4PH6QqFLlfmrsRuADXk49sE9hSj8
	 ox4HQBYuZjc7bAz7Fl8B49ngstjHxZbn72PGeAREf55DLXEy/JtfeBnyBu99qmnO0FCUk
	 8oErAE1zuQadbFnpr6HRqg9xayyVMDz1pboTZppAYKSr2BKJgfF07vntRTTMcWhLIZM6h
	 C//IoLgB4RViGYoWPtBSsW7FBht8TIuRmXIiYCmcOrrGQAwyiOFDgdxD012Eta4gNHd7E
	 yzFI+7Jy9zmf1Dm++BKtEaOvMEesq0GrRO/80sq7JcLun7JqlAIg7OSKNj6WZ5RFdrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046237;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+nIpuHyN7rLFplzWWrSiMyrGLGssAB634kgA/1V2iVw=;
	b=wU5qbNzABQR5xJ/NNRzSUPfA9m5zM4azMMj7D428HoVDpE+KSL3rMmnB36Okz5A64J2A
	 kI7Uc9QT2sleuUhacWWy+vWzuEfKXnTij8rU9TA+QGRDgNS9qH9BSEWGBPJEprm5xWL2Z
	 JJu9VIuMlPQQy3o5ilI8qhQO4GAommNLh9OkTSoXCoqUzV5Dgs/3Bsnc7lb33tE+awP9M
	 KhjK7/2waLUfb5idCCPPHmlTh9NH6UkgKEpCXPAat8skBjCShxUgkRlW62Hu4cRtDZjXg
	 1SDx1xjOe+AfhOV43rk7Biv6tV4PeInxTCteSYlSc1hTK2tM5ssIKk0tScc19TcHWfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="GMmrjhQ/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D1A606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GMmrjhQ/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B041F008A1;
	Sat,  7 Nov 2026 10:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046236;
	bh=+nIpuHyN7rLFplzWWrSiMyrGLGssAB634kgA/1V2iVw=;
	h=From:To:Cc:Subject:Date;
	b=GMmrjhQ/YjwQlWEkyGRNBY3nRKu7iS96GaqlJImlDE1apJr79hqbjwLPRLB75DdsL
	 /tOGh2RrgM2KD0DdKLAbiLd1ufLjg3tlcds0UBTCYme75x+w+Cgs2kAqAvbHLtTl6S
	 4Ur9EHObWS5UzNSavPBFC8Rrt4v8pUFAxsZmyDWIfetfRlgc5lZLVe3SyWmAWXgXi4
	 Lk1mdQZgCM8qEkFKWnyN4o7hjDcYu/xtY/A30M5vN3ioN7I/sM0Bsx0q3kP1pNKHkZ
	 cqRaUKzYLA9O5RMFXVtUI7gIvqqk5xtQFZ8mgVecmvR4gu0S8r7jpg5lo7Xoxkqrce
	 TIhERQ9Yey1Ww==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/core-kunit: test invalid damos filter commits" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:10:34 -0500
Message-ID: <20261107051034-failed-6.18-409d2ab6d982@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 409d2ab6d98209c30d45123920721710475a30b4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051034-failed-6.18-409d2ab6d982@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




