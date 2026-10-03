Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B5B165F16
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791034276; cv=none; b=UuzbvfG/6rq8iypajL4n6Krkh4YJarDmP6uoKG4NN4Jo59SdO7WC5K7AcAXnnUnWbCG7n6KDWB5azrBHrV/TVw/1Gw1g0cocgjzUbkv/00GOE3YpptDnTXepJeqi9Es4VNZtK2E0OcdGVTamLYerNrZbNHjUwiTQ637elZ+BcAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791034276; c=relaxed/simple;
	bh=5OBgB1d1JiHHN2QgeLvjDoK2KLmk9DbyhEK6xmXK9So=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=P8c8VMq+9JFzAF17ajoU79tBCGERdricTdl5MZZm1oLAgDFXxj0oPs/j4fcG+Gu9xOwR8UJk/KH2S6JqF3Tcq66PJIey4TlYZPRRTRS1XHNw+P329BMAqeQAQfmqq0tbXyMl8BI5rNK92bqbQ7ioCcpo0a8fSni6ipDvPl2CWNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=d9gQw06b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d9gQw06b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84391F0089D;
	Sat,  3 Oct 2026 13:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791034274;
	bh=7rADaUzy++gZnvdyxXrzOGoaE7TDfnHVeqFfHqdVaCQ=;
	h=Subject:To:Cc:From:Date;
	b=d9gQw06b/x0pxoWGT9Qhe6g30ajq6GwRob90e8Y5Tgan8b+VCG/0IU68iZ/97Jkog
	 OAFRPuR6Jy8D26rJ/iUfwdy69oOCnW4O4Khh456ySwGR0ByaRxzGoqG57e3yydGUC1
	 vibi3itJugM5hxg1yuViyHz7aSDlaNCdLBReP/vE=
Subject: FAILED: patch "[PATCH] mm/damon/core: don't skip damos_adjust_quota() while esz is" failed to apply to 6.18-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,kunwu.chan@gmail.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 03 Oct 2026 15:31:11 +0200
Message-ID: <2026100311-deforest-barstool-b0d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 52ae167ce16609c7e6fffef588b3c2c26de2db19
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100311-deforest-barstool-b0d0@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 52ae167ce16609c7e6fffef588b3c2c26de2db19 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Wed, 16 Sep 2026 06:50:19 -0700
Subject: [PATCH] mm/damon/core: don't skip damos_adjust_quota() while esz is
 not zero

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

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 1764620903f2..ab3c4d754964 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3147,7 +3147,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 	unsigned long cumulated_sz, cached_esz;
 	unsigned int score, max_score = 0;
 
-	if (!quota->ms && !quota->sz && list_empty(&quota->goals))
+	if (!damos_quota_is_set(quota))
 		return;
 
 	/* First charge window */

