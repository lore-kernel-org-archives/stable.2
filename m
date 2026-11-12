Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458851;
	b=4QoAZDKpoYipyUhy34pdqTsOyx6vjUW+tRXi5gaVDkW6DEG4B14ddr47xuAR3qtLNy2s
	 FAw/PwOUtVXUhjRhWoFAD244ahkpG3ryyk/x+D6Bd/VH3cjtdNu9QLBcg8TnzhsurWkl+
	 /rgJiDrYYA2zvD4FUiCVwrKKBZ79v+i33VzyQXqnG9+wpDj5M2qnbQu/VYKufUQzDD4QG
	 kZ1Jb0qErsMLG+Bx7ogaBybc8ZA3T2i1SA0ciTBA2j59ZUkAjHjFHrygdKaxn0v9cYCKx
	 hlMiWlY07hRmdsR0aFxblWnxhyiRdh2qupeHEqJ52DQb9/0ZxdfqiB0eSVE3Qy7H+hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458851;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=WR8j2TwPDUPevNVljLnHtKoNr8/4X2azosuFtL+wyfU=;
	b=VSy4EPsIGvMEpYzER1PrCbvrm3QLjG4BjrJyHiMMuytnpY8qy3o/dE2tm9gB9hC8D+cO
	 fGRLeWv78PpOLuHzL3CmDltqOrWj52X0521vDSR1AzLx3GYHa/XfGg55HP+SzRjVEdEn4
	 2MVZkyGYrMMO5ckY2j07hM+MHdFB0IQpzMltTz53vNUp/jXU6Zm4csVct6I0ud6aUz69C
	 BbxEcToCMAH6yhECm7KQ1d0QglNawuDLyqUc+zBsw86uidY4iEg0de3Ca2YY3kduOH9J0
	 M+AMI/Iia+YGk2MKanUGfUnwG2VqAPy0MkCal7SFo5GGY6WkZ8F6c+e9wL5YM9T0aLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VKMwDZF2;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B96606A32D
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 04:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38B96606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VKMwDZF2
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1931ff67a29so7041625c88.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 20:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794458850; x=1795063650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WR8j2TwPDUPevNVljLnHtKoNr8/4X2azosuFtL+wyfU=;
        b=VKMwDZF2V7rHE+kLkatC4a8bzZpq5qG5dbBrzyfhl8TA2vUfIu2E8cFgnr0muNEQNM
         z4iVImathAoImGHzpath9hFOwWxYv4V/6bCEye6KEovXsMAfWGVG6JGrbZhAT2Q3Y5xM
         xNWJXVXWiN2bSxZzoxAc+Mnvhu2z0u6nAdXf2wtL8gSj/avjLdEH29kXFYD6DqvULih4
         bPC4JYAuvo9OjkgcJlNAXNXDqSyDnIJoHnnFAac6Mdt/SkFLSbb2G+eR/AzGvkNsdIlG
         kvbAdjeVDGFfudjVfQR9CvBHhApl77XX/aM51orYfm3Cxt7VQ1exiG3pI4t1Y/TrcSqW
         hI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794458850; x=1795063650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WR8j2TwPDUPevNVljLnHtKoNr8/4X2azosuFtL+wyfU=;
        b=hu3naIeLbwGVhFdn2jmsriF2nJ7dATVEI0HcNC4tFtrQT/eHWKCukBd8QXssdlb5hd
         JznlmWjrZd2GRgLnVsMVcudoxUClWHZnHy+8wDA4kmYfgZlKR+Xw8hhJGsKlzp5HffTt
         vXGj2HwiNFv+1M3CfWHsxCLkHFqqFaZmNXNAPrXODke59teK9xv/4YQgsweXbqc0T1en
         8wVPw0MCAhzEihOqqA2BYV2wG2q7fxDq9eIaq/jrYhU8MDaD6Jdhs6Q5FOxcsDSMNvy5
         w5ETfevm+QyPsffknRR2QymZP5MSQyPmv94yaEkzK/lprP1kleztbYs5d2hsQzoEaaAY
         8kGg==
X-Forwarded-Encrypted: i=1; AL+hErErTj1E5LbraU4e/xjbbhfxuROVnjKf+87Bd/cCDLnocCguG0xlfKEY9uDAPxwRhDmYnmQ0VUw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8s9C3ekFWEdgUpMfvzTR/5VbahVdO0UtRD8ulpAJkoOK98dZoe
	+dKr46nLFYbh9NMf4tzW6EQVJIHgWenJwLIiRGByWhDql9gsma6XfSxd
X-Gm-Gg: AYBFou0pNkqJDFxyaDZrOe3e9yY4BxNlQQ4jallDqkY6C6vcEWNN0U2IwLud3hfgicG
	sNkAFGnUvIDNtIEYgsVvrFCCWnjywEqTiII9RHAAYYnONI1C9CwpovJ6lYsaR6VOlHnHojlcUaH
	TN/BP7RbxqVIFad2xwFg+jb1qI7NeCfng7tWY2mC4ba8wNCQk8X93Jwd57Mn/bxG1ziZ/tWSPrH
	C5M6Fu5L0Ypr1EI62o2SeeCqcaPV9UYf2A+4sHuSN3MCJ2pnKaWhS4OyjRo+JbmnL5oHSAGf2kD
	JfM+rmvkYRu9+4m+u3lmTdZb/2u2YGvEwQJsOVjz1l6WBCo8Yzq39S88ScpR3IAmoYnv+35nrPP
	9I5FtpyF65oCwh7mXg885VArZOc173RpCcTU//HdgiwI9FJy98BkwSOD2aEDpOZwV5oodSlXVrI
	oXvt30PpzqRQws0u7Jc+cwPgr2HYYT6pokUqNWU+PUEuAt6djvXHpsQ4tCW024Y6/GBC+JkBpQg
	oflRvsSLhiZPPcOzGmAhpP+ck6K0M4RGvPpF1jw4dK6V0JFpNjt40tJvapgxVx13ltqwjRmy30k
	zSm5vyUZ20eP7jzXE9mjoyo2YcOHx6cG0WR2JTKyjMRMiyXvv4gD0G9b38pT7wPQW5WOw5gS3Sg
	hmkg4zPgTibTwloDR7vwOvX7F
X-Received: by 2002:a05:701b:251c:b0:193:9aa3:474c with SMTP id a92af1059eb24-1b3c03179a5mr4030746c88.21.1794458850321;
        Wed, 11 Nov 2026 20:47:30 -0800 (PST)
Received: from localhost.localdomain ([2405:9800:b901:33ad:5d51:6f:e2db:335d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2fc14sm21024827c88.12.2026.11.11.20.47.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 20:47:30 -0800 (PST)
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
Subject: [PATCH v5 7/8] ksmbd: consume the sequence number of a request on a failed session
Date: Thu, 12 Nov 2026 11:46:44 +0700
Message-ID: <20261112044645.4074-8-mike.michalo@gmail.com>
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

