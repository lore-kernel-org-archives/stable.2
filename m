Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793022037;
	b=j+lMG3s3U3GKgHQq6AtuUvrfLoC/8CWMuvTpQBe1ueEjMZxjDwl3FoybQ7YPEQrWu/RT
	 AgAJxTDVRBWKE8p5oIhRPdGhWY5xWxnWQQqCKjrTkDvbiysTPLRs2k9jwlFPg5eYHaETK
	 DckMg0Ja15OePV6cM5DQUsbqYebxKgaSZKUhiRTUUIdQnxRKSQuYGgiTGNfXVUgnczWRh
	 Ze1BxRM51vthyMW/6tJnuz+ggH0VWsLweOAipI5KEemlluEb4hGu6CgaFNWN6DNGI2Nem
	 xiI7qo472J0VvDxNYlmTOajhxYcv5t8pu/gXhqQMBTr0Fgz/rezTIddGT1EEvoqMn7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793022037;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=yv63K6WTYEbnAMGBuOr4pGVb+unnC1oRL022JWcKu3I=;
	b=WW592rdBNborJQqS/EY4zgSz5dBvavXNN1yM/vGK86HEVydWIFHO5rM//Ort+eLrwR0d
	 spBEucDdlt2mvLDRIHVmCoHpOktoYiC6z3azxjk8bwL8Juu7cCGWeYA2zslCKHNdhDFsj
	 hQmK2RT1m3FgLzY8tph9aSFNo6+qEjwkGs4VbF7UgALqJbaZ69SxULyBpz61TBduqzEtJ
	 vz5qFdZ8OL2AbiVUe4pSMQlc0xKWhrAUbGi3L3ROTtaHnJhjb2ZNxDhxiA1yQxBB1KGod
	 DSrqhRYxuIENvVMIlgl5LM3zje8BdyKKBk0I5at/W5ZMQIW/Q4PnfXP1u9lMCTL+ZEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C36KyvBZ;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F502606A321;
	Mon, 26 Oct 2026 13:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F502606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C36KyvBZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793022038; x=1824558038;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hf5kLlEDZ2h/gBBkowoFWatGU502vmgzzpr7JnYGEGY=;
  b=C36KyvBZ4h1gbtCdqMUgobgc0cUORHH/Q/dcKKmwMcbmWqrKmuPPSuYq
   C090/BLrGTyAGMY3+l35oL2EcN1We+R50GmlIKIryacWrsdjZy0zg2lbh
   BJ54henMj8vOJmqGutvqRsyvrOhzimEosfVZEcYuHxWGIaTilWhf8QhkG
   6lF8XMoXRVwpQ90v+V0bgHOytmgSYIQ0vANIKQuVdqWkxudtr3QkiCLLz
   AkGWKrVJzBqseIQP0bM2kyUzISwf1J1fhfa716CLJlxOFXEt/QSlgqFRA
   bBkBfPRkUlg6hbhzQnobKBCz89eWXGOkrSFZ9ddUL7MadFcYspROUFTV6
   A==;
X-CSE-ConnectionGUID: /M3sHhFdSj2wJVtwCYa4BA==
X-CSE-MsgGUID: +KRxHlgvQK+6hGYa6+nfQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1710295"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1710295"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 06:40:37 -0700
X-CSE-ConnectionGUID: 3BMBfV/MQjGD+XXJZnDDzw==
X-CSE-MsgGUID: 34N6VaCTRQePODoeaNL5ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="6118721"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa011.fm.intel.com with ESMTP; 26 Oct 2026 06:40:35 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id A4D6399; Mon, 26 Oct 2026 14:40:33 +0100 (CET)
Date: Mon, 26 Oct 2026 14:40:33 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: z0rc3r@gmail.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Francesco Orro <ncesco@interstellar.eu>
Subject: Re: [PATCH] usb: typec: ucsi: acpi: Assume UCSI 1.0 on HP ZBook 8
 G2i 14
Message-ID: <at9YUXPLI9xBUxZt@black.igk.intel.com>
References: <20261026-ucsi-hp-zbook-8-g2i-v1-1-91002e9ef073@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-ucsi-hp-zbook-8-g2i-v1-1-91002e9ef073@gmail.com>

On Mon, Oct 26, 2026 at 01:47:52AM +0200, Ihor Urazov via B4 Relay wrote:
> From: Ihor Urazov <z0rc3r@gmail.com>
> 
> The HP ZBook 8 G2i 14 (board 8ED9) exposes a working UCSI ACPI PPM, but
> its UCSI VERSION field reads zero until the first command completes.
> ucsi_register() rejects a zero version with -ENODEV, so no Type-C ports
> are registered.
> 
> The firmware's _DSM READ function (2) is a stub. The mailbox VERSION
> field is written only by the EC response handler, after a command
> completes, after which it reads 0x0100 (UCSI 1.0). The mailbox is
> 48 bytes with 16-byte MESSAGE_IN/MESSAGE_OUT fields, the UCSI 1.x
> layout, and _DSM function 5 is not implemented.
> 
> Add a DMI-specific read_version for this board that substitutes the
> version the firmware itself reports, UCSI 1.0, only when VERSION reads
> zero. A non-zero firmware version is used as is.
> 
> The same firmware defect on the HP ZBook Fury G1i 16 was discussed in
> "[RFC PATCH] usb: typec: ucsi: acpi: bootstrap PPM on HP systems with
> empty _DSM func 2" [1]. The defect was reported to HP as case
> 5166176673.
> 
> Tested on an HP ZBook 8 G2i 14 with BIOS Y70 01.02.08, from a fresh
> boot where VERSION reads zero: three connectors register, the PD
> contract and alternate modes of a Thunderbolt dock are reported, and
> its DisplayPort output stays up across the PPM reset in ucsi_init().
> Dock unplug/replug and s2idle suspend/resume update the connector
> state without errors.
> 
> Link: https://lore.kernel.org/linux-usb/f3M_fpjtt8FxDqGKcA84vqXmRbKzCBfpCrIK4-jCWvIscER51zkD8qD8FYpz75qZw51rMDRSkUyYlrBvLvdM8CGRY2l8TFVvr4MC1LdTzbc=@interstellar.eu/ [1]
> Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")
> Cc: stable@vger.kernel.org
> Cc: Francesco Orro <ncesco@interstellar.eu>
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Ihor Urazov <z0rc3r@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Hi Heikki,
> 
> on the Fury G1i RFC you asked for the actual UCSI version instead of a
> guess. On this board the firmware itself reports 0x0100 once the first
> command completes (read back from the mailbox), and the mailbox layout and
> missing _DSM function 5 rule out 2.x. HP has been asked to report it from
> boot, case 5166176673.
> ---
>  drivers/usb/typec/ucsi/ucsi_acpi.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
> index 5697ccc24ec3..2421a92ecb0e 100644
> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
> @@ -148,6 +148,34 @@ static const struct ucsi_operations ucsi_acer_ops = {
>  	.async_control = ucsi_acpi_async_control
>  };
>  
> +static int ucsi_hp_read_version(struct ucsi *ucsi, u16 *version)
> +{
> +	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
> +	int ret;
> +
> +	ret = ucsi_acpi_read_version(ucsi, version);
> +	if (ret)
> +		return ret;
> +
> +	/* Firmware fills in VERSION (1.0) only after the first command completes */
> +	if (!*version) {
> +		dev_warn(ua->dev, "UCSI version is zero, assuming 1.0\n");
> +		*version = UCSI_VERSION_1_0;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct ucsi_operations ucsi_hp_ops = {
> +	.read_version = ucsi_hp_read_version,
> +	.read_cci = ucsi_acpi_read_cci,
> +	.poll_cci = ucsi_acpi_poll_cci,
> +	.read_message_in = ucsi_acpi_read_message_in,
> +	.write_message_out = ucsi_acpi_write_message_out,
> +	.sync_control = ucsi_sync_control_common,
> +	.async_control = ucsi_acpi_async_control
> +};
> +
>  static int ucsi_gram_sync_control(struct ucsi *ucsi, u64 command, u32 *cci,
>  				  void *val, size_t len, void *msg_out,
>  				  size_t msg_out_size)
> @@ -196,6 +224,13 @@ static const struct dmi_system_id ucsi_acpi_quirks[] = {
>  		},
>  		.driver_data = (void *)&ucsi_acer_ops,
>  	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
> +			DMI_MATCH(DMI_BOARD_NAME, "8ED9"),
> +		},
> +		.driver_data = (void *)&ucsi_hp_ops,
> +	},
>  	{
>  		.matches = {
>  			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
> 
> ---
> base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7
> change-id: 20261026-ucsi-hp-zbook-8-g2i-4446ab6e5ed4
> 
> Best regards,
> --  
> Ihor Urazov <z0rc3r@gmail.com>
> 

-- 
heikki
