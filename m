Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5F43E51D3
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670497; cv=none; b=hkVD/El1lyMwwOaTTD4/j7WuT/r7GrtsncSWs0pYod8SZihWOtyWeB6ypqEKGTtkMTa0jXz2PsL1YlFrgFDqaXr250rTReb/AqkPQOMFSQGQ4fLl4WkIZ2I1tUNMbRLj6hUq7wqWZYRkm2yNYmTYwW1WHOzr34BYra7ndNDfXEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670497; c=relaxed/simple;
	bh=BG18L8SbZ/IvLDchoFNVCW/YXPrVUdbunAF+zDufx9E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HU840DnqSIXM17Abkqhe2y5CFZvbyHnPkd56Voal/r9SpvaBdumwsf28IXnUm4cOXGcstSBYizRn7eCQijZZNHy/33IAvtZmBnH4Kg0L4G2CbXnKr7YXcvPKoqP0GOKZI6rTLTmJHtt7xYBrMGm2gEImOLG9983eJ7c2o91TCBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hM2dg70A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hM2dg70A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B401F000FF;
	Tue, 29 Sep 2026 08:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790670495;
	bh=gXjDTwx2Jm+ua2RN/VdOwcQs6XMdTjeh/cp6Jm9STPQ=;
	h=Subject:To:Cc:From:Date;
	b=hM2dg70A7foip2h4ctGiVlAMOO7I1kZ1T+vrzOE4bWRLwcGcC2flX5N407R7qgtjT
	 e+jPLB2iHrMBK6c5QV+Hp/NDG+HRIBDQzNLFABNqA8aJy/8NAIA+9/4besycbNjKWs
	 zAMRHiAVThXvZZ+e5WBzG1lnV8aZXcUNKL3G8bE8=
Subject: FAILED: patch "[PATCH] mm/damon/core: allow esz to be set to zero" failed to apply to 6.18-stable tree
To: aethernet65535@gmail.com,akpm@linux-foundation.org,sj@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:28:00 +0200
Message-ID: <2026092900-avenue-magnetize-e7a6@gregkh>
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
git cherry-pick -x 90179da203ba8b708c84a12a07cd44be0f346334
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092900-avenue-magnetize-e7a6@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 90179da203ba8b708c84a12a07cd44be0f346334 Mon Sep 17 00:00:00 2001
From: Liew Rui Yan <aethernet65535@gmail.com>
Date: Tue, 8 Sep 2026 06:54:11 -0700
Subject: [PATCH] mm/damon/core: allow esz to be set to zero

When the temporal quota goal tuner determines that the goal has been
achieved (score >= 10000), it sets esz_bp to zero so that the esz becomes
zero.  However, damos_set_effective_quota() clamps the esz to
min_region_sz when quota->ms is set.

This is a minor issue, the main problem is that it doesn't match the
description in the documentation, which state that if the goal has already
been [over-]achieved, the quota will be set to zero.

Fix this by set quota (esz) as minimum as possible.

Link: https://lore.kernel.org/20260908135413.97570-1-sj@kernel.org
Fixes: 8bbde987c2b8 ("mm/damon/core: disallow time-quota setting zero esz")
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: SJ Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # v7.1.x

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 644daf5a1656..2b294fb46648 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3091,6 +3091,7 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
 	struct damos_quota *quota = &s->quota;
 	unsigned long throughput;
 	unsigned long esz = ULONG_MAX;
+	unsigned long esz_time;
 
 	if (!quota->ms && list_empty(&quota->goals)) {
 		quota->esz = quota->sz;
@@ -3111,8 +3112,8 @@ static void damos_set_effective_quota(struct damon_ctx *ctx, struct damos *s)
 					1000000, quota->total_charged_ns);
 		else
 			throughput = PAGE_SIZE * 1024;
-		esz = min(throughput * quota->ms, esz);
-		esz = max(ctx->min_region_sz, esz);
+		esz_time = max(throughput * quota->ms, ctx->min_region_sz);
+		esz = min(esz_time, esz);
 	}
 
 	if (quota->sz && quota->sz < esz)

