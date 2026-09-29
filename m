Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B3F3E1D13
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670483; cv=none; b=hkF9HDjDVu5GiSvK1OWLvK1udLkzmNH/nVgnx7VM9cXv64zUEBnJ/tRzdjD3UqzOlkgfvD2ionrjxsWJRpsLmXvmiDpJNvUVrU+9+op/WRTbYhM6SwOduoTIOQp7SOnsRat/ilpamC70IcEGVBF3UsNT1Qaye3gPmzi5BszHulY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670483; c=relaxed/simple;
	bh=4HdflNjYXH38XmqBIDoyDGPJt7Nx7uEBukpgLrxK8vg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PsmNetCROCE4jL8keQjmFVbia0jTwUk1Dj/ZESgFgyl2LPYW/64OeMLMw+UlPUsbd7rLu37CaLPm1IL7XBUQCWG0YOE80HMj5X50Z2GqMsl1olYtigeNPN0NIPinC7kkW1fPAC6jFyipe2l3gRJABxytcRWzlChpiGYNQxF4g0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FyiGgLBl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FyiGgLBl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256D01F000FF;
	Tue, 29 Sep 2026 08:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790670481;
	bh=7EtQaEUOdIs/Kh1CAc/6U/5YW6drXj7VVZbeRHEdVNo=;
	h=Subject:To:Cc:From:Date;
	b=FyiGgLBlw9aj5UzFdedbMgzBaN7QXvbDQh4TiWTkmeC/ppz2BvawpND8Dx+QCNHcF
	 f3+6XHgKxKq0sn46NDkdhl6FUeV+IjFWadaUtbK7QinnixDgE1UIX71UWumfZTKckF
	 Fz2cPpb7Wp7okf5wPYOSjOQjKsAsmI5KePGUk7NA=
Subject: FAILED: patch "[PATCH] mm/damon/core: fix unconditionally skip last region" failed to apply to 6.6-stable tree
To: aethernet65535@gmail.com,akpm@linux-foundation.org,sj@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:27:48 +0200
Message-ID: <2026092948-moonrise-persecute-3597@gregkh>
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
git cherry-pick -x b3723b596b548c837a766aae3553c14a7b15af2b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092948-moonrise-persecute-3597@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b3723b596b548c837a766aae3553c14a7b15af2b Mon Sep 17 00:00:00 2001
From: Liew Rui Yan <aethernet65535@gmail.com>
Date: Tue, 8 Sep 2026 06:47:38 -0700
Subject: [PATCH] mm/damon/core: fix unconditionally skip last region

Once quota set, the charge_{target,addr}_from unconditionally skips and
resets at the last region of the tracked target, so the last region can be
skipped even when it has not been processed.

Example:

    1. Target has 2 regions: R1 (0-100 bytes) and R2 (100-200 bytes).
    2. Quota is configured to process only 100 bytes per window.
    3. Window 1: Processes R1 (0-100).  Quota is full.  charge_{target,
       addr}_from is saved at (Target, 100).
    4. Window 2: The loop reaches R2.  Because R2 is
       damon_last_region(t), the old code unconditionally returns true,
       skipping R2 entirely and resetting the charge_{target,addr}_from.

    Result: R2 is permanently skipped even though it has never been
    processed.

However, it is important to note that this is a very minor issue.  This is
because it is triggered only when the previous window saved/kept
charge_{target,addr}_from, and in the next window, all regions except the
last region were skipped by damos_skip_charged_region().

Fix this by only resetting the charge_{target,addr}_from when last region
is reached, only skipping when it is applied or cannot split.

Link: https://lore.kernel.org/20260908134739.96919-1-sj@kernel.org
Fixes: 50585192bc2e ("mm/damon/schemes: skip already charged targets and regions")
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: <stable@vger.kernel.org> # v5.16.x

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 2b294fb46648..06a253df8d4b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2342,36 +2342,39 @@ static bool damos_skip_charged_region(struct damon_target *t,
 {
 	struct damos_quota *quota = &s->quota;
 	unsigned long sz_to_skip;
+	bool skip = false;
 
 	/* Skip previously charged regions */
 	if (quota->charge_target_from) {
 		if (t != quota->charge_target_from)
 			return true;
-		if (r == damon_last_region(t)) {
-			quota->charge_target_from = NULL;
-			quota->charge_addr_from = 0;
-			return true;
-		}
 		if (quota->charge_addr_from &&
-				r->ar.end <= quota->charge_addr_from)
-			return true;
+				r->ar.end <= quota->charge_addr_from) {
+			skip = true;
+			goto out;
+		}
 
 		if (quota->charge_addr_from && r->ar.start <
 				quota->charge_addr_from) {
 			sz_to_skip = ALIGN_DOWN(quota->charge_addr_from -
 					r->ar.start, min_region_sz);
 			if (!sz_to_skip) {
-				if (damon_sz_region(r) <= min_region_sz)
-					return true;
+				if (damon_sz_region(r) <= min_region_sz) {
+					skip = true;
+					goto out;
+				}
 				sz_to_skip = min_region_sz;
 			}
 			damon_split_region_at(t, r, sz_to_skip);
-			return true;
+			skip = true;
 		}
+	}
+out:
+	if (r == damon_last_region(t)) {
 		quota->charge_target_from = NULL;
 		quota->charge_addr_from = 0;
 	}
-	return false;
+	return skip;
 }
 
 static void damos_update_stat(struct damos *s,

