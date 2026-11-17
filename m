Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.81
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794933997;
	b=SYwQM86aROub8tIHgjXDQmeHLPeBzO6pWf1lmdwd12ew4WMnqB8VHS/rCTG+fwhXdgbd
	 cbvYIBWvf22by39dvWu9d1JHwljseH56BmtvaY1lBj+K9oUj5aD8L5li9ZAmELCCd2mgk
	 ngYyHcJ+TB3KeRm7qj9e5mEeFub68sZZrVQJG8xI38AKVxFar9z87YbvD2Tep4SeE7nfX
	 tF9UgOQ6WMbCxHZ7kvAlo4DlPDKBcmABIuRbuwwz4cuaaWHsLuisZ7FzzDv9jbXMdZeHF
	 ecy0ykjTqFOOAS6yzHcDCCwQffoCjVdpDPHqGJJfl3DT+WYCpyDr4R7jeThELHTyz7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933997;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=L65L3kGQgyTU4k+t+QLZcR/E5EnwHfrvUT/pNYvIL0c=;
	b=RtC2ffRG2qVF90PFbrsD1o5Jm5gZ1IkyGjjAF8JKGg70H53sh/GBdnmv5OziCyLlKT3M
	 pB+qFThyumX6OM+YU7506aaatWeCIQAiGckBke9TgwnIe13LGHIXyEsRcgI4wEGcMrqPC
	 VXaEaYVSe3fH8tTpHaat9jwgQDcWvC1A9grok6Zosmgr1tcX11S/WMPkK0nLVkbQnBySz
	 Dad6o2XoThGMk9We6mvV/k6QkPPrWovj1OMm/8JV7ZyviAuZlUG/0SbyZC4MaR+mSjPLA
	 lkP3WZOVAbCSkfB9El2Smsa5WIFZUZLSLkUUqna85CpIj5U/h0mmSWcqLpep3mOc0sg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=hartkopp.net;
	spf=fail smtp.mailfrom=hartkopp.net;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=UO8UHY1z;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=3VHItw1E;
	arc=pass header.oldest-pass=0 smtp.remote-ip=85.215.255.81
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D147606A32C;
	Tue, 17 Nov 2026 16:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D147606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=hartkopp.net header.i=@hartkopp.net header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=UO8UHY1z;
	dkim=pass header.d=hartkopp.net header.i=@hartkopp.net header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=3VHItw1E
ARC-Seal: i=1; a=rsa-sha256; t=1794933984; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=G+xGrmN80mXvY92Dyb21DybRrmlQrHxe5D2MMe88uN81FmKo4WC1rcn4nBcUTOEhXm
    rjQSX93To6MjgxMAs/HvISGFEyxU7Qq+G9Jas/G8mZFQqM/OnNkFPq1KrglZsLAOHfAj
    a7hnIuhrODCnOFfRaHq8YqTmqK2PevK0cJuLy2aHkfcSdin1m9GK/nDwpW23PSgEWYT5
    nHa+g9fUuzgyn2M4bPkgDwuNu+HYOmVmqIkqaGXFBtiLCGeksvNSzeF7Pp398ruGWtK7
    iukUEJQFoGZuhFgx2VrksVU3IxnSk0Vb3KWVF4HYo9KhdGg+TsrncQbTwGbePTf+/rE0
    sB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794933984;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=L65L3kGQgyTU4k+t+QLZcR/E5EnwHfrvUT/pNYvIL0c=;
    b=NuT6R10j4JuzzObyDufeWI4r5+H030rHTjUetprQz7b13LVCxR85xMwdF9edaLlaWt
    RHt1L6GhuvdNcceAu97IzMrdXH5N8ifrz9DPy4BkhNgCAjXGaIj73edrpd6dMNtpCVuE
    tFxK6pEG31eRnikdc3WJQaulT95bTri4pVLWY6uftKHp8w+jvRPd5oOMpW6elj4aKqR3
    ccISZYoveEILrL4t7Is0t0EV+tExhPSud0mhgUg0OjIWV0BVyBHig7SDchNVlVp9/kGT
    Hotpk5JkCISd+HldbxYDTCyz8Z76k3AgkdnCnpcC5lnFp3yQjR9VOZ1mcWfAKCuFA4Ac
    YJuQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794933984;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=L65L3kGQgyTU4k+t+QLZcR/E5EnwHfrvUT/pNYvIL0c=;
    b=UO8UHY1z/SzLcCL+1pvAkllgf55ZgsEqmp4iJN0+TbTnwhdoIVLeC4LUdL4gt435Gh
    yoEH02vkTam2i5T6Yk3FEPcgMhXrKpvbviPkCj/zBwUCeWmV7qgOz6mcOiiyLo7NYNhN
    YXQWHRQKYnwPDjMlttIyciRDIX1UO255C2CRfp0IitRdcvVUetMzlRFYbZ4XmGOoXZ6k
    Owr+uXbvEuMr0SSs34YPNUmEAOx3y1bql9bFel6k2Pwggut7bF88+abN44IM12fpvKoS
    1Jq74lXgGLa0ABjjUgr7PLmqrkyPAFutRb4JEsW+n5Ld3jGcSVHrx0GECPsiunusciAs
    M8lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794933984;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=L65L3kGQgyTU4k+t+QLZcR/E5EnwHfrvUT/pNYvIL0c=;
    b=3VHItw1E6/HkHQgupg6jZA4LgMOTup9L5OyR0GS7+3pu8EtKuCb+LRH2MuO4VWKd0t
    q0STP/OIy8PsPJJuq8Cg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bDup0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::989]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id Kfdf2a2AHGkOdj4
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 17 Nov 2026 17:46:24 +0100 (CET)
Message-ID: <3f367733-75e6-485b-bf63-10864b5005ee@hartkopp.net>
Date: Tue, 17 Nov 2026 17:46:24 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/9] can: netlink: fix static FD-NON-ISO mode
 validation
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de, Zhu Ling <zhuling0805@qq.com>, stable@vger.kernel.org
References: <20261115095746.709371-1-mkl@pengutronix.de>
 <20261115095746.709371-4-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20261115095746.709371-4-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 15.11.26 10:54, Marc Kleine-Budde wrote:
> From: Zhu Ling <zhuling0805@qq.com>
> 
> The static CAN_CTRLMODE_FD_NON_ISO mode does not have to be specified when
> CAN FD is disabled. Since commit 6742ca18cb41 ("can: netlink: add userland
> error messages"), ctrlstatic_missing is calculated before applying this
> exception. Disabling CAN FD on a controller with static FD-NON-ISO mode
> therefore fails with -EOPNOTSUPP.
> 
> Apply the exception to ctrlstatic_missing instead of modifying ctrlstatic.
> Keep the original static mode mask and restore it after applying the
> userspace mask, so a request that disables CAN FD cannot remove
> CAN_CTRLMODE_FD_NON_ISO from priv->ctrlmode.
> 
> Fixes: 6742ca18cb41 ("can: netlink: add userland error messages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhu Ling <zhuling0805@qq.com>
> Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Link: https://patch.msgid.link/tencent_3A964832542399A780E646D6A6246335C409@qq.com
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> 
> Notes:
>      FAQ:
>      
>      Q: What about netlink payload size underestimation in can_get_size() for
>         the IFLA_CAN_BITRATE_MAX attribute.
>      A: This issue will be fixed in a follow up patch, to ease backporting to
>         stable.
>      
>      Q: What about netlink payload size underestimation in `can_pwm_get_size()`
>         when PWM capabilities exist but `CAN_CTRLMODE_XL_TMS` is disabled?
>      A: This issue will be fixed in a follow up patch, to ease backporting to
>         stable.
> 
>   drivers/net/can/dev/netlink.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
> index 081dfddda000..0cd55613a616 100644
> --- a/drivers/net/can/dev/netlink.c
> +++ b/drivers/net/can/dev/netlink.c
> @@ -332,7 +332,7 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>   
>   	/* do not check for static fd-non-iso if 'fd' is disabled */
>   	if (!(maskedflags & CAN_CTRLMODE_FD))
> -		ctrlstatic &= ~CAN_CTRLMODE_FD_NON_ISO;
> +		ctrlstatic_missing &= ~CAN_CTRLMODE_FD_NON_ISO;
>   
>   	if (ctrlstatic_missing) {
>   		NL_SET_ERR_MSG_FMT(extack,
> @@ -357,9 +357,9 @@ static int can_ctrlmode_changelink(struct net_device *dev,
>   		priv->ctrlmode &= ~(CAN_CTRLMODE_XL_TDC_MASK |
>   				    CAN_CTRLMODE_XL_TMS);
>   
> -	/* clear bits to be modified and copy the flag values */
> +	/* clear bits to be modified, copy flags and restore static modes */
>   	priv->ctrlmode &= ~cm->mask;
> -	priv->ctrlmode |= maskedflags;
> +	priv->ctrlmode |= maskedflags | ctrlstatic;
>   
>   	/* Wipe potential leftovers from previous CAN FD/XL config */
>   	if (!(priv->ctrlmode & CAN_CTRLMODE_FD)) {

Sachiko made a review of this patch which didn't show up on the mailing 
list:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261115095746.709371-1-mkl%40pengutronix.de

The problems were valid and I sent a fixed version here:

https://lore.kernel.org/linux-can/20261117-can-bcmlock-memcg-v6-8-6826a6227d36@hartkopp.net/

pw-bot: cr
