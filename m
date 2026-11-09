Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794241473;
	b=IDw0egXlb8sJkAG+FvfBIDgiZnoTa9m3q4lMOm5k7g+NBOKLAr1uoU3MRqKaK+IR19Mg
	 W584kFrJy9nlYzughqSTv6RPAtKHacYdacLGne6RZPPk5DnpYWgLbD9tY8mRG+Qd7kZvr
	 YcZNxTjgGsF0164uuyLSXisSj+vuyP4Kv1DGLqpaLEV0zjCFgA/5EV5T2aY+EOisf/yv4
	 +Byvr7vsqXa2dSMMFPLZc4S/J01BZBtpbPiBIIiScnJdtDgt7LIx6Kib44VO7a9YFGo97
	 yM4mSYvS48ed/hD3fxuILl1u19Mnrq2fBwsoznzEe9vhpxBKSDOnfN8QdHE5nsL9MoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241473;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=Sid5yZus6G+oQ4VFLDXwLEXmaqNVhVl2UK+LaDNwAlQ=;
	b=kw/bbSL0pin6DGfHL0xoNboegk19crQJ7c2T23L+jeD3oMNRql0Avnqo6Bo0QXKCz+8W
	 b5auD4fVbdbSx74FY4KKqi5LYCi2oOz2HjDsXBY3JNac9XaJgOfYVctJVN4SfXGy8RTqz
	 2xi98OpMDudpEBIbHttlFUUqfLGhUvRM4RF9v/7IMyg7afAbPfAbx2nrHO4ZZYljxOMD3
	 DMuwD5h2IpXxgM8BzkB0RcVPPK570LZsrquHViXF/emUH2vY+CDDksLvM4gs5CxflzGtY
	 83a0df1n1sY/Qdvj138qNQtTgaNu46duNNAGyLf6vmxmCpjGL5YFLfqpMCwDKNLtAxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cJLeeEJo;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D21D606A321;
	Mon,  9 Nov 2026 16:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D21D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cJLeeEJo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794241472; x=1825777472;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qu4ckg06nJ9ve+IS2WjcZpi5cYmOh0MLgKuJhDC4Gfc=;
  b=cJLeeEJo12j6NtDp82Gycvl8YxFZlUeD4+9Efry+JjQHzWylqsao/o8G
   ihhpWHz/saowKXY/WOzWKtBEabUf+TFmVo3bwrrdTocS7pTptUTZ7wP4X
   QysATzw5J2P4R5XJT00L46YX/MWIHDgOXoGP4bUIxWjTQ5FgfTJl73ZO7
   jCLl8Fi1JaYNpced5o5X7meNh1tldhZ1BhpvWUD08N/Uj9XCYVqXVofkQ
   x4ksvilug7sq4WomZGb159KxwO95VaNyIr3GHyCippnnyDOY70dOS91qs
   bVJzN1TN1AiXG56LXOh1vURC3T/YjAINoaG3PVX+XP2AFInmNuC+gvVt7
   w==;
X-CSE-ConnectionGUID: YdVvp9qbSDW5VCxe295cpQ==
X-CSE-MsgGUID: sIHbEB8rS/KWfGiuOjCPGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2979733"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2979733"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 08:24:21 -0800
X-CSE-ConnectionGUID: ePWGk5NMRdmWuIJBC2A+3w==
X-CSE-MsgGUID: 0o4kC1zlT2ChXuITN5kdKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8251144"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 08:24:18 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 9 Nov 2026 18:24:14 +0200 (EET)
To: Tristan Madani <tristmd@gmail.com>
cc: Azael Avalos <coproscefalo@gmail.com>, Hans de Goede <hansg@kernel.org>, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH] platform/x86: toshiba_acpi: validate ACPI object type
 in tci_raw()
In-Reply-To: <20261102181827.1989460-1-tristan@talencesecurity.com>
Message-ID: <7ac2114f-f4a5-c94a-0578-7659a7a291eb@linux.intel.com>
References: <20261102181827.1989460-1-tristan@talencesecurity.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 2 Nov 2026, Tristan Madani wrote:

> tci_raw() calls acpi_evaluate_object() and uses the returned buffer as
> an ACPI_TYPE_PACKAGE without checking its type field. If the ACPI method
> returns a different object type, accessing package.count and
> package.elements interprets whatever data the union holds as a package
> descriptor.
> 
> Add a type check before accessing the package fields. Return AE_TYPE
> when the result is not a package, when the package has more elements
> than TCI_WORDS, or when any element is not an ACPI_TYPE_INTEGER.

Your ACPI validation patches seem to lack information whether these 
actually have been observed to occur on some device.

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  drivers/platform/x86/toshiba_acpi.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/toshiba_acpi.c
> index a0b8060836d01..4ccc8f51c3a5b 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -342,9 +342,20 @@ static acpi_status tci_raw(struct toshiba_acpi_dev *dev,
>  	status = acpi_evaluate_object(dev->acpi_dev->handle,
>  				      (char *)dev->method_hci, &params,
>  				      &results);
> -	if ((status == AE_OK) && (out_objs->package.count <= TCI_WORDS)) {
> -		for (i = 0; i < out_objs->package.count; ++i)
> -			out[i] = out_objs->package.elements[i].integer.value;
> +	if (status == AE_OK) {
> +		if (out_objs->type == ACPI_TYPE_PACKAGE &&
> +		    out_objs->package.count <= TCI_WORDS) {
> +			for (i = 0; i < out_objs->package.count; ++i) {
> +				if (out_objs->package.elements[i].type !=
> +				    ACPI_TYPE_INTEGER) {
> +					status = AE_TYPE;
> +					break;
> +				}
> +				out[i] = out_objs->package.elements[i].integer.value;
> +			}
> +		} else {
> +			status = AE_TYPE;
> +		}
>  	}
>  
>  	return status;
> 

-- 
 i.

