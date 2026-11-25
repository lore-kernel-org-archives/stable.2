Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795605997;
	b=HPp87cTENTvX/QO52ILXeyAzIR7wqHKHultKejCDMC+JYxAoRKyeuFY2iwlAVWmWJqMq
	 B1pnA27ZKqmEP4ssqLeTL4zHmHJ3VLBO6+yoP1wa/9HZirt6dJLfj5dJsFaB0hfDLIwop
	 mhisITVcBy2Ff3ovMr7waTfLVrApefuh7WFYnE5icdErzWFVUnNNilaYZQddeZEp3fC7e
	 Y04EbjgWc8JK9WgtdTaV/cu5gaM8egJjBv/U5b1tjSPyfRNeLPZjPLp3NTItaqnzXRB2D
	 xXocaxn414pST5G7SYXQSypaCPJCV7UhNHYPqT/B0w/riDxFL1pNIg1TyzHdCWjgmyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795605997;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xdMTJNTpVsueFtqQ/6B5O6kc6G+t0VUYOM5P9C+uXdE=;
	b=mD0PcxsRq+J6HrjVsisU1UEsmuGw1OZEjCv9e5AeARYsC3kqhcrTp7Y8NpG7waTAVymB
	 q8fzBi8diu/fmTWFicqKBZIRJZxQrEPyHwQmzaMP+P3Ib2ctLPre5gh8FjM01jSz/fkom
	 mq/UIOeEL5CPeow038BZJAdBzmGAQueAkRdLImWWZ/XGBScUMKISTUa/UzLcnHbmlm3b0
	 LHTOQbcurWma3oqPLnlNZs8ZTGyr7Zt04qCVTp6Up3KVjmmMF/jJHA3Na2BL/dwL1ypcD
	 fyvoJDgEf9DmXHZYn2uFHbHIZy5boD5EwyPXv43iP2UiA/xdUtqcmXghn4IZOtI4P+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=SUeMVDc3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E4760A380D
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=SUeMVDc3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 876911F000CA;
	Wed, 25 Nov 2026 11:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795605996;
	bh=xdMTJNTpVsueFtqQ/6B5O6kc6G+t0VUYOM5P9C+uXdE=;
	h=Subject:To:Cc:From:Date;
	b=SUeMVDc31BdclAUVKmqs4g52MCqU10SyZI/A28TYgybSCklVzEYETBvOUNS+PS9R9
	 UXE1MjozDR4fu59kwHzgupd50lvGyxVEXaUI5gTUzpO6lFAd06843fEOGaUt5yGHu4
	 ZxglVrdwKpI/bBDfA4B9fezVFcsO97ZD0j1r8pfw=
Subject: FAILED: patch "[PATCH] smb: client: hold server ref while queueing reconnect work" failed to apply to 6.6-stable tree
To: joseph.qi@linux.alibaba.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:11:45 +0100
Message-ID: <2026112545-crowbar-trio-f08b@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x f02d249e9756b78990aaaa1635e47e06deb2cb51
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112545-crowbar-trio-f08b@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f02d249e9756b78990aaaa1635e47e06deb2cb51 Mon Sep 17 00:00:00 2001
From: Joseph Qi <joseph.qi@linux.alibaba.com>
Date: Tue, 3 Nov 2026 17:15:57 +0800
Subject: [PATCH] smb: client: hold server ref while queueing reconnect work

When query_server_interfaces() returns -EOPNOTSUPP on a secondary
channel, smb2_reconnect() calls smb3_update_ses_channels() which for a
channel runs cifs_chan_skip_or_disable().  That clears the channel's
slot in the session and calls cifs_put_tcp_session(), which can drop
the last reference of the channel and tear it down.

smb2_reconnect() then falls through to skip_add_channels and queues
reconnect work on that server, using a server that may already be
freed.  The send path obtained the channel from cifs_pick_channel(),
which does not take a reference, so the session's channel reference is
the only one.

Take our own reference on the channel before calling
smb3_update_ses_channels() and drop it after the reconnect work has
been queued, so the channel cannot be freed while it is still used.

Fixes: f591062bdbf4 ("cifs: handle servers that still advertise multichannel after disabling")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 7de6b0b2d116..cefbb245edcb 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -250,9 +250,10 @@ static int
 smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	       struct TCP_Server_Info *server, bool from_reconnect)
 {
+	bool hold_server_ref = false;
 	struct cifs_ses *ses;
-	int xid;
 	int rc = 0;
+	int xid;
 
 	/*
 	 * SMB2s NegProt, SessSetup, Logoff do not have tcon yet so
@@ -470,6 +471,20 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 			 * treat this as server not supporting multichannel
 			 */
 
+			/*
+			 * If server is a secondary channel,
+			 * cifs_chan_skip_or_disable() called below may
+			 * drop its last reference, so hold our own
+			 * reference until the reconnect work below has
+			 * been queued.
+			 */
+			spin_lock(&cifs_tcp_ses_lock);
+			if (server->srv_count) {
+				server->srv_count++;
+				hold_server_ref = true;
+			}
+			spin_unlock(&cifs_tcp_ses_lock);
+
 			rc = smb3_update_ses_channels(ses, server,
 						       from_reconnect,
 						       true /* disable_mchan */);
@@ -498,6 +513,8 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 
 	if (smb2_command != SMB2_INTERNAL_CMD)
 		cifs_queue_server_reconn(server);
+	if (hold_server_ref)
+		cifs_put_tcp_session(server, from_reconnect);
 
 	atomic_inc(&tconInfoReconnectCount);
 out:

