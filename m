Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498155;
	b=sesvyDJ+MJRBWauHPaeItt0HROXbEJXc4r1d9PLWD2xxXhVD5N12AbLncKalYogG025j
	 cCEQVECvmHZIY31JiH0CoHc6YQIfG7a3eR/vWW/EC1KIrR/v/Sn1tRJqds/snYksxDaCe
	 HNAD0/0b8xNAhq9w426MEHehQrsNhC9mh2SbcOROuPG974i/s4N1a+0fd8JMSDWWtxS4M
	 /33f6RC79x9+WTRVtOmIt9YfDfHWn8Ql+Qk1PSC88fIeh7Oh1DIbtTCAx2AkCT5IdEQ53
	 nKRpx8uR3i7rgekNsugADMt8BxB+nClnDNMRYLdODg/mUnrGV9WEJN6dImfRB1tepgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498155;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZQaDZUFARmg0vK0ubYlvR/6wjOF+eKzsBGsqgcT0Th8=;
	b=5k+Ko4TGBlDyiTO+LQWcvu+Pfk1uEmyMwq/fRL1xQm88wWpUGvPDRH8sEnk3OsTaz7gW
	 U1oebwVS2fgFKWALkqf+lN/+cghH6SK6aUW5pODXflJLWN2lvqa3l7o3zg2v9NwGATiXw
	 tTnNNafZJ4XUl622DMsF0SPCkVEKdTDknPTy9+QdhgE1biyeVEvE6xWOxOFVVBIO9jDdR
	 xWvOMUVhnDnlaEkZPBoNh5ey17+Rlm0ijFccBhAt/yJV4satng2ciygxla0c9oTn0R5/i
	 NQgZnaYa4f9Ven76iSeW9YKBY86/ICrD6NSZ2RRugVBAEIVR/8DXDgmnTTbUkW1WX/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n+iHftg8;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A38606A33D
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 15:42:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7A38606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n+iHftg8
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a06e79e152so2523698b3a.0
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 07:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794498154; x=1795102954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZQaDZUFARmg0vK0ubYlvR/6wjOF+eKzsBGsqgcT0Th8=;
        b=n+iHftg87qCl54RLdix5C2y9fS9IPoE5PdJXVS0FFnroFU/fJxsS6riEEIE8E76793
         FOQTJ0myMYAzrtcqhUA6RbEO+edY7gnnWPV9LLndNCv56DoC8jaWLZTFRTj4S2Ycr7IE
         +8tNKHD9KZ99n3CO6qWPalMn5aJrM71+eIRx6jU1BsL2cOh9rbzD614IE3qc5RObWgQZ
         qreeSSzA5OQkLNgxsNXBzA9QMbEcm0b0U+bbzNzO9Xzvg/mm2xg1hEAS26jK9B+30RAd
         ksBTHM4gpW/jmzELDbhkmt29sNooQzoVhucwm7V2vVT/WUhm2T4mUQtY+6MiMjTOqO0F
         uwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498154; x=1795102954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZQaDZUFARmg0vK0ubYlvR/6wjOF+eKzsBGsqgcT0Th8=;
        b=UTJ1INc+hRQpJG19nKK+bOqPR7aetmFBHoD7likQRolxF/bYvSev4u2lob7y6/jzqy
         WfyBAWWZGhXuhW39BdSycrcjVGtr51MdfwxfRaJuwo4c6GNVM79VTf2XwLhFyeqEpZzo
         JbyYKkN8HoO2zul4g4jqD6xTBJad+PYaDVJoLKtIO3DViFGqrV0aMe6D0cxd03b8okku
         nVldDQOaz2EeWhMTch1pyiSXs5kDLAS6GmrICzOJksgb8nym95XS/j+0fYSIn7yY09DH
         /9iBcRwLuYdWtyZwisNbj8umoK4aUJz0W6CNcrm2Ch+q+wntANssjSuvqOhRcZ74m2R8
         bppw==
X-Forwarded-Encrypted: i=1; AL+hErHuqq7PLKdvf3Cklm0oWdfG8DVCewGV2sF/HPvbeOtZnRM3KRA+yxneUxzCgWYOxsRrUHOE65k=@vger.kernel.org
X-Gm-Message-State: APuU4Z+sjM7BGkRfMh1YbLPm1ztckLp60PLH3SAhN8/P2xQB5x/ddtFW
	M51zY5HQ74MTX/6cHSHsy5vLZ44/4iAJhfIqDcdW7FCKdK4YVOCleXsF
X-Gm-Gg: AYBFou128BDcssclQw8JHoJfC444bOsGm2wVxvEP4YY/UyOq1tbFb8PDNqAPf6La3Be
	+3NOASKIN282S83A7NQCoNz9gLRghooZnRh7Qd4JWtV59aUgM9QHphbCsHoDYBf6DJrq694BGnw
	MfV4OjFxe7locrTZJw4nGb/tir7xGeOORKlRZZH8CHjDh2tQCigZsjU6R+lbRXJGAku8pC9x6jZ
	lRBB2KdHgGIFznd9Z4dDHYb0cFdYJ7UgninR51OuE/NRyMPJ7m6rBNyR+yN6CYFm4HXkPE1Fp0G
	VJ+3hiCc77OU5kC/1tYcE0d7TPRSljyFypBgQCDR0+Q+it9fuMoSim29uss3xZzsR7bfDPPwY+u
	umtsJzhIYbCxU7KiOHCU9DaC5mjz41TS5LeGqtKVvkJ1iUhaKxjlNtjrXqPDTD9bp9pg+tQ5Meh
	2ytWRCnoQbq6VRj3RVKz7Efdg6oEMNMHDNC+8/x8rZIXUZ4P7EAtlhMEj0mK1nnL6w7nGum0B0L
	TaiLEjVsXvfZyVuG+b6b4fpMcZIzO5VsooYq5QYvpAhLNx8rs+7w3wcsWEg66SKUwHYgVqghYwf
	LkkAf5e3EgwxDigQPETf2OLKOYFN1ocPirysv5ZtGiXXfPQ+XbwDJnwTRTpEX18+LV6QbxPAdgp
	eqczNwHT8QQAr1jWwJ9fLM05czzs=
X-Received: by 2002:a05:6a21:d82:b0:3e0:dbf5:59f1 with SMTP id adf61e73a8af0-3f2ff1dcab2mr5672388637.91.1794498154026;
        Thu, 12 Nov 2026 07:42:34 -0800 (PST)
Received: from localhost.localdomain ([2405:9800:b901:33ad:21c4:c32f:67c1:d87c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baa7de3619sm3790596b3a.5.2026.11.12.07.42.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 07:42:33 -0800 (PST)
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
Subject: [PATCH v6 6/8] ksmbd: use the current command's header for signing in a compound
Date: Thu, 12 Nov 2026 22:41:53 +0700
Message-ID: <20261112154155.20255-7-mike.michalo@gmail.com>
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
index ca0c78447f454..32bed8672dd2e 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -213,6 +213,7 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 	u16 command = 0;
 	int rc;
 	bool is_chained = false;
+	bool sign_rsp;
 
 	if (conn->ops->is_transform_hdr &&
 	    conn->ops->is_transform_hdr(work->request_buf)) {
@@ -288,7 +289,15 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
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
@@ -343,11 +352,21 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 
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
 			/*
 			 * A refused binding request is answered with the key
 			 * of the session, which can be of another dialect
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 186a497f83c62..1267114b79379 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -13000,6 +13000,10 @@ bool smb2_is_sign_req(struct ksmbd_work *work, unsigned int command)
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

