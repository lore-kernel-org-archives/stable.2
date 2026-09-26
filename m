Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5163385BC
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790428943; cv=none; b=NVNeS+haw8yxx7ys+z2gwrF0LqFZ537ElK3FPc4ZlV+aK4bO6QvtzG0uocRk5rJjZ7tRuTyLFg53OauMVRIZWGScJPm+pp5uvcBVywt0Pnu4DFOuQtP5mY5HtP6wxme5KwP+Cz0/c2ckByEZEow82rdrMsU3F2ctDEu7KJRwpP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790428943; c=relaxed/simple;
	bh=8rgTvvwDFSaspEHo+kCgQNZbcI/BJZf21gNZIv2AIRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y0/ExV8Qv0TzanevPX2Mevskj0Ivi2/RsSZk7hvA27eBi10oAFrdYpQy2LqrRgz4iec4fX3j/2jlixX9ZB3+UeR/SccywJemIr/G7oDWMv/5+X0Tnr4dWTfW7Pi6ks7LBMiYgtDf2JU/BtwBotCvQj9FBlaUAluYmHRHPTBU/RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=IoYrGoTi; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="IoYrGoTi"
Received: by mail-pj2-f39.google.com with SMTP id 98e67ed59e1d1-3a0dc47fee0so239475a91.1
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 06:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1790428940; x=1791033740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WY6jVhJ1QtI7aO10MKO0OcssEc831y4vQM9w+i0byGU=;
        b=IoYrGoTi6aru4z9/uiV1wb5/qC7Q0A21ix7UNXoBu9FYgU2RBHjFmFtcNtKLUkGV1w
         S2VijHZiEk8TefWyF0w3KWsdYCoslzg37jalrDrUyGXX0+oZhuacBQk9M3bM6OSH/Lxp
         3+M6xb3nObn4mxHxJzy48yyFtCvIVDM6RU3y0QkB6iQQ3LctdabJcs0qF7L9rAqeLy88
         Df4TB4oZSoSxlJuoTg+VGzoXXqk0FNrqb14shOWd8e+5P60wAAZ83Ng/DaC+MGOY2Xxx
         +l40q48wcJ21E6Aazf1Dr0xGYGQMgURJDnQ4wKDMHnwfq6tEXNTEqOQrPCpgi9PokdUM
         Ldtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790428940; x=1791033740;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WY6jVhJ1QtI7aO10MKO0OcssEc831y4vQM9w+i0byGU=;
        b=h4cEnTQvLoYKEzXyjVZDbath1f9jYnZuHSWdm953ZasCXHubaqdgNdtn0wiED9Cktf
         kq9n8kOiJMlvrgdGYC54EkNjT+XXkB0WdBCSwgmmvLp5KixNvBqj2y2OPYD9uO50Htsz
         Lvb8ueKy7KHOqjFfdJlZrDsc1uYjvP5pSKiEMNLv2+//e7yBxWCLO+/ZMK3EJmjvCdO6
         LVR+ZFM3xjDEXXBKiLWdj2v9vqfJFAniY6A0c9CQM8P2oAr9LuES0u1ouES4T1RGm2Dh
         IUGzgewhRPECv7SDkgiUHZiZ0H2Cm8xjN1pjwFMMz/S4mcJlqRYJqZ3CL7+WgdrDA12J
         XpoQ==
X-Forwarded-Encrypted: i=1; AKwUvBwJvH7k4O173qWCwQPNIcBjI+zsvnTSHdd6LPNwcdzd+p74S95JKtbKLhHc8ZjiV361euGvJF8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxLfVY+OoLrHGkS7XBoUHE1o8PIsDTAXfL6NMmicIj2APpgsEB
	irDlQoWJQJUpCGm78DMX4RjtYkM1Ue2qOxlSfbfLwvCn19joAET0AdaZnOrazfjoak72
X-Gm-Gg: AYBFou12SrsE5KVNs81dpHp1mXw/Fpkrj57E4/gBbLObJ/Hae9bTlJydfio0QCTa764
	4MpWqJF5prqQhQ5NMa2kiMn/CUFE06LA5N196tOYxmixJ5VR+Mj2w0poX5hjPydBqDNICK15g/O
	21aG1S5fOxV17rSapEj71cLRF1fsxxMyLaUts3nazktgrRJWpoblL8qm/b77XwAJ6VOw6PCRT1N
	N2fSZr71t1oGkmTdELAOQccLtlvYb+avwiuu4s9yXuf9vmcZKhR/ad66QR8M810KMAj4+fTLjAT
	XeU/IVlczIUMtdYYQbMOrrviYc6S083LvRRBLIAp0Y0uUTaZbw40zYt5Vg4p+mLsEZe1PvZQrPb
	v2Eq/p06ld0vrWDufQ13NnOJAw0yLC4QYq46TfC2V57XyY+6XvIr5D4+PO9eEpFZlgcu1+dJoNA
	8rCcdpG0/vVB3R/QTG/DToRXQYBP5mg5qOuN9H41Jp9ACPR0V2Yh6TTPlFCfaUAmbPs/vtKCHFN
	r2NAokKIdQy6SGH8IJs4/ZE41qQRA==
X-Received: by 2002:a17:90b:3dc3:b0:3a0:ce5f:e292 with SMTP id 98e67ed59e1d1-3a0ce5fe752mr2448333a91.65.1790428940028;
        Sat, 26 Sep 2026 06:22:20 -0700 (PDT)
Received: from 954df21a5119.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8efb156sm10619253a91.1.2026.09.26.06.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 06:22:19 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: pc@manguebit.org,
	linkinjeon@kernel.org
Cc: zihanx@nebusec.ai,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	dhowells@redhat.com,
	stfrench@microsoft.com,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>,
	Luxing Yin <root@tr0jan.top>
Subject: [PATCH] smb: client: avoid NULL resp_iov dereference
Date: Sat, 26 Sep 2026 13:22:08 +0000
Message-ID: <20260926132208.23360-1-zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

compound_send_recv() only populates response vectors when resp_iov is
non-NULL. The final pre-authentication hash update nevertheless
dereferences resp_iov[0] whenever all compound requests complete.

Guard the update with resp_iov to match the response-buffer handling and
avoid a NULL pointer dereference on callers that do not request response
vectors.

Fixes: 62432a3f5145 ("cifs: Clean up some places where an extra kvec[] was required for rfc1002")
Cc: stable@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/all/202609241449.HlHmnZFZ-lkp@intel.com/
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 fs/smb/client/transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 6e21b5f8754a1..307bd82128781 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -1111,7 +1111,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 	/*
 	 * Compounding is never used during session establish.
 	 */
-	if (num_processed == num_rqst) {
+	if (num_processed == num_rqst && resp_iov) {
 		spin_lock(&ses->ses_lock);
 		if ((ses->ses_status == SES_NEW) || (optype & CIFS_NEG_OP) || (optype & CIFS_SESS_OP)) {
 			struct kvec iov = {
-- 
2.43.0

