Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C3947887E
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 10:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790245453; cv=none; b=MJNHUexQQ3kGTYWgeW4xrzypYVVTdmPnh0kHRGfezz0zpFS7y5xAjxdJSdxq/xk9otLibj6pSE27pQ0uoRhlfcDpqSljgVtQZzecdJmk4uZoPlnkTWaI5O3B6ntEoSnjXmW+UsxnKwZZehTLrp5C13tCNqc2uQ+2W8fan0DVmn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790245453; c=relaxed/simple;
	bh=/I7sMKRC+Fm/RMOumClgldkrmS5D2N3LRxy0pszOg5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N6nnJMgl44x9D+gQpWEY1o19zd0cDnyFrhRnHPR2gTSKHB8xW+kaKRVLXJXNeS7TXwV0EEsEYIEfpeEQFWqFhuW8cWqX5E9JKvLbYU5TMMc9PBXvEuvsWWShXV6wiKhwPpCtn6SOsOIbHrkMCIN/RDIhznjTw0/U94Nb+S/278A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hXIReeRt; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jetjw+p0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hXIReeRt";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jetjw+p0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790245450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4gKaCmlo8zL0/IT3A5NQAgJVMGj3NM0BKVIjo7Jj9JQ=;
	b=hXIReeRtmdztWdNm93WBpP5nhcBdOLR+FevhnF/gt9JaH2QKBflgOorkLHSg5oSQ1eRH2U
	KcO7q4c/i2qArJFvv/dsCfDRV1p+0QjOQbNHgNDlC3EX5dYWmleUzYzzilXIGJXwRtG1WH
	Pzjjsc1MOBbWs1BERyy33e0hxNU4aPo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-I71GKDn2MACwaxQPIZ8ANQ-1; Thu, 24 Sep 2026 06:24:09 -0400
X-MC-Unique: I71GKDn2MACwaxQPIZ8ANQ-1
X-Mimecast-MFC-AGG-ID: I71GKDn2MACwaxQPIZ8ANQ_1790245448
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49cd83ca361so26392495e9.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 03:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790245448; x=1790850248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4gKaCmlo8zL0/IT3A5NQAgJVMGj3NM0BKVIjo7Jj9JQ=;
        b=Jetjw+p0l+j2Sxgn8CqbAnf8sEthYJm2QROIeqJNHCOqddxM4t2MUsTeAhf9Lu6Szp
         2PyQ3mMNvp1B1MyikvsoT2ICLqft92Tk1Ce/NVG0nAD1I6yvukwgvoHvoVm2VkuQAVM+
         sv9cOBYRBZkNtxz45f9KxA6V+2pkcU+4AeWGEBd71sKlpww5HdWzw8oRfrA9rrYeBTZ1
         hBzm3qiVZ8rqkUWJ/5zSq8yA8T7aAd7GZHVkBIj5CJKcNMxwR9IcGtqPFai1YQseoAB6
         agHZhGPWSpzndeQwdB6rbbhtGNMAX7SFjbp9pAYP0Aowd0la9jnm1AQ6Gxs32c1XnVIM
         1h5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790245448; x=1790850248;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4gKaCmlo8zL0/IT3A5NQAgJVMGj3NM0BKVIjo7Jj9JQ=;
        b=ZE92iLsQ8Jcux+OW84M9KUH2ZcQbm+htNHIz6yeVQZQxb5c3+gUYCE1mNte0wG9igZ
         QgW65WxGL4KZCy9cqr+OLc0yBtArGmYKgMydgjgnBak3y7M5UWD1O9VGT8ci93wsX74o
         XLw0fsnRgvksp2zEy7iaaEqf7MI63jyklKcnMdZ5a0nIZeZ+jpWL8kqT88u4a7ib5Nmr
         utjM1QK7fmzncGzYld5hImEKdJkZ0cMn9W3f7v+WmKzAjm3j9EwndoPpXh/4JwsatwmB
         XaTtUniql3GbMVKxhgSVcMj7P3U9nLEp3TleXSHmnsoYMbE8ydbRw6F14/NFbO65pKoc
         p7hw==
X-Forwarded-Encrypted: i=1; AKwUvBwNXo2hQxD4rT0//EKdJfJ4wkBNN2mXpKLF/io/a/0ZPwK8/NKmfXnIlomuRRH5eHM6lk9N9h8=@vger.kernel.org
X-Gm-Message-State: AFuF++kBN5KqJQTtz2okCROiU9H3cZ7Tvi3v4NRQh8SQ/koi/k0eBYOd
	Qkdujr/jAP3CKwmvdaP41nl0h71A4JKmFOGWd+yHA9w7SlOYmhvHQhnipopw0aoDQhNpCuO9Tny
	3LYNL2HKuBtoHHrArsvitPNTTVYhHjddyPnJTf/tXe//SLvotZmXNhfj04w==
X-Gm-Gg: AYBFou3FLTaMgP9Hwq3Z6pVQkp3iymn+CuqbVUo4pqw3rJrCQRm4a5vj+velthHnJnd
	EZlvhFWUDYnSN1/gYoW1uJeJlALH3Y7q35qUmlIdg0jeh/4ynPqGRU4QBcgfAAkUe9DOnnz0+6X
	Yi6u8zlyNr3OJN6m2VdvQlMfuWqLYgtMA6N6TzxpU0RSGd8w+/m0XcozKLSpRUhb1Q3E8v2ZyG4
	ZnkgRolUbXx9SvDPXVcgVGDgaBckVqWOMEucPSPKfwFW02Ti2QjSVmPqmUuuq6FQHRP1GUqtFW3
	PtanDoidVi++6bXQdHGfdjGTpkibJHbawr85STWPcFqBeQNOu94Wt4cUF8R4flxEIpKk6hRWOki
	e2E8HfALEdldG7Mp2KA5v1EBhyRRPKIt9+yJJXA7eK0Y/egPi9PGXGwdz3z629bDY5AHOTeExhA
	==
X-Received: by 2002:a05:600c:3515:b0:49f:d778:be09 with SMTP id 5b1f17b1804b1-49fe66fcc19mr33137715e9.24.1790245448048;
        Thu, 24 Sep 2026 03:24:08 -0700 (PDT)
X-Received: by 2002:a05:600c:3515:b0:49f:d778:be09 with SMTP id 5b1f17b1804b1-49fe66fcc19mr33137285e9.24.1790245447655;
        Thu, 24 Sep 2026 03:24:07 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5b9c59dsm52797735e9.1.2026.09.24.03.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 03:24:07 -0700 (PDT)
Message-ID: <4d5e2857-e6eb-43e2-b668-83e779aaa734@redhat.com>
Date: Thu, 24 Sep 2026 12:24:06 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: usb: cdc_mbim: add MeiG Smart SRM821 to ZLP
 whitelist
To: Ming Wang <wangming01@loongson.cn>, netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org, stable@vger.kernel.org,
 Oliver Neukum <oliver@neukum.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
References: <20260920074500.826121-1-wangming01@loongson.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260920074500.826121-1-wangming01@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/20/26 09:44, Ming Wang wrote:
> The MeiG Smart SRM821 5G module (0x2dee:0x4d53) crashes and drops off
> the USB bus when it receives a Zero Length Packet (ZLP) after sending
> or receiving an NTB of exactly 16384 bytes (tx_max).
> 
> According to the MBIM specification, devices do not require a ZLP
> if the NTB size is exactly dwNtbOutMaxSize. However, the cdc_mbim
> driver defaults to sending ZLPs for devices not explicitly whitelisted
> to accommodate non-conformant hardware. This default behavior breaks
> the strictly conformant MeiG SRM821 module.
> 
> Add this device to the ZLP conformance whitelist (cdc_mbim_info) so
> the driver will pad the NTB to avoid sending ZLPs, preventing the
> device firmware from crashing.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Ming Wang <wangming01@loongson.cn>

Before any other step, please read:

https://elixir.bootlin.com/linux/v7.3-rc3/source/Documentation/process/maintainer-netdev.rst#L454

AFAICS this is actually support for additional H/W, just worded in
very unusual way: please reword the commit message accordingly and
drop stable from CC.

/P

