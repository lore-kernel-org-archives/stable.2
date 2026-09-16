Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF7E3BCD34
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574828; cv=none; b=t3y11dCQa4NRD20eCCn9nWVV5XUFMyV6eCkQqDnT6ZsxkncKpPSVcdHomP/WChuKcrohQPRAcxA8EZs+Kz98/f6pWzPvzv9FGxiwQ4KiVgu2BcCkYROitbIVn05YC5jNm6GRbT3LiVB+Np5cjn/Yg/J9CIfoCXRngK9teYRS/Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574828; c=relaxed/simple;
	bh=fi7bLisD2fTUze5Xemc0WwWqgp9VKXx8s+PGs02BBJ8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EF/JgMTBBrlS3m1wPm0ou3U1NqjPo+e7Xubu5a0fy/nyAi44r5/WQOtKopwPdfjtbChNf3bKkuKqJ6KoJ7zSqKR1ly3ph8NbxfloMbJQmfLEV6BRcQ4NFKHQgy6O/Yc5cOy2Z9EVVAHzBiePsdpDllt5gMEJ36MCWsr6Ma2aP60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v1267S/X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v1267S/X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 547C11F000FF;
	Wed, 16 Sep 2026 16:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789574826;
	bh=8dyrAO+H9QLIiaoNYTCgi69lMvOOHYyicrkvtpkn+Jw=;
	h=Subject:To:Cc:From:Date;
	b=v1267S/X2sFxVCa/xPcOQzIchku5F3/D3rj9Wb8FGJhUeNolgU1GDOBW4XEwIrgKq
	 PKMaGSePVeImt3C2ymdVppEPEnceq7Hb8QP7JhqoOfVuH006dwA5lbS9L6q2vvcNtl
	 8NiuqzS0fCuTC+tbexHlLSIaFyIzfD6vXiB4JNK4=
Subject: FAILED: patch "[PATCH] landlock: Fix use-after-free of the source's parent directory" failed to apply to 6.18-stable tree
To: norbert@doyensec.com,gnoack3000@gmail.com,mic@digikod.net
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:46:39 +0100
Message-ID: <2026091639-trophy-refract-3155@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 2c6dc792538260a8087ac5b22c31b3b8e47c85d6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091639-trophy-refract-3155@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2c6dc792538260a8087ac5b22c31b3b8e47c85d6 Mon Sep 17 00:00:00 2001
From: Norbert Szetei <norbert@doyensec.com>
Date: Sat, 22 Aug 2026 14:29:00 +0200
Subject: [PATCH] landlock: Fix use-after-free of the source's parent directory
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

current_check_refer_path() reads old_dentry->d_parent without holding a
reference nor a lock on it, and then dereferences it in
collect_domain_accesses() and in the audit record.

A reference on a child does not pin its parent: __d_move() reassigns
dentry->d_parent and drops the reference the child held on its former
parent.  hook_path_rename() is not affected because the rename path
calls lock_rename() before the hook, so the source cannot be reparented
under it.  hook_path_link() has no such protection: filename_linkat()
holds a reference on the source dentry but neither locks nor references
its parent, so a concurrent rename(2) can reparent the source while
security_path_link() runs, and the former parent can then be removed and
freed while the hook walks it.

A process can trigger this after entering a Landlock domain that handles
at least one filesystem access right.  The process can then race a
linkat(2) loop against rename(2) and rmdir(2):

  BUG: KASAN: slab-use-after-free in collect_domain_accesses+0x278/0x290
  Read of size 4 at addr ffff888160bd53f4 by task llrepro2/549
   collect_domain_accesses+0x278/0x290
   current_check_refer_path+0x952/0x1120
   security_path_link+0x1be/0x320
   filename_linkat+0x342/0x6d0
   __x64_sys_linkat+0xfa/0x150
  Freed by task 562:
   kmem_cache_free+0x139/0x4c0
   i_callback+0x4b/0x80
   rcu_core+0x7dc/0x10a0

Take a reference on the dentry selected as the source parent, using
dget() for the common-mount-root case and dget_parent() otherwise.
Release it after the hierarchy walk and synchronous audit logging.

Cc: stable@vger.kernel.org
Fixes: b91c3e4ea756 ("landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER")
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
Reviewed-by: Günther Noack <gnoack3000@gmail.com>
Tested-by: Günther Noack <gnoack3000@gmail.com>
Link: https://patch.msgid.link/E9CDD9E6-E960-4DE2-B1AC-5667D52ABB3E@doyensec.com
[mic: Clarify the caller, reachability, and reference handling]
Signed-off-by: Mickaël Salaün <mic@digikod.net>

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 30aa6ce13590..330a1871bf94 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1298,11 +1298,12 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	/*
 	 * old_dentry may be the root of the common mount point and
 	 * !IS_ROOT(old_dentry) at the same time (e.g. with open_tree() and
-	 * OPEN_TREE_CLONE).  We do not need to call dget(old_parent) because
-	 * we keep a reference to old_dentry.
+	 * OPEN_TREE_CLONE).  Pin the dentry used as old_parent in either case.
+	 * Otherwise, dget_parent() safely fetches and pins the current parent
+	 * against a concurrent rename(2).
 	 */
-	old_parent = (old_dentry == mnt_dir.dentry) ? old_dentry :
-						      old_dentry->d_parent;
+	old_parent = (old_dentry == mnt_dir.dentry) ? dget(old_dentry) :
+						      dget_parent(old_dentry);
 
 	/* new_dir->dentry is equal to new_dentry->d_parent */
 	allow_parent1 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
@@ -1311,8 +1312,10 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	allow_parent2 = collect_domain_accesses(subject->domain, mnt_dir.dentry,
 						new_dir->dentry,
 						&layer_masks_parent2);
-	if (allow_parent1 && allow_parent2)
+	if (allow_parent1 && allow_parent2) {
+		dput(old_parent);
 		return 0;
+	}
 
 	/*
 	 * To be able to compare source and destination domain access rights,
@@ -1324,8 +1327,10 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 		    subject->domain, &mnt_dir, access_request_parent1,
 		    &layer_masks_parent1, &request1, old_dentry,
 		    access_request_parent2, &layer_masks_parent2, &request2,
-		    exchange ? new_dentry : NULL))
+		    exchange ? new_dentry : NULL)) {
+		dput(old_parent);
 		return 0;
+	}
 
 	if (request1.access) {
 		request1.audit.u.path.dentry = old_parent;
@@ -1335,6 +1340,7 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 		request2.audit.u.path.dentry = new_dir->dentry;
 		landlock_log_denial(subject, &request2);
 	}
+	dput(old_parent);
 
 	/*
 	 * This prioritizes EACCES over EXDEV for all actions, including

