Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9A448F852
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 07:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792395939; cv=none; b=CxQ4mhbT18MWTAmI/zfsmImWyhO4L5qtKT5Gyn8vD0FXTHz/nbWOY9fyBUaUY2KEDeTxfv4DCj4nsjHrylfnPuIAOf0VG0nkFEgCvNpej5Ki9zYsqOXV+uRX+rtVsg1aNi5uzWE7dEV2EPLsT0kVhquN2KaFNqqxA42/QbCRtRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792395939; c=relaxed/simple;
	bh=KFzqFt36Mxg0PEqNKBvEegXtqyyn8gNpLIWgf9rcm1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdcD5laHOfob/mCd1Vf2Nv71qVYyzecQxVutiuPX/wSN1hQLkLNf0gaYAyh8LPLq14U874EgJGQqmiTHPIWX/tJwdOMFYbg4Ck0og5EbCIZDI77wVNdFsPmUKv+VGYnQEpRaX9P7CMOO/vzd7w2IlgDkdx/x7O75temDYtyRFGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=lkGDhPri; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="lkGDhPri"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a05effaf8dso481327b3a.2
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 00:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1792395937; x=1793000737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wv36J9WWjzNdf3uQYboz2o0X4Yo9Dp1/goKB74IX4RI=;
        b=lkGDhPrif28OtIRvL0L3z93AfEpRueQC58X5YRV0578kpBXf7OYDM1WFLdxK6KIUXU
         8noVPg1gTW1YokbYruVnQ8Ty3FqidPmt1cXCx71coK3hZ4/B4Pgokdxv7MVhnMZ5qIU3
         Y1pFrkoj14n0fR1gVvWtL5Q6dTAtOG7a21uvGe1asQjwdlAH85kKSITAvTVlNyyEPbsz
         wFQQk47YZr7x6J10OWHAnJvjKJ9nlwzqu1wblabOOeKZPjbshbA7IEjq68L72HZNMSOk
         xTNWkwx6b0izOu+ZAPjwU16Sh7NW4AiT08zQJzuOpkTYTSyBGI+xD4/LrZAmu4eT7rj5
         XwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792395937; x=1793000737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wv36J9WWjzNdf3uQYboz2o0X4Yo9Dp1/goKB74IX4RI=;
        b=LyXlw5GQEcLKs9cjycSMPuQBAX/Zr5aXflq5Ke6aeEjjgie3mSGpUaUd4o3M2KrGYY
         v/p/4WIHGOt7lZzuYDkAOd3N31suWEpPnju3SG7CakdaHjBmjbBhLou35616Sq1XjoY+
         qNBt2+4joIuryx5IOUQN8UjT/tnsYyuU1c1I+IS4MyQhVE4QMTPOZRKMitZ8ITwfzBLr
         2INy2FX92BLAri2Pu8tLz/j4zw9S6u0Un5ml7qhZf1EF0BFjduUI5Dv9goQTo8pKcDaD
         hStehaPjbvm26HOtO7JjUlkP5VP+NS1pdijO8BLh8YKX4Ia4W3yzVXVJWHTqHorycbAb
         6POQ==
X-Forwarded-Encrypted: i=1; AKwUvBw3F8Ekmbc1KDhnaYCQi14JtbCCLA4CIaiRHF31TCF95TUn8mJeCHl2840XCz9EbD4AOWgaU8I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJiO9GYeYBxAAhix7Yt1ayMyxs3Po4Ak00yqcVpKwe4STtmtnIp
	hJLXEL8nfcF4OVeytpPsFiaWswK6WfOdDiejpIPg5q6X4PPxKv+RfsyiP9QqWr2l6Qw=
X-Gm-Gg: AYBFou0lYw/DlUwqRRolKn89/AC+Kq/RntrrHooGzscGHE2RjCaOy2oj1oiRY7JoMEr
	YIiJxhdGqcTEKqVzGWIV3wl4y/REGPns5T6LeubQFaoWaI0varJWc3mwW9q7wrUo37qVJ2dsNpW
	R2qi6AEXR/MUZPqKtpEWoq4Z4kQwG+9HQK9i/EDjD+TmhewIv65m1fOKnb29VKJZsm1yN8ZxxKx
	xxpHW/geXB8hjN1Qq/pgasTZzxykj+xKXV4InEU2g3yoECZBtgR8C6oIkCQ+GO17vgcMCwXqD7k
	eqUx2LK8bfBCtFfX3gfquBSUwiMEbssVlrz79Rj70Q+y/db42AgHZN2aNcdPT+pMVdCiMhW7u6M
	2568CqvNCBmIFFetJNlpl8o5lUJgeQRKOhmEnVGVG5HutVs179bVTv2lDhqCrSsKsNeVhF6Ibmk
	8dmZ6E9wnLnkn4Jysi8xE79NRNUdV1948ZWzn4lU2xUwIxZRdb127Nr5V1qEPyb7eXGKl3ZCX9m
	YcrYg==
X-Received: by 2002:a05:6a00:4c88:b0:89e:d76c:327f with SMTP id d2e1a72fcca58-8a04cd23fc7mr5017000b3a.34.1792395937189;
        Mon, 19 Oct 2026 00:45:37 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f58017244sm3494351b3a.47.2026.10.19.00.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 00:45:36 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: njavali@marvell.com,
	mrangankar@marvell.com,
	mkp@kernel.org,
	James.Bottomley@HansenPartnership.com
Cc: yhlee@isslab.korea.ac.kr,
	GR-QLogic-Storage-Upstream@marvell.com,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] scsi: bnx2i: bound the login and text response payload length
Date: Mon, 19 Oct 2026 16:45:21 +0900
Message-ID: <20261019074521.658170-3-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019074521.658170-1-yhlee@isslab.korea.ac.kr>
References: <20261019074521.658170-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnx2i_process_login_resp() and bnx2i_process_text_resp() take the payload
length out of the CQE and use it to place the write pointer inside the
buffer the chip DMA'd the payload into:

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

data_length is a u32 and nothing bounds it, so the padding bytes are
written wherever the length the chip reported puts the pointer.  resp_buf
is an ISCSI_DEF_MAX_RECV_SEG_LEN coherent DMA allocation, two pages with
nothing to spare, and pld_len is an int, so a large enough length puts the
pointer in front of the buffer instead of past it.  The length reaches
__iscsi_complete_pdu() afterwards as resp_wr_ptr - resp_buf.

The size is already on hand in gen_pdu.resp_buf_size, which so far has only
been handed to the chip in the login and text work queue entries.  Cap the
length with it.  The padding stays in bounds because resp_buf_size is a
multiple of four, so a capped length that needs padding is rounded up to at
most resp_buf_size itself.

Unlike the receive queue path in the previous patch this one is not covered
by the KUnit harness, since reaching these handlers needs a task and a
connection; the bound here is the size of the allocation the chip was
pointed at.

Fixes: cf4e6363859d ("[SCSI] bnx2i: Add bnx2i iSCSI driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
diff --git a/drivers/scsi/bnx2i/bnx2i_hwi.c b/drivers/scsi/bnx2i/bnx2i_hwi.c
--- a/drivers/scsi/bnx2i/bnx2i_hwi.c
+++ b/drivers/scsi/bnx2i/bnx2i_hwi.c
@@ -1461,7 +1461,10 @@
 	resp_hdr->active_version = login->version_active;
 	resp_hdr->hlength = 0;
 
-	hton24(resp_hdr->dlength, login->data_length);
+	/* The chip can only have filled the buffer it was given. */
+	pld_len = min_t(u32, login->data_length,
+			bnx2i_conn->gen_pdu.resp_buf_size);
+	hton24(resp_hdr->dlength, pld_len);
 	memcpy(resp_hdr->isid, &login->isid_lo, 6);
 	resp_hdr->tsih = cpu_to_be16(login->tsih);
 	resp_hdr->itt = task->hdr->itt;
@@ -1470,7 +1473,6 @@
 	resp_hdr->max_cmdsn = cpu_to_be32(login->max_cmd_sn);
 	resp_hdr->status_class = login->status_class;
 	resp_hdr->status_detail = login->status_detail;
-	pld_len = login->data_length;
 	bnx2i_conn->gen_pdu.resp_wr_ptr =
 					bnx2i_conn->gen_pdu.resp_buf + pld_len;
 
@@ -1526,13 +1528,15 @@
 	resp_hdr->flags = text->response_flags;
 	resp_hdr->hlength = 0;
 
-	hton24(resp_hdr->dlength, text->data_length);
+	/* The chip can only have filled the buffer it was given. */
+	pld_len = min_t(u32, text->data_length,
+			bnx2i_conn->gen_pdu.resp_buf_size);
+	hton24(resp_hdr->dlength, pld_len);
 	resp_hdr->itt = task->hdr->itt;
 	resp_hdr->ttt = cpu_to_be32(text->ttt);
 	resp_hdr->statsn = task->hdr->exp_statsn;
 	resp_hdr->exp_cmdsn = cpu_to_be32(text->exp_cmd_sn);
 	resp_hdr->max_cmdsn = cpu_to_be32(text->max_cmd_sn);
-	pld_len = text->data_length;
 	bnx2i_conn->gen_pdu.resp_wr_ptr = bnx2i_conn->gen_pdu.resp_buf +
 					  pld_len;
 	pad_len = 0;
