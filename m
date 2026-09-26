Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFE22931F0
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790409750; cv=none; b=nFsd+IazdCoszkSA56woXmxiRykcaAKko0H1bVxagEd/Yl+ms6rwtnBZt7/vcAn71fE87F3F3qm7M4iFdHF6C3yXhd2NpQnqNXt4+gHpovNsUF45GZ5+1cRBhNDZqtjjJPEKM1cO+8iIj7aEsOX/6Orml5RdT3pbnzyp4yiy6c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790409750; c=relaxed/simple;
	bh=JO526X/6Tt2mXMMyzxnEn8I9inabf6bHTO7ljFpjf1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gu0UNNbpXqJd+I10iwR3YQq1bUeDEI0o3DFl2QiLXKcrOsYqRVHCe2z2ekKqflxpOAkoEOJt3mD+KH8+m1RlxLJcML8FToFd0w1jMtN0NJFltexj47v2coRr24H8qHvEIr6t019F+3tmIGMeKU/7Z46j+M8NY3ERffYoxGW8jSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wnq4v0xN; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wnq4v0xN"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0bcdf41a3so714282a91.2
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 01:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790409748; x=1791014548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1QOIpORY6Eh+rWA+8y7RMDhGXP2bTeo70K5JN02r+40=;
        b=Wnq4v0xNOWnDzD4ZSQiZqv41jmnb5WS2fguemQMuW9BI+zbaJnKuZbcq7owA81vEs2
         ugD0O99tUvkVpNy+uZRG2Tk4rcCTUYEmWGZPZwo89vP3eij5tt1tW2S6gE2w5MjlVgSQ
         +wcHFzHJZ2ql/8IU6PIJUDWiUOAvp9ZJ13DKVBpQyuwpH7Gz3SCcBKLHrrz9Tu/cQb/o
         niFHrCeQXtu6AHSKZgirdkMb6Ccaf1KsIQtcojUoUZ8JTPV3SPD+PrExAcoflAIwWiuh
         TFbVlzx45m6ZdD76zBFUAHnyKZht/qS+mynkLPsbxADZ/tYiljY11SJoEepFsQyd99jN
         fLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790409748; x=1791014548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1QOIpORY6Eh+rWA+8y7RMDhGXP2bTeo70K5JN02r+40=;
        b=gVIvw4xBgYqzr2KxyFG+f5timfkBf/J/pMkXovdeTgOUwFfI5HHHYgOPdoDGpeb3Wy
         WdJxmDTHh+3ViMrlabq0CPeqbupjMjt3S41WvYWCw7NwIOYI35UtF1sDGOGMcKyMPi4I
         7Ck7bGbeDhaaKkix3+cY/Bq1rek21YmdHtMZm1uiBUG/rBmLGzlJMTLS99wvkaFTgSmG
         YUzKPxzWa6JxWkGb4IbtY20RiCT4njizw0sHeNC/KCrcQC1mD3pqZJ6LAIo1c/cWPoCQ
         85+nxGkL5xht4dx+9/sDIQ1FKJUhoaCfpzGU9L7lKIpLYVaul1rrnuF62OshFZlsAXSN
         hKIA==
X-Forwarded-Encrypted: i=1; AKwUvBy2qTxNIl5J5vC1XdjVgAtd2tXsPpgof8UQ1yNxn0OeWE3072YrKksv/hw7MTSVTOINfTo/eHw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcNLaZ6yWtkBgfaYVgiKyVC46cYIwxpe8cOL6tPDJ/fsDWh8o2
	LiEIU0reQi1AsI0HLhlNFgbMtXVqNoUBXcv94Av/RUkO8VN9UkX8dgpe
X-Gm-Gg: AYBFou0n0/x6VwuJpUZM+T6WmpO2aou3SlJ3sFjOPc17H2GQt0fV/UE9ReVGFvwsN32
	ArRarh58Rjugk7kCNAyQ35BVEN2Vhe8Uv8OD8WwmsRyNqIMX/vKJgcs6dh6vf2D0X6UMHXxtAsQ
	0AdtVvp8vu4y50ia7WHn0nHMDOVDrrFsmAQxgOxOuTPn/UeYP1hmsYhCUNf0gUKIGWu+O+cLPdr
	Tyve5/yJIMjg2jT0AgP36+JhZMW/cWdFbrJetNiBGIiisNe5JssMkcmaDDuQOqDJ8LF6mki9OQ8
	5VlXIK9j/mUNJ4ZWENfNUolbeVN9Hh35KptUf6tcC1UPIzNTNxACHdY8d0em9IaDTtciLhcBT5B
	5pKDGqKKNY9THuSTlFkmWVE9RKJ91wik15grnOZiZ/pdTPmfjN7Ffu6vulsb+xjhIGG5jolA4kS
	uTQ9dFcsynotlyA+jOJn2IIrCFez2nI/YKM8BlWd3wC8/rLimOES1g6Rub4sLApjB9f/NEI9Q=
X-Received: by 2002:a17:90b:4c42:b0:39e:4c80:f680 with SMTP id 98e67ed59e1d1-3a098bb66d1mr7292603a91.31.1790409748275;
        Sat, 26 Sep 2026 01:02:28 -0700 (PDT)
Received: from localhost ([180.184.92.195])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9355e54sm8355171a91.5.2026.09.26.01.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 01:02:27 -0700 (PDT)
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
Date: Sat, 26 Sep 2026 16:02:24 +0800
Message-ID: <20260926080224.1671214-1-zhangdairui@gmail.com>
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
and drop the connection on mismatch.

The check only applies to plain SMB2 payloads; a compression
transform payload carries the session id only after decompression
and is left as-is for now.

Reported-by: Dairui Zhang <zhangdairui@gmail.com>
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Dairui Zhang <zhangdairui@gmail.com>
---
 fs/smb/server/smb2pdu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 4cf7083..e4cfbe6 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -10890,6 +10890,22 @@ int smb3_decrypt_req(struct ksmbd_work *work)
 	if (rc)
 		return rc;
 
+	/*
+	 * The decryption key is selected by the transform header SessionId,
+	 * while the request is authorized under the session named in the
+	 * decrypted inner header. Per MS-SMB2 the two must match; verify
+	 * that here and drop the connection on mismatch. A compression
+	 * transform payload carries the session id only after
+	 * decompression, so it is not covered by this check.
+	 */
+	if (((struct smb2_hdr *)iov[1].iov_base)->ProtocolId ==
+	    SMB2_PROTO_NUMBER &&
+	    le64_to_cpu(tr_hdr->SessionId) !=
+	    le64_to_cpu(((struct smb2_hdr *)iov[1].iov_base)->SessionId)) {
+		pr_err_ratelimited("SessionId mismatch between transform and inner header\n");
+		return -ECONNABORTED;
+	}
+
 	/* Drop the AEAD authentication tag from the inner RFC1002 frame. */
 	memmove(buf + 4, iov[1].iov_base, original_msg_size);
 	*(__be32 *)buf = cpu_to_be32(original_msg_size);
-- 
2.53.0

