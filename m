Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793113682;
	b=mYMqiP/exc0YO5ksLgoYh/fPHvwDtRsU/leeCi73fS2Ld82zsjCpwEGscHqtvakKHAyg
	 8rM6m0mGbgox9/iBPzLZ4wGzMbuMwhI9LCHnqd0mtvUzeOqEiJCJbd84pkAboClIaQXxy
	 2GUGBm2sXuX2RWVaz8qqrkI5bgjJfvBYbEqN3LjG/5ZL9OILQohvF4fK/DxRbXDwXYOlL
	 1fjowCIbRwuU/1Wc9ZgnRnX0gWS+EW3CZp3VPR+2prXxyEw5JR2HBspN/965dgHCTaqsf
	 O+4OUqSrG55+K34H8svwTVFMmijDRIuMdlpOInmGZ6y/yIqr7Z+0qVg9YdKEDsfIyjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793113682;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1KzTeYbxSizdExmDLUTY3oH0bwSQMee2NZJRt9PMZ0c=;
	b=CcN88BUfzsjzbrpOzwMa3BMXlJxUnp5qhb69aCbVwhe1CNuP5y3IwOJqJcxSBaLhuBat
	 2j24Gprt1MGfaEGWJuUWzEu5YwYfcvJ976oHki/BW8x46udrizqgvXY+jfeoL/E57LHW8
	 /GdClrIVvV2nPXnDBwAF0+wZFWLwR69V4fxX14948pciJpGRgWdeJ6Ys8SRum4yfezbJq
	 OnIjwHIHUnSnubjBLOsHrUy1AIG+fu5D0rXMaXPFBm+p3WgkG4yznsY/Wtt0q0TiAJv1V
	 2EJCERh9r0nUAx4CT46VzAuYjlrAd9KUMST0dgj26ioEJFm0/+FWRakwruuFV7HcPYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0nJKW8S6;
	arc=none smtp.remote-ip=74.125.231.131
Received: from mail-oo2-f3.google.com (mail-oo2-f3.google.com [74.125.231.131])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3C3606A331
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 15:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA3C3606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0nJKW8S6
Received: by mail-oo2-f3.google.com with SMTP id 46e09a7af769-8459f7bc7c0so2212380a34.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 08:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793113681; x=1793718481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1KzTeYbxSizdExmDLUTY3oH0bwSQMee2NZJRt9PMZ0c=;
        b=0nJKW8S6y7i+XLa6TPGMvU6QxLKy9bw6wEcfFTBpFlLA8HJkuCw+P3q11A9CRHn0JO
         LRbj2FMNQ3jCfMrsnhP6CnZnf7pkC5IRUyU7LxQXBMyRHw4tNedJGfnZeO3qwSg2pym3
         IypH6124GeziLwLLdO1Dno+EQszr/ENlTzJPrhtRWuaOUa/75B6x0xk8DPmcc+wfkK64
         poeK4EsUjAQg4AcVKN5wGUmmEcEsks+t9+dKX5tFophAUiWQAxydvsbPBaV5DIy4T1Mm
         kEl/EesO2/+KU5huhumAHWXlclun2AU3sw4nAcuW9ZnII415N6+rRa8jcnV5OU3MsApr
         aiyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793113681; x=1793718481;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1KzTeYbxSizdExmDLUTY3oH0bwSQMee2NZJRt9PMZ0c=;
        b=Nd5SIt+ZxyHDBjSO0R/eZdrhU2ArMWKc2dQGnD4hOhij05S2wcyEhTWKQO8BX8T8gY
         q3eMezvYWP/XCBzGKNXsszUQrW/tp8t0OqC5OxV5CFkhcTA/KCnQj2lALkgivwzv1Wk9
         LrPt3x1KEbgYEjhfJb9j1HBpxaDoC3oTdKuqrAGg21bOM5A07xmFGLZVrF4LF65FljRC
         tA5ljPr1AWxjYYBmfisDczL2o445CM+BXqGmTEJaJXvrbXs1jjhOEQtg7uDad+4u1waj
         4XMDxfxCxcyxZZmp3zYoWy0SUUedkt393TxukN3/3V+48prjzwNmuoQtk6wC0itUqqgx
         qmPg==
X-Forwarded-Encrypted: i=1; AKwUvBwTVTgb8ORMM71M96k//SfruAvOpUevG7+DWAWc0dLyyJXikB9N3y+TDIr1qv6DNQ4iKzY+f1w=@vger.kernel.org
X-Gm-Message-State: AFq9FYLpzh2lv97qCXCGoBwCciP/UcAWTJI5KxiQ7tpjHdV8SZGtXRaF
	Iq6pXb4al6iKvCpx889RY0sCRuSCdoEBfPVdamrrfYSy0m1NNPWPm1zx
X-Gm-Gg: AYBFou0IDWemqOu5i/EOMbzLtI6sdDtuoS+yXZSgIFakCaOQdUmq8g5dZulXK+hZxW0
	UCHzEy5NCwsLw3Ps739c9fegn2kH+GimUFwBq+aGQwitssTWqvUJHfqLJNWzOo1Lcvze8SQbKU4
	UKbpmNcPvSJ6cA2x7TE+5dPIrELvwvkLMKzsacW2BjWlVccHCKFkoVaD7S1t/RoXHPjqK4MMr9G
	XumSRyj6Y1LvfTGjXSwvVDzvgOpOVe0slV4uzGmaRGVT7Q2Ns+8QVdq2KKLpQ0nuIPSqHpIjVLo
	uimD2jKL+Lm1aFYMyWuAd7HfqSzglUsZ0q902HCR5sl6YeBssf1SZrzff4oEQcTOUH7lbzivCjf
	2zr7/ov2T2RtOBdCfw+OTXoR157N+nT/mJesP0TxD2mORiRDjb+U6v1Jnjb4Pj535orA/kkVPNG
	U0AyRoeYzdNgYyGLW3lWKHZfJfeS3DC4C5P6tHvLvhCoSsk1NzXJdrs/qFZT4LNgkDyajgIBm34
	0g56ViUrPVz4jR34Usv1gnAH6P+PwRDpd83IWbkL72bXJCg0DnF3qlEcdes0RfCvwT00qsMwMI8
	igee53WAKVZIlobzdady61A3M+yr7dmTdwdZcY2P
X-Received: by 2002:a05:6830:927:b0:7f8:4ebe:2854 with SMTP id 46e09a7af769-850fb0769c4mr8385648a34.4.1793113680898;
        Tue, 27 Oct 2026 08:08:00 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-850fa99ccfbsm11397711a34.5.2026.10.27.08.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 08:08:00 -0700 (PDT)
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
Subject: [PATCH] scsi: qedi: fix OOB read in login/text response completion
Date: Tue, 27 Oct 2026 23:07:52 +0800
Message-ID: <20261027150752.951217-1-bsdhenrymartin@gmail.com>
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

qedi_process_text_resp() and qedi_process_login_resp() take the payload
length straight from the CQE field (hdr_second_dword &
ISCSI_{LOGIN,TEXT}_RESPONSE_HDR_DATA_SEG_LEN_MASK, 24 bits) written
back by the adapter, without any bounds check:

	pld_len = cqe_text_response->hdr_second_dword &
		  ISCSI_TEXT_RESPONSE_HDR_DATA_SEG_LEN_MASK;
	qedi_conn->gen_pdu.resp_wr_ptr = qedi_conn->gen_pdu.resp_buf + pld_len;
	...
	__iscsi_complete_pdu(conn, ..., qedi_conn->gen_pdu.resp_buf,
			     (qedi_conn->gen_pdu.resp_wr_ptr -
			      qedi_conn->gen_pdu.resp_buf));

resp_buf is an 8192-byte buffer (qedi_iscsi.c).  A CQE whose data
segment length exceeds the buffer makes resp_wr_ptr point past its end,
and the fabricated length is then passed to __iscsi_complete_pdu() as
the response buffer size: an out-of-bounds read of the buffer (and
beyond) delivered to the iscsi userspace daemon over the iscsi_recv_pdu
netlink unicast.

Clamp the payload length to the response buffer size before computing
the write pointer, in both the login and text response handlers.

This issue was discovered by Tencent CodeBuddy Security.

Fixes: ace7f46ba5fd ("scsi: qedi: Add QLogic FastLinQ offload iSCSI driver framework.")
Cc: stable@vger.kernel.org
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 drivers/scsi/qedi/qedi_fw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/scsi/qedi/qedi_fw.c b/drivers/scsi/qedi/qedi_fw.c
index 854efa4f61d87..24724fcba6571 100644
--- a/drivers/scsi/qedi/qedi_fw.c
+++ b/drivers/scsi/qedi/qedi_fw.c
@@ -115,6 +115,8 @@ static void qedi_process_text_resp(struct qedi_ctx *qedi,
 
 	pld_len = cqe_text_response->hdr_second_dword &
 		  ISCSI_TEXT_RESPONSE_HDR_DATA_SEG_LEN_MASK;
+	if (pld_len > qedi_conn->gen_pdu.resp_buf_size)
+		pld_len = qedi_conn->gen_pdu.resp_buf_size;
 	qedi_conn->gen_pdu.resp_wr_ptr = qedi_conn->gen_pdu.resp_buf + pld_len;
 
 	memset(task_ctx, '\0', sizeof(*task_ctx));
@@ -292,6 +294,8 @@ static void qedi_process_login_resp(struct qedi_ctx *qedi,
 	resp_hdr_ptr->status_detail = cqe_login_response->status_detail;
 	pld_len = cqe_login_response->hdr_second_dword &
 		  ISCSI_LOGIN_RESPONSE_HDR_DATA_SEG_LEN_MASK;
+	if (pld_len > qedi_conn->gen_pdu.resp_buf_size)
+		pld_len = qedi_conn->gen_pdu.resp_buf_size;
 	qedi_conn->gen_pdu.resp_wr_ptr = qedi_conn->gen_pdu.resp_buf + pld_len;
 
 	spin_lock(&qedi_conn->list_lock);
-- 
2.43.7
