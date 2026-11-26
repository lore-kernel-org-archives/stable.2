Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795709215;
	b=mRc4GSvTrtpABqDK7rzNZMO5k1IDaBqPmIFkph8u4DWD5FSaLSCatyx3ZaMfxx/u+gor
	 a+OEj9AFRlpKmKUmnr9G83oHax4rpR6NIOPbCebohihNgSIlqyZ6eFwTiW1l29qwyLN3s
	 2l7BFp18FcBbWqDQluKmnbnvDLRfE6D78vXmLYhjh6FiYaeEj6tmUVBqHrhYXmouR9yPf
	 M9reK/vB3n9hgZKTiXnoB3T9MPaDsUvXE200VkRQvcrHNnwBQHagWSd+VD5noGC3Msn1/
	 CY5kol3D5+4zIoW6nN3oGP8QbTTINfB1KnNV9x+P2g9yGanOK8t61U9V0Sl9hleBbyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795709215;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AzHAvUjgDaxbLScv2atD8c76+4UCyvRSfdN4bBd4CXc=;
	b=DlfzZNmxC9N5tS52qQtMTjezyVrjsDpcOt3k+sZs10ixM87c+C4JyHdscuFjuYyrknHG
	 IWH8fQ0Mc17J8DxYiJeOkpZZwKvQs6jQIvFy7mGlRHVHLNHdBR6LcyJOP89WSfwOzxtbP
	 U8TgkjJ+BbQPPpyvJvrqsC1vEgmLDg7oqbXGpL0TpDYb6KwqEP3WD2kfU7x2S3/zChxxb
	 zmWhbHfNJlbAzzYlycR7vpy9tU0ela1zMMpRgDGIsQrre9X2pkfUcuMSrAp5Cou7e5WZF
	 tdGAzt25brTvmJlDAcqFEQW3yg+X1uce5QV4cadLvMpXn0TsqRHGCvd9Qadozpri7tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NOSBlvud;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86109606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NOSBlvud
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F93F1F000C0;
	Thu, 26 Nov 2026 16:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795709215;
	bh=AzHAvUjgDaxbLScv2atD8c76+4UCyvRSfdN4bBd4CXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NOSBlvudMQxmJ2XRqOJ/8P2JJRzu5VE/yhwpT34/JhkNGbUhrLUFcqE7z4lHExHFc
	 JQObkzRD33BMSYg6ipsFXesZf/N4jgptUbzSPGH3nHBzyra8qpc44JHaeQdqgcNreT
	 kLSMp3xgrzyKXTglfbDfD18yzj4yMkzDs938Pi6n88gYbC+bT08VED9ohvsoiWEK6G
	 wGUu6RpBTXUeDPb97emlXx9fHgrTQmTJ2N8W+OERM+yPIatcbrbUJCGOwdaaqeCVv2
	 smJMOKlEb57NeEnQbVX18b0sii4i4OHza/1acLzvpFQcTl8pkQRJh0066H1vXNxyvr
	 m3zbnai0Q50Ew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Prashanth K <quic_prashk@quicinc.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] usb: dwc3: Wait unconditionally after issuing EndXfer command
Date: Thu, 26 Nov 2026 11:06:51 -0500
Message-ID: <20261126160644.2531838-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112521-mating-confiding-a0fa@gregkh>
References: <2026112521-mating-confiding-a0fa@gregkh>
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
index 5ea6d0c929db2..c8b7f7f6ea56a 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1464,7 +1464,6 @@ static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
  */
 static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt)
 {
-	struct dwc3 *dwc = dep->dwc;
 	struct dwc3_gadget_ep_cmd_params params;
 	u32 cmd;
 	int ret;
@@ -1479,8 +1478,7 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
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

