Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606002;
	b=3gdEiW+8Jg9jHE0cfuo2K8IIKDPVzWE8oC5gdkPazCPFsbGcOrG9mWEV/Gd61q7Rtd2+
	 bWS3sW0ZsrQ1Mlq5/A9Peo/f78iTpqeoegncK2E3L/Htd0Xt1AlSLNbss9uc96MbYXGcq
	 hAs9MCab4M8E1+MpA2dfjT7QhjdprNDMFNFq/ZFWx4T5kEI2NkDweaCyhfSjMRH6HyHlX
	 e7Rh3lIDVLtXtfC6vCYuyWWTlQYmpChN3Mna6hjW3YcaDMaBkydYgEw6NTPPL0cl0IiRP
	 SbgUNOPK0YLtHpTnn1ZcJLjoNcjfaktBh0LMZU3vPiQTQzlHydZUcq5VfJ3mBlsqIOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606002;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BtabmEeocZPGsTKFYSchefgNwHZd0UrbGqO5WldLXH0=;
	b=zbk2caEKjtUkdmrmE07XKRyIHojBR9U8VA3BDb2/4dUIxNTE3RvuhH5iZzEYL0pJY+5r
	 qdwut8tkvPwjz6TxUSROggx9QyyIeyzlUWK0nGV+vZVIYAZ6bv2Vr17/OO7qzr4KJDxL4
	 EXItpF8haI3wLEOVTXvsGKaGF2A8v7lzDgiNbAgWXhRW3wTbnxAVnt1O3HW3i+t+2YbMT
	 P4WMgNR4tV0POkW2pafzsvULloS728mTtGuXnVnatLqWyVIofAZVL5UXIVfMzGz9CSvm8
	 0MXw3GKkRSs48pS/mtCRnrsmsM/8Uk5KEhDE9i/s7o1071FmqG0MIqXdXmZxffgu4GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dBgSf47P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB78606A683
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dBgSf47P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47BD1F031D3;
	Wed, 25 Nov 2026 11:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606002;
	bh=BtabmEeocZPGsTKFYSchefgNwHZd0UrbGqO5WldLXH0=;
	h=Subject:To:Cc:From:Date;
	b=dBgSf47PXn9iC2mnba61JiJBSvOyEk19811sa06qYy+F1V8nvIho9hsdTo61XLtx+
	 2FKGPpm+XUoFZXl4zbiKIrE3DhpueJpdDMJD2zF621F55OkXc2pPeemyrwxDBNlhmy
	 fHfA83eNKXSWjSS2ERPb7QN7XqjfdEZx+F635YyQ=
Subject: FAILED: patch "[PATCH] smb: client: hold the inode across cifs_oplock_break()" failed to apply to 5.10-stable tree
To: joseph.qi@linux.alibaba.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:11:58 +0100
Message-ID: <2026112558-twirl-immobile-1b3e@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x fce78321f1b59531cf6fc94860550db1db8dec55
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112558-twirl-immobile-1b3e@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fce78321f1b59531cf6fc94860550db1db8dec55 Mon Sep 17 00:00:00 2001
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Date: Tue, 10 Nov 2026 17:48:29 +0800
Subject: [PATCH] smb: client: hold the inode across cifs_oplock_break()

cifs_oplock_break() drops the handle reference in the middle of the
handler and keeps using cinode afterwards, to send the break
acknowledgment and again in cifs_done_oplock_break().  The reference
cifs_queue_oplock_break() takes is the only pin: the handle holds the
dentry and the dentry is what keeps the inode alive.

When that put is the last reference, the dput() in
cifsFileInfo_put_final() kills an unhashed dentry, drops the last
i_count and evicts the inode, so the rest of the handler runs on an
object whose free is only RCU-deferred.  An unhashed dentry that a
handle still references is an ordinary state: unlinking an open file
leaves the dentry that way, and so does the dcache teardown at unmount.

Take a reference on the inode for the lifetime of the handler and drop
it once the break has been reported.  This also covers the
cifs_get_tlink() failure path, where the put is followed directly by
the out label.

Fixes: b98749cac4a6 ("CIFS: keep FileInfo handle live during oplock break")
Fixes: 23b26f4408ac ("smb: client: avoid leaking refcount when cifs_sb_tlink() fails")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index ea793d34ab69..1247d73740a0 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -3927,6 +3927,14 @@ void cifs_oplock_break(struct work_struct *work)
 	__u64 persistent_fid, volatile_fid;
 	__u16 net_fid;
 
+	/*
+	 * Dropping the handle reference below also drops the dentry
+	 * reference that pins this inode, and cinode is still needed to
+	 * acknowledge the break and to report it as complete.  Hold the inode
+	 * until that is done.
+	 */
+	ihold(inode);
+
 	wait_on_bit(&cinode->flags, CIFS_INODE_PENDING_WRITERS,
 			TASK_UNINTERRUPTIBLE);
 
@@ -4014,6 +4022,7 @@ void cifs_oplock_break(struct work_struct *work)
 	cifs_put_tlink(tlink);
 out:
 	cifs_done_oplock_break(cinode);
+	iput(inode);
 }
 
 #ifdef CONFIG_SWAP

