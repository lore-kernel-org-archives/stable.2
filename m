Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707995;
	b=n1D9xLl+XRbBPcti0gUlGOKFTb/BuQEhw/Va/c3gn/d1UmY68VvfboPYlA2zNytqlJGd
	 GCdLLBPCm+Rv7kxqdCXxdmLYBTIEQZZvhYoTdIdWNmB78I+mSQMBRHD16AasNEli4273C
	 GAmP7jg9/mrMkofgDZvH2CRBVK+doRW38XtjmiJ1pYG9HdxbLlEqfb7y+k88zh3mrSew4
	 SyKHCh4IrMDLQ9tk0+9fxESB//neiPlPH3eqI+KHMXo/LZ8/YnVq+TzTQszGhHFWHs2lI
	 5x7mckKdiEwCphH3pyAMsO/aLvxTF0f9M6L24k0T5cMrSTapviLWMfQC9LfMQY3i+jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707995;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MefJVAUwpTzBjIgXKDXq//nSPTgzfu659cwybf5WPco=;
	b=AmAtGsuKXPC8SKkihoMyec6tdXHE4cLhcp7tsw/9rf1dhOID5VJXo7aFoqrj7bclT61n
	 qCiOtIBQsfDW2WGUC4Aluz2zIgIOJb3vFigs/y/B7TTKmw+myhXOr1JUmwrT3AUuLytNn
	 wj+tzqdWudgY7vqALMv5pd6ZAZ/y7lNODk6/szLJCyM+N1Le321bjYo6Uuu5m/tB3FLIa
	 5onozluqHuFHVJ0/qjPSLw9OYtuzw3/fCWMYKgM+KbSvlrP/ln1xM84xkkJopWD/ZHHZM
	 qrocC0/CmefVFjAFUqMe8uRusCU87iQl5xf2G8VHnfPTdy7hTX4JIgcc8WtLp2LbZ/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EzXseuU4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19BC606A326
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EzXseuU4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560661F000EE;
	Thu, 26 Nov 2026 15:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795707995;
	bh=MefJVAUwpTzBjIgXKDXq//nSPTgzfu659cwybf5WPco=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EzXseuU4w9q55qUt5GpAWXlBU53ZmGfp57MSQUw28s0edKITXLGio2IvBUq88g65f
	 OHctNFdc5mvnV4Dn6+xRMm5sq4IzX9sKat9JW3WIN8Pur/mHPXoS1i3jfFnkcDGkz0
	 CPN6Cii9cJHb6iTjoeBm4eaMx4Uv9zj37Fz3H1ictoxTnwKULLTGO0G4Gy8gxDZLG6
	 MNXdEKoqXiuZY5w668+0YBkXyrUqmWTYKEWPz0sZTgIIuqxDS4UVrn4mG4/S65rEo3
	 hb+0kEM0XfiocBY3nr5qGT/KEyf0u7kK3cvRgmgIrISTd5uL73rEO4jMLmBOo9YJh4
	 +ctvEqDcjzskg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	stable <stable@kernel.org>,
	Selvarasu Ganesan <selvarasu.g@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] usb: dwc3: gadget: Track a timed out End Transfer
Date: Thu, 26 Nov 2026 10:46:30 -0500
Message-ID: <20261126154618.2487574-3-sashal@kernel.org>
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

From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>

[ Upstream commit af91c6322e633504aa45de278f5d520f39d127be ]

If an End Transfer command with CMDIOC times out, the driver clears the
resource index but keeps DWC3_EP_TRANSFER_STARTED without setting
DWC3_EP_END_TRANSFER_PENDING. The command is still outstanding, but a
later stop issues another End Transfer with resource index 0, and the
next Start Transfer fails with "No Resource".

Mark the timed out End Transfer as pending so that no other command is
issued to the endpoint until it completes. For any other failure, there
is no outstanding command, so clear DWC3_EP_TRANSFER_STARTED.

Fixes: e192cc7b5239 ("usb: dwc3: gadget: move cmd_endtransfer to extra function")
Cc: stable <stable@kernel.org>
Reported-by: Selvarasu Ganesan <selvarasu.g@samsung.com>
Closes: https://lore.kernel.org/linux-usb/3fdda532-8181-48e9-b58d-cad7289408e7@samsung.com/
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/5815c41a7e7923edb114741f29697cf0161f523c.1792542945.git.Thinh.Nguyen@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index a6245d36d0d40..636587226f537 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1719,9 +1719,9 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 
 	dep->resource_index = 0;
 
-	if (!interrupt)
+	if (!interrupt || (ret && ret != -ETIMEDOUT))
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
-	else if (!ret)
+	else
 		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
 
 	dep->flags &= ~DWC3_EP_DELAY_STOP;
-- 
2.53.0

