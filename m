Received: from mail-qk1-f227.google.com (mail-qk1-f227.google.com [209.85.222.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420C42DCF55
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 06:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786085233; cv=none; b=BZ7SDuOG96aosX7Gv7PNPWGxbNrW6UPjP/4mWlQKMHspwjY6DqrHSeh6vL5dNE2WImcsb1qC7J2dcEhghut7YZm8h9DQcMgNCF8lHEbPFOIXw2O5BK1jXjGHrzXXa+nqBdPv/xCL7ivf/57bwZoJ5p5fliF/GwZH76kGjCck2tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786085233; c=relaxed/simple;
	bh=9Y5CiBh9ejoquK6ooJ8B7lLV6zQMZFZZqfxbS+uFVnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPKmDAvG0esgQcM7adKapT84y87pglz4wX+2OJAuYqwS4zGfPz8YqkwrIqclfP/QTa3YrBEigdu+l6NQbHzL/ZxQLu85sWFVOtHWMyuu83OyyXpyQUbc2PGQ2YuP0YZp47GhL+2U8ingunJG14Kr/5pL7aas7Eo8/g3SPFrcNC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=OSGRgEgJ; arc=none smtp.client-ip=209.85.222.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OSGRgEgJ"
Received: by mail-qk1-f227.google.com with SMTP id af79cd13be357-92e53581361so168215485a.1
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 23:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786085231; x=1786690031;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=k1nQYGrcGXQu2s20fusPuZGr3riqxpJDJFHLZrZqcfQ=;
        b=JqYGDc8ikZmbpp9Owzj3rM+e+h0b5l2y8UkJqm3sznaWR37IoszpN0Fq421Xrdv/pf
         /1P2SwZy+KR+1HxJ4DPaQjjG6ppVOmya+d0x3OJCTUifZWXRTr9VNwxVWf4qBIL8ckM2
         z5VQT+HFqUMQseKtP+yQU8a3dxiDb9Edz5UhWv/kHx9kMTWGGDGO0KXyQLqiqLJhPTO0
         Aw3/d9Csz/wNUqmLkKUT+imgSQJXmWhKac0zZMHzkyuVh/nOVWxWmdwATQShqaJUm9r3
         lmxmbnAGWuJsUarFej9tYoLM9uJ/oO/G+/wafty97QKUfAlE06DMq0aAhE8yoTMEL06m
         JUrg==
X-Forwarded-Encrypted: i=1; AHgh+RqsGPCNa4xzLGfuFqb3Ne5JPrgu+rDsVSWXnPghNTQr4RTj2mMb3h9i1/Q627y1u7Bx2Ytxk7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/BsFzk3aEAB8ZJpjgg3T8T8eQCgQxe7pRxErobyB19bxXFpSY
	reiaS3qLYtBgeWXU7HM8uvBqBKaYoVdbVG2wtoixOg8sLjZJXsdx2cloRFJVMmk0IwKSLMzuroz
	iQsP373yL6guqmxhI62C5WjEIT+qEwWSQ11Tv+j569gd1N8s+XOuktqYg684TJESc/V9mqFBZFF
	/VNB82XS+7QzYugmLQ+4xaU4IFsgAUQe8HiEIgWHcd0kE6uX8dZYUj584THzXJ7MQa194nGdUr8
	kosgeS5wECX2bINIw==
X-Gm-Gg: AR+sD10UI4rsmCw3di1fK7jQ+nCXiOz4AvP/CM/w7Jw0xG+NEy6kAIMDqHyfkfRfLqQ
	k438QrSfbn2EzPgyqn5San0+bHXE2bMU1QTdw9KuC5VuEWIvSQywyMNUN8SRO4sHvInRxIkOyQ6
	VLdRk7s1i3F4vkBOkpgFqwO+yaG3ZZYtt14xBMo9nFZUGyp63VQNCAc1WawrmmVGmHMGTSw8ASS
	cT3tuBbdyrmJ/2Sey4nCo97i23LQlLZvnHJbchmqsW+dyJ387ujMfKf50mtg+yPENA1WErbxr1t
	2kRj0HA9bAm7pFlYrMQTT/aFDd+OYU2gMNU9/1xIAHD5gU5vK7Ie13JfthjSktbzzIs37wLirzd
	fG5FZ9WonnlXYA9kw7GIUTHTdnkg97T+ZD9EC7RuOkyeUYkOI7E4O1vtY7AkynCCJniIq1f/YUI
	MspzV+8QGqmf3eDL8VagzLCD2h8lkuQ0qeigUF
X-Received: by 2002:a05:620a:401:b0:931:18e:8642 with SMTP id af79cd13be357-93648fb0d54mr1732362885a.2.1786085231014;
        Thu, 06 Aug 2026 23:47:11 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-9366e29b5c4sm20812685a.7.2026.08.06.23.47.10
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Aug 2026 23:47:11 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15fed5653eso217787866b.2
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 23:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786085229; x=1786690029; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k1nQYGrcGXQu2s20fusPuZGr3riqxpJDJFHLZrZqcfQ=;
        b=OSGRgEgJwqSgiQblt/NcN7rKn4qeZT9WtX+Wg38hvKmacB1rXOOMuCoANbZiopnDZQ
         c2fayuK16Im54CKPPylk4EHNky29JmYhUmYZ5u3JGkZ/J2wOTF1NuUSNSgmr6ogxyY8L
         MsJIWQobjGml4JdDAYOWsZNmn/FmG2xT6mYds=
X-Forwarded-Encrypted: i=1; AHgh+Rowego+KDDv5L4C9x5ANC1uylIBWF49XC3rhhdmzkZF1EVQhBE2IerFd9M98vu2bhedtFuol8Y=@vger.kernel.org
X-Received: by 2002:a17:906:ef01:b0:c20:2b23:71cc with SMTP id a640c23a62f3a-c20731e1113mr305066266b.10.1786085228850;
        Thu, 06 Aug 2026 23:47:08 -0700 (PDT)
X-Received: by 2002:a17:906:ef01:b0:c20:2b23:71cc with SMTP id a640c23a62f3a-c20731e1113mr305058566b.10.1786085226844;
        Thu, 06 Aug 2026 23:47:06 -0700 (PDT)
Received: from [192.168.178.26] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080a29a4csm15686666b.1.2026.08.06.23.47.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 23:47:06 -0700 (PDT)
Message-ID: <ca791519-5967-4d30-919b-146158432990@broadcom.com>
Date: Fri, 7 Aug 2026 08:47:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] wifi: brcmfmac: cyw: pass PMKID to firmware if present
To: Bogdan Nicolae <bogdan.nicolae@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260807032209.447044-1-bogdan.nicolae@gmail.com>
Content-Language: en-US
From: Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <20260807032209.447044-1-bogdan.nicolae@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 07/08/2026 05:22, Bogdan Nicolae wrote:
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

It looks good, but in patchwork it showed the patch could not be applied 
so I tried myself:

$ patch -p1 < 
~/Downloads/v5-wifi-brcmfmac-cyw-pass-PMKID-to-firmware-if-present.diff
patching file drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c
/usr/bin/patch: **** malformed patch at line 23:  		bphy_err(drvr, 
"External authentication failed: status=%d\n",

Been staring at it and not seeing the problem. Also checkpatch is not 
complaining. Look at the hexdump and the last line was missing a space 
before the tabs, but that was not the issue. The plot thickens...
> ---
> v5: Fixed line length > 80 chars
> v4: Fixed indentation
> v3: Added Fixes, Cc: stable, and Acked-by tags

Contrary to this there is no CC: stable tag in this patch.

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

It looks like you hand edited the patch but now the number of line is 9 
and not 8. Not sure if Johannes wants to hand edit that, but it does 
apply once fixed.

Let's wait for Johannes to reply.

Regards,
Arend

>   	ifp = netdev_priv(dev);
>   	drvr = ifp->drvr;
>   	if (params->status == WLAN_STATUS_SUCCESS) {
> +		if (params->pmkid)
> +			memcpy(auth_status.pmkid, params->pmkid,
> +			       WLAN_PMKID_LEN);
>   		auth_status.flags = cpu_to_le16(BRCMF_EXTAUTH_SUCCESS);
>   	} else {
>   		bphy_err(drvr, "External authentication failed: status=%d\n",
> --
> 2.55.0

