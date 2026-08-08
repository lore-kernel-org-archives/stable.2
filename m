Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E5ADF6C
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786204138; cv=none; b=J/ywalpKOVtVIe3303g+rWBsmVrcgbBsrXlhygfjzeInX9tIDDPKChO39TF4bgFieFcKwjPS287zJRrrMxCpPpqX+TZGPvmmWEJfHWuoTUaOhs6YKJ0aMXxvmR2tWWhlkDP8duqsq5tJnuo8r/gLYZ43ZAS6D4cPL1JKk+NEXjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786204138; c=relaxed/simple;
	bh=86SsvhYCcUszFj0AlwpJPaQgbyceeRPiaBmI3BObeJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQUkCoXo3zBXlWSKpqMNxvwPOzVQM+R9bCkF7D1a6t0nUZZDoC2z2V9UIMWM6KVN0iN1DQ8sQkt2w61xOnvSF5bprpH54Ga9ZUMFOyCXIOJhK5fMN4a398deEWTdJaAbAXdl+znDT6lhHWPvLHUvFwJzGaXOXWSGe8a9i2vLDWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBTgaLhi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBTgaLhi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D171F000E9;
	Sat,  8 Aug 2026 15:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786204137;
	bh=i4+qXHTrgueeHdj8iV+yK1f4/Loq8m9EYTIgeCU6HC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lBTgaLhieQSirUefzTS6zJi4hcr/+5OsnfSQ+O22ifT3lvDCIT8XBqcZB6H/ZlFsB
	 s+Vjg5BdmoTelrDTEi9H4K/fLrWzZ0DyW8tgMH8KeG2KjrCrzJW0qaJjRZvyEJHhuK
	 esFGoGvPVh5i6ylBjgbEqAHWzxT69tbRZ+C9NHR/Ri71RHf/eUIn2FWLvlug9YzI6G
	 1cqcjYH20HTiTwX4E9OtbzC7cGKqH/2Eg0SmSNEVgYS6XnWUC1C/wRoy+xETp2iHtN
	 brhjPlETVMRtBT7+3lU0C7lTNp5MKc4Us/fC6zo7ViwWEGxL+vfuhlxmrre70WIg7a
	 4g0wVlWSgpBwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/6] super: use common iterator (Part 2)
Date: Sat,  8 Aug 2026 11:48:50 -0400
Message-ID: <20260808154852.370323-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808154852.370323-1-sashal@kernel.org>
References: <2026072927-mom-flyover-909f@gregkh>
 <20260808154852.370323-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit b47e42d10e8c20525febccbd6e0dc8528861aea4 ]

Use a common iterator for all callbacks. We could go for something even
more elaborate (advance step-by-step similar to iov_iter) but I really
don't think this is warranted.

Link: https://lore.kernel.org/r/20250329-work-freeze-v2-5-a47af37ecc3d@kernel.org
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 749d7aa0377a ("super: fix emergency thaw deadlock on frozen block devices")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/super.c         | 48 +++++++++++++++++++++++++++++++++++++---------
 include/linux/fs.h |  6 +-----
 2 files changed, 40 insertions(+), 14 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index d01088e55d30c..adfaee9e20297 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -887,21 +887,46 @@ void drop_super_exclusive(struct super_block *sb)
 }
 EXPORT_SYMBOL(drop_super_exclusive);
 
-void __iterate_supers(void (*f)(struct super_block *, void *), void *arg, bool excl)
+enum super_iter_flags_t {
+	SUPER_ITER_EXCL		= (1U << 0),
+	SUPER_ITER_UNLOCKED	= (1U << 1),
+	SUPER_ITER_REVERSE	= (1U << 2),
+};
+
+static inline struct super_block *first_super(enum super_iter_flags_t flags)
+{
+	if (flags & SUPER_ITER_REVERSE)
+		return list_last_entry(&super_blocks, struct super_block, s_list);
+	return list_first_entry(&super_blocks, struct super_block, s_list);
+}
+
+static inline struct super_block *next_super(struct super_block *sb,
+					     enum super_iter_flags_t flags)
+{
+	if (flags & SUPER_ITER_REVERSE)
+		return list_prev_entry(sb, s_list);
+	return list_next_entry(sb, s_list);
+}
+
+static void __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
+			     enum super_iter_flags_t flags)
 {
 	struct super_block *sb, *p = NULL;
+	bool excl = flags & SUPER_ITER_EXCL;
 
-	spin_lock(&sb_lock);
-	list_for_each_entry(sb, &super_blocks, s_list) {
-		bool locked;
+	guard(spinlock)(&sb_lock);
 
+	for (sb = first_super(flags);
+	     !list_entry_is_head(sb, &super_blocks, s_list);
+	     sb = next_super(sb, flags)) {
 		if (super_flags(sb, SB_DYING))
 			continue;
 		sb->s_count++;
 		spin_unlock(&sb_lock);
 
-		locked = super_lock(sb, excl);
-		if (locked) {
+		if (flags & SUPER_ITER_UNLOCKED) {
+			f(sb, arg);
+		} else if (super_lock(sb, excl)) {
 			f(sb, arg);
 			super_unlock(sb, excl);
 		}
@@ -913,7 +938,11 @@ void __iterate_supers(void (*f)(struct super_block *, void *), void *arg, bool e
 	}
 	if (p)
 		__put_super(p);
-	spin_unlock(&sb_lock);
+}
+
+void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
+{
+	__iterate_supers(f, arg, 0);
 }
 
 /**
@@ -1096,7 +1125,8 @@ static void do_emergency_remount_callback(struct super_block *sb, void *unused)
 
 static void do_emergency_remount(struct work_struct *work)
 {
-	__iterate_supers(do_emergency_remount_callback, NULL, true);
+	__iterate_supers(do_emergency_remount_callback, NULL,
+			 SUPER_ITER_EXCL | SUPER_ITER_REVERSE);
 	kfree(work);
 	printk("Emergency Remount complete\n");
 }
@@ -1123,7 +1153,7 @@ static void do_thaw_all_callback(struct super_block *sb, void *unused)
 
 static void do_thaw_all(struct work_struct *work)
 {
-	__iterate_supers(do_thaw_all_callback, NULL, true);
+	__iterate_supers(do_thaw_all_callback, NULL, SUPER_ITER_EXCL);
 	kfree(work);
 	printk(KERN_WARNING "Emergency Thaw complete\n");
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 9cc0ad05bb4de..0815637a47028 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3398,11 +3398,7 @@ extern void put_filesystem(struct file_system_type *fs);
 extern struct file_system_type *get_fs_type(const char *name);
 extern void drop_super(struct super_block *sb);
 extern void drop_super_exclusive(struct super_block *sb);
-void __iterate_supers(void (*f)(struct super_block *, void *), void *arg, bool excl);
-static inline void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
-{
-	__iterate_supers(f, arg, false);
-}
+extern void iterate_supers(void (*f)(struct super_block *, void *), void *arg);
 extern void iterate_supers_type(struct file_system_type *,
 			        void (*)(struct super_block *, void *), void *);
 
-- 
2.53.0

