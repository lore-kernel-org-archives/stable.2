Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817234;
	b=IzoDVTaBIZmnLsApkQiDZ4Pm8Wa9cbvt97VO4QT569S1ViKlD1XRJHBwApM2bQK8XWe7
	 3AWKC1t6sNmI0jTd1I5mb6TwspprfRrZcyRi3sOSbM5j1MBizqerZqLHKDtQvq0l5pzwk
	 YeJ6eAnd1VC6LOw0+/b0UJv7mcgpXs93yW6SsCT2Btpd/jPvpc0vOtcofj0B9ATvG+DZ3
	 90Vez8EqcJLvYY/0a0L2Ov9lDq5z+8csYHxUB07XFlJ4EIr+dFHWSCvFxP+FeXq71e0bv
	 U1gepO7xKaaK933/tS0WGhqjx3TOcQPrfJIp9r8PI/x6w96cwvyz7ItDd+JU+YiVGBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817234;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=aJbKpzQ5FwnkYHNaKLOcolRDN0KhbnGEg6en1d1TD44=;
	b=x9TYMm09EjOg303n+mqSMYF2M1PIKKC9EZb6xRN1vFm3h7+1YT3gOsFyaXAgreQATV4Y
	 u/csGDfC763bBhubb1G0U7oedmEz5dU3ki+FJW2Qj0bCCrHKKwGbQlL2VkNxAFC9vvX7x
	 Css325yCu1JYnk5gznLtTAyj12kGRhjlac8K1DXXM/HVB0SSQEbDwXHaaus/R1HogdYIS
	 fbyd3Q1ZhKHpstjjKfG+FBzqmNZ4+YZaNg4yUR5sWTkv0/fXwj1DezpYuaL8SzW35zScY
	 QkH2IvqoK+qbUF62RO7p/lxpcnzZG8D1mvZGfDJGY+NNzUfnXp2gZ9yqPMbBmrHf73g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zSK6WiK1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B23606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zSK6WiK1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC561F000C1;
	Wed,  4 Nov 2026 18:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793817234;
	bh=aJbKpzQ5FwnkYHNaKLOcolRDN0KhbnGEg6en1d1TD44=;
	h=Subject:To:Cc:From:Date;
	b=zSK6WiK1FK6/8d4XJOqfhFNyDT+kip/csmgfdmqboVJxUtRnpYqIV/E3FrPkrixlw
	 MWXZPx00V+fnw/Te/UbVHLnKrpTeG5zbiLBMoYNpFmSTe3cZMMRWxn37Iip4vEBB3f
	 y3h7NPWGcPvVieFRpYZkpyzt5J3HQ713NpyxzBvQ=
Subject: FAILED: patch "[PATCH] smb: client: reclaim credits for decrypted reads with no" failed to apply to 5.10-stable tree
To: pc@manguebit.org,bharathsm@microsoft.com,dhowells@redhat.com,linkinjeon@kernel.org,ronniesahlberg@gmail.com,sprasad@microsoft.com,tom@talpey.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:33:45 -0500
Message-ID: <2026110445-primal-lubricant-1cd6@gregkh>
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
git cherry-pick -x 78f73985846465a25a7bd1d89904053661f3ca92
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110445-primal-lubricant-1cd6@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

