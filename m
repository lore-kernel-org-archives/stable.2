Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EFB1E2834
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786204137; cv=none; b=EAptrnEsg8RT5qvWtjIEh/1vJs/+VljIBYbcIygOyXXD0mKLM7sVTTm3GQW/VjUS/SELtLLMga/2DhPpWwLl+Ygt7nTfoWELPRk7MOhDIiKGU099XuUa32P1eFB86GdpApZPKn85MmLz4nI46jbNPL3Zjw6vmpVqnrNZWuL8jBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786204137; c=relaxed/simple;
	bh=GdzszkS068lRw+lFmyJQif28+HChgTZWcxnrk8Wa4OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQ3Ib666YcriAk/xfOgynwusjflqrvLR8Bzu5UumUDhGZVzeARRo5YZS56kSDPtBPTtQoVk8XHDR6hhKjru18BK152WC+yvVj/93nWzzV1T/S1QS1oIH2FALhcSQE+UWjbIoWH8Sn9ybH8ZbfWHg37xMN6aFFCebmznKRKJJnJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GrIhSTd7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GrIhSTd7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6C801F00A3D;
	Sat,  8 Aug 2026 15:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786204136;
	bh=mrWUJrVlAyhsM/B25kcAXiWtg5uvDae3VWfeDpdoZ4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GrIhSTd7gUfivBiE+AE+hw7rt2yhnemfyQFbzbLSFQp/tbj8Kl+ZGXOI5oXKdAmYB
	 KiA8asKQ7VEpg58UeSqNR60sj0CYlZit2nDYFoBlTmCD4+cJY9ZHs6DvW9cfNnBRo8
	 Wk/tVYBP/rzfTu6K4JOznSIAkr4jX1mNn/U9YhhPlycmSp9ZCuiYdiHJ1ml9Ey18pJ
	 UseOPKWfEp1GQhOTn5eD4/Ry0Mvc3LuykwbJbPafNBWy7IHe0oa57ANUEToWsf9F2g
	 5rfr0ATFNE10cS7CCebRp5EaqvEVjikZb8zIEObOsvXBzLkLeLRssGz4IzcnLGDrXG
	 klhetYxXt9xWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/6] super: use a common iterator (Part 1)
Date: Sat,  8 Aug 2026 11:48:49 -0400
Message-ID: <20260808154852.370323-3-sashal@kernel.org>
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

[ Upstream commit 2992476528aeecbaee17ba0a6396a817481205a3 ]

Use a common iterator for all callbacks.

Link: https://lore.kernel.org/r/20250329-work-freeze-v2-4-a47af37ecc3d@kernel.org
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 749d7aa0377a ("super: fix emergency thaw deadlock on frozen block devices")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/super.c         | 67 +++++++++-------------------------------------
 include/linux/fs.h |  6 ++++-
 2 files changed, 18 insertions(+), 55 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index f1714752e439b..d01088e55d30c 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -887,37 +887,7 @@ void drop_super_exclusive(struct super_block *sb)
 }
 EXPORT_SYMBOL(drop_super_exclusive);
 
-static void __iterate_supers(void (*f)(struct super_block *))
-{
-	struct super_block *sb, *p = NULL;
-
-	spin_lock(&sb_lock);
-	list_for_each_entry(sb, &super_blocks, s_list) {
-		if (super_flags(sb, SB_DYING))
-			continue;
-		sb->s_count++;
-		spin_unlock(&sb_lock);
-
-		f(sb);
-
-		spin_lock(&sb_lock);
-		if (p)
-			__put_super(p);
-		p = sb;
-	}
-	if (p)
-		__put_super(p);
-	spin_unlock(&sb_lock);
-}
-/**
- *	iterate_supers - call function for all active superblocks
- *	@f: function to call
- *	@arg: argument to pass to it
- *
- *	Scans the superblock list and calls given function, passing it
- *	locked superblock and given argument.
- */
-void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
+void __iterate_supers(void (*f)(struct super_block *, void *), void *arg, bool excl)
 {
 	struct super_block *sb, *p = NULL;
 
@@ -927,14 +897,13 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
 
 		if (super_flags(sb, SB_DYING))
 			continue;
-
 		sb->s_count++;
 		spin_unlock(&sb_lock);
 
-		locked = super_lock_shared(sb);
+		locked = super_lock(sb, excl);
 		if (locked) {
 			f(sb, arg);
-			super_unlock_shared(sb);
+			super_unlock(sb, excl);
 		}
 
 		spin_lock(&sb_lock);
@@ -1110,11 +1079,9 @@ int reconfigure_super(struct fs_context *fc)
 	return retval;
 }
 
-static void do_emergency_remount_callback(struct super_block *sb)
+static void do_emergency_remount_callback(struct super_block *sb, void *unused)
 {
-	bool locked = super_lock_excl(sb);
-
-	if (locked && sb->s_root && sb->s_bdev && !sb_rdonly(sb)) {
+	if (sb->s_bdev && !sb_rdonly(sb)) {
 		struct fs_context *fc;
 
 		fc = fs_context_for_reconfigure(sb->s_root,
@@ -1125,13 +1092,11 @@ static void do_emergency_remount_callback(struct super_block *sb)
 			put_fs_context(fc);
 		}
 	}
-	if (locked)
-		super_unlock_excl(sb);
 }
 
 static void do_emergency_remount(struct work_struct *work)
 {
-	__iterate_supers(do_emergency_remount_callback);
+	__iterate_supers(do_emergency_remount_callback, NULL, true);
 	kfree(work);
 	printk("Emergency Remount complete\n");
 }
@@ -1147,24 +1112,18 @@ void emergency_remount(void)
 	}
 }
 
-static void do_thaw_all_callback(struct super_block *sb)
+static void do_thaw_all_callback(struct super_block *sb, void *unused)
 {
-	bool locked = super_lock_excl(sb);
-
-	if (locked && sb->s_root) {
-		if (IS_ENABLED(CONFIG_BLOCK))
-			while (sb->s_bdev && !bdev_thaw(sb->s_bdev))
-				pr_warn("Emergency Thaw on %pg\n", sb->s_bdev);
-		thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE);
-		return;
-	}
-	if (locked)
-		super_unlock_excl(sb);
+	if (IS_ENABLED(CONFIG_BLOCK))
+		while (sb->s_bdev && !bdev_thaw(sb->s_bdev))
+			pr_warn("Emergency Thaw on %pg\n", sb->s_bdev);
+	thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE);
+	return;
 }
 
 static void do_thaw_all(struct work_struct *work)
 {
-	__iterate_supers(do_thaw_all_callback);
+	__iterate_supers(do_thaw_all_callback, NULL, true);
 	kfree(work);
 	printk(KERN_WARNING "Emergency Thaw complete\n");
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 466a76771b0a1..9cc0ad05bb4de 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3398,7 +3398,11 @@ extern void put_filesystem(struct file_system_type *fs);
 extern struct file_system_type *get_fs_type(const char *name);
 extern void drop_super(struct super_block *sb);
 extern void drop_super_exclusive(struct super_block *sb);
-extern void iterate_supers(void (*)(struct super_block *, void *), void *);
+void __iterate_supers(void (*f)(struct super_block *, void *), void *arg, bool excl);
+static inline void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
+{
+	__iterate_supers(f, arg, false);
+}
 extern void iterate_supers_type(struct file_system_type *,
 			        void (*)(struct super_block *, void *), void *);
 
-- 
2.53.0

