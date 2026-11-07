Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046895;
	b=FrYP/ErIUcTztl8+FxOUP2uv4s5Fpcw734+RW1/iJWMsQ9Ejigu+vTthJn9HD8e8AHu6
	 kV21hAc1Fm0xWYTRY5Z4/dUVaQUCAvjBRRzc6gFiuvQlSo11Gg/6ORlGUMfHl7DOGR0o2
	 d6xc6SabCsRoWvdVJmHSU9XPd7bFPTLrum+lgDQn677mXP7fXZ9fyCVjODdV9myuuYyQ1
	 4EDA0Gma/+igNWy4k6tKBOWmfFrYngaFVh8vSEbzf1fZJAMxgNyugVedDz0tPrZYzBsLd
	 9TZjkmi+98f9m3vb9N1BycB5+V3aoPqk/nw+exfUapqIIYvNUGE03/gt+qslSs909DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046895;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=38XGWmeNwGLrGcUHPCEyg0i9ay2LUEVyS8gLgWkKYME=;
	b=TnElfnW6K5GS6M8BA2eqRak+XJ7v6yncqQ1+v+2YUQDtOYnOHKnqQRP6TKvnWtgXw0o1
	 t+Iew01vWu5/O4R87MeGDVpq4V+Ifj9ijGD87jVDXLEGXgghC9wvvd/erJ2WKNqHfVKqE
	 +4tRrVVV1go5sj4OX7068TaIovGqPfll01jQNGJtvKaRJZQcs2DeryYT3FHgD+6OXD3WQ
	 Eh+pa5DRgR0JN05HJsBECuR8zDFz3FgqfwxB971shRXbOypq5k2NsSwT5FL+CQBtqruVk
	 QIvt+siIGPa8u327RRvbvuOAnh6PI9wVjbrGvXJns3sL/jDFi5P+wu25tyryFbg/M2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TOhzRaFn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD517606EE94
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TOhzRaFn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEBF1F0089F;
	Sat,  7 Nov 2026 10:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046894;
	bh=38XGWmeNwGLrGcUHPCEyg0i9ay2LUEVyS8gLgWkKYME=;
	h=From:To:Cc:Subject:Date;
	b=TOhzRaFnNaOpOgDY78uVU1BSnBd/xtsJTFXYwlYe1ujuxzpkuyqQhGK+jHWKnpoZS
	 J0nPVbUAitysuEwvmj4hsybZzBhW+Pf0ZNiR2KtcOMbpZajO4OM9RH+ACuw3UAwEv/
	 Cw0+64J1VI6qEuR+eLgkJjurCkV6iMhDiVfcLD9sZgpE7oplljx0i6CfL756uJzoV2
	 U+Z0zBpcjMHZCfRhEPsiDxkMACtq3iWZlhR/C5ix6SQJFZMMxAvvxYoc7HEAybf4od
	 lQh2X83aFotlZZC+j+T1It5iw5q5Jc4ZciihkcPrmhN3EuhQvx5jxEJ4hR1P4VkxEJ
	 67cPHOix79aCg==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/core-kunit: test invalid damos filter commits" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:21:33 -0500
Message-ID: <20261107052132-failed-6.12-409d2ab6d982@kernel.org>
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
git cherry-pick -x 409d2ab6d98209c30d45123920721710475a30b4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052132-failed-6.12-409d2ab6d982@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




