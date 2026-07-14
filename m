Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BD7271456
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044276; cv=none; b=EcITMy9QPB9Kuj3pkA8013UbXnkiHMeibwM60Els9SFhO4IO+/weDCX/6FEiqW8Ld1Iz6xfr/ujfDgM0THIZYbAC6iZzdKgtBxhJ7HKu7urL/9GjJ4gxEwuxU+ZPECQLMMKFUXX9e9cldlRbfRc02DXvBnDKvUF9I/rc+WKMnB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044276; c=relaxed/simple;
	bh=1fBqWbyrGSxZXHLgBUqljvjYG9Vv8GpgHfzmJxoUaFw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jHUIvVeczEYK5a0PaDsY9ARvwI3/t3lxlQZHIpXbWDmZWRrtd2oa9kibjdGFLsyfVqpOPu/mRK3Qi3j3LGuSqKWCNzh66yPr6o30GHTSdjXzW9uCHzSoqdGQPAnJJ+ZCb4ZKciInEu/vHwAxm6XaQUDAVPy7tLdG7BRJe4FFCpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BgZilnhW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BgZilnhW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CBE41F000E9;
	Tue, 14 Jul 2026 15:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784044273;
	bh=l6ct6FcyC/3Jm64vGyesIqmybKPt0VLVtZhmurOLLYM=;
	h=Subject:To:Cc:From:Date;
	b=BgZilnhWbTqJSGwHwFkv+UfwAcO4jSok5LNFKERV4VsYBbVIEVDzxH9vjazRG9z12
	 Vuk1Qmdo5lxoKvtPD6LraLTS7bC09+8X7EY1hbOX8mUAyr4BXmRhxkEB7Vqv48ol+8
	 QC0RDUQlQBZy3zH0NJA+uCna4SLOdvQFU+yPh51A=
Subject: FAILED: patch "[PATCH] xfs: fix unreachable BIGTIME check in dquot flush validation" failed to apply to 5.10-stable tree
To: sdl@nppct.ru,achender@kernel.org,cem@kernel.org,djwong@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 17:51:07 +0200
Message-ID: <2026071407-parmesan-cyclic-e3d5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 03866d130ed33ab68cc7faaf4bf2c4abef96d42e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071407-parmesan-cyclic-e3d5@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 03866d130ed33ab68cc7faaf4bf2c4abef96d42e Mon Sep 17 00:00:00 2001
From: Alexey Nepomnyashih <sdl@nppct.ru>
Date: Wed, 3 Jun 2026 20:41:47 +0000
Subject: [PATCH] xfs: fix unreachable BIGTIME check in dquot flush validation

The dqp->q_id == 0 check inside the XFS_DQTYPE_BIGTIME block is
unreachable because root dquots return successfully earlier. Reject root
dquots with XFS_DQTYPE_BIGTIME before that early return, preserving the
intended validation and removing the unreachable condition.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 4ea1ff3b4968 ("xfs: widen ondisk quota expiration timestamps to handle y2038+")
Cc: stable@vger.kernel.org # v5.10+
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Allison Henderson <achender@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index 69e9bc588c8b..c311f61d9554 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -1216,6 +1216,14 @@ xfs_qm_dqflush_check(
 	    type != XFS_DQTYPE_PROJ)
 		return __this_address;
 
+	/* bigtime flag should never be set on root dquots */
+	if (dqp->q_type & XFS_DQTYPE_BIGTIME) {
+		if (!xfs_has_bigtime(dqp->q_mount))
+			return __this_address;
+		if (dqp->q_id == 0)
+			return __this_address;
+	}
+
 	if (dqp->q_id == 0)
 		return NULL;
 
@@ -1231,14 +1239,6 @@ xfs_qm_dqflush_check(
 	    !dqp->q_rtb.timer)
 		return __this_address;
 
-	/* bigtime flag should never be set on root dquots */
-	if (dqp->q_type & XFS_DQTYPE_BIGTIME) {
-		if (!xfs_has_bigtime(dqp->q_mount))
-			return __this_address;
-		if (dqp->q_id == 0)
-			return __this_address;
-	}
-
 	return NULL;
 }
 

