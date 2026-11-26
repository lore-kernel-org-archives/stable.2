Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707140;
	b=Z8M2gcHbhH67knH/lNmyClE65MM3LD4tZ68JuCrOk6DHjcaSkCb11gpfpz75z1g/fyGP
	 p8qMTmUwROMbs1gYuMsjhgruHdaVnwMkKGMU59TcWR/e3NTRXlF5TUUES3K0bxm+eqhRo
	 6yeobQCAEUNrqZtBxA3A3bzmsLv+tLX96m9tZGOAnUtlRtMbzlNUQjZ/ne7EVB8dZHuTR
	 HCF9QgG0EbHF4IqDtUKj697ssVpid0bim+H2QlLOsAA+uIupZxMBG6GPRIlZQPKnLOnJ+
	 UWvur016gqcj7XOQKsg5h3LIV5idyypIOHR/jk8rrUMZXKS25H2NcKZKKvM2P7A+DRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707140;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MRguvQQj8fr3aWjUO1Fg1mhG42wYoAr1+yTcYe48bmY=;
	b=tHY5lvvDCszu0VYMe61yiO3PWCPJFDKL+BNOqswTa2g92Tcr5raRznYrx6HVsxtvzLuW
	 6KZ7NP5CpgMawALBVdTT7wE/721vrNPD55QwMdzFflphlNJzkv1GKcyX+surjGBmIu0j9
	 2tIxD+ZMPiH4x5JcfQpSPC/MR/mLH8bPNWq2zly6C6Zz97srj5fUq/S2WdDYPSYRbyKPE
	 rKrCtFDHrUAvsEL2+UaggqMojnXUVkh0FO4B6l7QFLECW+ocFS+U0MsRLV/5v1+boTE2Y
	 wfuhH8OXf9hx0FuLKQ0vOAtKrLrtiis7feHruMCj4GOaDC4C1m42QMZNrOwjj0YiprA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QxlfntoT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FFB606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QxlfntoT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C807B1F000C0;
	Thu, 26 Nov 2026 15:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795707139;
	bh=MRguvQQj8fr3aWjUO1Fg1mhG42wYoAr1+yTcYe48bmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QxlfntoTWoVxKm7OIbAS5obaxDOmn8WxpjHZgOEmId8wtYJQrc93YRdJhkOw+LzdP
	 xgtMC2xoRIkfABBzdqojeIS3Vm3hzYPMNEu73KW9+e8I6o09g2cTCF1IoUtkV5c/6g
	 313qf9jADB4efVKTpjmBT8e+/ELJSgFUTLodry7nrUXRMIDIMd1imRwbuU09wdAqQw
	 0zbcsVQUFhf4mrPiirgvNZz8k2HmPO4qZW7XS3eL12i3cWAW3yUGZ3mrfXkojYEW/A
	 dpD8mSGSqsIw8M2esI6eoJC31/N8MYYHanRRazpKQsignU9LZr6/0/HAn8cOzZAqI7
	 /BpwG78AUhIjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Elson Serrao <elson.serrao@oss.qualcomm.com>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] usb: dwc3: clear forceRM when issuing EndTransfer
Date: Thu, 26 Nov 2026 10:32:15 -0500
Message-ID: <20261126153139.2455075-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126153139.2455075-1-sashal@kernel.org>
References: <2026112535-humming-whimsical-6e80@gregkh>
 <20261126153139.2455075-1-sashal@kernel.org>
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

From: Elson Serrao <elson.serrao@oss.qualcomm.com>

[ Upstream commit b58e6200450d350314db0ecda7d6d1bde3281e80 ]

The forceRM bit of the DEPCMD register controls the behavior of the
EndTransfer command used to stop an active transfer. Older DWC3
programming guide revisions recommended setting forceRM=1 when
issuing EndTransfer. Newer programming guide revisions recommend
issuing EndTransfer with forceRM cleared.

With forceRM=1 on DWC_usb31 v2.00a and v2.10a controllers, a transfer
aborted through the ep_dequeue path was observed to remain active
after EndTransfer completion. A subsequent StartTransfer issued on the
same endpoint triggered writes associated with the aborted transfer.
This resulted in an SMMU fault because the transfer buffer had already
been unmapped during EndTransfer command-completion cleanup.

Using forceRM=0 eliminates the issue. Although older DWC3 programming
guide revisions recommended setting forceRM=1, no issues are known
from using forceRM=0. Clear forceRM when issuing EndTransfer to provide
consistent EndTransfer behavior and align with newer programming guide
recommendations.

Fixes: 1e43c86d84fb ("usb: dwc3: core: Add DWC31 version 2.00a controller")
Cc: stable <stable@kernel.org>
Signed-off-by: Elson Serrao <elson.serrao@oss.qualcomm.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://patch.msgid.link/20260813151456.867008-1-elson.serrao@oss.qualcomm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: e616d91e0288 ("usb: dwc3: gadget: Issue no-op Start Transfer only for stream endpoints")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/ep0.c    |  2 +-
 drivers/usb/dwc3/gadget.c | 21 +++++++++++++--------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index c4aa925bcd7cf..764360ac7e368 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -311,7 +311,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 
 		dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
 		if (dwc->connected)
-			dwc3_stop_active_transfer(dwc3_ep, true, true);
+			dwc3_stop_active_transfer(dwc3_ep, false, true);
 		else
 			dwc3_remove_requests(dwc, dwc3_ep, -ESHUTDOWN);
 	}
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 1ed6f4fc89eb9..67ec3de16652c 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -962,7 +962,7 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 			 * controller to generate an ERDY to initiate the
 			 * stream.
 			 */
-			dwc3_stop_active_transfer(dep, true, true);
+			dwc3_stop_active_transfer(dep, false, true);
 
 			/*
 			 * All stream eps will reinitiate stream on NoStream
@@ -990,7 +990,7 @@ void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status)
 {
 	struct dwc3_request		*req;
 
-	dwc3_stop_active_transfer(dep, true, false);
+	dwc3_stop_active_transfer(dep, false, false);
 
 	/* If endxfer is delayed, avoid unmapping requests */
 	if (dep->flags & DWC3_EP_DELAY_STOP)
@@ -1676,7 +1676,7 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 		if (ret == -EAGAIN)
 			return ret;
 
-		dwc3_stop_active_transfer(dep, true, true);
+		dwc3_stop_active_transfer(dep, false, true);
 
 		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
 			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_DEQUEUED);
@@ -1715,6 +1715,11 @@ static void dwc3_schedule_err_recovery(struct dwc3 *dwc);
  * the controller won't update the TRB progress on command
  * completion. It also won't clear the HWO bit in the TRB.
  * The command will also not complete immediately in that case.
+ *
+ * Older programming guide revisions recommended setting ForceRM to 1
+ * when ending a transfer. Newer programming guide revisions now
+ * recommend keeping ForceRM cleared, and TRBs are properly updated
+ * on command completion.
  */
 static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt)
 {
@@ -1843,7 +1848,7 @@ static int dwc3_gadget_start_isoc_quirk(struct dwc3_ep *dep)
 		 * to wait for the next XferNotReady to test the command again
 		 */
 		if (cmd_status == 0) {
-			dwc3_stop_active_transfer(dep, true, true);
+			dwc3_stop_active_transfer(dep, false, true);
 			return 0;
 		}
 	}
@@ -2131,7 +2136,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 			struct dwc3_request *t;
 
 			/* wait until it is processed */
-			dwc3_stop_active_transfer(dep, true, true);
+			dwc3_stop_active_transfer(dep, false, true);
 
 			/*
 			 * Remove any started request if the transfer is
@@ -2208,7 +2213,7 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 			return 0;
 		}
 
-		dwc3_stop_active_transfer(dep, true, true);
+		dwc3_stop_active_transfer(dep, false, true);
 
 		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
 			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_STALLED);
@@ -3267,7 +3272,7 @@ static void dwc3_nostream_work(struct work_struct *work)
 		dwc3_send_gadget_generic_command(dwc, cmd, dep->number);
 	} else {
 		dep->flags |= DWC3_EP_DELAY_START;
-		dwc3_stop_active_transfer(dep, true, true);
+		dwc3_stop_active_transfer(dep, false, true);
 		spin_unlock_irqrestore(&dwc->lock, flags);
 		return;
 	}
@@ -3611,7 +3616,7 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
 	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
 		list_empty(&dep->started_list) &&
 		(list_empty(&dep->pending_list) || status == -EXDEV))
-		dwc3_stop_active_transfer(dep, true, true);
+		dwc3_stop_active_transfer(dep, false, true);
 	else if (dwc3_gadget_ep_should_continue(dep))
 		if (__dwc3_gadget_kick_transfer(dep) == 0)
 			no_started_trb = false;
-- 
2.53.0

