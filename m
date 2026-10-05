Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F04C4AF171
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211735; cv=none; b=HVLMVprm6J/hwjo7VKrSNAho3dHon+WAwvTof/9m/NdsmzE0Zgy308Xy6CrjHrTQDeeGjISBhksgPwUhUFmq08dRJ2xrx0CGaNjKJ5Qfcrk/NuUr2ImmnIWQ0mZofyFE525XvLrBYLlwygtYUcntX8AnVZWNolEGEZuFCCAl3Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211735; c=relaxed/simple;
	bh=XmayKRfPAl7lnz27KZwQigr4L+XXjiGOKzsATOJKixA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OYFlYQ2UwYwG/D64DQmQk5hmBNYMVmpJvvdjz+D0C8AIcz5MSS23MGms4G9a5YaXMrzsOgHo6t11TDVcarod2O046DP3GIRjYyM0yHePhddMpfxO9ix6ssHNvkXtgbexZNBYvVPM/j3y5XPdQQbc6HJAXJc3Lagy8VxixlmXjGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rEBoNpsv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rEBoNpsv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5987F1F00893;
	Mon,  5 Oct 2026 14:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791211731;
	bh=fNXHq//9tn7W/SSlqrnmlW31KmkIiWMYxOMMRpcPV/Q=;
	h=Subject:To:Cc:From:Date;
	b=rEBoNpsvDojakoBMesTzZmg/AGh/rZQ0BbjWGlZQMN6Zo9Lf+Z9wjPbaz6oEMI9c9
	 27UcQk7i894CA6bz4o4xcaErLAiAcA0VKbNBJ9X1VDDD57+t0SOkHvpar1vzUITdkt
	 6E6vtmqns/hUmi8zVrvLRhTRq+U006aSfKnM06Bg=
Subject: FAILED: patch "[PATCH] smb: client: split cifsFileInfo bitfields to avoid" failed to apply to 5.15-stable tree
To: sorenson@redhat.com,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:48:38 +0200
Message-ID: <2026100538-wool-unveiled-ca0d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 19465a9aeb664f1d710d0d22c07c31bfb7c85446
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100538-wool-unveiled-ca0d@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 19465a9aeb664f1d710d0d22c07c31bfb7c85446 Mon Sep 17 00:00:00 2001
From: Frank Sorenson <sorenson@redhat.com>
Date: Wed, 30 Sep 2026 15:47:15 -0500
Subject: [PATCH] smb: client: split cifsFileInfo bitfields to avoid
 shared-byte RMW races

The invalidHandle, swapfile, oplock_break_cancelled, offload,
and status_file_deleted fields are stored in the same bitfield byte
in struct cifsFileInfo, but are updated in different code paths that
may run simultaneously, and are protected by different locks.  Since
bitfield assignments generate byte-level read-modify-write operations,
a modification to one flag can overwrite a concurrent modification to
another flag.

To avoid these races, convert these flags from a bitfield to
separate bool fields.

Closes: https://lore.kernel.org/r/7689764e-c0f6-4016-9557-b54cf4a3de4e@redhat.com
Fixes: 3bc303c254335 ("cifs: convert oplock breaks to use slow_work facility (try #4)")
Fixes: 4e8aea30f7751 ("smb3: enable swap on SMB3 mounts")
Fixes: ffceb7640cbfe ("smb: client: do not defer close open handles to deleted files")
Fixes: 173217bd73365 ("smb3: retrying on failed server close")
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Cc: stable@vger.kernel.org
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 79e4e84f8985..5c5b76a9e9fe 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1450,11 +1450,11 @@ struct cifsFileInfo {
 	struct dentry *dentry;
 	struct tcon_link *tlink;
 	unsigned int f_flags;
-	bool invalidHandle:1;	/* file closed via session abend */
-	bool swapfile:1;
-	bool oplock_break_cancelled:1;
-	bool status_file_deleted:1; /* file has been deleted */
-	bool offload:1; /* offload final part of _put to a wq */
+	bool invalidHandle;	/* file closed via session abend */
+	bool swapfile;
+	bool oplock_break_cancelled;
+	bool status_file_deleted; /* file has been deleted */
+	bool offload; /* offload final part of _put to a wq */
 	__u16 oplock_epoch; /* epoch from the lease break */
 	__u32 oplock_level; /* oplock/lease level from the lease break */
 	int count;

