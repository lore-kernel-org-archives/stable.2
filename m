Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049486;
	b=5EsQuFZHwNFaGQYKCvIGBc/weCjShuEoQgM5Ni1p/TOCi43Fe9jadOQtVDJwTFvx/f1V
	 hNc8WQf4tnT/ATVtUPKBXcx3tXnkSzdem3VVbw/N4INYwboGIUpqbFRJxxRI8f7B9cYO6
	 mRoNWqQgWyW2tixAPdbvMlfgoM6vm48hDoM8dWkxUtNrsC/PXg6PNWYh9JcPoiGJg5alg
	 4io+9fRoza9VJuLyS5/aEb47Sfq8vZIrXKrFka720rmfQmufSCi7md0uTcwxNDW7tWx2K
	 aa8LY7CLOGaXfd2iwbIUqIl+qQJWdejCZs8N0tjm/+VFJUy4oxsfLmYtaUkzaRtA+sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049486;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RD1ZB0mfkEseuJfHDuQEdM3rihnPEOc95gOWHrOKZ4s=;
	b=FQStkd7qhQkXUZKH4rpVXVQ7QUiMH7b1qwxqdrK3bOpdjoX+8y29AmdnkXY0UHJ5azMC
	 IMWe4QqfSWYf1IDOJmTYaKx0wses+g8lqcONiVl/zqONk2bxmOMb4A9yc7lvQbeC1OiKo
	 GlOFQjG8/L9P+ydWaZ0L5gEBzr6ZKQRlOkwPpIQfwNEG+F5DP4j9V+pG+MokFTNLpbdD4
	 OmnrZilzhgbHLd3KWljnc8taI2b6qq3ublaaR0UAJOBjGgDlhNYZ5IjTXxhePg9oJ2+Zu
	 PMg6lOyabsEp3R0w3ARRpriFRTNLDSKiyF1aA8xpMrX/ILmQ18VmobqehX3y/fq0SAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aezEhsra;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25359606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aezEhsra
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B221F0089F;
	Sat,  7 Nov 2026 11:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049485;
	bh=RD1ZB0mfkEseuJfHDuQEdM3rihnPEOc95gOWHrOKZ4s=;
	h=From:To:Cc:Subject:Date;
	b=aezEhsraaJ/tzWIQ05zR1IUcLA1i1CvubEIqL/jHDeT0BP3XbkLSNCX7uAovfJVdR
	 lFrbHzW4UmtTWI7O1v7IKeKWiXXsrH5Bh0lc+cwq1mERLT8Et5KyBthz5iSdUQXBQL
	 etwXEM6KIigx/JYOiy4JynxRRn3Qz2Ru3p4F5zSrjNhSXHGYRq4EnkVlODe4GYd4ow
	 sPS5pjSiWpzYNuvETJcmNBiERe8QJdPwKtsRDwTfaBolFxaeupC2PdPOGt+GUwFF2k
	 KSu24as0JI7ofNJb5ei2PQoT/o8/TMoa2PxC2lGympl0uMcuz2kiAccBXb6Aj3y/yj
	 7YJRuGPjWmtVw==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/core-kunit: test invalid damos filter commits" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:04:43 -0500
Message-ID: <20261107060443-failed-5.15-409d2ab6d982@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 409d2ab6d98209c30d45123920721710475a30b4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060443-failed-5.15-409d2ab6d982@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




