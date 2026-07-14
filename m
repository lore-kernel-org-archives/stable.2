Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE96542BC54
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 22:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784066651; cv=none; b=dg46aDBBpETotDeBCoI1bEPELvIWn+T6g3vOsQxFDjexu+8qcu72TlWVZovT6lBkYljum0LsnTXayEqfSWtELErmOBqkm7rTORm6FfdnqopL30bW4f0sRiAwdqPH2ZQTgfyF7qDaHlN4D2gJC2/9A6G19gGza4PwWA/ks2AODHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784066651; c=relaxed/simple;
	bh=5AN8izFxlLp6HYIKuDRduQHExptF5GNcdV+d3QrX/jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PknH9X+nR2YdcUTuAyjwAdI6Q4P+MpAnGyqxOtcmJBqjXxCmu5/LxGtESBcTTm+Niz6KIHT347kMSUGUZySNIumoaEbTzM/A10YyV5dvmLdsNj2HOnRfzLSlNcbWnpr3OwMTfMzTIJaD4OQTqYg1xnQHROaiwvDFjYBCepuWdjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaAmTRRR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaAmTRRR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073D51F00A3E;
	Tue, 14 Jul 2026 22:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784066649;
	bh=7IG7A2iUB6LkXWnrjCMOwrEtfTvo09iHh+wy73I0v1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FaAmTRRRVumMdB5hEM65tH7qR0lHvJu6QwE81VucG4A7yGPMW2SKWpk+oKTVcs9DA
	 S/DM7YLvN3viida/5RtBQ7AAOBA0Y5ENg0pzEheZm4SI7FyJM0vcUNnn1TRuYnaoPH
	 Xmx05d0wvGYP37weN8nN7VEAbI23bjy/xsMj8kUqo6Kp0GcvGdbDgreksiEiupqF0b
	 n0dcgUrVs+4QGa6n8tF9IiXiXOWrAV/GzQUvDqPDLAVePtQx5loGrCqRL1cqysSGdq
	 WIFDeSk0M/6o9ck+ntiZQ1bqmzRr0Ej0L452fUsZHYXQpRP9h8Otcjl/U3Jo0GiZiQ
	 BZebhdgJdtqHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Enzo Matsumiya <ematsumiya@suse.de>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/5] smb2: small refactor in smb2_check_message()
Date: Tue, 14 Jul 2026 18:04:03 -0400
Message-ID: <20260714220405.3333589-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714220405.3333589-1-sashal@kernel.org>
References: <2026071312-blank-founding-5203@gregkh>
 <20260714220405.3333589-1-sashal@kernel.org>
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
index d4a54eecd432b4..a95b9d2318fa2e 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1012,19 +1012,18 @@ int
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
 
@@ -1039,9 +1038,9 @@ cifs_handle_standard(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 		return -1;
 
 	if (!mid)
-		return length;
+		return rc;
 
-	handle_mid(mid, server, buf, length);
+	handle_mid(mid, server, buf, rc);
 	return 0;
 }
 
diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index f6be821bb8bb5c..71923cda9cc502 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -136,15 +136,15 @@ static __u32 get_neg_ctxt_len(struct smb2_hdr *hdr, __u32 len,
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
@@ -158,7 +158,7 @@ smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *srvr)
 
 		/* decrypt frame now that it is completely read in */
 		spin_lock(&cifs_tcp_ses_lock);
-		list_for_each_entry(iter, &srvr->smb_ses_list, smb_ses_list) {
+		list_for_each_entry(iter, &server->smb_ses_list, smb_ses_list) {
 			if (iter->Suid == le64_to_cpu(thdr->SessionId)) {
 				ses = iter;
 				break;
@@ -225,30 +225,33 @@ smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *srvr)
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
@@ -257,12 +260,18 @@ smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *srvr)
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

