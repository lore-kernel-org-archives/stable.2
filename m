Received: from mail-pf1-f227.google.com (mail-pf1-f227.google.com [209.85.210.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B77A3AC0C1
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 17:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790704088; cv=none; b=RE4A/2gNmLkYRrSQ6vTn1NjU4g+eOZYQ19AMrZaGKhCAQfS4SzGiORYIFTtz7J9RGBN4CA6zcSvbl1dAdLGivehoESPexjt01aPZzwHq7+UzQRvtws/ytUlRHsg3WHOlIR5W1MUTVtahsrG0HP7ivlSN8pmPBF85DdSs6CVUzWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790704088; c=relaxed/simple;
	bh=cJpmwEiuNdtdqwEFSa2ysDoeGDJ2N9SxsOcBpZJ0PNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h/IyJYhFVFB0maaK6pVkit1pJetXAuPAYyGzsSesU4yp+XEbSW5Kqffu2B1CL6BtN523/LjDmvSRG1fhNPHCp0RkJOAw6+U626l+iqYGmT91T9wj8uy9PAxrUTEi+/xtYa6prUFuDRFW+/usave4d4xadmMl8xraUh9KowEDyyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=U4bWRal1; arc=none smtp.client-ip=209.85.210.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="U4bWRal1"
Received: by mail-pf1-f227.google.com with SMTP id d2e1a72fcca58-868b3248b2cso1209972b3a.1
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 10:48:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790704086; x=1791308886;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=e7MyTOOeEo7WzEXet1cmfM85sICUvnUIP5uaOgZRIgc=;
        b=bSreEzk9gRBLVMNPOeQQy1mKf88ntoh6v8QuA5VXydIhX6gowsDXM6kbs9Xj65Hot1
         IISQXaFi5mN7rl7zznl/2PU7P7edC3CWb9kfwapINT3tQXqPaLuAo+wZxXpw7/c1AROM
         PtbWw+yTcihd/D3eueVOObin220qgSCLBBvqxdf4bQVS2PQG2CZZm6xPtr5uRtN5xCfk
         wlHt1WIy/G0gHeCqpt6AVQCupVNDoW1qOPjvM6lV9Xe4Tf3pVc4CCQDxMbIwpQFTAX1F
         kEpZnza413OdXLtI5AtZfoVOULTcMDVypwIxSjolMOG9B3vlTHfooK99qvkx/ZV7Vm5F
         CR+w==
X-Forwarded-Encrypted: i=1; AKwUvBx6tAnXeffcpm9szMDbgbbxk8xC8GP1h/1Z6qlOG0ZsT8qgciwF7t3dDz1DiqANPkhrUoiHfV0=@vger.kernel.org
X-Gm-Message-State: AFuF++l9uYHr6pzE7/cx0TJohi7FMv8xuE3DUvq+qbRmBBkfpNf5hFsF
	NdJ2nM1nMHE6Src4f8FR9TaipBugm24mOyhop4UWn5cTNsO6wLGm59vbNwMRTQCLyz19ra2pcUb
	jrPNcX0dk8v5TvrufiPoEyG9rpfZTJFzP2NwkTPc7cqhXspWeXzv/j+BjlST3+4VvE18McXu2/k
	wKPeZDNsMIFGcOCbQzcK3kjiqz5JKhKDz988o4B2n73rLKQnqESEdyXUcBaj/bkfuue185bw/h4
	g66csaf0Q==
X-Gm-Gg: AYBFou0jNXppLuJMgJ00s/1Bo5jfXz3DJHPLA9KWD6kdqnaDQZa/m21nEWuh7xyT0b5
	lRAE79RQmbPRi+B6NAcV5qzkwTXfkRnOegPo0GWjL3ab+w0F3pcr4t3Pqx9rna3Da/D8Y9iS29r
	J++yU+wb5CG5Tonu1h8+NT1OzIWT79r0opbVHPmxyFIJ/o54DG8WO6aEBlCFW0Q6OUQ90Oh8Pci
	64al0gCcBiePbtcU1Z2dsAucAy3GZGYD0GX1p17zBTMxQ6WWeLosJchaMdUL1VYsC+E9mTrqxG9
	5bcNUd4CmvVK7Ici2n8jByyd4QvxKX9Oa6Cid5KBOV71W9lhQoSzXFaERZ98Z+289yHlrUjcujN
	ZgAdrbCtHeQqFcDYc/Y5hieaIFQtgOSsOyfKDl8lQWQH1TRlrqxZL6rhBKJFFjhQYaoNA4hOu7z
	mEM3nok9aGboIBj+RlRTiZ66SiKTQ0f5B7hs6Q
X-Received: by 2002:a05:6a00:1948:b0:878:37b2:df9d with SMTP id d2e1a72fcca58-87e9ca1e71amr13715768b3a.55.1790704085736;
        Tue, 29 Sep 2026 10:48:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-8868ad2be82sm201438b3a.5.2026.09.29.10.48.05
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Sep 2026 10:48:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39deda201bcso7300989a91.2
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 10:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790704084; x=1791308884; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e7MyTOOeEo7WzEXet1cmfM85sICUvnUIP5uaOgZRIgc=;
        b=U4bWRal1SZ7Hl6BG+s/i5AO3szN3ZCoOYl1RbpXW6RHffQN3O6R0Qubf6lE6LGeVDL
         cQQ+oIi/B8EO/XLwLN3yN2j+LthVII2C/FHyWMmPdo0zxAq6y17/G0NPdqFnVhhNjJiH
         9FILZiTtUvF1KctF3yRv3CnyGfvy7Wf8NHYiE=
X-Forwarded-Encrypted: i=1; AKwUvBzFNNIfYJrdop3x83drlWlUL6A05xlmkff0+zmKOEPSpKjrQFlyOjJtTgsSr8PhbnyJ5igG9B0=@vger.kernel.org
X-Received: by 2002:a17:90a:e7ca:b0:39e:24ab:9f82 with SMTP id 98e67ed59e1d1-3a4bfdbabc6mr122715a91.10.1790704083977;
        Tue, 29 Sep 2026 10:48:03 -0700 (PDT)
X-Received: by 2002:a17:90a:e7ca:b0:39e:24ab:9f82 with SMTP id 98e67ed59e1d1-3a4bfdbabc6mr122698a91.10.1790704083573;
        Tue, 29 Sep 2026 10:48:03 -0700 (PDT)
Received: from [10.14.4.125] ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a49858bf27sm6624088a91.4.2026.09.29.10.48.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Sep 2026 10:48:03 -0700 (PDT)
Message-ID: <0cfdc48c-e06d-4664-8791-98b29138584c@broadcom.com>
Date: Tue, 29 Sep 2026 10:48:02 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailbox: bcm74110: Cap rx_svc_init_list growth to prevent
 PMC-induced OOM
To: Danesh Petigara <danesh.petigara@broadcom.com>, jassisinghbrar@gmail.com
Cc: florian.fainelli@broadcom.com, james.quinlan@broadcom.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260825191619.2326087-1-danesh.petigara@broadcom.com>
Content-Language: en-US
From: Justin Chen <justin.chen@broadcom.com>
In-Reply-To: <20260825191619.2326087-1-danesh.petigara@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e



On 8/25/26 12:16 PM, Danesh Petigara wrote:
> From: Florian Fainelli <florian.fainelli@broadcom.com>
> 
> bcm74110_rx_push_init_msg() allocates a GFP_ATOMIC struct for every
> BCM_MSG_SVC_INIT word received from the PMC co-processor and appends it
> to rx_svc_init_list with no cap on list length.  The only consumers of
> this list (bcm74110_rx_pop_init_msg_block / bcm74110_rx_flush_msg) are
> called only during probe and at shutdown respectively; after probe
> completes, PMC firmware can continuously inject BCM_MSG_SVC_INIT words,
> exhausting GFP_ATOMIC reserves and causing a whole-device denial of
> service.
> 
> Add BCM74110_INIT_MSG_MAX (16 entries) as the maximum list depth.
> bcm74110_rx_push_init_msg() now checks the count under the existing
> rx_svc_list_lock before allocating; if the cap is reached the message is
> dropped and a rate-limited warning is emitted.  The new rx_svc_init_count
> field is decremented by bcm74110_rx_pop_init_msg() on successful dequeue
> and reset to zero by bcm74110_rx_flush_msg() on shutdown.
> 
> Fixes: 52436007b862 ("mailbox: Add support for bcm74110")
> Cc: stable@vger.kernel.org
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Assisted-by: Anthropic:claude-sonnet-4.6 cursor
> Signed-off-by: Danesh Petigara <danesh.petigara@broadcom.com>

Signed-off-by: Justin Chen <justin.chen@broadcom.com>

Gentle ping on this patch.

Thanks,
Justin
