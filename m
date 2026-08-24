Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8198D19D07A;
	Mon, 24 Aug 2026 06:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787551876; cv=none; b=vGt7tF8V1lvnEiygjjltpse+X8sNCLWs85xlrRYF+ZDe0c1UqL/+VyeTibULMPZAtOgt1M5dvey4u+k/dT5dYrbYbYbe+d20AmxJ1r4bGSb4YnKyVwjkR56rwIjYB8Cr7mwTQF2uSJs1IGXagWa0demr8ZKfGQu7tOf+uO5njEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787551876; c=relaxed/simple;
	bh=6nptbZGT1h/hLm2yraiYpWcwAGvLh2GTqfmrU8Xm6q8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DUXgY2M1u7nvbgV7GuS5miNl4eHtNST4DlCWv/BDwI7GZA+qYbwWg4dPFyqNfLAKHfSNyY+3nVCkr30cD3W2Df1eZhtq6369vItcZ7FNYKTrJ0C7ZX1juQNvPTMO+F/hZVFMNYBv/67f+02boyPZtWgNhjW0f7S2d59uhb9B5t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=L0kHe1Cc; arc=none smtp.client-ip=188.68.63.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="L0kHe1Cc"
Received: from mors-relay8203.netcup.net (localhost [127.0.0.1])
	by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4hT0h61TmBz8hnZ;
	Mon, 24 Aug 2026 06:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1787551382;
	bh=6nptbZGT1h/hLm2yraiYpWcwAGvLh2GTqfmrU8Xm6q8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L0kHe1CcVfVwhv+fJCO949efCMHCNDJrrCbWI4vdfTQaLx/w2U29j1bIlbK65Zobq
	 DpbM9u0jspsKgXvqSQrUcxyNbY5ocH2R7SEZJ87UeML6eoLjyA0HsRLVQzO6HYOabF
	 dZJnZDdVJtbqafjHYcTwQ1Bif1tRDprrxMBFLQtFFdmzXk8IU0h+LFRRzMDbXbliUP
	 nCraJAaj5vmSufvx9yEY4MA39n6OIdtryEMu0BtodgUK/H07R/l9qQB4E3AAwdwZGn
	 dFoHdmhwO/OUGbJGKJShMAb2Ug/mNZ5a1C8wCbjOOyvOMielrpmawtdZDpj3vDjc5i
	 +aUcKYzEfd/jw==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay8203.netcup.net (Postfix) with ESMTPS id 4hT0h60mGMz8hmB;
	Mon, 24 Aug 2026 06:03:02 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4hT0h44FSVz8tZn;
	Mon, 24 Aug 2026 08:03:00 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id E0DA45F9AF;
	Mon, 24 Aug 2026 08:02:59 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <77f94165-3d5f-41de-8969-c7318284fd6a@leemhuis.info>
Date: Mon, 24 Aug 2026 08:02:58 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: limit RTL8761B BROKEN_EXT_SCAN quirk to
 0bda:a728
To: Junjie Cao <junjie.cao@intel.com>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexej Sidorenko <alexej@sidorenko.cz>, regressions@lists.linux.dev,
 Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
 Kamil Serwus <kserwus@gmail.com>
References: <20260824053227.317496-1-junjie.cao@intel.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20260824053227.317496-1-junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178755138034.1921642.3871019175141522623@mxe9fb.netcup.net>
X-NC-CID: WDjihXVqlhKqBGmZvaes4uDUh9VM1OPgNoijMGzU+tUmObZ7sRQ=

On 8/24/26 07:32, Junjie Cao wrote:
> Commit 5ead2063611a ("Bluetooth: btrtl: fix RTL8761B/BU broken LE
> extended scan") set HCI_QUIRK_BROKEN_EXT_SCAN for every CHIP_ID_8761B
> device to cure repeated 0x2042 failures on an 0bda:a728 dongle. The
> brokenness is per-dongle, not per-chip: on a TP-Link UB500 (2357:0604,
> RTL8761BU, fw 0xdfc6d922) extended scan works, and the legacy scan
> path the quirk forces is what is broken -- LE Set Scan Enable (0x200c)
> times out with -110 about 30 s after firmware load, btusb resets the
> device, and the adapter re-enumerates in an endless loop (382 firmware
> reloads in one boot). 7.1.8, which predates the stable backport, runs
> clean on this unit; 7.1.9 loops.
> 
> Move the quirk from btrtl's chip-wide switch to a btusb device-table
> flag on the USB id the original fix was verified against. Other 8761B
> dongles return to their earlier long-standing behaviour.
> > Link: https://bugzilla.redhat.com/show_bug.cgi?id=2521504
> Fixes: 5ead2063611a ("Bluetooth: btrtl: fix RTL8761B/BU broken LE extended scan")

Thx. Just to make sure everyone is aware of it: Kamil (now CCed)
reported problems due to the commit yesterday and provided patches, too:
https://lore.kernel.org/all/20260822141115.58815-1-kserwus@gmail.com/

I suggested that a quick revert might be the best approach for now,
which Kamil submitted:
https://lore.kernel.org/all/20260823102959.100368-1-kserwus@gmail.com/

No comment yet from the BT folks yet.

Ciao, Thorsten

> Cc: stable@vger.kernel.org
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
> #regzbot introduced: 5ead2063611a
> #regzbot link: https://bugzilla.redhat.com/show_bug.cgi?id=2521504
> 
>  drivers/bluetooth/btrtl.c | 13 -------------
>  drivers/bluetooth/btusb.c |  8 ++++++++
>  2 files changed, 8 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 7f54d2d2d13a..03fa9409e3ee 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -1343,19 +1343,6 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
>  	if (!btrtl_dev->ic_info)
>  		return;
>  
> -	switch (btrtl_dev->project_id) {
> -	case CHIP_ID_8761B:
> -		/* RTL8761B/BU reports HCI version 5.1 but does not support
> -		 * the LE Extended Scan commands (Opcode 0x2042), causing
> -		 * repeated -EBUSY failures when BlueZ attempts extended
> -		 * scanning while a connection is active.
> -		 */
> -		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_EXT_SCAN);
> -		break;
> -	default:
> -		break;
> -	}
> -
>  	switch (btrtl_dev->ic_info->lmp_subver) {
>  	case RTL_ROM_LMP_8703B:
>  		/* 8723CS reports two pages for local ext features,
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 2bae85b0016c..84614e60d142 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -67,6 +67,7 @@ static struct usb_driver btusb_driver;
>  #define BTUSB_INTEL_NO_WBS_SUPPORT	BIT(26)
>  #define BTUSB_ACTIONS_SEMI		BIT(27)
>  #define BTUSB_BARROT			BIT(28)
> +#define BTUSB_BROKEN_EXT_SCAN		BIT(29)
>  
>  static const struct usb_device_id btusb_table[] = {
>  	/* Generic Bluetooth USB device */
> @@ -619,6 +620,10 @@ static const struct usb_device_id quirks_table[] = {
>  	{ USB_DEVICE(0x0489, 0xe130), .driver_info = BTUSB_REALTEK |
>  						     BTUSB_WIDEBAND_SPEECH },
>  
> +	/* Realtek 8761BU Bluetooth devices */
> +	{ USB_DEVICE(0x0bda, 0xa728), .driver_info = BTUSB_REALTEK |
> +						     BTUSB_BROKEN_EXT_SCAN },
> +
>  	/* Realtek Bluetooth devices */
>  	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
>  	  .driver_info = BTUSB_REALTEK },
> @@ -4403,6 +4408,9 @@ static int btusb_probe(struct usb_interface *intf,
>  	if (id->driver_info & BTUSB_INVALID_LE_STATES)
>  		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_LE_STATES);
>  
> +	if (id->driver_info & BTUSB_BROKEN_EXT_SCAN)
> +		hci_set_quirk(hdev, HCI_QUIRK_BROKEN_EXT_SCAN);
> +
>  	if (id->driver_info & BTUSB_DIGIANSWER) {
>  		data->cmdreq_type = USB_TYPE_VENDOR;
>  		hci_set_quirk(hdev, HCI_QUIRK_RESET_ON_CLOSE);

