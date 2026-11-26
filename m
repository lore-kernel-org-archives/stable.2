Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710011;
	b=x7CYa7Yf1ojlmjCKccfdQK0OdjwqIomh4L8sO/MzRXFaly4cYjAxyJqlPFXvumE4mZNR
	 KnsNalOYvRekCj8vR7+9XxAsWYrvEBEkY/GuWtr/ukTZsS5qFgHlZNYQynLkpv1+QCqgo
	 lf/+aBjdCdIqEdUrSJzhyqeWOBFVrP16immr+gNW5Cy0vaskzz6PigeegGEiTMDatgLLh
	 trH3dOmm25r/acg1pXQTDbiX8xK2NY13VGsHE//iPSLvnv8cXGtbAPKZYkikYRgK0fKPU
	 nEHwxOQ+5zz9FyEWd8gdBLXErcenOh5r37dE76vTWKP2KiOLqQQnkc4zGrGJ9BU77Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710011;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=st7iRIVBnhwog/Wb+LN/TMuDcnx+PjpHLapwwluz1l0=;
	b=NLszl4pfM48umJs0im0fpVAO90ed34kwgNO+O0tKkUOduUprgFqGmM4g+ZEWQvVZwNlo
	 uhBtOLIPmqe4wRDdk7QkQRlkGlOMmWK92E8o+LuIikN6WG4JrjuTYECVAAo5vHKHT1jUz
	 eSWebjuMPOH5RxBrYWov+BkfG4+cgNacoJmd6/FXoKW5DGdNEjm0KPJPxuvVJ7QXgeGnw
	 uBbF0jhS85os1Y6e2sOoWK9S2UAeqKzmSvrfRHGqd/WUvABavLGA0SCcGN4enZoPhIkVb
	 L6QQXI1GJocfWVvoyNnnVhMhqy/Yu3cI22Nux/MrRCX0ZrdHD7tRecdgCH5ZilkiSdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCVVBnqk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8271B606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mCVVBnqk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0D91F000D1;
	Thu, 26 Nov 2026 16:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795710011;
	bh=st7iRIVBnhwog/Wb+LN/TMuDcnx+PjpHLapwwluz1l0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mCVVBnqkBYBfbK/jkEWOZpBXevNeRTwB5Ws4V8H6VmIRRGSdUItraL2owWPnDkZWY
	 0vLxCt8/zkEeohabrQdyjHjP1jxHrGgDZZDCvstEF+2w2rkLJc8euYEvZaFJol2ZG4
	 sspuV7mRWosYla4KanAQPWKyraVLc3okfF3wFtIX6ewvtRNWHhco7cyVipC08rYHoX
	 xTdVp5aunr6xda197Sy1J8ixWuIEwJVyrZoRSeEhTQgVocyPwSPUyf63tG21dhiS+o
	 0slP2ZgjmVmdp3TTXdKqgjZ/bfasR9kDLFozIci4iEBaqfjdOof0gk4aEizluwIE9S
	 ZcGVpAOC1CXEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wesley Cheng <quic_wcheng@quicinc.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] usb: dwc3: Avoid unmapping USB requests if endxfer is not complete
Date: Thu, 26 Nov 2026 11:20:06 -0500
Message-ID: <20261126161938.2487645-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112536-chili-unchanged-4493@gregkh>
References: <2026112536-chili-unchanged-4493@gregkh>
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

From: Wesley Cheng <quic_wcheng@quicinc.com>

[ Upstream commit 2b2da6574e77ebf83c0df6d8b838bc37764c4bfa ]

If DWC3_EP_DELAYED_STOP is set during stop active transfers, then do not
continue attempting to unmap request buffers during dwc3_remove_requests().
This can lead to SMMU faults, as the controller has not stopped the
processing of the TRB.  Defer this sequence to the EP0 out start, which
ensures that there are no pending SETUP transactions before issuing the
endxfer.

Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
Link: https://lore.kernel.org/r/20220901193625.8727-2-quic_wcheng@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: e616d91e0288 ("usb: dwc3: gadget: Issue no-op Start Transfer only for stream endpoints")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/core.h   | 1 +
 drivers/usb/dwc3/ep0.c    | 5 ++++-
 drivers/usb/dwc3/gadget.c | 6 +++++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 78491e893d494..a788700fadc0b 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1566,6 +1566,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned int cmd,
 		u32 param);
 void dwc3_gadget_clear_tx_fifos(struct dwc3 *dwc);
+void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status);
 #else
 static inline int dwc3_gadget_init(struct dwc3 *dwc)
 { return 0; }
diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 9dd5f6f88e3b3..0a4442441adb4 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -306,7 +306,10 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 			continue;
 
 		dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
-		dwc3_stop_active_transfer(dwc3_ep, true, true);
+		if (dwc->connected)
+			dwc3_stop_active_transfer(dwc3_ep, true, true);
+		else
+			dwc3_remove_requests(dwc, dwc3_ep, -ESHUTDOWN);
 	}
 }
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 0fda58b77ebc1..e52275ec1f7df 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -976,12 +976,16 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 	return 0;
 }
 
-static void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status)
+void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status)
 {
 	struct dwc3_request		*req;
 
 	dwc3_stop_active_transfer(dep, true, false);
 
+	/* If endxfer is delayed, avoid unmapping requests */
+	if (dep->flags & DWC3_EP_DELAY_STOP)
+		return;
+
 	/* - giveback all requests to gadget driver */
 	while (!list_empty(&dep->started_list)) {
 		req = next_request(&dep->started_list);
-- 
2.53.0

