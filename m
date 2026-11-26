Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707195;
	b=YGpvNOmS+lq/DcWF20c12LG3gTqoGQ2R6OKYD7YnKIeXpqW5wt+Bilj26hZDvQiy2/ZA
	 KGHqYVk3iJHunfx9qU5ctiDbLPDOTavrzaawUFAFEU3lpATnhuvbLT3IqfvRSJnCi6ISk
	 dfEHB0htJ4RUTTLBWB+koadssOvOMs9TidtfQnsXjP4MohoLJH63e/uS95bydwt0k1W6T
	 a/+Nxdq1fAmz1I6K2cQ+oFBrgRYZ7oE1NEknGrHfBtigXqz0d4pInBtfggvu4ftSn6KkB
	 2TYcrxG80lm6cGVcsWw9YOrM0pvBHQ9+kdc3DYb6pG7qNnIDJPebw1lcPi9KtswK+OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707195;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3ccQjg1vU8fE+3ykZ1lInYsGCnkKEA+6QsEBc+//TBg=;
	b=MvF6xjd8LWpPGXp2rqpsCTqBTfAB11jopDS/rBOMnmq1H7bgIRJ8EQpwoyCdrvQxXQPs
	 jv640E0YHNcelxmh/sIPw8Jit1eX9Dy3WphPv/Urektkw37calyEHB+m63QWWdU4rh/LD
	 sWPjewCXWLEFRYKKvKe1vOMcJfY7wo/1WtT/zN7areimjE/TJwNRGKFK/er6NuaUGrmh/
	 BMHWrI+iGaW4Q+5tDYMLzJiROJhsrQNV+KWYwX2bmHTPaesMlTOJkrKK9nRNNofWe9u4g
	 eMCap8iIYiGXW6Y4ETA4aLMD5l2QXbkXDND4eqzmn/lAvcHUG2U5+lOFyIJGI8r3t6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uo0SMwQz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A066606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uo0SMwQz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A43E1F000C6;
	Thu, 26 Nov 2026 15:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795707194;
	bh=3ccQjg1vU8fE+3ykZ1lInYsGCnkKEA+6QsEBc+//TBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Uo0SMwQzbKQvPPBRYYKOfvrzC8l3RJ+m7i7qeu9l7USear+/U454zT0yTe9bAOEuG
	 c97dVUXy1/qhgj6WuBZ0efuty180NhatR+9Vw5g44/lbOYG+cNVXCUTPfeVZW1N7I5
	 gkhiC69huf/cKkCOUOHK9wSIhLWKcL90H4EF6KQxXCLwosVmzMoDIxYdK9LZ5iT4RY
	 Ko5h+wWCuydtg9AXj6bgUpjCdUT4nrSofFOj6PfTupBFbQyILAgUJKVIaF8Qe2lKSS
	 9GKTH+1hzenCbpame8iJJdN5lmxAD3Pa0gj21EHhKj5iK2zjEAfPexd/r+hXzkFqEq
	 MdQQF4so7+XXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] usb: dwc3: gadget: Reject requests to a disabled endpoint
Date: Thu, 26 Nov 2026 10:33:12 -0500
Message-ID: <20261126153243.2471009-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112500-lying-blot-de47@gregkh>
References: <2026112500-lying-blot-de47@gregkh>
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
[ sashal: Kept the tree's existing dev_err() in the context of the queue-path hunk instead of upstream's dev_dbg(), and the disable-path hunk's context uses dwc3_readl(dwc->regs, ...). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 0fda58b77ebc1..7a87245c3caab 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1027,6 +1027,8 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 	reg &= ~DWC3_DALEPENA_EP(dep->number);
 	dwc3_writel(dwc->regs, DWC3_DALEPENA, reg);
 
+	dep->flags &= ~DWC3_EP_ENABLED;
+
 	dwc3_remove_requests(dwc, dep, -ESHUTDOWN);
 
 	dep->stream_capable = false;
@@ -1907,7 +1909,8 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
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

