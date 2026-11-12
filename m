Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794509484;
	b=THuprJ10Dx722WfCOhTSpNe1Kg2cYyBo/ukVJZ45w++BqDgpeBj/9DqKJ2eoK8g3Ixat
	 W0TTT9A/VgcOBE2BjkMIPFrU3UXChcsQNV8Uej60cTVL3nM8DNP8Kzq2IOF1TzSR3l5Fa
	 GXzHNqm43HgAFlM3omf9Nx23+qiiA/NW4Q9Y+GC8xelb2KQvJwowF6748VRxEllIMIs4K
	 GxEO1SiMbivpV09Yk85TZ36176d8KzKZ82DSdoNqwh+5UIqRDSxVKfKN5w3QOPRydxUcr
	 ycMYEvp7fw2INYuBO+6z4EjPciK7j7LgYVF+ADahHhVWToSAUcScOzR2NhV87mT3N7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794509484;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=oYX2qRr8l1svLfkLSgI6YJjNFCjAsPL/QF0j4Jxr+wo=;
	b=ZZspNzsVqYvNUnKUJeaehTQdKNh83mhxDpYkxDrB4FWH4RxpiFHChYLT0JtxWxms/z5G
	 Rwd1cZ1x2t/t/7lkK43hFRq7yDhFgjMws3A7Xwp0DdqHA8GN1PcgErYLGm90VTj66IMxq
	 KL865O7yYHrwmmkzUereBE5vFnCn556ikAEitwSQ5Wg1lwNZ+CUT5LuGJY95J4DvFP80a
	 vt88eSXLDhKznPFK45HZ1KoGN7In7AnD6tEl8fXRhp31cM5zhLZfSC6up+2+OYUOR1QJ3
	 JVHAdizKj1B6arEJAkAbLw0n9ove++JIRGm/2+z29B9v//3Oi7F7VcBo74iqJkwxuow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r8ZqqTsO;
	arc=none smtp.remote-ip=209.85.214.176
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F50A60A2612
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 18:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F50A60A2612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r8ZqqTsO
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ed408b0d9dso875515ad.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 10:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794509483; x=1795114283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oYX2qRr8l1svLfkLSgI6YJjNFCjAsPL/QF0j4Jxr+wo=;
        b=r8ZqqTsOYRMaAs2KKWMB2yPZM5iN4soxNuQyTy2+QoNLD6p36T+o4RRrW3rusOHiBU
         EceS2eAN7QTtiV4wsjt3Lzo0oIGe5qqoF1tg4wDwDorRiZORVC93eevltB3BSiu3i0eH
         CJ9Sqqh/E+wkif1rlSldMojX4oejKk7QatbDIrrc0ZOxAFbXdzRxZ6r/3kJIBydyxx1l
         02pEYpFhSeFMK5VUAZ851Uv0fpWjYtUG26FFW4Y0ziU+j4rhS2RXSzP6rLVM+OIoEviL
         28QOJWfog36ypFteIDo091gIFN59uu4J3QP2I32R2rwoa8dr3tmwu5GlHo2aoHXNqB6l
         VqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794509483; x=1795114283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oYX2qRr8l1svLfkLSgI6YJjNFCjAsPL/QF0j4Jxr+wo=;
        b=YSCzyYZXyDYyS+R+/WiN6krO33eLVRqzSK9l+K0JY1f91LHnN8aP6p4SwPbO/mU0r4
         /sMiFrFnnlCSgAOuRpoE80AX9z2gbtt2wsxrZMUDE5mFjM3h+Ac5LjFmB2zGUBt0WgDa
         vGa0VG4mAUjDaTYrbmsLxxAfbqLDA5DRaOFVgHjthkz8sZdRTW+bj96jnEpIciStvEhm
         EtkaVtzKllztw+iLXpgKrM6rQ6VIfUg9XPs7DquaDucg/Lqxa5nxbJJmDyWuIA+Y3yVv
         58ctdbwkYpcv4nRvb8GaNTG6D4ZqXbyY8xuZd/sniOSwNSb/1c0eJSuOhzsL1v27lrtp
         olmQ==
X-Forwarded-Encrypted: i=1; AL+hErEO+JE30PMw9PYvXprS5Zj0tdwLPwRjBKwdURNefpsxrF0R6LDrJC6akQIjjXmwfgI7Eg8oams=@vger.kernel.org
X-Gm-Message-State: APuU4Z87FjSkAf4D9KWGMLlIWY9/Kefk11q6jS+nDHxPtZtA+npidHdp
	Im8cOAE4lbPWNZV0723uN6e1Pd+RIN5/UE8oaB2LQ6MBuVHFTxJ+VIXZiMtJyq1+z0zPZg32
X-Gm-Gg: AYBFou34rzxOQxzXhqrVGZI/WVJaHHxFvFijeEsx6lfZqF7ZSz230+9tWCX+cgncQJA
	2byDCYkAXDFXASMUZON59G+MQ+/PqGe+EuLAIqVOI6eJic7LakOlqXCrUYhlRpd0UfA783klGEA
	FD4CeWeYSo8R834yhgLn8Hek23fv36NRvWiQqfj0tORYU6NqvhjkqjjB/Myv8qA/ME9qt9mnr/f
	atrwfpK+s63SH1hu0JBA3NPLZJ7fV/bjbUEdkt1NaIqdqTagISYzNF8R9e30bc2FbrOuXOdzLge
	MulA//P0s2A+7CvveIO+OV0x8ZcODlzgGUBEpDn83s2/w7RGjEC83qAhVUDbL9P/p4jgJN56YYl
	MpS89h3QOJ1OUxX6qOYA7LuVqipUgryepBsa0sdGYEmv2zwOJ82wLjaXtAjx88d1gpGoCjdpp0U
	c3RvQ7HPpWiIMAjQx1gwlBYO9kKxpz+ErexiYmR+gq8OvYncAimsCD2r5ufK6P57Ta8Vnad0kdh
	zp8kZOcfIsyBe5RA5WCjNdaVMdWeXHeFdcr3yb5p3YPI7JAFkjIsxv7e9o8jYMYzUmchFZpIc8L
	mwzAsuQP4hCCiz1aYUYXD9B+WO9E5J9DuPIyrrZ2sP+MiGYxfbXXoJazv2wWN20eFeM0/9Z/2qv
	lsfRnC9o6+2O+sqrde3fLW0KgYw==
X-Received: by 2002:a17:902:fd8e:b0:2ed:107a:4f5d with SMTP id d9443c01a7336-2ee0d9e6eb1mr2506175ad.1.1794509483454;
        Thu, 12 Nov 2026 10:51:23 -0800 (PST)
Received: from localhost.localdomain ([2405:9800:b901:33ad:cbb:dbe2:bd9d:a035])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f7cf7bbsm66205ad.29.2026.11.12.10.51.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 10:51:23 -0800 (PST)
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
Subject: [PATCH v7 6/8] ksmbd: use the current command's header for signing in a compound
Date: Fri, 13 Nov 2026 01:50:42 +0700
Message-ID: <20261112185044.41571-7-mike.michalo@gmail.com>
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

smb2_send_interim_resp() also uses smb2_is_sign_req() to decide whether
to sign the final response of an async command (STATUS_CANCELLED for a
blocking LOCK or a CHANGE_NOTIFY, STATUS_NOTIFY_CLEANUP), so in a
compound that now follows the async command's own header as well.

When the session does not require signing, this mattered in three ways:
an unsigned command after a signed one was verified anyway and refused
with STATUS_ACCESS_DENIED; a signed command after an unsigned one was
processed without its signature being checked, so a wrong signature
was accepted, contrary to MS-SMB2 3.3.5.2.4; and the response to that
signed command was not signed. When the session requires signing, an
unsigned first command is still refused and every signed command was
and is verified against its own header, so mandatory signing is not
bypassed.

In an encrypted message, a later command with SMB2_FLAGS_SIGNED is now
verified, as the first command already was. 3.3.5.2.4 does not require
verifying an encrypted message; that is left as it is.

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
index 7790aa618fcbb..9c6e740180a4b 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -13004,6 +13004,10 @@ bool smb2_is_sign_req(struct ksmbd_work *work, unsigned int command)
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

