Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793867924;
	b=RTh+p51XAfSZiBlBOwczpJVZdfsrasFHOxZY7uGnpbcqsNyHWKAzFTzGorPQJyaj56Aa
	 Iyz3+Mtfu/ffApRZyH2c5r3rbMpE8druxD9+uj8qYRgXrauVZBmFgNgpYUXq3wO6ZDi5l
	 Y5CyMpsMZHHxeSuD3CpOUCKGSAYNCRNPuv3q9Iw/DzPjwTqXd0RxDJm5a6GB9rF5zCQ+F
	 ibjQxnZRLWUrsHU5IfkSf+J6YyjHhLtGSABqa5I3aT1KkbhQgKXs9QmprKbdg8sq9ntxn
	 CFGrmGy0ow5K/SNBOkimLSeF/98N2ToWAYARqVTSD5xzeyHKyP5EefnoXyFd2F+D3OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867924;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=0uDYlxqiv0mSLq/hIWs5/UPyDpAbAUOWaGdtWRXlapg=;
	b=NS3K4bkBLSgLnhQ++e9cKvezga7xFT6izK0NVg2/xpUtk/cubFot/ApFITmQgp48vN+7
	 FiuiT52h0osAj2iePSDpiK99dX2q9MpiowzfyeBU+TvFw7yXrFTmXfOeCbZCvtv1O3e93
	 F6NRbniHY2BuMLOTbphR2QnpzjqxgdaqDKValuRXsQH7fWdqzjS4bjfRJxermocGoQofj
	 2vnCjVif+DlIAPGsvVajeILyYNGWYVlfWkP1FugCIBLnyJsE2+rHKQWQ8cStRFKseojK1
	 68fy/TgA355NQR+fEKRHgWHAdH5wmAqIdwf69CAu3XhtfCBRd9fRn8vtpRvBCMSVy5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FWVVgyVK;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A457606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A457606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FWVVgyVK
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so1107638a91.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 00:38:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793867924; x=1794472724; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0uDYlxqiv0mSLq/hIWs5/UPyDpAbAUOWaGdtWRXlapg=;
        b=FWVVgyVKmbpq3jqC7wnZ7iUai+Zd8NmolPxVCvTqr/tCwGrje986AVfcmmjuHx5kY9
         BYpmN6pjKCpnw4Tk6mmnXciTqDymgiYizuynW+9u/PORW+WioUvuMmxVf5fZV//6C1X9
         cOT9dLhj926lES0dSAy+SzUq9DpmZW6MF4K9RMc8YHmwCj2LdU8R0f5dqRK5VhlM5SU3
         4Ry2+4g/eqWu+WFMtsH91dHegXX6Hu08Hj4gjX6saWWNRkIhhGkWbGUTYJQ3g+M41mR6
         ObNhYzgHEHAE6L7Itx7fDzMNLk1ES+KzeMWztLlSF5lGAodehQUB2PQKRmtCb5S+N/Si
         FFyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793867924; x=1794472724;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0uDYlxqiv0mSLq/hIWs5/UPyDpAbAUOWaGdtWRXlapg=;
        b=Jm58QnsdXFTfTCSdsWAL7i7O64CFw83swVH8zyNJDTwpeJTozCoszFjNUxC7cjNG8X
         LQv8Dkf2azVFSlrE6kW5YMPIMDVVsnJCCMYwvkkYzMwF5UxxeOV+u96zWTyV7v1Y9mdx
         d4o752kvP+q43MnZJOL/8Yeete/TCB6BxiGoRV7oaUQbY1m/OKDHUik1w5JjYD91r6/B
         JIaNl6WNVQ9E86iE/4tR2IDQaGTQCZkygwE2XvCpVClt+uPtfCFIRKduFKpII7wsmTAy
         8c561PrebQSj3PeLEKxMiXXXQa6kS9epeSvNhycDrvanXnYykl4wrU2PVBhGdJnEgKYN
         1PtA==
X-Forwarded-Encrypted: i=1; AKwUvBy97Bpc0t8SC0QSDPqBL9nxwu0dcIvy51iQ9TDIzjfeiWEpc2YgdA3tpqE+J5Z/FuBOp7ik+4o=@vger.kernel.org
X-Gm-Message-State: APuU4Z+0MhMOTBF84k6Vq6/9MIf4BDkP5361D+U9wL/FtPRIFy7LGGfW
	SBlBWhsJPXEm7zuai8pLZpe68ueYzStwJAY/V3kjVMLGUrytPASKeLzv
X-Gm-Gg: AYBFou2v6qHQ9HzQkmrH4exskOzgcpM4x0a87LD2zMUr9yzIHok9+zWWk5ataibArsM
	6StmADBQ4PEMzi+jNuT0z5oYyNHDTmXtQl9vNghUWJ6EDfiTtCQmUwmyhNtBUTA0P/l+St2DXh5
	Pa+IQPO/PWF8yY2KEcpIs7yiVGbVuIjvpM5I7MD4Ys/SCCb1dTX569Gw29sW1hD1KEcASh3Nhiy
	zim1vy0wqvAUy8Ss7RfiACIzim5oaFqSnhBl8SMJU339k/eW4rQ06PxAQXDEJyrDva4ukK6PAeB
	duyJDBguxoE5+6MhrEcFYBrRtOE0RlWUJw/dBHBaAWTSTCfhKaU4eCOW04CS+//AsYI/YDdII52
	7dfEcsVLOdmocWejARh7+sMyDQPF+nd+rLWX4Afd7xL6PilhOT3H9lqGpKVuFOnVaSdLSDELMmG
	f6XllXSy995nmg/7gCuVBdsuB7kon9G73WKjz+2IvBxi8xyrF7Jw9Ibvv4SobPyFMtxlnapNTu9
	kLTsY2gs0XAhXloATnJ3LWgI+qBdJbeXwHURl/gK4gqRmWUZNqfoo1LhUA3KZoDpo1U1E6zrw/T
	FfhM9ARaFsHvACKPfTRP3dVOelIEfoMONg==
X-Received: by 2002:a17:90b:4c52:b0:3ab:1481:69e5 with SMTP id 98e67ed59e1d1-3ae897ccbfdmr15940958a91.11.1793867923599;
        Thu, 05 Nov 2026 00:38:43 -0800 (PST)
Received: from localhost ([2400:2650:24e0:bf00:cc77:213f:afc3:65e2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b31d2b5esm2812294a91.15.2026.11.05.00.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 00:38:43 -0800 (PST)
Date: Thu, 5 Nov 2026 17:38:41 +0900
From: Zhenyu Wang <zhenyuw.linux@gmail.com>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: zhi.wang.linux@gmail.com, jani.nikula@linux.intel.com,
	joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
	tursulin@ursulin.net, intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gvt: Release GGTT MM if scratch page setup fails
Message-ID: <auxAkaQM1Rri52K9@dell-wzy>
References: <20261103065407.1070225-1-vulab@iscas.ac.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103065407.1070225-1-vulab@iscas.ac.cn>

On Tue, Nov 03, 2026 at 06:54:07AM +0000, Wentao Liang wrote:
> intel_vgpu_init_gtt() creates the GGTT MM before allocating the scratch
> page table tree. If scratch page allocation or DMA mapping fails,
> create_scratch_page_tree() releases its own pages, but the GGTT MM and
> its virtual GGTT and host GGTT buffers remain allocated. The caller
> skips intel_vgpu_clean_gtt() when intel_vgpu_init_gtt() fails.
> 
> Drop the GGTT MM reference and clear its pointer before returning the
> scratch page initialization error.
>
> Fixes: 3b6411c2c205 ("drm/i915/gvt: implement scratch page table tree for shadow PPGTT")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/gpu/drm/i915/gvt/gtt.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
> index 5056a5887b31..17d61548ec05 100644
> --- a/drivers/gpu/drm/i915/gvt/gtt.c
> +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> @@ -2403,6 +2403,7 @@ static int create_scratch_page_tree(struct intel_vgpu *vgpu)
>  int intel_vgpu_init_gtt(struct intel_vgpu *vgpu)
>  {
>  	struct intel_vgpu_gtt *gtt = &vgpu->gtt;
> +	int ret;
>  
>  	INIT_RADIX_TREE(&gtt->spt_tree, GFP_KERNEL);
>  
> @@ -2420,7 +2421,13 @@ int intel_vgpu_init_gtt(struct intel_vgpu *vgpu)
>  
>  	INIT_LIST_HEAD(&gtt->ggtt_mm->ggtt_mm.partial_pte_list);
>  
> -	return create_scratch_page_tree(vgpu);
> +	ret = create_scratch_page_tree(vgpu);
> +	if (ret) {
> +		intel_vgpu_destroy_mm(gtt->ggtt_mm);
> +		gtt->ggtt_mm = NULL;
> +	}

Better to just call intel_vgpu_destroy_ggtt_mm(vgpu) which is more
aligned as for ggtt mm handling.

The issue you identified with AI tool might make sense, but pls learn
how to work with kernel community first.

> +
> +	return ret;
>  }
>  
>  void intel_vgpu_destroy_all_ppgtt_mm(struct intel_vgpu *vgpu)
> -- 
> 2.34.1
