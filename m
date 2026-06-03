Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB1448BD57
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 19:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780515127; cv=none; b=A4v/vxv9+HRDneIoE3rt9fDvCC16ijRSTiAK2EPWjXJRUpl12gNDuDUhhzAta8gONCrSBkfFLbsAXI57tmpf+kRw/IwcmF1G36PHfYfrtk8tNEUeK589AbMNMPRcaqIl445bN2MjsBYocpGr24kcKOyBCU0mRBQj0gzH6aOKPYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780515127; c=relaxed/simple;
	bh=TQxe3lxjnun8hagmZm/MNZUEw9/HolUDis/d92awEoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iezwn8kOHRWzVdpBTcj2FwtHuG5X9lsI2iCoWmC3O3uMG3wnFTkQvntQ9yekjMX2dhOzasJCQ52OqxLoEH5x84zhdCG33MxK1zNdN3aO2cojUQedVRVleyT6j6miD73sh9tuw/po0oez006cpvuvnqITebpc2Bm1zg4TDEz8JEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YLFdbCai; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YLFdbCai"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4891b4934ffso15715e9.0
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 12:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780515124; x=1781119924; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WyYYbe9n0CflRt4VnvQU2N03ZiDpY3ZgwW7PfjETq5w=;
        b=YLFdbCaiajgSxtTu2+rCX/PlPlM0MAC4q4NHlEM/vQD2jLpBMcKIF81QQpbjXNChc6
         6aaBKrVwi9r+qR+8/de2fh9tBXepP2szaJrOlpclIHkM/XLmbldwkRUKM9d6AIobxq5R
         Qpr2UWbWHPfvNiNDVeY5N/DfyqcJZxPF7D217bc64rfwHhXJ50rfNqFnEKrc0OvYlHkY
         r7uxSP3Wv314cxrQFlj9J3EuFXhHwjXW0xim/YirWHwXIy5gCxnNcO9LGUiy1L3eF8GM
         pWUJzUr8aONDpl6lcJiAlrlkpJBGY9jUSJ4LgfKofeLcVB6YrO9KPLAM0EJBpP2kcexC
         GEtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780515124; x=1781119924;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WyYYbe9n0CflRt4VnvQU2N03ZiDpY3ZgwW7PfjETq5w=;
        b=TvMDH9iEaAJMcJdCQ87wMnyzm1oK7obuDzxT7IMmyCpNK8gvexZgzhBSe1Hy3o8jAH
         +1yQQRvCOFfsmzte21+d18MNpInoRAMaQgnQGO+pCvf52BQ8WdqWkK/wwZ3xyShONFFG
         BT0Q6Mk3ZK0oZxDaubrLcjroLDKiFlVYHN+Ywil8L6/H547T/d9E3O40adxvga2+MQYF
         izbuiazABLQw0AvUzuZOmgA03IKI87cBZDpic+xqIGfpTeE91nbIed3wYA6FtRvE+E90
         oxVppiDQu7mTKgc8CE22mMoRH39+v3GqxsZcvWofmwPNccpw7QHBxDBCvj5EA7xMw2eS
         /aOQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ju55zmmCUDJCrjqVmIuGOBPe6GHt9C4UCkjBGkR5Ns8n3aZte6hlK2hHHM4umlqYvKJ8OdLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmWQD0tFRd4vpbaeoCucFsopqsimdHXD7We1NaeKca04nhe8DS
	Pykf87JT3a8mZWoUyG8kxSs9Z2QSCNNVJlKLmKswV4WDWXIC8vKrZA7XUr/2/kSJ/A==
X-Gm-Gg: Acq92OGjx+xgPjrtABW6Qxp3PVo/5tSJ0ZV8mTpttsiPg5gr6MK5IvJZ9byeEopi+iO
	/khIdDH5/KiBqncH3OucXSzXBTT5GVIyCRFjcD4QT7knOYxLXnDDkmoVedLqeCrPoSDMp6kC8cQ
	RmVcsqnDV0AiC94Ct75cSYU8V0GBG2x49RGU1lzcdGCNlYrCwElci7tWGqE9l+VY9Td9TbPMVXq
	4qPIQpB3p7NI2BArrYtu2fBsAP2CvA/6QLHY2NyUiaCp17wvLc2MZN1x3/7yfIt5/3+gvcKbF4K
	PEKSqMcNTr5jmKExFS5mOdeRtGZAr24Fn+VAL3YnCri2vFp9+Z6hJFRy364HXAtwfkQSAhi3/MV
	ORJ6my4p8odUku1HLPO6N9+LCAfuD13P7/ax6JY3r1JJbELEXxeTZrgCHJOVHj2oMXdaBMyHJJI
	fZNmBehnX/+TFoDsHPt1b7cCTW9UeoHi++W0gGlw3N7i4hAftsd/T1iK6d1CbNww==
X-Received: by 2002:a05:600d:18:b0:490:b2ae:44e1 with SMTP id 5b1f17b1804b1-490bcbea733mr114005e9.5.1780515123978;
        Wed, 03 Jun 2026 12:32:03 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:ac5a:f71c:9e28:abca])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35fd33sm10773167f8f.35.2026.06.03.12.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2026 12:32:03 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Wed, 03 Jun 2026 21:31:57 +0200
Subject: [PATCH v2] fhandle: fix UAF due to unlocked ->mnt_ns read in
 may_decode_fh()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-vfs-fhandle-uaf-fix-v2-1-d05db76a5084@google.com>
X-B4-Tracking: v=1; b=H4sIACyBIGoC/32NSw6CMBCGr0Jm7ZjSQlFW3sOwADqFGqSmhUZDu
 Lst7l1+/3MDT86QhzrbwFEw3tg5Aj9l0I/tPBAaFRk445JJJjBojzo6aiJcW43avFFwXl1V2fG
 qvEBsvhxF+Vi9Nz/2a/egfklTKTEav1j3OW5DnnL/H0KOOWotCyIhKyrUbbB2mOjc2yc0+75/A
 aB7oQrJAAAA
X-Change-ID: 20260603-vfs-fhandle-uaf-fix-32279d5b2758
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780515120; l=6036;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=TQxe3lxjnun8hagmZm/MNZUEw9/HolUDis/d92awEoY=;
 b=K+4of6TqNWTyWzKPNAp9t6KhlWoMPKZ8N6RslxyIcl5G/CVP0yN5DB2rP9fkDSdzg39pgsZDq
 Ga5TomOHFV0AbRGKlkO9Mss5adscN2S+yIo9aKIeptmxtyDNWKoGKXH
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
Changes in v2:
- improve comment on mnt_ns semantics based on discussion with viro@
- Link to v1: https://patch.msgid.link/20260603-vfs-fhandle-uaf-fix-v1-1-ff64ee367e4d@google.com
---
 fs/fhandle.c   | 16 ++++++++++++++--
 fs/mount.h     | 10 +++++++++-
 fs/namespace.c |  6 +++---
 3 files changed, 26 insertions(+), 6 deletions(-)

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
index e0816c11a198..5c120f8361bd 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -71,7 +71,15 @@ struct mount {
 	struct hlist_head mnt_slave_list;/* list of slave mounts */
 	struct hlist_node mnt_slave;	/* slave list entry */
 	struct mount *mnt_master;	/* slave is on master->mnt_slave_list */
-	struct mnt_namespace *mnt_ns;	/* containing namespace */
+	/*
+	 * Containing namespace (active or deactivating, non-refcounted).
+	 * Normally protected by namespace_sem.
+	 * Can also be accessed locklessly under RCU. RCU readers can't rely on
+	 * the namespace still being active, but implicitly hold a passive
+	 * reference (because an RCU delay happens between a namespace being
+	 * deactivated and the corresponding passive refcount drop).
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

