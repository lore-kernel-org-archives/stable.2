Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF483655CF
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 10:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781865763; cv=none; b=TSDmq9IAp6HOnhE7f8X4WRmC+bWsA+URngVtlBRU/XDGg+kJgiF4kliv3xHPsBNKG/anWTv1n7THOZoT6PkSOvsFr0O4L6W0H3HUxMKg0gnjnAhBqE3J5V9+kHPJqOz+8nGX8OD6IpjmiHlSRiBUGQqZbwyzQwH0rJmOcVIDglQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781865763; c=relaxed/simple;
	bh=d7wQD2SRd/b5HcWwTGAQG/8iGCr7bMydWNZicS/LIqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K9Y4fcLZ4r6YVSPRJe4xVjwQsalcQD1p5wBYesMpsiW4sM4Mfb6YAq3zQNRDlItO8TsPXXrtAWWgr9GFHddcMsCjrpgmzSP5pmFH87iNsH4DNtqoy9KsqEoIvHdylNsiyOCM8uPE8zPwHPwU+YiWXNWEJCvxUqkigN3sHrQdohI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKtdrpt9; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKtdrpt9"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-460166910e6so1229877f8f.2
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 03:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781865759; x=1782470559; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JmfL4fDWdtp3QfnCMbKyt4hwMdf5Ddyrer+vB+D7Auo=;
        b=OKtdrpt9lMFSnYFZTlEstGtL8JqvbonhopFTJAPQ1iyfLB/QkQ+D4DXK/v9haKjrJE
         Aqe61GPmi3B81BlP1nqWJNC2pKlMtByWuDk1VU3Yr6Mq7IMjXbq7T2OEIKXyi9gjB19V
         VN19FsoV2izTr7HT9xSY7xvUklgavt4zJ8+V8UFxu8p1jkhSu3+MNjHLtds0q1ZIGfNn
         NW5uiItMoGDWE0N4fgb71xmPMrfT6Yk9UUYS20hc8xfIblsrKNXP9RO6oORNJ3gbMRKv
         TLA811q8Zqod11zTcV1IkIHucE1zRGQ7uMEDBLOm94U66ccBc45yke7mLg69svCHdqPs
         dflw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781865759; x=1782470559;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JmfL4fDWdtp3QfnCMbKyt4hwMdf5Ddyrer+vB+D7Auo=;
        b=COvAwrhAd9eAayfiw1yrysH82BTUe977aFDO5J6FzjMdzPbOYshJhQUQcwWKnImXdp
         FkNi4Yz+g1ltDCD8KhC3Km5dxxG71IIBmgW3e+AlsFZ8MFzzEg0MLEyeB3feOPX+zcYV
         EW/IsjI7wxj5N9g4325Dn+vGbVChwD7tr07JIZHekX730NLAMXOPmjHxiNg+fbhu3H2H
         pCdGkXpUOEKGJ/HiKaRLLEqLAOL6Ytkrykth61X3utQh7tDbfC+cVvMD5jDfTWy/2M5p
         AE6OoGo7nJhel0ZVx8/IClNjksrW9ID/cT2wAWbSJKAhhu5Oabf/zKw2cK6q/gx+jJNT
         RbZw==
X-Forwarded-Encrypted: i=1; AFNElJ9LEZM4/DhDPjScY2QJw7Q1rZMBO0MTxQCdLEeStWkbne2Dym4Sobi+Sz9dAxWQ9HVC7sV5pkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUKm+xOIeoUkqYLHjGpfIpPyOt3vG+9xvtcdw78Zz/zF3gDQTu
	Id0ekf3WFfvvIS25RLcVYqgcQu7jiM0SbRk8IjcH6k10jNqC8TPl6Fyk
X-Gm-Gg: AfdE7cl/rWeHwdGS6K13jC7Igup/zM5UJE2CKjRVAgDj7x3GyUMjxHMsoSMzddVsYWV
	OB3l90Ze8aT/ar1T8T6uyR+0athTayHG/52Hi2uEdrnwPtf9zvsQ3eFK+ODMhkZexWhnbWnwx7U
	1URdkUWJo2bMT/UD0vyk5Lz2GH0rchou6Z3mOH7VGv3jbuDvU8VMNuDwXp2LMPW90jJVIyNHVlD
	/075F0VEy8dXADUuNqByWzgQA3Pbqwg1YY6EjfiBbY9AqxR6eX41eJC+Q8kxojv8uTv3qs1UluV
	yREQLwylGbZzgnc27cFX87MLyqEVBlEXLLV8NqNYVecKJanJccC8nVXtyVWrh5NBSB3ilvDLFpP
	kkgpahUW4hhUtqckZLP5gIbrUJi/2NYbBD3/fFVfLdSotTNOrMdUOcTV5JZ8LclVzAQc7ZeWYq+
	PsakyF5ykWXrpDUsPzr0jgLqwQpuczcgNF
X-Received: by 2002:a05:6000:298d:20b0:463:a83f:fc12 with SMTP id ffacd0b85a97d-46502bafa75mr4162045f8f.23.1781865759174;
        Fri, 19 Jun 2026 03:42:39 -0700 (PDT)
Received: from foxbook (bfg19.neoplus.adsl.tpnet.pl. [83.28.44.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4650bc429a1sm6751690f8f.30.2026.06.19.03.42.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 19 Jun 2026 03:42:38 -0700 (PDT)
Date: Fri, 19 Jun 2026 12:42:34 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: raoxu <raoxu@uniontech.com>, mathias.nyman@intel.com,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] xhci: pci: Disable soft retry for Renesas uPD720201
Message-ID: <20260619124234.0a9e4670.michal.pecio@gmail.com>
In-Reply-To: <62003881-4975-4bb2-a842-cb153ebd8cd4@linux.intel.com>
References: <D9BA02889D046D23+20260617100957.2888108-1-raoxu@uniontech.com>
	<62003881-4975-4bb2-a842-cb153ebd8cd4@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/a30Xhx_PbaPSoGRaznypMiF"

--MP_/a30Xhx_PbaPSoGRaznypMiF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

> On 6/17/26 13:09, raoxu wrote:
> > From: Xu Rao <raoxu@uniontech.com>
> > 
> > The Renesas uPD720201 xHCI controller can fail to complete
> > a Stop Endpoint command after a transaction error on an interrupt
> > endpoint when soft retry is used.
> > 
> > This was reproduced with this setup:
> > 
> >    xHCI: Renesas uPD720201, PCI ID 1912:0014 rev 03
> >    dev:  USB Ethernet device with an integrated Genesys Logic
> >          USB3.1 hub, USB ID 05e3:0626, and a Realtek RTL8153
> >          Ethernet function, USB ID 0bda:8153

Same thing with uPD720202 (1912:0015) here.

Is the hub even necessary? In my case I have one too, but I cannot
separate it from the RTL8153 for testing.

> > Reproducer:
> > 
> >    1. Plug the integrated USB hub and Ethernet device into the
> >       1912:0014 xHCI controller.
> >    2. Let r8152 bind to the 0bda:8153 RTL8153 Ethernet function
> >       behind the integrated hub.
> >    3. Bring the Ethernet device up.
> >    4. Hot-unplug the device.

In my case, necessary step 3.5: connect a cable and wait for the
"r8152: carrier on" message. Otherwise it disconnects cleanly.

> > The host reports a transaction error on the RTL8153 interrupt
> > endpoint, queues a soft reset, and later times out the Stop
> > Endpoint command while disconnecting the device:
> > 
> >    Transfer error for slot 8 ep 6 on endpoint
> >    Soft-reset ep 6, slot 8
> >    Ignoring reset ep completion code of 1
> >    xHCI host not responding to stop endpoint command
> >    xHCI host controller not responding, assume dead
> >    HC died; cleaning up

There is other stuff too, like concurrent teardown of a separate bulk
endpoint, not yet sure what exactly breaks these chips.

Would you mind to apply the attached debug patch, reproduce and post
dmesg from your system for comparison?

> > The Renesas 1912:0014 controller cannot safely use the xHCI soft
> > retry path. Set XHCI_NO_SOFT_RETRY for this controller so
> > transaction errors use the pre-soft-retry recovery path. With
> > this quirk the same hot-unplug test no longer times out the Stop
> > Endpoint command and the RTL8153 remains usable and stable.

A bit heavy handed, but we might find no better way.

On Thu, 18 Jun 2026 17:03:26 +0300, Mathias Nyman wrote:
> I'd appreciate your opinion on a related issue.
> I'm thinking about trying to recover from these stop endpoint command
> timeouts.

I can share a bit of mine. I tried aborting Stop EP on Etron and found
the EP in some bogus state afterwards (e.g. Running but Stop EP fails
with Context State Error, or Stopped but not responing to doorbells,
something like that, I don't remember). 

Per xHCI 4.6.9 there isn't really a case when this command should time
out, so it's always some internal bug/deadlock in the xHC and IMO good
chance that abort will leave at least this one EP or slot broken.

Another case is ASMedia, which doesn't seem to implement abort at all -
at least in my tests with Address Device and a dummy device that always
NAKs, abort simply waits for the command to finish (these chips have
internal 3 second timeout on Address Device). I would expect the same
for Stop EP, except that it likely lacks internal timeout. And the
driver will busy-wait for several seconds with IRQs disabled.

> While debugging this, did xHC controller otherwise seem somewhat
> functional? Did you for example see port status change events, or
> transfer events between queuing the stop endpoint command and the
> timeout?

Mouse continues to work until we kill the HC. And I can even abort the
command, but then some URB is never given back, so teardown of the USB
device gets stuck and IDK what would happen later.

Such recovery would be a bit of work, potential chip specific bugs and
frankly we can' be sure if the EP won't try to begin executing URBs.

The spec would advise to reset the broken chip, but that's also not
easy to do, particularly if we would like USB devices to maintain their
state. On the upside, I think it's similar to existing "USB persist"
mechanism, so core and drivers might be able to handle such things.

Regards,
Michal

--MP_/a30Xhx_PbaPSoGRaznypMiF
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=xhci-ep-info.patch

From 69a5add743e203fe58267eb4ac58cdf46b42920c Mon Sep 17 00:00:00 2001
From: Michal Pecio <michal.pecio@gmail.com>
Date: Mon, 28 Oct 2024 21:08:17 +0100
Subject: [PATCH] EP info debug

---
 drivers/usb/host/xhci-ring.c | 62 ++++++++++++++++++++++++++++++++++--
 drivers/usb/host/xhci.c      | 14 ++++++++
 drivers/usb/host/xhci.h      | 28 ++++++++++++++++
 3 files changed, 102 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index d9ada94ee52c..e4fee00a00b8 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -421,6 +421,8 @@ static unsigned int xhci_ring_expansion_needed(struct xhci_hcd *xhci, struct xhc
 /* Ring the host controller doorbell after placing a command on the ring */
 void xhci_ring_cmd_db(struct xhci_hcd *xhci)
 {
+	xhci_ep_info(xhci, 0, -1, "xhci_ring_cmd_db cmd_ring_state %d\n", xhci->cmd_ring_state);
+
 	if (!(xhci->cmd_ring_state & CMD_RING_STATE_RUNNING))
 		return;
 
@@ -565,6 +567,10 @@ void xhci_ring_ep_doorbell(struct xhci_hcd *xhci,
 	    (ep_state & EP_HALTED) || (ep_state & EP_CLEARING_TT))
 		return;
 
+	struct xhci_ep_ctx *ep_ctx = xhci_get_ep_ctx(xhci, xhci->devs[slot_id]->out_ctx, ep_index);
+	if (GET_EP_CTX_STATE(READ_ONCE(ep_ctx)) != EP_STATE_RUNNING)
+		xhci_ep_info(xhci, slot_id, ep_index, "ring_ep_doorbell stream %d\n", stream_id);
+
 	trace_xhci_ring_ep_doorbell(slot_id, DB_VALUE(ep_index, stream_id));
 
 	writel(DB_VALUE(ep_index, stream_id), db_addr);
@@ -779,6 +785,8 @@ static int xhci_move_dequeue_past_td(struct xhci_hcd *xhci,
 
 	if (stream_id)
 		trb_sct = SCT_FOR_TRB(SCT_PRI_TR);
+	xhci_ep_info(xhci, slot_id, ep_index, "queue_set_tr_deq stream %d addr %.8llx\n",
+			stream_id, (u64) addr);
 	ret = queue_command(xhci, cmd,
 		lower_32_bits(addr) | trb_sct | new_cycle,
 		upper_32_bits(addr),
@@ -1239,8 +1247,6 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
 			 * If the halt happened before Stop Endpoint failed, its transfer event
 			 * should have already been handled and Reset Endpoint should be pending.
 			 */
-			if (ep->ep_state & EP_HALTED)
-				goto reset_done;
 
 			if (ep->ep_state & EP_HAS_STREAMS) {
 				reset_type = EP_SOFT_RESET;
@@ -1250,6 +1256,12 @@ static void xhci_handle_cmd_stop_ep(struct xhci_hcd *xhci, int slot_id,
 				if (td)
 					td->status = -EPROTO;
 			}
+			xhci_ep_info(xhci, slot_id, ep_index, "handle_cmd_stop_ep stalled TD found %d handled %d\n",
+					!!td, !!(ep->ep_state & EP_HALTED));
+
+			if (ep->ep_state & EP_HALTED)
+				goto reset_done;
+
 			/* reset ep, reset handler cleans up cancelled tds */
 			err = xhci_handle_halted_endpoint(xhci, ep, td, reset_type);
 			xhci_dbg(xhci, "Stop ep completion resetting ep, status %d\n", err);
@@ -1872,6 +1884,10 @@ static void handle_cmd_completion(struct xhci_hcd *xhci,
 	}
 
 	cmd_type = TRB_FIELD_TO_TYPE(le32_to_cpu(cmd_trb->generic.field[3]));
+	int ep_index = TRB_TO_EP_INDEX(le32_to_cpu(cmd_trb->generic.field[3]));
+	xhci_ep_info(xhci, slot_id, ep_index, "handle_cmd_completion cmd_type %d comp_code %d\n",
+			cmd_type, cmd_comp_code);
+
 	switch (cmd_type) {
 	case TRB_ENABLE_SLOT:
 		xhci_handle_cmd_enable_slot(slot_id, cmd, cmd_comp_code);
@@ -2664,6 +2680,10 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->transfer_len));
 	ep_trb_dma = le64_to_cpu(event->buffer);
 
+	if (trb_comp_code != COMP_SUCCESS && trb_comp_code != COMP_SHORT_PACKET)
+		xhci_ep_info(xhci, slot_id, ep_index, "handle_tx_event comp_code %d trb_dma %.8llx\n",
+				trb_comp_code, (u64) ep_trb_dma);
+
 	ep = xhci_get_virt_ep(xhci, slot_id, ep_index);
 	if (!ep) {
 		xhci_err(xhci, "ERROR Invalid Transfer event\n");
@@ -2686,6 +2706,18 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 	/* find the transfer trb this events points to */
 	ep_trb = xhci_dma_to_trb(ep_ring->deq_seg, ep_trb_dma, NULL);
 
+	if (trb_comp_code != COMP_SUCCESS && trb_comp_code != COMP_SHORT_PACKET) {
+		u32 remaining, ep_trb_len;
+
+		remaining = EVENT_TRB_LEN(le32_to_cpu(event->transfer_len));
+		ep_trb_len = ep_trb ?
+				TRB_LEN(le32_to_cpu(ep_trb->generic.field[2])) :
+				~0;
+
+		xhci_ep_info(xhci, slot_id, ep_index, "handle_tx_event stream_id %d trb_len %u missing %d\n",
+				ep_ring->stream_id, ep_trb_len, remaining);
+	}
+
 	/* Look for common error cases */
 	switch (trb_comp_code) {
 	/* Skip codes that require special handling depending on
@@ -4411,6 +4443,18 @@ static int queue_command(struct xhci_hcd *xhci, struct xhci_command *cmd,
 int xhci_queue_slot_control(struct xhci_hcd *xhci, struct xhci_command *cmd,
 		u32 trb_type, u32 slot_id)
 {
+	char *type = "wtf";
+
+	switch (trb_type) {
+	case TRB_ENABLE_SLOT:
+		type = "enable";
+		break;
+	case TRB_DISABLE_SLOT:
+		type = "disable";
+		break;
+	}
+	xhci_ep_info(xhci, slot_id, -1, "queue_%s_slot\n", type);
+
 	return queue_command(xhci, cmd, 0, 0, 0,
 			TRB_TYPE(trb_type) | SLOT_ID_FOR_TRB(slot_id), false);
 }
@@ -4419,6 +4463,9 @@ int xhci_queue_slot_control(struct xhci_hcd *xhci, struct xhci_command *cmd,
 int xhci_queue_address_device(struct xhci_hcd *xhci, struct xhci_command *cmd,
 		dma_addr_t in_ctx_ptr, u32 slot_id, enum xhci_setup_dev setup)
 {
+	xhci_ep_info(xhci, slot_id, -1, "queue_address_device bsr %d\n",
+			setup == SETUP_CONTEXT_ONLY);
+
 	return queue_command(xhci, cmd, lower_32_bits(in_ctx_ptr),
 			upper_32_bits(in_ctx_ptr), 0,
 			TRB_TYPE(TRB_ADDR_DEV) | SLOT_ID_FOR_TRB(slot_id)
@@ -4435,6 +4482,8 @@ int xhci_queue_vendor_command(struct xhci_hcd *xhci, struct xhci_command *cmd,
 int xhci_queue_reset_device(struct xhci_hcd *xhci, struct xhci_command *cmd,
 		u32 slot_id)
 {
+	xhci_ep_info(xhci, slot_id, -1, "queue_reset_device\n");
+
 	return queue_command(xhci, cmd, 0, 0, 0,
 			TRB_TYPE(TRB_RESET_DEV) | SLOT_ID_FOR_TRB(slot_id),
 			false);
@@ -4445,6 +4494,8 @@ int xhci_queue_configure_endpoint(struct xhci_hcd *xhci,
 		struct xhci_command *cmd, dma_addr_t in_ctx_ptr,
 		u32 slot_id, bool command_must_succeed)
 {
+	xhci_ep_info(xhci, slot_id, -1, "queue_configure_endpoint in_ctx %.8llx\n", (u64) in_ctx_ptr);
+
 	return queue_command(xhci, cmd, lower_32_bits(in_ctx_ptr),
 			upper_32_bits(in_ctx_ptr), 0,
 			TRB_TYPE(TRB_CONFIG_EP) | SLOT_ID_FOR_TRB(slot_id),
@@ -4466,6 +4517,8 @@ int xhci_queue_get_port_bw(struct xhci_hcd *xhci,
 int xhci_queue_evaluate_context(struct xhci_hcd *xhci, struct xhci_command *cmd,
 		dma_addr_t in_ctx_ptr, u32 slot_id, bool command_must_succeed)
 {
+	xhci_ep_info(xhci, slot_id, -1, "queue_evaluate_context in_ctx %.8llx\n", (u64) in_ctx_ptr);
+
 	return queue_command(xhci, cmd, lower_32_bits(in_ctx_ptr),
 			upper_32_bits(in_ctx_ptr), 0,
 			TRB_TYPE(TRB_EVAL_CONTEXT) | SLOT_ID_FOR_TRB(slot_id),
@@ -4484,6 +4537,8 @@ int xhci_queue_stop_endpoint(struct xhci_hcd *xhci, struct xhci_command *cmd,
 	u32 type = TRB_TYPE(TRB_STOP_RING);
 	u32 trb_suspend = SUSPEND_PORT_FOR_TRB(suspend);
 
+	xhci_ep_info(xhci, slot_id, ep_index, "queue_stop_endpoint suspend %d\n", suspend);
+
 	return queue_command(xhci, cmd, 0, 0, 0,
 			trb_slot_id | trb_ep_index | type | trb_suspend, false);
 }
@@ -4496,6 +4551,9 @@ int xhci_queue_reset_ep(struct xhci_hcd *xhci, struct xhci_command *cmd,
 	u32 trb_ep_index = EP_INDEX_FOR_TRB(ep_index);
 	u32 type = TRB_TYPE(TRB_RESET_EP);
 
+	xhci_ep_info(xhci, slot_id, ep_index, "queue_reset_endpoint tsp %d\n",
+			reset_type == EP_SOFT_RESET);
+
 	if (reset_type == EP_SOFT_RESET)
 		type |= TRB_TSP;
 
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 849a568d0e63..0b96fd8bff12 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1853,6 +1853,9 @@ static int xhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 
 	for (; i < urb_priv->num_tds; i++) {
 		td = &urb_priv->td[i];
+		xhci_ep_info(xhci, urb->dev->slot_id, ep_index, "xhci_urb_dequeue cancel TD at %.8llx stream %d\n",
+				(u64) xhci_trb_virt_to_dma(urb_priv->td[i].start_seg, urb_priv->td[i].start_trb),
+				urb->stream_id);
 		/* TD can already be on cancelled list if ep halted on it */
 		if (list_empty(&td->cancelled_td_list)) {
 			td->cancel_status = TD_DIRTY;
@@ -1969,6 +1972,7 @@ int xhci_drop_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
 	u32 drop_flag;
 	u32 new_add_flags, new_drop_flags;
 	int ret;
+	int td_num = -1;
 
 	ret = xhci_check_args(hcd, udev, ep, 1, true, __func__);
 	if (ret <= 0)
@@ -1995,7 +1999,13 @@ int xhci_drop_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
 	}
 
 	ep_index = xhci_get_endpoint_index(&ep->desc);
+	struct xhci_virt_ep *vep = &xhci->devs[udev->slot_id]->eps[ep_index];
+	if (vep && vep->ring)
+		td_num = list_count_nodes(&vep->ring->td_list);
 	ep_ctx = xhci_get_ep_ctx(xhci, out_ctx, ep_index);
+	xhci_ep_info(xhci, udev->slot_id, ep_index, "xhci_drop_endpoint ctx_state %d td_num %d\n",
+			GET_EP_CTX_STATE(ep_ctx), td_num);
+
 	/* If the HC already knows the endpoint is disabled,
 	 * or the HCD has noted it is disabled, ignore this request
 	 */
@@ -2087,6 +2097,8 @@ int xhci_add_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
 	}
 
 	ep_index = xhci_get_endpoint_index(&ep->desc);
+	xhci_ep_info(xhci, udev->slot_id, ep_index, "xhci_add_endpoint\n");
+
 	/* If this endpoint is already in use, and the upper layers are trying
 	 * to add it again without dropping it, reject the addition.
 	 */
@@ -3388,6 +3400,8 @@ static void xhci_endpoint_reset(struct usb_hcd *hcd,
 	xhci = hcd_to_xhci(hcd);
 	ep_index = xhci_get_endpoint_index(&host_ep->desc);
 
+	xhci_ep_info(xhci, udev->slot_id, ep_index, "xhci_endpoint_reset\n");
+
 	/*
 	 * Usb core assumes a max packet value for ep0 on FS devices until the
 	 * real value is read from the descriptor. Core resets Ep0 if values
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 32617dc155ac..c46bd4697c7a 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1747,6 +1747,34 @@ static inline bool xhci_has_one_roothub(struct xhci_hcd *xhci)
 #define xhci_info(xhci, fmt, args...) \
 	dev_info(xhci_to_hcd(xhci)->self.controller , fmt , ## args)
 
+#define xhci_ep_info(xhci, slot_id, ep_index, fmt, args...)				\
+	do {										\
+		int ep_state = 0xfff;							\
+		int ctx_state = 0xf;							\
+		u64 ep_deq = 0xffffffff;						\
+		u64 ctx_deq = 0xffffffff;						\
+		u64 ep_enq = 0xffffffff;						\
+		if (slot_id > 0 && slot_id < MAX_HC_SLOTS &&				\
+				ep_index >= 0 && ep_index < 32 &&			\
+				xhci->devs[slot_id]) {					\
+			struct xhci_virt_device *vdev = xhci->devs[slot_id];		\
+			struct xhci_virt_ep *ep = vdev->eps + ep_index;			\
+			struct xhci_ep_ctx *ep_ctx =					\
+				xhci_get_ep_ctx(xhci, vdev->out_ctx, ep_index);		\
+			if (ep->ring) {							\
+				ep_deq = xhci_trb_virt_to_dma(ep->ring->deq_seg,	\
+								ep->ring->dequeue);	\
+				ep_enq = xhci_trb_virt_to_dma(ep->ring->enq_seg,	\
+								ep->ring->enqueue);	\
+			}								\
+			ep_state = ep->ep_state;					\
+			ctx_state = GET_EP_CTX_STATE(READ_ONCE(ep_ctx));		\
+			ctx_deq = le64_to_cpu(READ_ONCE(ep_ctx->deq));			\
+		}									\
+		xhci_info(xhci, "%d/%d (%.3x/%x) [%.8llx/%.8llx/%.8llx] " fmt,		\
+				slot_id, ep_index, ep_state, ctx_state,			\
+				ep_deq, ctx_deq, ep_enq, ## args);			\
+	} while (0);
 /*
  * Registers should always be accessed with double word or quad word accesses.
  *
-- 
2.48.1


--MP_/a30Xhx_PbaPSoGRaznypMiF--
