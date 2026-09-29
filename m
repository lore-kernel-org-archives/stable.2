Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AD5495AF7
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682659; cv=none; b=QylRbqrYvetFdBpahDoZcj2hhw/T6X+D53/uEnJrTxVJbSl+4lhKM5nApZjkjnmXcA/LLMVoNt2RrsRxLX2BxsMwFrTj6CgxjJOEFrZ1h+YVFMYtXmyNGypb9Q+OFzSnrt6XwJ5zBit+HWVTqjPcatROyLOZF0IvAPQKFV0O/8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682659; c=relaxed/simple;
	bh=CFbgg/ObkoOCpa4kKvyeaXM9LufQe63stZfzYS9yi1A=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Kl9g1yJTX0rvStgwJ9t0SAKA+rPE5aQlC2nUgJvw+fXfJ1CkkcuMBcwHFW6NpCVBfQ81vvpjLMxcPtGKWSbIlaVPaKGYtrleR7BRaCpyQ+rZOzR4v+zWsqY9zEBOBqf9OZuRFPZevJ7KPEpy+LKmbKyCgtB27syb3tPqPpW+Udk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wzq9Dokb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wzq9Dokb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7BC1F000FF;
	Tue, 29 Sep 2026 11:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790682658;
	bh=LyePDMkL0wbFxszfpF8i6kcTmWuTkhGkA+BW/djLNZk=;
	h=Subject:To:Cc:From:Date;
	b=Wzq9DokbUGOpXQNT3hB8IkYavEGdiouyt42TK3Jwn5W6RUhNk556fxzWS4v3IX7oz
	 kbHNPtYUoJYBaauuHHc6yWy6bKgcgc1qujwz/v6PT7MGSsD5WGcXEYw9BhaB/d0tpi
	 +l/qbKKoRTrNFijtBRTxL1xxyX5FjDsoh1VFKJG8=
Subject: FAILED: patch "[PATCH] smb: client: close handle after create-context parsing" failed to apply to 6.12-stable tree
To: zihanx@nebusec.ai,pc@manguebit.org,root@tr0jan.top,sorenson@redhat.com,vega@nebusec.ai
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:50:44 +0200
Message-ID: <2026092944-ranked-citadel-c0d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 566820af017e81497fb5e9d3ad6e7ffe2828bc8b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092944-ranked-citadel-c0d8@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

