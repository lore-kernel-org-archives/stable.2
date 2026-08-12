Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9270370D56;
	Wed, 12 Aug 2026 01:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786498874; cv=none; b=XT94tWwxmwuj1SkxDrNMVcQWSeRxW9EAX+f/Rp1tWmzoVcsnDqL0EWc2G5Qq9kc4b+02Mt+O3GB1rqQuFTFYO97KOsO/+0dFzaU+bUDBZ/EgwomaOoqcJ6VYAY8OFyZi32/OMtWDYKl3nZwZS4zCRqei4pNi/oLa6YluxUI+FUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786498874; c=relaxed/simple;
	bh=zgxQ1Dlh38HZOImSEfZiP36YJ9/wuYQvRevSX5EiaEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JlB6zMTde5Po+vkTtfmQ3rjTBOw+qhw16KQAL6rRCDaOtQLqhKGOhLXbwfNu8hxfaTsRIpouh9smisJ/UoWUnicjih4d3HlgUej9kaA93hPIltrcl+vNBs9Gh7YjYKft+FVYr8R1SqVJL9O1wD61Y625u4LtwxbSxAPOyMrWUQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SevL2kYI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SevL2kYI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 303FA1F000E9;
	Wed, 12 Aug 2026 01:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786498872;
	bh=YDVhKIVRwhk7NjczVHRS/FNkLpxTfXl/HQj2fMs4j2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SevL2kYIpXIZjiVE3tSj+IOFi2FHZbHglTBaVFaudEB1eTPrryPkV8Z9X6y7vAAjd
	 eX0KPnk6el8K/5GIXaMRVTkjAaqwWCadkVTO52tbNhojCXs4RoKdlLhls47q0se2CJ
	 fbDt65Xk3uvwxFgBNhwekCRUfX6bmWEgJqn0ZyD4bE/pOTjuWdyO+XKVi7vGhVdUwC
	 qbO8QzvoonDC30WafEeLriT+NrKlSDdoMJvNrut37+u5MPFJ0XvcYWXsyj6vDsEDCg
	 mDCMpaE++1scufoZYcOK34lRayCubtwTKWLI2LHVg2Pa5nHACTFCTWbwZXJzzHoJ1j
	 A/LnExjoOXBWg==
From: Jakub Kicinski <kuba@kernel.org>
To: fabio.porcedda@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	bjorn@mork.no,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dnlplm@gmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] net: usb: qmi_wwan: add Telit Cinterion FE990D50 composition
Date: Tue, 11 Aug 2026 18:41:11 -0700
Message-ID: <20260812014111.1680631-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260810103409.133796-1-fabio.porcedda@gmail.com>
References: <20260810103409.133796-1-fabio.porcedda@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: usb: qmi_wwan: add Telit Cinterion FE990D50 composition

Adds a qmi_wwan products[] entry for USB ID 1bc7:0991 interface 0, using
the SET_DTR quirk, for the Telit Cinterion FE990D50 rmnet + tty + ADPL +
adb composition.

> diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
> index 94cdb61dca83d..147beaa61340d 100644
> --- a/drivers/net/usb/qmi_wwan.c
> +++ b/drivers/net/usb/qmi_wwan.c
> @@ -1360,6 +1360,7 @@ static const struct usb_device_id products[] = {
>  	{QMI_FIXED_INTF(0x1bbb, 0x0203, 2)},	/* Alcatel L800MA */
>  	{QMI_FIXED_INTF(0x2357, 0x0201, 4)},	/* TP-LINK HSUPA Modem MA180 */
>  	{QMI_FIXED_INTF(0x2357, 0x9000, 4)},	/* TP-LINK MA260 */
> +	{QMI_QUIRK_SET_DTR(0x1bc7, 0x0991, 0)}, /* Telit LE910C1-EUX */
                                                   ^^^^^^^^^^^^^^^^^^

[Severity: Low]
Is the device name in this comment the intended one?  The subject line and
the descriptor dump in the changelog both describe 1bc7:0991 as the
FE990D50:

    P:  Vendor=1bc7 ProdID=0991 Rev=06.06
    S:  Manufacturer=Telit Cinterion
    S:  Product=FE990

The comment looks like a copy of the next line, which is the entry for the
real LE910C1-EUX at a different product ID and interface number:

>  	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1031, 3)}, /* Telit LE910C1-EUX */

drivers/usb/serial/option.c already labels the same product ID as the
FE990D50 in option_ids[]:

	{ USB_DEVICE_AND_INTERFACE_INFO(TELIT_VENDOR_ID, 0x0991, 0xff, 0xff, 0x30),	/* Telit FE990D50 (rmnet) */

Would /* Telit FE990D50 */ be a better fit here, matching the existing
naming for the rest of the family in this table (/* Telit FE990A */ for
0x1080 and /* Telit FE990B */ for 0x10b0)?  As it stands, two entries for
different hardware carry the same label, which makes it easy for a later
addition to touch the wrong line.

The match itself looks fine: interface 0 of 0x0991 has bInterfaceProtocol
0x50, which none of the option.c filters (0x30, 0x40, 0x60) claim, so only
the comment appears to need a change.

>  	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1034, 2)}, /* Telit LE910C4-WWX */
>  	{QMI_QUIRK_SET_DTR(0x1bc7, 0x1037, 4)}, /* Telit LE910C4-WWX */
-- 
pw-bot: cr
