Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795709216;
	b=uO1+78F3g2hle5nij0ZpI9BMINXb7ULZRFwHrs9DDWZmNkgkZLq0ejhloD4MqhnQce01
	 JlAu2JSQnG3jDlfeVRogpimNf9kfVY7TGn4FFb57uLZ/8lXrPYVuYmuRW4dRtUrWjfWaR
	 7Ozx2g50ssDWJuzNC/PzJz1FpMUrO2uKmV0paFK2TG25tEAnSl3fT4TtnjkRzAHlI47vh
	 /8zKcdQfAl+lj0eLtdS2e6B6rHVQCOAjYkH3azmohUb3o5Id0KNnUyAecWc0POiTmfeO1
	 NkI079L/Cf+jxd5f2rnlKCH2MjjWLxTcb2XR7/bc/QglFYCOOLIra+ZMvf+8G263ETw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795709216;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=V/dF3S9fkTC0SfSkSH7Zv31XgC75+VgEhYKqEN/Cl1E=;
	b=omh6m3inQSZYo1eO8ysYpdq6807Qg85NmZuXKfa6yKbtmBVD6xdKAr11/fFuNVExvI4E
	 2jNOzP6lFJfbOzriKq+IrY9D8egpjf6eoe6ePj/a5P0SjGinR3BHTgN3r6O6FKckt5Yuh
	 MFQh2SfbrCMmjciflEpZjGR/empax0t1HHpJsR5SaiLKJsGow6rER6yNtGxSR410CWT3x
	 pm8lRRFiS9VtEswNwXcQC5l24Zm3J6gNmv5D0/3k38/mZmp92V1oh4+DwNPPqmJlzLhQG
	 v+rz4BEinsliYe7e7+wC2exKHA/6YZTfbsFNZnrlrYGB+BchqoDSKsTjoovs9+xxJdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQmydGMN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619A1606A326
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TQmydGMN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D59C1F000CA;
	Thu, 26 Nov 2026 16:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795709216;
	bh=V/dF3S9fkTC0SfSkSH7Zv31XgC75+VgEhYKqEN/Cl1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TQmydGMND73ex2niXD4iK+RaMHr5bgf4HLZuiw2dKABLZXc2ZspHaurG9sRJRFlB8
	 fDN6GNGXeXRctEJfyal/eZL3wU+LEz+RmEvCHO/1ajG6ZEbwW3pmHdIDRZhNrVIIkB
	 RaRVikE2amafJfRm7yGt+kpVuMjMN1kNccgI5bd/W9tqZtEm6kHeLa7xR8OY3ux38X
	 aP04QDE/x6U+OcMTMUz8z2cCnXYjW6p3UnqVEnwZIJMytgVu+CT1IYf5hXVwKxd93I
	 FjPxr15oXvwWF2/B1bmWJIvecZOIhvlU4eH3/kq6WgYztO4v2GPXDTxJw2vTaDbHG3
	 DAOxg62A1b6IQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Prashanth K <quic_prashk@quicinc.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] usb: dwc3: Wait for EndXfer completion before restoring GUSB2PHYCFG
Date: Thu, 26 Nov 2026 11:06:52 -0500
Message-ID: <20261126160644.2531838-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126160644.2531838-1-sashal@kernel.org>
References: <2026112521-mating-confiding-a0fa@gregkh>
 <20261126160644.2531838-1-sashal@kernel.org>
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
index c8b7f7f6ea56a..3ee4812bebff5 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -417,6 +417,10 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned int cmd,
 			dwc3_gadget_ep_get_transfer_index(dep);
 	}
 
+	if (DWC3_DEPCMD_CMD(cmd) == DWC3_DEPCMD_ENDTRANSFER &&
+	    !(cmd & DWC3_DEPCMD_CMDIOC))
+		mdelay(1);
+
 	if (saved_config) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
 		reg |= saved_config;
@@ -1477,12 +1481,10 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 	WARN_ON_ONCE(ret);
 	dep->resource_index = 0;
 
-	if (!interrupt) {
-		mdelay(1);
+	if (!interrupt)
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
-	} else if (!ret) {
+	else if (!ret)
 		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
-	}
 
 	return ret;
 }
-- 
2.53.0

