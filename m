Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793113655;
	b=PuhOll1Kq/i93MWLYKSt32t3EPBTrfMaddZNxfWPEsnPljeOLrJYeJVFMmu/fFsLbe1/
	 rR8/otRoyduSEGox22XpdFZ06u9GOWwIxoQONz+6GxKz3TDrlsBrKz+NQpzOJZzb1f/4m
	 L+2kUHAcl8e/I7IkHlz00Gb7h1RUdhtVti+VGp6OIoU5ywARJUcgaZdDBE6DGSlubQF7Z
	 SqKham8c/I0y30DGpFBY2wMV+3AScKz0kuv+IAgjdwD8LF0zEI6mYRTfyEFh686MSMtIM
	 r5PqB5IcPY70j9wlq1h1rmobACphOYtRVyb1MK/ohkvTer7VY8Dl5+GwvxYBNiJg0GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113655;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mxxURynAR9bAxx4Uoj/0ut49X9XR1HFcD/rz/A3dVCU=;
	b=2SlB2dy6la9h+mzf/6EsrRtC06PSwMTzmgsxrpFMWn+hrhx4zbTN6+ZoDF29Ouc85jFF
	 jk9d/qX2o6gkd+oPIvDbDsaouVqPxSb6pVpqd3/mVQY57N2+P4nWB66riAtuQgoWwpJI5
	 fa2XsKkvv6+4/hTc5PWEvyvqs1t3R6H4eJK8HxFQjT68pMh1AbTfqg6NWnP+tkWiPPiHl
	 BdNrqvpEkwcTepJdFmLZCnvLdJOAB4R28zquQg0KwmyYcAB/xJBRT7ulILFrUoM2+OZF1
	 DiHGwfxdxvG3MhgSP/g3iNtRDoQcubW0HKY90IthlCHLWV2LQj29RUbrWnTYeks9Y9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pio6rIqo;
	arc=none smtp.remote-ip=74.125.231.135
Received: from mail-oo2-f7.google.com (mail-oo2-f7.google.com [74.125.231.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2637606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 15:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2637606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pio6rIqo
Received: by mail-oo2-f7.google.com with SMTP id 46e09a7af769-8210db80578so1037991a34.0
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 08:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793113653; x=1793718453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mxxURynAR9bAxx4Uoj/0ut49X9XR1HFcD/rz/A3dVCU=;
        b=pio6rIqoVvBFD4OXEdzToeCLjwWtoTweeKR6MCtT/UloGziG1bqsYU+jO8UiUKU2YA
         2bSh992AF9MKghf37YyuB4AozwHoXyuCZBIEZTUBzKm7XiQ+L3/HzcZ9BIDX6mRUA1cA
         waVy34j4xO5fhA/uwxC+IoumHD5aRr8k1raiR1PxwXZuP444zRIuISqASaYfBHbBzxxY
         F9RLYzpaFRGv9XqIMQCviqmA/Q62yPLj1/f9noiWgUruUNxuPx8cxdWXgYBvOPZBGtMd
         QofyHI137pP/03jgyQPbDEGsXll+AY7Mj0UBRP+kH6uMtWz82pYknxyx9MdkTv717A/X
         tbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793113653; x=1793718453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mxxURynAR9bAxx4Uoj/0ut49X9XR1HFcD/rz/A3dVCU=;
        b=VtGvxJ0Tu2MfIGjO6HcjyPTelK02DeX6JXV5K1TUXRpiTi4k7CNkIEkDJRlPyu73Qx
         8FZM+PNrhWZsH7ME5YVrOMpgXC1ISkyz+beWX2ErCrWLWyZXVyHEMksqHaWS9TnTAvQv
         CI7hVkbb7jepdP8tuEeIKBXdHi9veDUDOMro9BGCwNl0xrvyyA32HjSX4rEkBU/RdAmh
         BpjHDGDPcoxOAspmPbW8WQ806KV+Mzjo5kQiP9u2vspuyxGRNzW+GQtfVO9xEuc6H11b
         +70WquQWGIrNgYywgmnVmy6ydIM2EQfDv1P2bb+3CaAHk0nVhX0TCl99jfXoEr7njRsf
         su/g==
X-Forwarded-Encrypted: i=1; AKwUvBzyIL5TovD7umbFrjqUV5hR9mIWRgA+g1gzqsIipsrtVP44aahbjj8CZ7eil91ncMuFczO/B2A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJOAXsv5Nl37KX0oBCmykzIoZodbFnNzYAVBV7Qx0FGjbWxRs7R
	sKrktVCdJsWYz2cElny4DExnrVE8L02FxfDSY8mfGkVfFqoQp2wORT91
X-Gm-Gg: AYBFou378WmNvVSPeEw6iUZL56RpqY7niV1OGFYq6JcSfpmDe4uAjWPH01X2RXIllKS
	l7UXQ4S8LHENh62uz4w7/GwxmJlnfyNMytsXFwpyXaY2QjUj10tsGeoEYLBTYpVzZ2+5wTvUgcQ
	xmK/lnRSyvFlY6ugsShGMnNAKVPSfExWTAtFu+hB3+j2lrzy0rGU3SK7Kqgy3v8oUsubaJBaQxf
	Blxco1FwCyo64cxU0mJru/FOWiA2vqm0tUJFhEFiUihWpU+bAxckpx9xijUHG2cD1ECm8M+vBO/
	BHLbrShcFc7PRli8WcEqsmfFx7VEqak+gnC3gv/J48PeodiVnUIj3dIxd8fALYtWXMqIycG9bjA
	X0pN8aYtIHUpIPgK8gIfAddMeJYlHUuFo6Zc2e04EKFKy8bQdhvbEMqvS5vNj1/dCT7kKMet99v
	OVqD1Cy79njCwtTiaSbVNiqEyp7TZ7BaXw0u0GH+XaOlln51u0MkBVtdnp5kiy6/IcoHk/eWdbf
	csRev16QIaCoKP2iGwRiq4laE9+mSQ8mg6RiimSl/BMW6qA+rf/pBJacmpQPLTFeWox1nJ2x3VJ
	xlV4/F1E0ko7Yr0fuw==
X-Received: by 2002:a05:6808:1494:b0:4f8:4a95:9b3b with SMTP id 5614622812f47-55c003d7fdfmr6129548b6e.68.1793113653505;
        Tue, 27 Oct 2026 08:07:33 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.180])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-55c0424775dsm7448276b6e.5.2026.10.27.08.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 08:07:32 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Nilesh Javali <njavali@marvell.com>,
	Manish Rangankar <mrangankar@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K . Petersen" <mkp@kernel.org>
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] scsi: bnx2i: fix OOB write in login/text response padding
Date: Tue, 27 Oct 2026 23:07:18 +0800
Message-ID: <20261027150718.949711-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
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

bnx2i_process_login_resp() and bnx2i_process_text_resp() take the
payload length straight from the CQE field (login->data_length /
text->data_length, u32) written back by the adapter, without any bounds
check:

	pld_len = login->data_length;
	bnx2i_conn->gen_pdu.resp_wr_ptr =
			bnx2i_conn->gen_pdu.resp_buf + pld_len;

	pad_len = 0;
	if (pld_len & 0x3)
		pad_len = 4 - (pld_len % 4);

	if (pad_len) {
		int i = 0;
		for (i = 0; i < pad_len; i++) {
			bnx2i_conn->gen_pdu.resp_wr_ptr[0] = 0;
			bnx2i_conn->gen_pdu.resp_wr_ptr++;
		}
	}

resp_buf is an 8192-byte DMA buffer (ISCSI_DEF_MAX_RECV_SEG_LEN).  A
CQE whose data_length exceeds the buffer makes resp_wr_ptr point past
its end, and the pad loop then writes 1-3 zero bytes out of bounds.
The data_length is also passed on to __iscsi_complete_pdu() as the
response buffer size, so a login response with a fabricated data_length
turns into an out-of-bounds read of the same buffer delivered to the
iscsi userspace daemon.  The login response path is reachable before
authentication.

Clamp the payload length to the response buffer size before computing
the write pointer and pad bytes, in both the login and text response
handlers.

This issue was discovered by Tencent CodeBuddy Security.

Fixes: cf4e6363859d ("[SCSI] bnx2i: Add bnx2i iSCSI driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/scsi/bnx2i/bnx2i_hwi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/bnx2i/bnx2i_hwi.c b/drivers/scsi/bnx2i/bnx2i_hwi.c
index d24cc2c795d61..735cfdb28289b 100644
--- a/drivers/scsi/bnx2i/bnx2i_hwi.c
+++ b/drivers/scsi/bnx2i/bnx2i_hwi.c
@@ -1466,6 +1466,8 @@ static int bnx2i_process_login_resp(struct iscsi_session *session,
 	resp_hdr->status_class = login->status_class;
 	resp_hdr->status_detail = login->status_detail;
 	pld_len = login->data_length;
+	if (pld_len > bnx2i_conn->gen_pdu.resp_buf_size)
+		pld_len = bnx2i_conn->gen_pdu.resp_buf_size;
 	bnx2i_conn->gen_pdu.resp_wr_ptr =
 					bnx2i_conn->gen_pdu.resp_buf + pld_len;
 
@@ -1528,6 +1530,8 @@ static int bnx2i_process_text_resp(struct iscsi_session *session,
 	resp_hdr->exp_cmdsn = cpu_to_be32(text->exp_cmd_sn);
 	resp_hdr->max_cmdsn = cpu_to_be32(text->max_cmd_sn);
 	pld_len = text->data_length;
+	if (pld_len > bnx2i_conn->gen_pdu.resp_buf_size)
+		pld_len = bnx2i_conn->gen_pdu.resp_buf_size;
 	bnx2i_conn->gen_pdu.resp_wr_ptr = bnx2i_conn->gen_pdu.resp_buf +
 					  pld_len;
 	pad_len = 0;
-- 
2.43.7
