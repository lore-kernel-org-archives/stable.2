Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com [74.125.229.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC693B8934
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 06:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790489807; cv=none; b=SZtENyvzulErkjBoZaSsgXwNAGPkps48Vpp7kQWVA/qjPlbHnDJYKmpLAhsgg/3vcRjaPFbXsTzCFtnIL9Rnf0O266QOD1q6hURuiK6Jt1t1VDvRqAaA5FYFpQmAR0M/8T3hWwsI3/QVifPGKwv1Qxle8q21rG+/74l4EEu3tjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790489807; c=relaxed/simple;
	bh=HrPsYSSx5VmtLkvtJnoxPKv7jbfJp6G89sQoqK7ven8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y2EevM/o7IDKaygzfHMqn1ExrMARLa0c5E/q1Rq84xJIVoJ6Lgze3VlAN/WoqzQKoXhYddixBLq3u+uyAL6oq0clNPZgaaaqE0n/7TI+UJ1syhYH6a5Pci+MZZKEYlZOlUE6io7U65BhI0HnRcJkFJk3FsddSlj9VjvNB3uN50M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MiyJwyRH; arc=none smtp.client-ip=74.125.229.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiyJwyRH"
Received: by mail-dy2-f12.google.com with SMTP id 5a478bee46e88-3396cec93b6so2539177eec.3
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 23:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790489804; x=1791094604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Me4JDrM3+ZMJhCrg6dCaSLfF95gdFZGC/6Q6sNMJj90=;
        b=MiyJwyRHvp0jvU5mZxJCBepFdSQWE0qme6lKW42AoflreRN6p6EXaFT8GdD3d4w3Gg
         WCyKYvHuFywAdbceQAk5prbucBddfTCQudaMzFaCccuWV0vTy9vFIw+PTqdQGVq16Rvw
         KdcYs6CdPN/HSYv1Dl78T5/Y3OtTg1SYflEwLuRyCfist2PtytC2TnbXn0fzqhIk2H5p
         b2KM4iddpbu3QTx7plk/up6qF5cZVtIJD5CJB1VQN46octcHH6W1y7tirPycytcTmCoZ
         skNbVjGbWhB/8LIByt0mVzWyMxsiXXvsDiBoyqnQA5iNgMDnCHHjjUOE1S3VaneapMsl
         KZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790489804; x=1791094604;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Me4JDrM3+ZMJhCrg6dCaSLfF95gdFZGC/6Q6sNMJj90=;
        b=MWCReJsRrYQIgdQZ7loI5Aj8IjVErhX2Jm74r5eSA0dvMp5HLlRMytTI2PaZYpVykq
         gtKgRqIlY0WbHLd/BhONh6GgCrHLTrTZJZpULYwBR0Wk3AINXey1qxJeUhKIINRBH7ur
         QXO1oJe9Pt/q3KSkYYnM0xlvwIWlfo3FZtRjZbXe3/SXWak/ddMGaPJgtaDjOfO2VY86
         RgFrDhvYLaeiHDPMWhODBVOqxcaFxgH1UupEQwKjkLKlAdo/mg3PqKLzRLqYKiOTFWre
         dbD13jWCwJpObEzdyRqpS4gYRLgeAH5+j6hPdzHAg8ySxuolEA6z3NF+i/G7pUVDAR1L
         4+Xw==
X-Forwarded-Encrypted: i=1; AKwUvBzKrLILcO4g01AUgxxYAO/usoVRxPwShQ3yJ1/lvK0Rb9HnStI3ZGM/XBB8WRDO9eZTzlKRLjY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIZ1A1bJWcGHo2IVmgg7sqlxL8ssJXYG65DFydoHtMJc13COVc1
	B+nn+ZyuuchB915qQIdIRKSqDrPgoMus3y3nczR837UVd9fUmwgp6rQi
X-Gm-Gg: AYBFou0KYAS3jLYnthdd4HBDze0F5qRLq6AZCDQMxEIjDApolsIHlZS09HEjFcln+9x
	X8OIhigYm4dKSQoKEguk4IHLbwYMFoi0VaMa/juc1sUJB+YVn4y7Oj/zT1kpUkjY4ImsHXL/NHE
	/VuoEp79UgZ7fDxGAUKiqYsB0pdxu4MKi1i3JM0dRjccoD8+K1+XKssX5A+iFardGIMXNT32oWH
	pTGlBHeF80Vfp8A8w4/EHZI/NgmNUwujIfvQJACfzLBRJHQxDiKREHbCol+/m5rxGtfiTI0XMoy
	VrEOqI/GfyjeE2lofw0IJIpJV0stRcjKakzD8JZutREsXsqbQNTAD5Tn/ry/qMv7VM4Fx62Hhy+
	wJfKaobBzi6oV4ZubzgHZgDUPn7aGe7NYc/a9+JPufeTUPy1Qcf8xZRHo02BpkWoEgKD6QAw6R9
	qpvyrCOsBOrQl+BZMW5mZihq100jT0afqGe3HQKvbnxtkvWRMgxM/H+DxJJcgMq0uWSA==
X-Received: by 2002:a05:7301:29b0:b0:343:9eb1:9940 with SMTP id 5a478bee46e88-3439eb1a517mr3091945eec.26.1790489802746;
        Sat, 26 Sep 2026 23:16:42 -0700 (PDT)
Received: from localhost ([8.219.239.189])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3444fd04d93sm2182244eec.12.2026.09.26.23.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 23:16:41 -0700 (PDT)
From: Dairui Zhang <zhangdairui@gmail.com>
To: linux-cifs@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Dairui Zhang <zhangdairui@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: verify transform SessionId matches the decrypted header
Date: Sun, 27 Sep 2026 14:16:39 +0800
Message-ID: <20260927061639.1722520-1-zhangdairui@gmail.com>
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

