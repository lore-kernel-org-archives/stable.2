Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE3F390CB8
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789612072; cv=none; b=VXz349qIykSLMR2yqYv0ofNRIvONh/Prd/cxI3fu4o3oBRcOKEWM0Va9vXelYAv6JpjBMcwWZnjEpRPQXNRksbm/Ky5uQoPB5GeHPHSSXUyzd40gANBqMHwe96lgRS7VUFcLyuv9qbQ5hq4dCclmo+O6U/f8WZc1JRt2pfwbS1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789612072; c=relaxed/simple;
	bh=Zjoh+GrcGESKUR7cwb5OzlgOJN+O3zM2CM/TqZKh/Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHte942FeNfHmIvjISP+z1ZTlh/Xb91+SQkB9Ob67n4XqiADzStFbtN8bSJcCwF3iYjymROm63QSQA4srGNJgVCGtQ1UIDuLtCVPj058o066BJq0chfFphOu+cS1bg3hrDBpKCT194Eqa2fTfQ6d90Ad9W25DseLKXbafyaDJyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tmc7asz/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tmc7asz/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978CF1F00898;
	Thu, 17 Sep 2026 02:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789612056;
	bh=JxXb1HTX8jWPoZuJcA6PV2WDh813IoxTrEPeKXwwBHs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tmc7asz/2Zdbo11gGRV8pjF16S8xfob1DCb6S4fqF35zzP/OlMa+IqUJVXziJ9e21
	 zrnhO4uSK70tDy132H3mPrO9IRPeSJKgr32aamgz4A9Qr3au+qFPp3xL/wEyLM2jQk
	 GS4+t/MzIG4Tc9GnBD1Cl6A2pJWDf5jfbZx0ojsY/l9RMF/S2efNiRUVidgc11smpa
	 qL2s74942Q8kDXzFFBCDOF+gHFDuyk9yyaQo6jXBvNajDURRP0bN2g2YJ2VVgJAd0e
	 XiB0qQWVoKLalKpbxzIflNTJ5HzvQfo+3E5oLNHiw7eaCCJ3njPJ0yV0ZNA+ifpuKU
	 kPfHXdtNzV75A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Norbert Szetei <norbert@doyensec.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] landlock: Fix use-after-free of the source's parent directory
Date: Wed, 16 Sep 2026 22:27:33 -0400
Message-ID: <20260917022733.3831420-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917022733.3831420-1-sashal@kernel.org>
References: <2026091642-android-strode-2706@gregkh>
 <20260917022733.3831420-1-sashal@kernel.org>
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
[ adapted to older Landlock helpers using dom and lacking audit arguments. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/landlock/fs.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index b96a4daa5b2a2..5b852c2965cf2 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -1192,11 +1192,12 @@ static int current_check_refer_path(struct dentry *const old_dentry,
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
 	allow_parent1 = collect_domain_accesses(dom, mnt_dir.dentry, old_parent,
@@ -1204,8 +1205,10 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	allow_parent2 = collect_domain_accesses(
 		dom, mnt_dir.dentry, new_dir->dentry, &layer_masks_parent2);
 
-	if (allow_parent1 && allow_parent2)
+	if (allow_parent1 && allow_parent2) {
+		dput(old_parent);
 		return 0;
+	}
 
 	/*
 	 * To be able to compare source and destination domain access rights,
@@ -1216,8 +1219,11 @@ static int current_check_refer_path(struct dentry *const old_dentry,
 	if (is_access_to_paths_allowed(
 		    dom, &mnt_dir, access_request_parent1, &layer_masks_parent1,
 		    old_dentry, access_request_parent2, &layer_masks_parent2,
-		    exchange ? new_dentry : NULL))
+		    exchange ? new_dentry : NULL)) {
+		dput(old_parent);
 		return 0;
+	}
+	dput(old_parent);
 
 	/*
 	 * This prioritizes EACCES over EXDEV for all actions, including
-- 
2.53.0

