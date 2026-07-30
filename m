Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C7F3B442F
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 06:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785393104; cv=none; b=N0KjskJ3fnOAk7UuVHEF8UqMlMgTYStgf56YMVbKJhzT4QfRBfZnbLH+UzaRLAIzbnV8KHD6GdyoDrma810AovpkkIvev9rJGB33UMfdEBHJ/dFzqCONe1azBh9XFP/wRYZP6fObJa/SCzJXF8mnmxPplH4X07FR6d8l4nqvOYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785393104; c=relaxed/simple;
	bh=EXpxwWwztD3fEM22BSVlO08z9mBvEKPFOIBfEilM0/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOarELhuh3bVjm1iUQuQybiNk6DcI9wFdow+uWmNok/8u6Ei1XuiHmU3HJL/2ZcoZuBg++e5mu78/C9KVNch1G30LmUxQe8gj9lHBSxvoTZ2Jx6Isy0hCTqvIawpFgW/M+k6xlLQBld2Y0gzGv95gUyQs1bd+TBZZiIwseUZ1B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=jQYH7vxr; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="jQYH7vxr"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cf50c6f235so19717735ad.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 23:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785393101; x=1785997901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0KVjCJTGOtgB/H7vksCOVOeu2PNewMcg63vsKNlch1M=;
        b=jQYH7vxrcOpVZdXbbTFqgGglpj+qnwXiEI87t8ZirmGockojn0s7zz3QNt4Fk7dkvT
         c2riQvtMbyRM5g9Dy+3NKgFjj6Z91ltcXbzw1EHLKzmaZ146p05DbpPoOKKN7gZFkqx8
         KdasIbG5QQplmBDhSdMXLrby9CXZZ4BJAQqTJaIqk2NJmO79LS/DBy9HQW1sOGDb4/lo
         J4EbQh+G56/YCBOlV5DKtARIQRKvtj5nmB1tJMqgpmG9kudWaDHJeKlnt0ak0or4kMq9
         OigOw+owh3qk0fK2U5WumTSArdAxJB+NNMs/0sVRH8WwT4nheW7Y3eEDguOtUPt6SFpa
         oGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785393101; x=1785997901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0KVjCJTGOtgB/H7vksCOVOeu2PNewMcg63vsKNlch1M=;
        b=mWYTZBCDmOOknTkqD/f8Q5QqFuFvjLRXKhyDW4C33IiWlUUIlgJialkHJR1M8AgouH
         zOok3rTMpvAaMnToOhzjqAR84zWYoWoAY3juKkk6K/bjC8QAk8LY8pWyeNivs/vrqfF1
         l6b9UoLoWXI3irIcN150vHY4W0HcqQUr/A/HI3mMPrYSQmhXHasS4nYJHWJFWOLU5rz2
         1g83zZJD3T01iu539tHlloHtKvE7W+yckKc6WWLYs5UZWWyulCWgFm58fELvqSdZcRtR
         6Yd8lPYFUuq8yTcfvW5DcfcSFgXhR11fhgQv4v4tuLTxyjibl74yM8zb7zbA2NiFRNOr
         9w+w==
X-Forwarded-Encrypted: i=1; AHgh+RofaqmBTej58uFT0TRpXvEGPf+kCvx6ugN9Z2EOfG9BnMPsrhI/71v+HKwSG3cY+Qxy3/xO5Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Kv1cWnEkMOiOEXn1aK2O6oTvxODBwPdmj0MdezoxaMfOrp+v
	q/hp8sDhxbhBUZnOFIT0r3Df4sA6591CIK0M9nhIEd94fPvvorfEdQckD4HKCjQHysc=
X-Gm-Gg: AR+sD11Re1eD1NWPj/B1vKJ0xMecqCJJ7ePJX/64Hu01GNNLTAIzhzxo9xxXqEBmXKH
	Mzi3E6PZ8/N68AlaVqp8+C4I6GLI010WX1cL7jsSFNUzZBuSKiFlGNaqmEfJj2jJurZBPCzi1y5
	jEKeSUmafaEqc82QCWXBm12AyW+NjwibeP4dKOAJpX50UZAJjSscbDGbS1tSR/w9+ABIQqnsVV8
	vECTdxgIt4STIYWOw9swDz1SKcyW5NWCsKUc96Z7pdpxRNTECpehe4Qb8vwRU9Wheb6Ok2WFmJH
	Uq45QJGhACnNJlwZ3be0E7fbuK4YUcGJTA7658nAEz6VbCCwL+vu5JDnrY1/LpKLadBaD7uqWyt
	hs+CprBFfKVhBI5aN3zuEYq43+NW+6vZj82/Ol9MFQdS5dFgcBIEtk0Scb2/hJHPqUh8FeDZrzv
	hzui0bgdZ5j+JhjM/mtPA3r+EhWBazY339LANTWv06//7uFydZd95ZrCZ2D+XnJqcDDlXB
X-Received: by 2002:a17:902:dacd:b0:2c8:4c29:afeb with SMTP id d9443c01a7336-2d035b89e3fmr13891105ad.8.1785393101219;
        Wed, 29 Jul 2026 23:31:41 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c50f43sm21144755ad.83.2026.07.29.23.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:31:40 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: sagi@grimberg.me,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: michael.christie@oracle.com,
	martin.petersen@oracle.com,
	linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH v2 2/2] IB/isert: reject full-feature PDUs that arrive before registration
Date: Thu, 30 Jul 2026 15:31:24 +0900
Message-ID: <20260730063124.1554460-2-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730063124.1554460-1-yhlee@isslab.korea.ac.kr>
References: <20260730063124.1554460-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The full-feature receive buffers are posted from isert_put_login_tx(),
which runs before __transport_register_session().  An initiator that does
not wait for the final Login Response can therefore still have a SCSI
command executed against an se_session whose se_tpg is NULL, with the same
oops as the previous patch.

Move the ISER_CONN_FULL_FEATURE transition into isert_get_rx_pdu(), where
it happens after the session has been registered, and reinstate the
connection on any PDU that arrives before it, the same call this function
already makes when a work completion fails.  A full-feature PDU before the
login has completed is a protocol violation.  The state is read without
isert_conn->mutex because isert_recv_done() runs on ib-comp-wq.

Measured over rxe with an initiator that fires SCSI commands into that
window without waiting for the Login Response, 400 login cycles per run:
the oops appeared in 6 of 10 runs with only the previous patch applied and
in 0 of 10 runs with this one on top.  The check fired 24 times across
those 10 runs, always in ISER_CONN_BOUND.  Well-formed traffic is
unaffected: the regression set passes 10/10 and a 400-cycle churn passes
400/400 with the check never firing.

Fixes: b8d26b3be8b3 ("iser-target: Add iSCSI Extensions for RDMA (iSER) target driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
New in v2.  Depends on 1/2 and must not be backported without it.

 drivers/infiniband/ulp/isert/ib_isert.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 93f2fec942dd..2a322df5202c 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -952,11 +952,6 @@ isert_put_login_tx(struct iscsit_conn *conn, struct iscsi_login *login,
 			if (ret)
 				return ret;
 
-			/* Now we are in FULL_FEATURE phase */
-			mutex_lock(&isert_conn->mutex);
-			isert_conn->state = ISER_CONN_FULL_FEATURE;
-			mutex_unlock(&isert_conn->mutex);
-
 			/* Sent from isert_get_rx_pdu() after registration. */
 			isert_conn->login_rsp_pending = true;
 			return 0;
@@ -1331,6 +1326,14 @@ isert_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		return;
 	}
 
+	/* A full-feature PDU before registration is a protocol violation. */
+	if (unlikely(READ_ONCE(isert_conn->state) != ISER_CONN_FULL_FEATURE)) {
+		isert_err("PDU received in state %d, resetting connection\n",
+			  isert_conn->state);
+		iscsit_cause_connection_reinstatement(isert_conn->conn, 0);
+		return;
+	}
+
 	rx_desc->in_use = true;
 
 	ib_dma_sync_single_for_cpu(ib_dev, rx_desc->dma_addr,
@@ -2594,6 +2597,12 @@ static void isert_get_rx_pdu(struct iscsit_conn *conn)
 	/* The session is registered by now; see isert_put_login_tx(). */
 	if (isert_conn->login_rsp_pending) {
 		isert_conn->login_rsp_pending = false;
+
+		/* Now we are in FULL_FEATURE phase */
+		mutex_lock(&isert_conn->mutex);
+		isert_conn->state = ISER_CONN_FULL_FEATURE;
+		mutex_unlock(&isert_conn->mutex);
+
 		if (isert_login_post_send(isert_conn,
 					  &isert_conn->login_tx_desc))
 			return;
-- 
2.43.0

