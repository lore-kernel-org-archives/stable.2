Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016193;
	b=eohOoXckDvfPOo9iXJqTN7FFlbRHsyr8NPyVxJ2F1Bxah8zQlN1S9T4QYn6e7FSaVVZv
	 IFf93cFwzLMZ1nyafu+nbnm+Fkq7dZ8kSzhG8p7spU8oGIqSZ4AgE3TZt0NeA1ROFQsAF
	 XzbEWP5442yelidVAtDHjCbg9GoREqvNX5Maay3ArRUdLZ7Y9Ac+NGxd/60pP3N2by5uV
	 oARfHU2bYNRX8/tG3ig9UwTeB53Zhl12FSkH69zLK8ZUMptmLa1fjFJA9VV+gPiCQebtG
	 cur9oba9FBAymxp/PY6Hd3jLp30x+g/wdEpNWD60KkigO1C943ZmcuXNzLX+K/ACIfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016193;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=NKB1Y87I4LlR2vC0YNobJ6njavPrckuOYKMefHfRV6w=;
	b=341Qp0VzUliXLCyjLgKkDfiwOCdAiM6xs7UU7oFE0u/JIY0f0tDDOL++DtGVIgRSE3A4
	 IQa5qzKcgfGqC2l37DNAqmkExce7/6q0eB6eSMWXFY/bCpIcIE2W3PJxVDgTPC85jeSVF
	 Xjd17+gc6OLdk9sITR1Yw68TRmt650040dB9AywI/3H48bxEmbEfh29WB81p1bPZIlPi9
	 FGgnxDsQGeZz6IDR+/U+GlXuzuWobo5Y0S8b81/TDdFE4apgftH0zymQfTyEadO7Vg3Yr
	 v8xIQ6vmTryGOHqKNLwQEHyEyZQovRBOs7Moo0Tep8fwUkpQTVmOSQqoF7qfYzZMv7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PQUF1etZ;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5062D60A2609;
	Mon, 26 Oct 2026 12:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5062D60A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PQUF1etZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793016192; x=1824552192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Y3sspoExOb0v12DrZqmms6766mwRzwAeiQE/j1+DjhE=;
  b=PQUF1etZfnjrAHYj6dW+g3gvDAMsvOTe4XeX3ZGKOL7PMe+fYw8dIIlt
   y4LDEG9yfF5IINEexv1c7ZYqk+Zo4bTTh+y9pswtW+ZLN9OHLxcdUj16m
   0iK4G4tGIjOthkq21gGOPu0DItJ7irsemUxsUNbQsID0mA6K2xhtyd3IB
   woM/gd5hs6xjm64/nCoPKYLvN9gFqY2jZBUeVTrsLbTrCJG1gOW2YAk1v
   z6p+yB/EjwNMOCurWBoG8FBDQ0JcDTQkV0VkTbtDCnQuW/fhkvzQb/9TF
   Hroy8Y0PHVqn9Q1QNslUie7RkNIU05gjR8pFtbHNvYH6bbRBxD8wRb3me
   A==;
X-CSE-ConnectionGUID: y/9Y7IxSSHWFykoRsan1ig==
X-CSE-MsgGUID: QKlwjJyfQSuDjo3coFHY9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1701067"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1701067"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 05:03:11 -0700
X-CSE-ConnectionGUID: cGa/oTkNT8i9tEULeZFn0g==
X-CSE-MsgGUID: a6aLU48LSama0inXYXkpdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4646001"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa009.fm.intel.com with ESMTP; 26 Oct 2026 05:03:10 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 56D6A99; Mon, 26 Oct 2026 13:03:09 +0100 (CET)
Date: Mon, 26 Oct 2026 13:03:09 +0100
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Chaz Bailey <charles.s.bailey@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
	linux-usb@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: nb7vpq904m: Set client data in probe to
 avoid crash on remove
Message-ID: <at9BfeEyLPhMFkUW@black.igk.intel.com>
References: <20261016122045.187862-1-charles.s.bailey@gmail.com>
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
In-Reply-To: <20261016122045.187862-1-charles.s.bailey@gmail.com>

On Fri, Oct 16, 2026 at 01:20:45PM +0100, Chaz Bailey wrote:
> nb7vpq904m_probe() allocates struct nb7vpq904m, but client data is not
> set during probe.
> 
> In nb7vpq904m_remove(), i2c_get_clientdata(client) returns NULL, leading
> to a NULL pointer dereference when accessing nb7->retimer or nb7->sw.
> 
> Set client data upon successful allocation in probe.
> 
> Fixes: 88d8f3ac9c67 ("usb: typec: add support for the nb7vpq904m Type-C Linear Redriver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chaz Bailey <charles.s.bailey@gmail.com>
> Reviewed-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v2:
>  - Rephrased commit message to state that "client data is not set during probe" (Krishna Kurapati).
>  - Picked up Reviewed-by tag from Krishna Kurapati.
> 
>  drivers/usb/typec/mux/nb7vpq904m.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/mux/nb7vpq904m.c b/drivers/usb/typec/mux/nb7vpq904m.c
> index d1fa26ff44..52e3c9db35 100644
> --- a/drivers/usb/typec/mux/nb7vpq904m.c
> +++ b/drivers/usb/typec/mux/nb7vpq904m.c
> @@ -396,6 +396,7 @@ static int nb7vpq904m_probe(struct i2c_client *client)
>  		return -ENOMEM;
>  
>  	nb7->client = client;
> +	i2c_set_clientdata(client, nb7);
>  
>  	nb7->regmap = devm_regmap_init_i2c(client, &nb7_regmap);
>  	if (IS_ERR(nb7->regmap)) {
> -- 
> 2.55.0

-- 
heikki
