Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA763DCD92
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780508299; cv=none; b=deKnoEVyw8cbukkwZOw82g1ahOzAcYlgUYS/bI+HkIItzaHXS2stAonb396OqFdskkKerj7QJgeqJEigJGGlEvxD5vYFi9N1y/Nt3EiMROfT+jPZuG7ttDRDoRuRha7E+f/mnagm7jAqyiGgg5efI8NAVBHZkXGc7Jf4YX2l4Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780508299; c=relaxed/simple;
	bh=/Lgj9HtEnqPpmq+rogy1Nun9KLEpuIEnHyzW//Qr03k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sm9pmh6oNJj0CWSzQI3OUyAJK/wwYy8YxEDpLbjCe5KX4wDuwJx0NhsRn3mNAjgkeEFvE3yNdY7jY+HewMnyd+3ZpryKleYTMkntxVKMp8Ogee3MnYUYbWCnrBcHcR54gZ4fsuYud+6PkeFNxbb35HS3Xxkvu8U3ZatIJXaQuVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fIrjrmRE; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fIrjrmRE"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b23c828aso4925e9.1
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 10:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780508293; x=1781113093; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mVCPWqSNKcww4dR+mNI3XTjBLMex/Kkq8cMFX9Pn86M=;
        b=fIrjrmRERXZZGx2aKTwfYHBDhksTNYr/gstglZtNq+vjUhQPcVmDwv5nb+7/ZGP1Sq
         aXULYHX9SM3ADPsNR77CeEYVKwM8p7M2WI987nK4WVpN3/ceJ8HduJ4JQg0j0l7nrHC2
         suQEmLxBGpLJ8fGl4NdC7BXJ69rmz6axDBS1EQO//Y4VQVK5kKsCHchtbOcosPXLpYaN
         2MpINMxa+oZNZtMsll5ocX6t1qA9E6UoJVVcYt7MCrc1y7fnWQoLtjAbE7Tr6cVxX+Zy
         19Itb6WkT2576q5NCFkFe0IX2ZwwtEUPwOU9pkenoQDjf5DI+YOfLtWrhE52uFCgYhwH
         VEig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780508293; x=1781113093;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mVCPWqSNKcww4dR+mNI3XTjBLMex/Kkq8cMFX9Pn86M=;
        b=a6MG/TKafA4wKG3NcCNPvEckb3Lbph6vpJ4J/as7Ab0YZjd671RpYlL2sEPX8N6nzX
         im9x+c+38mjRnAjFiSM71OWN22N4s9CdL/Oy9B/BYgtblU7NF+oZfE9C44rX0pEWLDIr
         eGl6GsGLlaERaTauf8czuOOUZTazi2XhJKltI9sXdF9bNRP6ghzeennLMMxn5vaLlf9J
         x+aj9TBOJq9Cdo/aiI3YdbrcmnIIOxZmaJlcWxIHipys9cK7HbccgsHyIE5zEE4dQ9Cq
         0bYd9Eqt2/FYspv7NaiiR0mPTRI88NBq1yRnpKfhRUV6MUWXaaOiuESg8xdsbvbRV301
         /nyg==
X-Forwarded-Encrypted: i=1; AFNElJ+0IouvFVKQDcXlO5xT7VQ1gqqKV0UQbfwqKGQBCZwN9wKhTXFqn/5herRkQMPuJh5/J9ablek=@vger.kernel.org
X-Gm-Message-State: AOJu0YynnMvpBEbHXBse2GEM/3gar3bFGoucQrU9XSARC1coJS+YAhyo
	ztxoZHK+oCkx8zRxWny2p+87OWKB3jaHReIdRz+K08hZlSPnSXLIg0eM7nDrYt2LlA==
X-Gm-Gg: Acq92OGf4K6rfHvOc/V00ijrqg9Psdvq2ics6N9GVYXlOSh9b5G23RPEsiG9w73M08a
	SxWkkkOsSqAArr5Vm3icHNNzLcYgRiuQzdYjMAmVeoj74EVZCAfkP6r3EipQJZexcB4tHx/gO6S
	W+AGM9cNvv0yP/JOMhVsx+6ikR1cpULZrN9CQoIsHuZdi1GDEUyBy54Y148y6fcKbXdZtbJOKJD
	BXuJ0vGwJW9rI89llFpwoPNIY23eRMANHfvVqO7JE9+S7fMUIJWMyUf6yd1ukU3wNquv3KhZI8C
	y8nGb/b6TdeUV6nIAOud7DVmB6YpuDieuZVQ52kdPg2ExqbA+KUyFG3MRxZVi36HcJ0hHubTaSr
	z/HVoZqKTdl5eMBIgHJNVta5ksPktVx7tufWpGALhTwmkbAY9rLU7TFZndiqj5o7bUOTyy5uWga
	L4KNkGnsGJju9Rf/CqcK2GG6ApunwjgqOubKIxvd4QRNUDqKy5G7duW/HiYNnEBv5qVyAmes5C
X-Received: by 2002:a05:600c:1912:b0:490:ab15:b9e8 with SMTP id 5b1f17b1804b1-490bca7445emr90855e9.2.1780508292385;
        Wed, 03 Jun 2026 10:38:12 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:ac5a:f71c:9e28:abca])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc391aaasm9894005e9.1.2026.06.03.10.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 10:38:11 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Wed, 03 Jun 2026 19:38:06 +0200
Subject: [PATCH] fhandle: fix UAF due to unlocked ->mnt_ns read in
 may_decode_fh()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-vfs-fhandle-uaf-fix-v1-1-ff64ee367e4d@google.com>
X-B4-Tracking: v=1; b=H4sIAH5mIGoC/yWMywqDQAxFf0WyNjBGfNRfkS7UybSRojJRKYj/b
 myX517OOUA5Cis0yQGRd1GZJ4MsTWB4d9OLUbwxkKPSlS7HPSgGe/yHcesCBvliTlQ9fNFTVdR
 g5hLZ5l+1ff5Zt37kYb1TcJ4X/gcrkXcAAAA=
X-Change-ID: 20260603-vfs-fhandle-uaf-fix-32279d5b2758
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780508288; l=5636;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=/Lgj9HtEnqPpmq+rogy1Nun9KLEpuIEnHyzW//Qr03k=;
 b=QBYoxLJIwvpSnWQyglXtVqRr/pmqqfjrZYlk0p12HNcbNJYMSOj125PeA2qZCwy3jaXqTz89a
 dMYx1BW4O4FBeJgBIDlLdKs0YsZtaOaQAGK3bJEv2akyIrsqKOlChgZ
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

may_decode_fh() accesses mount::mnt_ns without holding any locks; that
means the mount can concurrently be unmounted, and the mnt_namespace can
concurrently be freed after an RCU grace period.

This race can happens as follows, assuming that the mount point was
created by open_tree(..., OPEN_TREE_CLONE):

thread 1            thread 2            RCU
                    __do_sys_open_by_handle_at
                      do_handle_open
                        handle_to_path
                          may_decode_fh
                            is_mounted
                              [mount::mnt_ns access]
                            [mount::mnt_ns access]
__do_sys_close
  fput_close_sync
    __fput
      dissolve_on_fput
        umount_tree
        class_namespace_excl_destructor
          namespace_unlock
            free_mnt_ns
              mnt_ns_tree_remove
                call_rcu(mnt_ns_release_rcu)
                                        mnt_ns_release_rcu
                                          mnt_ns_release
                                            kfree
                            [mnt_namespace::user_ns access] **UAF**

Fix it by taking rcu_read_lock() around the mount::mnt_ns access, like
in __prepend_path().
Additionally, document the semantics of mount::mnt_ns, and use WRITE_ONCE()
for writers that can race with lockless readers.

This bug is unreachable unless one of the following is set:

 - CONFIG_PREEMPTION
 - CONFIG_RCU_STRICT_GRACE_PERIOD

because it requires an RCU grace period to happen during a syscall without
an explicit preemption.

This doesn't seem to have interesting security impact; worst-case, it could
leak the result of an integer comparison to userspace (from the level
check in cap_capable()), cause an endless loop, or crash the kernel by
dereferencing an invalid address.

Fixes: 620c266f3949 ("fhandle: relax open_by_handle_at() permission checks")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
I used custom tooling to force this race condition to occur and check
that it leads to a KASAN splat - let me know if you want me to create a
kernel patch to force the race condition and a reproducer you can run.

I remember Christian asking me for feedback on the patch that introduced
the bug, and I missed the bug because I didn't realize what the semantics
of mount::mnt_ns are...
---
 fs/fhandle.c   | 16 ++++++++++++++--
 fs/mount.h     |  8 +++++++-
 fs/namespace.c |  6 +++---
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 642e3d569497..1ca7eb3a6cb5 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -285,6 +285,19 @@ static int do_handle_to_path(struct file_handle *handle, struct path *path,
 	return 0;
 }
 
+static bool capable_wrt_mount(struct mount *mount)
+{
+	struct mnt_namespace *mnt_ns;
+
+	/*
+	 * For ->mnt_ns access.
+	 * The following READ_ONCE() is semantically rcu_dereference().
+	 */
+	guard(rcu)();
+	mnt_ns = READ_ONCE(mount->mnt_ns);
+	return ns_capable(mnt_ns->user_ns, CAP_SYS_ADMIN);
+}
+
 static inline int may_decode_fh(struct handle_to_path_ctx *ctx,
 				unsigned int o_flags)
 {
@@ -320,8 +333,7 @@ static inline int may_decode_fh(struct handle_to_path_ctx *ctx,
 	if (ns_capable(root->mnt->mnt_sb->s_user_ns, CAP_SYS_ADMIN))
 		ctx->flags = HANDLE_CHECK_PERMS;
 	else if (is_mounted(root->mnt) &&
-		 ns_capable(real_mount(root->mnt)->mnt_ns->user_ns,
-			    CAP_SYS_ADMIN) &&
+		 capable_wrt_mount(real_mount(root->mnt)) &&
 		 !has_locked_children(real_mount(root->mnt), root->dentry))
 		ctx->flags = HANDLE_CHECK_PERMS | HANDLE_CHECK_SUBTREE;
 	else
diff --git a/fs/mount.h b/fs/mount.h
index e0816c11a198..f0af6d789bfc 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -71,7 +71,13 @@ struct mount {
 	struct hlist_head mnt_slave_list;/* list of slave mounts */
 	struct hlist_node mnt_slave;	/* slave list entry */
 	struct mount *mnt_master;	/* slave is on master->mnt_slave_list */
-	struct mnt_namespace *mnt_ns;	/* containing namespace */
+	/*
+	 * Containing namespace.
+	 * Normally protected by namespace_sem, but there are also lockless
+	 * readers (which must use RCU to guard against the namespace being
+	 * freed).
+	 */
+	struct mnt_namespace *mnt_ns;
 	struct mountpoint *mnt_mp;	/* where is it mounted */
 	union {
 		struct hlist_node mnt_mp_list;	/* list mounts with the same mountpoint */
diff --git a/fs/namespace.c b/fs/namespace.c
index fe919abd2f01..f5905f4ec560 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1079,7 +1079,7 @@ static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
 	bool mnt_first_node = true, mnt_last_node = true;
 
 	WARN_ON(mnt_ns_attached(mnt));
-	mnt->mnt_ns = ns;
+	WRITE_ONCE(mnt->mnt_ns, ns);
 	while (*link) {
 		parent = *link;
 		if (mnt->mnt_id_unique < node_to_mount(parent)->mnt_id_unique) {
@@ -1434,7 +1434,7 @@ EXPORT_SYMBOL(mntget);
 void mnt_make_shortterm(struct vfsmount *mnt)
 {
 	if (mnt)
-		real_mount(mnt)->mnt_ns = NULL;
+		WRITE_ONCE(real_mount(mnt)->mnt_ns, NULL);
 }
 
 /**
@@ -1806,7 +1806,7 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 			ns->nr_mounts--;
 			__touch_mnt_namespace(ns);
 		}
-		p->mnt_ns = NULL;
+		WRITE_ONCE(p->mnt_ns, NULL);
 		if (how & UMOUNT_SYNC)
 			p->mnt.mnt_flags |= MNT_SYNC_UMOUNT;
 

---
base-commit: ba3e43a9e601636f5edb54e259a74f96ca3b8fd8
change-id: 20260603-vfs-fhandle-uaf-fix-32279d5b2758

Best regards,
--  
Jann Horn <jannh@google.com>

