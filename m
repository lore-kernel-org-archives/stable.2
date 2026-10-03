Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FA54446EC;
	Sat,  3 Oct 2026 15:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791042685; cv=none; b=lz7am0GRnhFZcreTCcC/j4gqXRF2ZyIMndyP0h7Koy4e10wVDYnecMZk+aM1zqm8Qt14dKqt7CgFZ41gWdOUDI+Q+c2VCvmA8E/Wh3Zxy3ddVcs4oC0ufFA14ffgZ8isOwJoOkzfJlaTMEAKRICsTeWXm4hha3sr4GIxq6qV8O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791042685; c=relaxed/simple;
	bh=ZGh2pZEAehXDUYHZyhLpAMtpr2i5z1oJV0wn/mKu2Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cbm9wEX1LaO8yRDqfcd5SpJsYYzd5Vm6Fi0oXSVW5rkbsgW540C/zEtthVutqcZId+ugqiKZfBHHDg2MDBSYMHlqq/XKv/f7DCAEzauZ9Gi/PB2xKJdqK90i/uB0UxD36Zj01c9O/U7S8Dac4U5Zwp9YIGDABcj3xsyphg9TrGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvaKdcRG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvaKdcRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71EB31F0089B;
	Sat,  3 Oct 2026 15:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791042683;
	bh=vQL5VLnwKtHPWtKmS5WzrNHf+JZYMsn/apLV3LczJJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gvaKdcRGgYmC5HayrhixvAA2XcZjMXF6u4L90PDCTl15srua9h3wQ0q/s2JaY+vby
	 3bJ29LMnCOzPxLELft2rMgl0k2p6PGqDwQ68nGED0VsY85Y79Fnc8IdAi3rGhWcHXr
	 Q/ipzTPEpn932yO0xsEdSTp+k6vcIFaKTlYHYhYdqWspIqxnF1Z606TKqwWDSw8yxi
	 I8aHvJJBcKGgr1jOTjH1wphPKS12qWiMD7BApwaz0khDVUyJBdeO0MO7kU4zXUxTcX
	 GmTIVwv7C4p4zbRXwT+Y4otGtdKXilH75lrocF7CAcM55J9HdiGlSqBsVfS9psguqE
	 zO5AFdaN0Iflg==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: damon@lists.linux.dev,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH 6.1.y] mm/damon/core: don't skip damos_adjust_quota() while esz is not zero
Date: Sat,  3 Oct 2026 08:51:19 -0700
Message-ID: <20261003155119.28683-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026100319-silent-lark-6245@gregkh>
References: <2026100319-silent-lark-6245@gregkh>
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
(cherry picked from commit 52ae167ce16609c7e6fffef588b3c2c26de2db19)
Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7afbc20833ea..568f24da26e6 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -869,7 +869,7 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 		if (!s->wmarks.activated)
 			continue;
 
-		if (!quota->ms && !quota->sz)
+		if (!quota->esz && !quota->ms && !quota->sz)
 			continue;
 
 		/* New charge window starts */
-- 
2.47.3

