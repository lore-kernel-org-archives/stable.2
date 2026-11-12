Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498150;
	b=tBbo2Mz4wdWDcpWDCFP0FaGsEJUFh7Ri1GhU2rA0fxtIGU9zdEkkk4KATJ6mZf3zK2Hj
	 sbOgxsgR5dGIEXPY/Ag7qyyTYlchM0uveQRlYosMfQcxLc0YmsenzLVySG2DslTtax4tl
	 +s7VnT4Kqd1ZOlSQVCWNikv9Sxpt959A9KzmY+EkK6YWTZfaWz3ZeH6dpH5eZoGetimNk
	 HSy1BX0oxLUHd7cV8y851EsMIiYmHk51Hhb7mp8ZUaZW2u+Zh17svJyLA98eWtHq7vskg
	 JVPDrLTRknYu1leVF8ttYe4Qh4L+jqpVupewYdn1BKmSUOd4SsC508j7UL/f0FdFEEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498150;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HBLCGcqufQIhkN3sBdqHjkVXfZZ4ZTmimDtIq4+w0iU=;
	b=Ic0Y5/knYQ67eLBVTZfzjim8DVJ0wJE7CebIOOBjDjylxkqSqmVq4/CiVUcfYvfqlOp/
	 vVpWRFyzlawERkhyTlN0SdEz2hOoO4T9eAOUjPluAZ4FqNA5/CFxTmZRS5bkY4WqOwZTK
	 vmD65OKgCwJjecotUxNP3iy+NOIvlAEBO/vXAydw3Ifr2dQnKUZWG9ReBAMJSG/zAz795
	 +K/VGGDiqujAPphFJfJgnA5Gciim7bbsNFQIkhqteqcvIH71iOTHZ6xiQAZtL0dN4mkZx
	 YdyS8lzkWDcj53MS2SZeWBpXWF4IhHvmxk2H7rUouPUdfbCm4VYpOvwoqI0VqiBBZxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q0BCfTY5;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CD060A2624
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 15:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7CD060A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=q0BCfTY5
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b6399ebb41so3900140b3a.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 07:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794498149; x=1795102949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HBLCGcqufQIhkN3sBdqHjkVXfZZ4ZTmimDtIq4+w0iU=;
        b=q0BCfTY5Rtk/u+c1WRC+vhl5bYaNgeAz/F0fVXViwEGncWv1eFzIWRapxJ7b/nGHcg
         74ySBPr8UY4G6hDI0KvwNEYmG9+UAv911kQUjyqQj6HJzTZkFsN8Tcca/S43Wfw8QCjT
         9kelHhqR+Ri5DO6izPoCKHpuHR6L/kNsCEaLwMHNboygQtruOQMH7ozYh/BvKzck/AGS
         U88L3vAqjkBVMYVXua5bAvX+T0mTNUOFlkJPWE6VNlpqA643S/gpfk/nhd1fnzGSH13q
         PQw1pvC5boWSzTl+05NCUpU1Y/k3Ld+qJUlOGeC6DThi/u6i7+oVtfnTvlX2b5b0wG58
         vY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498149; x=1795102949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HBLCGcqufQIhkN3sBdqHjkVXfZZ4ZTmimDtIq4+w0iU=;
        b=2z6S7H8eLqqflukCSPCBOgHIWg3bEax0YtxZ1qE10vfEyfloEWdHJ3J7mcT3QpRdYJ
         rKqvEXE5+eFunancJhmO7WJ5wxFcADSTx9QaJn/tNgs2p0dzj4PbIuJnJHvKLlhlpyNw
         UGEU73ShCh66jmCb9dgDxPvIs705FWJRy7Agle4M+ieGHkCuXgDTdY6VZNCxThYDdpSJ
         C3D6gJD15gJK/SbTVYUR1yPeG+bDau8LMnPKfFk6ojHMmEyce1DLNhi8wrsp+JtPvGPc
         BxsxPtjEih8WO89DN9LnqFc3N7vB2K0MHXGpWRj5PyukKMj3ZiG9miXqlTjbeCsvwiM2
         JERQ==
X-Forwarded-Encrypted: i=1; AL+hErGoaYoVgrZK1W/nuDuMP64shubSwqQ4YvnFB4mKBBCtQ88yB/9w5vUPVZo8imUz4V6OTG7/gpw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9fv714sKSO8aD/FgPD7gOwZQwAJPgvY++l81gojiCtrM2gRjl3
	pEUku0n9NZBTE5rNk6roTymxJXnmYCs2Awn0EW2IlNRMvh9/6wI3jPMA
X-Gm-Gg: AYBFou0UHxnrjds7Te6DCmPHNLwqNFu1cVpWh9eJ96VMUHPQxhua7iekdZ+TFBEOG2g
	6lIQBIdeV3b0oenFclWnPEe9IeF25jlksZlmLtml1evAZlFUzKXof+xnrOGKzQSeNMsjI+oiPvI
	u0B03leO23Xxqg1g1n6Xfjt+BjZhWcsGGXnyVTyfwjIIzJZkDh6oALkmWP9R59Q20IzpWCcOVq/
	kIqM4pb8zX55fRZubti+mu47GY/c4b7D9N10li1qB0Qv/U+h+i2zlwXDD9XZwlH1VU5i2/XTce1
	hZPsuNJ14NpbdhWg8UypJYyrygbX5PXzZgwmCB00dvgjt5mT7M9kTCJjcJYqJ1NawReAUAmcIMt
	5rxEJTgE4sX61xH+k/LY/F2e0xmDYuTxZlVsIls2QZh5d5O0HRcY+CyUdyAyzD9I/dIw5C6zwJ1
	TC5/31S8c7QQL6IiJhnud0vA+4uZ6ZN5GmNZmu3i4Unql0cNLD4QBcgIo3uu2m3TgmQmY4MtYTn
	JAJmwTt8vgrQ8MBrRWblI3Znkdt6OAI1lcZzys27bFiV28ynNZmFbk6qPWQJDKGLZKFivwsIlU4
	1C6LaOsY9m9n69RFxsyR2sk/n2iNpQzq4LkOyvfBVs/vcLPxsP3zbLjSU1UOvwX9/aj6FjU4WP2
	X/qUI+CH+0wM8V3JeegSrIfmTtTg=
X-Received: by 2002:a05:6a21:6450:b0:3e2:86b6:9be8 with SMTP id adf61e73a8af0-3f2fe0a8506mr5804970637.35.1794498149028;
        Thu, 12 Nov 2026 07:42:29 -0800 (PST)
Received: from localhost.localdomain ([2405:9800:b901:33ad:21c4:c32f:67c1:d87c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de3619sm3790596b3a.5.2026.11.12.07.42.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 07:42:28 -0800 (PST)
From: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
To: linkinjeon@kernel.org,
	stfrench@microsoft.com
Cc: icb@fastmail.org,
	senozhatsky@chromium.org,
	tom@talpey.com,
	chenxiaosong@chenxiaosong.com,
	ematsumiya@suse.de,
	lsahlber@redhat.com,
	hyc.lee@gmail.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michail Andreas Michalopoulos <mike.michalo@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v6 5/8] ksmbd: check a request before signing STATUS_NETWORK_SESSION_EXPIRED
Date: Thu, 12 Nov 2026 22:41:52 +0700
Message-ID: <20261112154155.20255-6-mike.michalo@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112154155.20255-1-mike.michalo@gmail.com>
References: <20261112154155.20255-1-mike.michalo@gmail.com>
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

When a session's Kerberos ticket has expired, smb2_check_user_session()
returns -EKEYEXPIRED and __handle_ksmbd_work() signs the
STATUS_NETWORK_SESSION_EXPIRED response if the request has
SMB2_FLAGS_SIGNED set. This happens before __process_request(), which
is where the MessageId and the request signature are checked. So the
response is signed with the session's key for a request whose
signature was never verified, at a MessageId that was never checked.

Anyone who can inject requests into the connection can then get
responses signed with that key at MessageIds of their choice: a
signing oracle. A Kerberos reauthentication keeps the session's keys, so
the effect lasts for the rest of the session.

MS-SMB2 checks the MessageId (3.3.5.2.3) and the signature (3.3.5.2.4)
before the session (3.3.5.2.9). Do the same: sign the response only if
the request passes both checks, and otherwise answer with an unsigned
STATUS_INVALID_PARAMETER or STATUS_ACCESS_DENIED, as
__process_request() does.

For a later command of a compound, the response that is current at this
point is still the previous one, so the old code re-signed that response
instead. Leave the expired response of such a command unsigned.

An AI assistant was used to draft the patch and as an independent
reviewer.

Fixes: a47634cd729b ("ksmbd: expire SMB sessions when Kerberos tickets expire")
Reported-by: Ian Bridges <icb@fastmail.org>
Cc: stable@vger.kernel.org
Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
---
 fs/smb/server/server.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 51aa981bcef4e..ca0c78447f454 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -107,6 +107,32 @@ static inline int check_conn_state(struct ksmbd_work *work)
 	return 0;
 }
 
+/*
+ * The keys of a session whose Kerberos ticket has expired are still valid,
+ * so STATUS_NETWORK_SESSION_EXPIRED is signed. Check the MessageId and the
+ * signature first (MS-SMB2 3.3.5.2.3 and 3.3.5.2.4), so that the key never
+ * signs a response to a request it did not sign.
+ */
+static void ksmbd_sign_expired_rsp(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+
+	/*
+	 * For a later command of a compound, the current response is still
+	 * the previous one here, so signing would corrupt that response.
+	 * Leave this one unsigned.
+	 */
+	if (work->next_smb2_rcv_hdr_off)
+		return;
+
+	if (ksmbd_verify_smb_message(work))
+		conn->ops->set_rsp_status(work, STATUS_INVALID_PARAMETER);
+	else if (!conn->ops->check_sign_req(work))
+		conn->ops->set_rsp_status(work, STATUS_ACCESS_DENIED);
+	else
+		conn->ops->set_sign_rsp(work);
+}
+
 #define SERVER_HANDLER_CONTINUE		0
 #define SERVER_HANDLER_ABORT		1
 
@@ -265,7 +291,7 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 					rsp_hdr = ksmbd_resp_buf_curr(work);
 					if (rc == -EKEYEXPIRED && work->sess &&
 					    conn->ops->set_sign_rsp)
-						conn->ops->set_sign_rsp(work);
+						ksmbd_sign_expired_rsp(work);
 					else
 						rsp_hdr->Flags |= SMB2_FLAGS_SIGNED;
 				}
-- 
2.43.0

