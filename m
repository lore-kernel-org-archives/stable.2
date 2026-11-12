Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498162;
	b=PN3xjYIukDWnsDZI8DiA0LtMyDhAStv/3YRVmULN9gq+oS4jJbLUCkk1CL3lTkTOGZA3
	 3V8K40BU4mWX5anYfQIQ3ih9DGAYsHbOVPj0HYkcEW116qgoAePpF0t4DIy1ERgMxrWQA
	 T+LdxPgzL041bgqxuI1T5xf6qVWtAc7WUwHIQmiMs7pNdXf4RhCl45iO3b6y5aMfAXvjd
	 BVToFW9nbyb4yLwFt6thFpN7H8cWwx9nyaetEsNJVeEKLNciMhPSi+ajypMBOwaFgccGd
	 wBhDCp0LrubOv/DQEll/o+Q3iUZIk9z/bBaQEZ/dVMJmaXjq74+YnFFilJBaSnofGnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Oadj/k+YUbXCuqf8XiX+YDF2IH/fTwUIifcUE08h3Aw=;
	b=acN7ZI4u0h3Ox28Di/3tfJOIiyL+akq+EjhEPHyXWH8hikLTemEan/2SnWIdWdAWBfxz
	 HZDBef7wmd1tC02jrt33bUyFIpHtNhY//WlYUe9ZjXrz3bBgnmHA4ZKe5qB5z2uibwHTG
	 IzHhhWhHuAC7NmlrQANhOqf2O7NmDDpud/GasnwR884/uMVVeW8kh7TAP545sONBkKXxD
	 N5Q9gIcjbOLFQgG9Z8G21+vs4RmxUDniGlQLxg7hpSFTTfu2DDW4SdBQ4tDkL1AMj/zxE
	 x5+1ylhG6m9sUFHL5a71OXwUtxZs8QgBavIF61L7gnqAyCEBXCB+uqjyjl+WH+Sc5mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IajlPuVg;
	arc=none smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416F9606A33E
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 15:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 416F9606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IajlPuVg
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8b68e59ab33so1006539b3a.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 07:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794498161; x=1795102961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Oadj/k+YUbXCuqf8XiX+YDF2IH/fTwUIifcUE08h3Aw=;
        b=IajlPuVgKrGxSLaKBXCFVvTjOWrJ45wqfmbFNCXWvH3GOxsz9PtFqOzjeKDjHrRxq4
         UDtDoDfpw8v9ofu7III84PY0yzFnBRUQ58F+ilH8hOVIGKLQrAVIR2A0oX76nqOfJemo
         1+zNV4az6Do0gJ3onTQFcgvIzkRI0ox7waMjTyShxaUfXkQbUa4DJbgOKDBD25f8D625
         TjM2Q0gJcF75eAxiuSNN4kK0qTh48V/fUV1QGApW9Wc0B5zrhnOQwzEG5rzosJeTOyhw
         H124mEZQG009gT+LWic5p3tatTu2qkzXwDG1uHRLLSfR4kRB39S9Xnd1l4tN8OWqrYV9
         jLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498161; x=1795102961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Oadj/k+YUbXCuqf8XiX+YDF2IH/fTwUIifcUE08h3Aw=;
        b=k9mPsjkkYuJalCusXLjApK7c11yjHRZBla32W3YcoJH5s+meEP5DCJT3h9UDImY9Qt
         0wfKhlIFgFkYWbSxy5kXe3Q4Xr2voBcZ2RN+HJsdt3BukP035a+MJ89d4TU5lQ1oY3/X
         DTVxMTbh24/Rgun9a2cRiPUaWET0S2yTuijbp7xr6EZEg68+D8PeY6714En7cYNaW1RI
         TNnBv4+MBCSBTcTrXvy0ROh2fU3UySqY55H0bROtQrO9uzA+Art5DjL674aS3w2OWoMK
         BL7h/ep5ycaUCAKZyYEC8+O7xUwhj0CfrZ6ll31GFjjkI8phzVnWHnIpnOcWxWmIbART
         VlnA==
X-Forwarded-Encrypted: i=1; AL+hErElKS2i6nzP/jfHj3d8NB+NdJm7tFHBDckh8+REA+ya9qggQTUysZY9m8lsuNGR9y3pECFSpzo=@vger.kernel.org
X-Gm-Message-State: APuU4Z9E9gwkaCW5VDvPKdfrA+I6uM4Kh5Vk8qZ0C27ZO5vP8qsA74la
	wAYxlgOrckyBZh22d4ctUmGlWi3WN6gPQAQRxX1otVFcUnGXMiQ5MLqf
X-Gm-Gg: AYBFou0NMeSReOvArzOvGau7JYFZiisaMaXUA0iKji673/cx2GQ7FMWTteNmbn0T4Tj
	Ls2nz6fFbsYoIsbA+qtpDfLdCPvb+qJGZdJ+whq3xkjdGseKB+yBg5JPnTW4P6mGkgbVHR81zdb
	xR3KljG9SCZD769RJUyJEPHPpuEQDigdjePbquIOaxavkGokJtIFoRp9uQ0+LKkuT1PgvanI2w1
	GZqws0NKwL5Mt17GSdsUEc/cCSuvOUjaEJh6sfLw0TXFLKIgL40ZNh3TJKc2WP3IxhO070tennE
	MIL5Tyh0VxyS6zfMTkIUvHrpWZuYWks17+BR9glRuOkGF2ZQ5dhWOIERWAPjg1uTQSjwbPjmyUN
	jnpIdj8Zh/SmsoIX33seK8Zh3rLzxjwxNYZ/yLqyyoWYNMMe/O4dIYo7xiQB/0Fx/bhKtZb76Ct
	bEOf+tcx16nwx92lzTDFjonhIFeAiGpr6a7E0mdDAlVK0vx3RfDM8Sa+uWgkFoAZFVCeAMcMiJF
	WQb+zu2lPiKu+62DgAj3U9Y8YexFqsdYKdNYviNq4x8QwLWAWGEVrJAb4IR5NDijwzo/0cKkqh2
	NWuFTV+tJ1cKUMtIpcIUGj2LLn/UI5ioQdr9MMW2OPMSjhpuqPCZn8qXNhSMEd7Gk86Ehj8/dXX
	THVmomjORYiZHE6Afphxhd5733WI=
X-Received: by 2002:a05:6a00:f8d:b0:857:7337:5db7 with SMTP id d2e1a72fcca58-8bc1bdceb15mr5652943b3a.21.1794498161442;
        Thu, 12 Nov 2026 07:42:41 -0800 (PST)
Received: from localhost.localdomain ([2405:9800:b901:33ad:21c4:c32f:67c1:d87c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de3619sm3790596b3a.5.2026.11.12.07.42.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 07:42:41 -0800 (PST)
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
Subject: [PATCH v6 7/8] ksmbd: consume the sequence number of a request on a failed session
Date: Thu, 12 Nov 2026 22:41:54 +0700
Message-ID: <20261112154155.20255-8-mike.michalo@gmail.com>
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
answered nor consumed, as after any error that ends a compound, and a
request refused by the tree connect checks that follow has the same
problem as this one; those are separate changes.

An AI assistant was used to draft the patch and as an independent
reviewer.

Fixes: fd8c97d7c1cc ("ksmbd: implement the command sequence window")
Cc: stable@vger.kernel.org
Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
---
 fs/smb/server/server.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 32bed8672dd2e..52eee04e0d93a 100644
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

