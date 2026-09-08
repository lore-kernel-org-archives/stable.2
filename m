Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F67544883
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872167; cv=none; b=WXURdLJIoFrrtnZvLqm7ecF/+vD3g0LGv3YphMk5cLZeDpo7WH4asyFrPAfM95/vPUFMln5Ns+anEcIWElYNguj0hiwU0cWyLJbjcR7vjNNCkf6VANmxdN4A97s1xwbH3aoA93q4sEGwwdd5Ziot3Dpe4WAgOkl7OSAYbPVGPwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872167; c=relaxed/simple;
	bh=+mEN1ESh8LfiqXj5+fkfJuvnfRq8ISvv7b2p2+wF25Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=i5MzJZqikQLDyQrvhu7NjzkpOURPNT8xFyTFpoqP+abBhv67yHcWg3rA0WkrFE1lFdxMncR9CT7aD0/79GXwlFklVCBjcDeqB/iO9MMD+XE3dXJ+aZ6MFY/lcx7aix+ZKMfu0fHUHRb6eE/wmyYbSHxFlBXLpmzVETZQussWSRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x+Q+ysFm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x+Q+ysFm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65ACC1F00A3A;
	Tue,  8 Sep 2026 12:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788872165;
	bh=dkJ7HK7BTDaF2zXhh7CyUG4ZHf27PN0W4Ipcp+SFFWc=;
	h=Subject:To:Cc:From:Date;
	b=x+Q+ysFmJfAgpv/Y1iW+M8bNYU3Is2rXJrRcTa1ziw7WBK7lXZcLTL94uTvOfvrwH
	 QOha09lGd1jhyN5U5UacUqFdTXXgfrmCHVeZnd5hxgUkSWHK5/VAlwh6dYFkNk9s68
	 rPp2p3RZpA97s7RKvrpBpjDSgmZmRLKN7f20Xl/0=
Subject: FAILED: patch "[PATCH] mm/damon/sysfs: read ops_id only once in" failed to apply to 6.18-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:48:58 +0200
Message-ID: <2026090858-arousal-getting-ee35@gregkh>
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
git cherry-pick -x 5adaaa28be8a79ddd7e103b171f9d6e14e7fc26e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090858-arousal-getting-ee35@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5adaaa28be8a79ddd7e103b171f9d6e14e7fc26e Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Tue, 14 Jul 2026 20:10:01 -0700
Subject: [PATCH] mm/damon/sysfs: read ops_id only once in
 damon_sysfs_apply_inputs()

damon_sysfs_apply_inputs() reads ops_id twice.  It could race with
ops_id_store().  As a result, the min_region_sz could wrongly be set up.
Read it once.

The user impact is trivial.  Sane users ain't update the parameter in
parallel.  Even if it happens, the DAMON core layer handles the wrong
min_region_sz (!is_power_of_2()).  Even if somehow the race ended up
making a min_region_sz that is different from the user's intention but
still valid, only monitoring itself runs differently than expected.  No
critical consequences like kernel panic or memory corruption happen

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260715031002.108504-7-sj@kernel.org
Link: https://lore.kernel.org/20260703172417.95426-1-sj@kernel.org [1]
Fixes: 8d009da32f13 ("mm/damon/sysfs: set damon_ctx->min_sz_region only for paddr use case")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 3db4da88fc72..e3858ffab4b2 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2094,14 +2094,16 @@ static inline bool damon_sysfs_kdamond_running(
 static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 		struct damon_sysfs_context *sys_ctx)
 {
+	enum damon_ops_id ops_id;
 	int err;
 
-	err = damon_select_ops(ctx, sys_ctx->ops_id);
+	ops_id = READ_ONCE(sys_ctx->ops_id);
+	err = damon_select_ops(ctx, ops_id);
 	if (err)
 		return err;
 	ctx->addr_unit = READ_ONCE(sys_ctx->addr_unit);
 	/* addr_unit is respected by only DAMON_OPS_PADDR */
-	if (sys_ctx->ops_id == DAMON_OPS_PADDR)
+	if (ops_id == DAMON_OPS_PADDR)
 		ctx->min_region_sz = max(
 				DAMON_MIN_REGION_SZ / ctx->addr_unit, 1);
 	ctx->pause = sys_ctx->pause;

