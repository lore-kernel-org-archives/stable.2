Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F47345CCE
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 23:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785195270; cv=none; b=ein4LiX/dJUV4qRhdJUQYfNNX+nVpHvKqrJEJXSryZO1wMvb8RlYdZBejG0b2LGrM2juOZvIB9t3GWuBar4ZH5V4LBkjYS3HRJfDNUYXBPmXIZd4dnI+Rc2a3US/IOCqY0WvOaO958bzmAgnAezmmRmNuF3GEiq+IRoV3eYbAiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785195270; c=relaxed/simple;
	bh=2g3euYrpHhipdGMxt1wSZV09wIcIZ9xebyjFnP/+uqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fxi7U7r6bgUtQcfrix7WcPCnZ4gLA3jSMGwtGZi7TZevNYVf62DrIN2M1uDFohj9GqTqiPjbuElwYxUDTQPR2L+Yr5NrrFZ8W16ZKagsaBiMREUIyo1GEG89gpnGTUpKHQa70HoZwQ3bdNz8Ty1TT3/sfpN8bx2FCVZOykdpNlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eiA6kBOA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiA6kBOA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5681F00A3A;
	Mon, 27 Jul 2026 23:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785195268;
	bh=JU+GVngn0Tod1YGjzGO5JmVW4s0CSKMJZmWlFFu92Do=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eiA6kBOAN+vsfzOaOA6KjiRzaYUcAxZfxlsdQU5mUdKo8UO9VuQlhOX+rfYaVCO+E
	 6vipetJWivoHxt8Bxn7s2ukRwPtNBiHdY8HqrnPW3O73s65+rxxZqpQmbGYqGS7LYH
	 cO2ZVtrdm4+gOCxXuFTkPOpiUgLOiKXchpTQnZrHvlg2fkvLy/B3ju9g2s17SENagN
	 wyBp48yhQKPNVpcDhF7uDXgczv+VrdNtXRnS3uqO9AxfYNb1YiEfxyTVzzUQkG42TA
	 juh2F9sqHjfqc1T/91+WtFa77U04ZLbmxwUpcUcE/nxwE1brOxXlQSRjWFdwdEv4e2
	 2gAayaFQcWueg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tony Luck <tony.luck@intel.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Reinette Chatre <reinette.chatre@intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Chen Yu <yu.c.chen@intel.com>,
	stable@kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 6/6] fs/resctrl: Fix use-after-free during unmount
Date: Mon, 27 Jul 2026 19:34:20 -0400
Message-ID: <20260727233421.2423844-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727233421.2423844-1-sashal@kernel.org>
References: <2026072028-reverence-sandy-7415@gregkh>
 <20260727233421.2423844-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Luck <tony.luck@intel.com>

[ Upstream commit 52fce648607e0d6a76eeb443d78708c49df1c554 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/resctrl/rdtgroup.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 260339c8df5081..08e26c0c9fb9cf 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -581,14 +581,20 @@ static ssize_t rdtgroup_cpus_write(struct kernfs_open_file *of,
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
@@ -2732,6 +2738,12 @@ static int rdt_get_tree(struct fs_context *fc)
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
@@ -3094,6 +3106,7 @@ static void resctrl_fs_teardown(void)
 	mon_put_kn_priv();
 	rdt_pseudo_lock_release();
 	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
+	rdtgroup_default.flags = RDT_DELETED;
 	closid_exit();
 	schemata_list_destroy();
 	rdtgroup_destroy_root();
@@ -4148,6 +4161,7 @@ static int rdtgroup_setup_root(struct rdt_fs_context *ctx)
 
 	ctx->kfc.root = rdt_root;
 	rdtgroup_default.kn = kernfs_root_to_node(rdt_root);
+	rdtgroup_default.flags = 0;
 
 	return 0;
 }
-- 
2.53.0

