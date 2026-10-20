Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792506361;
	b=LQKW7meTQUAaeR4bhYi7Gt4CfdTUbkPUvLl0f+iZRKrqptG/zLrt/2sbb67SovJz9AFZ
	 HME8tlgE4yn57QBjUIieIqiYUI0/K8/YNNBFidZShuIIG8b4r9DbLQwPZxcuJTVD2X+R1
	 nMRxe0DKrCEnYdTSrTVYAZBDRnhWNNGxPTSlHflY4hu3ebDJcDzdivUua4lMcxx6Hn0+C
	 iGz4Bn7GIgWZbmO0Lg/KpkN7ERUIyC+iK08kH3znAxNJgMiwnyIvRolF+ty9cC0WluWeg
	 MVBD7xm6F4KVEqI2lyE6nBApp0TvytiwxftMzFHR7839ng2LLAKxvNmiuzghdnre0sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7RWczmxZUd2zIPBf7cDOEeEN988E+Le0eDxxMs8/MXs=;
	b=SWG9KpKvTOLXZ/ljKj2xsTLrXLHk2AUPto2JhQtNoH1qu8ki0pEGWiktsQQxaPa+5BVj
	 CsW6CSQbM/WT4aUTkx2E8WM9fzhZndOmX8pemjOkVN/g/+1FrbFIHV36PvQZ6F9Mi1R3m
	 F8+5+D2iSbuVT4UMg/P/67V/ZoHlK8kv1FNIJ2Mbcfm52Fd11LTEy59NQwvFFElc4cKj9
	 WEU0NAqsuwAl7maMd2FywFkFh7KcMKqOD20JP12lRBl2E/c0iHD4SfHmVHcJWSdrin/XO
	 QnrvYv6Ix9/+pbgwb/aPwYY/I6HOT6zzHblMZaAVKExEkS6VmkfDFfKGYqdxZr2rhWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eJK8g8Me;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE49606A32E
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 14:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBE49606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eJK8g8Me
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ab98332238so2575155a91.3
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 07:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792506360; x=1793111160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7RWczmxZUd2zIPBf7cDOEeEN988E+Le0eDxxMs8/MXs=;
        b=eJK8g8MejqV9x2Hu41kHWeJSeWzsbxg0bL526SOb0HgS+1naaZXq9tqMgKbN2+W2ST
         nCZQ7BusvRl4wWKV/FeDKnCi1JG0MuOeG5/BDhy/U+0Pu+DWZdRPPP8nCgwcdX8CUBVh
         QyZx4zVe1fUcfFDOYyriNtrraHAvgDHNdk8QMY8eaofXwoV7lM8GrwvDO7Cmw4NxrWWR
         knxajiEm5Kal81rC7XB9qjwVqqYnZEi5CEMxzj6o5WqHcbp+mo7LtEnWvK7ZTPBjf4P1
         HrSCN5IBBXaI2+V7iqPW9Ury/tos/G6hAhOeNgvnmvQbZFo0Csf4SMaaq/jQXLV0PAQJ
         XzWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792506360; x=1793111160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7RWczmxZUd2zIPBf7cDOEeEN988E+Le0eDxxMs8/MXs=;
        b=AGC1d7RD4hGtAesJQjP99kD1B69rwKFZ7zX0VaYOuaw/ScjLngmFnElsXZLCgWAF+B
         VH/NhM5/rRS4uZL6eswkieyCJ0QLXRpSuiYvJaYYm5bW7e06zWiY/vpMW/YdyQxTsTYI
         ztzm113ZyBNpbeFIAF4oeUCoYV853AfYajYow+HArAReUPXb96oBw+YbN6Q4bhgUbjhR
         ZUQo+smA97Xs3aLV8ukMDbP0oPaxG78wf3xzkLyfT19Hz82J4TSZxbQj1amZBwKU4946
         8t78MrkKBPpA0LQiDnCtJuUYMghffIuXsSrQgbUEcGbGylBAFz7dAeAH6aJT+xmlABwb
         r7Jg==
X-Forwarded-Encrypted: i=1; AKwUvBy/VjW8W+ZRJZGuuS9wXVRMukzCbNZfpqtRNhBx+3QnX4Um0KmUQsRfGvV5OEYajcfcAfabjfA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLT3D1F3pxdSM0Ak7UjkY8/dnZ1UF1UwIBAcNZJqNk7KOD9yRQo
	OuFTBkA0YU5lkahxNEz5ByHKfUi2k6GjmNFtHhcT6rmd7zcQOilGepWLC2s/vqCgdA41Ew==
X-Gm-Gg: AYBFou3W+jTYae6n5QfwTtUB+JHd81hAUBM5HrAZ7W6YhkZ81sZFxMHeOY9nxJPcYVL
	m13F3nCuh4ozGu8O2pIQwVfF4/qtPFxyC/YyWE8nJlGgOsWnfio7S8ZVLLPPTAHhXUZ+41mzUKT
	tefB1JE6ZNGYkv7DnGibZHj3UbO4Sxmj2IbGIFo5hm6iIzdqtPF0Enc++p9JkY9xemVo2N+l307
	TA+rVJTET3ghiQSnqmWgbvaM3QdTlH/Gq3LCrMRXI2nXMHZA7o9dYJL57O+cTc+NQ/y2ip1+uxd
	QvSsKlYcUY/mPOMlhL4yZAbvsbwBL6MWu3imJV28+6JcVgVL5Ml0mL4+W1PtE80bo/Ah5UuV4EK
	63upol7HTVYJCVwhffePPR/eCAfptQ6Y6ZiVCWBLSvVnc2tg3ecpU/x4ormnOz8g7cVXMs4LUk5
	C0RcioobV7g21s+UnqXiKJ71bnhiXYD4d0ehF0xORKfEXEieUQbzjJEjK0wMEMIVm7LjQoefwf+
	q7XAfT7RDLji28mPHZRO4OFIi5GJgPhEDNEVZdA+hXaq1AWQvutjq/i7F/ytJ2Pk1E7Ch3Z
X-Received: by 2002:a17:90b:5743:b0:3ab:1b1c:8a70 with SMTP id 98e67ed59e1d1-3acef29e7c2mr9107677a91.38.1792506359913;
        Tue, 20 Oct 2026 07:25:59 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd0cde4fdsm10447319a91.4.2026.10.20.07.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 07:25:59 -0700 (PDT)
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
Subject: [PATCH v4] ocfs2: cache the mount context for dentry lock callbacks
Date: Tue, 20 Oct 2026 22:25:53 +0800
Message-Id: <pm-ocfs2-objects-candidate-0012-v9-eeb9084fb29577971229@gmail.com>
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

ocfs2_drop_dentry_lock() drops the inode reference before releasing the
DENTRY lock. This lets inode eviction release the local inode and open
locks before a remote unlink can proceed past the DENTRY lock.

A DLM callback can still arrive before the DENTRY lock has been dropped.
ocfs2_get_dentry_osb() obtains the mount context through dl_inode->i_sb,
which can access a freed inode when the downconvert thread drops the
last inode reference in its post-unlock callback:

  Downconvert thread                     DLM callback thread
  ------------------                     -------------------
  ocfs2_process_blocked_lock()
    ocfs2_dentry_post_unlock()
      ocfs2_dentry_lock_put()
        ocfs2_drop_dentry_lock()
          iput(dl->dl_inode)
          [inode reclaimed after RCU]
                                         ocfs2_blocking_ast()
                                           ocfs2_get_dentry_osb()
                                             dl->dl_inode->i_sb
          ocfs2_simple_drop_lockres()

Store the mount context in the DENTRY lock resource's l_priv field and
use the default mount-context lookup. Recover the containing dentry
lock with container_of(), as already done for refcount locks, and remove
ocfs2_get_dentry_osb(). ocfs2_dismount_volume() shuts down the DLM before
freeing the mount context, so callbacks can use it without accessing the
inode. Preserve the existing iput-before-unlock order to avoid delaying
local inode and open lock release until after the DENTRY lock is released.

Fixes: 8ed6b23709b3 ("ocfs2: revert iput deferring code in ocfs2_drop_dentry_lock")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Suggested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Changes in v4:
- Drop the convert-worker change from v3. Keep MAYBE_ORPHANED marking before
  the extra-reference check, including the dl_count == 0 path needed for
  local orphan cleanup.
- Retain the osb cache from v2 and the original iput-before-unlock order;
  remove the incorrect worker-lifetime claims from the commit message.

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
Link to v3: https://lore.kernel.org/r/pm-ocfs2-objects-candidate-0012-v8-d01e30cb3f465e294c0a@gmail.com

 fs/ocfs2/dcache.h  |  5 ++---
 fs/ocfs2/dlmglue.c | 16 ++++------------
 2 files changed, 6 insertions(+), 15 deletions(-)

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
index 88d946466083..437a726834c8 100644
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
