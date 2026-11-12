Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458842;
	b=0N5Uds/4Um6QiOvwdQF36pi7P0l2sSN3WdYlc3KeWESgxJ90KJRaYLZG5asVJh7VMqqK
	 zp3YrE6gyAWBsrKJodVDXEsW+Iptz7BWZj2WyEstwKg5r4BbmJZtNUrzQYwTo5nEHdw+P
	 yjR027lOjfa6uD+U+/7qNjEXQNJ7JwYUYAIm1PDvySTFG/3gIIww6AhB/Y/fFMRiGfJmh
	 6lDXKJAZw5v7A1ivh66Th3/LkRwHpb56SQZtl5cPmY8hgZ9xJiiGqqEAyubvdD5+FT+nL
	 P+FFNw0vq2SZEoiy7vOEWcNWjiNbj4qYn+m3thKsYsYPRyJrFZV69QPgYth73s7hH6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HBLCGcqufQIhkN3sBdqHjkVXfZZ4ZTmimDtIq4+w0iU=;
	b=YsWlzACdUrXFdCJ2FZjGU3/bMNGxkZ7DRGOD9AOSYvdqdDZ6gEXVcW4i2L/8XInCZeFz
	 s8TfwXHxd7fI9eJsheSImF86/ZphgosgESa5DdSIjmX3Mgvfw1Lze+driqa0gwIWvjdtF
	 SukY2okOxLu8B1ZaSyTTXtekpGDxTOa4DhI2r2jXKZtvBmGEmQxf+h6TOOdwq6DYvzXDJ
	 a+8ex39T8Mli3QAPj4epoMQ8K9XuYMoJ1fGvnVFlQyoUqn9q3WqLsvpP0Y+kToMqDMAE6
	 GYWmM8J0pE15zPskDZEFP5XiLlChYNVPbKX51icpWri/InYsjnr7rbSYYkDejDTvoUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xh+OLvCP;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C916606A339
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C916606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xh+OLvCP
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so1890473c88.0
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 20:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794458840; x=1795063640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HBLCGcqufQIhkN3sBdqHjkVXfZZ4ZTmimDtIq4+w0iU=;
        b=Xh+OLvCPlLgl4eFIfpTLOuY4nuytx/msPDTuB7c6Urj9vS1TSnm/0RxeGI0eGL+u+8
         xgQffiVkq39/OpendSdKiGdPUpReKeb+FIMFzlgw63KuxCqmZ2+NYYy4LOD0TW2dVMBW
         gqNW8LgvpOZYtG1EIAHfUEeWxvWqnvE+Y4KKQ09+Ql9+eBMxqB0O3V6gGqkRHIDMW2+C
         1Iyrb66AZIqjtJWd4vUsAhYk/p19yJIbMKmDLAdJv6uSsV3Z+7apwjZ4wzb9rgzNFqeL
         4mKxbdL+8oJxUp9mjLltQrhZDq0H1y3zM84Eu3OY6ebBVXDJ7Y7diy7um5Rr9TlY9Afx
         jLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794458840; x=1795063640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HBLCGcqufQIhkN3sBdqHjkVXfZZ4ZTmimDtIq4+w0iU=;
        b=p7dzU1fVUpPWBYerDvN8Irhw/jfanTe0iJqfnyF7mSk4h32AHvih89Ta9/Md3gA/7C
         hND8k2vJX5oTjJIsIi+CXXTWAmTA+W8VJg9V0LR8EklgYVntGz1+m5UtQrXcBEm3kZyX
         +wzKAsgJLSBDsv0Zsb1nXo620ZNRPVVjSMuRPDsNv15NSHhE44iB0JBR2ffJqPD2CSJJ
         EwQx8KHnSPyIMN91X/wwqIGVJ4o6L6YutLyOeMzc+//jnWI4u4cLhC749ML496A06tbE
         5DAtmOpUIFuEzQgblpXQsFrTTqqLkJLLUiW8pZV8qK6qXx1DPWDrvkKfSV1zybZ71bp6
         ZNxg==
X-Forwarded-Encrypted: i=1; AL+hErFd/7aNBUzuqDFkVoJzXN5N1YEHxdiS5s7skNg3DuohIrQRUwbOLiBktvq9OdwX2suVPcMkO98=@vger.kernel.org
X-Gm-Message-State: APuU4Z+DYLXijFHIqCYpqzkXFlYkb7ZaFwAPT9t5rTg78M78kZKcFOkU
	PbIIG3ap/H7VYpdy1MpzVs7eSmwhmWg58BJnGda8eOD4Vq3h7qxiZ0Em
X-Gm-Gg: AYBFou0i/Gmht+o/FkzHeC5KR2rdJ9ztaayxZ0508vShU+6Z2ntO9rJv3HPyAvVOol7
	SKALCl7tT88As4hXwIf+kh8Sua9doLD2UQ0zBs1QzpY6W/iwYXiggS6AuKfr3yrI1zfYGYKtwWn
	WrtyywLBeM3UEX/xTe7WDb1Adffld7Bfy3y3/tKaUNLiUPrOy9j1c9zQFL437yr6gEACzX3Lohs
	2oPbW9XtjvyZUsC10BWn3RNFrcmta/aXdMIy0qTbrjYaL57zWCyupGB5hNLaYNGTtPtPWAGOYNl
	auqXj5sINvl/DfY+paCOSImWcO6hsHRGUqfYxEAiu7c5xFTPlMHQe7TxKf9SbTzmQmEMSB9a3p4
	KeM4CCRr/7IepZ8ptB9p5R7C4BZL6n3sA3LQNo8ObtHNCHHHZqkQxADj28+1mDlHf4uS9G1JIGD
	gwUkQcQ2TtuNrDq9GPAyoMFW6N132ggrUIZOqE4E/QfldR75t/xn/UXMiByleZ8LRmMe8vGf6KM
	xurVO7bm1dXl/k6c+xCxjoMCx0lfqHa74o5tZP8yy9lua55vtt4kToN3Ioxipb6VgagOSSfoZ/e
	S4g9ESThhtV4yfaDzIEYvRL1xqn8vEof3mrWgHZg+3A9oK8EzhYNvsnZPf44dvWv39uNEXu0A6j
	svEp3N1498m91fNjWpBZEuRRw
X-Received: by 2002:a05:7023:c082:b0:188:e51:e86a with SMTP id a92af1059eb24-1b3c023c45fmr3692481c88.2.1794458840206;
        Wed, 11 Nov 2026 20:47:20 -0800 (PST)
Received: from localhost.localdomain ([2405:9800:b901:33ad:5d51:6f:e2db:335d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2fc14sm21024827c88.12.2026.11.11.20.47.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 20:47:19 -0800 (PST)
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
Subject: [PATCH v5 5/8] ksmbd: check a request before signing STATUS_NETWORK_SESSION_EXPIRED
Date: Thu, 12 Nov 2026 11:46:42 +0700
Message-ID: <20261112044645.4074-6-mike.michalo@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112044645.4074-1-mike.michalo@gmail.com>
References: <20261112044645.4074-1-mike.michalo@gmail.com>
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

