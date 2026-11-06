Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793992024;
	b=XnDUUEEzVQqvcVmtKfMb/lmxzzed2c021E1XJPkL0ZshBcvtbcXwf0ABvlKu1I36PE/e
	 0Yl9KGt0GRDL2QPYjdIBeD3u2mO/Bpal60AYVHbBuKGRcvQGhB4NbAsrhNQVvCW1eUsm4
	 Ndx1bBUcCSu/kwMQcaPVDzdLi6XcnVHqSWson0LcTbbPalwQNMocxhjtIZr7MFmObTVz1
	 owu+V9xKXbFt+PCNYcElnC3dKoOe5LlO/8CYBDG12hCIeOESvUqQn/TD3gfZYacGmbxt3
	 lVkJT9G+81LK43DnBpFaD4CN/CkHf1jPZWVmXG1m3lcU11+r9BKqlzkGSgOmmbgesBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793992024;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YMJu4XLBqQ/fEGisX73M6D244sbUdTxsQ1NSbRoweVc=;
	b=D1uRWpEZmB0Kcbbd0zlPptydRpYlXTxZlqeSAn4vh9DpitU3zLtiFjpnPKlacPEW83aC
	 IrerquReYwspBjExT2V+eOxm9aiErKDHqytC215waWTpHlzi/9r0/UqqcSx86FAfnQqYS
	 PnNYa4VNzUYUim60Kj4+Q9M7ienZrA9u8js8KLpcxiWNWgORPsBKSVjZj0HJEuSzmDXlU
	 FC9m7t93H0g/FGutT/ln6HyHLq34RdMcWvkjax+g1H6bb2/Z/6w0hUMcNUQ74XdzTgmQM
	 vhgOt2YBaBdrZ/LJtxvfm0+M/zzaGN91imJecAqK9X0Ksnh7KSrfir//wcIhohcQhtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="wUtTXUy/";
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E630606A32E
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 19:07:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E630606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wUtTXUy/
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-4922dbcee23so583648f8f.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 11:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793992023; x=1794596823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YMJu4XLBqQ/fEGisX73M6D244sbUdTxsQ1NSbRoweVc=;
        b=wUtTXUy/GvL1ymzkcDRgg6xpVxA1BZEB7KkgnwMqpQO5bTNN74ON1+fT6zkGlJlm34
         /rbI2zJZETBP6tU5Oq+AqkP2KvVuvPOTe22ruPWbPBtmUcm5yih9bOelUjfTMz2V9mkT
         b7+mbqaqSfYM2ZAoKchwTcRJiEQCpP1gznRY3tI+eAla24c/cjrC2b7sP3yq5AaHKmco
         p3P8j5L04jyBAqNPs9RRushrAlNAZSExy/fLKZNVdKh/q3Sv3BRZuk3M4ut1AwvBp+dU
         A35pGA+70UDUHabCbUdhKjQOgrl0cQceDy9caSk2RpIwDmDNNQfnhS/jQ7wBG8s87FnV
         QsUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793992023; x=1794596823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YMJu4XLBqQ/fEGisX73M6D244sbUdTxsQ1NSbRoweVc=;
        b=etLaoIvZXL0OXeG7SVHuA4Ymx9fvx+OrrSs26C4HdZlLlOWxwxfYM5fWE+vk4LHmaj
         CO6h6SzdKzjeP7Hoj6PdbpLE4YsW5/Bno1ohPhujIuBX2rlSosFBSdrFP8wu4pW/Hhee
         dJV+JvNwfKupHaN/LeWmUPRQU0djWzvtW5w6MsCU9J6KCLYxfKWD9UqXhXC3T98DX+I3
         JXuioF5KnWo2XjwT3fQagf9ACBntpimyvsESoc//oRnd+4/KPaubRJJ3AMRZaO7V78Cx
         5+l8d74fc/bCjEAxpn1Rk1hhVwKVD5Ry1/3M7+L7IMmIyJeODPIHIExUc1Yp5IC6KpxQ
         sS4Q==
X-Forwarded-Encrypted: i=1; AL+hErHb6iStr9z5+FNngWFRryqRkTvjPF3fDbBieiCxZiJw1/sHEPkzmS+2/oHSJYdW6gweOxZkl8g=@vger.kernel.org
X-Gm-Message-State: APuU4Z+sF265kF9d4KSx+G0iVRjaWjxAISVauYIMvq8i36d2WD8PQEQ1
	JnPMXpU5QqFmdpUE0XDDKt6XlX3Ln/YBLOgWh6O/x17HFb5ZE11pmPBM
X-Gm-Gg: AYBFou36BWJ7Uls2Rqu2dl6lkLn95NvE5rio99sy9rXsWfScyeQs8Gmb8Io9J7IYlcj
	sXeYA3dwzWBCwSChu0ENxd+dEzlIRBYgETsYPC0YFiJJ1b64Atkn7ldUnXhs01iCLqnakuXPezm
	JRNLg0EkQUd0yxxlG0/CXYlIXqRLvil8Z8JNDyI5/UT1cshL1Apu/RX7yjZ3Hh71fZNosGZeIWq
	w6P3Rlxg8M5W87tSXQo46pC1zUJiz7vJwk7xBXW1ndvKE1bBRQYO2wHYGjN2iEpJ+lTh5jHQZu4
	JIYxOlHJxfBfoMk7ITTiLOI6vYS6UXWTkcB8LXqy2mtj4sANYz2J2X6whmRFL7HdKnNjogVUwy7
	lDzKnlg3T7+vVSu276uNXx9NQUMpsPLAaK2mmZd+rjeQCTrCCHJcGRPMHnD/Qb+4pWlhKmZrmLW
	sEQP2Wz+lzcnGWNL2xney02F7KVU+P+OWxi+UDlwaGWVpnHkZoKqe7pjHz+ZmU2UxKcCQPRoRx3
	svZn2fKMjNsglId3Ny8XR4Vs9YWbQEilp0JjPtA9lrLG33EG3DIeRQVh0ogQljjJBIRAv1B87RV
	ENQP+KN9DXoKLu9bk3aueb43CvCXMktFbJNF7z3Nh/hKRxysGxTpzvaOvt4UDJ9p/6zymm84qIB
	kMM7kWXGRuEOyQUw=
X-Received: by 2002:a5d:5d83:0:b0:48d:fbf4:895e with SMTP id ffacd0b85a97d-492764aedeemr6683116f8f.11.1793992022611;
        Fri, 06 Nov 2026 11:07:02 -0800 (PST)
Received: from localhost.localdomain ([74.244.226.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4930a5a91dbsm3960533f8f.35.2026.11.06.11.06.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 11:07:02 -0800 (PST)
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
Subject: [PATCH v2 4/4] ksmbd: check a request before signing STATUS_NETWORK_SESSION_EXPIRED
Date: Fri,  6 Nov 2026 20:06:22 +0100
Message-ID: <20261106190622.20990-5-mike.michalo@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106190622.20990-1-mike.michalo@gmail.com>
References: <20261103171742.18816-1-icb@fastmail.org>
 <20261106190622.20990-1-mike.michalo@gmail.com>
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
signing oracle. Reauthentication keeps the session's keys, so the effect
lasts for the rest of the session.

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
index 4430c8d6393e..bd4db44f06cd 100644
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
 
@@ -276,7 +302,7 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
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

