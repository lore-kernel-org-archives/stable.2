Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707997;
	b=Wj1b5Xye6KNdU61ra329ICAy5QcT6neCPnCTLcGRi+SQXvkjPbafIjZHEbJff7EYsy33
	 SnZ+ExNwBRO+gQ5aqt21TIIFmI7/6GUJCorfPUYlPTgap/yztJakS0ciSfUsp9KStIkbZ
	 yct/0RMw9RjqLUOCuEJoDvARR18ct3hmOP/ejnHzcoE+L6qzp6Tkl4KWGD0SwH/OdquuF
	 aveEkGVA54vlWk7Fv8G5ffkgQZmQDW60CJWIjGkEyvnKTcQ1Df/P1l1wG5Ds8XtMu8mqn
	 ShMUT2RE6wtyrCxYtpJH8pcO5CkgwXeVqBs2rJZRW+iEAxCOw7i/3kDp/JsRZbwvJBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707997;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SMt/upcmyClEUcZKv6MTINypDCZNsHg4t30U2ElmYX4=;
	b=QxKwjv/R6v4tTIgfrbnDtJ6ZLec8xoABSGKzmqWVMH24QPDHrSOv8fqls+fHUa5nZmSj
	 quy2WEt1S9ZDxuCt78BoJEIDJESPl2a5NHreHqHkOjCIA7TitWrfNaaa8idu3IDbN9AeC
	 S/g4iM/0kkXFK7CxDEGoEDt1GSpL8+HF+IHbLGgNYSn2gTJXNpRYE8vkWSmwjS8xrF7WY
	 SrjUkX37ABwdKYdzX0dfDahVsHJFg51dc/06KtFQ+kFnxvAcnFvox1ZFmlzIqIBB0PmxW
	 6q2kqCSGcvG0GHKl2sxQxfRKduefnoUuHokGNqt26/OY/i2BPITUahUjXoom6N3tRpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTTVeJgf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111C4606A323
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTTVeJgf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5651F000E6;
	Thu, 26 Nov 2026 15:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795707996;
	bh=SMt/upcmyClEUcZKv6MTINypDCZNsHg4t30U2ElmYX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eTTVeJgf0NCGxmn0GtFJka02Ul9xMzgablxUATQL46OQc9zqZFdpw3CSVGi3hk2m5
	 XW76eqmYxn4M2r2OkoXQk0iUxqLr89Ero1d2/LwG5BoWmP0HprSxGRSgHPJHOK6+es
	 32/618w74n1TsWFfLcANl0T/gIbQxd9/iYTEZZVx9ibJ/xd53Th5mQacW4dw52I7vZ
	 eevdptMfC9o31LST1QmyC2KylLzDf6nqvG3eVdmR+M6wIAB24R2lvU9m3Zp/ramGvW
	 h/ZMyCdPN6OOT6G96shX1XkNBixRYGJQm6FiKm7al0KdQUhn0rVDWcyaaEKZuOk8PG
	 11FHWW2xGI0bA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: dwc3: gadget: Reject requests to a disabled endpoint
Date: Thu, 26 Nov 2026 10:46:34 -0500
Message-ID: <20261126154605.2497617-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112500-sabotage-racing-0864@gregkh>
References: <2026112500-sabotage-racing-0864@gregkh>
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

[ Upstream commit 5eb11b1647b0534b3a61a21473d77ebf4ffbed7c ]

__dwc3_gadget_ep_disable() releases the lock while giving back requests,
and DWC3_EP_ENABLED is only cleared afterward. A function driver can
queue a new request in this window, and the driver would start a
transfer on an endpoint that is already disabled in hardware.

Clear DWC3_EP_ENABLED before giving back the requests, and reject
requests queued to an endpoint that is not enabled.

Fixes: 72246da40f37 ("usb: Introduce DesignWare USB3 DRD Driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/4ceab6aa5d6af0e4780f9d3a964fd5d8168a0a02.1792542945.git.Thinh.Nguyen@synopsys.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ sashal: adapted dwc3_writel() call to the older signature taking dwc->regs, and kept the existing dev_dbg() instead of dev_err() in the disabled-endpoint message. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 5ea6d0c929db2..d14cee7e588ea 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -812,6 +812,8 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 	reg &= ~DWC3_DALEPENA_EP(dep->number);
 	dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
 
+	dep->flags &= ~DWC3_EP_ENABLED;
+
 	dwc3_remove_requests(dwc, dep, -ESHUTDOWN);
 
 	dep->stream_capable = false;
@@ -1668,7 +1670,8 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
 {
 	struct dwc3		*dwc = dep->dwc;
 
-	if (!dep->endpoint.desc || !dwc->pullups_connected || !dwc->connected) {
+	if (!(dep->flags & DWC3_EP_ENABLED) || !dep->endpoint.desc ||
+	    !dwc->pullups_connected || !dwc->connected) {
 		dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
 				dep->name);
 		return -ESHUTDOWN;
-- 
2.53.0

