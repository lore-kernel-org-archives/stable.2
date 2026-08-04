Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF49F391507
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 21:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878349; cv=none; b=AkDFDhz+yBpsiriVaQaxXY5VVP7QgqUV7nlUiXiAxONgzqHfOdr+aKnGaDOCEHcOLvK1DD5IVR2eDMw/pOeP0QEqEunO3zhf7MY5h6GbKa2Zl/Nqz8S3raV52TiFrRO8eq8P2PCnLlnPHlJ+kyTETEqCZL8xxBccDhalmzOSatw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878349; c=relaxed/simple;
	bh=sr2Cq9PRWWi2YOdQ68q3lF48Fp53MwBlfAhHyCZ5ViE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ScpwNomHU6LEBaCDItRrAF1XuNooWxn4MCOHiNAdZ1hc27wwUz6n5n5qUoP1wSpkWXfkydxaxDoVC7dZtfLzyv+/QduL0wFnDkSHQNnhiJVzQiDb2d1K6vpCuD8YMkJk1e+1k4szeWlwYuhUjdaLuPXbWoql1KrxrNrJ6JXarrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hZC2a5Cw; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hZC2a5Cw"
Message-ID: <38b89c7d-58db-410a-b943-7ebf30c47905@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785878335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u7+ldWnQ/ZMVcD+XRoaEbqgZ0HqDoRKLAZFfAukpgXc=;
	b=hZC2a5CwsVGTNf9ebavs5WVzJDIOV99BR4asEfugnfeE/yQ96emVvepo7MriWJwfIIcFcC
	g4w5Da1GlJdfLgSy5qK4nredpSlQ72jwzzmWwrZI4RHYCN31E9SKhpSb+P7qRsa6Lzq2eH
	NhrFYoWGrLkZ4whU50V10DckZvfl0Bc=
Date: Tue, 4 Aug 2026 22:18:41 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v3] ptp: ocp: Fix board ID over-read
To: Ahmad Byagowi <ahmadexp@gmail.com>, netdev@vger.kernel.org
Cc: Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260804210751.48248-1-ahmadexp@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260804210751.48248-1-ahmadexp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 04.08.2026 22:07, Ahmad Byagowi wrote:
> The EEPROM board ID is a fixed 13-byte field and is not guaranteed to
> contain a NUL terminator. Passing it directly to
> devlink_info_version_fixed_put() treats it as a C string and may read
> beyond the field.
> 
> Format at most OCP_BOARD_ID_LEN bytes into the existing local buffer
> before reporting the ID. Use a precision limit because the snprintf()
> output size alone does not bound the source string scan.
> 
> Fixes: 0cfcdd1ebcfe ("ptp: ocp: add nvmem interface for accessing eeprom")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ahmad Byagowi <ahmadexp@gmail.com>
> ---
> Changes since RFC v2:
> - Split the safety fix from the net-next feature series and target net.
> - Use the short Fixes hash.
> - Reuse the existing devlink info buffer and bound the source scan with
>    string precision.
> - Limit the change to the board ID over-read.
> 
> RFC v2:
> https://lore.kernel.org/r/20260803205011.1249-5-ahmadexp@gmail.com/
> 
>   drivers/ptp/ptp_ocp.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 35e911f1ad78c..3d26ec1f7b9ec 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -2177,9 +2177,11 @@ ptp_ocp_devlink_info_get(struct devlink *devlink, struct devlink_info_req *req,
>   	if (err)
>   		return err;
>   
> +	snprintf(buf, sizeof(buf), "%.*s", OCP_BOARD_ID_LEN,
> +		 (const char *)bp->board_id);
>   	err = devlink_info_version_fixed_put(req,
>   			DEVLINK_INFO_VERSION_GENERIC_BOARD_ID,
> -			bp->board_id);
> +			buf);
>   	if (err)
>   		return err;
>   
Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
