Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498167;
	b=Ne/db/k9XuMFHMb0l/W7SF0JziERW99EoyEIpLKXsP3q3Fy2iZHYkhs3Sq8UA8Gh316e
	 p2ccOg8rR8cS456yZZnWq02iS92mQDR0Mf7hKbtdz7mbD2/JQqpQ3tEkV69D4ajRorC0b
	 tdtPKJAfzIrlKKzXfxBOdZZ4vK4JsihfCWUpxz7zbL2JDQvR8KBBGmXPTqklxLJvjr1wf
	 tJ5KoNEY4EFbRqGgCG2/v41ZE9i/ceTMKfUO52jfMDpfeKueI7BkGamv5Su4OcO4xsk/Q
	 jgW6mxYYxo4xZDkPzFG6GgdC6a43Sa7c61Gg5oykfbCMorIIbdY2z5vI4ceG0Ojhd0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=cmrDW5oxPDCT6kNIjHKrqyE0Mun040k//ijsfC3fuC4=;
	b=CRtKXUQC7ppDH/KfdBzpLjy8BBaqo/Y5MVIQpZMenjNj5/UEHCiJg3Mf6XQyVLyOQBWc
	 tv3a49xM6SAAy8zed04K/FT+RtgpvTU8TWyJ5txhoVWeCFwwLbWttxOs0RDitNHS33SBt
	 eU7pZgoWLEHU3L1GKxYMbLOmqtEwDMy4+vhODUgzCkdhloW6jxPHHJnBlyIwC1iMbAtQf
	 yHNnfdoH/0SsvCKwbv6CMbWZHRbd0f5GryJebOXXaQE4ZQlA4o5gt1kTOLxdQ6ko2jn2/
	 nDOc/L3maytj+4ToFP0DfGTOqNbFpa8mp9lVLZEoEsXViibCjTluQaxDNS2kVtlhG+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NGJJyN8T;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B1660A2605
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 15:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6B1660A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NGJJyN8T
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8b32bc605d9so2033949b3a.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 07:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794498166; x=1795102966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cmrDW5oxPDCT6kNIjHKrqyE0Mun040k//ijsfC3fuC4=;
        b=NGJJyN8TLSDamU3rlphuj3kbaO7HtRQ+QACITfzPw2oi0pUl6jR6URruPdxiTnB37+
         BJ7R33Md8sNrKXt4PgmVq1Py7w15J2125Cf+GOqvXBOdZjySYIS5rbQgvt4nGhNujzPR
         NW2UQTbHqSyfpyoYsqQhY62cXrhe03fm00X6evuTsI+8Xw1ns6AIENVTiHshu0TlXz9k
         oruS63smbKmK8JB4nWI0mbEq8INxrXczDIBLN2qvJovvz2XvGbyQ2ovQBZvMbc01KR/y
         dJVUdeKEpLBVyOn21YRVJ+Sma3Ti3eVF6qv0c4/WCNercGcVCTNvbBVWzJy7/o5LkO9b
         4RjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498166; x=1795102966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cmrDW5oxPDCT6kNIjHKrqyE0Mun040k//ijsfC3fuC4=;
        b=TQbZsN72uBVhszoVGfM+OCIauBTQQ6lHBHUNmj9HuCD3g/0GNsAf3r/i79o/32PcTJ
         EK51B6nQhg+sEICrXZ35T8Vvo9L/vK2axkQ6+/bCkdrcJscfXth4f5PQ+ez1zFmlwA2Z
         AOj9LYCV6X9BRDXowPavgx/FrDx293ZHTYMiE8k1xlVwlRBTydT0VA4aMZSVu4F8qxk+
         0o9Hq4TGW87TjSeI3BzYjquN3w8HdCnEmJXnMeS9a0f73Vb+plHrkxLdUpEFLh4uGnQc
         oVtRDjHwVRPEJ4fY6Ubd3LceFfCNjyTMDFQWId8JsF1shuS9DqxmtGUcIGlhaLEYbCqH
         QXSQ==
X-Forwarded-Encrypted: i=1; AL+hErGVvgvJR+RUMtfaFwssKEX74Uqp1krmpPAgfu2CmKF86b7JrpJACqUpa2dkKMjdsZcfcUN/gfA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rNzLQog36aYQ1ipObD5PsJ62y6EZxO5vwlwmO4GUzgzfV6w8n
	aL0NN8xwD3ENu/xXcn0iHlt0NvOqaDcVxABKpT0B0KN7FRxCWT3OyeJAODs0Imi99wy4arH0
X-Gm-Gg: AYBFou3KfLlZcsJpAWf8mvn2Kijbm+qS0xlXvqIZVmEtYWNsOMZ2zCci0l9zyI+NNMW
	ltlpMcYGJf1pEgk9glcZ8JJVtBLiiC6/mvZ8sDrpz6MX5vnsL4tfIXWOvH/mN4ZRV6nGPdXysYe
	hUCpMZd5oeAvAEuX+vyR+7wsLJB/fMM0LUwACsCaa6Nyu/g9HzmvmM8wmtMLjV04qedaSZf5RMo
	9roqqeUGAhKktvaXfMOeNRhTsz5jK9/vfxqQkWtS+JA7rtk1XM4P8heRK4ghCLuGXojqB/fNz54
	tCug2RUJRWmz9QSieQqHOLS8b7k3GXM7Z1x4hCBRe9Tb53nd+sM/2HXTbRF5o3yzeDziGTeQrH4
	7jzP6xdf3DFI1HYlyaxhwTRXcoWnyFtJgoTGDyVo2ClaaZJF1JQIewJZsOl9+tmLKdnM+hHGcW/
	A6HwvEZNLjUSIY8ZWL7SJyPsQLbcTJbi49g/5H+F9Gedmf8ybW+Xn9m9RUGTHvmJ6XsBof4LPdh
	ZCbnEI/hrgckYECYQlwXBAm78P7bAYGX6WdsU0vZ6cya7wMK4xY16HcQgqH2Thm+xSKf8KODYrC
	UtXdyyOp60NbKkUyeabcUYILHa5FRI2XG9R6V3t1kef1lK2rWZjmzrLeDvGlv9hVL4E9Lv5Iyds
	ZihaCuF6RneekP7xY+gdI99TClggIiPP+ZO9KgHNB9tePfLVM
X-Received: by 2002:a05:6a00:9087:b0:87d:430:1437 with SMTP id d2e1a72fcca58-8bc1def0ad5mr5929164b3a.38.1794498166048;
        Thu, 12 Nov 2026 07:42:46 -0800 (PST)
Received: from localhost.localdomain ([2405:9800:b901:33ad:21c4:c32f:67c1:d87c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de3619sm3790596b3a.5.2026.11.12.07.42.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 07:42:45 -0800 (PST)
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
Subject: [PATCH v6 8/8] ksmbd: account for the credits of a request on a failed session
Date: Thu, 12 Nov 2026 22:41:55 +0700
Message-ID: <20261112154155.20255-9-mike.michalo@gmail.com>
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
granted credits.

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

