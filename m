Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577421632DD
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 15:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791042228; cv=none; b=GJl7H/tlGBC5q09bHnRG4GdplJ2fZptoEl6AOQ4ias7hIlWCnwMeoxVPVXsHwsc8Nf+Y0r6Fz91LZE/T2BGU+OxgOYfgqYVwXfpDdS6kG8gs2TMdHvyov5YZH4o8asDNGSpYkpfJeoMQJSW+j3USLhSCjt94FiFfzbju5Wf7HFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791042228; c=relaxed/simple;
	bh=DKfzPq3Tgj5yPAmTAhXXiQJogeVCWamzH5gA0XHzRsM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=godqhK4qQ7cgOjSUyGBL+flqO+dJ9I5e9QKI/4qGbdknx6Ej6N7kit6M9bt7T62lLAjns8k7+9i1S9uHIujbdzuGpreq5PELgshPVV8lsQw0FZQ2VSp4vt0ZVKZF0llHJ0S9xcxhvv8Knlp8i+PQI1q2T3cEc291XgzPmk63ukg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEbdU4P7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEbdU4P7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37DB1F0089B;
	Sat,  3 Oct 2026 15:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791042227;
	bh=Di9fTDRp9RZdMWSuSPqy/Wo3kkv02wMfsJBCScJ2jzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SEbdU4P7fTh/9+nJjZF47kav+nAEUzI7XJ1bs/vxaQnPuleb4/oaz+u2hatZGjJCd
	 f8S1MBhjh384CzR8+LGBjDdwYyqQlWQ7oaBsdbuU1ozsLC8e9tL+DvIXrz3Sm/hK/3
	 zeIFdrx+tXY52WQgY6460UH8PXTXGGRfVgQGwFyVts0PU1PnkuJvbSjl81A9Q2q/XI
	 BUD8qPeoU5I672+Ovzm0i9huG80BXyZNuKtfvCrlYu0Kl/FG4GfrZeTdKUEBbPCl/c
	 cqIfZBXvRALI52zirbIeuNJ7QV7ezkEZz3dVIMs67zlWlt46ZkPcJbTrBp+QguusIQ
	 at5Dcnu4pbldw==
From: SJ Park <sj@kernel.org>
To: stable@vger.kernel.org
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: [PATCH 6.18.y] mm/damon/core: don't skip damos_adjust_quota() while esz is not zero
Date: Sat,  3 Oct 2026 08:43:41 -0700
Message-ID: <20261003154341.19354-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026100311-deforest-barstool-b0d0@gregkh>
References: <2026100311-deforest-barstool-b0d0@gregkh>
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
 mm/damon/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index c0dcb190b06e..0182cc8198d3 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2248,7 +2248,8 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	unsigned long cumulated_sz, cached_esz;
 	unsigned int score, max_score = 0;
 
-	if (!quota->ms && !quota->sz && list_empty(&quota->goals))
+	if (!quota->esz && !quota->ms && !quota->sz &&
+			list_empty(&quota->goals))
 		return;
 
 	/* First charge window */
-- 
2.47.3

