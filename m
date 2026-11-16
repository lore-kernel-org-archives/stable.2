Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845691;
	b=A6V6Daw8avH3ZJ25Oqdbt54hJZlCNDad3v2Jt7ZPSYuyxPEwgSC6/K8k/JojV2NwVEjl
	 Irp+n+jq/hBY3H2PXuxftGsZkOZ145gmqgSR7UiXrylJlp0Y2+DSotQd6jJ4kjILWx638
	 cU0nVAsOtEanmTuBR8o+O51GwvgG2IhFZdKYVAyE7f2z67sGQuCkvyAbcrpaUfGke+J9w
	 JoX72wUirNkrDlh7F7fhyLKU590+bu9vi6SMoEzXuYlNzP0omIqnugxzP3banqh/hmHnW
	 OPW7H8okMRujxAANXO1kDdXZM+blTjeGVmEpwKVnlNXPAwXO/lUsju7GLR1Mcf+0sCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845691;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=N7wQpVQ+bTcbptKNuYSOq1g/ZGresd4OfMg6HHxOoag=;
	b=RX8QLb9pWMvQm0PAgPUaNZ3HJYdfH89kxUh/hXkLKKo98wOGTcmRmam4NZx5OhkJv7UE
	 8ZdWE6PJSt8fjnpH07aC8jCBDR6e9rDXnLh5jHokWg9vuNmqrIQt4SXT2lRXaCMuz+8is
	 RFWQYr9yIj4qcBaNASyhjQSaSa271z3wh4cCYGB2f4NwPqxdlHgSySWDZZhW6DK4pOnW2
	 NIg7GKng1j7jECQ4gDGD+sxr6PKyujtpShIfmt8sZ/SqKKQjEA1CUWGkFQIlukhgduyWJ
	 UnUYVDUMgdYiXwTSVuapsylBpCbutK38OXt7ZXNoB9kLqdhTGWHB2KMYDLyvk3jw+Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="EW4/4GAX";
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD2D606A322;
	Mon, 16 Nov 2026 16:14:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BD2D606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EW4/4GAX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794845692; x=1826381692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2qWksjfKSQubdHdo66uJX986+dh3EH0BJB8sxwmWIKc=;
  b=EW4/4GAXaSvLd8buqlvrcAdPkO0blXK9jSlG9ZhlMbOv3IgRzoUpmCl3
   6J0qPwEUCoE4YICX2PI6lYMDgrltkOFV4ZQdfiTRGaMVlUKOa6k7itPLG
   7dmmZtl3PontzT7DObsjx4EkeMcUXaoC2SeCzao0yW907IV7uduEU2JYu
   ZXWS05FMPoOxw4ytVDi9TWfUcgg+EicRcw2fugAKuD+GOAwFayLGep/DM
   Og4hKXCAKW5XTx1AUenFYhY+DsbWmeN2PXBS4Ko2j2U8WEqDgFjPGUknP
   7RliuWXT0HWlS5uZaEyFwLVqu0+QKEVPIEuTawvtzCFl4zBG1qEEacmzS
   g==;
X-CSE-ConnectionGUID: 4eNOjWQLQA6VSJu3JluYww==
X-CSE-MsgGUID: 0ZAjSXMDST+CsYdJXgtU5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3479439"
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="3479439"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 08:14:51 -0800
X-CSE-ConnectionGUID: 4FKOGO9wT5yTDyoPEq7VnA==
X-CSE-MsgGUID: 5f7Ksyp+Q8mrRdhLO+8XeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,217,1787036400"; 
   d="scan'208";a="9990259"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 08:14:47 -0800
Date: Mon, 16 Nov 2026 18:14:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Dan Williams <djbw@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, stable@vger.kernel.org
Subject: Re: [PATCH v8 5/6] dmaengine: dw: calculate residue in the status
 getter
Message-ID: <avsr9Xy9WR-C7VzD@ashevche-desk.local>
References: <20261116-submit-dw-dma-synchronize-v1-v8-0-4a82d64fcd1a@gmail.com>
 <20261116-submit-dw-dma-synchronize-v1-v8-5-4a82d64fcd1a@gmail.com>
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
In-Reply-To: <20261116-submit-dw-dma-synchronize-v1-v8-5-4a82d64fcd1a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 16, 2026 at 03:52:33AM -0700, James Hilliard wrote:

> Calculate hardware-LLP residue while looking up the requested cookie under
> the channel lock. The descriptor scanner updates cached residue only when
> no transfer-complete event is pending. If a status query completes the
> current transaction and starts the next one, that new transaction's cached
> residue has not been initialized and a query for its cookie reports zero.
> 
> Have dwc_get_hard_llp_desc_residue() return a local residue value from a
> fresh LLP snapshot. Keep the persistent residue field for software-LLP
> block accounting, subtracting the current block's progress when reporting
> status. The descriptor scanner continues to advance software-LLP blocks
> and complete cookies from RAW.XFER, including for polled transfers.

...

>  	desc = dwc_find_desc(dwc, cookie);
>  	if (desc) {
>  		if (desc == dwc->desc) {
> -			residue = desc->residue;
> -			if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags) && residue)
> +			if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
> +				residue = desc->residue;
>  				residue -= dwc_get_sent(dwc);
> +			} else {
> +				residue = dwc_get_hard_llp_desc_residue(dwc, desc);
> +			}

It can be written in a shorter form

			if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags))
				residue = desc->residue - dwc_get_sent(dwc);
			else
				residue = dwc_get_hard_llp_desc_residue(dwc, desc);

>  			if (test_bit(DW_DMA_IS_PAUSED, &dwc->flags))
>  				*status = DMA_PAUSED;
>  		} else {

-- 
With Best Regards,
Andy Shevchenko


