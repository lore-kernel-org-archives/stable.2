Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B77D279DC2
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091261; cv=none; b=OQLpJNBkYU/a21x37T3k0EBNlYJw2TGZPora/BUUn2bXw12rI2J/dr7ZwzIjidF492U0JZ82VlkgxzwzCDjO+ZcbMadcncp3bFjMI+doNf2rNW7LRTDLjOJ51mP6l/avLDDtZo07xe8vE2mPs+W4n/5Ov151iAHOZ+P2XBass6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091261; c=relaxed/simple;
	bh=mgjyxZoiOvFijt/d+PC0DtD/Alk5U8ztsi8AqhLZuZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xr+s/dtVDNTrf/OlIj92pkb0AbjFJiItX3qZQynpadTW1UqFII4si5bXw7+MuqnDXstC4KnOQlkfalPMpu1bO6LROe00BBzk19PLaMDGzgp3WRUrqlUz81ODchLUWQ8q5/bIL1QacwwuSveKWuW37EadgHWixhLwIe6HoNHB0qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RuAt6L0F; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=B/hPGg30; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RuAt6L0F";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="B/hPGg30"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783091258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ufmoYIO+8FVkXj7I+/+r0HlaIjqkZ37cLPCzcjFGBsk=;
	b=RuAt6L0FVMkBLNgDU7IVySAqPi0x3uUjHTY1YhcDL8/rItXH1JwoeX/dY6VX8KZKBjotkB
	JIR/xw/JgSYfm5J/WFjf3OYcyzGM3MSkoj5AhpXsTfTPkoWDJWnCLLBPtx3Cgvf9wORx0z
	kbcqwG0l3KBdlQhUEGEwvGRxShysxmM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-lvhhsZv_P5CS5zpTLmrEFw-1; Fri, 03 Jul 2026 11:07:35 -0400
X-MC-Unique: lvhhsZv_P5CS5zpTLmrEFw-1
X-Mimecast-MFC-AGG-ID: lvhhsZv_P5CS5zpTLmrEFw_1783091254
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493c588b6f2so5037145e9.0
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 08:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783091254; x=1783696054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ufmoYIO+8FVkXj7I+/+r0HlaIjqkZ37cLPCzcjFGBsk=;
        b=B/hPGg30VI1IBI3VDfScRK027txAkZD2w3apaKDixLY3A3RoVpQttupKu9mzFiJh9n
         onxMm20p5xYD7pEQwnXwLXTF0Thrmq2q7t4GKy7bK+VhBrgCKA5n5mUdBuwYuai/477Y
         WJFj/pKuxSJDdMninWWJT9YwoLXUlCaXsT09I2pGAzxncesaLNBED0xUQXPw6dASOCl2
         HZ3br5aqpnJV4LcYPBaHguWrHPsedTzWL+cStLUefc46k6V0iYNJgO1u77241GnsrwUn
         aXlxp0DwpsSHoeTmsfRkEsMgz/dyNiIWFUE9WYl2XeABYwNSVHMvPvZDsvMQoQqbQhUk
         jbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783091254; x=1783696054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufmoYIO+8FVkXj7I+/+r0HlaIjqkZ37cLPCzcjFGBsk=;
        b=qtNXXRs2UsKpsoHmjf7ak5Rik0OGP9fgdT5yhlxZ5ggVVoHoDgeaxdI0+uuF3SlwXI
         RgSneeHXASmSOpGpdeMQOQMKQliY+jHEoJNBvMlebS+V4uCixs4rZfSKYgR+uAYsqjzC
         7OcRRwMIWHNTJg8m3ELLHFECNAptKv0rhNhfMq93u3sibiPdReZ38kKvrwADPn+SNjsN
         Q7v/MtN0N4fcvnYu5gHItwBnAZ90SdT51YcF4OM7vxDBdDiCess2vxDvE0J+9IKxcs+Q
         9kVra+Xj6QAYrVNaGT51HLZd6ilJOs5/gYo5pL6IYCBhAKW2R9izf5AriAyCDDy/+waK
         gp8A==
X-Forwarded-Encrypted: i=1; AFNElJ/GZtKBXrn2udzQKdIVMvQZz9cig/kNowcCbM/rsPT3zwPsPZk7XTbcbHv7OyF2fSU2A8PrE/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2A1g0PTaQDBlKAZhwuFvqet9TTuP7Bao1NB4iAq3VydxSsfzV
	/eHzQdAWh+pOpiCo9QQXKKhRUSUajy5KD8vJiokyt7+3H+Af15FPDcxGDfghG+jtC8zBbINonPQ
	Or9P9pzSDhgXJBpERuCOa2KaDL2mY2x4xSBeYsqe8f87lvlX4ddWCcN97Lw==
X-Gm-Gg: AfdE7cm5qwg1P5uLu3Wg4Ac7NViYKw/a7vxDEGQxwfOgAaYLMpqVbyUjzEKSEDllP6t
	DZkWNDHEwIfTnzbuCyYiNgXpAbwhjccRgXqBxl6s7Ypz+0MXAie9Lft08Y4trcf/pT6ToRajj3G
	/+slW6MfapQTn97PPoHodeVhR1/Yx6rVV5iufLc99I2cmGzcpItkN00WHHKkfIPW3kt6a8945c5
	A8AgeDdi/gIOLWqSKrSa+lBqVEoDAUoMSLcnkzEeRxf36EGuckzRr9WS5+kjwIJ9RlpClkCXXnM
	6U1Krh16n+/U2QKUxnqZAywfU5j6dcyoGYyXjrWVtBAXxV29xkz+gGQy0l/JzQ4CKmaxZwN2G9P
	QLQt5FDiqJ3MkGIplb66SWvaHsuTemMAlJkRqB8WBfBDnHj7TC38wUd5GyQRsPWfM7MnCjovPxa
	xJ3Jc=
X-Received: by 2002:a05:600c:22da:b0:493:b55f:bca2 with SMTP id 5b1f17b1804b1-493d0f418famr2033625e9.34.1783091253954;
        Fri, 03 Jul 2026 08:07:33 -0700 (PDT)
X-Received: by 2002:a05:600c:22da:b0:493:b55f:bca2 with SMTP id 5b1f17b1804b1-493d0f418famr2033285e9.34.1783091253473;
        Fri, 03 Jul 2026 08:07:33 -0700 (PDT)
Received: from ?IPV6:2a01:e34:ecaf:77c0:40ac:89a3:9858:a68e? ([2a01:e34:ecaf:77c0:40ac:89a3:9858:a68e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493cfb6f199sm30527515e9.3.2026.07.03.08.07.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2026 08:07:32 -0700 (PDT)
Message-ID: <eb829084-0b8b-4317-a382-4a9d0a0b4bac@redhat.com>
Date: Fri, 3 Jul 2026 17:07:31 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] 9p: fix privport option setting wrong RDMA field
To: Stefano Garzarella <sgarzare@redhat.com>, v9fs@lists.linux.dev
Cc: Latchesar Ionkov <lucho@ionkov.net>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Christian Schoenebeck <linux_oss@crudebyte.com>,
 linux-kernel@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>,
 stable@vger.kernel.org
References: <20260703102254.114446-1-sgarzare@redhat.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20260703102254.114446-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/3/26 12:22 PM, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> While reviewing a patch adding vsock transport to 9p, I noticed that
> since commit 1f3e4142c0eb ("9p: convert to the new mount API"), the
> Opt_privport case incorrectly sets rdma_opts->port instead of
> rdma_opts->privport, so mounting with the privport option overwrites
> the RDMA port number instead of enabling privileged port usage.
> 
> Fixes: 1f3e4142c0eb ("9p: convert to the new mount API")
> Cc: stable@vger.kernel.org
> Cc: sandeen@redhat.com
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

Ugh, sorry about that.

Acked-by: Eric Sandeen <sandeen@redhat.com>

> ---
>  fs/9p/v9fs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
> index 274c5157135d..f426cee37414 100644
> --- a/fs/9p/v9fs.c
> +++ b/fs/9p/v9fs.c
> @@ -406,7 +406,7 @@ int v9fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  		break;
>  	case Opt_privport:
>  		fd_opts->privport = true;
> -		rdma_opts->port = true;
> +		rdma_opts->privport = true;
>  		break;
>  	}
>  

