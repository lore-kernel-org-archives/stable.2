Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B747A51598F
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 11:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682735; cv=none; b=oB265E0Sn14CRJjsY9NWZ2TM42FdWEkw6IBga52w4admhzpujtAUkw8mSPlxMlwtvS6G2+4jN2ODUG5KlpFVpEDnxo3SBa3pylMyNaEm4u2pmfVMqVUcsxHHO9pgnDKy6I4ZTW5C6WafcdxEyR5y5oHswGWbKVcmnKe3yheF394=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682735; c=relaxed/simple;
	bh=JUo7fSkMrzSzxLZeH6tq17t8KRmSVyT3osckeMQlexc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YXdDX2AMMS2CK431Sbck66ThPjtfvhM2XWxoGvZwfP2nNe2mxW/zIHCfhjESA/GPbiNOsWY8rQ1P/ziaPlN5jUPC/4zPIo8pdiXl+wwd5H6sBMRdp8NG4ELRXbpNW+riOw2PFV7e9aYOLMuQHY3xwjzQ182KXnS2/9iaLQCeqSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pCl3qDdw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pCl3qDdw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1731F000FF;
	Tue, 29 Sep 2026 11:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790682733;
	bh=7VHVIZhZKx8zcVH9Lu0Ek5UCRs5lpn49VgMxOPsJw30=;
	h=Subject:To:Cc:From:Date;
	b=pCl3qDdwsMgTZ34pedy3A+GCXt8h3MhzSQnBf1vyx5HY6H2LwWZqTcsD+a/5vgPiv
	 tx3EAtTn5JwtYF+0j592nLGWvvteWb2emZ41rXBwvIOdd4Y2EmFeU/sAPGIIx9KeRG
	 vzsV/LufK3rcQXmgZuDFQA+UuUmbbFW6CqgVz/xo=
Subject: FAILED: patch "[PATCH] smb: client: delete compound mids on send failure before" failed to apply to 5.10-stable tree
To: adarshdas950@gmail.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 13:52:01 +0200
Message-ID: <2026092901-extending-vineyard-ce48@gregkh>
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
git cherry-pick -x 8f6f8a48399f82f4a83f7b9f25b9707e0062a4f9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092901-extending-vineyard-ce48@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8f6f8a48399f82f4a83f7b9f25b9707e0062a4f9 Mon Sep 17 00:00:00 2001
From: Adarsh Das <adarshdas950@gmail.com>
Date: Sat, 19 Sep 2026 16:27:32 +0530
Subject: [PATCH] smb: client: delete compound mids on send failure before
 unlock

When sending a compound request fails, smb_send_rqst() kicks off a
reconnect. compound_send_recv() still has those mids on pending_mid_q,
but it unlocks the server without removing them first.

During reconnect, cifs_abort_connection() walks pending_mid_q and runs
each mid callback. With no response yet, those callbacks return credits
and drop in_flight. Then compound_send_recv()'s send-error path returns
the same credits again. in_flight ends up decremented twice and
smb2_add_credits() WARNs.

syzbot hits this during SMB2_negotiate when the socket send fails.

cifs_call_async() already calls delete_mid() before unlock on send
failure. Do the same for compound chains and set cancelled_mid[] so the
out: path does not delete them again.

Fixes: ee258d79159a ("CIFS: Move credit processing to mid callbacks for SMB3")
Reported-by: syzbot+eeb58d2197d88720a228@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/6a727d22.40259c87.584f4.04ce.GAE@google.com
Tested-by: syzbot+eeb58d2197d88720a228@syzkaller.appspotmail.com
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Adarsh Das <adarshdas950@gmail.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>

diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index e266859818a4..7df5b3447aea 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -965,6 +965,10 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 	if (rc < 0) {
 		revert_current_mid(server, num_rqst);
 		server->sequence_number -= 2;
+		for (i = 0; i < num_rqst; i++) {
+			delete_mid(server, mid[i]);
+			cancelled_mid[i] = true;
+		}
 	}
 
 	cifs_server_unlock(server);

