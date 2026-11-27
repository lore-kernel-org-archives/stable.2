Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795784080;
	b=VSz1w6e5LPv9TDyhoKSUoJD4GGfoQkfMBRUArqQ/oK7li+8Sg535ziSrOo7CHPCmgnXi
	 SACC7SYlRneYf8dtL1l2ep3FNIkr0/Z3kWAnnOXcMGglby2g3jWXkYEtkACXQjnqpJBEs
	 Vr3iCLx6RdQkVbHs0M/BxEO7K8NOiaIUTtnXRZr3B/JbMiMbzxpkZh16v+7i35rCqIDXj
	 fVkS3bQhkKgY+ISCeoAeK3wdDmTY+m9Jyl/8PnWX1iD4Oqnitiew/wGcSkWhs6iBFUIeS
	 rqpkCMPuyWGFPUukBrJo+BTPK4xpdeMhYkSQyB1hy6uubZ1PuObhVIfCJ7RXUfkTXWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795784080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=TQkVH1jjDAMiibOHHeNRFPOznvXK/0Z03BJFc8UEQVY=;
	b=nJEMM4Cd+Jkj2TZOxmx4LEMs71XyZ5Lnlnc7OaCrUTG1HKnWDRGzSbwkxf+Eeu288Omr
	 BUdnGw4373cyjcbTgmgzOq41UFBBm4QEFuY3VLJTVmMDgfDFj0dzUVyheY5p3/bKHAd5Q
	 HeTpKucTbCF0yFsgjZbNDYYRQqwcz8D3Pq3FGS0x6jiXFm5FmbCvjhjmHFZxUJ72uxTY8
	 0VrvQRFdKE8jZhG5un0ZIO6n7XXkxCvaJxPDYC+WyuNcrEL897wPuqq0E93HJP2SZ+lbF
	 +460b/iy/n820haunbDBFLvzLk1S/cMiIGcUrF8wmdXXNLYWMm3PVssARGfkPsXHpIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SIP3eZ2D;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDCE606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:54:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FDCE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SIP3eZ2D
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso43048395e9.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 04:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795784078; x=1796388878; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TQkVH1jjDAMiibOHHeNRFPOznvXK/0Z03BJFc8UEQVY=;
        b=SIP3eZ2DsdAMoRu4vPpjQzKjQZx9t/i9WRmXaY62bUIwbPnLOWxW3Q6lJYqWrSPQcG
         EtdUrY4749Yzrqs1BuVP6qxHYZ20BeFyoMWUC+rGNnm969fFoZB5pKQiL/CqVL165xIJ
         dP9GgOtWWGUS6ISVPvSYQ3z5Zh5eiMSIvJ/5IvxIxj+jLdzlJkXPNgui9YDGocQytf0M
         5s2VGUHqVvcuw1jNWbjDg7ptd7SCws6xdjNoSHiwI4G2PcseGXEFpJjfijhbzSpHsNE0
         ez/NsQj+w/kT2j/mXHvujRoQOALhqgcmeXVMPl5YSvoX3SVDaSPrwQJpizSqG2NcuLCf
         Mweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795784078; x=1796388878;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TQkVH1jjDAMiibOHHeNRFPOznvXK/0Z03BJFc8UEQVY=;
        b=hA3V0QhiZbQGavuIEMIjYXvz9qDa+EAPO8eVi9jVWaZC2sgZdobDN4OwqToyxsZniX
         J4ODHeaI2zjoTEVDMxi6pUPazC6LxfDoCsI8dAR1/ZqoAAUpDb923DNsFNNQv52qgClJ
         sapzcjXm75l4HGFH7A5PZAFKx94XQ33y1IdLo/4SnAbkjommjHq6d+y0uGBQANEakoxy
         ScCqa7lO0u+m1fchXRyyx7E/7z+TbAfhTuoEJ0G98xsDGXo4//rbMMg+eqf2U2xJZY+o
         oFJNaoMWmI3j76qVeKBAPRQQFDGogEqjQZ9NLkyaSPpNyDcSmDyOxKtXubil72qq1D4m
         t8NA==
X-Forwarded-Encrypted: i=1; AL+hErGpz50vycqGRw8fdr9qk7mCQeBFo0L1Kjl3qLuuyZ5fscutdzRSFqmk0lgqzKZdsYkzisvfyfE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/N7/ooNksxhZQSgL/oKkXtfQRVFzWWqHdjTFUUVPWGBKfF3N0D
	cRV52sOR+DajHFw7m1LciJFluJyYfFqXHV3BTEh3o+oCSGBud5ue4Q0P
X-Gm-Gg: AZFdTZdbdzxL1FOE8NDQsPowYjNEnbgHx1D6DZpfvcCTr9Y9x8T428+IffnOgdXuv4v
	hB5skXDb0D3xlUDWoxw6N6yk0NwTzYZ0uWUJ23SWatUGA8dMZEOoHqDDA3Qkhl4zxQppJVJaKds
	yRD1ZXOTf6v59Uwi2BamGSdoc8YsN1TR2pXzjLwbAB54E0Vnh3reRNvOr/GtAtCjD7HF6j8n9Dl
	qjZV7hKFzG9NfKexuMbI22KCYC5sir+JS4LMl+Yh85nXO04aPh9Yd1POorYWkOSMygDuiU0dOKB
	+IAIjG8Ndx+cSV+Mhx/s6uSrzGkFkN1J8sYjxjBjmNBhIKF8/YeZapvI19oF+IuCgSGl7WCZtrz
	2ZVHFMcXkyDE0Nu/f20fImKLXX8SoKa8OIbqAYBuUprEST0Qr0ZJkxlTY5iTTMj6eos4FTmAiP9
	MxZbD4Jr/CB6W3n5mF+lFGyZt7klb7gQ4WqqjJodZzZHXqPqr4kXLx8uy0DbfPJw3I6ECK9OuHr
	mjmKrmnCp0/qp/TJqECWxvZ9Kc4v8y73WeW+Koh5v3bTCyMvCr/6Wi69ih1TeRZK7X9zdRNErMM
	cJFAaZK0qj+IySvEu60RsybCCbB8/WkcLQq1USr0fvS3TUJnCb5NWOb9y6U3cSK5LIrnnhjCxgQ
	ZYa7TG94=
X-Received: by 2002:a05:600c:5246:b0:4a7:9006:b176 with SMTP id 5b1f17b1804b1-4bb887fe892mr527018685e9.7.1795784078292;
        Fri, 27 Nov 2026 04:54:38 -0800 (PST)
Received: from [192.168.68.89] (host-87-4-46-207.retail.telecomitalia.it. [87.4.46.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf630esm47880489f8f.16.2026.11.27.04.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 04:54:37 -0800 (PST)
Message-ID: <2b6444b1-c81f-4ea6-8981-9bd4bdcbab2c@gmail.com>
Date: Fri, 27 Nov 2026 13:54:36 +0100
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
Subject: Re: [PATCH 6.18 000/990] 6.18.66-rc1 review
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Francesco Dolcini <francesco@dolcini.it>
Cc: sungbyeongchan <tjdqudcks0424@naver.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, stable@vger.kernel.org,
 patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20261125143822.072087159@linuxfoundation.org>
 <20261126173920.GA180459@francesco-nb> <20261126174236.GA183126@francesco-nb>
 <2026112702-donator-rebuff-16b2@gregkh>
 <9e86f015-0f0e-4897-80b2-9662b96a98f8@gmail.com>
Content-Language: en-US
In-Reply-To: <9e86f015-0f0e-4897-80b2-9662b96a98f8@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/27/26 13:13, Emanuele Ghidoli wrote:
> Hello Greg,
> 
> Reverting e498eb93f961 ("virtio_ring: use shadow flags when detaching
> split descriptors") on top of 6.18.66-rc2 fixes the issue. The tree at
> e498eb93f961 itself works fine, so it seems to break only in combination
> with a later patch in the queue. Still investigating.
> 
> The "Device Manager" is TI firmware on an R5F core that serves Linux's
> TI-SCI power/clock requests. Linux talks to it via remoteproc/rpmsg,
> which runs on virtio_ring. With rc2 the rpmsg channels to it are never
> created, and I2C transfers start timing out.
> 
> Kind regards,
> Emanuele

Hello Greg,

Correction to my previous mail: the "tree at e498eb93f961" I tested was
mainline (v7.4-rc1+27), not the stable queue, sorry for the noise.

On the stable queue:
- 44b6e54e4a0a (patch 203): OK
- 22944d517ff8 (patch 204, "virtio_ring: use shadow flags when detaching
  split descriptors", upstream e498eb93f961): broken
- 6.18.66-rc2 with 22944d517ff8 reverted: OK
- 6.18.66-rc2 with this change: OK

-       if (!indirect && vring_need_unmap_buffer(vq, &extra[prev]))
+       if (!indirect)
                vq->split.desc_extra[prev & (vq->split.vring.num - 1)].flags &=
                        ~VRING_DESC_F_NEXT;

According to an AI-assisted analysis (Claude), not verified in depth by
me, the patch relies on 03f05c4eeb7b ("virtio_ring: determine descriptor
flags at one time", v7.0-rc1), which is not in 6.18.

Please drop 22944d517ff8 from 6.18.

Kind regards,
Emanuele
