Received: from mail-pj2-f20.google.com (mail-pj2-f20.google.com [74.125.227.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477BF19F137
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 06:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790489289; cv=none; b=RhB8s2TlehiWT8PfM7+jW2w84ho7NKOtAAQwsLOiuXPf372vPK/cADsxTfUuq4AH07XuIwd9AlCNMUE2CO/7ToxDUMssK5LXhbTlKebHQDIS9bdyGgBb83Ug1AL2p1G3nsQPI8XIHR3/XVWvcuGmDFHOMQf5RE/PJ1J5MyEYhYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790489289; c=relaxed/simple;
	bh=HrPsYSSx5VmtLkvtJnoxPKv7jbfJp6G89sQoqK7ven8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BnRlqSBlzq0giDZn3rkjYN7VwGC4mbUZiKg3gqW1unEMYHXiZmQgHtJcAi8gXMOEHUeyb6zlqlAVa4CJyKuY0horWcmt9ghCSE8KVIWOAPvR0Tg0yfEvp2DBcaGyp0Gg8Lcy8F1fI/swPOAVqttyFdZVltjUVOcjpUo/PQLANbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TdDUc9uO; arc=none smtp.client-ip=74.125.227.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TdDUc9uO"
Received: by mail-pj2-f20.google.com with SMTP id d9443c01a7336-2d747ed9866so14824115ad.2
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 23:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790489287; x=1791094087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Me4JDrM3+ZMJhCrg6dCaSLfF95gdFZGC/6Q6sNMJj90=;
        b=TdDUc9uOjWSi7eJYQL/ziTZDH7vCqdP3ROzyQ/brgxl5Q/W+AvIU5aTIDtJC2eNc6b
         3LOrSsu0Xr669hBv3DzO81EltpHuHHGv7Y8XHJRE0oCaHfif9KbT9yBVkpJccA76wXLk
         1QszDPPmWywD3LPNheztE87q/AqDDY8f59hXxuphBY7QXSp0YoVkX7afXHe/iAf6b689
         yxtDVwyaD8jC/MmNVzzgJMKawyvHDvMMnmzYmto3lqPM8qDy4Mxu5deB1uWdax3LlVQ0
         jXBDnCqeeOSLinKEkaS6/i6YhykPX0roYIIOoYZ3tV1oGu87Jy/qEc3tDvp3k00Q1w6e
         q2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790489287; x=1791094087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Me4JDrM3+ZMJhCrg6dCaSLfF95gdFZGC/6Q6sNMJj90=;
        b=n5cTJYkperTJ+gCoWEXJxnHm+k/PxKCripYExmozO8HkgQTrQ1I//mlkTjNf8HUj+Y
         KRj9fHqa5nG0UnRUA24V8Thwz7pPpsZW9uTJN5BhZPl2/go2tlwRf9e7TEgwRbwOrklQ
         R65DvJyFz1SDI6xLw15/6aZEwRSHXUX5x+102ijB2KHypJor6ZxGpobLXOGUMgPLrsdv
         XbUbWjy66WfOt1S+YrGrD5B2shuyejW/usiT0h55JxuySqZPQaxCNFhRn6kP5ABZRiIz
         6j2hnhcIGIs4h0bLC145gsC8qfTUZT9rLJcX/wdfof3lxTsfybZ66g4famTeTMiF/jW1
         uk1g==
X-Gm-Message-State: AFq9FYKn9JGNPOVCR7WGQI3+jb9aXZzw440nux+NLEpWeNlilLgnqRze
	gxCvkaIQDG5zQjzEs6BJDXCnLFCIR5f7G5iAKt5RykBmmFsXbALwAfZYOhGGVS454mXnMA==
X-Gm-Gg: AYBFou22w7zu4u9CcffMI24pCmaoShYf2zPoIecHHO1tKAl4iIJBJA5V8NXoYlajYNB
	hLWFqzLkLLjZ5/iO/dTD+rCUCH9dNAc4ETHAovkMaUFAHeTMbNte3VDzz/iOIKTKgJNtK6NYbjY
	aAnzPgaeZ5vdDQXfxz5Kx6aM35WA2EqHtTO41ZR/3QGK8nS/Uww3qE+GXxgTouwzBZlZca9UEUc
	Yu52xQqFlOM6w2MMDdwFxVNzEe/Ss4lSL5R2DnBEZBTgrxfviOFZz169E26Dbc6mP7kvRdA6UkX
	nbjMLLzR5ZfqICzm8KkQ6thGInr7VNyjrShuVtAlXCndLikqHeUHkwQtgMV3N2FU0GgM1UT/PmY
	vFkrQdC1h2Ka+KZvucM3c8jqUgXfou39YDAAScJa6JdRY5AS2DRYdA6FQfjOCWoQq+Kmz2o3gaX
	cKtrUNxve8wDByTeTdG0ioLo8kS4xdyZ4c8bI1lD0b7TExhMIHadvPfcQLZizk7XXJoQy4JMk=
X-Received: by 2002:a17:902:c406:b0:2dd:9b53:f9ba with SMTP id d9443c01a7336-2df7da5e366mr93775535ad.1.1790489287113;
        Sat, 26 Sep 2026 23:08:07 -0700 (PDT)
Received: from localhost ([180.184.47.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df90fc2e5fsm26662555ad.5.2026.09.26.23.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 23:08:06 -0700 (PDT)
From: Dairui Zhang <zhangdairui@gmail.com>
To: zhangdairui@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] ksmbd: verify transform SessionId matches the decrypted header
Date: Sun, 27 Sep 2026 14:06:52 +0800
Message-ID: <20260927060652.1721812-1-zhangdairui@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The decryption key for an encrypted request is selected by the
SessionId in the encryption transform header, but the request is
then authorized under the session named in the decrypted inner SMB2
header. Nothing compares the two, so on a connection carrying more
than one session a client can have a request decrypted with one
session's key and executed under another session's identity. Since
encrypted requests are also exempt from the signing requirement, the
AEAD tag is the only proof of session identity, and it is checked
against the wrong session.

Per MS-SMB2 the server must verify that the SessionId in the
transform header matches the one in the decrypted SMB2 header and
treat a mismatch as a protocol error. Compare them after decryption
and drop the connection on mismatch. When the encrypted payload is a
compression transform, the transform SessionId is saved and verified
against the decompressed SMB2 header instead, since a compression
transform header carries no SessionId.

Reported-by: Dairui Zhang <zhangdairui@gmail.com>
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Dairui Zhang <zhangdairui@gmail.com>
---
v1 -> v2:
- Also cover the compression-transform case, per Namjae's review:
  save the transform SessionId during decryption and check it
  against the decompressed SMB2 header.
- Reject a decrypted SMB2 message smaller than the fixed header
  before reading its SessionId (a crafted short OriginalMessageSize
  would otherwise make the check itself read out of bounds).
- v1: https://lore.kernel.org/linux-cifs/20260926080224.1671214-1-zhangdairui@gmail.com/
---
 fs/smb/server/compress.c   | 14 ++++++++++++++
 fs/smb/server/ksmbd_work.h |  4 ++++
 fs/smb/server/smb2pdu.c    | 25 +++++++++++++++++++++++++
 3 files changed, 43 insertions(+)

diff --git a/fs/smb/server/compress.c b/fs/smb/server/compress.c
index 5162fb8..1c5a070 100644
--- a/fs/smb/server/compress.c
+++ b/fs/smb/server/compress.c
@@ -125,6 +125,20 @@ int ksmbd_decompress_work_request(struct ksmbd_work *work)
 	if (rc)
 		return rc;
 
+	/*
+	 * The SessionId of the encryption transform header was saved
+	 * before the compression transform was parsed; the decompressed
+	 * SMB2 header must carry the same one. Per MS-SMB2 a mismatch is
+	 * a protocol error.
+	 */
+	if (work->tr_sess_id &&
+	    le64_to_cpu(((struct smb2_hdr *)smb_get_msg(out_buf))->SessionId) !=
+	    work->tr_sess_id) {
+		pr_err_ratelimited("SessionId mismatch between transform and decompressed header\n");
+		kvfree(out_buf);
+		return -ECONNABORTED;
+	}
+
 	kvfree(work->request_buf);
 	work->request_buf = out_buf;
 	return 0;
diff --git a/fs/smb/server/ksmbd_work.h b/fs/smb/server/ksmbd_work.h
index 5f1d3eb..3e8bf2a 100644
--- a/fs/smb/server/ksmbd_work.h
+++ b/fs/smb/server/ksmbd_work.h
@@ -82,6 +82,10 @@ struct ksmbd_work {
 	/* Contiguous SMB2 compression transform owned by this work item. */
 	void				*compress_buf;
 
+	/* SessionId from the encryption transform header, for the
+	 * post-decompression SessionId check. Zero when unset. */
+	__u64				tr_sess_id;
+
 	unsigned char			state;
 	/* No response for cancelled request */
 	bool                            send_no_response:1;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 4cf7083..9eb13a8 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -10860,6 +10860,7 @@ int smb3_decrypt_req(struct ksmbd_work *work)
 	unsigned int buf_data_size;
 	struct smb2_transform_hdr *tr_hdr = smb_get_msg(buf);
 	unsigned int original_msg_size;
+	__le32 proto;
 	int rc = 0;
 
 	if (pdu_length < sizeof(struct smb2_transform_hdr)) {
@@ -10890,6 +10891,30 @@ int smb3_decrypt_req(struct ksmbd_work *work)
 	if (rc)
 		return rc;
 
+	/*
+	 * The decryption key is selected by the transform header SessionId,
+	 * while the request is authorized under the session named in the
+	 * decrypted inner header. Per MS-SMB2 the two must match; verify
+	 * that here and drop the connection on mismatch. A compression
+	 * transform payload carries the session id only after
+	 * decompression, so save the transform SessionId for the check
+	 * after decompression instead.
+	 */
+	proto = ((struct smb2_hdr *)iov[1].iov_base)->ProtocolId;
+	if (proto == SMB2_PROTO_NUMBER) {
+		if (original_msg_size < sizeof(struct smb2_hdr)) {
+			pr_err_ratelimited("Decrypted SMB2 message is too small\n");
+			return -ECONNABORTED;
+		}
+		if (le64_to_cpu(tr_hdr->SessionId) !=
+		    le64_to_cpu(((struct smb2_hdr *)iov[1].iov_base)->SessionId)) {
+			pr_err_ratelimited("SessionId mismatch between transform and inner header\n");
+			return -ECONNABORTED;
+		}
+	} else if (proto == SMB2_COMPRESSION_TRANSFORM_ID) {
+		work->tr_sess_id = le64_to_cpu(tr_hdr->SessionId);
+	}
+
 	/* Drop the AEAD authentication tag from the inner RFC1002 frame. */
 	memmove(buf + 4, iov[1].iov_base, original_msg_size);
 	*(__be32 *)buf = cpu_to_be32(original_msg_size);
-- 
2.53.0

