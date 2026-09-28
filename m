Received: from mail-dy2-f41.google.com (mail-dy2-f41.google.com [74.125.229.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E8649EC77
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612444; cv=none; b=ouf4H5BYgVgjLxyRmAjgVcoUHk7pcWvL32k4Yd1BJJ0OjLtoj7QiOrkNutVTbbKJMZTRg7ehK9Ya0hr89VG8i6F5YKsBrqsR9HN1nqql6R5nswUWTgtSEKshMd3Hcmog+PWieiz7v+YsrgFkvoaSb9gHLdRMno656v+AiCzZBqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612444; c=relaxed/simple;
	bh=vs01MtfEVBiTmJkI3GpvJwZkshOrLmwv+qiFKh+6pNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B7j12CVrQD0ZQ23Q5e7MvXXlCjcO6JYro2sNYqxeu/9FCSqm7SZ3tl4EM/CQOXFB++sJ88WAjAQJboptQIRCi+d8TBJzusBAKdLB+RwvOh826WYX9NXyIf9KoP1SY4uyopX0k30vrNFqz9iLXB6V1KZoaEsiHQoDIv3m9Lqi3ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTjBPO+8; arc=none smtp.client-ip=74.125.229.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTjBPO+8"
Received: by mail-dy2-f41.google.com with SMTP id 5a478bee46e88-347327e3aeaso1320676eec.3
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 09:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790612442; x=1791217242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=drEwMPfBNK7Qvk+gxJqEf+fPVQFTEJ4sYjTDfDQ8114=;
        b=WTjBPO+8PnX7N4Eplp1HZFBZWWoX07t8H1Zgs/7N7Wsoc7/QUltpR3+kAVokwTVnS1
         7nNUt9XG5WSbJTtPwOFq7rO32Sh7Ug7ccCqNDQzWdP/2sq54OIScsezsNp3dv80VzQMq
         b3f7h3YePsbD4pOiCQsYd9cCkAfOgU6pYxXASH2fzbuiwoWFYjsZ4M/E6LiNPmqfNHon
         XvCnmR9Dkju4FDdPuyvizL5OZQyJkIPrHcOMxcCL5XYR0zMD6Ej+Rc1bukt/Wu6gs9HD
         Dte4zn6+zfeGoaukTB+j2j2dbW0j6/GQxjhI0+eW3dgbCXKBJ0JvMY5JFIkTMcKTKx1H
         31pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612442; x=1791217242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=drEwMPfBNK7Qvk+gxJqEf+fPVQFTEJ4sYjTDfDQ8114=;
        b=uR7Iem0XjY0ni83jrMFLqt69aqlapAYZQZ0xukpNwoBpsQ3JkVuu+RR1kL/BLr6hzp
         FlL2yMHUmpo4/et9NTDJ0SPCcFofZcUoaLqh1Ge40ldFDiBTKImX8o/fu+dXSwpEFJVF
         wteRJTa00BAMTISSt19rAQR6pGWt+ULNzLfnk31YDQ1odTniuu9RkyhN1Ni5i59sAxgd
         ADtHMxa1HeWYVTlWTEuFdVIZcj+5CXJAN2DUR0BGUlJL/amgbUQKvy/TKTdK7+GUtPbP
         gOQViyTpRt+HGoFoMdzCWnJtm55jqC20sYSsuJnIcNvf/Btvo01ILPvMwazmtcAgpnp8
         faAw==
X-Gm-Message-State: AFq9FYKbeGA0HeW8V3ttI63GVrdpO4E0SyclP5lknS38mYlkrDfhr0hq
	eotI73rJN6/eDcTLuTFCwdAxNMZaAYibFxrWN62/DtOxG6+Xl8R28nUZVuRzc7gv8fY/JA==
X-Gm-Gg: AYBFou3J134tzraTsJ+Uj4UOc4/f7/uoA5IaNiagvGVjR/i46LXyp6sy3bjFJvWQyaq
	3VlV1fR5aFNG+eq1JJ8pWdccnTSl0PWcdI6qgONbUNYoVCFlK4OoaSZUq3eeegFgfNmr002FFjl
	SzrKOhuqVwd+gS2/l5hMGIkDVL9XggMrzNfqjHeXAcZeryCX7GS5ZCYpJBxRbpJD+Q3jRT8hsX4
	UGssbScpe3ihYAlSJoQj+c/gk/l6N5cJuEPFksddPxdDvm3Mq6eBoLO3h+N18OI6V6DQFH7HHVx
	l3PqkTYdJmqlQJI6HU5kM0YXm6wF2lW0gKS9g8zQ68xCyH4LboP/VZeayzpWBJD6XIRm3L8w4ri
	A7j7pzHZs+DJ7g12lELyWf8H30EzPGG4IY0uT9AoBIaGoqYUmWkd2TOIRw96zMhFYK5YjHuEx5k
	+x0tels2szq8K1OsughevJYY8rE88URaQAi5OwYxa+C8rudlR4H0rUyISFBugvR4m9KmTxiAkvM
	nFJmA==
X-Received: by 2002:a05:7301:5804:b0:33b:e3c8:a757 with SMTP id 5a478bee46e88-342705b865cmr15581328eec.1.1790612440658;
        Mon, 28 Sep 2026 09:20:40 -0700 (PDT)
Received: from localhost ([8.219.185.173])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-342c9c245a7sm20917662eec.11.2026.09.28.09.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 09:20:40 -0700 (PDT)
From: Dairui Zhang <zhangdairui@gmail.com>
To: zhangdairui@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] ksmbd: verify transform SessionId matches the decrypted header
Date: Tue, 29 Sep 2026 00:20:36 +0800
Message-ID: <20260928162036.1829090-1-zhangdairui@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When an encrypted request comes in, the decryption key is picked by
the SessionId in the transform header, but the request is then
authorized under whatever session the decrypted inner header names.
Nothing ever compares the two, so on a connection with more than
one session a client can get a request decrypted with one session's
key and run it as another session. Encrypted requests are exempt
from signing too, so a valid AEAD tag is the only proof of session
identity, and it is checked against the wrong session.

MS-SMB2 says the server must check that the transform SessionId
matches the one in the decrypted SMB2 header and treat a mismatch
as a protocol error. Add that check before dispatching: the message
has to be at least one fixed SMB2 header, the first operation must
not set SMB2_FLAGS_RELATED_OPERATIONS and its SessionId must match
the transform SessionId, and every following operation in a
compound chain must either set RELATED or carry the same SessionId.
The usual ULLONG_MAX wildcard is accepted for those, same as the
existing compound session check, since it means the compound's
session and cannot be a different session. NextCommand offsets must
be 8-byte aligned and stay inside the message, and the accumulated
offset is guarded against u32 overflow.

While here I noticed there is no decompression step after
decryption, so an encrypted compression transform would be
dispatched as if it were a plain SMB2 message. ProtocolId is not
checked anywhere on that path, so a crafted transform could be made
to parse as a valid command under any session id in the payload.
Reject those for now; if encrypted compression ever comes back, the
decompression step has to be restored and the message needs the
same check after decompression.

Reported-by: Dairui Zhang <zhangdairui@gmail.com>
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Dairui Zhang <zhangdairui@gmail.com>
---
v3 -> v4:
- Rebase onto ksmbd-for-next as requested.
- Guard the chain-walk offset accumulation with
  check_add_overflow() before updating it, per Namjae's review
  (an invalid NextCommand could otherwise wrap the offset and loop).
- Reject encrypted compression transforms outright: for-next has no
  decompression step after decryption, and an undecoded transform
  would otherwise be dispatched as an attacker-crafted command
  (ProtocolId is not validated downstream).
- Exempt SessionId == ULLONG_MAX in subsequent compound operations,
  matching the existing compound session-check behavior (it means
  the compound's session and cannot be a confused deputy).
---
 fs/smb/server/smb2pdu.c | 85 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index bfa8954..ec47457 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -11634,6 +11634,64 @@ bool smb3_is_transform_hdr(void *buf)
 	return trhdr->ProtocolId == SMB2_TRANSFORM_PROTO_NUM;
 }
 
+/*
+ * Validate the session binding of a decrypted message against the
+ * encryption transform SessionId, per MS-SMB2:
+ *  - the message must be at least one fixed SMB2 header;
+ *  - the first operation must not set SMB2_FLAGS_RELATED_OPERATIONS
+ *    and its SessionId must match the transform SessionId;
+ *  - each following operation in a compound chain must either set
+ *    SMB2_FLAGS_RELATED_OPERATIONS or carry the same SessionId;
+ *  - NextCommand offsets must be 8-byte aligned, and the accumulated
+ *    offset must not overflow and must stay inside the message.
+ * Returns 0 on success, -ECONNABORTED on protocol error.
+ */
+static int ksmbd_check_transform_session(struct smb2_hdr *hdr,
+				  unsigned int msg_len, __u64 tr_sess_id)
+{
+	struct smb2_hdr *in_hdr = hdr;
+	bool first = true;
+	u32 off = 0, next;
+
+	if (msg_len < sizeof(struct smb2_hdr)) {
+		pr_err_ratelimited("Decrypted message is smaller than SMB2 header\n");
+		return -ECONNABORTED;
+	}
+
+	for (;;) {
+		if (first) {
+			if (in_hdr->Flags & SMB2_FLAGS_RELATED_OPERATIONS) {
+				pr_err_ratelimited("RELATED_OPERATIONS set on first operation\n");
+				return -ECONNABORTED;
+			}
+			if (le64_to_cpu(in_hdr->SessionId) != tr_sess_id) {
+				pr_err_ratelimited("SessionId mismatch between transform and inner header\n");
+				return -ECONNABORTED;
+			}
+			first = false;
+		} else if (!(in_hdr->Flags & SMB2_FLAGS_RELATED_OPERATIONS) &&
+			   le64_to_cpu(in_hdr->SessionId) != ULLONG_MAX &&
+			   le64_to_cpu(in_hdr->SessionId) != tr_sess_id) {
+			pr_err_ratelimited("SessionId mismatch in compound chain\n");
+			return -ECONNABORTED;
+		}
+
+		next = le32_to_cpu(in_hdr->NextCommand);
+		if (!next)
+			return 0;
+		if (next % 8) {
+			pr_err_ratelimited("NextCommand %u is not 8-byte aligned\n", next);
+			return -ECONNABORTED;
+		}
+		if (check_add_overflow(off, next, &off) ||
+		    off + sizeof(struct smb2_hdr) > msg_len) {
+			pr_err_ratelimited("NextCommand %u is out of the message\n", next);
+			return -ECONNABORTED;
+		}
+		in_hdr = (struct smb2_hdr *)((u8 *)hdr + off);
+	}
+}
+
 int smb3_decrypt_req(struct ksmbd_work *work)
 {
 	char *buf = work->request_buf;
@@ -11641,6 +11699,7 @@ int smb3_decrypt_req(struct ksmbd_work *work)
 	struct kvec iov[2];
 	int buf_data_size = pdu_length - sizeof(struct smb2_transform_hdr);
 	struct smb2_transform_hdr *tr_hdr = smb_get_msg(buf);
+	__le32 proto;
 	int rc = 0;
 
 	if (pdu_length < sizeof(struct smb2_transform_hdr) ||
@@ -11663,6 +11722,32 @@ int smb3_decrypt_req(struct ksmbd_work *work)
 	if (rc)
 		return rc;
 
+	/*
+	 * The decryption key is selected by the transform header SessionId,
+	 * while the request is authorized under the session named in the
+	 * decrypted inner header. Per MS-SMB2 the two must match, so
+	 * validate the decrypted message before dispatching it.
+	 */
+	proto = ((struct smb2_hdr *)iov[1].iov_base)->ProtocolId;
+	if (proto == SMB2_PROTO_NUMBER) {
+		rc = ksmbd_check_transform_session(
+				(struct smb2_hdr *)iov[1].iov_base,
+				buf_data_size,
+				le64_to_cpu(tr_hdr->SessionId));
+		if (rc)
+			return rc;
+	} else if (proto == SMB2_COMPRESSION_TRANSFORM_ID) {
+		/*
+		 * There is no decompression step after decryption, so a
+		 * compression transform would be dispatched as if it were
+		 * an SMB2 message. ProtocolId is not checked on that path,
+		 * so a crafted transform could be made to run as a valid
+		 * command under any session id in the payload.
+		 */
+		pr_err_ratelimited("Encrypted compression transform is not supported\n");
+		return -ECONNABORTED;
+	}
+
 	memmove(buf + 4, iov[1].iov_base, buf_data_size);
 	*(__be32 *)buf = cpu_to_be32(buf_data_size);
 
-- 
2.53.0

