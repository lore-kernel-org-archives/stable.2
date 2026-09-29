Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BC2514746
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682670; cv=none; b=iW09ttfpmajQ7dxQNmOOC/VRrqsvY4StEsaU3zkhPOsCuc0TtWek/XrcpZ8gX0DDCN179bbTXbTd4VUkL5jeFHPHOOQUOW9/IyKUGyk2hRdLRludKD7SlnBSueA9uS9UDaN++ShMJoRIaRXW1AilviaotNN4JsWJRG9k5ZKawdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682670; c=relaxed/simple;
	bh=qnviwbMQQKnm5hlGCNc3SlFbrn3+JLDySSg2r0DW8J4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ERvsnQGljDg9Lf99Ag23y+L6Vlv5fSp/ofsccMa7Y3zTmhQT72lMrqBnWj+CRYYf9MSZEUecvDiC7TRmyg1/bLsvljd/Pi4SCEOHoGLxhv7nvam7dMkILY9ciA7W7wIrgfWqIzcUwbnDGe+rSzJpEOkAc0NGI3uFTFmuas7n3no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RguS72rX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RguS72rX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2950E1F000FF;
	Tue, 29 Sep 2026 11:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790682669;
	bh=1LoFJEy+ih0kfztgZmKCuUWdLfBFdjxiLMMQBiulHII=;
	h=Subject:To:Cc:From:Date;
	b=RguS72rX2jaSrOB5SbR40IZEAZr8x+ITreGAhEUawepbwJOeHkEbow8fcmHXR+lbi
	 7U85ZSsJvBSM8z4wH/Hz+BF3JmezG+Y1xmRzUGuXuN5Bq5FNPqI4TgwSGOU8wNRnra
	 4UeOUc+PseP+RZE1XzC7uSKoOq6j6bRrSubSZDpk=
Subject: FAILED: patch "[PATCH] smb: client: close handle after create-context parsing" failed to apply to 5.10-stable tree
To: zihanx@nebusec.ai,pc@manguebit.org,root@tr0jan.top,sorenson@redhat.com,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:50:46 +0200
Message-ID: <2026092946-apron-radio-67f9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x 566820af017e81497fb5e9d3ad6e7ffe2828bc8b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092946-apron-radio-67f9@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 566820af017e81497fb5e9d3ad6e7ffe2828bc8b Mon Sep 17 00:00:00 2001
From: Zihan Xi <zihanx@nebusec.ai>
Date: Wed, 16 Sep 2026 15:29:26 +0000
Subject: [PATCH] smb: client: close handle after create-context parsing
 failure

SMB2_open() accounts a successful CREATE response as a remote open before
parsing its create contexts.  If smb2_parse_contexts() rejects malformed
context data, SMB2_open() returns without closing the handle, leaving the
server-side handle open and num_remote_opens elevated.

Close the handle after a post-CREATE context parsing failure so the error
path releases the remote resource and balances the open count.

Fixes: af1689a9b770 ("smb: client: fix potential OOBs in smb2_parse_contexts()")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Tested-by: Frank Sorenson <sorenson@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 538d708b0404..3d7ead36d1a0 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3416,6 +3416,9 @@ replay_again:
 
 	rc = smb2_parse_contexts(server, &rsp_iov, &oparms->fid->epoch,
 				 oparms->fid->lease_key, oplock, file_info, posix);
+	if (rc)
+		SMB2_close(xid, tcon, oparms->fid->persistent_fid,
+			   oparms->fid->volatile_fid);
 
 	trace_smb3_open_done(xid, rsp->PersistentFileId, tcon->tid, ses->Suid,
 			     oparms->create_options, oparms->desired_access,

