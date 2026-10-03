Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6920923AB9D;
	Sat,  3 Oct 2026 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791042383; cv=none; b=t/cGtXpwhxcDSeQEWGaKq3484h4mlwoCyQQWZjNSBARpD+uhK2/f7nzwp/LdC2qv9WCYfNGhwcQMwvyn2SjnPpCEbJeUcFUkwlG8AFI+/FSEL5ZmD6unFikcwLQJkCwcCvqG4N7F1TVfWHMhJ1C8G2qSXXPK2FqUr3F1wbiJsmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791042383; c=relaxed/simple;
	bh=dKTVdy+yCyrLn3MnTq5spw3qQpFrz79wsn1WiJm0ywM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XyG2FlogGP4++z2OhdmdrvU+e1pDU1TKXKpSk6jDr7blxtw/eB58h/xKJRj2p/pfZz6gfXxkF1oEILBqPGzJnbXrkQXeT8siP2NwX5/GlspP8dXxilrxhwvV3xdXXxxbw/ueNxeL0OyqnSc1zAE7HgfbNctLmWRrYkC2FpefAbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8zZnkrR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8zZnkrR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3A201F0089C;
	Sat,  3 Oct 2026 15:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791042382;
	bh=tkts0pDbe69YFVrBqsvwV2MRMgMY6TcvecSmyeXkG58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V8zZnkrRupfrBMhPYg9eyDonKWcXD+jJWnf4kZiGoM2i+R6/JQUDhbHmc+NP2pjWO
	 ZW7iBOBhhawcGFts+pPaNNSN8sodjTIorajAIhy88uFXizKLTHqKqoE/1XrefjD/h4
	 V1FrYy+XpU/8i/erCjFaJmvAmZuKR1Gl/DeaCqI3C6hMMe5arRQVJaAf2O1Dzxs6jm
	 OFntH4e7dFXFmypHnmTwGVuNKFTcu8AutiMoq22eooEEDJYDsHIg/4da3kqBEu1UtY
	 +rScgvL6S4OdzAgGIC1pQuXjq+eqvOfdhkLqBaOUGOz9ClxYEBlLs08YWrSj0OWoE+
	 vnFZzoYsfZ+pQ==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH 6.12.y] mm/damon/core: don't skip damos_adjust_quota() while esz is not zero
Date: Sat,  3 Oct 2026 08:46:16 -0700
Message-ID: <20261003154616.22092-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026100358-repayment-destitute-a6a6@gregkh>
References: <2026100358-repayment-destitute-a6a6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS could unexpectedly stop working when a user disables quota using the
online parameters commit feature.  Fix it by correcting a wrong quota
unset check in damos_adjust_quota().

DAMON users could disable all quotas by unsetting time and size quotas,
and removing all quota goals.  The intention of disabling quotas would be
making DAMOS run at full speed.  When such quota disabled setup is
detected, damos_adjust_quota() skips all its work.  The skipped works
include effective size quota (damos_quota->esz) updates and charged quota
amount (damos_quota->charged_sz) resets.  The intention is to avoid doing
unnecessary work when quotas are disabled.

However, users could do the setup while effective size quota is non-zero,
by doing the disabling with the online DAMON parameters commit feature.
In this case, because the effective size quota exists, DAMOS will keep
working with the quota until it is fully charged.  After the effective
quota is fully charged, the charged quota amount (damos_quota->charged_sz)
cannot be reset because damos_adjust_quota() skips it.  Then, DAMOS stops
working until the quota is newly set or DAMON is entirely restarted.

The problem happens because damos_adjust_quota() assumes the user setup
for disabling quota immediately disabled it.  In reality, the quota is
still working until the effective size quota is also updated to zero.
Other logic for catching that uses damos_quota_is_set(), which understands
the fact and therefore checks the effective size quota in addition to the
user setup.  Fix the issue by using damos_quota_is_set() in
damos_adjust_quota() to determine if its works should be skipped.

The user impact is a non-deterministic and unexpected DAMOS stop behavior.
That is, users would disable quotas using the online parameters commit
feature, expecting DAMOS will run at full speed.  However, depending on
the timing, the setup can be updated while the effective size quota is
non-zero.  Due to the above mentioned internal mechanism, DAMOS stops
working instead of running at full speed.  It is unexpected behavior.  It
is also non-deterministic because sometimes the setup is done when the
effective size quota is zero, depending on the timing.  It doesn't cause
critical issues like crashes or leaks.  Users can simply set a reasonable
quota again, or restart DAMON.  But definitely it is an unexpected and
non-deterministic behavior that makes it difficult to reliably use.  Also
investigating the root cause of the behavior would be quite difficult.

Link: https://lore.kernel.org/20260916135020.86483-1-sj@kernel.org
Fixes: da87878010e5 ("mm/damon/sysfs: support online inputs update")
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Kunwu Chan <kunwu.chan@gmail.com>
Cc: <stable@vger.kernel.org> # 5.19.x
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 32737cc5f877..2f6d60b9ca0f 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1677,7 +1677,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	unsigned long cumulated_sz;
 	unsigned int score, max_score = 0;
 
-	if (!quota->ms && !quota->sz && list_empty(&quota->goals))
+	if (!quota->esz && !quota->ms && !quota->sz &&
+			list_empty(&quota->goals))
 		return;
 
 	/* First charge window */
-- 
2.47.3

