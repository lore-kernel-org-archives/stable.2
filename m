Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68C139CCE0
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 07:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791876831; cv=none; b=j98JaBcb2/6TgkhY33BzXA+0jkcM4wNulSVaUdwldpPRBsigps7kLPER5ltW6v8d7ZjMvibJ/3pk06OfUHKL+nxPaDB2Xe+9baqkKa1n+wwL9cTyzJpsT/eNYSujhat61bTIkq3+f1FoMuLtfVgP1lBY+63Q9m0smYv62VBJMSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791876831; c=relaxed/simple;
	bh=v2xoffiL2VDz5NojqZv0T7MpCAZB7J4RpYDb1c9cCbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVx/JGWjOdoGeSMfIGal4fAub+lFdDtTdDmD+wnuL4qkHoWWnrEkhxKg/iorpVY+158RLXQx1DY+aNS3UgSi8jvGmyCPovFita0IjqMBZE7OeMJCTe2qRpHGMdK/aG957AelWJbaf5ret/wD0p32YSII9ckYZ6sux9GPVJWhvNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=Hf4tpKNR; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="Hf4tpKNR"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3a4cdc9025bso1254905a91.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 00:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1791876827; x=1792481627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=POSn5GjUfqQ74/iwNoPgD0VKPoE1QYtcinfIgdFuRqw=;
        b=Hf4tpKNRNVW/Dt/bmr3z6dyPkPsJz5pTzYVKIPAlLBhCjAqnuOQLPI8x67kpLaYlq1
         PHha7Bmw3n8mFsep3d9g3V1+8pYuadTcuxvJtlOvWM2iAa1jN/Cf45mmTgkp9F5VJTWU
         coMRov/VPo2ADeQ/Grh8iNi+Egfc3bnkGL45qePlaHakhWWF8i4DLfsOYQL5dRtJNpyO
         sRWQ5XvLZ8PG4iUqIRyu3uBXVD12V5DFMayGGBd2e8jrCRBa/EkaijbpWacMF6qTrjIc
         HjTfOzdl7sdv7Syy2eQseUSQh8aYQRC+GA6FLIU1KbweVlrt0Tv6sHyQoRVoL9hydoS4
         5cGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791876827; x=1792481627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=POSn5GjUfqQ74/iwNoPgD0VKPoE1QYtcinfIgdFuRqw=;
        b=zNWOMkcwGajPvd1LCcwivVdcXSlTo3wpONQRxe6iO1R0RQN6IK4AaTpvTCkKv+vn/n
         P/s2RwZO05UO313eLOHbKP4OgIlDedRXoVJX724D/CIE1LtwL//nP1aIg1I9JbXkdbUn
         XLkMDzT8TWkxlQFZZJ6CX2wT4hSVHk33VPpbxrmSskAtgG0vIZDNlO64rlbAd87/uHQm
         7nWy3RcidFN+qQd1uk1EWXvcccrgMgrPesQXmZK6YotW7s9ee35n9ryjDAiKnoJsvh5q
         aK4SrFjoh6ycEQVzFUGDe4EWgp81p+4og2Hx5wSVQKtEldg4LcIA3jm57yhwMp9P+ro3
         /HEw==
X-Forwarded-Encrypted: i=1; AKwUvBynEp3x6sE1HxOl5o6qmDHAqN9qxlv3g3fmi+2mHYti17W7hwNw28UKtlZQyy/j+XLQpms+6iI=@vger.kernel.org
X-Gm-Message-State: AFq9FYK/ir6ylWNDKbL6m2eDcxu+i3twk1jxDoQ/nwhQlZnDO+AOKfdW
	o0zL9tP+baLVhvWj/NJ4hxk3GKRpIT9TRcHdYBwZF+jq2H+FLhPCLWJShFagEITpxUA=
X-Gm-Gg: AYBFou3sjxtVBW1EFJwLkEfoNi/2QnTxv7tQ2LDoZk4cUapV2lX3HkbnDP/GZ0/q0XF
	NAI0unyqd5CYRbCHfUDqqp+N4yFQ8uo+HNy6cSg+uSmGn2Boct5kaOOBq+h2L2wOHM8utDGxU4O
	BcF65Zt9cvZAvEDtsl6UMx209Z0Ad3oXt4g+lbypbdBIlZ1qdcVfgE/kWKfzTfIkxkHpbKrouRW
	Jd9fiQrxLdt9WZTCxP/f0N5xUlJVmFkxqS97Llr7+YOB1U35DBTejyFsNwdnGYdf/CjCW0Q/nJi
	cbEy42wjbyOzX2OT7qaNbfLybLPrB7eR+Ez2AjYYZ4CeP0CXWl4qyjFP2PWOy61CNws42BUkPDL
	qdiN6IK0yIb279egUrELgD+4zUtbdqdprUEUopE6N7F74aTZh+/q9KBObq0Rh/d1cAVaDA5yIqn
	e8o6PpZzpahjCG2/XbYlfeOO0ZLyu1vcvCVu5abZumzdzg/UDMs6jnmXLEU3BUaiu33lntU+W5U
	5Y+qg==
X-Received: by 2002:a17:90b:3c0d:b0:3ab:b39f:41da with SMTP id 98e67ed59e1d1-3abb39f450amr5643655a91.11.1791876827134;
        Tue, 13 Oct 2026 00:33:47 -0700 (PDT)
Received: from yhlee-960QFG.. ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36ed0daesm19973923a91.5.2026.10.13.00.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 00:33:46 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v7 2/3] usb: gadget: f_tcm: reject a short write data-out transfer
Date: Tue, 13 Oct 2026 16:33:27 +0900
Message-ID: <20261013073328.2936318-3-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013073328.2936318-1-yhlee@isslab.korea.ac.kr>
References: <20261013073328.2936318-1-yhlee@isslab.korea.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

usbg_data_write_cmpl() copies se_cmd->data_length bytes out of the bounce
buffer into the command's scatter-gather list without checking how much the
host actually sent.  A BOT host can declare a larger OUT transfer than it
delivers and end the data stage with a short packet: req->actual is then
shorter than req->length, but the completion handler still commits the full
declared length.  The tail past req->actual is whatever was already in the
kmalloc'd bounce buffer, which is not zeroed, so uninitialised kernel heap
is written to the backing store and can be read back by the host.

Fail the command when req->actual does not match req->length instead of
committing the stale tail.  By the time usbg_data_write_cmpl() runs the OUT
data request has completed, so mark the command and skip the ep_out drain
in bot_send_bad_status() - there is nothing left on the wire, and draining
it re-arms ep_out for data the host already finished sending and wedges the
bulk pipe.  This mirrors how f_mass_storage stops draining once the host
ends the OUT stage.  A command rejected before its data stage still drains,
since the host has yet to send it.

A short 8192/4096 WRITE then commits nothing to the backing store instead
of 4096 bytes of stale heap, and no OUT drain is queued.

Fixes: c52661d60f63 ("usb-gadget: Initial merge of target module for UASP + BOT")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/usb/gadget/function/f_tcm.c | 14 +++++++++++---
 drivers/usb/gadget/function/tcm.h   |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index 12e2b20e33b92..a37a3ec8e7a4d 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -120,7 +120,8 @@ static void bot_send_bad_status(struct usbg_cmd *cmd)
 
 	csw->Residue = cpu_to_le32(cmd->data_len);
 
-	if (cmd->data_len) {
+	/* nothing to drain once the OUT data phase has completed */
+	if (cmd->data_len && !(cmd->flags & USBG_CMD_OUT_DATA_DONE)) {
 		if (cmd->is_read) {
 			ep = fu->ep_in;
 			req = fu->bot_req_in;
@@ -1090,8 +1091,15 @@ static void usbg_data_write_cmpl(struct usb_ep *ep, struct usb_request *req)
 		return;
 	}
 
-	if (req->status) {
-		pr_err("%s() state %d transfer failed\n", __func__, cmd->state);
+	/* the OUT data request completed; nothing is left to drain */
+	cmd->flags |= USBG_CMD_OUT_DATA_DONE;
+
+	/* a short data-out left the tail unwritten; don't commit stale data */
+	if (req->status || req->actual != req->length) {
+		struct usb_gadget *gadget = fuas_to_gadget(cmd->fu);
+
+		dev_err_ratelimited(&gadget->dev, "%s() state %d transfer failed\n",
+				    __func__, cmd->state);
 		goto cleanup;
 	}
 
diff --git a/drivers/usb/gadget/function/tcm.h b/drivers/usb/gadget/function/tcm.h
index e1d5a93916127..50764a33cdf36 100644
--- a/drivers/usb/gadget/function/tcm.h
+++ b/drivers/usb/gadget/function/tcm.h
@@ -88,6 +88,7 @@ struct usbg_cmd {
 
 	u32 flags;
 #define USBG_CMD_PENDING_DATA_WRITE	BIT(0)
+#define USBG_CMD_OUT_DATA_DONE		BIT(1)
 
 	/* UAS only */
 	u16 tag;
-- 
2.43.0

