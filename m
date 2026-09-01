Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8325267B89
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264612; cv=none; b=I4ZKZIg553PXrqKBYt9e0OaORg9pcnTYwM8GUOyyf0cqgDlO6bOzPN0vxoZStuwaBS90pwRFdDijZvSd0sIe9b0N0HzT75DniIl6rLQNejZqrL0D6gFM+KGSCXdCqXFXur+j+EMhYBkurN7Yg3tyMrbDpFJjOPMwls3BHblYaD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264612; c=relaxed/simple;
	bh=pUAQhpIylhH03veS5v2pJ5187OFtExWloOWxSlrMTWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Y6YbfXHyze760ul+NtkkLzCD9OOOHKavcxI+o2bXhmJqtGSquyUa+Vpibbk/P8tREeyG3dMR9qm6UuSI55XNQemGoF8v92d7ahVCXh8OgHWaxwsM/ANgIYZzer/OeCx4df1TzGLGorhNiUSg5jqsXk+1pdDt2JtjXRCkorOacgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J4LBT0R8; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MlypWCcK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J4LBT0R8";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MlypWCcK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788264609;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8fwOGFXieQl813ckc/IUkjGRGe4UDJCJhqZtMy1/kp8=;
	b=J4LBT0R8cVl1pqQW2IyBNPf6xqIE6OSwmWxbTEaJDxgk2gj+M785RbygHmMHh0P1f5kGpQ
	GYnFVXlSuMXUkBkJxFSMYYoWAXeo0MQdGSggvXLVbKg+LyYxbs19vhE/0JHqUDJMfzIG5p
	ao9Zy5Xy73ViJToH4Mx70iwAUJE+mB4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-wtXo7387Ofyd9mKLgpm2AQ-1; Tue, 01 Sept 2026 08:10:08 -0400
X-MC-Unique: wtXo7387Ofyd9mKLgpm2AQ-1
X-Mimecast-MFC-AGG-ID: wtXo7387Ofyd9mKLgpm2AQ_1788264607
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f6db77430so2515122f8f.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 05:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1788264607; x=1788869407; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8fwOGFXieQl813ckc/IUkjGRGe4UDJCJhqZtMy1/kp8=;
        b=MlypWCcKSfGjZY9Eqt5KulJUqs2foa19Ey6tTuqKHzbs+XTIrn6Kff89D6VhhxGpwx
         Pk+QaqxVW2hC/fK5ecRMrEC21EERvDF4Ah8c6IElLrmyTz0lYXuNYIkze1t+xHojUZ1q
         UtgcDDEMTtEmutpZKssgUNSjrDU6dG42m/2PnUaJEMCXDo444Z0+SwccPKAFdp80Lu9G
         +hnraQ4ZPgwgBep6EPjPnoxYv5gg5THpqr6GO1FXat17cBgpfCub+dF4Fj78sfeZvRl3
         BFLNhNO7qPAPnAACXnfrZ6iO79oKZsBHFt3EP1d1XX1btxpP5qVQ9D+a7XmqlzxAmGNI
         OnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264607; x=1788869407;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8fwOGFXieQl813ckc/IUkjGRGe4UDJCJhqZtMy1/kp8=;
        b=nOjUaBgYFXYJ6QxgQwJMEUtW6VvC2lXPnSL32kJwvnV7g8HJqu6hmTCGDgmXlBb2vs
         APHrUMEr7sKmIHzilAi6SezXKLe9x7cLAExW7oM8rpdU5IeQxTFx05XUehkFfAfL7Rz3
         CHB75Do297KXsHb15yDM59QcXZnVXf57NqrEKtiUeVBAHNAUqOiP6sAE6EpeSzfCrvJQ
         SjIYmzhG89u6bwR6AFh6xgacouGP6SF+8f7AKgw5di0ePEdXW9NnEX7op8waOQfsN8wA
         dmVjm1fCMpI4Mq0Gi2MygBUSKci8tqW273az1FIaXj3ne8r4YMFAo+5+DsvgpaB1lRZc
         XzEg==
X-Forwarded-Encrypted: i=1; AKwUvBz5KZuq0rYFpiSWuLhCLk3AESZKftFvtjrZzRSCc2rPV1NRZHruFNsOoePiKzbEJ3HIt4yro64=@vger.kernel.org
X-Gm-Message-State: AFuF++kh+19YnREUcH25OC0ro6nZhKuouMBu6nGqZTznsZRnbOi8T3e5
	s4cxkmkIxrvrfZfiEgqkPTLhYJXmQlIGRV9qqx5Zu5F1gz5RZhx0gm73sMwQvbghzb4UQ09qKbA
	kvNh4fMzRNcbwNQW0gLXH1flG7CBb7K73Fu8AkDIXxrCOm4xeajnnBouiYg==
X-Gm-Gg: AYBFou2m7ZMD4PUN71NfHrRAY4/0izolK4AN6NLVcWnglJKF9v6101H7lueycBVdTv9
	y0VFw5KMW3dUMuA4Z6katNX8fSjjo5D8z5xmfYMaE7JGXOQwSjwHsMWYOKUJ2QWtgPx5YI9PGSI
	cWrclp6InBrbG7Ec6o1/ZEMx3YnhJZaEqMGvFCGo9mQL5ZpUI3fF1/DaWi21ZH6ncQ4riu4RxaR
	3/rRMG2yA1zTcLLmoSv4udVeN+b4hPILiTrln3OBVlwe4PVKPlVqB18qm/u26OGxg2gKkFo47Vs
	xrS19KBP6GGaNY1fGCeAS8bTXOYAlLJ/kFgzheqwzM4P9bsQT7H3H7BfO3iNUmkHAj/XQed9mJL
	EjSkfkGJrh0ShJuVQr9MpLp482wd/7v4087GSEp4P4VSZbUxafIhp+GEq14EmJMP16PeALwntHg
	==
X-Received: by 2002:a05:6000:1ac5:b0:484:3785:210e with SMTP id ffacd0b85a97d-4844103cd55mr13007017f8f.25.1788264607320;
        Tue, 01 Sep 2026 05:10:07 -0700 (PDT)
X-Received: by 2002:a05:6000:1ac5:b0:484:3785:210e with SMTP id ffacd0b85a97d-4844103cd55mr13006886f8f.25.1788264606789;
        Tue, 01 Sep 2026 05:10:06 -0700 (PDT)
Received: from [192.168.188.218] (ip245-45-231-195.pool-bba.aruba.it. [195.231.45.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48442d36e9csm4881021f8f.3.2026.09.01.05.10.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2026 05:10:05 -0700 (PDT)
Message-ID: <b8b6db7b-353d-4d6a-b0b6-3b5e1be22008@redhat.com>
Date: Tue, 1 Sep 2026 14:10:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v4] bnxt_en: Bound SW TPA IDs to prevent crashes
To: Joe Damato <joe@dama.to>, netdev@vger.kernel.org,
 Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
 Rukhsana Ansari <rukhsana.ansari@broadcom.com>, horms@kernel.org,
 colin.winegarden@broadcom.com, linux-kernel@vger.kernel.org,
 raphaelcf@meta.com, stable@vger.kernel.org, llvm@lists.linux.dev
References: <20260828190900.1767611-1-joe@dama.to>
 <1c87458d-7d76-4da4-9981-51756cef391b@redhat.com>
 <apa9qofhuatqGTra@devvm20253.cco0.facebook.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <apa9qofhuatqGTra@devvm20253.cco0.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/1/26 1:57 PM, Joe Damato wrote:
> On Tue, Sep 01, 2026 at 10:16:54AM +0200, Paolo Abeni wrote:
>> On 8/28/26 9:08 PM, Joe Damato wrote:
>>>   - Moved bp->max_tpa_roundup_size init out of the early return path and
>>>     documented that TPA is unsupported there, as suggested by Michael.
>>
>> Clashiko quite convincingly elaborates that the above is not enough:
>>
>> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828190900.1767611-1-joe%40dama.to
>>
>> Could you please have a look?
[...]
> 3.) "The new assignment sits after the max_tpa_v2 == 0 early return, so on a P5+
> device whose firmware reports max_aggs_supported == 0, does
> bp->max_tpa_roundup_size stay 0 while BNXT_FLAG_TPA is set? ..."
> 
> Michael commented in the v3 that this is a false positive, hence why I changed
> the code from what it was in the v3 to this.

This is the comment I referred to.

AFAICS the problem is that the driver sets

	bp->dev->hw_features |= NETIF_F_LRO;

regardless of the supported capabilities, and that seams to disagree
with Michael.

/P

