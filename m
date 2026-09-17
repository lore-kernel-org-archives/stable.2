Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A08374A08
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789609187; cv=none; b=DcfeoYlI+I5L5Y1hP/AmODfBXHwXXeiGFFw4afmj5jiOF4rVHNNyHUY31NeY+E8oasTQVar3f+laLIz7fvxUH+Z/FHFSqdcGHkoNAw61KfEzeEg6Go4cPf/2GVq6GHa2ZIj/bA72ZECg7CzPpgSWK+yA32Fd73ix1wwDD8JtknI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789609187; c=relaxed/simple;
	bh=4EE5F6H628vu71vyZ2FG3MwVZuXPXbW19bhe86h7iTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h/8k4pu/xbWxYuMjrxXylaK3KMImmbMNKcSmpDQJipLEI7m45mrI1RZN5ZeM69bY5TSE1eMbV1tTRK7hrYgYV434kX7owAdj5/dY06egUtvPPELXCdl5JeCSR5jLBY1BgNmnAYD+3AKMP9J8LDIEKn1WaLT+FXGDMROrEow9Kuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+mKp52w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+mKp52w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135F21F00893;
	Thu, 17 Sep 2026 01:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789609185;
	bh=y0mlPqB0joid0mBrFQuz8jugi6bvOUJPMU2ZkVT/94o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j+mKp52wsmhg0yac7zigbY3o/CROtdbHlZ0NQ5iWZDBs0M5rIT/XuQ5pLf3xEfVTF
	 e5l4FVkXBzys6HFtU3Khpl3OHf7a9WBwx0wLm9r7Zyl7YVInDBs7NAhJQ4LPeaDEDG
	 3Tq/1KsVMOhVV2UHZcNXxsDOEt1icrKCwjp8Mx1YY8WfKth0zeYaHbA6uGdDAp7ztg
	 Riic7XgCiBPGOFn/TgaM0cWAbPDTfTzCbiiVkNS16RHyPoiaIYgy2830FroJDBXum6
	 UcIoYY0aqZ86DcyB8o5YYf63CQvCz15KHFLqxfpw/I+0/n4i68We6qOP0kedfakEtV
	 Flkyq0cbLAzAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Norbert Szetei <norbert@doyensec.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 5/5] landlock: Fix use-after-free of the source's parent directory
Date: Wed, 16 Sep 2026 21:39:40 -0400
Message-ID: <20260917013940.3651217-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917013940.3651217-1-sashal@kernel.org>
References: <2026091639-trophy-refract-3155@gregkh>
 <20260917013940.3651217-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Norbert Szetei <norbert@doyensec.com>

[ Upstream commit 2c6dc792538260a8087ac5b22c31b3b8e47c85d6 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/landlock/fs.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index a9a5fc5ba1bb8..a32658c18880f 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1196,11 +1196,12 @@ static int current_check_refer_path(struct dentry *const old_dentry,
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
@@ -1209,8 +1210,10 @@ static int current_check_refer_path(struct dentry *const old_dentry,
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
@@ -1222,8 +1225,10 @@ static int current_check_refer_path(struct dentry *const old_dentry,
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
@@ -1233,6 +1238,7 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 		request2.audit.u.path.dentry = new_dir->dentry;
 		landlock_log_denial(subject, &request2);
 	}
+	dput(old_parent);
 
 	/*
 	 * This prioritizes EACCES over EXDEV for all actions, including
-- 
2.53.0

