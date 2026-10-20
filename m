Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792501339;
	b=4XXVgdkXEPsMyfpMmD+B+zMZZO2sGT8L6XBbZNLTfut1EWjsVVTkMjrnK7girnoy2za/
	 6ETZhek4ioEaYto7W1Kt5Hv/HcsbtAf77vBZaY0P96dma7ZWGCrWSZXHmj+jxYW8JT05q
	 jp+KStXlrVnT5yqL7li6Gc1VgJmEjF08ttxGFqEIo0gV8IGSctDXMAvOf9lWICPGMK/JU
	 GhC5oGbfTko0NNjEIEtrENREbzoVsjLBU34FLD+Nelg15IZZ0h90jYJYjO2YlrHpgSNZO
	 blpLsWo1Y8EXpgM4OB9TA0+S2od3Mut6+JohaNhiBiCo03bQOp0iSOO+Tg5/bj7M0/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792501339;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gjjyIg7yw0eyGLg8RRhVnBYmkPs2Yv+fCMF7oLmX6WU=;
	b=z504dvhyWeJaOMJYW12FpW8BEMjIraHxOEFseqhKUjH/btxXQqrnVQIUGLvNnTqy5frB
	 /ZPtZ/+0QUwhGpypFSKSkCJ8y9LsUHCeiUR/ML5k6fbRIqhLKK2agCrWj1A//yW0TCE4D
	 1Vb/xRHmXpzgdQCfwUoFGgFU4QjUk1Im40caqpYYR19ufXEBEQ4m0nbU0BGqGNloMELpc
	 zM3j36i7LoFKIxJB4WNOeUmJ440/G73ygTGL2mdYDG5uddai4qB28xvpqW8R6rlRZtl/E
	 g/ryATTsgcr8ZF/0RMevz7d9yR9BnK3LI1y4lYDiMntCB3DfVnmEfNv/FsAsaOIRvGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O31hgjgO;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21899606A324
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 13:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21899606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O31hgjgO
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso2060711a12.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 06:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792501338; x=1793106138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gjjyIg7yw0eyGLg8RRhVnBYmkPs2Yv+fCMF7oLmX6WU=;
        b=O31hgjgO6nwby1lr+RY08q8V2GkVttKSA4Aek2SGq/881Bga/Y0NoU3hvAerXeeQHF
         2+iQiIDENeLj/+F0EF+eDz2OZw8Z4pxLUf7SLDfL+BI64IjtQ7AqvC/3NwN0cFXygC5I
         kWag7YnM1yrVi5HYl1tdlTyIlqrsuYw4XEl4kLSYHx4+Usjl29E/8V4dUzJo7lvT63/u
         Xx4sHCLLoqygVogP4FmTrGCtfSfp6nG56BDRx9pIlHbxxsCMR8YnwmMorFtqFEn/X6Ck
         4XOGw3dERZkx5kRryqrgemn6JHoLcybeImqVBYDPXE1h+4Wm29Q9T/7gCaXNogfruB3X
         sXMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792501338; x=1793106138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gjjyIg7yw0eyGLg8RRhVnBYmkPs2Yv+fCMF7oLmX6WU=;
        b=rCS3AJiUsYykjRoRmMu/8J0vS79GeuonDGP+OHxtb4/0dv01lcqck35bz2sanax1Pg
         WRBAeUaNAlzo0e5Bhic7VuOIxXhDpEdzkWk1vIbzhPto+tEs5PuZaWatO4EFIjFhqdPn
         PLhGrZSYA806ybjBOnQG4rt8j6lEfJwKSLmqOrzWgEk7NVgV65jmO1EKkRgyJ9jm/6VQ
         Kbg64Pvba1x84bMtEeDS8yi/5zXdKDbhAUmvQKtuwKLUagfl5CEw7V5z0A1cJsoNplNC
         PGMYgChewb4qQemE+ZJmLi8i4U+YctdD0RpIE/zLmm6AGoMlwS4plC6WOB2C25lhSjuk
         M53A==
X-Forwarded-Encrypted: i=1; AKwUvBwdmXTw+GZgCGOMYIVxQ5htQ0EDCHaD9F4bTBm/j9aSa0phh+pyKXY3eptYsl42j8YqC2ffE+o=@vger.kernel.org
X-Gm-Message-State: AFq9FYJldXEpvQYoa0t1x1utI0VrVpubA1SkqecodpVuvSddZMgIgD46
	tHBM6sqy64nQ41MJj50eqqqH0cAFD+5wbcRPrcyHCWA+V47N0msTOAEeMAHdz50INSTvng==
X-Gm-Gg: AYBFou3MlVTtzWO1Or1eM85gSfYOKsvf+VPlm1CduHsEuKz2KpxEuhGMMLrVODZZBF3
	/6FyU/BLvTsMLJJn5QRJgxDoVWcLRWAKm2PJ0E4WKFP5GUbBlsAjmin3AVeX78NzBg1rtFutZFY
	9aNJxEzZD5lfR94ClgEcDeY/8viSb1eRW3WKkh3lWEiLuzAjy2hPkRoCiSgJNBP01rq3Hlcd4QM
	Es3Z3WHtVYpn4k8Hsmfc82BmwIdLsGpOrbSktCR0QwR2XfGS1nq8DwpQu+F6PRNmweeMKAxMTCI
	N7usqOE09P4NOF0MfPGdsg+RoDZLBoQLS5o6RKCgz9P9ysKUKZ5LrXg3jkL/XhOjJy6YVvXqe+K
	kgNFgXqj9Yd6sLvpgaiPIV0F2bR7dj/3F2z3XIfZ7QYB1cHcwds6JjCVz5fLdRYSm1q+Zsjt0Nq
	kYxX4PxtcHxgvuwyndfLxwy9Y1xh9DOxYlaPvwg2rz3uTI6aLO9/Q7E3earNhRdX1KUA==
X-Received: by 2002:a05:6a21:7a8e:b0:3e1:a769:9620 with SMTP id adf61e73a8af0-3e226424957mr7969858637.71.1792501337859;
        Tue, 20 Oct 2026 06:02:17 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f58017c70sm4817600b3a.48.2026.10.20.06.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 06:02:17 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: heming.zhao@suse.com,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v3] ocfs2: protect dentry lock callbacks during inode teardown
Date: Tue, 20 Oct 2026 21:02:09 +0800
Message-Id: <pm-ocfs2-objects-candidate-0012-v8-d01e30cb3f465e294c0a@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ocfs2_drop_dentry_lock() drops the inode reference before releasing
the DENTRY lock. This lets inode eviction release the local inode
and open locks before a remote unlink proceeds past the DENTRY lock.

A DLM callback can still arrive before the DENTRY lock has been
dropped. ocfs2_get_dentry_osb() obtains the mount context through
dl_inode->i_sb, which can access an inode already released by the
downconvert thread in its post-unlock callback:

  Downconvert thread                   DLM callback thread
  ------------------                   -------------------
  ocfs2_dentry_post_unlock()
    ocfs2_dentry_lock_put()
      ocfs2_drop_dentry_lock()
        iput(dl->dl_inode)
        [inode reclaimed after RCU]
                                       ocfs2_blocking_ast()
                                         ocfs2_get_dentry_osb()
                                           dl->dl_inode->i_sb
        ocfs2_simple_drop_lockres()

Store the mount context in the DENTRY lock resource's existing
l_priv field and use the default mount-context lookup. Recover the
containing dentry lock with container_of(), as for refcount locks.
The mount context remains valid until DLM shutdown completes.

The dentry convert worker also accesses dl_inode before checking
OCFS2_LOCK_FREEING and dl_count. Its early MAYBE_ORPHANED update
therefore precedes the reference that is meant to protect the inode.
ocfs2_unblock_lock() can invoke the worker without a FREEING test.

Move both the inode lookup and the flag update after the existing
guard has acquired an extra dentry lock reference. The check and
increment are serialized with final put by dentry_attach_lock, and
with FREEING by l_lock. A zero count also stops inode access in the
window before teardown sets FREEING. Once the extra reference is
held, final put cannot release dl_inode until the worker's existing
post-unlock path drops it.

Preserve iput-before-unlock ordering, normal orphan marking and the
existing extra-reference/post-unlock pairing.

Fixes: 8ed6b23709b3 ("ocfs2: revert iput deferring code in ocfs2_drop_dentry_lock")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Suggested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

---
Changes in v3:
- Move the inode lookup and MAYBE_ORPHANED update after the existing
  FREEING/dl_count guard and successful extra-reference acquisition,
  addressing Joseph Qi's review.
- Keep the osb cache from v2 and preserve iput-before-unlock ordering.

Changes in v2:
- Preserve the existing iput-before-unlock order and cache the mount context
  in the lock resource's existing l_priv field instead.
- Recover the containing dentry lock with container_of() and remove the
  inode-dependent mount-context lookup.
- Correct the comment describing the dentry lock's inode reference.

Link to v1: https://lore.kernel.org/r/pm-ocfs2-objects-candidate-0012-v5-a0413a339b72c02fc885@gmail.com
Link to v2: https://lore.kernel.org/r/pm-ocfs2-objects-candidate-0012-v6-17b58652a3505eeecb0c@gmail.com

 fs/ocfs2/dcache.h  |  5 ++---
 fs/ocfs2/dlmglue.c | 38 ++++++++++++++++----------------------
 2 files changed, 18 insertions(+), 25 deletions(-)

diff --git a/fs/ocfs2/dcache.h b/fs/ocfs2/dcache.h
index 7f246c5692d8..046ab9a80769 100644
--- a/fs/ocfs2/dcache.h
+++ b/fs/ocfs2/dcache.h
@@ -17,9 +17,8 @@ struct ocfs2_dentry_lock {
 	u64			dl_parent_blkno;
 
 	/*
-	 * The ocfs2_dentry_lock keeps an inode reference until
-	 * dl_lockres has been destroyed. This is usually done in
-	 * ->d_iput() anyway, so there should be minimal impact.
+	 * The inode reference is dropped before dl_lockres is unlocked.
+	 * Callbacks must not use it to find the mount context during teardown.
 	 */
 	struct inode		*dl_inode;
 	struct ocfs2_lock_res	dl_lockres;
diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 88d946466083..b0b649b0d471 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -58,7 +58,6 @@ struct ocfs2_mask_waiter {
 #endif
 };
 
-static struct ocfs2_super *ocfs2_get_dentry_osb(struct ocfs2_lock_res *lockres);
 static struct ocfs2_super *ocfs2_get_inode_osb(struct ocfs2_lock_res *lockres);
 static struct ocfs2_super *ocfs2_get_file_osb(struct ocfs2_lock_res *lockres);
 static struct ocfs2_super *ocfs2_get_qinfo_osb(struct ocfs2_lock_res *lockres);
@@ -258,7 +257,6 @@ static const struct ocfs2_lock_res_ops ocfs2_orphan_scan_lops = {
 };
 
 static const struct ocfs2_lock_res_ops ocfs2_dentry_lops = {
-	.get_osb	= ocfs2_get_dentry_osb,
 	.post_unlock	= ocfs2_dentry_post_unlock,
 	.downconvert_worker = ocfs2_dentry_convert_worker,
 	.flags		= 0,
@@ -309,7 +307,7 @@ static inline struct ocfs2_dentry_lock *ocfs2_lock_res_dl(struct ocfs2_lock_res
 {
 	BUG_ON(lockres->l_type != OCFS2_LOCK_TYPE_DENTRY);
 
-	return (struct ocfs2_dentry_lock *)lockres->l_priv;
+	return container_of(lockres, struct ocfs2_dentry_lock, dl_lockres);
 }
 
 static inline struct ocfs2_mem_dqinfo *ocfs2_lock_res_qinfo(struct ocfs2_lock_res *lockres)
@@ -610,13 +608,6 @@ static __u64 ocfs2_get_dentry_lock_ino(struct ocfs2_lock_res *lockres)
 	return be64_to_cpu(inode_blkno_be);
 }
 
-static struct ocfs2_super *ocfs2_get_dentry_osb(struct ocfs2_lock_res *lockres)
-{
-	struct ocfs2_dentry_lock *dl = lockres->l_priv;
-
-	return OCFS2_SB(dl->dl_inode->i_sb);
-}
-
 void ocfs2_dentry_lock_res_init(struct ocfs2_dentry_lock *dl,
 				u64 parent, struct inode *inode)
 {
@@ -624,6 +615,7 @@ void ocfs2_dentry_lock_res_init(struct ocfs2_dentry_lock *dl,
 	u64 inode_blkno = OCFS2_I(inode)->ip_blkno;
 	__be64 inode_blkno_be = cpu_to_be64(inode_blkno);
 	struct ocfs2_lock_res *lockres = &dl->dl_lockres;
+	struct ocfs2_super *osb = OCFS2_SB(inode->i_sb);
 
 	ocfs2_lock_res_init_once(lockres);
 
@@ -652,9 +644,9 @@ void ocfs2_dentry_lock_res_init(struct ocfs2_dentry_lock *dl,
 	memcpy(&lockres->l_name[OCFS2_DENTRY_LOCK_INO_START], &inode_blkno_be,
 	       sizeof(__be64));
 
-	ocfs2_lock_res_init_common(OCFS2_SB(inode->i_sb), lockres,
+	ocfs2_lock_res_init_common(osb, lockres,
 				   OCFS2_LOCK_TYPE_DENTRY, &ocfs2_dentry_lops,
-				   dl);
+				   osb);
 }
 
 static void ocfs2_super_lock_res_init(struct ocfs2_lock_res *res,
@@ -4099,7 +4091,7 @@ static int ocfs2_dentry_convert_worker(struct ocfs2_lock_res *lockres,
 				       int blocking)
 {
 	struct ocfs2_dentry_lock *dl = ocfs2_lock_res_dl(lockres);
-	struct ocfs2_inode_info *oi = OCFS2_I(dl->dl_inode);
+	struct ocfs2_inode_info *oi;
 	struct dentry *dentry;
 	unsigned long flags;
 	int extra_ref = 0;
@@ -4115,15 +4107,6 @@ static int ocfs2_dentry_convert_worker(struct ocfs2_lock_res *lockres,
 	if (blocking == DLM_LOCK_PR)
 		return UNBLOCK_CONTINUE;
 
-	/*
-	 * Mark this inode as potentially orphaned. The code in
-	 * ocfs2_delete_inode() will figure out whether it actually
-	 * needs to be freed or not.
-	 */
-	spin_lock(&oi->ip_lock);
-	oi->ip_flags |= OCFS2_INODE_MAYBE_ORPHANED;
-	spin_unlock(&oi->ip_lock);
-
 	/*
 	 * Yuck. We need to make sure however that the check of
 	 * OCFS2_LOCK_FREEING and the extra reference are atomic with
@@ -4150,6 +4133,17 @@ static int ocfs2_dentry_convert_worker(struct ocfs2_lock_res *lockres,
 	if (!extra_ref)
 		return UNBLOCK_CONTINUE;
 
+	/* The extra dentry lock reference keeps dl_inode alive. */
+	oi = OCFS2_I(dl->dl_inode);
+	/*
+	 * Mark this inode as potentially orphaned. The code in
+	 * ocfs2_delete_inode() will figure out whether it actually
+	 * needs to be freed or not.
+	 */
+	spin_lock(&oi->ip_lock);
+	oi->ip_flags |= OCFS2_INODE_MAYBE_ORPHANED;
+	spin_unlock(&oi->ip_lock);
+
 	spin_lock(&dentry_attach_lock);
 	while (1) {
 		dentry = ocfs2_find_local_alias(dl->dl_inode,
