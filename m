Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710014;
	b=yr5lAqmhpyH43KKzntlAUIaKqxrLDznIlRXGyg+b+EYhTXhnmOm8/54iVQ3QW3KYJRGc
	 6mpIPAtLUSNO4zj8RG8Fu6UQU3rZfFGx07pw6EqJ28QlcL40U7DKMYuuumu274sld1Lrc
	 Ojtf4rxQYmpp7XR8Tc+OWXKvuPmO1hGJCTHtU0Huo0slGW7gONaDc0Tz/+NtAtQy5oY4c
	 S/krjGiZ6mySm9JQ/RtjTzozj3IlHvv3esnbgPZQ/n4KCZgAQWYWB7StPg3QRCJioRIan
	 2a8z73X5zR87FpqCAY/A3HQdLg1Wqw0UW4tTR48YRu/+56k2N5fM3I4fsaLNZpFfg2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710014;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bdNiVpUryss5NIjW1bzSafabwzFLBgbILtU+wz9SjqM=;
	b=QDXY0VrOUdRuaj3kMJoTQ7vPNuhUKLam7I+qpOfJ3+MDt08yj9ytqQrfJLJLH5s7G7dm
	 jH/sstU96oCzSPdKEote/3g37MHIIv4d711FSm22yKsfTURgPNWYXWpFGLPXt6X0wpbXD
	 Z/5IyPa5xAF+Y3MCc4fbO+Y9hOAyBjnMq28j9A09a0xJILhpswNlis1UVsncrF6ll/2PG
	 fgA3VUFRqLG+H7S5v5LrNKwPnH9QNqYv1M7BAkQRCGNA3BYQhXs7Y6GkAqIZfgdJ4a3Lu
	 55vpkoem05yUAwAS107NHBLelSxSHdKo8qffFpc8rJtA24aSKiroDK3wD0zwG3pz54A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iITSwKGD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E735606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iITSwKGD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A851F000CF;
	Thu, 26 Nov 2026 16:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795710013;
	bh=bdNiVpUryss5NIjW1bzSafabwzFLBgbILtU+wz9SjqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iITSwKGDcmxDAsmGymYUnQD9NlEIyHoQ7WXg4iPAES+SduOuKAv0INUwoTnSAWYz9
	 h2Z0lk4iaaXA514HD2yc+f9tCwqYp2IcyLPIkhl2irygIs4URiRhn5HA64M4L7WbR/
	 J9RA+pY8s9CMbfEHhSX+oPZajz9zoPNfZh1FKTn+xr5PXKU+X+v3/wynemrntpFqAF
	 Tx2TAl3pVGksZWs0nfl4cGNJnAh4R2ZsSZCoBWVaLTb2ktH9zDJvHUk43u3xhwoKpa
	 jnbUNYPCXRv3DCoHtbGLs5iWXVfTKU2Qz9cvI70BnwxK0TQEFOP2/G12JpXFYbZU31
	 uFLTJ4DdvN7+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Elson Serrao <elson.serrao@oss.qualcomm.com>,
	stable <stable@kernel.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] usb: dwc3: clear forceRM when issuing EndTransfer
Date: Thu, 26 Nov 2026 11:20:08 -0500
Message-ID: <20261126161938.2487645-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126161938.2487645-1-sashal@kernel.org>
References: <2026112536-chili-unchanged-4493@gregkh>
 <20261126161938.2487645-1-sashal@kernel.org>
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
index 0a4442441adb4..dda434c47b66d 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -307,7 +307,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 
 		dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
 		if (dwc->connected)
-			dwc3_stop_active_transfer(dwc3_ep, true, true);
+			dwc3_stop_active_transfer(dwc3_ep, false, true);
 		else
 			dwc3_remove_requests(dwc, dwc3_ep, -ESHUTDOWN);
 	}
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 17026105b5ea6..7bb843ec9592a 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -951,7 +951,7 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 			 * controller to generate an ERDY to initiate the
 			 * stream.
 			 */
-			dwc3_stop_active_transfer(dep, true, true);
+			dwc3_stop_active_transfer(dep, false, true);
 
 			/*
 			 * All stream eps will reinitiate stream on NoStream
@@ -979,7 +979,7 @@ void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status)
 {
 	struct dwc3_request		*req;
 
-	dwc3_stop_active_transfer(dep, true, false);
+	dwc3_stop_active_transfer(dep, false, false);
 
 	/* If endxfer is delayed, avoid unmapping requests */
 	if (dep->flags & DWC3_EP_DELAY_STOP)
@@ -1649,7 +1649,7 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 		if (ret == -EAGAIN)
 			return ret;
 
-		dwc3_stop_active_transfer(dep, true, true);
+		dwc3_stop_active_transfer(dep, false, true);
 
 		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
 			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_DEQUEUED);
@@ -1687,6 +1687,11 @@ static void dwc3_schedule_err_recovery(struct dwc3 *dwc);
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
@@ -1819,7 +1824,7 @@ static int dwc3_gadget_start_isoc_quirk(struct dwc3_ep *dep)
 		 * to wait for the next XferNotReady to test the command again
 		 */
 		if (cmd_status == 0) {
-			dwc3_stop_active_transfer(dep, true, true);
+			dwc3_stop_active_transfer(dep, false, true);
 			return 0;
 		}
 	}
@@ -2102,7 +2107,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 			struct dwc3_request *t;
 
 			/* wait until it is processed */
-			dwc3_stop_active_transfer(dep, true, true);
+			dwc3_stop_active_transfer(dep, false, true);
 
 			/*
 			 * Remove any started request if the transfer is
@@ -2179,7 +2184,7 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 			return 0;
 		}
 
-		dwc3_stop_active_transfer(dep, true, true);
+		dwc3_stop_active_transfer(dep, false, true);
 
 		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
 			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_STALLED);
@@ -3208,7 +3213,7 @@ static void dwc3_nostream_work(struct work_struct *work)
 		dwc3_send_gadget_generic_command(dwc, cmd, dep->number);
 	} else {
 		dep->flags |= DWC3_EP_DELAY_START;
-		dwc3_stop_active_transfer(dep, true, true);
+		dwc3_stop_active_transfer(dep, false, true);
 		spin_unlock_irqrestore(&dwc->lock, flags);
 		return;
 	}
@@ -3555,7 +3560,7 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
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

