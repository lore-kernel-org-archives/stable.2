Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.154.241.218
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317297;
	b=3NuFmpUmD/frkBTLp8OmogTVWRFt0+h+rZLWDpjf/4eNPVMvhwkdkqMA0uEstD87I8UV
	 3M5/uUXkcIZKShKyfKmkJ+PCWMeTanF1rROSGAG/Ex0tl/DwzUW/W9H1cjvzTdR/KJmsD
	 JKAS6233ahS2RQI3ydr7d97G6KrLk7RrfVfebSNAEAQ+IYitAyEDrkq656Ndlrzivcu/O
	 uqMzfDpRQDtMgMjG1gKbuL18d3p21YPKK0l58G/EWPluCmmSc6J0ZSXS9ges/2Q2E5AYP
	 imdTp77qGN7/XJQKnlnzlW/LftYZEYEgs2siqLWKyJofqMFWCqkLqpFDMyFd5/TQx0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317297;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:Organization:X-Mailer:MIME-Version:Content-Type:
	 X-Bm-Milter-Handled:X-Bm-Transport-Timestamp;
	bh=l14YgoDj6UsUcAbDEsM0PgXfMBZOn3CoIGk61o/gzMk=;
	b=4w8XTkCKj3QUMJc3W7OtBMMAkHU21rw+0QTrz+vCrpB5cXbPDwv5qaWujiaOHATC6sXD
	 ckAkqRcheEmMKWQK8OvJZ3f6BPf0ovueQbgOt4xXz22PAsxbnTNp5iWLZYzW2fE4VR41z
	 ZREoClil6s2Epgie03yqStt4VmqNr6bTzB7k4ZLjRYoVybz+5fffzJotUBP2sdoqlCWdE
	 AlMDYo4y3YthdQBSIQMCd1B1bHkJ1/11R09AzJBXAOe6XPTxMZxkT5zwHFUIcjMlMg++z
	 ooiwl91+R2jl4DuhehWAQ8Yi11sL7Xaxoerai36JoFVvybMV8cbmcLVyklifrgJqxSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=lauterbach.com;
	spf=pass smtp.mailfrom=lauterbach.com;
	arc=none smtp.remote-ip=62.154.241.218
Received: from bm.lauterbach.com (bm.lauterbach.com [62.154.241.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C4D606A325;
	Tue, 10 Nov 2026 13:28:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87C4D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lauterbach.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lauterbach.com
Received: from ingpc2.intern.lauterbach.com (unknown [10.2.10.44])
	(Authenticated sender: ingo.rohloff@lauterbach.com)
	by bm.lauterbach.com (Postfix) with ESMTPSA id 96B701A2EE074;
	Tue, 10 Nov 2026 14:28:06 +0100 (CET)
Date: Tue, 10 Nov 2026 14:28:06 +0100
From: Ingo Rohloff <ingo.rohloff@lauterbach.com>
To: Brian Ellis via B4 Relay <devnull+brianellis.gotenna.com@kernel.org>
Cc: brianellis@gotenna.com, Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] usb: dwc3: apply XCVRDLY after PHY init
Message-ID: <20261110142806.6c3aed36@ingpc2.intern.lauterbach.com>
In-Reply-To: <20261109-dwc3-xcvrdly-after-phy-init-v1-1-488ed0a0c7da@gotenna.com>
References: <20261109-dwc3-xcvrdly-after-phy-init-v1-1-488ed0a0c7da@gotenna.com>
Organization: Lauterbach GmbH
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-unknown-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/pW_pSM03sPOE5BUUld6eaQX"
X-Bm-Milter-Handled: 166a2dfb-2e12-4590-8fa5-72e30323519f
X-Bm-Transport-Timestamp: 1794317286637

--MP_/pW_pSM03sPOE5BUUld6eaQX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello Brian,

> Each link enumerates at 480 Mbps and passes traffic, 
> then drops 2.20-2.23 s after enumeration, and the host's
> attempts to re-enumerate the device fail.

I have a hypothesis what the problem is:
USB 2.0 LPM (Low Power Management).
Please try the attached patch.
If this helps: That's the origin why you loose the link.

It seems USB344x + DWC3 don't support USB 2.0 LPM in this combination.

Note: This problem only appears when your HOST USB Controller also
supports USB 2.0 LPM.
Meaning: Depending on your exact Host PC you might not see this effect.
Only recent PCs support USB 2.0 LPM; on my PC here only some specific
USB ports support USB 2.0 LPM. So on my PC it depends to which USB port
you connect the device to.


> Ingo, if your USB3340 board is still to hand, it would help to know
> whether its high-speed links stay up for more than a few seconds, with
> and without this change.

Yes this board is very much on hand ;-)
The high-speed link there stays up indefinitely.

> Not addressed here: on our board the ULPI ID read that a28de6335657 uses
> to detect the USB3340 fails when no cable is attached at boot, because
> this PHY only clocks ULPI with VBUS present, so the bit is never set and
> the port runs at full speed.

At least for my board this is not the case.

I get a completely stable 60Mhz ULPI clock regardless of if 
VBUS is present or not.

Which of course in turn means the ULPI ID can be read out without
any problems.

This very likely depends on how exactly you use the USB344x.
On my board I am using a USB3346 with the circuit described in

https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/00001880A.pdf

Figure 8-1 USB333X DEVICE APPLICATION DIAGRAM
(CONFIGURED FOR ULPI CLOCK OUTPUT MODE)

What kind of circuit does your board use?

> Fixing that needs a DT property and a binding update, so it is not part of this fix.

That was my original patch proposal: Use a DT property.
I got push-back on that idea. 
The auto-detection via using the ULPI ID is a lot nicer.
Of course this doesn't work if you don't have a stable ULPI CLK signal.

> What matters is when the bit is written, not its value.  Written at the
> end of dwc3_core_init() instead, GUSB2PHYCFG holds the same value
> (0x00022710 on this board), and high-speed links on the same board stay
> up: one ran continuously for over 1000 s with no receive errors, and 60
> re-enumeration cycles completed without a failure.

Where did the 60 re-enumeration cycles came from?
If the link "stays up", then why do you get a re-enumeration?

It might have something to do with what happens with the
ULPI PHY when USB 2.0 LPM gets active.
When the host looses the link (which should not happen in the first place)
because of USB 2.0 LPM, then it re-enumerates.
Depending on where you put the "dwc3_ulpi_setup(dwc);"
this re-enumeration after link loss (because of USB 2.0 LPM)
might then work.

But again the link should not be lost in the first place.

with best regards
  Ingo





On Mon, 09 Nov 2026 10:22:31 -0700
Brian Ellis via B4 Relay <devnull+brianellis.gotenna.com@kernel.org> wrote:

> From: Brian Ellis <brianellis@gotenna.com>
> 
> Commit a28de6335657 ("usb: dwc3: Support USB3340x ULPI PHY high-speed
> negotiation.") sets GUSB2PHYCFG.XCVRDLY in dwc3_ulpi_setup(), which
> dwc3_core_init() calls straight after ULPI init.  That is before
> dwc3_core_get_phy(), dwc3_phy_init(), dwc3_core_soft_reset() and
> dwc3_phy_power_on(), so the bit is already asserted while the PHY is
> brought up.
> 
> On a ZynqMP board (DWC3 2.90a, peripheral mode) with a USB3340, that
> ordering breaks high-speed links.  Each link enumerates at 480 Mbps and
> passes traffic, then drops 2.20-2.23 s after enumeration, and the host's
> attempts to re-enumerate the device fail.  We measured 12 such links on
> two host root ports; every one died in that window.
> 
> What matters is when the bit is written, not its value.  Written at the
> end of dwc3_core_init() instead, GUSB2PHYCFG holds the same value
> (0x00022710 on this board), and high-speed links on the same board stay
> up: one ran continuously for over 1000 s with no receive errors, and 60
> re-enumeration cycles completed without a failure.
> 
> Move the dwc3_ulpi_setup() call to the end of dwc3_core_init().  The bit
> is still set well before any high-speed chirp, which only happens when a
> host enumerates the device.
> 
> Fixes: a28de6335657 ("usb: dwc3: Support USB3340x ULPI PHY high-speed negotiation.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Brian Ellis <brianellis@gotenna.com>
> ---
> How this was tested: not on mainline.  The failure and the fix were both
> measured on our board running AMD's 6.6-based vendor kernel (through
> ADI's tree), with a28de6335657 backported.  The backport calls
> dwc3_ulpi_setup() from the same place and differs only in handling a
> single USB2 port.  The 12 failing links were attached directly to two
> host root ports.  The 1000 s run was through a hub, on a kernel carrying
> this change plus five other local dwc3, ULPI and extcon patches.  The 60
> re-enumeration cycles were direct to two root ports, on a later build
> with more of our local USB fixes.  On mainline the change is
> compile-tested only (x86_64 allmodconfig, W=1, no new warnings).
> 
> Not established: why the ordering matters.  The outcome follows whether
> XCVRDLY is asserted before dwc3_phy_init(), not the value written, but
> we have not identified which step of PHY bring-up is sensitive to it.
> 
> Ingo, if your USB3340 board is still to hand, it would help to know
> whether its high-speed links stay up for more than a few seconds, with
> and without this change.
> 
> Not addressed here: on our board the ULPI ID read that a28de6335657 uses
> to detect the USB3340 fails when no cable is attached at boot, because
> this PHY only clocks ULPI with VBUS present, so the bit is never set and
> the port runs at full speed.  Fixing that needs a DT property and a
> binding update, so it is not part of this fix.
> 
> Tool use: an LLM coding assistant (Claude) helped run the investigation
> and keep its record, wrote the code change, and drafted this changelog
> and these notes from that record.  The measurements were taken on our
> hardware.
> ---
>  drivers/usb/dwc3/core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> index fd5c2cd36c..9b37ceda9a 100644
> --- a/drivers/usb/dwc3/core.c
> +++ b/drivers/usb/dwc3/core.c
> @@ -1371,8 +1371,6 @@ int dwc3_core_init(struct dwc3 *dwc)
>  		dwc->ulpi_ready = true;
>  	}
>  
> -	dwc3_ulpi_setup(dwc);
> -
>  	if (!dwc->phys_ready) {
>  		ret = dwc3_core_get_phy(dwc);
>  		if (ret)
> @@ -1534,6 +1532,9 @@ int dwc3_core_init(struct dwc3 *dwc)
>  		dwc3_writel(dwc, DWC3_GUCTL3, reg);
>  	}
>  
> +	/* XCVRDLY must not be asserted across PHY init, so set it last. */
> +	dwc3_ulpi_setup(dwc);
> +
>  	return 0;
>  
>  err_power_off_phy:
> 
> ---
> base-commit: 3149e8b3237f58d4dd440fc64c45c93404c4b064
> change-id: 20261109-dwc3-xcvrdly-after-phy-init-509803f4b0c8
> 
> Best regards,



-- 

-------------------------------------------------------------------------
Dipl.-Inform.
Ingo ROHLOFF
Senior Staff Engineer
phone +49 8102 9876-142 - ingo.rohloff@lauterbach.com

Lauterbach Engineering GmbH & Co. KG
Altlaufstrasse 40, 85635 Hoehenkirchen-Siegertsbrunn, GERMANY
www.lauterbach.com

Registered Office: Hoehenkirchen-Siegertsbrunn, Germany,
Local Court: Munich, HRA 87406, VAT ID: DE246770537, 
Managing Directors: Stephan Lauterbach, Dr. Thomas Ullmann

-------------------------------------------------------------------------

--MP_/pW_pSM03sPOE5BUUld6eaQX
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-usb-gadget-composite-Disable-USB-2.0-LPM-Low-Power-M.patch

From 58bd9ce416687c35ead5245820e42e74dc349018 Mon Sep 17 00:00:00 2001
From: Ingo Rohloff <ingo.rohloff@lauterbach.com>
Date: Fri, 28 Aug 2026 19:06:31 +0200
Subject: [PATCH] usb: gadget: composite: Disable USB 2.0 LPM (Low Power Mode)

Make sure, that the BOS descriptor sent to the host indicates, that there
is no USB 2.0 LPM support.

Note 1: DONT'T do this via
   dwc->gadget->lpm_capable = false;  // in dwc3_gadget_init()
because this would also disable LPM (Low Power Mode) for SuperSpeed; but
LPM for SuperSpeed seems to work without a problem.

Note 2: USB 2.0 LPM seems to be a mess!
=> There seem to be LOTs of (SuperSpeed capable) devices which have non
working USB 2.0 LPM.

Signed-off-by: Ingo Rohloff <ingo.rohloff@lauterbach.com>
---
 drivers/usb/gadget/composite.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 1b2238147cfe..59dcf5788f96 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -769,8 +769,10 @@ static int bos_desc(struct usb_composite_dev *cdev)
 		usb_ext->bLength = USB_DT_USB_EXT_CAP_SIZE;
 		usb_ext->bDescriptorType = USB_DT_DEVICE_CAPABILITY;
 		usb_ext->bDevCapabilityType = USB_CAP_TYPE_EXT;
-		usb_ext->bmAttributes = cpu_to_le32(USB_LPM_SUPPORT |
-							USB_BESL_SUPPORT | besl);
+//		usb_ext->bmAttributes = cpu_to_le32(USB_LPM_SUPPORT |
+//							USB_BESL_SUPPORT | besl);
+		// No USB 2.0 LPM support whatsoever please!
+		usb_ext->bmAttributes = 0;
 	}
 
 	/*
-- 
2.55.0


--MP_/pW_pSM03sPOE5BUUld6eaQX--
