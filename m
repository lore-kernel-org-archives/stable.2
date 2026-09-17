Received: from smtp-190a.mail.infomaniak.ch (smtp-190a.mail.infomaniak.ch [185.125.25.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF83E3911B2
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657255; cv=none; b=fZzSOz3HyU+zl+KDUnTFHrJ7UKUHZktsFiN2WVtccKIe5h17ybzi6L+Xt2rnvChdTsAGT7W53iuaFtmp2071+RgD0bN7xjBpFueAvzC6p6JSbvdTL1T6kwyg34SQSzy0rtlVez3cdH3p/h7/XXsyvTU3ETAVTCdd8EY3otZ0Cj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657255; c=relaxed/simple;
	bh=RUemFhJU+5+Svw8eOzDO+pzLLIIf40WApr0NDJsP7nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VFVYOt06n8oW3VUj8iUH40PYBNhsMZpJ89YLmxDxtwrKgJK0ff6zYSZmtgsa+4SaEZ3lJ5mrx7k2hO86o82aRgkkkR04xb4SaPUibU8bgUNH/MT/JJOz871Sb++eRvvmktLh8T+KidE34hT+TrSCEi89tzgTvJ3ihXpG6PG7R/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Z7xzyOL8; arc=none smtp.client-ip=185.125.25.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Z7xzyOL8"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hlzSv67d1z1vw;
	Thu, 17 Sep 2026 17:00:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1789657215;
	bh=OWrjANAHqdKBCCawebuNE8n8Jg/xZvN7MQe+OtV6Pgc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z7xzyOL8RxQEtogyiLpyceRdSh/kRxeYLCTwFyI8XAkdLHlbkZNy8oPUC2dc9epIq
	 wU3JEgRi+GPwS57ryq/29G+HRTERWUwvuhhRTbXVYvYvYNlOkOxMrJ8QxicyQEZwoD
	 jrjpm1xUA6QuJccddgj0eWgImTqaLqhaUZJ3sKBk=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4hlzSt6jJDz8qR;
	Thu, 17 Sep 2026 17:00:14 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Sasha Levin <sashal@kernel.org>,
	=?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>,
	Song Liu <song@kernel.org>,
	Tingmao Wang <m@maowtm.org>
Subject: [PATCH 6.1.y 1/4] landlock: Fix handling of disconnected directories
Date: Thu, 17 Sep 2026 17:00:02 +0200
Message-ID: <71ca68abf74762f78612f635123cbfe1773b6de5.1789655724.git.mic@digikod.net>
In-Reply-To: <2026-09-05-daily-reply-0020-landlock-whiteout-6-1@kernel.org>
References: <2026-09-05-daily-reply-0020-landlock-whiteout-6-1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

[ Upstream commit 49c9e09d961025b22e61ef9ad56aa1c21b6ce2f1 ]

Disconnected files or directories can appear when they are visible and
opened from a bind mount, but have been renamed or moved from the source
of the bind mount in a way that makes them inaccessible from the mount
point (i.e. out of scope).

Previously, access rights tied to files or directories opened through a
disconnected directory were collected by walking the related hierarchy
down to the root of the filesystem, without taking into account the
mount point because it couldn't be found. This could lead to
inconsistent access results, potential access right widening, and
hard-to-debug renames, especially since such paths cannot be printed.

For a sandboxed task to create a disconnected directory, it needs to
have write access (i.e. FS_MAKE_REG, FS_REMOVE_FILE, and FS_REFER) to
the underlying source of the bind mount, and read access to the related
mount point.   Because a sandboxed task cannot acquire more access
rights than those defined by its Landlock domain, this could lead to
inconsistent access rights due to missing permissions that should be
inherited from the mount point hierarchy, while inheriting permissions
from the filesystem hierarchy hidden by this mount point instead.

Landlock now handles files and directories opened from disconnected
directories by taking into account the filesystem hierarchy when the
mount point is not found in the hierarchy walk, and also always taking
into account the mount point from which these disconnected directories
were opened.  This ensures that a rename is not allowed if it would
widen access rights [1].

The rationale is that, even if disconnected hierarchies might not be
visible or accessible to a sandboxed task, relying on the collected
access rights from them improves the guarantee that access rights will
not be widened during a rename because of the access right comparison
between the source and the destination (see LANDLOCK_ACCESS_FS_REFER).
It may look like this would grant more access on disconnected files and
directories, but the security policies are always enforced for all the
evaluated hierarchies.  This new behavior should be less surprising to
users and safer from an access control perspective.

Remove a wrong WARN_ON_ONCE() canary in collect_domain_accesses() and
fix the related comment.

Because opened files have their access rights stored in the related file
security properties, there is no impact for disconnected or unlinked
files.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Song Liu <song@kernel.org>
Reported-by: Tingmao Wang <m@maowtm.org>
Closes: https://lore.kernel.org/r/027d5190-b37a-40a8-84e9-4ccbc352bcdf@maowtm.org
Closes: https://lore.kernel.org/r/09b24128f86973a6022e6aa8338945fcfb9a33e4.1749925391.git.m@maowtm.org
Fixes: b91c3e4ea756 ("landlock: Add support for file reparenting with LANDLOCK_ACCESS_FS_REFER")
Fixes: cb2c7d1a1776 ("landlock: Support filesystem access-control")
Link: https://lore.kernel.org/r/b0f46246-f2c5-42ca-93ce-0d629702a987@maowtm.org [1]
Reviewed-by: Tingmao Wang <m@maowtm.org>
Link: https://lore.kernel.org/r/20251128172200.760753-2-mic@digikod.net
Signed-off-by: Mickaël Salaün <mic@digikod.net>
[mic: Backport: adjust the filesystem walk and errata insertion context]
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/errata/abi-1.h | 15 ++++++++++++
 security/landlock/fs.c           | 40 +++++++++++++++++++++++---------
 2 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/security/landlock/errata/abi-1.h b/security/landlock/errata/abi-1.h
index 53c96c2057fa..80930957e84d 100644
--- a/security/landlock/errata/abi-1.h
+++ b/security/landlock/errata/abi-1.h
@@ -1,5 +1,20 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 
+/**
+ * DOC: erratum_3
+ *
+ * Erratum 3: Disconnected directory handling
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This fix addresses an issue with disconnected directories that occur when a
+ * directory is moved outside the scope of a bind mount.  The change ensures
+ * that evaluated access rights include both those from the disconnected file
+ * hierarchy down to its filesystem root and those from the related mount point
+ * hierarchy.  This prevents access right widening through rename or link
+ * actions.
+ */
+LANDLOCK_ERRATUM(3)
+
 /**
  * DOC: erratum_4
  *
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index dd7f0fd921cf..8f20a146648c 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -607,19 +607,31 @@ static int check_access_path_dual(
 				break;
 			}
 		}
+
 		if (unlikely(IS_ROOT(walker_path.dentry))) {
+			if (likely(walker_path.mnt->mnt_flags & MNT_INTERNAL)) {
+				/*
+				 * Stops and allows access when reaching disconnected root
+				 * directories that are part of internal filesystems (e.g. nsfs,
+				 * which is reachable through /proc/<pid>/ns/<namespace>).
+				 */
+				allowed_parent1 = true;
+				allowed_parent2 = true;
+				break;
+			}
+
 			/*
-			 * Stops at disconnected root directories.  Only allows
-			 * access to internal filesystems (e.g. nsfs, which is
-			 * reachable through /proc/<pid>/ns/<namespace>).
+			 * We reached a disconnected root directory from a bind mount.
+			 * Let's continue the walk with the mount point we missed.
 			 */
-			allowed_parent1 = allowed_parent2 =
-				!!(walker_path.mnt->mnt_flags & MNT_INTERNAL);
-			break;
+			dput(walker_path.dentry);
+			walker_path.dentry = walker_path.mnt->mnt_root;
+			dget(walker_path.dentry);
+		} else {
+			parent_dentry = dget_parent(walker_path.dentry);
+			dput(walker_path.dentry);
+			walker_path.dentry = parent_dentry;
 		}
-		parent_dentry = dget_parent(walker_path.dentry);
-		dput(walker_path.dentry);
-		walker_path.dentry = parent_dentry;
 	}
 	path_put(&walker_path);
 
@@ -721,6 +733,9 @@ static inline access_mask_t maybe_remove(const struct dentry *const dentry)
  * file.  While walking from @dir to @mnt_root, we record all the domain's
  * allowed accesses in @layer_masks_dom.
  *
+ * Because of disconnected directories, this walk may not reach @mnt_dir.  In
+ * this case, the walk will continue to @mnt_dir after this call.
+ *
  * This is similar to check_access_path_dual() but much simpler because it only
  * handles walking on the same mount point and only checks one set of accesses.
  *
@@ -759,8 +774,11 @@ static bool collect_domain_accesses(
 			break;
 		}
 
-		/* We should not reach a root other than @mnt_root. */
-		if (dir == mnt_root || WARN_ON_ONCE(IS_ROOT(dir)))
+		/*
+		 * Stops at the mount point or the filesystem root for a disconnected
+		 * directory.
+		 */
+		if (dir == mnt_root || unlikely(IS_ROOT(dir)))
 			break;
 
 		parent_dentry = dget_parent(dir);
