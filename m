Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329952;
	b=rJSFvPqu8pcaW8wQxcwsoP+as1g16VHlwuLMhW67NYZgLYT2sf66hRZZm1c4rfZeZOaI
	 WKY1REPBfEBOrhYerYo4kYWbkHeSDv/KEjrJoS9664dO5bhHzQekJrn4+HWaGCOT5BWAu
	 v8LKtnKv/r4KZi8cpi/R0m+2AOF7aU5yXk8omxOUuiLtXP9sgBtKPngj9b3o8UjkaZJsq
	 3pLBJGYJJxSS1suDGMIDvImVJ1FMaiIOtm79v0iVeq850bIFAYmbBBq2dcQqYSczaDuPT
	 nIlAFt0mqHLiU6PNmLl6Iis0Gzget5z/NLXWplbTkgmMcLxgRnSUzIn9N0DXSXu9aEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329952;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=D45L3fPRhObdeDNJWurd+/N9L/g975IX6M+u32F2JVg=;
	b=et7xOMweQaWsH54Mpp0RRie80Y7dx3BlrYlhuPDCg3YzOThAZydP0Vu9lCFmSUw/TZiA
	 P7FBHDJFKlF4MWJALB411acKch3Vx3YV1fWLM5c2xJLR01RP7MUQobL4PeFygxuM2KLBy
	 cy145Pny/LpN7hehkKahlGQEz5BwThNgwt5rgmbMZvQrPESyCLjMYWidoM4YODaHRlW8E
	 g1GW2z8hzkdLLK5ZCTf04Aij8O1aTicGfxjabgWoWT9Ph5QUuUJ1VihZxtkFXPOoKpejj
	 OvF1K3JVoQTZqybFnARzaprvlnyM+VmhlSkVOgMnpyjAYP1C1ylv7hBN0kcNM7lmRIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AAyoIJWQ;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66522606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66522606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AAyoIJWQ
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8b6a88e4341so1137571b3a.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 08:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794329951; x=1794934751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D45L3fPRhObdeDNJWurd+/N9L/g975IX6M+u32F2JVg=;
        b=AAyoIJWQn9m194HohnVrgyQmygSrD2P8CKEjj6TTNjNFgBn80wxvkQiAw2asly+02h
         I+65I6e6wSSrpHMKlFJs5ItvELIQPhOGvJC8u7FZxxnuFYzkhBd8tWmJwCM/0R8UtvyY
         tF+g6Bwk5r2+klsXTahj7DsxxdBa5NfRIkN80i//f6S/zEUDlmvP2T6F31Bxg7NbYQNc
         BhsjjUxiLJXbdsZThvvI62AwOcfYs95PE9FtJ6VwgVto9OqjkHb3xUhf5TpyU7X7uX8n
         atwgZILm/mlFq+50OCGeZl5pa6DfuQnoJcvoZYg5Vc3E7zA1s8ATwTVweaHyYpt5pAon
         JQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794329951; x=1794934751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D45L3fPRhObdeDNJWurd+/N9L/g975IX6M+u32F2JVg=;
        b=ybyROF0kByScDqE6B7tS5VNiKO4wgpSnGKvaHy82T1/CYF35MgclaIvv6jlcU2SI68
         2gPwUIf2VOwsPHAbZsBbdZUfugGHhSDLtEPrp9UImT00mmiXq3VxYD7nfGmd40VLgyHh
         zaLVTg8JtqDJfZhFyMiCeb29IabQKhO1vDDKnME9wRzldjDBt3ouD2FzxHyIQhKiF0Dm
         JVk5ZoD+2gbafH+ZB77L1fLpUyMJv2O6RCLejKHgzgUR9yW+SEetuH3nyXVl0oQMd7oY
         h+rLCqJ5rjOBWp0Gpe3vj1tX8rus8vZ60bJMjy+A0e6SO5Nd19pjJmybBfM5/R3wF6GW
         1MGA==
X-Forwarded-Encrypted: i=1; AL+hErH+PYm4dj8DK4Oa5PDBXKux3zbwZKYAC2UVFWW6MI4B/1iO8z1fNd8hqW7W97AJV52HIqHAHmk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8kW38Wr8rkH15OlfFSwNb4qgl6B3Fb29brl/pCUuVosPh2XbTj
	HiG2m6vddLBPoeOFeqq/4VvUrDfS4E0JRdKWIe6dYogeZ4Ps6donblWO
X-Gm-Gg: AYBFou3E/XMrE0xG7vmtfGG3KZDMxv+iKWzT31xrwPWFiMiDJdwKJVWUmftoLX+v0x4
	RHtd8lBst7TWLr6VmSVu1x98fooK2KJXpnezHUrnMPT5lnn/hnzBSGudqS0L0Ey1h6TvVJ/Qdmi
	O3vO0WJnxeEG10mV+lA/cPdJau//QCnuSk33fI/71gaNDeOoCwYc7GkJeV1WfsxEvfHI9Gf8vIC
	WnYgX6uOTl3cpkD+d+WA+5mkrPKh0qwE2dXZdL7weQW/UvXViTzYDaldDQDCODmHYCYFdwXrnap
	ncWG3a7NG2wtph2gOZ2E7Q4P/ooNz06gZlfWkSycH0Artu73Pl00V3Z/qsTzCKnnv69tPhZCk2m
	ArUvr8eimjOJSo+y9nZPkECRN3pgWR9SeegIY7fzdw1Ts/hv2zt2Bvz+a4iKTWKBE4XkQd+XxJn
	DvcDDjhQ5noP8pf6APW4qPb7fl00UMEn6cVLcETjyGejR0jgK+jiskfguuq6HbnJNVOhpyKzVPp
	W9ApIm6YIWvWP5iPwqYEvs0RwxFpAiESimr50C82SUUv+WhHLO+ySCKAQ6+aXj7XMSoyF1wz6fl
	Pg5xMVf1kQJ3TcBkjjX27OwOnEMkqBBAU2hc8FvgS7H0kHkk1r9Y0YC421WO1KCMrDR2p4TV/hr
	BWCPdrpNol2eV+jpSugOxxgklQCEdk2Va9hO/2HRa8nxH20L2/CL0dWU=
X-Received: by 2002:a05:6a00:3a1c:b0:8b5:7fc8:866f with SMTP id d2e1a72fcca58-8ba8773de56mr3437547b3a.44.1794329950745;
        Tue, 10 Nov 2026 08:59:10 -0800 (PST)
Received: from localhost.localdomain (mx-ll-183.88.2-201.dynamic.3bb.co.th. [183.88.2.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab4fd5c6sm1157154b3a.46.2026.11.10.08.59.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 08:59:10 -0800 (PST)
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
Subject: [PATCH v4 4/6] ksmbd: check a request before signing STATUS_NETWORK_SESSION_EXPIRED
Date: Tue, 10 Nov 2026 23:58:32 +0700
Message-ID: <20261110165834.28162-5-mike.michalo@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110165834.28162-1-mike.michalo@gmail.com>
References: <20261110165834.28162-1-mike.michalo@gmail.com>
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
index 064f99427ca6f..276dbbd986503 100644
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

