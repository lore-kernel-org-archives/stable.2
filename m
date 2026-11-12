Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509494;
	b=VFhVzghRIfi17P7mzH1DjiMbJB0JZYlZdWItytkJjbqTI9IRaxaz0bVK3TgbjOomAhmk
	 cUME0T2W4SxRG3PSxHJWvTM3gxDsaLzEGK4gKo3A3sw2W0cIKIrhWFjEVVEdJ9LhfC3Fn
	 SIqBrZKOvv19N3Ng0oYSvW00kHyH8MImOvTFMnQUGMqjetou5i3V+C6cE6zrjctteAtT6
	 O9KgWHSl49fonY3Aq0Q6fGJBABcumR6VVcWrPlSdA8GYwP5Ak5Jaeq7s1wXtwruyWB+RZ
	 nU8ccTEg5rS3KdWlCkpJ/CCyTldcPuwmGufyC8qq6YYoPqyFNwlBlBfxyzCDCgpLqkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509494;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=KwpBy7aCuNryqK7ChK2jdyNQZwtIbInwf3mrciB/5/w=;
	b=iAgO+Zn2YaM9uXJiiRi/JgFx4wJle2asCt05oGp5UAqgNRHuzUcsjN5nRvKoHPoOf9hS
	 9Ql9D2do/pJ1vsR4hd/RV5R0obwO5Kcvrt7noHRd9vj797arnggEIXWcgyb0LJMa/wSaE
	 MLSikx6FeDOciZ5MnhgQLKjvV7KF/Hh3e/0kKwELviIzZBSYW7aGLfEYijcY4CYlW+C4P
	 Ia00YNPJPKq5ntqEKSUHSYzM89hjNa1aZiRH12wt5JzJdpquMI756hUBW02yUMkXr2unY
	 lgZP3ZdZ87Kf8oitHGinrDwildzkhzVfEKFC4bsl7uQidA4JpI+aoMGXSCSdOKsrxHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b6c1WIWF;
	arc=none smtp.remote-ip=209.85.214.179
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0099460A262D
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 18:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0099460A262D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b6c1WIWF
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ed39646f04so815795ad.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 10:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794509493; x=1795114293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KwpBy7aCuNryqK7ChK2jdyNQZwtIbInwf3mrciB/5/w=;
        b=b6c1WIWFkfrbHfv7IJO+yPunQkHlxgc905Dencs8hBqMr/Cm2e+LasD30H9PFiJQQy
         YXUWpBn2rOyqihmweriC2yQgSBJkFtVOoRio4/HxQDPSbeya0RJk2KhkBjBB+WNtOr1h
         Q3Bzbr2pwDZBA6hblBDx5Bt1F5gWccqEHs1utM5sGN/s7EsjHlEWzT+YmHLwSD0affFM
         WoO2KsJS436CJtSI8P815XQVR1rD6F3d2A8RD1vknPkvAtrHTRoP0ixS6MHTefTWMETj
         w1PbJCBD4C4USz8my4r2FTSITnlKD30OpyYeG2HHOVlJgrfMkxJsvieo+0asFZBv6JXq
         /F9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794509493; x=1795114293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KwpBy7aCuNryqK7ChK2jdyNQZwtIbInwf3mrciB/5/w=;
        b=1Skp2V+BbH4iq6iasoUtpwTrsZ5Gt7784/iw/ZifStM/69BZ/5tJqBB9MMNKsPV9Ei
         ryWBl8Or1FJwlX/E3y//jfa3R0E7tVGHuGAWSchsBlRp2gbrK6nnKB7DkkEap6tmr2WL
         ZWxQh7rSqkcIay+y0htNmXPwtjpphYCMgyFhHQ+BDVmM3iUwcxwJm7jIKD/z8Uc/m4+k
         BDZlhctM0n8E0rhqjTMxClKBU2XGLJClXCgufRNPcMjxMqyJVc4LmqehGWdagEdyOtro
         e/3KaPiQ0guyfV/1fBLEIH4DrGee7OQ7E9cYKzBtTB+9mjw+dInZ1osbNMGTNXn2bwtv
         FydA==
X-Forwarded-Encrypted: i=1; AL+hErExaBWohQeCK9HNTSOEBsVLpO3kPa8rQZXatahmd+Z4I4qmDFuJmnMKA6SEPEigF1cK38D3y+Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wEb+dKuecRXAmXMdld0RSqZLuYdbY4jgvfBqKNqiESEZBYz5c
	QdpP9bjKn0MQ/UzLP/SUFo4xN4D7BQBC/3Iabns9WxGTuNUZ8BfZMhkY
X-Gm-Gg: AYBFou0/McocEIrMTI0JESPaT0zzoNpyJmInSxmSzkcKTTC2R3jnUNCP7Jyj2TuUht/
	0oQQTvjNP4kSdIBgfEfjLGK6BV0blsp3BSqQeRIKzat5prZMz2UsT0q6OXGB1fOLnnk0fpuJkRS
	6hPrGKyKRqXTBXrhfk3RW4ocnT9dH9ncbdjdWE65DGY8H0Fxw2drGSXGXwhnA5kTHOqz4v0iPqP
	6Vh77/LagNs+vZLxuWGU8ZGXwEVhAGVSSSkCHHZ3RQpOFPQjRhYb1om8Df8TrN+esCAjcgYiBAn
	NKa7PfwbDnl72nbqj5qNHwZCHcQcyhuMSO5SyhidrMHktaFciZlJ+VaY9RDO+pCg3Qd66V/7+vJ
	+E1fEW/ZbyPqOCvyo/h65MXYIjKWMvfRIXOau+M1p2d4mRyMUhTAb8gtgTaJOlmV1xN5i22SY9d
	1OS9y7Z60UCK5JzYPv6HESJ+bVIKUTLl6fFd8khzpwAashpIf15Ycs7CHNY1wQNtMzpwtoKnmzA
	BznIphW940qMI1XM64JPxHGszRRABJG5Pza/z5HPknjIsYAM//yhfMLw2HwsdF6IYPjgXDbQI+G
	bw0zbjMatRvyckAhM48uOexmR7ieTX/WiXYg8Nbbwb4+2jYkCUsQQ0C1xhK2DbGZ6krgdORIaDB
	civWWyN/JFfxOPsVd2d48lOhd1lI=
X-Received: by 2002:a17:902:e80e:b0:2ed:2176:244f with SMTP id d9443c01a7336-2ee0df868acmr2099305ad.51.1794509493128;
        Thu, 12 Nov 2026 10:51:33 -0800 (PST)
Received: from localhost.localdomain ([2405:9800:b901:33ad:cbb:dbe2:bd9d:a035])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f7cf7bbsm66205ad.29.2026.11.12.10.51.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 10:51:32 -0800 (PST)
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
Subject: [PATCH v7 8/8] ksmbd: account for the credits of a request on a failed session
Date: Fri, 13 Nov 2026 01:50:44 +0700
Message-ID: <20261112185044.41571-9-mike.michalo@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261112185044.41571-1-mike.michalo@gmail.com>
References: <20261112185044.41571-1-mike.michalo@gmail.com>
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

A request on an unknown, invalid or expired session is answered by
__handle_ksmbd_work() without reaching the code that calls
smb2_set_rsp_credits(). Its credit charge is never taken off
conn->total_credits, and the response grants no credits.

The client has spent those credits all the same. Each such request
leaves ksmbd's count of the client's credits too high by its charge,
which reduces what later responses can grant, and a client that keeps
getting these errors runs out of credits. Since the command sequence
window was added in commit fd8c97d7c1cc ("ksmbd: implement the command
sequence window"), this also ends the connection: after NEGOTIATE, the
second request that names an unknown session is already outside the
window. A client whose session has expired loses a credit with every
request, until it can no longer send the SESSION_SETUP that would
reauthenticate it.

MS-SMB2 has the server consume a credit for every request but CANCEL
(3.3.4.1.2) and put the credits it grants in an error response as in
any other (3.3.4.4). Charge the request's credits and grant the ones it
asks for, as for a request on a valid session, before the response is
signed, except for an SMB2 CANCEL, which consumes no credit. This
response ends the work, so it reports the credits granted for the whole
compound, also when it answers a CANCEL that follows commands that were
granted credits. The same applies to a request answered on this path
because the connection is not in a good state, including one sent
before NEGOTIATE.

An AI assistant was used to draft the patch and as an independent
reviewer.

Fixes: 0626e6641f6b ("cifsd: add server handler for central processing and tranport layers")
Cc: stable@vger.kernel.org
Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
---
 fs/smb/server/server.c | 46 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 52eee04e0d93a..e91e3a1459e5c 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -132,6 +132,41 @@ static void ksmbd_sign_expired_rsp(struct ksmbd_work *work)
 		conn->ops->set_sign_rsp(work);
 }
 
+/*
+ * Charge the credits of a request that is answered without going through
+ * __process_request(), and grant the ones it asked for. This response ends
+ * the work, so it carries the credits granted for the whole compound.
+ */
+static int ksmbd_set_failed_rsp_credits(struct ksmbd_work *work)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct smb2_hdr *rsp_hdr;
+	int rc;
+
+	if (!conn->ops->set_rsp_credits)
+		return 0;
+
+	/*
+	 * An SMB2 CANCEL consumes no credit (MS-SMB2 3.3.4.1.2), but its
+	 * response may still end a compound whose earlier commands were
+	 * granted credits.
+	 */
+	if (conn->ops->get_cmd_val(work) != SMB2_CANCEL_HE) {
+		spin_lock(&conn->credits_lock);
+		rc = conn->ops->set_rsp_credits(work);
+		spin_unlock(&conn->credits_lock);
+		if (rc < 0)
+			return rc;
+	}
+
+	if (work->next_smb2_rcv_hdr_off)
+		rsp_hdr = ksmbd_resp_buf_next(work);
+	else
+		rsp_hdr = ksmbd_resp_buf_curr(work);
+	rsp_hdr->CreditRequest = cpu_to_le16(work->credits_granted);
+	return 0;
+}
+
 #define SERVER_HANDLER_CONTINUE		0
 #define SERVER_HANDLER_ABORT		1
 
@@ -300,6 +335,17 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 				else
 					conn->ops->set_rsp_status(work,
 						STATUS_USER_SESSION_DELETED);
+				/*
+				 * The request has used its credits, so charge
+				 * them and grant new ones in this response, as
+				 * for a request on a valid session, and before
+				 * the response is signed.
+				 */
+				if (ksmbd_set_failed_rsp_credits(work)) {
+					conn->ops->set_rsp_status(work,
+						STATUS_INVALID_PARAMETER);
+					goto send;
+				}
 				if (conn->ops->is_sign_req(work, conn->ops->get_cmd_val(work))) {
 					struct smb2_hdr *rsp_hdr;
 
-- 
2.43.0

