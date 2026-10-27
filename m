Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793117130;
	b=XrxCH+oU9KtatjOgTHsMRlqpmKQLvbozXmQD5cDPF27fZya68JStfqljHPuvZdid0jcy
	 iUvlmn1JvOZVY5Or3Qr5nRxWiQQ9yl14E6nKg0wr+uucyJu+j3G4Czc66DBfUfoU6cO+F
	 nuRGTVED6F+NH+eELyyRXktwBNgw2WybPNMJGZCqvzUGUqekR0v7h4PukQapdezI9vCWz
	 0riY/OIsPAijHsVcKmslS1fbSUX4ai++hkfZTY+qnGAxKe/MlsvANhjNJYQUadkKcXvP+
	 Ii/qLyW2igj5lGYSKaNjm455+r0aXxiilvmKyYWPHzzTYRd9sEOhAKBecrhBsAkuLcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793117130;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=znwq9KG/l2CzOedJVktIS5u20w/kYRWrngVGRcQMqdI=;
	b=Wj4FczkUv1UCVOYGroWUf+Zbwr8Y2ndfZYgmicOMWi1d+dFdmGReBIkPd5xg/J1yuUBG
	 UAhU0oRNzsOldhVVzDb7Miv2nTNCu1GhXfwCa1hilF+KKjNbNDvg+TESVxwqOtGAuNq8S
	 uRmgVK7jUjCkc0hMyMus7yYTE2jkBoi2nPqA7MB1vYqKeCkKuF+R3w3LlVA89Tkzs4BOZ
	 ISjMZLm1XCJkupwiK89KrKuzCZ9YTlfeBdxJf0tqFFmeAzxty5fX/IrXVal82cVkL1e9U
	 XYKd5GW+SxUX61z8JfC0/qL9vtgSvjCn0gVCYF+B86chJJnJeD+FRCZo+F8rd+bBNOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=mlTxIFuS;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B4E606A31D;
	Tue, 27 Oct 2026 16:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1B4E606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=mlTxIFuS
Received: from [192.168.0.43] (chfd-03-b2-v4wan-176392-cust229.vm15.cable.virginm.net [82.19.20.230])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 35F05493;
	Tue, 27 Oct 2026 17:03:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1793116995;
	bh=pbXoieiNF/gtZjfmWjqIF4b0//1+leDv9Tw4jjv2icA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mlTxIFuSmDKAyLhJHu8w4sWqvENLd6lyex5pzrRJUyF8YgYAXOV6r4j4e1fyAVqz7
	 KXP75fxMvsomoH6FIA8wz37M5QH22MgBuYObYtBHKzdrZVDvrsbPdY/ylhz5rxjIVx
	 cxi8+Cvg3XxMu65SgrZXR7xOIlx7q2saKis7W4Xo=
Message-ID: <80fe2c30-bcb8-49b1-aca3-d5b7ec69a5c3@ideasonboard.com>
Date: Tue, 27 Oct 2026 16:05:24 +0000
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
Subject: Re: [PATCH 1/7] media: i2c: ov7251: Fix link frequency index
To: Antoine Pichot <antoine.pichot@gmail.com>, linux-media@vger.kernel.org
Cc: sakari.ailus@linux.intel.com, mchehab@kernel.org, djrscally@gmail.com,
 hansg@kernel.org, andriy.shevchenko@linux.intel.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261026111032.88355-1-antoine.pichot@gmail.com>
 <20261026111032.88355-2-antoine.pichot@gmail.com>
Content-Language: en-US
From: Dan Scally <dan.scally@ideasonboard.com>
In-Reply-To: <20261026111032.88355-2-antoine.pichot@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Antoine

On 26/10/2026 11:10, Antoine Pichot wrote:
> ov7251_check_hwcfg() stores i, the index into the firmware's
> link_frequencies array, in link_freq_idx, which the driver then uses to
> index its own link_freq[], pixel_rates[] and pll1[] tables. The matching
> driver entry is j. Store j.
> 
> Observed on a Surface Book 2, where ipu-bridge lists one link frequency,
> 319.2 MHz, which is link_freq[1]: V4L2_CID_LINK_FREQ reads 240000000,
> and the pixel rate and PLL registers are off the same way.
> 
> Fixes: cc125aaa5a78 ("media: i2c: Provide ov7251_check_hwcfg()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Antoine Pichot <antoine.pichot@gmail.com>
> ---

Thanks for the patch, this is right:

Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>

>   drivers/media/i2c/ov7251.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/ov7251.c b/drivers/media/i2c/ov7251.c
> index fce6344b51..1413f1856e 100644
> --- a/drivers/media/i2c/ov7251.c
> +++ b/drivers/media/i2c/ov7251.c
> @@ -1523,7 +1523,7 @@ static int ov7251_check_hwcfg(struct ov7251 *ov7251)
>   		goto out_free_bus_cfg;
>   	}
>   
> -	ov7251->link_freq_idx = i;
> +	ov7251->link_freq_idx = j;
>   
>   out_free_bus_cfg:
>   	v4l2_fwnode_endpoint_free(&bus_cfg);

