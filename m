Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012651;
	b=FGzdFtzlPW98xjXBGcDna1wIHu0w7idIdssPveWK5caMetoC2BNsfgWhLGXIyi3bl3ko
	 h/Mu+0kLn3j4I1VRkNjLf/Gv1Fo5dXFBZ1FqCFTD8vDdt1tIauRN3NNc4rn2GE925S+kj
	 b/ZPMILYzBbjqJq2qGMzEE3z8a3SDbD3jFAEvqxa4xQ/vi7oweNaOCI9FRAx0G7DDcjwo
	 o6qL1TMxa3DT/lez9niDW50ssJv/+xAUqh9eWuxCaqzy/PIiSMmuq1syO9H2ET8vv8OdY
	 fxpuxygVDlVjJrMvRg/t64xuirM31bJsX66o6mJ7EvGG4rj6jf+S0odem01TBttm2/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012651;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yc3GxhcVwYHF7pcFhLDs2JFITUiR3kBKiUR6rOxi4q4=;
	b=zXCEuC5ozwjcXDZeGNeTw2xdJEd3G07eXbAf5qyHNVr3OJQmm4BZFKPMvMPNvYPYbSsG
	 ndrHy/6UHAd1NyX7NBZDDGPtFbKjsi2vG6zVHUUMbDkqZ9dN2VVrFG+uMEkSNGMROdYEv
	 FItEqrEYXpZzbJSGzSGm8D9wVcuegg1uD/FclVeXS1UORDO38fyfKOW60zpy8YBpLQVLf
	 T+3JixLbq5baZdvB5lL0xTrgZILOjW23bnQX+Vy/WabpTehj+yBXsPoq1NVdDc960YmJA
	 KHutxnp9VzT99mHIZ7+cTWY4eJ/DhMXVc/huMmEruCe8Lf0tzXvnpICsEFV8mfdfnRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HpQNJnOr;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C9D606A31D
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3C9D606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HpQNJnOr
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso1646202a91.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 04:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793012650; x=1793617450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yc3GxhcVwYHF7pcFhLDs2JFITUiR3kBKiUR6rOxi4q4=;
        b=HpQNJnOriCtXbTc+LEUQuu83qSG6ddFJoOM5b1gwgsZtnj1nytw9S9fnZ5FTFYcfdm
         +jTdk9uxpn6T0zZM6mY3/ky0m3yXpLr+UXO7lKC+9z9dQD88AWqqxbu3RFvsNC9Y88Cv
         iYPgqo1YphbaVHX5uSe8sdpJxRpHJZAzci+e2H8aCVtLzZLgg2vUIgNZWVV+3PNvVlVd
         j+XpIieqlNbKDUdTeRhKTyLkebIRv97wZ7G50lAGp5zbhPrHOEMKAuQjYNjlDBzZY5mO
         o0v6keAvcuzII0wRHr9Jc7iOLZ1c0cMo/g+d6XbZWwJpeViYXDTcJ97j2Z6kSYHzX7rh
         a4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793012650; x=1793617450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yc3GxhcVwYHF7pcFhLDs2JFITUiR3kBKiUR6rOxi4q4=;
        b=xs+jUl9fz3ZqbTRJzbhhyZR68ZjexdpdI1pL6wfjHSPXR3j+wZZvEeLfh3XFoDHRU7
         cj8rEfqoq4YRppvNUF0llp3lqscewuBhCSCwHTZnyVOC5lH05STPUWktVTcgTWNwj7WL
         QS8iMLkbX9m/+w7SeY5Y4bzbnvqKJddcCT4FqI09u+mcH7Vh+jRHAcJMnfPPcUYEs73F
         43dN1J5sJ9g8alqbqV7bctQp7YKtP+0R+O5P9cXXKAjcPG2YBbqpJR4koixP352LzT48
         VS3+l5BX7Z+R0+y3wgurO/cmkKnGjDJv1hPwvY2QikUYtasrVuFthhexynyO+MPSNjSv
         Zftw==
X-Forwarded-Encrypted: i=1; AKwUvBwT482Nluhh6NS83yX1bnayGEM6/w9VPz8UzJfZKcBfxlk14zhUQxrlqdWdOw3yLTkAEqVBZxk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxi6R447i3ZxllS/xc4mekPFjYwczGpgNrJnMiYn/C1mdFiYRL
	zaPHJnO/uVYkXn/19N4cHpSyOEV5fksuHIjn+uJj77fDThpn4vNpn6Fy
X-Gm-Gg: AYBFou3zGVDdNj7cHdFkHn38he0hoH+SdGPaPpSKaa+MrIxt39UfrySi2Zk31FeL+bk
	ZYchtlZpQ69wpnJx+Zc7O+AMZpe5AmQIcJs25BDBMkE7ngGPb8Y8DxPRXoXkgDMYK9vPR5ucPVW
	2+LJokE9FZVWSluw1dVB3/V+NaFbG16RXCHmITk0Xb/eBxIjSiYtXKWjuCDN4SKTk45gTlhMBX8
	McnChhbmHt+JizeDQv/Ft5L/tnYhsLaMFD+IGD4PAMUs6yUuIUUCJuiylxFx+/BtE+5QxWeE6V0
	YeC5wTCj0CVUYM08TocMh0bpHA8b9paeLfhOaVXw2bzRMZMKTjJLsZYUQyYfvmUON9iSbQxUFrM
	/BUm/luNY47DFtcQA/T9wXkr1ZlkEjTOVUuXOAmdgUsdbY/3+Hftaml6vBqvOOVrUCUddlA3keU
	azehizUjscZLBEBQQlYwXz4nAu+UNQl8y7YIaegCz6ANFo9Hvh/2TnxTl0J7j1YwuIF/Q+bGcYp
	ahhP/6TiZ4FNNcQMAy38q6QdBeJ6n2ht0N+NQOTPJ0Fc3wC9EY=
X-Received: by 2002:a17:90b:58e8:b0:3ac:9706:7739 with SMTP id 98e67ed59e1d1-3adead57cf0mr5711908a91.17.1793012649819;
        Mon, 26 Oct 2026 04:04:09 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebbb2fb2sm8024223a91.1.2026.10.26.04.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:04:09 -0700 (PDT)
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
Subject: [PATCH v3] ocfs2: validate move extents against a stable EOF
Date: Mon, 26 Oct 2026 19:04:00 +0800
Message-Id: <pm-ocfs2-move-extents-isize-rrw-v6-395bdee84ea81149068e@gmail.com>
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

Range errors now reach the ioctl's normal copyout path, as goal errors
already did. Unlike the old early rejection, a failed copyout can
therefore override -EINVAL with -EFAULT.

Fixes: 53069d4e7695 ("Ocfs2/move_extents: move/defrag extents within a certain range.")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Suggested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

---
Changes in v3:
- Log goal validation failures with mlog_errno(), matching range validation
  failures.
- Document that range errors now reach copyout and that a copyout failure
  can override -EINVAL with -EFAULT, as for goal errors.

Changes in v2:
- Validate and normalize the original range only once, after inode and
  cluster locking have stabilized and refreshed EOF.
- Move goal validation after range adjustment because its allocation-group
  capacity check depends on me_len.

Link to v1: https://lore.kernel.org/r/pm-ocfs2-move-extents-isize-rrw-v3-b2a7508c41108cc2d00b@gmail.com
Link to v2: https://lore.kernel.org/r/pm-ocfs2-move-extents-isize-rrw-v4-d4b80ed0748f84dc3f8e@gmail.com

 fs/ocfs2/move_extents.c | 70 +++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
index ad1678ee7cc4..93b45531bf7d 100644
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
@@ -936,6 +960,21 @@ static int ocfs2_move_extents(struct ocfs2_move_extents_context *context)
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
+		if (status) {
+			mlog_errno(status);
+			goto out_inode_unlock;
+		}
+	}
+
 	/*
 	 * remember ip_xattr_sem also needs to be held if necessary
 	 */
@@ -1028,27 +1067,8 @@ int ocfs2_ioctl_move_extents(struct file *filp, void __user *argp)
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
@@ -1060,23 +1080,11 @@ int ocfs2_ioctl_move_extents(struct file *filp, void __user *argp)
 
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
