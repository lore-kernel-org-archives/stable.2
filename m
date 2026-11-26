Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707992;
	b=rqFbdJniE0PfDjIIakDyXZN0Zf+dNB7uB8dlka81ZAssRzgNm4eKH334Bu60GiZNio5m
	 0h3iPrTnMIKYpwW3Pkq0EVD3/e6UyPwQV7u+hBzwNmbksm/xFA9g+79F4OaU80CTyc/JW
	 +NfEoL9MWiGvwUaRW2g4U6hgg672xqaEcOUIaZIt5ieIG1syz8ux8jlgyJ1162dVFA/D4
	 rEecmOsX1dpJXff7WIT6r6AR0G9RXXBtAKU+4dvPaY1qfx+XWvgpL6jOP837thx29xHPP
	 TaYRDLEJbF3wqVnqyIE5FRTDgcj/nakA6GAQkAMNU0jf7SgCpjLJEa6vxa18u62A1cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707992;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gMhm7Cv+XZdyvHGfq24oMiXyYYljymDJJ/reK/K6qdQ=;
	b=19I7fwa77AdQ22nom/HbI/vob8iwGHPCcWYj8dQMfXLXZug03sYtVQeKczH8YdbV1IsW
	 BUR60RXqgwShUzJM8JDMruXhxI7dKuNBqMbMDveWdunK5K+7GEtlfrCuw81nV1y7aBgbW
	 DJJ27In+UdJBiC8hchpM16rtc+nVCHA+cMhAIzdWeT33hGDGfuQyqW1zlfQHPD9ueNyX3
	 Cc1OSvIYr6/4q6/73GPIV2cDxKuIUyA28HVvUPY6zFeCqPgiFctDeArXF/bJSEZmLYbXU
	 POZdSrj100vmL1Z1zfsJbMsAosS1CWTap3hPTUAAgm23JucH+rykPA1KaS92f+vvQbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJQPkAMo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5102606A696
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FJQPkAMo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1EF91F000EC;
	Thu, 26 Nov 2026 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795707992;
	bh=gMhm7Cv+XZdyvHGfq24oMiXyYYljymDJJ/reK/K6qdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FJQPkAMoCPL4U7QgNfy0GDEq/p68ffvZiM9nTgAPAHTXGmlpZAFdg4anuSxwFAjVz
	 gTUHtGekFQ21mDAKwMZHERPoVDjwDOznWRcyEL0sF0wrJCEIVkB4HSRBW4XKOEJOjm
	 BdhqMIxgiXhMqbyEadLYH67LxQ/rtoTbm/jRaiscJdODzGzUBr0diI43WyfbCz5IvC
	 u1rL1y7MNmgUsHAPdlbIAlF5MtuVRjcs3HYE2CzXucrPBJZdomo1EkUIfQi92rtejD
	 7O756ZPD9UWPRGy8PnAMlrIUpjwtVqr9KRyYkoISdqN+dZ7e5d2OXPgRdLxQdpPj14
	 knTvnVcctlViA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Prashanth K <quic_prashk@quicinc.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] usb: dwc3: Wait unconditionally after issuing EndXfer command
Date: Thu, 26 Nov 2026 10:46:28 -0500
Message-ID: <20261126154618.2487574-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112521-swinging-willed-f488@gregkh>
References: <2026112521-swinging-willed-f488@gregkh>
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

[ Upstream commit 1d26ba0944d398f88aaf997bda3544646cf21945 ]

Currently all controller IP/revisions except DWC3_usb3 >= 310a
wait 1ms unconditionally for ENDXFER completion when IOC is not
set. This is because DWC_usb3 controller revisions >= 3.10a
supports GUCTL2[14: Rst_actbitlater] bit which allows polling
CMDACT bit to know whether ENDXFER command is completed.

Consider a case where an IN request was queued, and parallelly
soft_disconnect was called (due to ffs_epfile_release). This
eventually calls stop_active_transfer with IOC cleared, hence
send_gadget_ep_cmd() skips waiting for CMDACT cleared during
EndXfer. For DWC3 controllers with revisions >= 310a, we don't
forcefully wait for 1ms either, and we proceed by unmapping the
requests. If ENDXFER didn't complete by this time, it leads to
SMMU faults since the controller would still be accessing those
requests.

Fix this by ensuring ENDXFER completion by adding 1ms delay in
__dwc3_stop_active_transfer() unconditionally.

Cc: stable@vger.kernel.org
Fixes: b353eb6dc285 ("usb: dwc3: gadget: Skip waiting for CMDACT cleared during endxfer")
Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/20240502044103.1066350-1-quic_prashk@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: af91c6322e63 ("usb: dwc3: gadget: Track a timed out End Transfer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/gadget.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 0fda58b77ebc1..ec31136a5f867 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1685,7 +1685,6 @@ static void dwc3_schedule_err_recovery(struct dwc3 *dwc);
  */
 static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt)
 {
-	struct dwc3 *dwc = dep->dwc;
 	struct dwc3_gadget_ep_cmd_params params;
 	u32 cmd;
 	int ret;
@@ -1717,8 +1716,7 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 	dep->resource_index = 0;
 
 	if (!interrupt) {
-		if (!DWC3_IP_IS(DWC3) || DWC3_VER_IS_PRIOR(DWC3, 310A))
-			mdelay(1);
+		mdelay(1);
 		dep->flags &= ~DWC3_EP_TRANSFER_STARTED;
 	} else if (!ret) {
 		dep->flags |= DWC3_EP_END_TRANSFER_PENDING;
-- 
2.53.0

