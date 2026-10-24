Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792858808;
	b=VfCQp54v304VrqPfZGz0+4H1zwZ0zHV9PNA+GNiHrCnGuDe9K0LVXUKlHFEBzX/TGb8o
	 8U8ya/Mtw/hYGsCYCPEtGjzp41k7GLi9JK7aFzDQ+CDp/5LzuktLS6e80oQRRY5AxM8VU
	 7fZ4UcF2zhP0Q/xz/wPDe/L6gtEZvTPxabl1aUGkyLiIuDX/tSJzm47Ls+YaIQIlq1M/3
	 4DSHJ8tWfWAdnsIbHjT3wJ6wkeAg4Gj8fCue93q8ib5iw548/DxFpMr7Kq5Afz/bT1g4W
	 UidY3K/TUKIdz7/2p/nCkFJdIdtDk9VRfuZftxlo4UaIRhre15OEMutbsy0HP+/a89Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792858808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xwmLnAa6b4VIfgYdyaQibjdMJAMiidZmgGGch02/UIc=;
	b=hLPHH50f+RaUKfKOBpkquL/XNAi+UZtartQUvYIgjSa0PKlThcmCWOIXV3ZrJj68l7Nz
	 JQyCx6okiOHC8N0jkBzd4ybPHflvhcYr/hzrHyqmE0CY6geMTcWPxF7Sx3OpOdpQKlbg9
	 e43s4aMRfkJOUMxwN/nMdwE16XeaRR+0D2Tnq7xAxN/fPyAUaUcLBE58slBwjRV3Cszn0
	 eiZSoj5uVKlDKY29SozaLc/l3gVhdHaC9Vz2lk1ySDudXBwVHSiu1eNXUjtNC4mGWeNrD
	 oDqrisuEZtTqNh4NmsgkajeNBUoTAxW62TuAThvweXO5xeOTRZxLbL1BAx29ntOYCEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=grHHy9fn;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A26606A31A
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 16:20:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03A26606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=grHHy9fn
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so1289611a91.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 09:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792858807; x=1793463607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xwmLnAa6b4VIfgYdyaQibjdMJAMiidZmgGGch02/UIc=;
        b=grHHy9fnVHuY1405Ef2orje57iOKu31LW3gCJQfMRR37YW2XFisFHAz89/1atQFlQf
         rJJpHMfaqScvwbEJ1AVGvoUs0loPiS4et2nYDmtYZDRkifwBCN7ebptGLZmrWKDGGY1r
         QzLaifCkRDHXAx77Lq2G5xI7WRjbvAoHQ7S325lPufCq/Ev4qDe8BxK+O1/K6hO5ZAYY
         blieZqe7NZt/qJvea+8EcUmtBxhFy4Swkdd41XGccPXG7TwUAP2T2QRW0JXuAlMIyO6K
         DiTYDg9NsBHkuTbgi4LWiLF0gCJJ5Tlg6jCwTdjKoSCtv0b5pqZifPiRRLJ507mlTvan
         KpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792858807; x=1793463607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xwmLnAa6b4VIfgYdyaQibjdMJAMiidZmgGGch02/UIc=;
        b=brx5tS1zc1C1czlfWiMswAz0HIZGvfgw48H5ZHF3FNdTIp6d/P/RqYb/iGRhha79nZ
         z8yvSW11BcfnKX5b1CECxq6TxUVu6O5uQVoklTOHKHr4X9e0kHmL3ERy8oyuvOQdIPdr
         GcBLuds0ao8XyBgijgwJmBdasMZNd4W/XLehW2fDLO3RfOJihwZAgK8qKVSaLEBL0tFH
         sbWuICOaa5y913tVej/68z/jF14MeL30AVoeh8+nLzLU4zy99+AxkPzvNDr3RVklPSyf
         6itdgPQJzkls/hCBGSjwbu47nBvXHv6cwe1U1mhcOfWePdTVmpdTlmvw6qDiJAXRHgWC
         gQdQ==
X-Forwarded-Encrypted: i=1; AKwUvBx8ithEQ+v+DZonr5S1TqJXw0FBMGA8hC0XyWrvw02TpHApWK8ZZoOT1kr5pjQaGSkdkov6oFs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcp4F1RE0XviMHsrA2ZTqFnesjTtXZsnAcolN8+ynoZ4S2x1+8
	0+kdtgRsVMX2LaCHeMqyRcvwi9UW9/p4LQZf1RiSSMnTZNMKj4+HiasH
X-Gm-Gg: AYBFou3Dmiitc13B2+WFOy9ZJn7HnI7Fk0NXcgsPyqlM9RB6wztmhIksuPeHG0rxUaE
	DdahZjQvm/1EfXSwpE0kgwKrXpBM8jgOB4njyA7SpdzOQVhUbD5gkoDY5oeat0sXqxv4apWrvO5
	VEo59Sj2USqD1X6g7ECovmyXG8rp4WV3fFkkGsk7fjTdo/QfEbC83hKVI4MpE/Q37US2NfpkWNR
	ZlDrWG7qpS6vNZlr918dwp6yP4nkGciqgD73jKOhyICxUDACFCCcMQgPvDBjO0cUHAAud96CZNi
	DCFKfhGlwRo/qwI94pAW1uoUD0uadGoCXmIpPLqP1rzQWrrIcx/Es6jyz0DKzyV3FUuMEdJ5mil
	GEs2695sVRUIaErGFzB5WL0TH+VkK4nx9ccXXMBPtQstljWXL6qokqoFE6um5c1h5/t9ZTAe6X5
	CrK3GyxA4ru+nez1fZs06zxNv/8EkRPOb/OqA7UQUMNidI8XjupCXRvkFF4Rbs7wdfaYo3LNAvC
	wYRPkp+Mg+bY1Mj7u48+/zY35d4x+8y3lVAgD53vcWrpcMb8qw=
X-Received: by 2002:a17:90b:1645:b0:3ac:9c37:9418 with SMTP id 98e67ed59e1d1-3adead50acfmr2166488a91.19.1792858807236;
        Sat, 24 Oct 2026 09:20:07 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeb8240b5sm2180033a91.0.2026.10.24.09.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 09:20:06 -0700 (PDT)
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
Subject: [PATCH v2] ocfs2: validate move extents against a stable EOF
Date: Sun, 25 Oct 2026 00:20:00 +0800
Message-Id: <pm-ocfs2-move-extents-isize-rrw-v4-d4b80ed0748f84dc3f8e@gmail.com>
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

The move-extents range must be bounded by the inode size used for extent
movement. ocfs2_ioctl_move_extents() checks and clamps the request before
taking the local inode and cluster locks in ocfs2_move_extents(). It also
uses separate i_size_read() calls for the range check and subtraction.

A concurrent truncate can invalidate the first check and make the later
unsigned subtraction underflow:

  Move-extents ioctl                  Truncate
  ------------------                  --------
  check me_start <= i_size
                                      take inode and cluster locks
                                      shrink EOF below me_start
                                      release locks
  compare me_start + me_len with EOF
  set me_len = EOF - me_start
    [unsigned underflow]
  acquire inode and cluster locks
  select extents using the bad range

A truncate after clamping can also leave the range extending beyond EOF.
Conversely, the cached size may be smaller than the size refreshed when
the cluster inode lock is acquired. Early validation can then reject a
valid start or permanently shorten the requested length and threshold.
The me_start + me_len comparison can also wrap for a large input length.

Validate and adjust the original request once, after inode_lock(), the
exclusive rw lock and ocfs2_inode_lock() have stabilized and refreshed
the size. Read EOF once, reject a start beyond it, and bound the length
by EOF minus start. Normalize the threshold using the same EOF snapshot.
This keeps zero as the default-threshold sentinel until validation uses
the size that will govern extent movement.

Move goal validation after range adjustment as well. Its allocation-group
capacity check uses me_len and must see the EOF-clamped length. Both
validation failures use the existing inode-lock unwind path before any
extent movement or transaction starts.

Fixes: 53069d4e7695 ("Ocfs2/move_extents: move/defrag extents within a certain range.")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Changes in v2:
- Validate and normalize the original range only once, after inode and
  cluster locking have stabilized and refreshed EOF.
- Move goal validation after range adjustment because its allocation-group
  capacity check depends on me_len.

Link to v1: https://lore.kernel.org/r/pm-ocfs2-move-extents-isize-rrw-v3-b2a7508c41108cc2d00b@gmail.com

 fs/ocfs2/move_extents.c | 68 ++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 31 deletions(-)

diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index ad1678ee7cc4..f2682ef6bf2b 100644
--- a/fs/ocfs2/move_extents.c
+++ b/fs/ocfs2/move_extents.c
@@ -907,6 +907,30 @@ out:
 	return ret;
 }
 
+static int ocfs2_validate_and_adjust_move_range(struct inode *inode,
+						struct ocfs2_move_extents *range)
+{
+	u64 i_size = i_size_read(inode);
+
+	if (range->me_start > i_size)
+		return -EINVAL;
+
+	if (range->me_len > i_size - range->me_start)
+		range->me_len = i_size - range->me_start;
+
+	/*
+	 * The default threshold for defragmentation is 1 MiB, which
+	 * matches the maximum OCFS2 cluster size.
+	 */
+	if (!range->me_threshold)
+		range->me_threshold = 1024 * 1024;
+
+	if (range->me_threshold > i_size)
+		range->me_threshold = i_size;
+
+	return 0;
+}
+
 static int ocfs2_move_extents(struct ocfs2_move_extents_context *context)
 {
 	int status;
@@ -936,6 +960,19 @@ static int ocfs2_move_extents(struct ocfs2_move_extents_context *context)
 		goto out_rw_unlock;
 	}
 
+	status = ocfs2_validate_and_adjust_move_range(inode, context->range);
+	if (status) {
+		mlog_errno(status);
+		goto out_inode_unlock;
+	}
+
+	/* The goal check depends on the adjusted range length. */
+	if (!context->auto_defrag) {
+		status = ocfs2_validate_and_adjust_move_goal(inode, context->range);
+		if (status)
+			goto out_inode_unlock;
+	}
+
 	/*
 	 * remember ip_xattr_sem also needs to be held if necessary
 	 */
@@ -1028,27 +1065,8 @@ int ocfs2_ioctl_move_extents(struct file *filp, void __user *argp)
 		goto out_free;
 	}
 
-	if (range.me_start > i_size_read(inode)) {
-		status = -EINVAL;
-		goto out_free;
-	}
-
-	if (range.me_start + range.me_len > i_size_read(inode))
-			range.me_len = i_size_read(inode) - range.me_start;
-
 	context->range = &range;
 
-	/*
-	 * ok, the default threshold for the defragmentation
-	 * is 1M, since our maximum clustersize was 1M also.
-	 * any thought?
-	 */
-	if (!range.me_threshold)
-		range.me_threshold = 1024 * 1024;
-
-	if (range.me_threshold > i_size_read(inode))
-		range.me_threshold = i_size_read(inode);
-
 	if (range.me_flags & ~(OCFS2_MOVE_EXT_FL_AUTO_DEFRAG |
 			       OCFS2_MOVE_EXT_FL_PART_DEFRAG)) {
 		status = -EINVAL;
@@ -1060,23 +1078,11 @@ int ocfs2_ioctl_move_extents(struct file *filp, void __user *argp)
 
 		if (range.me_flags & OCFS2_MOVE_EXT_FL_PART_DEFRAG)
 			context->partial = 1;
-	} else {
-		/*
-		 * first best-effort attempt to validate and adjust the goal
-		 * (physical address in block), while it can't guarantee later
-		 * operation can succeed all the time since global_bitmap may
-		 * change a bit over time.
-		 */
-
-		status = ocfs2_validate_and_adjust_move_goal(inode, &range);
-		if (status)
-			goto out_copy;
 	}
 
 	status = ocfs2_move_extents(context);
 	if (status)
 		mlog_errno(status);
-out_copy:
 	/*
 	 * movement/defragmentation may end up being partially completed,
 	 * that's the reason why we need to return userspace the finished
