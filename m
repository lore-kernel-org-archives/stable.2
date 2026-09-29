Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7624C514746
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682665; cv=none; b=aOGz9npbHLt10js5SKeisUicNNdRUrfOlrmG31IlCz7xopuazN1zcKqSdkmeHv1g2KckR8cgkxkK+XqH2D+CFBKEB4NSDwwmj4TJndTLk07c7PqkmS4JIimRKZAXfpHbLcr9vrk0XdR3pN5FWNey1xawEorieRgNsi4SYr2CpeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682665; c=relaxed/simple;
	bh=/BrK5DqSU/xb6J34WPyftHQPub+gNcGhRrujnotTrtY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Po9gMJ64okE3HyeJBMrMKIYieBzIeK0t1qeTojKVjtuQZ6eB936LpzHXNY+oG0ArEPQfPrkB05HwbaK7Vep4w9YbeswsgBKjYWTNwsxGaQh5vfY9UCWYqfyvwmjTVeIxH/0vgh80qL+mFklE/moDl4rYzMR1KQixi7TgecPo4bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RL2V1iL/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RL2V1iL/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9A31F000FF;
	Tue, 29 Sep 2026 11:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790682664;
	bh=JumBsFF5q8OUODJeVfEiQAjcmC+cdoI9gqOMwCFOJm0=;
	h=Subject:To:Cc:From:Date;
	b=RL2V1iL/AJhvDAzRaNc1QFAnTJon4spuTncHbk4pbhCn5rtt9aLNprRdQSY8sxFWs
	 mEkBEAVM3L42UJ0Waq8sDwM1r0oZmZUFpFM9Vt4sXxNxb1OdVy13rm8/Zf2rQbRGT9
	 a0p/OtAkGXh+KrQJ40VYsBeAlxkChYcBb/YFuVwE=
Subject: FAILED: patch "[PATCH] smb: client: close handle after create-context parsing" failed to apply to 5.15-stable tree
To: zihanx@nebusec.ai,pc@manguebit.org,root@tr0jan.top,sorenson@redhat.com,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:50:45 +0200
Message-ID: <2026092945-vendor-cesarean-fd29@gregkh>
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
git cherry-pick -x 566820af017e81497fb5e9d3ad6e7ffe2828bc8b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092945-vendor-cesarean-fd29@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

