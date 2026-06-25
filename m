Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C1E3CD8AC
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782381883; cv=none; b=WsXFqBl3jll7J2udUxL0W3LUGFNkyRRl8xrKbPFszk1YZWXmUn3Nfrd5RGjaCKrlgNywkYkcMSVCtEHAgROmw9X9LDzgbhCc4TSBI5yBqZIJvMmNA4bIBjFu0xgdgTjWdQrjIEdMaW/VOXSy42PLQq3kioM35gtZ6fiMu0tw7qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782381883; c=relaxed/simple;
	bh=QDzsnUqwF537r9M0E1hQPClNIzZvDM04Y5WP6j505Wg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GA451PGu20HHVEVzv9kmOdN/yqKjfS29LFyyRI8DWFSjCvWgAHMXzMa4hrjDk8B21G0DUfBNLhBKitYaCRmBzxNgeYf+CADglzprY1fJ3er3tduQbKIhzV/NG8fd3E6Rp3TKs/HqZw+EstcNBb8Qzw50+qpgNUve4Fet1pHGx3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io; spf=pass smtp.mailfrom=bynar.io; dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b=d1s+AjUE; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bynar.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bynar.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bynar.io header.i=@bynar.io header.b="d1s+AjUE"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c0e12cb1d90so315738666b.2
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 03:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bynar.io; s=google; t=1782381880; x=1782986680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJYAU8T0dbhlhhmhVee2XR5nvnk6dSr8CYdyAa40XFg=;
        b=d1s+AjUElnxOsvZM/lRCxbAL9Av+hMqibOb574krGZbEOEiQazCVqlJFvxqcp7XscD
         YDoyF2m4AkJI/ASx63vw2lQAyLSKXuDFAGSDaNhRbn4GjhC/k3urQYpEfhY+bUvi/Uuu
         sXdG997xSTxOK4E5wwks/nIMLovJXXG6Oh7Yt9ZU/nXnLbOsBzlnWAAuWomPtx1CF3Re
         zXPY0JslBzI2NPQjCfTqcWf+VfbSNdcLETSKeGRGpYi1c4dTQnNt8fNe2DRndspe0IRh
         9gCcW+hKU0igciSa5t+IIgL9M/x7fNd+VDru2c7XA3/MSGvCzKyKjP2iEJsVmmQ/OVGJ
         gE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782381880; x=1782986680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJYAU8T0dbhlhhmhVee2XR5nvnk6dSr8CYdyAa40XFg=;
        b=ZEs5dyj2NsuSQK03jKViUbMVzzrI6IOz5oe6ZH9TjGQPoD91m1SlDwLd/t7E0yvsKh
         8zbwT0kAmkWvtUlA/Q76a7zewBkmWylIMJnqy7gR1gDyuz1WS2t2NLS2xYSX0lbmfZ8Y
         LjkjKvmZEuFbf7rJAAj5GeU46JhiBxHmUqKuAA+DrIXYks1u0ZW5/nhmYQhejXDIBfyi
         +BZKQdtKCdX5rztxmAs5eiishsINOFmOejH/5wOFyeD9SwxiorMqEwbuWkrbCgwh5azg
         00tEVz4mGwGxTRgd4ATFI+AceU0hUJqZSuZOSxr95Cg8qgt6bymrJ9+aciVZgA5EaDkV
         K3Tg==
X-Forwarded-Encrypted: i=1; AHgh+Rqr7U9lPOxQDXYEQrdaPAXi1h5/iRdGAn7d0ILmAiGBw2OrGUAB9oG0oBVHDQC1ph85j8vetJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCZ4XVa8Od4DuC+8fOQEBvT1xryzjdz4OtPAI8pHVOg1PwR7IL
	KbbI56LGeVJnXgTmrpuefDgazAZgdLK3188OE53C/923Xvf6PK66vPH+dIFroyocxp/Z
X-Gm-Gg: AfdE7cnUWonEZ90Mzmy7Z9CE0b06RyqTrFjkbc8tNUNyDSB6xhbqa5a0n492b1Fej2T
	4iJbqIl1ml6J16ie9uc5BqUCIAWfBWs3Ks0FSzTdOPS6P+e7OpgDFsTsg+fAiPAuGDyxKC2I9Pg
	t2IDtvYq/PGkKF0RqMU8U4PpXyE9PhymuHy4WSgN8W8HQq8ItF5tdgRdRk9od6FTWAHJojFKCPM
	Eg6p59SZeH0TTmzZgp0aLzf8OitR1eHwl53Yy/QQe24hoE74hDrEGzHDNhAUZz5eAhAmyN0yTyD
	W2VfIqIhTprnzGRTWmksdV/NQT4gGXtjt3YMWKbQ7VhVsP9vhtx7b/C1v54lVon9pI2a7usuZzQ
	oEZPsF6XTJzozmdQz5XWlVqHgpvcB+wRldPRSxkx2KlZnyVv9Ibu5L06mZw6151T0TAzQZdtTS8
	N7/Z2ANJ4fM6mVluzHl5Sx/Yaortp3+cUhnXo/tMhUuntz3A==
X-Received: by 2002:a17:906:f5a2:b0:c0e:840a:79a3 with SMTP id a640c23a62f3a-c12061eb76dmr128400266b.52.1782381879743;
        Thu, 25 Jun 2026 03:04:39 -0700 (PDT)
Received: from ?IPV6:2a06:61c2:d427:0:b321:1c7a:b072:326e? ([2a06:61c2:d427:0:b321:1c7a:b072:326e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c11fbe05cb3sm150309966b.35.2026.06.25.03.04.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2026 03:04:39 -0700 (PDT)
Message-ID: <ea447873-9222-4b75-8090-68d08e53097a@bynar.io>
Date: Thu, 25 Jun 2026 11:04:38 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] nfc: nci: fix uninit-value in the RF
 discover/activated NTF handlers
To: Simon Horman <horms@kernel.org>
Cc: david@ixit.cz, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260623234126.214667-1-sam@bynar.io>
 <20260625091828.1170615-2-horms@kernel.org>
Content-Language: en-GB
From: Sam P <sam@bynar.io>
In-Reply-To: <20260625091828.1170615-2-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/06/2026 10:18, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> nfc: nci: fix uninit-value in the RF discover/activated NTF handlers
> 
> This zero-initialises the on-stack nci_rf_discover_ntf and
> nci_rf_intf_activated_ntf structs in the RF discover and interface
> activated NTF handlers so that the technology- and activation-specific
> unions read back as zero when the corresponding length fields are zero.
> 
> Link: https://lore.kernel.org/netdev/20260623172109.1105965-2-horms@kernel.org/
> 
>>   - activated: with rf_tech_specific_params_len == 0 the same union is read
>>     via nci_target_auto_activated(); with activation_params_len == 0 the
>>     activation_params union is read by nci_store_ats_nfc_iso_dep() into
>>     ndev->target_ats.
> 
> [Low]
> Does the third scenario in this paragraph match the code?
> 
> Looking at nci_store_ats_nfc_iso_dep():
> 
>      static int nci_store_ats_nfc_iso_dep(struct nci_dev *ndev,
>                           const struct nci_rf_intf_activated_ntf *ntf)
>      {
>          ndev->target_ats_len = 0;
> 
>          if (ntf->activation_params_len <= 0)
>              return NCI_STATUS_OK;
> 
>          if (ntf->activation_params.nfca_poll_iso_dep.rats_res_len > NFC_ATS_MAXSIZE) {
>          ...
> 
> The function returns NCI_STATUS_OK before any access to the
> activation_params union when activation_params_len is 0, so the union
> is not read in that case.
> 
> The sibling nci_store_general_bytes_nfc_dep() has the same early return
> on activation_params_len <= 0.
> 
> The two rf_tech_specific_params_len == 0 cases listed earlier in the
> commit message do match the code (nci_add_new_protocol() and
> nci_target_auto_activated() unconditionally pass
> &ntf.rf_tech_specific_params even when rf_tech_specific_params_len is
> 0), and the KMSAN trace quoted in the commit message only mentions the
> nci_add_new_protocol() path.
> 
> The ntf = {} change still looks correct and necessary for the
> rf_tech_specific_params union. Could the third bullet be dropped or
> adjusted so the commit message reflects only the paths that actually
> read uninitialised bytes?

Thanks for sharing the review.

This is valid feedback, I'll fix up the commit message in a v2.
