Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C294C77BE
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059348; cv=none; b=eoIHhtXePOMZcFlKzuLdPk0me5RbJC+LtgRojkZKao3fnez849Waaf+PGNSAdqlOfynz+wB6rznCmX4BJhmPh+fTUQQH6uY3yjGrYQhnLAY93igQrD8N/pXPVLTlLM2dBtGtBhvMqjdMywB7e/rL9d/8AT8nqN0anzteOyjIhiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059348; c=relaxed/simple;
	bh=OlVGFoZt9hhNAamMcIZJsg6XloxkkOpd+R4GmlB/jcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFCxBb49ILOjjUeu7zfUVPTO5tzx4hTQoR728GwiK/21VErqUZN8fmgXX1dmzGFKf+icNnial4KN69DQ8URtv5u7OrL7vhPzvgvzsh71n2ZL3dWCefwdP780l8BECOzm2TfnE2xsYTTxLYyI5IhmVTg3R4CLcr9msXtlPeHjpJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8X7+uzu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8X7+uzu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEC0A1F00AC4;
	Tue, 14 Jul 2026 20:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059339;
	bh=KnwQVLEYEHlb4BDY48vptng8MO8lcJE5iJc5ahSJ17c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K8X7+uzuAzGLun462nsF/456W8ehlVlCb8RGZ/CfvkAF6mJov2hV2UacCerfOKkL0
	 Nd2cWPS2M8yHrlQU3Fz/BLhqYcA/vy6iZAzSnvxvPaY9v7CufMQVy4zMdL20BT6Ngn
	 qfp0ba5dxhiarMfIf74tXm8TF/MiAkilief4+/kz2gxPi4xNMnS2YF4f+tQJgp9oQU
	 q16nFtY0hitEnXxLSGpcRXV9L0UWwk4ZWTxEbRzp5P2yD6lt39oFQSuDXVbZDhYhiF
	 Rn1hmVU/lTwKPXpOaSGARpXs7YOgpjZDF6bIreT2lkiX0jcbBf7jamHKx/GH68V0jg
	 xF99NJC5pB18w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Enzo Matsumiya <ematsumiya@suse.de>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/5] smb2: small refactor in smb2_check_message()
Date: Tue, 14 Jul 2026 16:02:13 -0400
Message-ID: <20260714200215.3152449-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714200215.3152449-1-sashal@kernel.org>
References: <2026071307-payment-valium-e77f@gregkh>
 <20260714200215.3152449-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Enzo Matsumiya <ematsumiya@suse.de>

[ Upstream commit da3847894fddc27ca95d5ac0012f444a77a5e0c3 ]

If the command is SMB2_IOCTL, OutputLength and OutputContext are
optional and can be zero, so return early and skip calculated length
check.

Move the mismatched length message to the end of the check, to avoid
unnecessary logs when the check was not a real miscalculation.

Also change the pr_warn_once() to a pr_warn() so we're sure to get a
log for the real mismatches.

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: 53b7c271f06b ("smb: client: restrict implied bcc[0] exemption to responses without data area")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/connect.c  | 13 ++++++-------
 fs/cifs/smb2misc.c | 47 +++++++++++++++++++++++++++-------------------
 2 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 6fca381353620a..e29314719bc26b 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -890,19 +890,18 @@ int
 cifs_handle_standard(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 {
 	char *buf = server->large_buf ? server->bigbuf : server->smallbuf;
-	int length;
+	int rc;
 
 	/*
 	 * We know that we received enough to get to the MID as we
 	 * checked the pdu_length earlier. Now check to see
-	 * if the rest of the header is OK. We borrow the length
-	 * var for the rest of the loop to avoid a new stack var.
+	 * if the rest of the header is OK.
 	 *
 	 * 48 bytes is enough to display the header and a little bit
 	 * into the payload for debugging purposes.
 	 */
-	length = server->ops->check_message(buf, server->total_read, server);
-	if (length != 0)
+	rc = server->ops->check_message(buf, server->total_read, server);
+	if (rc)
 		cifs_dump_mem("Bad SMB: ", buf,
 			min_t(unsigned int, server->total_read, 48));
 
@@ -917,9 +916,9 @@ cifs_handle_standard(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 		return -1;
 
 	if (!mid)
-		return length;
+		return rc;
 
-	handle_mid(mid, server, buf, length);
+	handle_mid(mid, server, buf, rc);
 	return 0;
 }
 
diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index ab20585db8c159..c24d3bcb565f17 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -132,15 +132,15 @@ static __u32 get_neg_ctxt_len(struct smb2_hdr *hdr, __u32 len,
 }
 
 int
-smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *srvr)
+smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *server)
 {
 	struct smb2_hdr *shdr = (struct smb2_hdr *)buf;
 	struct smb2_pdu *pdu = (struct smb2_pdu *)shdr;
-	__u64 mid;
-	__u32 clc_len;  /* calculated length */
-	int command;
-	int pdu_size = sizeof(struct smb2_pdu);
 	int hdr_size = sizeof(struct smb2_hdr);
+	int pdu_size = sizeof(struct smb2_pdu);
+	int command;
+	__u32 calc_len; /* calculated length */
+	__u64 mid;
 
 	/*
 	 * Add function to do table lookup of StructureSize by command
@@ -154,7 +154,7 @@ smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *srvr)
 
 		/* decrypt frame now that it is completely read in */
 		spin_lock(&cifs_tcp_ses_lock);
-		list_for_each_entry(iter, &srvr->smb_ses_list, smb_ses_list) {
+		list_for_each_entry(iter, &server->smb_ses_list, smb_ses_list) {
 			if (iter->Suid == le64_to_cpu(thdr->SessionId)) {
 				ses = iter;
 				break;
@@ -221,30 +221,33 @@ smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *srvr)
 		}
 	}
 
-	clc_len = smb2_calc_size(buf, srvr);
+	calc_len = smb2_calc_size(buf, server);
+
+	/* For SMB2_IOCTL, OutputOffset and OutputLength are optional, so might
+	 * be 0, and not a real miscalculation */
+	if (command == SMB2_IOCTL_HE && calc_len == 0)
+		return 0;
 
-	if (shdr->Command == SMB2_NEGOTIATE)
-		clc_len += get_neg_ctxt_len(shdr, len, clc_len);
+	if (command == SMB2_NEGOTIATE_HE)
+		calc_len += get_neg_ctxt_len(shdr, len, calc_len);
 
-	if (len != clc_len) {
-		cifs_dbg(FYI, "Calculated size %u length %u mismatch mid %llu\n",
-			 clc_len, len, mid);
+	if (len != calc_len) {
 		/* create failed on symlink */
 		if (command == SMB2_CREATE_HE &&
 		    shdr->Status == STATUS_STOPPED_ON_SYMLINK)
 			return 0;
 		/* Windows 7 server returns 24 bytes more */
-		if (clc_len + 24 == len && command == SMB2_OPLOCK_BREAK_HE)
+		if (calc_len + 24 == len && command == SMB2_OPLOCK_BREAK_HE)
 			return 0;
 		/* server can return one byte more due to implied bcc[0] */
-		if (clc_len == len + 1)
+		if (calc_len == len + 1)
 			return 0;
 
 		/*
 		 * Some windows servers (win2016) will pad also the final
 		 * PDU in a compound to 8 bytes.
 		 */
-		if (((clc_len + 7) & ~7) == len)
+		if (((calc_len + 7) & ~7) == len)
 			return 0;
 
 		/*
@@ -253,12 +256,18 @@ smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *srvr)
 		 * SMB2/SMB3 frame length (header + smb2 response specific data)
 		 * Some windows servers also pad up to 8 bytes when compounding.
 		 */
-		if (clc_len < len)
+		if (calc_len < len)
 			return 0;
 
-		pr_warn_once(
-			"srv rsp too short, len %d not %d. cmd:%d mid:%llu\n",
-			len, clc_len, command, mid);
+		/* Only log a message if len was really miscalculated */
+		if (unlikely(cifsFYI))
+			cifs_dbg(FYI, "Server response too short: calculated "
+				 "length %u doesn't match read length %u (cmd=%d, mid=%llu)\n",
+				 calc_len, len, command, mid);
+		else
+			pr_warn("Server response too short: calculated length "
+				"%u doesn't match read length %u (cmd=%d, mid=%llu)\n",
+				calc_len, len, command, mid);
 
 		return 1;
 	}
-- 
2.53.0

