Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000DB35FF6E
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784681481; cv=none; b=NKFqgLxFFhjeL9ZChN0WgSkAbDmoV+eqkCtweAs/6p/C8m9A+Hm9lxlab6Cjbx/Kjg6ZdEWh/rAkdrkuL1r4tbRoYOrgPmHqidldgEMuyCQLD4Kg4l7cNflR1KFPm7nPOnx6ERdZrg1kbQxWx7aT19qM35rmTusYz1PNpnr34b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784681481; c=relaxed/simple;
	bh=Xv0V5aRKB9ljBbqp8X+1EmeY9ynLQ/mcRzO4f29gmHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uNkY/NkQOXPzS9vr53aRI1pJ9yOMa41tMKLi66wOO7rAwqLmfq+zcr8UNTMTiXuLmtkkHfFHQ1vyPIIskrrxE3KbOFFMoyt6THJLFfHwijEOQUMhHC9S0t7kGO8uEDjbhi0+5IsM++kwxjTKLbcOIJqdncap1N9y05f+drdMQ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjKpA7XG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjKpA7XG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0901F00A3A;
	Wed, 22 Jul 2026 00:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784681479;
	bh=ieycxAgtxcCJPlFgYSIR+2A0GJ54pggrndVMSKksXz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OjKpA7XGhiYEek4tpyJX1Af6mK8OrWQWux/yz6d0hta+kVnWyNQk7Q0zg1FDfuuBa
	 xcucmaXj7HZWTcXYsqMVR62UbuakDFmRx1yC2//80wqQSa35Gyy55WC1u6jvewAKw2
	 3ohLCIcTxKKdoAmmWHNIck8DssXHchSK6iJ5WgQVUtLyZEPPu5whgfsP1KJbrcT0ur
	 SE/2nu0T+Va90oHL394OKkNGE/4lq+MTBOmohJykiBgCaRcA7v8Vhn7gkmQRnbuQ0B
	 MpE48C5ePUbbu4A8An6hD4QGq3YmiB2GJvvhKMv07pZ9dDCuowfOBk3z5Ml3zHA+3K
	 j5KGQZXTcAsng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ricardo Robaina <rrobaina@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] audit: use 'unsigned int' instead of 'unsigned'
Date: Tue, 21 Jul 2026 20:51:14 -0400
Message-ID: <20260722005116.605624-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722005116.605624-1-sashal@kernel.org>
References: <2026071651-dismount-trapped-aafe@gregkh>
 <20260722005116.605624-1-sashal@kernel.org>
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
 kernel/auditfilter.c       |  8 ++++----
 kernel/auditsc.c           |  2 +-
 lib/compat_audit.c         | 12 ++++++------
 8 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 4b060b0f3d70cd..c42046c4fd700b 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -122,8 +122,8 @@ enum audit_nfcfgop {
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
index 433672f81e30dd..0de8bca7bdd494 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1986,7 +1986,7 @@ static void audit_log_vformat(struct audit_buffer *ab, const char *fmt,
 		 * here and AUDIT_BUFSIZ is at least 1024, then we can
 		 * log everything that printk could have logged. */
 		avail = audit_expand(ab,
-			max_t(unsigned, AUDIT_BUFSIZ, 1+len-avail));
+			max_t(unsigned int, AUDIT_BUFSIZ, 1+len-avail));
 		if (!avail)
 			goto out_va_end;
 		len = vsnprintf(skb_tail_pointer(skb), avail, fmt, args2);
diff --git a/kernel/audit.h b/kernel/audit.h
index e7610428ee448b..3504f900a49e42 100644
--- a/kernel/audit.h
+++ b/kernel/audit.h
@@ -227,7 +227,7 @@ static inline int audit_hash_ino(u64 ino)
 /* Indicates that audit should log the full pathname. */
 #define AUDIT_NAME_FULL -1
 
-extern int audit_match_class(int class, unsigned syscall);
+extern int audit_match_class(int class, unsigned int syscall);
 extern int audit_comparator(const u32 left, const u32 op, const u32 right);
 extern int audit_uid_comparator(kuid_t left, u32 op, kuid_t right);
 extern int audit_gid_comparator(kgid_t left, u32 op, kgid_t right);
diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
index e867c17d3f84df..17125ac3a5737b 100644
--- a/kernel/audit_tree.c
+++ b/kernel/audit_tree.c
@@ -33,7 +33,7 @@ struct audit_chunk {
 	struct audit_node {
 		struct list_head list;
 		struct audit_tree *owner;
-		unsigned index;		/* index; upper bit indicates 'will prune' */
+		unsigned int index;	/* index; upper bit indicates 'will prune' */
 	} owners[];
 };
 
diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
index 685bccb20b6f05..a027aaee6f53e0 100644
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
index 575551b50b3d14..1727af77245de7 100644
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

