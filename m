Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253344;
	b=i01KSe/8hZ1sbHuMSCjDcijzUgtSUWlscIa/o+H8ghhbjNhoNdRk3JH8VD6lm74FVzwm
	 3dLc9GvAjo0tVTjrXCD4Zzo9nvr8T7gzXmgVSVmhbjvmgtJI70enN7Oltp7b+32JT3zN8
	 AyuHKu5Gyi4T7+zwsuRo93pUN+IuW7fkMRaT/oxPxH4mBe34Y9s3mLauzBhSVTUqfE9by
	 a7WL0y22vE81mXNybObGuWDE74WehTZUOWt3mOWfw3naVbDhqDwdanMI3oox/OJwroVYE
	 9dzE9YnWm8bCbSBibeoifrlJQtxxKLQN8liFwOYD98GtsDIeb+yRvtYcjGQYjI6OA0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253344;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gTCtd7kUwVe5VTZFqC1PznWnEbiMuYwV17eKK+NQQ90=;
	b=w5CszSSdlLdbfH4cJDgvMBs6SJ6gDNaI9hqvow/d189tHyX7F4pPZ5sB+/9kyzDXatJf
	 eGHYk3PATY0me27yynEQdB+QqZh3UZrwGEwQBqLPUmr9AC2pbSF5fmT+aa9iYhHK41mip
	 /s32Vw1If7Ab5Dq/lExrh09DLbxA6Umt3DvmjDntMPcBP7Je9z3kthaO77QWwk+wJo+rT
	 fTYyj1YG4iAa92kPwF4RqNqhztArmG7Er4msrjh3nTCN3+GNUJTJ95Qjyx8R/lYpLyZL7
	 3kiVfTrn2brdONbPCGZqWuuj+MSHAL/2XVbPQTiBUIwt3fQHn+1J3xRN1D6yGDWg42w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WI4gLQ90;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00090606A32A
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 19:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00090606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WI4gLQ90
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ed1e9ae5a8so4011095ad.1
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 11:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794253343; x=1794858143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gTCtd7kUwVe5VTZFqC1PznWnEbiMuYwV17eKK+NQQ90=;
        b=WI4gLQ90VGyyexRY5w3wAZFIw90EiaJZMjEayscPoAymwuF2abH92loKyY3FvHVgfs
         DLZtcGPeBQoAHqiN19DHwhSxTbAA5g8AyO66tt5I0aFfw4garNedRjnHvIKBN53jPA/p
         fvzK0fBa8NrdmzFyG8e2e+k4PBZ9X8t95DEKYQQDIa9As/PkhdjnZlNkadIh3jq2APn4
         76dkOpnby4AN2GmAiyy+Tv3gOc/Pwhb6tMTZ/z8k4ys7xHVaKkHo5lYgzOWkkTXdUaVt
         3tWjY+PGuOMSqAvcu/QB/rwFQnInzWl+DW3/97sl1Sg/P9K57pbVsIQcQm5aoYfIBrV9
         spxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253343; x=1794858143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gTCtd7kUwVe5VTZFqC1PznWnEbiMuYwV17eKK+NQQ90=;
        b=0KmxdIyWaHpP3gtauCm7H32cRF2L+RDzCiWqtgXmySHvMwQJue6+ZEOvL42GH8PrO2
         Ql/lX8ev/BNt3HHBjyqKoHeGBYq4xQWdoDCUcM7AzDIdcKvNQtA4m8KGMU2dR7kM3J+g
         DhQWuSrjzQmjWF9SMQTsH2sLwR9tCRTyGzECJhpoy57lj/6MN4+dLI6INZXVO3/UGQpr
         XJ2j/yb5P8wJEy5taWb05G7pBqlRgOpP/rCcEODuYgvB5vx8e3VfX+sBSI/zjo3vmpg5
         SUMZq64BZ/nVsNSnN6qAhvtRUbWOuWvvJp0AzrrIW3A4voRxzlRwKyUYSSMd7qAMCV1+
         kNiw==
X-Forwarded-Encrypted: i=1; AL+hErGtdVQBK/2ACXHBRySdAmxXo+thIBFQTk/wXlLHOOUGUfxbP0vjtH3rIjhLnO5PSuobUVcP/cE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kFeoiB7vgiD8IPCLx2s7aiyCg/Vbmkyq/+TSMidaaEjo4Xr5S
	Uw1DMqfMIAHI4EuZvKS3pv41RIrdt5a10P9oha82eKSmDYLVJG3QUvra
X-Gm-Gg: AYBFou1TrEYpoUIZdODCkWlryVQ3ZY+NKy72nF7Dbw8ahkf7XTQv33LBBhnUPfuEm8G
	vORuUoPUy1d50XsMW2gLHFUAj0B/POyBuMDqLyuM2jqZlVKh7zCjJTXPyIIeRVIiM0xvkNqdZlm
	bHrNL358TIGyMzuKWgsE+9rEe6TJAonl73BwojSCsjGJC31hZEecedixVmeKcuDVbB6F86dyhqW
	de4lDTOUWyuHV5KrNKRFOCqBgDrXYY9/vDRrRRyQ0o9HkG0yEbQU4tqOIu2z7d3mX48fNYHCdWk
	L1xfcHOgGu6kNjyZb0NFRB+NZc0xjHdVSWYulUNr1i7DKoyu8oXBzysZJRRlwHGE5oV4MWIlj/X
	K7x/VgKd254t5yXf+KqWON2qZeMnK09ie58TGTJFQN82iB9u6EAu419/wmxVI9Z3eQfYCTZqlyO
	eN7pPnEKoixtmyB57pvquFs0v3UiHH57/fMYN2ufDoTQY/LUu+KL1uNPOS1IW1Q8uW1+fOSXz2K
	KpncreVxEu9vziCf0omNI3Vw7Wn45yRkjTpbvihW7riboQZaZ4QAI+ODv3XAKbBEQAWJxW1yeXf
	Eie9tjyV1HlenWw4lTzEzI2P/SM8WsDHyOPiLXHwoJPR9s7ihoAlt4m6gWQ/z+FVy3XuFYHPbq3
	G3MSWFE1G9ApBf/M7IH6pOJ0NxlkWvITG0iGDGKqgH5OyV09hWl4OVO0=
X-Received: by 2002:a17:903:3d0f:b0:2ed:38c0:332d with SMTP id d9443c01a7336-2edb91b1659mr1447805ad.23.1794253343386;
        Mon, 09 Nov 2026 11:42:23 -0800 (PST)
Received: from localhost.localdomain (mx-ll-183.88.2-201.dynamic.3bb.co.th. [183.88.2.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d4b950sm1388585ad.13.2026.11.09.11.42.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Nov 2026 11:42:22 -0800 (PST)
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
Subject: [PATCH v3 5/6] ksmbd: use the current command's header for signing in a compound
Date: Tue, 10 Nov 2026 02:41:43 +0700
Message-ID: <20261109194144.22814-6-mike.michalo@gmail.com>
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

Three places in the signing path read the wrong command of a compound
request instead of the command being processed:

- smb2_is_sign_req() always inspects smb_get_msg(work->request_buf)->Flags,
  so the per-command signing decision in __process_request() follows the
  first command's SMB2_FLAGS_SIGNED bit rather than the current one.
  smb2_check_sign_req() already uses ksmbd_req_buf_next() for a chained
  command; do the same here.

- When check_user_session() fails on a chained command,
  set_smb2_rsp_status() writes the error into ksmbd_resp_buf_next(), but
  __handle_ksmbd_work() then set SMB2_FLAGS_SIGNED on
  ksmbd_resp_buf_curr(), i.e. the previous command's response. Flag the
  response that actually holds the error.

- After each command, __handle_ksmbd_work() decides whether to sign its
  response only after is_chained_smb2_message() has moved on to the next
  command, so smb2_is_sign_req() and smb3_11_final_sess_setup_resp()
  would see the next command's request and response. Decide before
  moving on, and still sign afterwards, once NextCommand and the padding
  of the response are final.

When the session does not require signing, this mattered in three ways:
an unsigned command after a signed one was verified anyway and refused
with STATUS_ACCESS_DENIED; a signed command after an unsigned one was
processed without its signature being checked, so a wrong signature
was accepted, contrary to MS-SMB2 3.3.5.2.4; and the response to that
signed command was not signed. When the session requires signing, an
unsigned first command is still refused and every signed command was
and is verified against its own header, so mandatory signing is not
bypassed.

An AI assistant was used to draft the patch and as an independent
reviewer.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Michail Andreas Michalopoulos <mike.michalo@gmail.com>
---
 fs/smb/server/server.c  | 27 +++++++++++++++++++++++----
 fs/smb/server/smb2pdu.c |  4 ++++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index bd4db44f06cd2..7604fdb919a2a 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -224,6 +224,7 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 	u16 command = 0;
 	int rc;
 	bool is_chained = false;
+	bool sign_rsp;
 
 	if (conn->ops->is_transform_hdr &&
 	    conn->ops->is_transform_hdr(work->request_buf)) {
@@ -299,7 +300,15 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 				if (conn->ops->is_sign_req(work, conn->ops->get_cmd_val(work))) {
 					struct smb2_hdr *rsp_hdr;
 
-					rsp_hdr = ksmbd_resp_buf_curr(work);
+					/*
+					 * set_smb2_rsp_status() wrote the error
+					 * into the next response for a chained
+					 * command, so flag that one, not curr.
+					 */
+					if (work->next_smb2_rcv_hdr_off)
+						rsp_hdr = ksmbd_resp_buf_next(work);
+					else
+						rsp_hdr = ksmbd_resp_buf_curr(work);
 					if (rc == -EKEYEXPIRED && work->sess &&
 					    conn->ops->set_sign_rsp)
 						ksmbd_sign_expired_rsp(work);
@@ -354,11 +363,21 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 
 		smb2_complete_request_open(work);
 
+		/*
+		 * Decide now whether to sign this command's response:
+		 * is_chained_smb2_message() moves on to the next command of a
+		 * compound, after which the request and response helpers see
+		 * that command. The response is still signed afterwards, once
+		 * its NextCommand and padding are final.
+		 */
+		sign_rsp = work->sess &&
+			   (work->sess->sign ||
+			    smb3_11_final_sess_setup_resp(work) ||
+			    conn->ops->is_sign_req(work, command));
+
 		is_chained = is_chained_smb2_message(work);
 
-		if (work->sess &&
-		    (work->sess->sign || smb3_11_final_sess_setup_resp(work) ||
-		     conn->ops->is_sign_req(work, command))) {
+		if (sign_rsp) {
 			if (command == SMB2_SESSION_SETUP_HE &&
 			    work->sess->dialect >= SMB30_PROT_ID &&
 			    conn->dialect < SMB30_PROT_ID)
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 7d107a61626ad..b77c93b3ba4c6 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -12892,6 +12892,10 @@ bool smb2_is_sign_req(struct ksmbd_work *work, unsigned int command)
 {
 	struct smb2_hdr *rcv_hdr2 = smb_get_msg(work->request_buf);
 
+	/* In a compound, test the current command, not the first one. */
+	if (work->next_smb2_rcv_hdr_off)
+		rcv_hdr2 = ksmbd_req_buf_next(work);
+
 	if ((rcv_hdr2->Flags & SMB2_FLAGS_SIGNED) &&
 	    command != SMB2_NEGOTIATE_HE)
 		return true;
-- 
2.43.0

