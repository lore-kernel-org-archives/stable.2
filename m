Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795440637;
	b=SpRUohBD8WLfhPLBayQuE3Ut8tLvLA339DstFMRIDA/8D2EURVB3VphD1cRdi0/8MOq4
	 HRqItQ8L5BaGtmrHY/UT93jzEwAqpUvFG2aUeVXLCQrsWUErH4gIpV5VLQo/ldZPv6l1E
	 txgLZtp2h8HDbhz4u5nXIzys1CxiJaWAmH0VyUR2vNzaNXrhbG8rRB9rhuG2HfoHBwQqG
	 shcXnYGj3kc1IfYKsAIleP1Ns0LWz961vw4uJWEPj20cySogxQP2w0axTzbD3+aI+hAW0
	 mBSyjI1VAsOHQvjunSpsrAD0+i1TR5FICxki0E6nQBjwdwwpD5WB5O6KtP0SbaizLVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440637;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=qQXAfHWveCmdLSz3URl19N541Pjxo0PecFC7ymUqELE=;
	b=KXCb8RU5M36jE4EIq/tSo+M4FYVidFANUaS/eNkYOnPNMFVVcIr5On8GE6jNDupy9RAH
	 aEpuyC4S42tqUGeTdhKTV1klChogzqNthqe2MkeYETxDoMqcVAYPGE7+Mz3hKF5PqDJIA
	 /wVt1D3HNQu/VuV86TpDyQT8cdsiGmW2TQbT08/aOLOGunzBtPgE8aVYVK95wAaE1pbkU
	 onbRKpel3Wd0T1eIkWSVmFUn4bKezQprfSYQTCHiCUP5V2C7UnFDJDDvRlUBo3cqGO9vn
	 EuYvqgeJxpz5y0HRi32LWIb939pWG07Zq1nXb0zZxi3yORx8bE8DjobFolBHmK/XW3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EtFgoYfQ;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b="dLSSq/Uk";
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABF6606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 13:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6ABF6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EtFgoYfQ;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=dLSSq/Uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795440635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qQXAfHWveCmdLSz3URl19N541Pjxo0PecFC7ymUqELE=;
	b=EtFgoYfQuP8Gf5NMHbcdsm+zdu81VUhEJUXXxp2o/LgzIYdh7LcQOumsK7qV8gCCuekmBs
	qffD69w1HhEJ7zlmC3ZuLMpsD+ra4V+T/YHw5G7zO4mzKD4pzAVybFbk66h/FSdDhP0Yvf
	msxXVThbeJCBIbxAFOdBLSN5GKL5CWA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-mDpf8ASzNtS6sG_9Cw1Eqg-1; Mon, 23 Nov 2026 13:30:33 +0000
X-MC-Unique: mDpf8ASzNtS6sG_9Cw1Eqg-1
X-Mimecast-MFC-AGG-ID: mDpf8ASzNtS6sG_9Cw1Eqg_1795440632
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c504991a35eso329775566b.3
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 05:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795440632; x=1796045432; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qQXAfHWveCmdLSz3URl19N541Pjxo0PecFC7ymUqELE=;
        b=dLSSq/Uks1no5qNJ4Lu71xvjtfL4hqd/Uv4ZUX4tiY/cvJlc3PfDjUQ9BHiDSTu0pz
         48w3AVMmziJ3YoETQ0BFnXZYCtx3McrpmPwRIz6OPiMGHHrrf4gzv1LLDxkJmjP2C3DO
         flOuVuLyAVcJn/xKzWR7uoeCWL5E02B+j+bGZIqX+/RrNVAr99AAU0WnChWB01pNP0Re
         VOFP0fs7MGMdgYZ3OSu2flaFLhIBiGEH4DP30ewP4gGVkNPF+JY5xjgfwQDwbectBjmq
         qpoCWipqNU3D7Nc8T+jRJ7V3DRYFBrpnlnjZxev/nldyy47xc3enb3qswofL+yYl1hOQ
         DFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795440632; x=1796045432;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qQXAfHWveCmdLSz3URl19N541Pjxo0PecFC7ymUqELE=;
        b=BY+HkCYCEBiJclcz9WfurMT89rYC8w3lx0GMMv1qVE6FEctDf1DYoMpYO1KC2Me3oM
         kzTZI6TGc1oirERO+NDE3ipq/xOwV0Gt96w5njjtDraWRytJnexvboSw0Ko8zTFYpfcM
         he9qtblMIICtf6nGrUUP4ehH7qiOmlAoJJImgTGM54+J9td4Tejk5k1J0tW7tWShnyxF
         Gn3N10NONPZZc+qcNS5jSTv9N9Muo1fDj0CfyhNM0EbjxImtvaW45xEJWaIbru4bGfgr
         L9LMrfAtGewDwoOLdtboNh+hO73CxhVkLZFHB2OPWauORePtqZWqlqCYH+eEWnBwuE+H
         eNJg==
X-Gm-Message-State: APuU4Z/ZUVyZNJ0RGjnSk4hh5KTJnEMIGuw5MRpamzvRZ0fZvGGGVXJ+
	+O2QWUUeorqaVcp3sCC+t1FbYCE+h37778F2W9TOEjFVkBfznv15qIe3u9k/jid2a+j2dd62sK/
	CvMOyhtmRLMtJ7zxbBIb3aBZMxOKjDu2aUnW5rqAORTBvH6fhcc0Wx+vVjw==
X-Gm-Gg: AZFdTZeiY4lYOKnUKk+VvCJBIJ/BKOMdxOHs4/GIDbf9TVqj80/ghATixad6b/W6XVa
	lKrrwWo5IMUxQtJitIz3s6NLLS2QQ9MNNZZiYKS0acOjQ9vjxGQFdDvlO2QppGxtglGTTrl40uJ
	Mkkix9GBNZoX2xJBHmfFo+7SV3LOfx2Wthf7g3xm/Ca99ouHmsTRXLIOoFf9HCkoC59jFig1Rul
	gaNF2nsIo+cZkPn0iDgXDhZh9Ey5YYz8ZyGyzqUfs+K3Up7FaLiHSUq1QAq8LfF8sf365FpWYx3
	kr+fbvMGOrvQaJrDUopjpDjTJknHq6y9CGZxjUd95dRJhwD61xz2iYp160/l4Hni1ssCD8+Qvw9
	R8jdM8rstXAwuJktYT83o9qV1Il9MNawLRLrZUg30QsVIluVd7cr2YKEttY5wQndxJrT28FZNQg
	HNkMd5ug==
X-Received: by 2002:a17:907:6089:b0:c4d:f63:642 with SMTP id a640c23a62f3a-c513a99e69bmr1071147466b.33.1795440632541;
        Mon, 23 Nov 2026 05:30:32 -0800 (PST)
X-Received: by 2002:a17:907:6089:b0:c4d:f63:642 with SMTP id a640c23a62f3a-c513a99e69bmr1071144666b.33.1795440632158;
        Mon, 23 Nov 2026 05:30:32 -0800 (PST)
Received: from ?IPV6:2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9? ([2a01:e0a:11aa:87f0:ea69:b2b0:2dae:5ef9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513aea28f4sm418217466b.33.2026.11.23.05.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 05:30:31 -0800 (PST)
Message-ID: <dbbc50fd-1c02-4085-a142-0fe10b0103b8@redhat.com>
Date: Mon, 23 Nov 2026 14:30:29 +0100
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
Subject: Re: [PATCH] drm/ast: Add an option to disable Write-Combine
To: Thomas Zimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 airlied@gmail.com, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20261120155821.119377-1-tzimmermann@suse.de>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <20261120155821.119377-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/26 16:57, Thomas Zimmermann wrote:
> WC-mapped video memory presumably has PCI I/O bursts that interfere
> with real-time tasks. Seen on AST2600 hardware.
> 
> Add an Kconfig option to ast for vmapping the video memory uncached
> if CONFIG_RT=y. If set, video-memory access is slower, but avoids
> I/O bursts on the PCI us. Mirrors a similar change to mgag200 in
> commit b593ea940623 ("drm/mgag200: Add an option to disable
> Write-Combine").

Ok, so ast also is affected by this issue.

Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>

-- 

Jocelyn
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: f2fa5a99ca81 ("drm/ast: Convert ast to SHMEM")
> Cc: <stable@vger.kernel.org> # v6.2+
> ---
>   drivers/gpu/drm/ast/Kconfig  |  9 +++++++++
>   drivers/gpu/drm/ast/ast_mm.c | 13 +++++++++++++
>   2 files changed, 22 insertions(+)
> 
> diff --git a/drivers/gpu/drm/ast/Kconfig b/drivers/gpu/drm/ast/Kconfig
> index 242fbccdf844..f2c99e99b5b4 100644
> --- a/drivers/gpu/drm/ast/Kconfig
> +++ b/drivers/gpu/drm/ast/Kconfig
> @@ -14,3 +14,12 @@ config DRM_AST
>   	 is bound to the driver. These GPUs are commonly found
>   	 in server chipsets.
>   
> +config DRM_AST_DISABLE_WRITECOMBINE
> +	bool "Disable Write Combine mapping of VRAM"
> +	depends on DRM_AST && (PREEMPT_RT || COMPILE_TEST)
> +	help
> +	  The VRAM of AST GPUs is mapped with Write-Combine to improve
> +	  performances. This can interfere with real-time tasks; even if they
> +	  are running on other CPU cores than the graphics output.
> +	  Enable this option only if you run real-time tasks on a server with
> +	  Aspeed graphics.
> diff --git a/drivers/gpu/drm/ast/ast_mm.c b/drivers/gpu/drm/ast/ast_mm.c
> index 0bc140319464..cc882d2c172d 100644
> --- a/drivers/gpu/drm/ast/ast_mm.c
> +++ b/drivers/gpu/drm/ast/ast_mm.c
> @@ -74,6 +74,18 @@ int ast_mm_init(struct ast_device *ast)
>   {
>   	struct drm_device *dev = &ast->base;
>   	struct pci_dev *pdev = to_pci_dev(dev->dev);
> +#if defined(CONFIG_DRM_AST_DISABLE_WRITECOMBINE)
> +	resource_size_t base;
> +	u32 vram_size;
> +
> +	base = pci_resource_start(pdev, 0);
> +
> +	vram_size = ast_get_vram_size(ast);
> +
> +	ast->vram = devm_ioremap(dev->dev, base, vram_size);
> +	if (!ast->vram)
> +		return -ENOMEM;
> +#else
>   	resource_size_t base, size;
>   	u32 vram_size;
>   
> @@ -89,6 +101,7 @@ int ast_mm_init(struct ast_device *ast)
>   	ast->vram = devm_ioremap_wc(dev->dev, base, vram_size);
>   	if (!ast->vram)
>   		return -ENOMEM;
> +#endif
>   
>   	ast->vram_base = base;
>   	ast->vram_size = vram_size;
> 
> base-commit: 7d502136b31169f6b5575f7f89c3da60cdf7891d

