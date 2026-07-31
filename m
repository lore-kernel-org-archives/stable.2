Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7DB34D4F9
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 04:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785471232; cv=none; b=QD0qGSSxxhhQKW8Fsiz441OjTNbNX+k2+pcC1Yty8P0Bzlolp8mMNWuTZae0STfhKjJ3E6y1VR5XfQW0kHURdBf1HYNJW9GlWJpA7osit2S5cRBpPuT62VOuWGCZhrYUxxKb7z5DBwHWLU0WRIXjZvq/F2/IDx2UUBKmz+Sasxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785471232; c=relaxed/simple;
	bh=D8UuNWzqJeLMPd3fxp0yOHaQIXO9HrXwAk0i+bzUzzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QX0mz8+LAO52Z9tRireFHPP7DXI16YD+uVpGKn871l+b3Za5t7Vs/S5wd4ED5C9oASHurGFbNq/VEqDFhcmRVooyP33mg8+zl931B2X0SU86xsLROaE1eJJnbEnsBuRQxBcgj3JSKxn181C+/j3i4hvJYBkePBKl3eVFMyjaMdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=UjLq5RBR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="UjLq5RBR"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-848479c9bd5so505863b3a.3
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 21:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785471229; x=1786076029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Flqy4g9Cc+LdV45mmI6gA26Bq8MLwWr7oZ7btwtoMwc=;
        b=UjLq5RBRuyVb4b1zoH6RqAzALMIAtO3kuCFrdEAyCtjoZ2uK9NPGLTRh0RJVH5obQl
         Y6B5o68z1bWGDVISRueSO2lxfd3uX4hgAwX9O7gAGT/+DyaW5IrVb1Bjz1qCMT2lMDUY
         ftRFReQttWOXXPSDxPCUcwXW+OqrAGmlIN7XBlLtAW8oov2lQ/OQ5LX+Mjs3/U/77M1r
         LR6FaloE0HvXKe3oBNPExKFqnWhnb9fZbrdN3/gs13KxHl9SCLSbixv7NJXwAG1Kmq/d
         rNRcEdQrHsMM4OzEbZ/1HwjZhlWsUEQ8GxZ0iDjYFI1xXenf8o1m5VeCEPy+HF4Xfnud
         rydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785471229; x=1786076029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Flqy4g9Cc+LdV45mmI6gA26Bq8MLwWr7oZ7btwtoMwc=;
        b=HMnlWd+Zs6RgLwRWflrbEf++Oc1B9IiXMMBseznnSZOdt7kTS3cxhxJDuyGIJpXife
         UQp5BG7poB/HwROWoHsYnQZF2TnYDDoIln0FC5kaSyDqFnMYOGNmsHDy6TNbRQmQCvQN
         fS9FtyPrtQh22oNFTazaVehFlEMniOQCq8/8nRlyLBsGK9P0FPooG13CEqNx55L2+9nz
         QiZFr/xiuzYtqj0F5uBu5p24yKOOedh7Vhb25j0crCN1gIPdk+ZXS/KZPTs9eKC3mCy9
         ix1S0lEg8pyPt1NKL1OsoN+Vqkzt16zLPOSx8NyQ8P584wi/jFlHouYPa/pQk45yUfAO
         UZjg==
X-Forwarded-Encrypted: i=1; AHgh+RoHocNeqktJkLboGMRZ2ltVL0iD0tTjvk+H0BaGdm4u1FADgBrQT7vUTsgqzWA4nIn2uP1Mpuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDn/REiOEwmA9o0YBqCl6rW6In//BLzVdlmZlH+KtuRx3QTmho
	b0fMsefAQ774VB/zlYvCyU7Js2Q1w4QlnGn4EbZVKRlHBJftOr8QVHyDAs610cAXWwc=
X-Gm-Gg: AR+sD11MsTbBi8+WNjHSoSDnqBMnd3nNmkRvzkjjLYiPAwMRsFAmokEtlTetVfwaxoD
	Pvw4/dXjaixRcJgsWArNPkXovERuckgHH9wiZr2iF7FL2W01opO1noJULI1qMyTi7qKSrsSZ5y2
	wQlzDPmMxaq5ZbivqYRb49zFfwXyC7lFlBesWuUHT0f8cSqi4Qasn2bZ3j7/pUIyXyO87qB8Uw+
	XgjBiQG6FZq0gywvtM36muXpOQ7wZfXLejrnpaKa4+CgU24qy+NYFTB/fVILuFC9IfCPuw+Jklg
	w5hpoRaQ/H3g/DWmFAtnhQZ+VIhdj1FWbkOTx4s+jHT9sUZ5FAcR3vmvP1HVLlKXH231PgQRq6H
	v2KkXY+R8k0EHxcBY1/Mj2jj4IU30dbK7yI0BiqzfpMpXjgV+fEBoIcULR5vUIdxYNVllDmiIvS
	k5lKl9k4Ybv4sLTljUOprpFZRjmgs6bApRCDBdUhOEAj1RNJpRkFlifRQvECR+5mfuLDu9
X-Received: by 2002:a05:6a00:2e26:b0:848:2f74:d8d2 with SMTP id d2e1a72fcca58-84ed6f5151fmr378990b3a.67.1785471229183;
        Thu, 30 Jul 2026 21:13:49 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ed5782ea8sm195642b3a.1.2026.07.30.21.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 21:13:48 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: sagi@grimberg.me,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: michael.christie@oracle.com,
	martin.petersen@oracle.com,
	linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH v4 2/2] IB/isert: post the full-feature receive buffers after session registration
Date: Fri, 31 Jul 2026 13:12:12 +0900
Message-ID: <20260731041212.1733364-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731041212.1733364-1-yhlee@isslab.korea.ac.kr>
References: <20260731041212.1733364-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

isert_put_login_tx() posts the full-feature receive buffers before
__transport_register_session() runs, so an initiator that does not wait
for the final Login Response can still have a SCSI command executed
against an se_session whose se_tpg is NULL - the same oops as the
previous patch, at target_submit+0xbe.

Post them from isert_get_rx_pdu(), which the previous patch already uses
to send that response, and post them before that send: the receive queue
is filled at the moment the initiator is told it may use it.  Allocating
there keeps the existing property that a memory allocation failure cannot
happen once the final Login Response is on the wire.

The receive queue is already empty between the final Login Request and
isert_post_recvm(); this moves the second point later, from a median of
92 us to 172 us over 1200 logins.  Only an initiator that sends before it
has been told to can reach that window, and on IB and RoCE its send is
retried there until the buffers appear - isert_rdma_accept() asks for
rnr_retry_count = 7.  iWARP has no RNR flow control, so there the same
send terminates the connection instead.

Measured over rxe, 400 login cycles per run, with an initiator that does
not wait: an instrumented build counted no entries to isert_recv_done()
before the buffers are posted in 10 runs, where that initiator oopsed
8 of 10 unpatched runs and 5 of 10 with only the previous patch.

Not tested: iWARP, discovery sessions over iSER, and real HCAs.

Fixes: b8d26b3be8b3 ("iser-target: Add iSCSI Extensions for RDMA (iSER) target driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
v4: 2/2 replaced.  v3's version rejected such PDUs from isert_recv_done()
    and reinstated the connection, which strands both iscsi kthreads because
    conn->conn_state is still TARG_CONN_STATE_IN_LOGIN when it runs; dropping
    the PDU instead leaves a gap in the CmdSN stream that
    iscsit_close_connection() then waits on.  Both reproduce; this does
    neither.
    v3: https://lore.kernel.org/all/20260730135110.1647384-1-yhlee@isslab.korea.ac.kr/

 drivers/infiniband/ulp/isert/ib_isert.c | 41 ++++++++++++-------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index e117cd2e62c9..545212ae4792 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -947,21 +947,7 @@ isert_put_login_tx(struct iscsit_conn *conn, struct iscsi_login *login,
 	}
 	if (!login->login_failed) {
 		if (login->login_complete) {
-			ret = isert_alloc_rx_descriptors(isert_conn);
-			if (ret)
-				return ret;
-
-			ret = isert_post_recvm(isert_conn,
-					       ISERT_QP_MAX_RECV_DTOS);
-			if (ret)
-				return ret;
-
-			/* Now we are in FULL_FEATURE phase */
-			mutex_lock(&isert_conn->mutex);
-			isert_conn->state = ISER_CONN_FULL_FEATURE;
-			mutex_unlock(&isert_conn->mutex);
-
-			/* Sent from isert_get_rx_pdu() after registration. */
+			/* Posted and sent from isert_get_rx_pdu(). */
 			isert_conn->login_rsp_pending = true;
 			return 0;
 		}
@@ -2595,13 +2581,26 @@ static void isert_get_rx_pdu(struct iscsit_conn *conn)
 	struct isert_conn *isert_conn = conn->context;
 	struct completion comp;
 
+	/* The login timeout timer can fail the login after isert_put_login_tx(). */
+	if (!isert_conn->login_rsp_pending)
+		return;
+
+	isert_conn->login_rsp_pending = false;
+
 	/* The session is registered by now; see isert_put_login_tx(). */
-	if (isert_conn->login_rsp_pending) {
-		isert_conn->login_rsp_pending = false;
-		if (isert_login_post_send(isert_conn,
-					  &isert_conn->login_tx_desc))
-			return;
-	}
+	if (isert_alloc_rx_descriptors(isert_conn))
+		return;
+
+	if (isert_post_recvm(isert_conn, ISERT_QP_MAX_RECV_DTOS))
+		return;
+
+	/* Now we are in FULL_FEATURE phase */
+	mutex_lock(&isert_conn->mutex);
+	isert_conn->state = ISER_CONN_FULL_FEATURE;
+	mutex_unlock(&isert_conn->mutex);
+
+	if (isert_login_post_send(isert_conn, &isert_conn->login_tx_desc))
+		return;
 
 	init_completion(&comp);
 
-- 
2.43.0

