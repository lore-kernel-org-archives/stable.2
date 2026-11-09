Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794241798;
	b=jiytS2CXYaZ+OvTXEpNa0lF4iv0cDIuP43dWM6I66AkqGaXGwVywzW1ZeUGd9aGhYNOI
	 wVCyEMuHCpL9P3+750Xlvy9gmAamgZ75bYruraKvBwDR4L0GpAvm9LawFVUd5wph5vEFD
	 IDKY1P/BUmMHv+jSYRyKqjQH5X0Z3/gHSTM1vZbQAsm1FxF1AI2RI2nngc7A29h0GAud3
	 ejzj61UVYvAwKp6Hn90I9EddogzBQ0Ayv7KgsjbxK8BNXC/JUyAEqyVn7ZjAiOuBBGB7f
	 xD/kE6FTsQrF26zAQyWw9LtMiLv4+F8NAZFOeaUQnHUPRMEl8LokYcRZN3FBcafgj5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241798;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=vxG54koDm80HfHxfLyoAWDitBBKRIo2lMZtZZWNg1hk=;
	b=nM3HQkaWOLC9c8H1dz1jYciMvvpSdZ0kqgglGdnmyhH5zIpweO9YHRfxKFcEJy4o+QHF
	 Smikk2GYcNdEDGQAnMBSXRRBN3vHkP91t1iFaN0VMsZaWjJCF3LA5gQvG8bp3TYYrygey
	 Q2XODK3s873/kME30UcB4FuR1XUY7CReFJdEfc59ZiovJRjiK5z4lxT839hREeQqym+c/
	 oFAJZqWXAweUoQb4WI+xTkvH29ro6GhroGxDIEajv0PqAKlxdsGE71n05PEfmltIgybfu
	 JuR8WRH8znxBAi2mXr8aamYEVkynaAwBl3osN3odDQaqrcmC7Wk5QSmbGdW/6DEYuAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eXfBQd9b;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1012606A31C;
	Mon,  9 Nov 2026 16:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1012606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eXfBQd9b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794241799; x=1825777799;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Hnvi9iMKOrVTdH9yUBMXKJCbr7+rERZnZmiBjcI/LVs=;
  b=eXfBQd9bFU787Vj7VrgL7h7W6pW3oxF8wL5IzB3PQfvWA8gDQXfGXD0D
   z9Fss6y0rq/LbV7fTR//K+6E/y0M0kZZN3kPopS3F5FVXD2fPZ3Xs4Qnj
   ty1xt4NBwqLZ8y+0P/S1s/CU3KdX42Cyixi5yUOiYr1yJkCQVJN7pvk/f
   7j6vaiM+lxg0SVoxRfNmqOSvXjOOgFuI5aYr0RelpX7jAcOHAzky6YCQU
   6PppnpMNFTE6/B1rmqP1QHS899RmHh8fhewYYE/JS7G0rxPy5A9h5XwTB
   Te4Pn+3C+G66InfXglbR34Qnt3xxpAY41X++dp4Jc8E5+O70RJyowSuiY
   A==;
X-CSE-ConnectionGUID: +4h+wM3NQkGwQruPX/CQbA==
X-CSE-MsgGUID: cN/aBSM9R0qKxE7d+R4qow==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2997422"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2997422"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 08:29:58 -0800
X-CSE-ConnectionGUID: tJqy7YSSSeySS9oSR51VAQ==
X-CSE-MsgGUID: dXqXreHNR8WkZXjXwjcOzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="7780362"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.139])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 08:29:54 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 9 Nov 2026 18:29:50 +0200 (EET)
To: Tristan Madani <tristmd@gmail.com>
cc: Hans de Goede <hdegoede@redhat.com>, Anssi Hannula <anssi.hannula@iki.fi>, 
    Matthew Garrett <mjg59@srcf.ucam.org>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, 
    Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH] platform/x86: hp-wmi: validate WMI return buffer
 length
In-Reply-To: <20261024205519.4029617-1-tristmd@gmail.com>
Message-ID: <c8985e22-3f00-b32b-3de2-65e486b367db@linux.intel.com>
References: <20261024205519.4029617-1-tristmd@gmail.com>
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

On Sat, 24 Oct 2026, Tristan Madani wrote:

> From: Tristan Madani <tristan@talencesecurity.com>
> 
> hp_wmi_perform_query() casts the WMI return buffer to struct
> bios_return without first checking that the buffer is large enough.
> If firmware returns a buffer shorter than sizeof(struct bios_return),
> the subsequent subtraction on buffer.length underflows, causing
> memcpy to copy a near-maximal number of bytes and crash the kernel.

Where's the crash output then? Please quote it in the changelog for the 
relevant parts.

> Add a buffer length check before accessing the return data, matching
> the validation already present in the sibling hp-bioscfg driver.

More important though, hp-wmi should migrate to using the modern WMI API 
which would likely allow using WMI core to validate the output sizes.

Somebody tried the WMI conversion earlier but to me that patch looked 
incorrect (or more like clearly missing pieces) and I had bad experiences 
with the particular submitter when it comes to converging to something 
sensible based on given feedback so I've low prioritized that patch.

> Fixes: c3021ea1beee ("hp-wmi: allow setting input and output buffer sizes separately")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  drivers/platform/x86/hp/hp-wmi.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 615b4cf6fc451..81c0acc874f8e 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -697,6 +697,13 @@ static int hp_wmi_perform_query(int query, enum hp_wmi_command command,
>  		goto out_free;
>  	}
>  
> +	if (obj->buffer.length < sizeof(*bios_return)) {
> +		pr_warn("query 0x%x returned undersized buffer (%u < %zu)\n",
> +			query, obj->buffer.length, sizeof(*bios_return));
> +		ret = -EINVAL;
> +		goto out_free;
> +	}
> +
>  	bios_return = (struct bios_return *)obj->buffer.pointer;
>  	ret = bios_return->return_code;
>  
> 

-- 
 i.

