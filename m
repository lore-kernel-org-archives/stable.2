Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C56739061D
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670494; cv=none; b=H4PRXpob4cBcnPV4bI5/HuqJlpBuj0CHy42wClTwZR7BlmJN7fQ/JyfKQ/wcI62nQ4HNZUZe2+FG0vB0V3BKiNho9hUMYKp2yfrOQgdFbsoNfpIOl4jcs9T6Ydy40eTH4uPkIU5mzSPTlAxTQYAwUGixEQiIkFutDYZ12xqzyFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670494; c=relaxed/simple;
	bh=oS0Rn1I/N4SU578D7nXpUNKs27MJuuAkM1c9y5iCTKg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=WUC3g4TWjexlk1WXjkCNJNWK40TA+qpsdNdy2yBvgIZu5DMaw12ILVwKCSAHzeAPh0go8+EkUXCBVPhKdbhLBDbvCgXNzTMC40OBvnLBUbpdqekDfvVtLAp/2+WVcemHROXBkgBZXnzyAG7oqFKZ7LYISrOWPclMc8zb7C+TdFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RYxwsX35; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RYxwsX35"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 729BE1F00893;
	Tue, 29 Sep 2026 08:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790670493;
	bh=OGFWTZvmlb9+HvXPxLwrVov0kMfFGhwjpiF5+lLm6ow=;
	h=Subject:To:Cc:From:Date;
	b=RYxwsX35DpYHwHA2kBFy6xXzSQ4n2KmtJ+7BRAI7Ccmsz3zFNle1Xg52hQdkqgaq7
	 PgaBN0XMvPZKdJ82SVOv3xaP1Ce85LO05ldswKnvb5BMutSxbwoEqU8vk86f7rQzCu
	 GxFtYQ/3GcnOmGNe470OdLa0EUMHH3jcA0lIV1X4=
Subject: FAILED: patch "[PATCH] mm/damon/core: allow esz to be set to zero" failed to apply to 6.6-stable tree
To: aethernet65535@gmail.com,akpm@linux-foundation.org,sj@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:28:00 +0200
Message-ID: <2026092900-finalize-hungry-54dc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 90179da203ba8b708c84a12a07cd44be0f346334
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092900-finalize-hungry-54dc@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

