Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606006;
	b=GIQNVRYXCWkfzedPflYY9kS2dEDAhliNmEKD0ry6o4wZ6p6lucz2EjFwd548BkoMtR/7
	 +ELqQcdA57uJiWjnyWVXyXmG8oWSHTzgzgU7aA90RZ6/KLZYCo1IIPsq3nDKPh1Yln6N7
	 tsMXoFPpdFxrDgk1QtW0Agc8lH0X3Zuh5bFgtJoY/Qy4f/Vzdeqx05NvEDlKUCIQ304/e
	 sqs65aP2lJ0XkCGgU1c+uj/FeSBNpHakI7XMhDawEgNcxbuT0gO5qMMFVuzoxG5G7NMiw
	 L3M2GPvqWJGvSEZ3RmiWeWBXNay7tfhBkdyDgq9xkHcRZavJ0k/Nv3T6bDChzFyq4hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606006;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=X8gVOA6TXKn0jRFQfMb7cfe/0bDKhJMlMT/P/n1T5bk=;
	b=AzS0xU6C8K2wLxIBO16GC9byjj2YoBZEiTNUMhPLbP4IvwtZZa0yRDqD7F5QmVJvQTT7
	 /B2edohuBFj/FOvFymGZllVswgsxqdi/89O6TVE3wcAyFQV7zcwPVHH330LK2cDs2x9RS
	 /0DekHRufewsl+K45nD0yj7lLDulbzA0dCf1Zg6OMpUKN/zkAaYiugCKyCxDVDoGNuZIu
	 cDOpoWaolvq10zBqnjVbDw5XbsF9vfXQpOr6XprhCg3H0hHLqijztdY9dWFoPCkSUSg0o
	 osQ0ccs7v7HeNHnk89ZuO9s7ORw9nUDK+CKltFiVapL48YOnzd2B+xb64HbncTcneXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=DdkgRFLg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D97606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=DdkgRFLg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1E21F000F0;
	Wed, 25 Nov 2026 11:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606005;
	bh=X8gVOA6TXKn0jRFQfMb7cfe/0bDKhJMlMT/P/n1T5bk=;
	h=Subject:To:Cc:From:Date;
	b=DdkgRFLgh1w9UkHYi02m9toAYLsEByCjkdAS+DFqiUjMC0IDLgA/yj/Lr7CsUH6wS
	 Cl0F8aDREOP6RblUuUiHEyjfaEhd0WyQ3a72ohqCc2X0ncMwOB/7kZD2ctOMQdeugP
	 w2BlLfTjPDD0kraPk1EU6Y8BGuP/as3YQSj6rtdg=
Subject: FAILED: patch "[PATCH] smb: client: hold the inode across cifs_oplock_break()" failed to apply to 5.15-stable tree
To: joseph.qi@linux.alibaba.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:11:58 +0100
Message-ID: <2026112558-throbbing-bash-4fb0@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x fce78321f1b59531cf6fc94860550db1db8dec55
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112558-throbbing-bash-4fb0@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

