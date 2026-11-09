Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253349;
	b=Y4N09LfDEH8aTzwhAokDDKKldzZN8QuGaWTcabNEsTUe7Avf7aph+QKUNU7xTmGQI68Z
	 52Jg/Y0UVDm1fCwAyGfcST6OohDN5zKTy7AhLfG2GqKM4oaH8eOk+SW2ic7DK79a15bBj
	 yakX7zHfXA5DabocVymtuwUjvqAlTUlAzdvDgselmq5hJ4wHgiD5jMPwh8BlAFrRHz7vv
	 G5KEhvkroqQaK5+TVi9McxaiiFGaano2nTxry5/3G+l14TaVd/WSqfgh7R2KlT9OgwVy6
	 8cfYGiTfso+ActYq3yUSJ8mMG4YESt/RdVi+0ShIK+v5fTCqJRfxUEuQGwQCb319+Vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UEhZmesMv0jigQ7cD/Kn5QG1oqSQq9Q4U814VKFftdc=;
	b=RdIjL6Q1wJCh6wI+F7XNh0f/JvlwIKWDjNroKA29oqR2jqCWfJNUFr5ebyfeHCU0pXmh
	 ggN/mH8jTr1cTFSHVJ/EKXKY0Hl5pqV0Q4rJQh7dGW5gdms/dfsPMgP/X1yX0VxGtvKT3
	 yvNYU4iwBkRd+MdydMh7T/LpsjpKxLxxBVrV/SkjU+3j153X4g5wcztHbK7BqNkunixNu
	 HIsAdYag16/nZWRTRvMeI5N1jW5HtLsIoh5IEfHLT29wfwyfTNEx7NBwQVqhU3aS/N1c+
	 XP7t1jMuGZnYCcxg7RTcXtZ+/neIUDgLYtG6bn5jV8lg7XG8MmFV62qUYPgoGVEm0ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EKc2b8Wl;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD75606A33C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 19:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CD75606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EKc2b8Wl
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ed0b03ce3eso5152085ad.3
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 11:42:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794253349; x=1794858149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UEhZmesMv0jigQ7cD/Kn5QG1oqSQq9Q4U814VKFftdc=;
        b=EKc2b8WlVQAK+QDBBLBJs3pHzNBRz6SdjfsrdP9tAslpxwZc5moiXJfRT9tI5WQCQQ
         zrAl/FZzen2FYuI3vqvOem38LgmsVVcGmmq90rFjJ6ZO1rFAwz5sT5X5puJiV4QWpf02
         8dozWpc9Bsb/euLqwJLLlSdltxIUPG50x/JDZ4+YYXlWJpWHuhS8Zp25OqaXxTN+T2OY
         ANCZ5EQd9Y0k0SH2NgLL5qStUKPB4L6Djwsi6aKpPOZlnpcPDCTZxK379BLIbtSUe4AC
         S5pNZEF0oE0YUuehpm1rcSf9PK8eL0IuqvHRXvZlWDrsdh7xxTt88VHifS224YuFwXTd
         PcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253349; x=1794858149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UEhZmesMv0jigQ7cD/Kn5QG1oqSQq9Q4U814VKFftdc=;
        b=P6fVUfSU89srHbfj7ri15aP1EUAwyivX+I8JTLrzN5Pi0dCxZ10jbD/nM8VdxWIB+h
         ZZOdRihB/t+aMlx4AC1uWRedK6u+kuugHuXTJ7yazhGgaKD/oLaQieSBzNT+eQYXX3aV
         l6lAQn1NHd6okUhQQf2D/P5FUMwxDNgqzxFsm5bGUsqgwpfgsTEzmVO2HSGd1O95R9lD
         uPEjHVW1L5qu7lXzI6LJOBlCXp8SYNbTQs+W8u0sxFojxrjJDPU6j+YfwunwqZK3Q+oe
         37bQqrxLGLtpAKN6pPlnC/6yFWdvgaLb9xJHxeOgsgzsgg7dolT5eyMSPCC0s2Vatzh2
         GyRw==
X-Forwarded-Encrypted: i=1; AL+hErFKtyeqZBtO3qKId2atNYmo+B7+w6zugFFjZUXFeyv0n/rwMLFexYpwMu0wCOrPtH16DSl17Cc=@vger.kernel.org
X-Gm-Message-State: APuU4Z85auDPzShi2YDq3o9dj47xbJT5mH4/uqCWPS1YoAmVItTFgDp/
	3dsxaty7NuyZWxQaxEqPda8tjByY/yzqwfvWPscbU4gNQJXAD8oR9hS8
X-Gm-Gg: AYBFou1YhFLxIf9443nglMYtcAtV7bBzff6SMv4KA2PgjRD6NoWAxrN5Vo8++2zfFf2
	J8Eu7DC6q4u4Qt7XlmM7hPKmF6C0KFR6PH0VsYAvkMgxRm/dXSB6BWrXHqvvRxrYbmQSSntomt+
	O8QnMdzjTmCVuMKtTtXcptxZoG/xqXRtFIc7dkKmDEsg/GGOjuadFdWCnNhr2xqNJhfA1/ZGXlD
	hjn9FrvVKr1UNPzjC0rzu4b6RhwRWJ9FvDzde6XWGY9/V378U1sqeoinkCngvqL2uiONx25oeBl
	q3vKvoeKTRnNW+BPjjuaIY0TQe1BAyJ60h3cJTfFIK2qNS4d8n/itRmrmweLSfhEIe+1n+xBjAT
	nmj7QK30q50PEgv6ZwRU4JFGt//O8UFkz7SAwDLmsZY0nUZZp8NbBhfNeE45/KjcQ4l7VYSFKEl
	NoEq3fCLPBoEKob3BXwE7KEgTkQ1sj+UwuGQq0m+XcN5NuI84BIFCMBQ3HVWZJYYLG00XCBoWSR
	DHY1VVSm36xUkCjQesF1L6RY4dqtw7htEawp51XtFidtNS4UoTLuPUQU0a+bmpomWHSYPFZF/Be
	9xg+P8sQIWSDBU22gmALmQPrr1VtMHiJYrvcji8tP6T2p3tuAerUDvqlb5HEIMHjRrlq7T1XBqn
	F53bpr50EtZ2h63dZKpYXk2w1oHUTo7xdu+Fs1QXFR35zkv4hhj3TvSs=
X-Received: by 2002:a17:902:da8b:b0:2e9:9c65:1af9 with SMTP id d9443c01a7336-2edb9227047mr1360425ad.53.1794253348909;
        Mon, 09 Nov 2026 11:42:28 -0800 (PST)
Received: from localhost.localdomain (mx-ll-183.88.2-201.dynamic.3bb.co.th. [183.88.2.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d4b950sm1388585ad.13.2026.11.09.11.42.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 11:42:28 -0800 (PST)
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
Subject: [PATCH v3 6/6] ksmbd: consume the sequence number of a request on a failed session
Date: Tue, 10 Nov 2026 02:41:44 +0700
Message-ID: <20261109194144.22814-7-mike.michalo@gmail.com>
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

__handle_ksmbd_work() calls check_user_session() before
__process_request(). When the session is unknown, invalid or expired, it
sets the error status and jumps straight to send, skipping
__process_request() and therefore ksmbd_verify_smb_message(), which is
where smb2_check_sequence_number() consumes the request's MessageId from
the command sequence window and refuses a replay.

Only a signed request on an expired session had its MessageId checked,
by ksmbd_sign_expired_rsp(). Any other failed-session request (unsigned,
encrypted, or on an unknown or invalid session) left its MessageId
unconsumed: conn->seq_low then stays pinned at it while conn->seq_high
advances as credits are granted, until the window of
KSMBD_CMD_SEQ_WINDOW ids is full and the connection stalls. A replayed
MessageId on such a session is not refused either.

Verify the message once at the start of the failed-session path, as
__process_request() would have, and drop the now redundant check from
ksmbd_sign_expired_rsp(); verifying twice would consume the MessageId
twice and refuse a genuine request.

The commands of a compound that follow the failed one are still neither
answered nor consumed, as after any error that ends a compound; that is
a separate problem.

An AI assistant was used to draft the patch and as an independent
reviewer.

Fixes: fd8c97d7c1cc ("ksmbd: implement the command sequence window")
Cc: stable@vger.kernel.org
Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
---
 fs/smb/server/server.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 7604fdb919a2a..df04b0dd9f2f6 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -109,9 +109,10 @@ static inline int check_conn_state(struct ksmbd_work *work)
 
 /*
  * The keys of a session whose Kerberos ticket has expired are still valid,
- * so STATUS_NETWORK_SESSION_EXPIRED is signed. Check the MessageId and the
- * signature first (MS-SMB2 3.3.5.2.3 and 3.3.5.2.4), so that the key never
- * signs a response to a request it did not sign.
+ * so STATUS_NETWORK_SESSION_EXPIRED is signed. The caller has already
+ * checked the MessageId (MS-SMB2 3.3.5.2.3); check the signature
+ * (3.3.5.2.4) too, so that the key never signs a response to a request it
+ * did not sign.
  */
 static void ksmbd_sign_expired_rsp(struct ksmbd_work *work)
 {
@@ -125,9 +126,7 @@ static void ksmbd_sign_expired_rsp(struct ksmbd_work *work)
 	if (work->next_smb2_rcv_hdr_off)
 		return;
 
-	if (ksmbd_verify_smb_message(work))
-		conn->ops->set_rsp_status(work, STATUS_INVALID_PARAMETER);
-	else if (!conn->ops->check_sign_req(work))
+	if (!conn->ops->check_sign_req(work))
 		conn->ops->set_rsp_status(work, STATUS_ACCESS_DENIED);
 	else
 		conn->ops->set_sign_rsp(work);
@@ -288,6 +287,21 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 		if (conn->ops->check_user_session) {
 			rc = conn->ops->check_user_session(work);
 			if (rc < 0) {
+				/*
+				 * The error reply below skips
+				 * __process_request(), so check the message
+				 * and consume its sequence number here, as it
+				 * would. Otherwise a request on an unknown,
+				 * invalid or expired session leaves its
+				 * MessageId unconsumed, which pins the command
+				 * sequence window, and a replayed MessageId
+				 * is not refused.
+				 */
+				if (ksmbd_verify_smb_message(work)) {
+					conn->ops->set_rsp_status(work,
+						STATUS_INVALID_PARAMETER);
+					goto send;
+				}
 				if (rc == -EINVAL)
 					conn->ops->set_rsp_status(work,
 						STATUS_INVALID_PARAMETER);
-- 
2.43.0

