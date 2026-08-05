Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C653955FC
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 06:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785909922; cv=none; b=tuNil07luZZNs7xGdSdza3BqtFlGidQTr4wwjAYniiixHO8gB0cszstu3nTvMs1l0l2esMby6j5LGujafxjz/kGilYCxll8F0Jbul/xfBucMgjlTwyzYa3JsDqSFQLf/fgn3S2GWgLn2ns4BpD5lS/56/eQoioIULqac+idhrv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785909922; c=relaxed/simple;
	bh=OriPhg6YGIwEW9hmmH46YSgFHuBbRMq19BdArA9MZD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WpEFmFp9IyVQMYx7t2r2Tsevm67o7NFgzZyuliiYnx2xx3lNnsHsAfu0bV+WRFC0RCt5FxV8/+xazxLX0fjo3LXrcITXdu/phDMagzKCYdXbgWzI5GBlkHKSBt9dHoa0oDQkpHggFZojUzGP0lPRZuIvPWSBnu3Uj5IyCMph7FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=f+ow04oh; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="f+ow04oh"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso523934a91.1
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 23:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785909920; x=1786514720;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ixvJyzHf6CwQR78Vnc98OrtjL5Qm3qHKniNH1npgOPE=;
        b=a1I0hJ1ZWior3rCOLiEZpPeqHG9EeAs5YI8IRTJ+ZtaVd0ioo1ck5xKLaEXjt4l4LQ
         yQqsEyGYfTMoHwP4rdKYScjp+DkeX5aINVCuzGdb4NYeL+KS4X0fIFTl/doY2/Q4R5lP
         bruHnGwuqrjVUZqxbjpBwl/wYOczoIsBG0SkYFBsUi3/Fk3DYNFv0jYrmniNo5rltwlm
         NFo/qA3BIO9X8r6seGTRUpSZpIxhPtjFuLUVUYETwzkFR1ipdcfF0NGhpb7V2NsQYKfr
         TrPT/e+7trtRuJrSxomFXJryMEKjipVJP7V58KyGkU97/jLh56aMFQ7JaUw9dgM4cq59
         PKEw==
X-Forwarded-Encrypted: i=1; AHgh+RpzsCpTQaJ136Xpb8nkT2W5F6mToxkrkur/PMvkFRqi6x8cVcr3ncgacoUseaNw8WXovSnEjcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6rrsoURfGPNeuMTi1q89NY40RpQfNygGMAZVr9jI1hy8Ay872
	HaVf1V8KsuEw1XWgf/hTfPjANs74pZYZ4nJc0iWIe03ws2TCsrH4RZ9UBF5dqHvpA2rUvnrP+Y/
	VXLMvgQwZNloSRxdSTX3kJKZWwviTMx5/I4T/gMTJsJGloXzh5sYCoWMhA9hrhfnBLJmfqE3wDr
	OnrTgOmWvbGYmeiMDgiup9CA7Vp/TFrJoh9ApaamVwJ06Pw2rAEZxP1gbdPwHsAHlq0JaRrN3Hs
	KTEvLMd9eUbVqThuQ==
X-Gm-Gg: AR+sD11NrWPXAf6zn1vvjIe0j6aIhbEEUC03F5Lnh3sbp8BUvmt6jFCAi+CzCGaUfc7
	qdb/A4ETebXs2tyOzKqYFaP7NJaEQFIMK1GpP6P9AIkg/vFnuYH/jIAX/NNQ4oh571m5rWU2ySf
	aQCLm4o6rX9VKLU7aHFKIj1aLc6LgVxw5A5HLTCim7DO1sq83IAT87Nt9DeN+Dl6sGrFB150gwm
	tCvlK1n+pxNtXDorBMpvKLfjrBhEezW6PmEFwqALKAaE1U+MI5WqmGVNFHpGAtYMDbGLK5/dA/q
	OwaNKYrgPow/S9dZm9itnepFyffa3EaSGcIof/+e5HTyHaxVGOG355pw1tPC/j0L1hv0/BvsYvg
	3JfrbBx9umo9rLsO/Glvj8hAg+kcJ7xoB8DWzamwOdnk0cjJug1hhLx1dBzgniduJ2QlqE7ObYv
	vcFg6v8YbppbXguFZ4cfqH+A/qL5+y5y5y4LRuLPI=
X-Received: by 2002:a17:90b:53cf:b0:37f:b0a9:1a68 with SMTP id 98e67ed59e1d1-3903c54b340mr4504709a91.7.1785909919628;
        Tue, 04 Aug 2026 23:05:19 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-390392554dbsm535371a91.4.2026.08.04.23.05.19
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2026 23:05:19 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c083f1818so6455161cf.0
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 23:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785909918; x=1786514718; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ixvJyzHf6CwQR78Vnc98OrtjL5Qm3qHKniNH1npgOPE=;
        b=f+ow04ohqJqfSxh3Rfm1dIJfTvahqicxT1Yjyj5VvMwcw1cO4JAYH80Q4AH8TekJY4
         sU4VAqpVIiE9hJAneuomLOq4RtnCsOGWR/2GUXhuCPZpZ0sk3yAF3B87ONGnDYTuueMh
         Kne1tBHUVhW+nzHCMD/ztWxMnSsgR/S2dZLak=
X-Forwarded-Encrypted: i=1; AHgh+RpPWmU3yzA7Cmr9LNw5xc691vSCTO0gPPihraY/7RLOClxo+SIlPNFtgoXEFaV8GxPvJhfl/A4=@vger.kernel.org
X-Received: by 2002:a05:622a:a06:b0:51c:844f:28da with SMTP id d75a77b69052e-52ce5f8fa54mr48932041cf.5.1785909918286;
        Tue, 04 Aug 2026 23:05:18 -0700 (PDT)
X-Received: by 2002:a05:622a:a06:b0:51c:844f:28da with SMTP id d75a77b69052e-52ce5f8fa54mr48931731cf.5.1785909917851;
        Tue, 04 Aug 2026 23:05:17 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52ce8975b3dsm12228941cf.30.2026.08.04.23.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2026 23:05:17 -0700 (PDT)
Message-ID: <367ced51-be75-4e21-8e8f-6ed31331a0d2@broadcom.com>
Date: Wed, 5 Aug 2026 08:05:14 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] wifi: brcmfmac: cyw: pass PMKID to firmware if present
To: Bogdan Nicolae <bogdan.nicolae@gmail.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260804060859.412348-1-bogdan.nicolae@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <20260804060859.412348-1-bogdan.nicolae@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 04/08/2026 08:08, Bogdan Nicolae wrote:
> Zero out auth_status on initialization. Otherwise, garbage will
> leak from the stack to the firmware (when ssid is less than 32 bytes
> and/or when params->pmkid is set). Then, pass the params->pmkid to the
> firmware (without it, the firmware caches a garbage PMKID on successful
> authentication and denies a subsequent association request that includes
> the PMKID).
> 
> Fixes: 66f909308a7c ("wifi: brcmfmac: cyw: support external SAE authentication in station mode")
> Signed-off-by: Bogdan Nicolae <bogdan.nicolae@gmail.com>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

The checkpatch results on patchwork still show one failure [1].

Regards,
Arend

[1] 
https://netdev-ctrl.bots.linux.dev/logview.html?f=/logs/build-wireless/1139831/14729070/checkpatch/stdout

> ---
> v4: Fixed indentation
> v3: Added Fixes, Cc: stable, and Acked-by tags
> v2: Split into a separate patch
> 
>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> index 873754be5..2c59b5e57 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
> @@ -200,7 +200,7 @@ brcmf_cyw_external_auth(struct wiphy *wiphy, struct net_device *dev,
>   {
>   	struct brcmf_if *ifp;
>   	struct brcmf_pub *drvr;
> -	struct brcmf_auth_req_status_le auth_status;
> +	struct brcmf_auth_req_status_le auth_status = {};
>   	int ret = 0;
>   
>   	brcmf_dbg(TRACE, "Enter\n");
> @@ -208,6 +208,8 @@ brcmf_cyw_external_auth(struct wiphy *wiphy, struct net_device *dev,
>   	ifp = netdev_priv(dev);
>   	drvr = ifp->drvr;
>   	if (params->status == WLAN_STATUS_SUCCESS) {
> +		if (params->pmkid)
> +			memcpy(auth_status.pmkid, params->pmkid, WLAN_PMKID_LEN);

The line above exceeds the 80 column limit.

>   		auth_status.flags = cpu_to_le16(BRCMF_EXTAUTH_SUCCESS);
>   	} else {
>   		bphy_err(drvr, "External authentication failed: status=%d\n",

