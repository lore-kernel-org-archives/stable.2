Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794574120;
	b=J2/5ARftK8innZ7pPWcMCy3laq/efftS54rPWIVcstJkmrJKaCucB1dJpCSWarXZWuUU
	 XZ4OOx89a5EmpNlLK/pEEIs0NtqqMATOplYyC4nE6AT4xyJz11T/xgHi/UAqOKtA9wndR
	 e/zXMb03y5V0qjHPtR34fiBkOgtG89fQzv+tNsKN+ViSlxvyYP241koUTGktyw067uFdN
	 cmwGxFLHAH4tU2MznlSn7xl7kbyMqzptEb8LLFhtlYN8cUUHpX1LbkahIAxShSvZBhtAV
	 UPM/Rqu8KTQepguw5qe3IJ9W3e4EOg2DowBharTuvQL0bTDW7NBE793sDUBwmgaZftg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794574120;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jz4hVdaW52UUAkyBzaCPrzOKHHNFtHiedb5E1/etRB8=;
	b=C0E2Mu7KVNjmT3L5lotfPlBk6r5TU27PtxQ/L/l0NUNNY4l+34Gz5Wk8Hdz9WNXR9Nxf
	 rCArwTSz8BmDwEmdVkv7KOFwZ23q8WXfaOIYfJKvxF/5OIwHqHwyZ+QL33N/ygyIIm1wr
	 rsFuvG7lxu18wbxwuzX4LJXGmf3cIxyrNGKmu0TSVsAH0oPmQfItjCMTRF7UdNnEwaURa
	 iEeOsVqJ0GaUOA2zUOE6RMQRxdjqORkKqzJvPTcbUzNPJ6ICsw8K1pDArKclN2RyfB2Cj
	 jI+asB9RvtZk9+JkVsYdkT8qDVBuTYnetqn7bf6E6WiAANQAyU1JC12/p8L7UEXetHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=aa13XPBT;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340D1606A32D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 12:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 340D1606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=aa13XPBT
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-491f34b4e0fso292412f8f.2
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 04:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794574117; x=1795178917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jz4hVdaW52UUAkyBzaCPrzOKHHNFtHiedb5E1/etRB8=;
        b=aa13XPBTnWlME6AGchQWWhj8WGEPUrnXgNH+WOydHvaXbcAUsWHkOI/GSW2/SIVUyB
         8MtI2pih7abMuH5xIRGeiapYujpgnF3zpLYi/NF4R4aj5mWgalfCJEVVItt250DMFa5D
         K1WauyvOHmvrHcBqavIlfhKvvj8/VU5wAqxUhIbg21kxq29L21DIl7hjTt4fHocn67zK
         N3Tm8StUiETdtN/vaQJZzWUKYZRjnp+DPmYGs3wmG3/342ugfreO3AD6to7ULluEpV8b
         SLiFg7T7rQ3WAoHUtEd/kUkdc8OmMKP1vDqdUoY+T1DTvSr34N/bQDHs/emCYvhMAE9Q
         u37A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794574117; x=1795178917;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jz4hVdaW52UUAkyBzaCPrzOKHHNFtHiedb5E1/etRB8=;
        b=PPt7PFHLVcRms6KnRKEYQDn0VDTA1S5u6OMskct+OZ2WvsU0+nehMwfUDH7pqsBvTA
         J5P1NiI1IjjJjBnwIiBNA8MK6e/3x2IJqZEkY1n16JS8xAZcD0oRpJROYTZThMS3a5uR
         k5OVkDDTNM1e/8LlRJ/gsGFp2fMBw0wyV2ujiiKnohZPjeW1z1W7QKdxzja+cQJVjjzV
         eH2db97iR647Rhm6Pt0BOkF7RZF1deFVnRRLyVKMjsJzFcFd5Xyq1wgSgdOXiYoHfzcv
         vQeKdFDNx1U1oOB+FWGZ9JdD2qicO/WgCorFLUbdRgi7ogD96WRG6oRgC81flCSOUox2
         fRYA==
X-Forwarded-Encrypted: i=1; AL+hErEqtmb/Jy85KD1hHMawkoiOSIk0Wkmt0OmoKjMFi1QrxOD9WOajMKXgVaVWWuDyHBGn1wfwRMQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3YmTIQuo9wjSDYQV9EvurmmIJhapnWXkMxU3F6OULNVKa3GeY
	S8zF9yNDK8/iVmGbAc7wDloEMIgYtg1JvfmxU8akFFcYrTNX7re0SzWHDL9l2BCknPCXlnic3DJ
	HpzLG34A=
X-Gm-Gg: AYBFou1vTEsgvAflVksGY8G2fV9A6Gv+NjakBXvfpi5CJtAPRrTjFlBSQg7dY0OpvbX
	K3hyP/IqKc3zrOKpE4wEN32OoatpUIo6E1uNuoEdjfRC4GTreEaFVnXXP4jXsFiGwKNVbjexwUn
	rIsRXQ+JzUtaV8ZXT8yIFfB14vfTpujvj5OpaRJegnNhOIlHH7MCO76k/dlOdA9gp+g8ZwiwfZo
	Fvz57dYUVF5uICzmmo7xR+HSJ/oKIWNohLq1on2Aqa9r2JgdQ3/0emeljebajaKbkTuow+6+1ZX
	xOZ6clJ3vw/NY3J4rytJcVbmA73OUfAJEABpCPP3JTeb5x7JTJxlm8CxVTN3UbCl+LF3izCyhJs
	uVo27KaGNVLLIc42cvtUSZb4ztF1HpokVBDEE5+UFT3dHjKqqDrbUfAYdasBu+yFsPMEWAqPjnY
	glycBqNLBU2P3NAbJ9f1Uh9UBq+pW/2iL5Ol/cKaSEe4LU+b8FMcV5DzSuMnTcYcRuIZsLfYefg
	usBLUEJj9S//UIBKDM3+uce953HFuCxIyF5Oa8+umV8mRqrijhsNdT4Tpx+kjXPczhHX7yatIG9
	/y+WGpvIFMPzjzSHTItvKokKt/Uj
X-Received: by 2002:a5d:5e85:0:b0:48d:f391:5c45 with SMTP id ffacd0b85a97d-49c740bcf7amr4648801f8f.42.1794574117479;
        Fri, 13 Nov 2026 04:48:37 -0800 (PST)
Received: from localhost ([82.145.117.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5fe370f8sm4643230f8f.27.2026.11.13.04.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 04:48:36 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Fri, 13 Nov 2026 13:52:34 +0100
To: Xiaolei Wang <wangxiaolei01@kaihong.com>
Cc: linusw@kernel.org, florian.fainelli@broadcom.com, rjui@broadcom.com,
	sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	daniel@dragonzap.com, iivanov@suse.de, andrea.porta@suse.com,
	phil@raspberrypi.com, linux-gpio@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Jonathan Bell <jonathan@raspberrypi.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] pinctrl: bcm: Fix off-by-one and out-of-bounds
 access in fsel_get()
Message-ID: <avcIEnCThuTHeWVv@apocalypse>
References: <20261113053221.3131068-1-wangxiaolei01@kaihong.com>
 <20261113053221.3131068-2-wangxiaolei01@kaihong.com>
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
In-Reply-To: <20261113053221.3131068-2-wangxiaolei01@kaihong.com>

Hi Wang,

On 05:32 Fri 13 Nov     , Xiaolei Wang wrote:
> The FSEL field is a 1-based function number: 0 means GPIO, 1..n_funcs
> map to funcs[0..n_funcs - 1], and n_funcs + 1 and above are rejected.
> brcmstb_pinctrl_fsel_get() indexes funcs[] with the raw value instead
> of subtracting one, so readbacks are shifted by one slot: value 8
> indexes funcs[8], past the array end, while 0 is reported as funcs[0]
> instead of GPIO. The setter programs the mux correctly, so only the
> debugfs readback is affected.
> 
> Map 0 and out-of-range values back to GPIO, warn on the latter, and
> index funcs[] with fsel - 1. Tested on Raspberry Pi 5 with KASAN: the
> "alt8" readback no longer splats, and field 0 reports GPIO.
> 
> Fixes: 657cbf9b24ba ("pinctrl: bcm: Add STB family pin controller driver")
> Cc: Jonathan Bell <jonathan@raspberrypi.com>
> Cc: Phil Elwell <phil@raspberrypi.com>
> Cc: stable@vger.kernel.org
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Xiaolei Wang <wangxiaolei01@kaihong.com>

Reviewed-by: Andrea della Porta <andrea.porta@suse.com>

Thanks!
Andrea

> ---
>  drivers/pinctrl/bcm/pinctrl-brcmstb.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/bcm/pinctrl-brcmstb.c b/drivers/pinctrl/bcm/pinctrl-brcmstb.c
> index f46b27155c3c..2b942ca7196b 100644
> --- a/drivers/pinctrl/bcm/pinctrl-brcmstb.c
> +++ b/drivers/pinctrl/bcm/pinctrl-brcmstb.c
> @@ -66,7 +66,16 @@ static unsigned int brcmstb_pinctrl_fsel_get(struct brcmstb_pinctrl *pc,
>  
>  	val = readl(pc->base + BIT_TO_REG(bit));
>  	fsel = (val >> BIT_TO_SHIFT(bit)) & pc->pin_funcs[pin].func_mask;
> -	func = pc->pin_funcs[pin].funcs[fsel];
> +
> +	if (!fsel)
> +		return pc->func_gpio;
> +
> +	if (fsel > pc->pin_funcs[pin].n_funcs) {
> +		dev_warn(pc->dev, "invalid fsel %d for pin %u\n", fsel, pin);
> +		return pc->func_gpio;
> +	}
> +
> +	func = pc->pin_funcs[pin].funcs[fsel - 1];
>  
>  	if (func >= pc->func_count)
>  		func = fsel;
> -- 
> 2.34.1
> 
