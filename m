Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9FB3D9025
	for <stable@vger.kernel.org>; Tue, 11 Aug 2026 18:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474584; cv=none; b=B7MrCUT5TwaPa+RLKBp3cdiB6kRtUomfv+GuM11DkvVQFPzz+fYz5MYG23AsTFANOUJ+oq3wTjKPZe66Bcktc6/Ic2DMuuL2M/u1X5emtka1qKWGUKfERodYoBNQhOKhMy5+Yo0KcJFT90saFR6zKi/WbR/QBGymxFLAns31NjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474584; c=relaxed/simple;
	bh=4DcyXIrdz5MJ9cmSmjF/QhuZH3S7w9U5jlCxLxK0kVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtzTnjPFGnk04tlzFTNSrxVgVb9ot06ZGkQSXxHER+2CfM/O6crEEu6wl3NJbpiTgPr4fUkrjQqzwv/N3b4MoWN0c6zr/hH0GXxyI+r5jcfdC5TlZJGS0vf+3C+FsCNs4wxMQTeVsxWPdgZJL9FdWaXjdkzf8fa8r5HuRR5wRoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PWQ/K7ok; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PWQ/K7ok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9A81F000E9;
	Tue, 11 Aug 2026 18:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786474583;
	bh=XXV7Rza6TGqTvwpYnSMf6b2RYb+0PPJPuEEBOf+LNZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PWQ/K7okhmw8MLaA2Ny4MVk8z+pAwO39iJ+sZ3HKKXsfwT3WpZbJHJVpGKP0aDBnD
	 JQhnwB9NO4EGhy2mdzY2x6If0ZzyS1VUISZfIuXYdpYG9BUv08PItoBpu+KbkP88fi
	 S6kTy3xi+Y3SVK6O2VUQ/Egepit2blsQXfnvjdQPjGwM8YeO2EBuYFBjThPdU91+W9
	 476QUPH+DRnyJnXUf5ebtlLiwXNZJfAPrpW+qwU2TdwONtSobU1p9Ux3sb4kwZYtyE
	 RQQ3FB1yZhLS1vA448zzAJLysi2GDPeuvDjD0ioXO6RrqXk3LJwF5Ao4+tnoGWJPdr
	 WF52ITr0D3nYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Song Liu <song@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] fsnotify, lsm: Decouple fsnotify from lsm
Date: Tue, 11 Aug 2026 14:56:16 -0400
Message-ID: <20260811185619.3386946-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080511-putdown-richly-6ef6@gregkh>
References: <2026080511-putdown-richly-6ef6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Song Liu <song@kernel.org>

[ Upstream commit 1cda52f1b4611f4daa9d89e69d9428fb4137dc3f ]

Currently, fsnotify_open_perm() is called from security_file_open().
This is a a bit unexpected and creates otherwise unnecessary dependency
of CONFIG_FANOTIFY_ACCESS_PERMISSIONS on CONFIG_SECURITY. Fix this by
calling fsnotify_open_perm() directly.

Signed-off-by: Song Liu <song@kernel.org>
Acked-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20241013002248.3984442-1-song@kernel.org
Stable-dep-of: db1856ea9196 ("binfmt_misc: restore write access when removing an entry")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/fanotify/Kconfig | 1 -
 fs/open.c                  | 4 ++++
 security/security.c        | 9 +--------
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/notify/fanotify/Kconfig b/fs/notify/fanotify/Kconfig
index a511f9d8677ba..0e36aaf379b73 100644
--- a/fs/notify/fanotify/Kconfig
+++ b/fs/notify/fanotify/Kconfig
@@ -15,7 +15,6 @@ config FANOTIFY
 config FANOTIFY_ACCESS_PERMISSIONS
 	bool "fanotify permissions checking"
 	depends on FANOTIFY
-	depends on SECURITY
 	default n
 	help
 	   Say Y here is you want fanotify listeners to be able to make permissions
diff --git a/fs/open.c b/fs/open.c
index be7b55260a755..031a78d138ecb 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -940,6 +940,10 @@ static int do_dentry_open(struct file *f,
 	if (error)
 		goto cleanup_all;
 
+	error = fsnotify_open_perm(f);
+	if (error)
+		goto cleanup_all;
+
 	error = break_lease(file_inode(f), f->f_flags);
 	if (error)
 		goto cleanup_all;
diff --git a/security/security.c b/security/security.c
index dd6b922c12de0..de57d6e2b3a49 100644
--- a/security/security.c
+++ b/security/security.c
@@ -19,7 +19,6 @@
 #include <linux/kernel.h>
 #include <linux/kernel_read_file.h>
 #include <linux/lsm_hooks.h>
-#include <linux/fsnotify.h>
 #include <linux/mman.h>
 #include <linux/mount.h>
 #include <linux/personality.h>
@@ -3214,13 +3213,7 @@ int security_file_receive(struct file *file)
  */
 int security_file_open(struct file *file)
 {
-	int ret;
-
-	ret = call_int_hook(file_open, file);
-	if (ret)
-		return ret;
-
-	return fsnotify_open_perm(file);
+	return call_int_hook(file_open, file);
 }
 
 /**
-- 
2.53.0

