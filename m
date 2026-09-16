Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B494D4D7966
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789579788; cv=none; b=KmoSiswB/RWhoTkQjuwZg/HtWzMSeya3PO9AF0+pxAvpA7Amr0YZoHIAa2L7MatR0gaCpsRn/cGgiHHD15VKFteTh6eb9mYu6THcBG6eeGuogoxUcxImRko6n84HaS2V3HOFr+JVeX1IxxsidhzqtnkJC4L+A8JrijfcjUoliOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789579788; c=relaxed/simple;
	bh=aHEizmjIAGy6ybYXwQ7OU76QN6W/+L7yXPsOhX++p5M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OfJwpkTflBdhCnMj3GQexvEq/dIYfdGf7ZvnUciWEx/OUk6JSG0aIC3k+Gn0Tk5uduwSntXOpUfLejFiUmnVnGDj979Wqrvz90b5hUPgDJrjVqGKdmOcKoIChimg4WAckuoRgcXYBAK+OSOP8a44EJCPn4lSt4AVSnNIp8UMUEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HWSPQk9g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HWSPQk9g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047991F00893;
	Wed, 16 Sep 2026 17:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789579786;
	bh=lkupH+7vLyK1p7ke4YCH0NkBjJl7ZK4K4G/YWdzYgb4=;
	h=Subject:To:Cc:From:Date;
	b=HWSPQk9gMgyiMnMOP9+jv325q4Wgcj/H5a6bTdAzmSlwebDAnf9UFP9yJqkkv3pEe
	 7DNQJKwQ5j2pXfOVYS9rkZ6eedQS/ecdLeGgR9WI9nOtP0zGdfkO3ylMAYTJc3oMl3
	 RQKmlSknQgiQq0RB/siDo1rmEnv4aLjUDxxv7MnQ=
Subject: FAILED: patch "[PATCH] xfs: initialise args->total for parent pointer updates" failed to apply to 6.12-stable tree
To: javier@peridio.com,cem@kernel.org,djwong@kernel.org,floss@jetm.me
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 18:24:10 +0100
Message-ID: <2026091609-these-relocate-53bf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8e4ebb6afaa34bd2e8ce52da231003d24111c2d6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091609-these-relocate-53bf@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8e4ebb6afaa34bd2e8ce52da231003d24111c2d6 Mon Sep 17 00:00:00 2001
From: Javier Tia <javier@peridio.com>
Date: Mon, 10 Aug 2026 17:06:17 -0600
Subject: [PATCH] xfs: initialise args->total for parent pointer updates

xfs_parent_da_args_init() builds an xfs_da_args from a zeroed
xfs_parent_args (kmem_cache_zalloc), leaving args->total == 0.
xfs_da_grow_inode_int() treats that field as a running block reservation
and subtracts from it; because it is an xfs_extlen_t (uint32_t), the
first attr-fork growth wraps it to ~0U.  That defeats the free-space
check in xfs_alloc_space_available(), and when it coincides with an AG
that has exactly zero available blocks the allocation is clamped to
maxlen 0 and returns -ENOSPC, which xfs_defer_finish_noroll() escalates
to a filesystem shutdown.

Set args->total the way the log recovery path does
(xfs_attri_recover_work(), xfs_attr_item.c:706), in the add and replace
paths that can grow the fork.  Removals and lookups never grow it, so
they leave the field alone, matching that switch.

Fixes: b7c62d90c12c ("xfs: parent pointer attribute creation")
Cc: stable@vger.kernel.org # v6.10
Signed-off-by: Javier Tia <floss@jetm.me>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/libxfs/xfs_parent.c b/fs/xfs/libxfs/xfs_parent.c
index 8d111c9b6527..a2f2f5fa640e 100644
--- a/fs/xfs/libxfs/xfs_parent.c
+++ b/fs/xfs/libxfs/xfs_parent.c
@@ -193,7 +193,7 @@ xfs_parent_addname(
 	const struct xfs_name	*parent_name,
 	struct xfs_inode	*child)
 {
-	int			error;
+	int			error, local;
 
 	error = xfs_parent_iread_extents(tp, child);
 	if (error)
@@ -203,6 +203,10 @@ xfs_parent_addname(
 	xfs_parent_da_args_init(&ppargs->args, tp, &ppargs->rec, child,
 			I_INO(child), parent_name);
 
+	/* Growing the attr fork needs a real reservation in args->total. */
+	ppargs->args.total = xfs_attr_calc_size(&ppargs->args, &local);
+	ASSERT(local);
+
 	return xfs_attr_setname(&ppargs->args, 0);
 }
 
@@ -239,7 +243,7 @@ xfs_parent_replacename(
 	const struct xfs_name	*new_name,
 	struct xfs_inode	*child)
 {
-	int			error;
+	int			error, local;
 
 	error = xfs_parent_iread_extents(tp, child);
 	if (error)
@@ -249,6 +253,10 @@ xfs_parent_replacename(
 	xfs_parent_da_args_init(&ppargs->args, tp, &ppargs->rec, child,
 			I_INO(child), old_name);
 
+	/* Growing the attr fork needs a real reservation in args->total. */
+	ppargs->args.total = xfs_attr_calc_size(&ppargs->args, &local);
+	ASSERT(local);
+
 	xfs_inode_to_parent_rec(&ppargs->new_rec, new_dp);
 
 	ppargs->args.new_name = new_name->name;

