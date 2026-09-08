Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2F8544881
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 12:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872164; cv=none; b=AJdheIgr5mH6VHNcZ3d2gobZYkYEHz1SG3p4KFENa9LFGPAB5jb/3vNv9euVWPWXhTjeXZCx2ZoyYyOxjGwWAWf4HFyi+/5gRZkuHAqC+KHC3Hml6R2NIoyhEQfzFOvOwrhmIIK/Z/Hnb3OvyAHU0cYF9wTXKp4XnhxLVwFxK5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872164; c=relaxed/simple;
	bh=1FvS9TeLNwg+8scOWlFvhtfRF9RoQdXh/7SjIgsIvF8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=h0+JnPPQ4l6XmNLd/zbTG3KwEgWTsoDk1UOCFKDh/YtQ27fT5HwD9POmxlL8IU2i4Dp2068iW8zCoGrH6w/XDdj1qkKcnWnY1k70O26J8yUVxaHD1epivZ6/TbAsJhQHbjGwmrzYK5YMSg7QxECYDztCwzdrFQqhdaYno7lTzHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eDy+QMA+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eDy+QMA+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424871F00A3D;
	Tue,  8 Sep 2026 12:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788872162;
	bh=bOKlhZ+HrY0BBpcicVrFg5xTI1dcOfUoeVtv68sWdEc=;
	h=Subject:To:Cc:From:Date;
	b=eDy+QMA+AYfHq0jDcU21i+hQx1JdAfSp7XfwhksPdA43Aoar3eI6sFaL83FQcNcoW
	 20fjas6k/lOEwJsMR4eBu7ZX9gDKkQ23aZIUlhUBerexiTiLL2VhhjHU38BE4GQZVG
	 1FcOjt+8CmdM/80JkgxBeXKH69GGrTPeb7aoO0R0=
Subject: FAILED: patch "[PATCH] mm/damon/sysfs: read addr_unit only once in" failed to apply to 6.18-stable tree
To: sj@kernel.org,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 14:48:50 +0200
Message-ID: <2026090850-untried-sanctity-a00c@gregkh>
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
git cherry-pick -x ab4d9358e32316fa39b5f1f5360292135978c3d9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090850-untried-sanctity-a00c@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ab4d9358e32316fa39b5f1f5360292135978c3d9 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Tue, 14 Jul 2026 20:10:00 -0700
Subject: [PATCH] mm/damon/sysfs: read addr_unit only once in
 damon_sysfs_apply_inputs()

damon_sysfs_apply_inputs() reads addr_unit twice.  It could race with
addr_unit_store().  As a result, the min_region_sz could wrongly be set
up.  Read it once.

The user impact is trivial.  Sane users ain't update the parameter in
parallel.  Even if it happens, the DAMON core layer handles the wrong
min_region_sz (!is_power_of_2()).  Even if somehow the race ended up
making a min_region_sz that is different from the user's intention but
still valid, only monitoring itself runs differently than expected.  No
critical consequences like kernel panic or memory corruption happen.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260715031002.108504-6-sj@kernel.org
Link: https://lore.kernel.org/20260714142950.100711-1-sj@kernel.org [1]
Fixes: 540a2aebc657 ("mm/damon/sysfs: implement addr_unit file under context dir")
Signed-off-by: SJ Park <sj@kernel.org>
Cc: <stable@vger.kernel.org> # 6.18.x
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 208bb639f50f..3db4da88fc72 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2099,11 +2099,11 @@ static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
 	err = damon_select_ops(ctx, sys_ctx->ops_id);
 	if (err)
 		return err;
-	ctx->addr_unit = sys_ctx->addr_unit;
+	ctx->addr_unit = READ_ONCE(sys_ctx->addr_unit);
 	/* addr_unit is respected by only DAMON_OPS_PADDR */
 	if (sys_ctx->ops_id == DAMON_OPS_PADDR)
 		ctx->min_region_sz = max(
-				DAMON_MIN_REGION_SZ / sys_ctx->addr_unit, 1);
+				DAMON_MIN_REGION_SZ / ctx->addr_unit, 1);
 	ctx->pause = sys_ctx->pause;
 	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
 	if (err)

