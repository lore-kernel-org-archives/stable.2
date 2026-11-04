Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793812131;
	b=jG9BFaOdNUpZwQixPRAfHUQuNI7HJEod/cJi0xIZotlZCA9PPcOf98z434hi15529yrj
	 +m0HCKgLWu6IO7Q4rrhjc1ns+vemoouxA3uRJpilP9IinPyBZWmK4Pj4F+OHCFUFOhcqE
	 yp6Kzq/p7uEG9ExSSjBVcIfr2cTq5LzT8bfaqgqt/CQ1JUtWTT+69s1ZYW9529NHdqJ26
	 9o082zEud7wT39dXinW5xnptOM4OWsVPHeidh92ZZvVZFEPNF3gFOtaAfHaWv+CSWAlAk
	 fh/5n6wql1j7E26V6YpwzR67rcn+VojBY7bxZ9kZIbiIGnJEsLkb3UDTlVBrpnRH7cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793812131;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=BggNDxA9KgGk5xDWclBWYSnVWHuMCkK7nhX4rgf+QMg=;
	b=YJsB6y+Sw/tMiazX7Gm+jGSiedpLyUq7OlgCjap3gI+o9oak7dGwAd+MkG24MZQn9ayQ
	 HsC3/CTGd1kRak5fcbd59KIuk1sIk9yM1FDYPaLiM6LgoFnPPwmP9kSo7yOVF3FcfwwXy
	 WETCdPRckKokGncWzcRgnFpnNweAxOStDIUvnU29xzKKrkcmM58DsbsqQbsj+bb60og+C
	 BKtgYCG62d3fQlkSUwL8LCMA/2E808g0+JkfeCNBiBamrzWVmN6DWvN81YHuxkdI5hIR0
	 KWyRweS1x0Od5Pkhmo9XcMm0083LAHvvAjn9ptEgWWpEbRrh/ghkvWEBshpbrG8ijmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cMiaVy+p;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B8F606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 17:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4B8F606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cMiaVy+p
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-353804b591eso1760406eec.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 09:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793812130; x=1794416930; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BggNDxA9KgGk5xDWclBWYSnVWHuMCkK7nhX4rgf+QMg=;
        b=cMiaVy+pSe19pMljL1uhjFq4kEbCEUt/o/Iz6C2dTV176m5rucfND0PEf2SEpbbZxc
         PlE025Nm9PTscRp/p6IR7dB+llIsWQ/RxTRQ9DMb3zak2OfQIiH4AzmBia7njqIOqfv7
         +6UkapzksH/qN5zgpwwEDIiJP5Zra4K5wMOpP9dnw6Ut8jFNBtafU9CP3+QcghOfWyuS
         VRs1slNBsFhglrZ5hpyjHicvAlB1cY4yMXpAHrE91rIxMDuYxleL7z7x1/StDrDduXTF
         /8oMWy7fE10gZwzPJXEvuhfC6tma6uCe3q0HDDPSHNL+iHzw782M8oIMqk9jJLuN1MeJ
         mURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793812130; x=1794416930;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BggNDxA9KgGk5xDWclBWYSnVWHuMCkK7nhX4rgf+QMg=;
        b=zhnX5tblMhWtVZKVuiMmCkEJMlI/TXc5wlJ9zGQkDa2aTHiIQzocF2JCzNhRxe+nDt
         lsHXCsFI7HSFjrv6Cit4yb2mzob1rO2pdRRblgJrySa8/cplPvqY7da+ZMi6PcFwveLP
         q7EiYpQb0m+76UkC1QaCx8TWN6GZotDAmPRhZf3VcmfHq1UmS1C+oXFRvPRvD+C1O1hH
         KDYrkIciwWsk36yPGuegFpIGfPZHV11b9Xto2tWmDE3tlsp+d8U1HUUW9udo7+6P9MT5
         DF3m7ITSI++Yfq//K3DHWQDbSC5rHvY7/VP2rhegblGVnIJm2aDbgTj4y25vq+WIdgBd
         sg8g==
X-Forwarded-Encrypted: i=1; AKwUvBzgnJb25NF/8nxWRR+ImxnnaYA1JPR4SLxeRPjm0DhsXvwvHqaVVVxELLoVNJ22sAYZpcs5XdU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+RZ0C5aoiWNF6FD6BwF3FsFiocNT039j1BjgeQs+G5/5+SgN4C
	tZ7W7x8zIZ1lrkMryjpipEqn3c5GF7zcXUfTMQWZK/90TRbaGoEH8AVa
X-Gm-Gg: AYBFou3WcuWhnfwtePMEUvCNUqhvzMb3LpTbZcv3nGCfdZ2NZk3wHB1wgO+SU4EE4yl
	cQ9dHzdtqub90tS4RZgViziu8vhalIxuir5wXo85nLRwxczOSgzaKyITJSb++HWfpa7ZEW1KP9Y
	bwTDnLqp3WZ1+oju7JgOVWksxAWFp+b3NjrZl+xXr9l80spRWXjp/MBUj5TdyV+e+jczLX/NWaZ
	QP90W9d/xSa4jgHm7F642CPyC4YfdsMUcTt+GqLZXcf07MiOSTn4+e4s9jq5QL9MPEBSYIR/dvi
	ouijeDwAtjOcEj8jrylI5IFrmM7ixNZHiBvfheirRD6NbRVjX9h/zWLUQuAV1XYrjho2jwz5ThA
	1vVhoH5VoVdaohfxpT2jezu+HE4eDh6PohFIs23IVazYrRkMD8E01n18+492VfWvSsebexIwEar
	LaeFoqvLpFltDJ+YvbyZv2Uyr0/8KWwo3eHrDXJVwApv3DTB5k9DqRrGrxVdR3qF7ldBE0qrbZf
	CE2SjKJDmDuxtf5IjZxIG+FRLcS2y6HtagY3q7wDdIdQwr7zAj5ufI0yLe9BmCdk/aelAFEc14F
	TSmJxLBgsslpZm1IFcDTpY7BRc53dXVHSWZwqS9hm3vU7PyC4eGFzx0mJ9+2VA1eHJUd
X-Received: by 2002:a05:7022:b0c8:b0:1ab:6b10:461 with SMTP id a92af1059eb24-1ac5e3231demr21369464c88.45.1793812128406;
        Wed, 04 Nov 2026 09:08:48 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:88b4:22ec:d621:c1b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c290sm9034336c88.5.2026.11.04.09.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:08:47 -0800 (PST)
Date: Wed, 04 Nov 2026 09:08:46 -0800
Message-ID: <219a70bd93416777ae88becb34d8cb72@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	liuc63@xiaopeng.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] Input: tegra-kbc - check the pin numbers from the device tree
In-Reply-To: <20261103084135.426629-7-zhugl3@xiaopeng.com>
References: <20261103084135.426629-1-zhugl3@xiaopeng.com> <20261103084135.426629-7-zhugl3@xiaopeng.com>
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
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Guanglei,

On Tue, Nov 03, 2026 at 04:41:34PM +0800, Guanglei Zhu wrote:
> The row and column pin lists are read straight from the device tree
> and used to index the fixed pin configuration array:
> 
> 	num_rows = of_property_read_variable_u32_array(np, "nvidia,kbc-row-pins",
> 				rows_cfg, 1, KBC_MAX_GPIO);
> 	...
> 	for (i = 0; i < num_rows; i++) {
> 		kbc->pin_cfg[rows_cfg[i]].type = PIN_CFG_ROW;
> 		kbc->pin_cfg[rows_cfg[i]].num = i;
> 	}
> 
> The helper only limits how many entries it reads, not what they
> contain, and the pin_cfg array holds KBC_MAX_GPIO entries, so a pin
> number from the device tree indexes past the array into the rest
> of the driver data. The later configuration check validates the
> row and column counts stored this way, not the index itself, so it
> cannot undo the write.
> 
> Reject pin numbers the array does not have.
> 
> Fixes: 88390243a993 ("Input: tegra-kbc - add support for rows/columns configuration from dt")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guanglei Zhu <zhugl3@xiaopeng.com>
> ---
>  drivers/input/keyboard/tegra-kbc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/input/keyboard/tegra-kbc.c b/drivers/input/keyboard/tegra-kbc.c
> index e6177f2bdf8d..f086ccf1a075 100644
> --- a/drivers/input/keyboard/tegra-kbc.c
> +++ b/drivers/input/keyboard/tegra-kbc.c
> @@ -522,6 +522,10 @@ static int tegra_kbc_parse_dt(struct tegra_kbc *kbc)
>  	}
>  
>  	for (i = 0; i < num_rows; i++) {
> +		if (rows_cfg[i] >= KBC_MAX_GPIO) {
> +			dev_err(kbc->dev, "invalid row pin %u\n", rows_cfg[i]);
> +			return -EINVAL;
> +		}
>  		kbc->pin_cfg[rows_cfg[i]].type = PIN_CFG_ROW;
>  		kbc->pin_cfg[rows_cfg[i]].num = i;
>  	}
> @@ -538,6 +542,10 @@ static int tegra_kbc_parse_dt(struct tegra_kbc *kbc)
>  	}
>  
>  	for (i = 0; i < num_cols; i++) {
> +		if (cols_cfg[i] >= KBC_MAX_GPIO) {
> +			dev_err(kbc->dev, "invalid col pin %u\n", cols_cfg[i]);
> +			return -EINVAL;
> +		}
>  		kbc->pin_cfg[cols_cfg[i]].type = PIN_CFG_COL;
>  		kbc->pin_cfg[cols_cfg[i]].num = i;
>  	}

Could you please check against kbc->num_rows_and_columns instead of
KBC_MAX_GPIO? Not all Tegra variants have 24 KBC pins (for example,
Tegra114 only has 11 rows + 8 columns = 19 pins), and the loop right
above only initializes kbc->pin_cfg[] up to kbc->num_rows_and_columns.

Thanks.

-- 
Dmitry
