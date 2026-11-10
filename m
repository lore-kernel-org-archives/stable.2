Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329962;
	b=L93bOSiqLdHBABY3fs8fN1QbAEMs3r/xEPP6qcqL4teMNKJAWh6iIqaV9pfcGmH0GcXh
	 eDK0RgfXl08VFiLhySgFf6rEWZbVyDrvsB86Iym4f04CULGwOe1fL9t/p7jPgwLzJauVZ
	 xA1imdMst5BZpjTmk0MWsJZG+g3CX3bK58o3JWYFoh6zGsvXu20bTiW/ZuYLP+RozhoyU
	 Mj40vIwoxnUfWpZ5eEJDnsP9wHfrmarBRgHOJQkfE6iqrv7DwA8BWuYsVaJpL2CAmcvpc
	 ngbbbZ90smC9bG2n5Z41qFVcmBU8lTZ3EkYcIYAByD2jMkE7+eDWATm8Mti0Mz8NFgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329962;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UZ/ExlSldP4/rbOita3JeRaRAyJwH7hKfGTv9i0JcTE=;
	b=sEwUO76/kb981VDH5nyjnADxvVkLqd42Ti/5q5kBSCtxScDBh3Y0H7bbpcO3pozOXwKW
	 HigLaPUKnxVN0VKbvTEyeGv5iXDUuYEeh2sOzxZuJN4GfQ9cdTsyQxe7FF6QQmJPWfLGd
	 +gP+I/YUWifP5y9cH/ZeXD85TyyECM1xFUv84OPzCLVqa0q8Shjbmfb6F/6IC7XvLIk/9
	 LI7iXIMcehpXCduyMEsFMbGZahjPk47cna8nFfCVMR/w8PRR6b/u6k8ZTpw/80m4oGp/5
	 HT5knJn9zdJieLJboicSnXrB8oCL1u3j8Zyw2TNeNnsmbQdvqwqNgSkKkbYrgrgfICA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vxf7Nh1Z;
	arc=none smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5ED60A262E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D5ED60A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vxf7Nh1Z
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-89d6bd67045so1266402b3a.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 08:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794329960; x=1794934760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UZ/ExlSldP4/rbOita3JeRaRAyJwH7hKfGTv9i0JcTE=;
        b=vxf7Nh1Z24RTvN9FwqKW0jSRILebSLzBbZ6KAEGfd4PmUlkxFBJQCuTnRzp3AXm1Et
         zRHX1slxIq9ysn3jLVyshOndV81B+Qke4y7juBfkv+yZaxJNzuA1OgjyzBuquphAZ2Ro
         nHBMzoVVKK8t3RxnDVfg3eCLakSu9oSJx+yuJV2yOO9twhiCFsEcZZEV+iKJMvf0e07g
         WG45Wb7K3rE3/pIwExDayq4UG3SyzIErBCelC/GQA5z+Z7X2vK4SrGUWG35bsIlzA8Zt
         OveDWV47W/Lr/2az7oRvmoUJGjcA6GpBm7iuphnQp2rTtQDOnteaJFXdepdYrZCmdRr8
         wVuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794329960; x=1794934760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UZ/ExlSldP4/rbOita3JeRaRAyJwH7hKfGTv9i0JcTE=;
        b=FSOK6ffeRavwuX+td2pNik5dGQzPgV8KdPN+MLtWFP+Dfe36pD7tM962mGhpEgIozB
         Lqzg0zGc0MEvzlufblS7JWeOxAD59uTfTn+JPFZm5T2pPzes3FOt3tdWfqSXcVbS/dZs
         2OKXMmPJGNuUaGA/rDGzxQ9S+jG2CZhglaJNLeXUGwB5fVEf1RD6xPbLZiiW6ABo+DCo
         L7N9o2jtFv5K9hwR+MFn0p2KxccHvo/W+B2Ix9Yhvi6tLf4vhsTeXUJDlAJw0r4RCMA4
         tMuRJ6bMGRONWVZMSati2te1Oj8GNwIzqqZ388w0UI0YCdjCQqnOs4EVO9EC6IlbiGhC
         W7xA==
X-Forwarded-Encrypted: i=1; AL+hErFb7NVH+3ANZ54RQebxkpXkzxQHawVvvyn7mI2Umxya2u07o+gz97AYzkV2kXzzr1v3qczASFE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+PKu1s3Yk8yu+z/7Tr72hxe7rD3fNzqjO1tDlv2+drdAwhJa70
	dWvkJLSlLcmavcgFcx3L5Fwubr3Owqe/TjmyZ91H7N9/qICIkLpWxfQd
X-Gm-Gg: AYBFou39UwJKjBS7wK+2QM+KDLjeJ7x3DWNXlxA49RoOwhYX84SGc0i3zKC0i5K81Ax
	1TuQdsB5QI9tu8lB5IyJ5raYftmQESyg+ZVQgcKzg6kZ0gJ5+L7rUJ9hirxicO7pi3pPJj4EV4j
	FLybo7yHXcUmnsx0jDW8TICgUPpxWPwB7qQv2z0JHWbDFlLR8V/9TIBtdJwNUrV/UkT/0u4PHmr
	/qkWkR5Wn/jHFd7QjtzyLxlezJjWopydETA8ocJH0BGqLLHGhS7ghmYJb774JeA18xy8yWFlaVe
	zPkFcvW5U479t/dah3rFSEoG9so1woBs20QL2Lc08TRsTcr2pHfrUddIWOXBENjQOdNsd+8xozW
	e+CtfKGxrgvFdl4j1ulFCsfImB/CPQ9h3MmjXyHLx2MLG7utytsihv7uHY2+f2urmakmz2Xkl8H
	6I5saJNxA7qFrlEiG6UQlf7KK5EQApNECBy5cXvYgiBQZodPtcZzxkOqeBlAdbWShlhjF13lNuF
	xJro8UP6D9faaCmglvaggL65IN0m7lUoS0/yGz0KpadwaWPDFb8s0hlRlr2P7JV2hevVKu/iiTi
	KH99tvxTjlGiurxN2MBi3LY/Y5ZNoQSEhoS24HfmoPNiAq22XuWlpFunBtkpj6kxnJQzgXGoTVu
	jL/jVTlolkHurWzOrlAlt42a+8g6sJ5hIn1sR98me/2zSJn3CwydRzTA=
X-Received: by 2002:a05:6a00:430e:b0:8b9:227b:bfc with SMTP id d2e1a72fcca58-8ba9474056bmr2246885b3a.1.1794329960411;
        Tue, 10 Nov 2026 08:59:20 -0800 (PST)
Received: from localhost.localdomain (mx-ll-183.88.2-201.dynamic.3bb.co.th. [183.88.2.201])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baab4fd5c6sm1157154b3a.46.2026.11.10.08.59.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 08:59:19 -0800 (PST)
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
Subject: [PATCH v4 6/6] ksmbd: consume the sequence number of a request on a failed session
Date: Tue, 10 Nov 2026 23:58:34 +0700
Message-ID: <20261110165834.28162-7-mike.michalo@gmail.com>
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
index 13341ff38aeeb..e3fe856a8258a 100644
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
@@ -277,6 +276,21 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
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

