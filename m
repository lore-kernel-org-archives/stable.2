Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050482;
	b=czgq5rgzH++zI24xrIPVnhWt0ywir5zBL3Eo0qxK8FSXoAFauXMF25yXMvzIDmuNe9PN
	 n6zVAOQBgQfrZxeZ/8mGCRcEX7JS9F4SgPTr9nLTSI9pKOMBR8RfYFSnTE4Vz8jws87L4
	 L+wuh0eGRWWM9tZaYdKk7HxLOJ80CcIsi5+h/tmhF6jN29cRHKJKljdnpgI2qLF3lNgWC
	 XliruYZZmSFIlO1zgmO1j9eCJWeNza53cFiZT8OZuUb7T929QSmi+9tPF6jvN1rIlLBRa
	 neIfPWPGUTGGF0rwjkgxTeF8CaHP0tl32c+hpn85jK+r1qTW/Q5VRUblMniixpvcKeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050482;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4dWeKJIt8FTc41FtsAFjNQ6LLm+dPQxw//wt8FrJr6U=;
	b=caqk0g+3qZZiyk8WRUGrvxVI4u0Z+6Jyo4Wp2dmSXZ1KXQYY4mAj/FFtqTRQQ/XrgU0Z
	 L+sCJtqgEI8G0yr8V2YtoXRjgGhmpMlXd5njkSSpI8tn515tTmDBD+IVozlRW2gL78Eu0
	 fln8i2ilHiTeMrq5DyR/LWnC8skCHKmiHsKw79BlrlM5erykmZgU6PPXFJBwIygXdigBi
	 An+F+AiB/F8C7dM+xSPyDcOGECTmslKksbfREPAAH4fU2egdPt0WajxARsVSThe1Kr7ek
	 kM1a5qo30f+yingU90UR7jBIqxEh6NjGs0zg8KB+w7wc1rUa3AsSDUjOIfRxXjPBx6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YTySWCqw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF9F606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YTySWCqw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBE61F0089F;
	Sat,  7 Nov 2026 11:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050482;
	bh=4dWeKJIt8FTc41FtsAFjNQ6LLm+dPQxw//wt8FrJr6U=;
	h=From:To:Cc:Subject:Date;
	b=YTySWCqw2ORj2eYK9e2M19MoVt/avsGjj//GhyLJWXcKunp47aIpDrYyUziJaP7cD
	 XlYw/yKoeuCIQ9ZHm49CUr9S1e73l0IRL/VsPIJeFgh+gm10aO/eI4jTIPqjoL3Ys/
	 6RAEA43nKGr1r/3FILlC24xyJslsKkTLdjSpazGJElN9O7FHRcnCuhlUrjmu/2S/rV
	 evOxI7OBkzko74yo1krtUtt+NN/q6XQ+KEZrbzOXY0G+lcYtrhPoNvRYsf6Y7CGG4n
	 MSlLDepz9re/YDF+00tlVEHE+sQV28LkYZqrM+Ki/kgk3fEhIH87aGljhI/4v4VC0z
	 uUJGdNsF1/QmQ==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/core-kunit: test invalid damos filter commits" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:21:20 -0500
Message-ID: <20261107062120-failed-5.10-409d2ab6d982@kernel.org>
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
git cherry-pick -x 409d2ab6d98209c30d45123920721710475a30b4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062120-failed-5.10-409d2ab6d982@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




