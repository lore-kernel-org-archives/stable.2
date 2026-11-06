Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988209;
	b=fJEXNWC65sfzu9qhGauBQ1lcSQqz8MuNQc8zgG5M51njFhlhjggKX0ilYG7rCVMrJ3iQ
	 sxMg4WeGYNr2BqAH/LtNcGw1cslMsp5fw+AvqyEKvwKK8D/982wGikpzQHDJcARdph8FJ
	 gxhW4NkqWxb8H1zuhQ1cwfEdMPs7HIsX/hjr5NZFAKuETH256ftWggFexY9/r79YDzcx8
	 WLLAk+J482fG5WZK5J8755Hl1IYr3JtB8FHol9UTY+UpBgEfX8sBrytodmVAXeVQ9201K
	 yHng4Za60SBxieZFuoa4sOkbAh6nZpVk93KRY793YM7f/pzKIV4JpxmUOzb+HK35tQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988209;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=H4JC89FtVyR6bVp+jdRxlev26LVtw5xFWty/pAHQfbQ=;
	b=5bcGSVr1kyJs7bYSABO8DfkCX7WOOJhpKLq9tGRHVg70dwDQor5POam5GW2Q9aX7Lwll
	 IqUZFp+bnJ7xGBOk3peEY+IiamnR9g9yTkNANwIUdnv2E2BtCRRUwr3VhkYaN4MS0hB5p
	 Hi092qmkaZOIejLxs65xx/IYi3KXxszezxJbgImw1AgrKrxqnFtH8IAM0q93QqBJbS5IS
	 Iu10G1MHbqJLTrAbNFUn98VIDP3gXFD/MseiX20zJutZuMN4215l5YaLbnL2AnQ1YHLxw
	 U4ncTUPZ8s5wyFjoI8TFtdlO+jPl5g/gEpjwBphH09GjoxkDa8nK3PsDIzLda2qldpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=czfank+a;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2795606A326;
	Fri,  6 Nov 2026 18:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2795606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=czfank+a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793988208; x=1825524208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=lCk/h8ygbgP+epzmfmv6nQwe4Y/dng1VVPwIVpqwZss=;
  b=czfank+aoParhYgOfJ2/72btQkRasNl/s0g3ZKdMmr5OzplwyuWkMx0i
   vxJlQjXEsfaJy0h8VzEsOlvKE05cfN1K+6onhL7CY7+D5gsFyU14MSedM
   Xsn6THXdS5A8uIpR+XDlXXghlsDya2YXM08QNBfiOLo++CvWKQC9dytEo
   lds5ro+8v1Ro1aCddYOKmSQ/R1y+YkmcjdUrtlJCG/TTPRPm0BIVWFTNA
   c/KwQdiSxc6SdNoTE1j9OFFqFgEKoZablYS789ummmNDgXsR0BHHSNM7j
   u5dFVeg7QuWQ8rvzG+XUHa16BlQSE1pFPeI04imUQ1bGm4re0FJ591DB+
   A==;
X-CSE-ConnectionGUID: 6W0xCCE9Rj+oRSh2OSH2Uw==
X-CSE-MsgGUID: bGbpnRKXT5yrhPW3v7TrFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2675771"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2675771"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 10:03:26 -0800
X-CSE-ConnectionGUID: +pXFL1TJS3GZbhDaO5V8hA==
X-CSE-MsgGUID: syFtqdleSImvrpB4xOVoXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7169959"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 06 Nov 2026 10:03:24 -0800
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 2B98899; Fri, 06 Nov 2026 19:03:23 +0100 (CET)
Date: Fri, 6 Nov 2026 19:03:23 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: kernel@resetko.pl, Greg KH <gregkh@linuxfoundation.org>,
	Guenter Roeck <linux@roeck-us.net>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Daniel Dev <daniel.dev@noex.uk>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: typec: ucsi: acpi: Assume UCSI 1.2 on Lenovo
 ThinkPad T14 Gen 2a
Message-ID: <au4Wa_xIfLp0UFjq@black.igk.intel.com>
References: <20261103-ucsi-lenovo-t14g2a-v2-0-e85c659b56a2@resetko.pl>
 <20261103-ucsi-lenovo-t14g2a-v2-2-e85c659b56a2@resetko.pl>
 <au4GUwhJz1jxYnqF@black.igk.intel.com>
 <79fec522-e734-4194-bf1d-57b1cb0b67c1@app.fastmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79fec522-e734-4194-bf1d-57b1cb0b67c1@app.fastmail.com>

On Fri, Nov 06, 2026 at 12:54:27PM -0500, Mark Pearson wrote:
> 
> 
> On Fri, Nov 6, 2026, at 11:54 AM, Heikki Krogerus wrote:
> > On Tue, Nov 03, 2026 at 05:10:21PM +0100, Stanisław Titenko via B4 Relay wrote:
> >> From: Stanisław Titenko <kernel@resetko.pl>
> >> 
> >> The Lenovo ThinkPad T14 Gen 2a exposes a functional UCSI ACPI PPM but
> >> the firmware leaves the VERSION field of the UCSI mailbox at zero.
> >> 
> >> ucsi_register() rejects a zero version with -ENODEV, leaving the
> >> system without registered USB Type-C connectors. Without an OPM, the
> >> embedded controller does not complete DisplayPort Alternate Mode setup
> >> when a USB-C dock or monitor that supplies power is connected after
> >> boot, so the display stays dark while USB and charging work.
> >> 
> >> Use the zero version quirk for the ThinkPad T14 Gen 2a, matching the
> >> two board names of this model (20XK and 20XL).
> >
> > So is the product family the same?
> >
> > Could you use DMI_MATCH(DMI_PRODUCT_FAMILY... instead of adding
> > separate matches entry for both?
> >
> 
> The board names are what I recommended - they are pretty safe to guarantee
> they won't change whereas other fields are less guaranteed (guidance given by
> FW team). It is annoying there are two I know.

Okay, thanks. I had to double check. I guess you guys already talked
about this. Sorry about the noise.

> FWIW I would rather wait for confirmation from the FW team if they will fix
> this before accepting the quirk. I am still waiting for a reply from them
> though I'm afraid.

Makes sense.

Thanks,

> >> Tested on a ThinkPad T14 Gen 2a (20XK) with BIOS 1.33 (R1MET63W):
> >> both Type-C connectors register, and plugging and replugging a USB-C
> >> monitor with an integrated hub and power delivery brings up
> >> DisplayPort Alternate Mode each time.
> >> 
> >> Reported-by: Daniel Dev <daniel.dev@noex.uk>
> >> Closes: https://lore.kernel.org/linux-usb/b1Wn_eFvTFShGbd970WWl4CWhge_6P2x7Wb6rab3QHNlE4OJ4p__O-QN3B6I-308ftr5oV5Zr7vywA0vdvmtNw6E0YJnVM2ek_5DcFnkXB0=@noex.uk/
> >> Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")
> >> Cc: stable@vger.kernel.org
> >> Assisted-by: pi:claude-opus-5-5
> >> Signed-off-by: Stanisław Titenko <kernel@resetko.pl>
> >
> > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >
> >> ---
> >>  drivers/usb/typec/ucsi/ucsi_acpi.c | 16 ++++++++++++++++
> >>  1 file changed, 16 insertions(+)
> >> 
> >> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
> >> index 47ba0e15b8ba..d752fc7b61ec 100644
> >> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
> >> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
> >> @@ -196,6 +196,22 @@ static const struct dmi_system_id ucsi_acpi_quirks[] = {
> >>  		},
> >>  		.driver_data = (void *)&ucsi_zero_version_ops,
> >>  	},
> >> +	{
> >> +		/* Lenovo ThinkPad T14 Gen 2a */
> >> +		.matches = {
> >> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >> +			DMI_MATCH(DMI_BOARD_NAME, "20XK"),
> >> +		},
> >> +		.driver_data = (void *)&ucsi_zero_version_ops,
> >> +	},
> >> +	{
> >> +		/* Lenovo ThinkPad T14 Gen 2a */
> >> +		.matches = {
> >> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> >> +			DMI_MATCH(DMI_BOARD_NAME, "20XL"),
> >> +		},
> >> +		.driver_data = (void *)&ucsi_zero_version_ops,
> >> +	},
> >>  	{
> >>  		.matches = {
> >>  			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
> >> 
> >> -- 
> >> 2.56.0
> >> 
> >
> > -- 
> > heikki

-- 
heikki
