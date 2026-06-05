Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E33C416D15
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780676940; cv=none; b=aJqUWHhqoFf2HzjXXZnEQGttZKIO1XT5he/tpZNPifXaFUFYF7pmmHdpoqWTT9NTW+FUTrwBfLh9gc9FC+3NYOB5Fri01Z9dNBYoK785oD/V6LvjtJySzVqz1KM03IaApAzKdQ9hYpIlIa/g8E1K3i9SO8+O0y64c6P1cst7H0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780676940; c=relaxed/simple;
	bh=G2UoaTUBsy8YP1XAK8MC20PbrieDy7yS/loF19hogbg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Cu1boaHZSDokPWNHd44Ux5qJEWnckFqcnnJMZX8WZiVkhHXX2pDA2fWsvAaVOE2XQcUoWQLyfO6s8wrA0WE9M+jD53W7ssriSCWfa+e+R2SILNUthtb1hpQEGjEJYhICmeFV/04VeJxddLyoFMZT3nYSJ8pFRA90CHmTUHqub94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca; spf=pass smtp.mailfrom=marek.ca; dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b=U31cEtL8; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marek.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marek.ca header.i=@marek.ca header.b="U31cEtL8"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-9159bad8c98so235138585a.3
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 09:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek.ca; s=google; t=1780676931; x=1781281731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=keYw8EcQ4PK+W0SNMoTM+wvQ1RmTHYvCycVi3RIxEGs=;
        b=U31cEtL8hb102unwA4N19zq3dZs6hHu2KoOQb2fPXFc4EzSKfLLxyp0NHMfHBo5vaN
         6uUnP0i8qymujvCSA/fj1Hf7xxTCr6nHhwW8ZIP1qgmFpYS+QO3mvhobckR+5cC1gvT4
         OfZIEf9uSHXjdWPHhAc6A2EpeAAuToMnN9nBpIdAbRXRT/+zMa66m64jRfDQCXQe9+Nx
         stdKGDKCm4KKR0a0XWNYEnqccp4t14zP7mzingQqjTMemzIkyaIRapQdbN2oRsk8QF1L
         m1lGBKJoWCaPnWGySGxnSAO2ugJDDCkA1MSaEl6y+jre866A320dm/XqJ6+uzJZdnPkg
         07uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780676931; x=1781281731;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=keYw8EcQ4PK+W0SNMoTM+wvQ1RmTHYvCycVi3RIxEGs=;
        b=ei2s373TGsVbr5uxM6Lj/K1axuq2LiFF0iAIhci7ntSLBs1OFUDSOWty/e3tHwuV6P
         ig7tNh+7NHZ7ETC3LdFADiIaitrXsD8bxkybWr7LYhM4TC+JqvDhmy+VuPYC96VaaRdl
         P7qYoN/Q8BQFO689uBj3OFmJAatxs0UdjIVokLa7ExGs2KOSMwpk/tu1imMuoGE69EKA
         g6M2KCtqhbL5VY7JCmXw7d40P2IFOY79BP+MKDNnCoDzWPNvNQxbS7fvA9Iv1lo2iyOT
         mztmWMZxfKVbjQqepsZG8sHNv9jJ6aAeYXmc9p32yeTVFn6do2bpOryMvLDm/FGZjsXJ
         yJ/A==
X-Forwarded-Encrypted: i=1; AFNElJ9UqRyPUHjnYkiBev+v6l3BDRlpiXsEceN6ujfh4mMGfRyNXWudKEsEqeYNMB5t0/nW/D+l3EY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy26WOwdQSlULrV3tgYDYYPkid3a5ZLUanEAyyi9fjdLvBqE28J
	B1jQ1aXFzKYZMENu2wdMrcXpxKir/K1BGNs/zNJNPhObQ+AGng254UAUD1BNyT9jHReb00CayEC
	0E1Oc
X-Gm-Gg: Acq92OEqn0VRTEwFwotTAuT+4RtRH1doPvzdNyXECNGcqGIm7n5sZLB4D5TZB8tFBm7
	Ho9HZXo/E0/ogyNdtL/x0zl85Go8ASFbl62OWfFkiTUvIabrnc/i9o9XyZzA+qFxdSOue6wWeic
	tO56b/1A2NunAw83zDvgAiQdPenYG2QewD2CxthtAgCIQst0/0sY4zgTr6RBTppgzkjiFn23s93
	BPEipUGBebUdbSv7vaQLa/BwLZ2pTtf/G0vNbQ/l+LZamr3fnNbKXR0N5NZ+/ETuyIIWsZwHqWr
	rmW4NRbyhZeXhPwI1eHm07xKjcsbzSDixrtde164R/R3OLH7c/GIYDj5pMaj8uzsGX5IAo9mvtj
	hB/7uj1otXS447OoHJ8DYWKkMThCVPpp6gBW7sSxkQoNcFCs9fIwcErAleY9CZK9tlqfs9cXSYM
	WoD6O7TM8oBErI+9ALhzn8ltMyqUFB9Va24U95XqRrJgj26XiJPtfBkUsRiarbXKDtXdTyHTEcp
	zme4/iOWJWXcCWECSk=
X-Received: by 2002:a05:620a:480b:b0:911:449d:98c0 with SMTP id af79cd13be357-915a9c4bd5emr831113485a.7.1780676930899;
        Fri, 05 Jun 2026 09:28:50 -0700 (PDT)
Received: from [192.168.0.189] (modemcable125.110-19-135.mc.videotron.ca. [135.19.110.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9158a411333sm989320385a.46.2026.06.05.09.28.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2026 09:28:50 -0700 (PDT)
Subject: Re: [PATCH v1] spi: qcom-geni: Fix cs_change handling on the last
 transfer
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
 Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260529-fix-spi-fragmentation-bit-logic-v1-1-3b30f1a3dd7d@oss.qualcomm.com>
From: Jonathan Marek <jonathan@marek.ca>
Message-ID: <dd247b87-71a2-78d6-fb6f-663906c8ec59@marek.ca>
Date: Fri, 5 Jun 2026 12:24:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260529-fix-spi-fragmentation-bit-logic-v1-1-3b30f1a3dd7d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

should have another Fixes tag for the GSI xfer fix, otherwise LTGM

Reviewed-by: Jonathan Marek <jonathan@marek.ca>

On 5/28/26 3:03 PM, Viken Dadhaniya wrote:
> Commit b99181cdf9fa ("spi-geni-qcom: remove manual CS control") introduced
> automatic CS control via the FRAGMENTATION bit, but missed the case where
> cs_change is set on the last transfer in a message.
> 
> For the last transfer, cs_change means that CS should remain asserted after
> the message completes. Since GENI SPI controls CS through FRAGMENTATION,
> set FRAGMENTATION for this case as well as for non-last transfers where
> cs_change is not set.
> 
> Additionally, setup_gsi_xfer() was storing FRAGMENTATION (BIT(2) = 4) in
> peripheral.fragmentation, which is a boolean field consumed by
> gpi_create_spi_tre() via u32_encode_bits(..., TRE_SPI_GO_FRAG). Storing 4
> causes u32_encode_bits to mask it to 0, silently disabling the FRAG bit in
> the GPI TRE regardless of the cs_change logic. Store 1 instead.
> 
> Without these fixes, TPM TIS SPI transfers deassert CS between
> single-transfer messages that use cs_change to keep CS asserted across the
> header, wait-state, and data phases, breaking TCG SPI flow control:
> 
>    tpm_tis_spi: probe of spi11.0 failed with error -110
> 
> Update both setup_se_xfer() and setup_gsi_xfer() to handle this condition.
> 
> Fixes: b99181cdf9fa ("spi-geni-qcom: remove manual CS control")
> Cc: stable@vger.kernel.org
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> ---
>   drivers/spi/spi-geni-qcom.c | 27 +++++++++++++++++++--------
>   1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
> index a04cdc1e5ad4..0618f6bd7878 100644
> --- a/drivers/spi/spi-geni-qcom.c
> +++ b/drivers/spi/spi-geni-qcom.c
> @@ -449,10 +449,15 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
>   		return ret;
>   	}
>   
> -	if (!xfer->cs_change) {
> -		if (!list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers))
> -			peripheral.fragmentation = FRAGMENTATION;
> -	}
> +	/*
> +	 * Set fragmentation to keep CS asserted after this transfer when:
> +	 *  - non-last transfer with cs_change=0: keep CS between chained transfers
> +	 *  - last transfer with cs_change=1: keep CS asserted after the message
> +	 *    (e.g. TPM TIS SPI uses cs_change=1 on single-transfer messages to
> +	 *     keep CS asserted across header, wait-state and data phases)
> +	 */
> +	peripheral.fragmentation = list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers) ?
> +				   xfer->cs_change : !xfer->cs_change;
>   
>   	if (peripheral.cmd & SPI_RX) {
>   		dmaengine_slave_config(mas->rx, &config);
> @@ -858,10 +863,16 @@ static int setup_se_xfer(struct spi_transfer *xfer,
>   		mas->cur_xfer_mode = GENI_SE_DMA;
>   	geni_se_select_mode(se, mas->cur_xfer_mode);
>   
> -	if (!xfer->cs_change) {
> -		if (!list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers))
> -			m_params = FRAGMENTATION;
> -	}
> +	/*
> +	 * Set FRAGMENTATION to keep CS asserted after this transfer when:
> +	 *  - non-last transfer with cs_change=0: keep CS between chained transfers
> +	 *  - last transfer with cs_change=1: keep CS asserted after the message
> +	 *    (e.g. TPM TIS SPI uses cs_change=1 on single-transfer messages to
> +	 *     keep CS asserted across header, wait-state and data phases)
> +	 */
> +	if (list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers) ?
> +	    xfer->cs_change : !xfer->cs_change)
> +		m_params = FRAGMENTATION;
>   
>   	/*
>   	 * Lock around right before we start the transfer since our
> 
> ---
> base-commit: e7d700e14934e68f86338c5610cf2ae76798b663
> change-id: 20260528-fix-spi-fragmentation-bit-logic-880394337ff9
> 
> Best regards,
> --
> Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
> 
