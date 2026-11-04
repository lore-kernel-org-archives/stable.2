Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817223;
	b=njBxAuFEP4x1Eweerc5Y4Tw37ONgECdbIcPmccxggHdcpV4ORv9Ch8180VOBdyU0w4Lw
	 oK8JIGARRlxtRyJL1r9qo7om66iaeSMt+KbY3tl3QVWKzc2YjAdew5U1KJHTFLC0xKKBi
	 2WObIH3N0jPjW5g4H6yNERyODV3zm6sMDKqz8FhTrxude4g7dzNyk2FQvv1v/z7hk1/0R
	 uwNc3aYBwyiDPM20zRf/jg2bZuDSdvo6l+YDc6HPfOeBBF8Gej5M3Aj+PNxvHQhoSgrv4
	 j/S3J9xC17ZSXLoM6dsFwR8KuKhbKQg43J8kEAg8Q8S+4nfN7pQQ09RM05DUV7h9mJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817223;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gm9xk6iy+Z+05fMZVVLYKtS8UPvNG0bzD+mbvbZWrKQ=;
	b=hP6ZqhpWdK+1OiaWhQD92oDPuJyhP0lQGgQGGHkeJ5sDNY73QA/d18qD9kvQ1DS8XH3/
	 48OF4WWn8kWmC9fG62VwFnTW5oOIdQN3MzOG7jQnDnFEZbgeEg98rvFRNvVwDn15wemeI
	 uxrSeLXkOdb9pdwDWx6ALdwT+/Xlbc2AtIhS8azg0REav7JWS+0B7dCg1fCCUnMkVQpJ2
	 VIgrlEKnsATSB39tuRn2ByzTXAb47O3A8r6tFQ3xHo+3Mqt1cz9zQ5uRYw3KfzoVpKMKy
	 3pXRC3ICi984jERosVa1aQFAlFmvpkqVjfkiO0E7kRyz/+85zsW66bI56m51FJ+rCHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=oJaNRwQj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC9A606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=oJaNRwQj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386B51F00919;
	Wed,  4 Nov 2026 18:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793817222;
	bh=gm9xk6iy+Z+05fMZVVLYKtS8UPvNG0bzD+mbvbZWrKQ=;
	h=Subject:To:Cc:From:Date;
	b=oJaNRwQjFhodxehIp/Ke46MkBfAgCiX9Av55LJRqsjYO+1RZjUzaVWi+ADhTaJ2RN
	 l5dx6A8Wwlu6PWYTqigz89s3Ejo9VTvEMLL0fV6iQz8Ag9M5kVVylk5GS5+jbX5J9z
	 MVtgx3w2JHpYa3u/XS7xCPr5+oSsrKDcPkqhXfAg=
Subject: FAILED: patch "[PATCH] smb: client: reclaim credits for decrypted reads with no" failed to apply to 6.18-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,dhowells@redhat.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:33:40 -0500
Message-ID: <2026110440-baked-marvelous-fdf0@gregkh>
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


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 78f73985846465a25a7bd1d89904053661f3ca92
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110440-baked-marvelous-fdf0@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 78f73985846465a25a7bd1d89904053661f3ca92 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Thu, 15 Oct 2026 15:53:32 -0300
Subject: [PATCH] smb: client: reclaim credits for decrypted reads with no
 matching mid

When a decrypted SMB2 READ response carries a MessageId that matches no
outstanding request, both the inline receive_encrypted_read() and the
offloaded smb2_decrypt_offload() paths drop the frame without accounting
the credits the server granted in it.  The plaintext unknown-frame path in
cifs_demultiplex_thread() already reclaims them with
smb2_add_credits_from_hdr(), so encrypted reads leak credits that the
plaintext path would not.

This also happens for legitimate frames - e.g. a reply that arrives after
the client has timed out and dropped the mid - so over a long-lived
connection the client's credit count drifts down and can eventually starve
it of the ability to issue requests.  The frame is AEAD-authenticated, so
the granted credits in the decrypted header come from the real server and
are safe to apply.

Reclaim the credits from the decrypted header before dropping the frame,
and export smb2_add_credits_from_hdr() so the SMB2 receive paths can use it.

Fixes: c42a6abe3012 ("CIFS: Add capability to decrypt big read responses")
Fixes: 35cf94a39728 ("smb3: allow parallelizing decryption of reads")
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Reviewed-by: David Howells <dhowells@redhat.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Bharath SM <bharathsm@microsoft.com>
Cc: stable@vger.kernel.org

diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 7b9eca22281f..9c44d1d2ae20 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -131,6 +131,7 @@ void cifs_signal_cifsd_for_reconnect(struct TCP_Server_Info *server,
 void cifs_mark_tcp_ses_conns_for_reconnect(struct TCP_Server_Info *server,
 					   bool mark_smb_session);
 int cifs_reconnect(struct TCP_Server_Info *server, bool mark_smb_session);
+void smb2_add_credits_from_hdr(char *buffer, struct TCP_Server_Info *server);
 bool backup_cred(struct cifs_sb_info *cifs_sb);
 bool is_size_safe_to_change(struct cifsInodeInfo *cifsInode, __u64 end_of_file,
 			    bool from_readdir);
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index f46c37e9b3c7..c3614c077746 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1249,8 +1249,7 @@ cifs_handle_standard(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 	return 0;
 }
 
-static void
-smb2_add_credits_from_hdr(char *buffer, struct TCP_Server_Info *server)
+void smb2_add_credits_from_hdr(char *buffer, struct TCP_Server_Info *server)
 {
 	struct smb2_hdr *shdr = (struct smb2_hdr *)buffer;
 	int scredits, in_flight;
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index a0b9363ba89d..83d5c6a05ef6 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -5263,9 +5263,10 @@ static void smb2_decrypt_offload(struct work_struct *work)
 
 	dw->server->lstrp = jiffies;
 	mid = smb2_find_dequeue_mid(dw->server, dw->buf);
-	if (mid == NULL)
+	if (mid == NULL) {
 		cifs_dbg(FYI, "mid not found\n");
-	else {
+		smb2_add_credits_from_hdr(dw->buf, dw->server);
+	} else {
 		mid->decrypted = true;
 		rc = handle_read_data(dw->server, mid, dw->buf,
 				      dw->server->vals->read_rsp_size,
@@ -5396,6 +5397,7 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 	*mid = smb2_find_mid(server, buf);
 	if (*mid == NULL) {
 		cifs_dbg(FYI, "mid not found\n");
+		smb2_add_credits_from_hdr(buf, server);
 		rc = -1;
 	} else {
 		cifs_dbg(FYI, "mid found\n");

