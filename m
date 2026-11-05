Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902425;
	b=H50AP1FIWaC+Es/nyWt1BMn4QwjKB3rygSsboTO8MeBqiJ5nf+wACglBhAqIPrcc7BvX
	 a6B29v1UmnzvQgKSpv+a77im2OGf4gEAlojpLZi9Uhs0o/63sGbntA2CgKrMCS92125js
	 DSmWpYWAiMc3L/TcIcsml4apDF3NQF6qnbD+rh9Elx7rOt5MSy43xA9ahKYsqSU679Bbs
	 gx3H1AiOj8q0JiQ0QFK4o+SJvrx/dgyeBXdWFpy0oQsa96yJItc5mSHNihNeKll6KFLyh
	 xFUK0MCanmliF+ixkoCopsfIhQpOorYhhbnCS8sOYg/aVZu+DfCNDv0ZgsTsThNEsDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902425;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RJ6adDlLDVxMK+RCqIFQr2Tr2SX9JNSJvqtnfx0ibBE=;
	b=lajdSbFzlV7JvRnsMF96xLwXQXIrj4MDTpJSiqk80ghpq+QDwEhrI4U/yW8/TFYVbSLv
	 S7tKPJyAN8+u/NoUK9kdqAwRjKkogGvSI3lj09fEKC2s966cdYufwL5ECp0X5lJBtx4jt
	 dy6NUuPKoPL1emSZ+Y4ANN/JVZoRh4e2XlhkPVVI+lGOiHvVzirOPmrxpPNAfb1V0MrF4
	 s+JDzlvL3qkM1jiRR72MbcbofIs3M0xUmM6tL/TAi9QYZ7yxJDyeNdTA7rj7khgXlkgbu
	 9ORj9rDts/4iFk9eaq2aRbOUueCckOzKrko1KCU8LkysHN8kI7gQ/+xg4/ZTkCmeooQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="I/LvY11a";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FBE606A32D
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 18:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I/LvY11a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 746151F0093A;
	Thu,  5 Nov 2026 18:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793902425;
	bh=RJ6adDlLDVxMK+RCqIFQr2Tr2SX9JNSJvqtnfx0ibBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I/LvY11aPjd2viVYbGWliS3Mme2WF7nXVRZeD1/EJNk61TJk5NdedgV1bZJ8TcKsg
	 ABPbkFKeMrH0bnA8ocuKsiW3/xPZtcVNXjvqaHjyCMkdEjTaacnQ59Vj2sCOr+PmFg
	 BzdBYfgKMzCr07F2+w5+1p+l4nZZbR8bgU7uxCpaE9nuWXdD6QxvsVmaO+Fn0tVNyM
	 6++t80jXAEqr49OU+LE01l6wUyqYwYwAucA///IMokwt9xWMn+vwxFCfWxdejvz1as
	 z159jMi/FXoqUlgK9Cvr+a8t3GPeNh/LAZkKOEohXN8HvlVi3GwYq8ahN9AEBd1wHE
	 fn5kF95HUZySA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] smb: client: reclaim credits for decrypted reads with no matching mid
Date: Thu,  5 Nov 2026 13:13:43 -0500
Message-ID: <20261105181325.2262054-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110440-baked-marvelous-fdf0@gregkh>
References: <2026110440-baked-marvelous-fdf0@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit 78f73985846465a25a7bd1d89904053661f3ca92 ]

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
[ sashal: adjusted prototype insertion context to preserve existing declaration formatting and extern keywords ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsproto.h | 1 +
 fs/smb/client/connect.c   | 3 +--
 fs/smb/client/smb2ops.c   | 6 ++++--
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 325408073888e..d47ad5d86b4b1 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -161,6 +161,7 @@ cifs_mark_tcp_ses_conns_for_reconnect(struct TCP_Server_Info *server,
 				      bool mark_smb_session);
 extern int cifs_reconnect(struct TCP_Server_Info *server,
 			  bool mark_smb_session);
+void smb2_add_credits_from_hdr(char *buffer, struct TCP_Server_Info *server);
 extern int checkSMB(char *buf, unsigned int len, struct TCP_Server_Info *srvr);
 extern bool is_valid_oplock_break(char *, struct TCP_Server_Info *);
 extern bool backup_cred(struct cifs_sb_info *);
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 2cbbbf0c93b80..cfe694eed0f67 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1225,8 +1225,7 @@ cifs_handle_standard(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 	return 0;
 }
 
-static void
-smb2_add_credits_from_hdr(char *buffer, struct TCP_Server_Info *server)
+void smb2_add_credits_from_hdr(char *buffer, struct TCP_Server_Info *server)
 {
 	struct smb2_hdr *shdr = (struct smb2_hdr *)buffer;
 	int scredits, in_flight;
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 7cf6419df037d..63e3c3082ab28 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -5256,9 +5256,10 @@ static void smb2_decrypt_offload(struct work_struct *work)
 
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
@@ -5381,6 +5382,7 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 	*mid = smb2_find_mid(server, buf);
 	if (*mid == NULL) {
 		cifs_dbg(FYI, "mid not found\n");
+		smb2_add_credits_from_hdr(buf, server);
 		rc = -1;
 	} else {
 		cifs_dbg(FYI, "mid found\n");
-- 
2.53.0

