Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28BB49AA34
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055512; cv=none; b=JiW1zcZDM0UP9KaYgm9VE4KYENEdWyufh/o/c8/mrPasR/o5wKOutenhPVc7DfRUpu8mLUuhSXj2OpqDr283PNO+R3W8vRul9kQMcyDW6jVzwY9vQ0NFElw8F7FV+l6BGENvzZQIAqtm13gEGSEnvoLMc9aDaBrLkqrY7py5k4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055512; c=relaxed/simple;
	bh=b5Ymm/ECofLnPQCTo+E/rmIx2nAMwNPMuKuCAVOQii0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPSyyTkfrk3KPTlzp4554c2vFahXNh6s+cxA8ZExvIPaRk2YyxBsi5BIgrqxAJf10pWHMpeen+Ww6vSrE/uFgpR4dCySxY5kY8dqHLDY8+wphyjj5kCsMyGbHyU8wgsYy5s3z+fcVL44XIGCaPUJ8sTiOFC5ybZ8a2x/Xql7ZnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=bOcroJMA; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="bOcroJMA"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8623b1e7cb2so55750447b3.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 08:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1789055509; x=1789660309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v/Ll3fwIdpv7mlEfFgIe9/htJBU9V9jdUb8GRoDGxak=;
        b=bOcroJMA8usKHkKesnAK6pqNhbEctAJxi2E4k548bbKaAQuHlzPZ77F2vSg2q3Fsjw
         3Nafd3Gyb2HBNdWMG/0sGe412/UWgkHNnfo7hpIj3ATL77cZj+KndUCWoaoWd9jRo+rb
         s/8Ee/ejR51KIkBRTFViNvKE6cqvm7Bf+AZ9rgDoEO3n9xlaUhZgRshRM/6KjzI1f2Ba
         iSMCtJ28nB5yymPIeYH8+ucFzd5ylzRNkMxhEj6E4DT0N514kHzkFqPJoL5gIvYZvP7N
         0NxoQU/oRa6kwpaE95jj8tbzBfk5hHpcvBNZ8OFwxsjnQGp/WBmaRi8LNdl/S1/7BRIr
         SUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789055509; x=1789660309;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v/Ll3fwIdpv7mlEfFgIe9/htJBU9V9jdUb8GRoDGxak=;
        b=jkBC1hVsm64msLRbNIoQw2FRc13Z7OlSyfFz12kZo0Z+R3/nQ3PECRo1QCD/tV38ai
         181SF7l3jkKl+DLbN+1qKe5/c/il67F9rxqDGQj++L8kCHcTpOGylhbjLzvI+MEcQlty
         vKjMTAdEhgUyQHVqFk53bnodYNsVBBXSNhFSdpMiMkycN+FOzDWxOm48SG4SgmPd5lYF
         TyI1+LZ0xiiKwK/L7Jbjfi++xGU6Z23hDOmHzeQW7Sn4aCMWGsw4puzmuStzcq8ZRcbw
         yX+DWXIeUSx7WSVX9QIkW8+zkRAMjPT+TJMUrCsfk8Wjmi7/mmU2BVaQWawbBj57Ao37
         XAgg==
X-Forwarded-Encrypted: i=1; AKwUvBwn5k2sgw8XCbNLKCbeYs2q0TGmh+nLDjO1Uv025wy0oX+xgJlLoGQggBKDfmzXeeRokuW5gbM=@vger.kernel.org
X-Gm-Message-State: AFuF++lZoaH/l2iJrKqo3/CvcjhoU/h4IPGDnOFYCMaa3DrdB6bGB2lf
	98FUu/KCbmQA9mUiTzJYSNFFYorMiBrVTU5hGdNep0SWWMeQ4SxJgjwUSCwQtzynaw==
X-Gm-Gg: AYBFou3aNnfqXu4HltyWibBhqX8sGcg5oNGfuugyBF61eHhuSabSKttGBWoKoKGZUKU
	ogmYkOp++L3ConxKL4s/GotmoaWFcggrpEzvMGda7bXpKQO6NXOuin4sdxxOhHWIy1XO4p52AA4
	v0ka8fPQ3DO63k+kZbpt7eKdoP30KQq3nJTC/HLHHU+XT9EM3WtLx6JOSQWBi9ccQgRsCCg21jR
	QnqsR9O1kb/wQWcXT1zQIywW2CRRTpVsrcvd5v9rYzXxLvIDS9s13JZbHkaBxJa9OwyuFc4TPKu
	O2j4orG5T49JMWrZEks083Z7N0I7FbVhU42PggWe8ZEblWLkAQE27HYD1g0+k6nGZa06ARDVB9L
	WWbfBzgWNT6/BFTw008/fhy7j30hw31UyY3p48stEnGbd7xX9jl8Z9Nl4R8w4DuuMnv8PF+pqKx
	LddQY5woBPvnVTPLKd0LRnZT7mx6csoUTigXy3stDppp6O6SsZW7L1iPrXLwpmVarehqRanS91
X-Received: by 2002:a05:690c:298:b0:87f:dd04:b453 with SMTP id 00721157ae682-87fdd04b821mr48840217b3.68.1789055509477;
        Thu, 10 Sep 2026 08:51:49 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210::7544])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e7f184d9sm13144085a.12.2026.09.10.08.51.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 08:51:48 -0700 (PDT)
Date: Thu, 10 Sep 2026 11:51:46 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Syed Labeeq Sajid Bukhari <syedlabeeq@gmail.com>
Cc: linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: Re: [usb-storage] [PATCH v2] usb: storage: sierra_ms: reject short
 SWoC info transfers
Message-ID: <38e316b8-2305-4156-b4ce-185364c377f2@rowland.harvard.edu>
References: <20260910140343.49371-1-syedlabeeq@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910140343.49371-1-syedlabeeq@gmail.com>

On Thu, Sep 10, 2026 at 07:03:43PM +0500, Syed Labeeq Sajid Bukhari wrote:
> sierra_get_swoc_info() requests sizeof(struct swoc_info) (60) bytes
> from the device via usb_control_msg(), but its callers only treat a
> negative return value as failure. A device that answers the
> vendor-specific GetSwocInfo request with a short IN transfer is
> therefore accepted, leaving the tail of the freshly allocated
> (kmalloc(), non-zeroing) swoc_info buffer uninitialized.
> 
> truinst_show() subsequently prints swocInfo->rev, swocInfo->LinuxSKU
> and swocInfo->LinuxVer from that buffer into the world-readable
> (0444) "truinst" sysfs attribute. An emulated/malicious USB device
> (VID 0x1199, PID 0x0fff) can exploit this to disclose up to 5 bytes
> of stale kernel heap memory (kmalloc-64) to unprivileged userspace,
> once per sysfs read, indefinitely. On kernels built without
> init_on_alloc this leaks recently freed heap contents.
> 
> Only accept the transfer when the full structure was received.
> sierra_ms_init() already retries failed queries, so well-behaved
> devices are unaffected.
> 
> Fixes: 32fe5e393455 ("USB Storage Sierra: TRU-Install feature update")
> Cc: stable@vger.kernel.org
> Signed-off-by: Syed Labeeq Sajid Bukhari <syedlabeeq@gmail.com>
> Assisted-by: Kimi:K2 [Kimi Code CLI]
> ---
> v2: add blank line before the comment block; add Assisted-by tag.
>     No functional change.
>  drivers/usb/storage/sierra_ms.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Acked-by: Alan Stern <stern@rowland.harvard.edu>

> diff --git a/drivers/usb/storage/sierra_ms.c b/drivers/usb/storage/sierra_ms.c
> index 177fa6cd143ab2837640c26f8336781ddd3cf9cb..d8fe9561b2b5f4cce6aa8702309cfc195bc3c891 100644
> --- a/drivers/usb/storage/sierra_ms.c
> +++ b/drivers/usb/storage/sierra_ms.c
> @@ -77,6 +77,13 @@
>  			sizeof(struct swoc_info),	/* __u16 size 	     */
>  			USB_CTRL_SET_TIMEOUT);		/* int timeout 	     */
>  
> +	/*
> +	 * A short IN transfer leaves the tail of swocInfo uninitialized;
> +	 * only a full transfer is valid.
> +	 */
> +	if (result != sizeof(struct swoc_info))
> +		return -EIO;
> +
>  	swocInfo->LinuxSKU = le16_to_cpu(swocInfo->LinuxSKU);
>  	swocInfo->LinuxVer = le16_to_cpu(swocInfo->LinuxVer);
>  	return result;
> -- 
> 2.43.0
> 
> -- 
> You received this message because you are subscribed to the Google Groups "USB Mass Storage on Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to usb-storage+unsubscribe@lists.one-eyed-alien.net.
> To view this discussion visit https://groups.google.com/a/lists.one-eyed-alien.net/d/msgid/usb-storage/20260910140343.49371-1-syedlabeeq%40gmail.com.
