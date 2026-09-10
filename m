Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870FB1DED4C
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003960; cv=none; b=YTgQPsgBMcMnTKQX0zTqpHcEme9iQIOpurS6cy4cvQVlKmhIp/u/kYESNnJeVrU5BR/WAmCTBOyNcbtqvXOasqYhdwKSViI/z079eEDqz/j9Kr2D0E/6w9C0b4FqqF1HpAEm843kdOO2FcTB6KScAmUcnkAxEASuxsg1VUU43NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003960; c=relaxed/simple;
	bh=K3B4mWUd0OhbjP6tCmTrh3u+/KIBn5BjUeY+W3hsj2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f1am1jS4mJ/RJye0lIwlW26wGz3TwTfS3RZh6TExDvFvjBehzNZyeB4IL2aYRz1iIyvEx8LbRDh2k0efxVdGvKQXPv61s+/QO64qJBHMYsEaPpVTd1RUC3nlQ9b3+8Bddm8aEF82sfou7W2Hwb8/sFcdsf1QXV6jwXPdHPu85zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwIcz8sU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwIcz8sU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01231F00898;
	Thu, 10 Sep 2026 01:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003959;
	bh=wswfpxOHLj+umWiI8+2oWM3DmdcpCyy9mEXLixAfnqQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lwIcz8sU3stGOkluMgdpMLTydjRIzqF/X75CibpABLp+3A17eVXPbYsJewNi6guWs
	 ja7u0utsHXcDZyLq3oQu6V8XVrlI+CVOBK51WSSCTjbzQKsb0n7SIChkebQaLii24z
	 NZYcRv3jvaloL9Q0CIAm0HSSXUlj8KHYHvGnXsPtD3dOsH3UfW9Rnp1WiIpRJTQLZ/
	 tDJbyvgzg7XrepTcY4WnJ47Q4QBoPd/5Qfc/Vx6F6x6KmVUSHTc6DpQlS2OWPKd+Xa
	 JTJGW5ss7McHX0ca2XGLeN1g4f5QQDCy2erRKPmIBHG4LJnnNlY+4sZJCZirFW3M7G
	 k0t6GrO1v7a1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Elson Serrao <elson.serrao@oss.qualcomm.com>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] usb: dwc3: clear forceRM when issuing EndTransfer
Date: Wed,  9 Sep 2026 21:32:36 -0400
Message-ID: <20260910013236.3889340-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910013236.3889340-1-sashal@kernel.org>
References: <2026090819-kilometer-itunes-d755@gregkh>
 <20260910013236.3889340-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/dwc3/ep0.c    |  2 +-
 drivers/usb/dwc3/gadget.c | 21 +++++++++++++--------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index bcc9cc3980683..5e4f35e572659 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -304,7 +304,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 
 		dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
 		if (dwc->connected)
-			dwc3_stop_active_transfer(dwc3_ep, true, true);
+			dwc3_stop_active_transfer(dwc3_ep, false, true);
 		else
 			dwc3_remove_requests(dwc, dwc3_ep, -ESHUTDOWN);
 	}
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 3cf22447c0415..225bc433e3f83 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -991,7 +991,7 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 			 * controller to generate an ERDY to initiate the
 			 * stream.
 			 */
-			dwc3_stop_active_transfer(dep, true, true);
+			dwc3_stop_active_transfer(dep, false, true);
 
 			/*
 			 * All stream eps will reinitiate stream on NoStream
@@ -1019,7 +1019,7 @@ void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status)
 {
 	struct dwc3_request		*req;
 
-	dwc3_stop_active_transfer(dep, true, false);
+	dwc3_stop_active_transfer(dep, false, false);
 
 	/* If endxfer is delayed, avoid unmapping requests */
 	if (dep->flags & DWC3_EP_DELAY_STOP)
@@ -1709,7 +1709,7 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 		if (ret == -EAGAIN)
 			return ret;
 
-		dwc3_stop_active_transfer(dep, true, true);
+		dwc3_stop_active_transfer(dep, false, true);
 
 		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
 			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_DEQUEUED);
@@ -1746,6 +1746,11 @@ static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
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
@@ -1871,7 +1876,7 @@ static int dwc3_gadget_start_isoc_quirk(struct dwc3_ep *dep)
 		 * to wait for the next XferNotReady to test the command again
 		 */
 		if (cmd_status == 0) {
-			dwc3_stop_active_transfer(dep, true, true);
+			dwc3_stop_active_transfer(dep, false, true);
 			return 0;
 		}
 	}
@@ -2154,7 +2159,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 			struct dwc3_request *t;
 
 			/* wait until it is processed */
-			dwc3_stop_active_transfer(dep, true, true);
+			dwc3_stop_active_transfer(dep, false, true);
 
 			/*
 			 * Remove any started request if the transfer is
@@ -2231,7 +2236,7 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 			return 0;
 		}
 
-		dwc3_stop_active_transfer(dep, true, true);
+		dwc3_stop_active_transfer(dep, false, true);
 
 		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
 			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_STALLED);
@@ -3343,7 +3348,7 @@ static void dwc3_nostream_work(struct work_struct *work)
 		dwc3_send_gadget_generic_command(dwc, cmd, dep->number);
 	} else {
 		dep->flags |= DWC3_EP_DELAY_START;
-		dwc3_stop_active_transfer(dep, true, true);
+		dwc3_stop_active_transfer(dep, false, true);
 		spin_unlock_irqrestore(&dwc->lock, flags);
 		return;
 	}
@@ -3687,7 +3692,7 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
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

