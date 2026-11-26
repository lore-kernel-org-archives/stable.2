Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707993;
	b=snyi0FGLlBjY6ldu0YoR4THsq3cuMcRb5bdLhZiaUWv/tsmVCmlepgiY4AfdW42+gy5G
	 9z+vKCvgc4C1WcNiUwPfY6OfPY1fiebbOyzBbA7AL+uV5DNNp0SnZ+DNJbyUEDHyIMK+K
	 GBDu4h6z+gAX8dIqIwpmnMakSvagXYICqDeEef+5EdX4KqsG+ubm7OZUlEipzER+YHnne
	 Yjsn/wz6Q1H2K517mQpAjiAB/URTvYlzb81xB5+SFTsIy+/DS6OptyoB7Y+WKUbMyK7KD
	 PFdjPeFW9zsrEwpKC6rWtFpGnbX4I9g9zQ7SiZp4BaDgXR5FEjpN5Fqu4B0RIoWsNCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707993;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZKZFGs8gEzmhdk/MIoCeGykD2s5xXuwKYYrx4O5kRDY=;
	b=ExC4gistml9KzUol3SpS3x+W4iFy/zII1NtavxNXiXHg3pcNmFbRn3cuZQE5rom2nbg1
	 TSow5jMQCUX+qhSOtngx0FMXBPpWzbfg8dIkXHD7w4cj/eeODArJYjbee+0lO2ioLRiaQ
	 jSwFyIj9jKpAjvfshXAEprARQQptRwJj3B7ALzuWDhR6vSYKFS0IYVJ4OiwP4S8dqy2lR
	 K9ESfecUYK8WTVAfZE+YYyOZahBDjzXU3ejsmpIKm9XKRx7kzujufLnyga5NlW7Zyg6jG
	 9UL1kdJF81f3nxayXpfDi9SqigXBxIw/IkWSXPEbnua/PMsa0A7qVzBLgCYTdnU0vRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MiY4R9Nx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CF5606A32C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MiY4R9Nx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062661F00A03;
	Thu, 26 Nov 2026 15:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795707993;
	bh=ZKZFGs8gEzmhdk/MIoCeGykD2s5xXuwKYYrx4O5kRDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MiY4R9Nx8PeMmDCvu/4HWBRKOSSIIud+nAHckfDCc3YYaPAHtJrgxWbNjcikuquIT
	 +wPzoKBpvoUZ8mfYL0q/RF7+ldLKeIiOpQt4YfDxarQ+Ij8AR4OyRMTOJiJ9LiK32c
	 uagW+kR+nICHQd0EfgfVZZ+yYIqj/71jY6n3SovhUPAG0hW1gb7TZDxn8gGqUge82l
	 RaI/wIUO2D2NVUmXeJJpeFpF8g+3ssfa/3Er+dJuiMdzKDXATaH1pY0LKc22UkZpIQ
	 jJn2oXlWDtAMgy9TqNxyJleB5jyCUUPjh/siRjWLjZlMWYrH9svyETw/xcRmeQjiAQ
	 M5vzqZW9EGr8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Prashanth K <quic_prashk@quicinc.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] usb: dwc3: Wait for EndXfer completion before restoring GUSB2PHYCFG
Date: Thu, 26 Nov 2026 10:46:29 -0500
Message-ID: <20261126154618.2487574-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126154618.2487574-1-sashal@kernel.org>
References: <2026112521-swinging-willed-f488@gregkh>
 <20261126154618.2487574-1-sashal@kernel.org>
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

From: Prashanth K <quic_prashk@quicinc.com>

[ Upstream commit c96e31252110a84dcc44412e8a7b456b33c3e298 ]

DWC3 programming guide mentions that when operating in USB2.0 speeds,
if GUSB2PHYCFG[6] or GUSB2PHYCFG[8] is set, it must be cleared prior
to issuing commands and may be set again  after the command completes.
But currently while issuing EndXfer command without CmdIOC set, we
wait for 1ms after GUSB2PHYCFG is restored. This results in cases
where EndXfer command doesn't get completed and causes SMMU faults
since requests are unmapped afterwards. Hence restore GUSB2PHYCFG
after waiting for EndXfer command completion.

Cc: stable@vger.kernel.org
Fixes: 1d26ba0944d3 ("usb: dwc3: Wait unconditionally after issuing EndXfer command")
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/20240924093208.2524531-1-quic_prashk@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: af91c6322e63 ("usb: dwc3: gadget: Track a timed out End Transfer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index ec31136a5f867..a6245d36d0d40 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -435,6 +435,10 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 			dwc3_gadget_ep_get_transfer_index(dep);
 	}
 
+	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_ENDTRANSFER &&
+	    !(cmd & DWC3_DEPCMD_CMDIOC))
+		mdelay(1);
+
 	if (saved_config) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
 		reg |= saved_config;
@@ -1715,12 +1719,10 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 
 	dep->resource_index = 0;
 
-	if (!interrupt) {
-		mdelay(1);
+	if (!interrupt)
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
-	} else if (!ret) {
+	else if (!ret)
 		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
-	}
 
 	dep->flags &= ~DWC3_EP_DELAY_STOP;
 	return ret;
-- 
2.53.0

