Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E753430CD92
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 01:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784942351; cv=none; b=uoZT4NldPa1EDcIbMGLIEggCW2ofokqZkdcwuZ78BYENaFoM9L8K3Vsb+kswagbILU03kFJvnXQv0kQsvN4LnSpxXEwbvb19xfSureU/SqKq5n1DaUSzu5hE0Q3/utW4k1pseiGYLJB5d1AF0Gq2te2tUqMZ21l6VANmP3I8qts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784942351; c=relaxed/simple;
	bh=kY97jMSaYFRyOhLuhoPk8ncA/FlWHmJxZkk5P6Xcjjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JvqkXQx07sWRpRfwempy/T0QYHxUaEjsiifjAnGtjRytJqS5JnbI43yBrK0TNMsFrL0c71B4Bsqe92P9Q5YskSHqv7d2gFIFqevbY7IwMigZ37cBVOtHeHWMWky6Rq7R+srLQTfSOYa2QKBQYBYwt2QpvWe5G6zln7nwMyE1598=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=hapLki+a; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="hapLki+a"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-381b831d535so1192892a91.0
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 18:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1784942347; x=1785547147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bvKGmGUyLkToHyhT3F1NkxRelwm5rOMQeA2DF+fE5zI=;
        b=hapLki+amV2KICvGcyyf8Bs3QQ9M2CAS/nhGXI5B6Dh3KqQoiA3aiIuc32s/t4/CbH
         bLHOJg00zZAWW454qhy2RelE54YxKR1PKJpsHn7HZSByegnyImi4zbEcwEXTuiL9uOTe
         9dK/7s4Bes/M7gcRYlaErdj60f/lsg3+R52Mu3PW8n0Ck1U6GDv++N3KfYXPXlvkXPok
         Z9yZRABPhlVzpOrR8dI1GW57rvDoapMd/2FiKgkWg1qa7JT8OEAQ7BB24/fH8X7qIQmr
         D3gwd4ZQvViJNrcKr/SF9VsiYk40XVDOLbbE7VK4UETtnKUAseyXEeISZKqka8nf/RaY
         pjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784942347; x=1785547147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bvKGmGUyLkToHyhT3F1NkxRelwm5rOMQeA2DF+fE5zI=;
        b=hbcjcjaqRo5Op8cbdg7x08KS2psRAeTJfA/srEjVnwE8looxT0vo+j983xUg1BYGxU
         +zn6Nn41aXYyYpp5yQf+HiB6zOrsgDbz2OLg4R+AD1/poQIpCwQ3asrS02snsuE2Qxip
         5ChsekhkK+4GRB8+3ksVSF0WKddYcpv9v+vZhkEIqrnrxQC9sBC3lo0ohBPxCIQSRTj6
         W2AxQcNexTmRJcK45OI3gDf+/e/XZOQUluUuORsDMERMGDQVVPbuFGigI/0590tOten6
         E7RHcg6TXp6BRuJVxxrl1Lb7a13hxjlzTuAlXnM0z6NL6q5jSNJ8rcY3N5AU0XtKjL5F
         xaww==
X-Forwarded-Encrypted: i=1; AHgh+RoiNL9H1zRsxwgUwtGPWhUCbklKhM1ZCkg2l6JKIaRp/eAvLpxcK+MGdVPkL3ggM2b4mmwPc2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf1p7Kg32Y+B5tKwQ5mRnS4951qKJVEq4huE0baja/mNdOl0G5
	zejvW5B+XJf6Pr/eVNqLz/p8bM7rwZzs8V4IDEH+Mcf4zcW77zZrouWfgl22iXwVSys=
X-Gm-Gg: AR+sD12NkkOEqHVnI4inriqpbFt4yr0Su0LVBh2B0u73sgal1dMOdoHdVT4l1K0kE2c
	379ruMca+kGC/0eCg3efRzS49L6DfGWuhZYoOO2qpe0onLZpwUKxNpY77kzxXuNpMJWFaf8/A6W
	XePuaIwmvOJHd9hUFe+MxkN3XmINDGE8TVhAzd+GY03f1+lP2tKkjot7u6/OEX46Ueh+pbVDAOC
	hoqRpb/b6YqDHKR0gk2ZzENIgyRzMX/Ae4Vn5PnuALeIP/nHjonkF3GCZChe5sZlFb0mSecHnMz
	4NDTYtdyCtRVZF4QBYDZpP6GXOqG+1FDHF/U5FoExAjmcPeCMVDUm+TOOFf+gc7bvSF5sBxqOaz
	hKg/QXGKMLB4BL+RKJggpY2auLNSapuv8eaXLhq/2UXk/n4WRvbpkSOa0frgibYcch/6j2P/mHF
	vjnquZhTvQmZs0M3bwFlkS6GXp
X-Received: by 2002:a17:90a:da83:b0:38d:dbc7:5178 with SMTP id 98e67ed59e1d1-38f296554d6mr687142a91.22.1784942347162;
        Fri, 24 Jul 2026 18:19:07 -0700 (PDT)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:27f4:9b8e:6315:1280])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f2951e62fsm234633a91.14.2026.07.24.18.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 18:19:06 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: sagi@grimberg.me,
	jgg@ziepe.ca,
	leon@kernel.org
Cc: nab@linux-iscsi.org,
	linux-rdma@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>,
	stable@vger.kernel.org
Subject: [PATCH] IB/isert: reject PDUs declaring more data than was received
Date: Sat, 25 Jul 2026 10:18:46 +0900
Message-ID: <20260725011846.538191-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

isert_recv_done() hands each received PDU to the opcode handlers without
ever looking at wc->byte_len, the number of bytes the HCA actually placed
in the receive descriptor. The handlers then copy that many bytes - the
data-segment length the initiator declared in the BHS
(ntoh24(hdr->dlength), via the derived unsol_data_len / imm_data_len) -
out of the fixed-size descriptor:

  isert_handle_iscsi_dataout():
        sg_copy_from_buffer(sg_start, sg_nents, isert_get_data(rx_desc),
                            unsol_data_len);
  isert_handle_scsi_cmd():
        sg_copy_from_buffer(cmd->se_cmd.t_data_sg, sg_nents,
                            isert_get_data(rx_desc), imm_data_len);

Because the declared length is never checked against wc->byte_len, an
initiator can declare a data segment larger than the bytes it actually
sent (and larger than the descriptor) and cause an out-of-bounds read of
the receive buffer.

Nothing upstream of isert closes this door:

  - __iscsit_check_dataout_hdr() bounds the inbound payload against
    conn_ops->MaxXmitDataSegmentLength (MXDSL) - a transmit parameter,
    used here for the inbound check.
  - iscsi_set_connection_parameters() sets
    ops->MaxXmitDataSegmentLength = ops->TargetRecvDataSegmentLength;
    and TARGETRECVDATASEGMENTLENGTH is absent from the min()-clamp list in
    iscsi_check_acceptor_state(), so the value the initiator declares is
    adopted verbatim (type range 512..16777215). The initiator effectively
    raises its own ceiling.
  - isert never clamps the negotiated value to its own fixed receive
    descriptor (ISER_RX_SIZE, 9216 bytes), so the target core's bound and
    the descriptor size are unrelated.

The imm_data_len == data_len path is more than an over-read: it aliases
the receive descriptor via sg_set_buf() and passes it to the backend as
the data source for the SCSI WRITE, so an over-declared length causes heap
contents past the descriptor to be written through the backend to the
backing store. The backend is the victim of the oversized scatterlist
isert hands it, not the cause; no read-back of the written bytes was
demonstrated.

Trigger: after login completes (full feature phase), an initiator that has
declared a large TargetRecvDataSegmentLength and a FirstBurstLength that
permits unsolicited/immediate data sends a PDU whose declared data-segment
length exceeds what was received. With KASAN:

  BUG: KASAN: slab-out-of-bounds in sg_copy_buffer+0x150/0x1c0
  Read of size 4096 at addr ffff888109720800 by task kworker/1:0H/25
  Workqueue: ib-comp-wq ib_cq_poll_work
  Call Trace:
   sg_copy_buffer+0x150/0x1c0
   isert_recv_done+0xba6/0x2390
   __ib_process_cq+0xe1/0x390
   ib_cq_poll_work+0x46/0x150

isert_recv_done+0xba6 resolves to isert_handle_iscsi_dataout()
(ib_isert.c:1160), inlined through isert_rx_opcode().

Validate wc->byte_len against the framing in isert_recv_done() before the
PDU reaches any handler, and reinstate the connection if it is short.
Because the test compares without subtracting the header length, it also
rejects PDUs shorter than the iSER and iSCSI headers, which would otherwise
be parsed out of stale descriptor contents. The sibling login handler,
isert_login_recv_done(), already rejects PDUs shorter than ISER_HEADERS_LEN
(commit 29e7b925ae6d ("IB/isert: Reject login PDUs shorter than
ISER_HEADERS_LEN")); the data handlers had no length check at all.

isert reads the data segment from a fixed offset: isert_get_data()
returns the iSER header plus ISER_HEADERS_LEN and makes no adjustment for
an AHS.  The bytes the handlers touch are therefore exactly
[ISER_HEADERS_LEN, ISER_HEADERS_LEN + dlength), and comparing that sum
against wc->byte_len bounds precisely the region that is read.  An AHS
term would only make the test stricter without bounding anything further,
and cannot cause a false reject: a PDU carrying an AHS is longer, not
shorter.

This is a memory-safety fix that verifies the bytes that were actually
received; it does not touch RFC 7145 length negotiation and is not the
MaxXmitDataSegmentLength negotiation redesign raised in the 2017 "[Query]
iSER-Target: QP errors observed on increasing MaxXmitDataSegmentLength"
discussion. That redesign is explicitly out of scope here.

The patched kernel rejects the malformed DataOut PDU and both
immediate-data variants with "PDU declares ... bytes were received" and
continues to pass normal traffic with no regression.

Reproduced with soft-RoCE (rdma_rxe) and a raw rdma_cm/ibv initiator; no
kernel-side test hooks were needed.

Fixes: b8d26b3be8b3 ("iser-target: Add iSCSI Extensions for RDMA (iSER) target driver")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/infiniband/ulp/isert/ib_isert.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 1015a51f750a..66435a0a5c7a 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -1333,6 +1333,21 @@ isert_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	ib_dma_sync_single_for_cpu(ib_dev, rx_desc->dma_addr,
 			ISER_RX_SIZE, DMA_FROM_DEVICE);
 
+	/*
+	 * The data segment length declared in the BHS is attacker controlled
+	 * and is used further down to read that many bytes out of the fixed
+	 * size receive descriptor, so it has to be checked against the number
+	 * of bytes that were actually received. Comparing without subtracting
+	 * also rejects PDUs shorter than the iSER and iSCSI headers, which
+	 * would otherwise be parsed out of stale descriptor contents.
+	 */
+	if (unlikely(wc->byte_len < ISER_HEADERS_LEN + ntoh24(hdr->dlength))) {
+		isert_err("PDU declares %u data bytes but only %u bytes were received\n",
+			  ntoh24(hdr->dlength), wc->byte_len);
+		iscsit_cause_connection_reinstatement(isert_conn->conn, 0);
+		return;
+	}
+
 	isert_dbg("DMA: 0x%llx, iSCSI opcode: 0x%02x, ITT: 0x%08x, flags: 0x%02x dlen: %d\n",
 		 rx_desc->dma_addr, hdr->opcode, hdr->itt, hdr->flags,
 		 (int)(wc->byte_len - ISER_HEADERS_LEN));

base-commit: 248951ddc14de84de3910f9b13f51491a8cd91df
-- 
2.43.0

