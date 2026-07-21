Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF5946EF73
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 19:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662578; cv=none; b=tolYI0wYII71Ri0BZwZ6C97YY64OEDTRHuoE7IIA20Hl/UyqimYAcqN1mQnNVph4V+OBr0zxfHOvdzWk8K6/WbWyoDaROidX81sqNgwjhVg7dsga7V6s5hNB3SW3TJ4v6Bryeb4u0XNcbJWZhabiHY82GRcgdQq6gOFKMkBN99c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662578; c=relaxed/simple;
	bh=7U5fmmpoxC3KEfamSvXNjnOHekjF4r5GuBfd7sRE+AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ILlBN27I+piI0kjXfJm+LBasYxuczmzMv5aXaBubH0RxIGdAhjwA6yHzV68RWLaFqUooLrbx+333jwp7S8bAU+CHbvnwwdGrXyC7B5jb272PYpW4eFEKFxz8rXUrgvs/+HcjCkGciqtBE0EtpR5aFJUB2D/a0AodQYgQ7IjMG94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohFP/vYb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohFP/vYb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049771F00A3E;
	Tue, 21 Jul 2026 19:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784662576;
	bh=bt3YFrLvoA9mLf9/tGqsa1jIgQMfUjundI1+Xe2+ozw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ohFP/vYbNblxwgRmhNeCggsNIUbVJby8K4nTbPSU1x/swKayCj8vwX6SWI8fFHopl
	 0YOf5QB9E76ppRiB/KlOwbic0K+6GvMF9/qB8kCdD4kXWefRMDJaFoY1j38Fug/nQl
	 LPBIFhfbB5VEonkFykvwTkdQ27e+oVg2TcZ4FOjx+yUMZ2qj0KT37KWRhCdDghBZ9f
	 DGx3P/3mirNbBHdcEljh7klKiJTiTo3eUJtL+t37zOnV7yLtfR2t+DFApigPGOF0fj
	 /hL+yNS9P4iMgpy/ZlJ0CeuFzR3cdw7bRjeb86VzvxSTDkRyGtRkfCpxWiZFuL6e9Q
	 L7bHMOtt3MGow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ricardo Robaina <rrobaina@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] audit: use 'unsigned int' instead of 'unsigned'
Date: Tue, 21 Jul 2026 15:36:12 -0400
Message-ID: <20260721193613.410665-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721193613.410665-1-sashal@kernel.org>
References: <2026071649-unify-resurrect-9786@gregkh>
 <20260721193613.410665-1-sashal@kernel.org>
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
 include/linux/audit.h      |  4 ++--
 include/linux/audit_arch.h | 12 ++++++------
 kernel/audit.c             |  2 +-
 kernel/audit.h             |  2 +-
 kernel/audit_tree.c        |  2 +-
 kernel/audit_watch.c       |  2 +-
 kernel/auditfilter.c       |  8 ++++----
 kernel/auditsc.c           |  2 +-
 lib/compat_audit.c         | 12 ++++++------
 9 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 4ab9310ba2881e..09d06684174bae 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -125,8 +125,8 @@ enum audit_nfcfgop {
 	AUDIT_NFT_OP_INVALID,
 };
 
-extern int __init audit_register_class(int class, unsigned *list);
-extern int audit_classify_syscall(int abi, unsigned syscall);
+extern int __init audit_register_class(int class, unsigned int *list);
+extern int audit_classify_syscall(int abi, unsigned int syscall);
 extern int audit_classify_arch(int arch);
 
 /* audit_names->type values */
diff --git a/include/linux/audit_arch.h b/include/linux/audit_arch.h
index 2b8153791e6a5d..a35069a6c15de2 100644
--- a/include/linux/audit_arch.h
+++ b/include/linux/audit_arch.h
@@ -21,13 +21,13 @@ enum auditsc_class_t {
 	AUDITSC_NVALS /* count */
 };
 
-extern int audit_classify_compat_syscall(int abi, unsigned syscall);
+extern int audit_classify_compat_syscall(int abi, unsigned int syscall);
 
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
 
 #endif
diff --git a/kernel/audit.c b/kernel/audit.c
index db7868945a877b..e175fce41ef931 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2030,7 +2030,7 @@ void audit_log_vformat(struct audit_buffer *ab, const char *fmt, va_list args)
 		 * here and AUDIT_BUFSIZ is at least 1024, then we can
 		 * log everything that printk could have logged. */
 		avail = audit_expand(ab,
-			max_t(unsigned, AUDIT_BUFSIZ, 1+len-avail));
+			max_t(unsigned int, AUDIT_BUFSIZ, 1+len-avail));
 		if (!avail)
 			goto out_va_end;
 		len = vsnprintf(skb_tail_pointer(skb), avail, fmt, args2);
diff --git a/kernel/audit.h b/kernel/audit.h
index bf25675fc718f7..7c56035627721e 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -233,7 +233,7 @@ static inline int audit_hash_ino(u64 ino)
 /* Indicates that audit should log the full pathname. */
 #define AUDIT_NAME_FULL -1
 
-extern int audit_match_class(int class, unsigned syscall);
+extern int audit_match_class(int class, unsigned int syscall);
 extern int audit_comparator(const u32 left, const u32 op, const u32 right);
 extern int audit_uid_comparator(kuid_t left, u32 op, kuid_t right);
 extern int audit_gid_comparator(kgid_t left, u32 op, kgid_t right);
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index fda6beb041e05a..f2c13a62bfb637 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -33,7 +33,7 @@ struct audit_chunk {
 	struct audit_node {
 		struct list_head list;
 		struct audit_tree *owner;
-		unsigned index;		/* index; upper bit indicates 'will prune' */
+		unsigned int index;	/* index; upper bit indicates 'will prune' */
 	} owners[] __counted_by(count);
 };
 
diff --git a/kernel/audit_watch.c b/kernel/audit_watch.c
index e64172dc69bd59..f7b101e71d002a 100644
--- a/kernel/audit_watch.c
+++ b/kernel/audit_watch.c
@@ -244,7 +244,7 @@ static void audit_watch_log_rule_change(struct audit_krule *r, struct audit_watc
 /* Update inode info in audit rules based on filesystem event. */
 static void audit_update_watch(struct audit_parent *parent,
 			       const struct qstr *dname, dev_t dev,
-			       u64 ino, unsigned invalidating)
+			       u64 ino, unsigned int invalidating)
 {
 	struct audit_watch *owatch, *nwatch, *nextw;
 	struct audit_krule *r, *nextr;
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index c401082d9b2506..2eae8483fb19cb 100644
--- a/kernel/auditfilter.c
+++ b/kernel/auditfilter.c
@@ -165,13 +165,13 @@ static inline int audit_to_inode(struct audit_krule *krule,
 
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
@@ -186,7 +186,7 @@ int __init audit_register_class(int class, unsigned *list)
 	return 0;
 }
 
-int audit_match_class(int class, unsigned syscall)
+int audit_match_class(int class, unsigned int syscall)
 {
 	if (unlikely(syscall >= AUDIT_BITMASK_SIZE * 32))
 		return 0;
@@ -237,7 +237,7 @@ static int audit_match_signal(struct audit_entry *entry)
 /* Common user-space to kernel rule translation. */
 static inline struct audit_entry *audit_to_entry_common(struct audit_rule_data *rule)
 {
-	unsigned listnr;
+	unsigned int listnr;
 	struct audit_entry *entry;
 	int i, err;
 
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 40917dc4137b5a..c547add1302844 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -150,7 +150,7 @@ static const struct audit_nfcfgop_tab audit_nfcfgs[] = {
 
 static int audit_match_perm(struct audit_context *ctx, int mask)
 {
-	unsigned n;
+	unsigned int n;
 
 	if (unlikely(!ctx))
 		return 0;
diff --git a/lib/compat_audit.c b/lib/compat_audit.c
index 3d6b8996f027df..fee1dfccd116b0 100644
--- a/lib/compat_audit.c
+++ b/lib/compat_audit.c
@@ -4,32 +4,32 @@
 #include <linux/audit_arch.h>
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

