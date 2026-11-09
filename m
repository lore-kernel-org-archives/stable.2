Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253320;
	b=2r4TaoMRqhfpB4v7QW4gygCztHstlPllMA2bEo7MkvGwOQ9tQgAfKT4bTjQu9dvhiXf0
	 FIqTti6MQeLPmFFPXR9bCq+ZGYFxbr1ScIoR7BUxqXknuzeShSEuG29Fkw0Y+EpUmrbsQ
	 ye4o72tOenmiWuCHxqRyL5nyzBpAMSTRdNzDYdUJJqB3Mp8yrQ8SyENuBtGHaaX+aH4fU
	 8VfoQNGq9/2p+sjDaLxGvMTp7DcvCVZL86fpy7P/QlC3FF9CE/Ksh6RZbh6P5cJE82g6S
	 uhI1Nuzs43VKxXpKDn3yzQNWbfBNfEDMBTt51XXrIh3ou2MAupW58APhNwOKG+uRzbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253320;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=pm5tgrvS4mxwXIED4+gFl49LnVQMWhYzlp2m+wLFFK4=;
	b=jx6Z00WBJ1Z2Vaodjfsc5p/3QFLBvN6k3LDb7PbnbyoH976wJ7yEQPFJaPvvKajjC8vT
	 ienaGEuX9IuQo6j5/c1wXKIhtvxqch5l8kIxlB0v1aV9Bn8yYr7OhdU8xOMjHvlzuJims
	 5IAXcFsmIzXQekcTyzjESKjxLEQG0NuEylZd7B7CDzipzbP+uNBh5T+ycpWtZjCBiFWQ6
	 EDv79+bdt/vlmbpJSKFrBxB5bzsNzycrjHvjJ9nvqIAVK7OgtAtCFDgXxMDqZYxPKsyDs
	 3qRV1ksKBi/3ZiMNwTor9IX/a0CDr0EdUNUgiUfTl5Tl7XYT5PbyKNknkk/5T+h78+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="x/Rw7ojk";
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CB3606A325
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 19:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35CB3606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x/Rw7ojk
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ed2b4348fcso4971825ad.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 11:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794253319; x=1794858119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pm5tgrvS4mxwXIED4+gFl49LnVQMWhYzlp2m+wLFFK4=;
        b=x/Rw7ojkBV1ZHNo3L36EabZCWxrpQADkCWB/M5JmAbPgLZxtm0S5+06vl0pU9NoOjH
         Bi+c2Ke0Js8Faq7w9dLkpyg3yDAQwTgODhQzJmfjV8qkC1bo/3527WmjQBp3MlgOyHgt
         5KR9oSUuJnccwagtpOv9qM0hS35N1wM1jLF0jQyXjs+Sfyg/yL2z2CjniMv4RiIn+tpz
         BglCi6tBprvAgu0CIy5FrO+h04UK8XlMagG8aCgdjFLPNVY0EfOE3tbIjLQ4lvA0AD7M
         jzLtJm0eLNU3yN59dQer1w5GOfiyNvB9xsbe3AEiPjGzZ4HX6NzAocDo1rnmHym8bA5w
         CesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253319; x=1794858119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pm5tgrvS4mxwXIED4+gFl49LnVQMWhYzlp2m+wLFFK4=;
        b=XfgPlDD43tUYPXnaDTeLN/3TkoIqbeBkZR0/AGKUOcPVdGxsjbxweZOtqbJ07VDohw
         UGlrgwJoj18kW4IT43QjFr7FmjukqH+X4W1H2eO0v0PQLMIxL9GjKRXtSQRBRyjdH+Nh
         ZVii+sR32s9eViEdMXuhWVwXWuWvX4xfXyMqYGFij5re7736tD7khA0AW+37XzXeOROu
         M+uRksW1TjB2imBzv5X6N91jMDA19lu1zMPBs5VSrvQJ6LN/DpMUdzKRlhxGL1HH0k1y
         BES7u8ZJDN18fQxYEpoWvgPvlucAfLmyHw7b/asSyQ4CbgJmAZJO87J0OCaem4dEnWWP
         Wgpg==
X-Forwarded-Encrypted: i=1; AL+hErFKpOrqfr14im1fSfxT+SpDhuR6mAjv7pC7CZMOZgl1LuotQwChbE+wldD+E4bMwxzYpgqSSDc=@vger.kernel.org
X-Gm-Message-State: APuU4Z//k7VGlqicZ37qv9xOGTTd/UbEsShFcvjbKJoa24yGGOYLkPPB
	Ve/YfNli7ljRhxb1KvQ6Sofz8K4FO7DQhKtYcp53jb6R2szBUJeQnnqqklO36IESgrYDDQ==
X-Gm-Gg: AYBFou2WV0MeVmfATjsA2sVVsXCl8JeW2ufb1wcp/9I7c7lmysfobHB/8txzYnbSKB5
	w3+xdc38dMdrw2goxXd6fIy62BU7eCDLMqGHPkOFNB21KCJYo4Gpk+o6zbYCiJotnWvP1Ba/b+4
	tUUq9k6LBXqvneM5nDwEfo/tKqUi9LdsBQuYHb2P6CVjeD+NUErNWcN1IZmrZHgyX3Y03iDfFlE
	nAxVuxW0J1AGsldP7yCENFmXEcSKTpPkTN1D9HMP8p0Y4piKoRQ4T/1eDusRRpaR8EHO/8oXSYN
	f9p76iiiQk/duuOC0msVpQEsggmQSmERF2gM+tLMIFpTMbqDS+uHD2WHE0GZGWXACqtiFIAyarP
	OBa1U8uB1onOTyOjeiJo98wbI2TrIeKu6In/3WJHFiTbk73YZXx40x9wbM3yANSac4NaBNteA32
	2lh5j2IBTBPr6SHdf143QZErwtlOfW00ZTxkZkL4oByNRT3fcviMVlL8xkXlxOO8IWnFHoqUs4B
	rL50XuxiK7p7BxYL/tBrmqLpYpZq3B2rF0dTDymaVVKXj3sGGwEihq+/jdxwOnOco2LZD1rHFEZ
	3qjdatc71OWcvdkpW09GGew89aQ2wJkdA8o5D2dhmx4ijMjKi2s0vzh4G8gdIRCmT63wJhRfNM/
	qcsL77HL2SDlRrkTa9Aw271ERdWJXL+LiMAqJgq1E9w1U8gTfMMBFvlc=
X-Received: by 2002:a17:903:1b6c:b0:2ed:2e3a:1fa4 with SMTP id d9443c01a7336-2edb92f56a1mr1330285ad.62.1794253319491;
        Mon, 09 Nov 2026 11:41:59 -0800 (PST)
Received: from localhost.localdomain (mx-ll-183.88.2-201.dynamic.3bb.co.th. [183.88.2.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d4b950sm1388585ad.13.2026.11.09.11.41.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 11:41:59 -0800 (PST)
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
Subject: [PATCH v3 1/6] ksmbd: verify the signature of session binding requests
Date: Tue, 10 Nov 2026 02:41:39 +0700
Message-ID: <20261109194144.22814-2-mike.michalo@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109194144.22814-1-mike.michalo@gmail.com>
References: <CAKYAXd-Jo-ObBDs-AdGfaM+QmDsot3gj1g0oJiyDKczoUDg2TA@mail.gmail.com>
 <20261109194144.22814-1-mike.michalo@gmail.com>
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

When multichannel is enabled, smb2_sess_setup() accepts a binding
request on a new connection once it finds the session and sees
SMB2_FLAGS_SIGNED, but never checks the signature: SESSION_SETUP is
exempt from the generic check in __process_request(), because
work->sess is not set for it. The request then goes through
authentication, and the response is signed with the session's signing
key, since the request claims to be signed.

So anyone who knows a SessionId and ClientGUID can open a connection
and have the server sign STATUS_MORE_PROCESSING_REQUIRED responses with
another client's session key, each with a fresh NTLM challenge and at a
MessageId of their choice. With AES-CMAC this is a signing oracle. With
AES-GMAC the nonce is the MessageId, so it also lets two different
messages be authenticated under the same key and nonce, which reveals
the GHASH key and allows forging signatures for that session.

MS-SMB2 3.3.5.2.4 requires the server to verify a binding request with
Session.SigningKey and to fail it with STATUS_ACCESS_DENIED if that
fails. Do so before the request is processed further. The failure
response is not signed, because work->sess is only set once the
request has been accepted.

smb3_check_sign_req() zeroes the Signature field in place to compute
the MAC. Restore it afterwards, as generate_preauth_hash() later hashes
the request as received into the channel's SMB 3.1.1 preauth integrity
hash.

The other binding branch, which rejects a binding request that is not a
valid multichannel bind, verifies the signature as well. A missing
negation on the multichannel flag made that branch unreachable for an
SMB 3.x request when multichannel is disabled: such a request fell
through to the reauthentication path instead and was answered with an
unsigned STATUS_USER_SESSION_DELETED. Correct the condition so the
request is verified and rejected there.

An AI assistant was used to draft the patch and as an independent
reviewer.

Reported-by: Ian Bridges <icb@fastmail.org>
Closes: https://lore.kernel.org/all/20261103171742.18816-1-icb@fastmail.org/
Fixes: f5a544e3bab7 ("ksmbd: add support for SMB3 multichannel")
Cc: stable@vger.kernel.org
Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
---
 fs/smb/server/smb2pdu.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index b084cca8813cc..129a4c5c74f44 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2558,6 +2558,29 @@ static int krb5_authenticate(struct ksmbd_work *work,
 }
 #endif
 
+/*
+ * A binding request must be signed with the signing key of the session it
+ * binds to (MS-SMB2 3.3.5.2.4). Check it before the request is processed
+ * and before any response is signed with that key. The Signature field is
+ * restored afterwards, because SMB 3.1.1 adds the request as received to
+ * the channel's preauth integrity hash.
+ */
+static bool smb2_check_binding_sign_req(struct ksmbd_work *work,
+					struct smb2_hdr *hdr,
+					struct ksmbd_session *sess)
+{
+	struct ksmbd_session *prev_sess = work->sess;
+	char signature[SMB2_SIGNATURE_SIZE];
+	int ret;
+
+	memcpy(signature, hdr->Signature, SMB2_SIGNATURE_SIZE);
+	work->sess = sess;
+	ret = smb3_check_sign_req(work);
+	work->sess = prev_sess;
+	memcpy(hdr->Signature, signature, SMB2_SIGNATURE_SIZE);
+	return ret;
+}
+
 int smb2_sess_setup(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
@@ -2640,6 +2663,11 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			goto out_err;
 		}
 
+		if (!smb2_check_binding_sign_req(work, &req->hdr, sess)) {
+			rc = -EKEYREJECTED;
+			goto out_err;
+		}
+
 		if (memcmp(conn->ClientGUID, sess->ClientGUID,
 			    SMB2_CLIENT_GUID_SIZE)) {
 			rc = -ENOENT;
@@ -2675,7 +2703,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 
 		conn->binding = true;
 	} else if ((conn->dialect < SMB30_PROT_ID ||
-		    server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL) &&
+		    !(server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL)) &&
 		   (req->Flags & SMB2_SESSION_REQ_FLAG_BINDING)) {
 		sess = ksmbd_session_lookup_slowpath(le64_to_cpu(req->hdr.SessionId));
 		if (sess) {
-- 
2.43.0

