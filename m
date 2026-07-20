Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C596434E20
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562520; cv=none; b=m+fezejciU8YcO5p9+zCT9Qlcru8wby1EIuZhA+z6gDqNlT9cUNKSJ5qPV6TGor2zSsjQwxSYSHjrklkCb1WXh32v1lv8y/pkDzgDhTZbCRB1zIELMkNhCMeWUMXmyIDUtaDL0GdhOXcJfjfiI3HDFJYtXDzMKhOMd/qWD9DW0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562520; c=relaxed/simple;
	bh=NHhfp5R1i5K+kl60OiV2tc7NOx74PPS7hqLUtntoo60=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Hc33D1EiqInqBhsBgojUhHbV1hrsW9pf47hnT+TxParuOeTya2ZXka+QmzA3biu1Kk8eg5Hyi1ZEWXhiUWJX2hSp8hjLyBG1IRGIMB9FDVCPKpkNhZDVC+Iao1W00wzJp7yYVl/B9W9yaescnTAcPQa5Yrveekh67sMh0lMaC5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lRTWHJ9o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lRTWHJ9o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044411F00A3A;
	Mon, 20 Jul 2026 15:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784562519;
	bh=2JOLc0xj5kBS7saAkXS4CFwM1+yV0BC+d6AuXFXJN5Q=;
	h=Subject:To:Cc:From:Date;
	b=lRTWHJ9otLzM0t/5pEVV5J/98oWGp1Qzt4XHHMmXu/CUC4+9hDCieSplQYyKntI2y
	 j0wy2gffdoyJu3mHTmLaURIXcgXfize43/hQCh+my3F2LZN6X4DTlLl4uzhUkbojbt
	 31Wm+hmGrBMWskpeN2JH1tjWUr8C3/foeoNgs550=
Subject: FAILED: patch "[PATCH] fs/resctrl: Fix use-after-free during unmount" failed to apply to 6.18-stable tree
To: tony.luck@intel.com,bp@alien8.de,reinette.chatre@intel.com,sashiko-bot@kernel.org,stable@kernel.org,yu.c.chen@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:40:28 +0200
Message-ID: <2026072028-reverence-sandy-7415@gregkh>
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
git cherry-pick -x 52fce648607e0d6a76eeb443d78708c49df1c554
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072028-reverence-sandy-7415@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 52fce648607e0d6a76eeb443d78708c49df1c554 Mon Sep 17 00:00:00 2001
From: Tony Luck <tony.luck@intel.com>
Date: Mon, 6 Jul 2026 15:46:22 -0700
Subject: [PATCH] fs/resctrl: Fix use-after-free during unmount

During unmount or failure teardown all mon_data structures that contain
monitoring event file private data are freed after which kernfs nodes are
removed. However, the RDT_DELETED flag is never set for the statically
allocated default resource group.

A concurrent reader of an event file associated with the default resource
group may, after dropping kernfs active protection, block on rdtgroup_mutex
while unmount proceeds to free the file private data and destroy the kernfs
node without waiting for the reader.

When the mutex is released, the reader wakes up, observes that RDT_DELETED
is not set for the default group, and dereferences the already-freed
file private data.

The scenario can be depicted as follows:
  CPU0                                      CPU1
   /*
    * Default resource group's
    * monitoring data accessible via
    * kernfs file with kernfs_node::priv
    * pointing to a struct mon_data.
    * User opens the file for reading.
    */
   rdtgroup_mondata_show()                 /* arch encounters fatal error */
    rdtgroup_kn_lock_live()                 resctrl_exit()
     atomic_inc(&rdtgroup_default.waitcount) cpus_read_lock()
     kernfs_break_active_protection(kn)      mutex_lock(&rdtgroup_mutex)
     cpus_read_lock()                        resctrl_fs_teardown()
     mutex_lock(&rdtgroup_mutex)              rmdir_all_sub()
                                              mon_put_kn_priv()
                                               /* Delete all mon_data structures */
                                              rdtgroup_destroy_root()
                                               kernfs_destroy_root()
                                               rdtgroup_default.kn = NULL
                                             mutex_unlock(&rdtgroup_mutex)
     /*
      * rdtgroup_default.flags is empty so
      * rdtgroup_kn_lock_live() returns
      * &rdtgroup_default
      */
     md = of->kn->priv;

     /* md points to freed mon_data */

Set RDT_DELETED for the default group unconditionally since the flag does
not lead to the freeing of this statically allocated group.

Do not allow a new resctrl mount if there are any waiters on default group
of previous mount. A new mount will re-initialize the default group that
would appear to waiters from previous mount as though the default group is
accessible causing them to access the mon_data structures from the previous
mount that have been removed.

Fixes: 2a6566038544 ("x86/resctrl: Expand the width of domid by replacing mon_data_bits")
Closes: https://sashiko.dev/#/patchset/20260508182143.14592-1-tony.luck%40intel.com?part=2 [1]
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Cc: <stable@kernel.org>
Link: https://patch.msgid.link/49a2ca3ca688f27e1a646cf90e1dc69287021127.1783377598.git.reinette.chatre@intel.com

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 1312b52c7f7b..ce277f16ea12 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -587,14 +587,20 @@ static ssize_t rdtgroup_cpus_write(struct kernfs_open_file *of,
  *
  * On resource group creation via a mkdir, an extra kernfs_node reference is
  * taken to ensure that the rdtgroup structure remains accessible for the
- * rdtgroup_kn_unlock() calls where it is removed.
+ * rdtgroup_kn_unlock() calls where it is removed. The default group is
+ * statically allocated: it does not have an extra reference but will have
+ * RDT_DELETED set on unmount to support safe access to its associated files
+ * via rdtgroup_kn_lock_live/rdtgroup_kn_unlock().
  *
- * Drop the extra reference here, then free the rdtgroup structure.
+ * For all but the default group: drop the extra reference, then free the
+ * rdtgroup structure.
  *
  * Return: void
  */
 static void rdtgroup_remove(struct rdtgroup *rdtgrp)
 {
+	if (rdtgrp == &rdtgroup_default)
+		return;
 	kernfs_put(rdtgrp->kn);
 	kfree(rdtgrp);
 }
@@ -2814,6 +2820,12 @@ static int rdt_get_tree(struct fs_context *fc)
 		goto out;
 	}
 
+	/* Avoid races from pending operations from a previous mount */
+	if (atomic_read(&rdtgroup_default.waitcount) != 0) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	ret = setup_rmid_lru_list();
 	if (ret)
 		goto out;
@@ -3177,6 +3189,7 @@ static void resctrl_fs_teardown(void)
 	mon_put_kn_priv();
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
+	rdtgroup_default.flags = RDT_DELETED;
 	closid_exit();
 	schemata_list_destroy();
 	rdtgroup_destroy_root();
@@ -4277,6 +4290,7 @@ static int rdtgroup_setup_root(struct rdt_fs_context *ctx)
 
 	ctx->kfc.root = rdt_root;
 	rdtgroup_default.kn = kernfs_root_to_node(rdt_root);
+	rdtgroup_default.flags = 0;
 
 	return 0;
 }

