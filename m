Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7C846F4B1
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 11:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784720328; cv=none; b=i5qKX5qOvta7re/l7orct5JKFhYZD7FC/ZyhiHLJ1TKj9gIb2xtYNHN+8uBJzyT4MyXdyQsNbUhwi8h4CBUzYn0XG/c6yyGY+0A4VxT/Ty8EnMjussLhMY+ZGeBeAr20xrL4fX5xX/U4gO3Lsp1RSRZsfKoVoics27qOWsYR7JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784720328; c=relaxed/simple;
	bh=q7a650NRNZqD95B4OLC5toRX2gFUtbVbVDVCWSwcOsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hl9/OV9sz/PEhys8Fd4GEBI432R9mTuxGs/jxHHOHgfScxiYYupqgcvseNIiL4xhqS7AY7Df5CSdhaLtZUQsYjDGGvE+wkAeibthj2xg7nZDV0KOxEQ17atGeku77LGE6E/trwh3HsOwmsVVh1Flrf9lSSnp77RWTte1tZN71mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIw5t9b9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIw5t9b9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462011F00A3D;
	Wed, 22 Jul 2026 11:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784720324;
	bh=54y0mTEC4xsoYkuc9iu+O4AgOH4oDV/yL+fUNskIr4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RIw5t9b9AXdskNi2r9yQjVBVs487Vk0lqd2LaHIq4/VolS6IPNAwPtUhrYj2qXWgI
	 NuFXFAf1eGQluk8ugZZplMu5rY2xNfDBHkvX/A6r5ruzXPK0KJqJMyTQb1n7R5hvoX
	 yyOgdIBkN+RYk07aM6ymr8f9zeIKdr+Ry2zMrd0LFUS5+whdq0UcldgSuqSqXvzUcg
	 8Wfpr82TpqVg5MZhiQGZL0JwLqTYySO+WtNfoNh+8s4DYa3wS+d+Qz0UodSaONzCVW
	 mtdL9UTk5vDCkx05zhP1hJYgEgPjLwpw3jM5qBkvme5LnrjOamV7jyfJpJakIVrBex
	 y8eAaNuf74n5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ricardo Robaina <rrobaina@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] audit: use 'unsigned int' instead of 'unsigned'
Date: Wed, 22 Jul 2026 07:38:40 -0400
Message-ID: <20260722113841.1168662-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722113841.1168662-1-sashal@kernel.org>
References: <2026071653-tartly-scoundrel-d2b3@gregkh>
 <20260722113841.1168662-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ricardo Robaina <rrobaina@redhat.com>

[ Upstream commit 8b226771014beab1292081151a99530886ce54b4 ]

Address checkpatch.pl warning below, across the audit subsystem:

  WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Minor cleanup, no functional changes.

Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Stable-dep-of: 81905b5acbe7 ("audit: fix recursive locking deadlock in audit_dupe_exe()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/audit.h | 16 ++++++++--------
 kernel/audit.c        |  2 +-
 kernel/audit.h        |  2 +-
 kernel/audit_tree.c   |  2 +-
 kernel/auditfilter.c  |  8 ++++----
 kernel/auditsc.c      |  2 +-
 lib/compat_audit.c    | 12 ++++++------
 7 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 9abc128a0e0555..65182c7d737665 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -120,17 +120,17 @@ enum audit_nfcfgop {
 
 extern int is_audit_feature_set(int which);
 
-extern int __init audit_register_class(int class, unsigned *list);
-extern int audit_classify_syscall(int abi, unsigned syscall);
+extern int __init audit_register_class(int class, unsigned int *list);
+extern int audit_classify_syscall(int abi, unsigned int syscall);
 extern int audit_classify_arch(int arch);
 /* only for compat system calls */
-extern unsigned compat_write_class[];
-extern unsigned compat_read_class[];
-extern unsigned compat_dir_class[];
-extern unsigned compat_chattr_class[];
-extern unsigned compat_signal_class[];
+extern unsigned int compat_write_class[];
+extern unsigned int compat_read_class[];
+extern unsigned int compat_dir_class[];
+extern unsigned int compat_chattr_class[];
+extern unsigned int compat_signal_class[];
 
-extern int audit_classify_compat_syscall(int abi, unsigned syscall);
+extern int audit_classify_compat_syscall(int abi, unsigned int syscall);
 
 /* audit_names->type values */
 #define	AUDIT_TYPE_UNKNOWN	0	/* we don't know yet */
diff --git a/kernel/audit.c b/kernel/audit.c
index 3e1c18a4110138..21c6dec716deb1 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1989,7 +1989,7 @@ static void audit_log_vformat(struct audit_buffer *ab, const char *fmt,
 		 * here and AUDIT_BUFSIZ is at least 1024, then we can
 		 * log everything that printk could have logged. */
 		avail = audit_expand(ab,
-			max_t(unsigned, AUDIT_BUFSIZ, 1+len-avail));
+			max_t(unsigned int, AUDIT_BUFSIZ, 1+len-avail));
 		if (!avail)
 			goto out_va_end;
 		len = vsnprintf(skb_tail_pointer(skb), avail, fmt, args2);
diff --git a/kernel/audit.h b/kernel/audit.h
index a8489492e80b93..554bbc5bf2a68e 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -220,7 +220,7 @@ static inline int audit_hash_ino(u64 ino)
 /* Indicates that audit should log the full pathname. */
 #define AUDIT_NAME_FULL -1
 
-extern int audit_match_class(int class, unsigned syscall);
+extern int audit_match_class(int class, unsigned int syscall);
 extern int audit_comparator(const u32 left, const u32 op, const u32 right);
 extern int audit_uid_comparator(kuid_t left, u32 op, kuid_t right);
 extern int audit_gid_comparator(kgid_t left, u32 op, kgid_t right);
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index 18ab4575ae0094..2c21b4b1d763ac 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -33,7 +33,7 @@ struct audit_chunk {
 	struct node {
 		struct list_head list;
 		struct audit_tree *owner;
-		unsigned index;		/* index; upper bit indicates 'will prune' */
+		unsigned int index;	/* index; upper bit indicates 'will prune' */
 	} owners[];
 };
 
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 9d0e63b64ef88d..d1d48085657b55 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -162,13 +162,13 @@ static inline int audit_to_inode(struct audit_krule *krule,
 
 static __u32 *classes[AUDIT_SYSCALL_CLASSES];
 
-int __init audit_register_class(int class, unsigned *list)
+int __init audit_register_class(int class, unsigned int *list)
 {
 	__u32 *p = kcalloc(AUDIT_BITMASK_SIZE, sizeof(__u32), GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 	while (*list != ~0U) {
-		unsigned n = *list++;
+		unsigned int n = *list++;
 		if (n >= AUDIT_BITMASK_SIZE * 32 - AUDIT_SYSCALL_CLASSES) {
 			kfree(p);
 			return -EINVAL;
@@ -183,7 +183,7 @@ int __init audit_register_class(int class, unsigned *list)
 	return 0;
 }
 
-int audit_match_class(int class, unsigned syscall)
+int audit_match_class(int class, unsigned int syscall)
 {
 	if (unlikely(syscall >= AUDIT_BITMASK_SIZE * 32))
 		return 0;
@@ -234,7 +234,7 @@ static int audit_match_signal(struct audit_entry *entry)
 /* Common user-space to kernel rule translation. */
 static inline struct audit_entry *audit_to_entry_common(struct audit_rule_data *rule)
 {
-	unsigned listnr;
+	unsigned int listnr;
 	struct audit_entry *entry;
 	int i, err;
 
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 0063aa3f1d39f4..d351e9b71ced22 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -159,7 +159,7 @@ static const struct audit_nfcfgop_tab audit_nfcfgs[] = {
 
 static int audit_match_perm(struct audit_context *ctx, int mask)
 {
-	unsigned n;
+	unsigned int n;
 
 	if (unlikely(!ctx))
 		return 0;
diff --git a/lib/compat_audit.c b/lib/compat_audit.c
index 77eabad69b4a8f..fb4e86dc664c99 100644
--- a/lib/compat_audit.c
+++ b/lib/compat_audit.c
@@ -3,32 +3,32 @@
 #include <linux/types.h>
 #include <asm/unistd32.h>
 
-unsigned compat_dir_class[] = {
+unsigned int compat_dir_class[] = {
 #include <asm-generic/audit_dir_write.h>
 ~0U
 };
 
-unsigned compat_read_class[] = {
+unsigned int compat_read_class[] = {
 #include <asm-generic/audit_read.h>
 ~0U
 };
 
-unsigned compat_write_class[] = {
+unsigned int compat_write_class[] = {
 #include <asm-generic/audit_write.h>
 ~0U
 };
 
-unsigned compat_chattr_class[] = {
+unsigned int compat_chattr_class[] = {
 #include <asm-generic/audit_change_attr.h>
 ~0U
 };
 
-unsigned compat_signal_class[] = {
+unsigned int compat_signal_class[] = {
 #include <asm-generic/audit_signal.h>
 ~0U
 };
 
-int audit_classify_compat_syscall(int abi, unsigned syscall)
+int audit_classify_compat_syscall(int abi, unsigned int syscall)
 {
 	switch (syscall) {
 #ifdef __NR_open
-- 
2.53.0

