Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABBF346E54
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786122503; cv=none; b=Gh0Nhy7tpVDTB7y6wph2y2SCx8aXGF0V6+kKtUZyReeilkR6SOv9Xj13YpVEmq+Uvg0yD+BKj0hx1NFOj5ZY5Gk+KuT7RS1muNZjOwrWmnechx2p8aaUHMRUZdw1BVSjEQRNYdZomLaYvOKDRvA4SNTK8ykuNID9EJb8tVxMQcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786122503; c=relaxed/simple;
	bh=PEyv/ZNi02HaucwD0lzLJLCQOah9Kpc2cmwW88odXGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+4J8UgXFSEDN0hutsz8JDlQTrvFRYdTYidvOrC+CeGyLrmrMGyFvL47RvY0Nsan2qWwT4Je+8kqfS/FRB9OgXtVWG0f5EWJ6MokdlJUyNq/DMcALwyeKTNa4RcswFSKuMKdIOEUoluE5n/LFT3XsYVAKVVxUpql3J+YRMXq3HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JtNOOLD+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JtNOOLD+"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4957eefd361so27447915e9.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 10:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786122501; x=1786727301; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iaOeMTZOYIaS16knxOG50vS1TNGyqbn7Zjc+qZ37u3k=;
        b=JtNOOLD+BKHzhekHXUFK7fqLux5xka+dQPHThqPO7XT6oqsXWCT4m6xhGTlI8f74a0
         wX5D/AydYqllox4SGbbLDoTFfohtmOhisesQqCKbVr3UtklUb66Sfsbw4fsOdzaM9RWV
         oW6nk90WC5JXhTxWcwlBrKDnSzI/8vtrEjRuaUiHiJkcHJqW/1dck8GIIzKjMSvbMxoR
         5g8e6Nus2QRm2nHrqPOlGevHhepxAP6LuBB6y1POSc4J/7HerzDyqoLXetPFML0Lg6Rk
         cJRmBA+3tPb0TYXilKRvB5AlJgfxsZtf7Q0Di5VrOsLEEjg2FQM9H7kMJ7DXckshd9Ew
         UiGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786122501; x=1786727301;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iaOeMTZOYIaS16knxOG50vS1TNGyqbn7Zjc+qZ37u3k=;
        b=G7zu8qQIWBWzAzv9MMxP8jPI4m03q+O9WGERHIwH7m+7n0Gqw1JC9tLxviPXD5Xtys
         GzDNpUXQ0077C5KaT5TBk31H0CQNi3vwH/1cPNn/gd1oMwh8w+3gfBoIHj4wxyHvD3PP
         LvjJMPvo9W9baceus0qy0fu98vesoZQ4745A3H8nCkDXjOZVDEu5rdWiHsvEM4X/rieB
         yu2TZOsfiHKadrNwWoId6tgtOjGJ11FydZAs50d3FfTlJ9TPeaXp6BxVGRguAVw3dq8k
         rQ51vCj0b+Pr7J3RigNvo8ZDPJvLhU23WfYuFZfZ03vsrwuvUM/hLKPhNicZ+ebwuxVa
         OZfw==
X-Forwarded-Encrypted: i=1; AHgh+Ro/W1MIrEG78RIMYgP2YKLnD1eNTeG9f0Uvk7jkjx0M3NEN/Zs6jvYWjWCp7NgB+Metd7fl6xE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7InoLtpA26BCaWwC4mfkIDFhv9bvNEQSvxxOn/j4uSnNAerle
	bS4GCvj7rw96PHGFglrReA1QP2LZiEUfeI16oj4J1vSdT1U5xWuDFeGe
X-Gm-Gg: AR+sD10DyjWelvgdF6f50Hnk3SGCmJ/KjQjDQRV0NELC0wLwZKJHtecv0QJTDzxK1iS
	RNvDSjf0OX5I4cB+/4Jqvx5AhMMjwAXHWLX8u7UJW1d+DBZVZhNiQIwomJT0bvBTMI0xEmFNKxx
	QB3XduqhORPUpXADji8vWnNTjOVH6/LRy1c9DZ6nP26tR0i3BBQo7UKIAd5aF03xiP2ADIv1rwW
	PhpmT9f77as5z0ToWTxbD22huvCU0g+WQKynXDwPPhSAHXuaVyxNOlpXemq99x6EvotTyw8p2nk
	t3uihZlgZ+hv8tXTaoow1BKG7DnIELft8IvVQVuUUb2/YG41zqfYpe45lLfrcDODUTGAtztAWaL
	9qMFFoRy3U/pfB3DCesFpGUQAXAU/nAXO8iZtce6ZhkFvKfv5dtwiv8bFIcrSLCjI4V7yttWLxa
	vCAvYtIUsudoqjsCQl8HT2uWGomslslu/X1Het5KsxRAGWwVei0y2tkMrX3kdIV86U7VtK847SG
	u5/fwF18W78ee8ZgGmMhgunZ0sf4O2Lrl963DrjUfgFdKqETgMJC8P9JDEcGrJHsAienUmW0740
	ILqeKsvEErB+yO/ChqfZHeXy9JMxMlUt01j6mVAzvVN4tvrh6E7T4n19xlGeZgJJi8SxuHwg5pf
	5BZ9wcIHfb+JdOXWDQ6g=
X-Received: by 2002:a05:600c:b85:b0:496:c93d:e2f with SMTP id 5b1f17b1804b1-4995e0dff0amr73285775e9.15.1786122500534;
        Fri, 07 Aug 2026 10:08:20 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-b105-e101-a437-493a-4de9-ee3e.310.pool.telefonica.de. [2a02:3100:b105:e101:a437:493a:4de9:ee3e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995ea27ef0sm60747585e9.9.2026.08.07.10.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 10:08:19 -0700 (PDT)
Date: Fri, 7 Aug 2026 19:08:17 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, Fuad Tabba <tabba@google.com>, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: arm64: nv: Allocate the shadow S2 MMUs
 individually
Message-ID: <anYNTW2e3HalTqTk@gmail.com>
References: <20260803224405.41468-1-kmehltretter@gmail.com>
 <86mrv2arf2.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86mrv2arf2.wl-maz@kernel.org>

On Tue, Aug 04, 2026 at 03:31:13PM +0100, Marc Zyngier wrote:
> See the hack below that seems to work OK.
> 

Hi Marc,

Since error handling has come up again, I should clarify why
v2 did not use this sketch verbatim.

> -	kvm_init_nested(kvm);
> +	ret = kvm_init_nested(kvm);
> +	if (ret)
> +		return ret;
>  
>  	ret = kvm_share_hyp(kvm, kvm + 1);
>  	if (ret)

Once kvm_init_nested() has allocated the pointer table, failure in
kvm_share_hyp() or any subsequent VM initialisation step leaks that
table.

v2 therefore calls kvm_init_nested() after the earlier initialisation
steps have succeeded and frees the table if a later step in
kvm_arch_init_vm() fails.

> +		for (int i = 0; !ret && i < S2_MMU_PER_VCPU; i++)
> +			ret = init_nested_s2_mmu(kvm, &tmp[i]);

> +		if (ret) {
> +			for (int i = 0; i < S2_MMU_PER_VCPU; i++)
> +				kvm_free_stage2_pgd(&tmp[i]);

This cleanup includes the entry whose initialisation failed and any
entries whose initialisation was never attempted. An uninitialised
entry has no valid mmu->arch, but kvm_free_stage2_pgd() immediately
derives kvm from mmu->arch before checking mmu->pgt. It can therefore
dereference an invalid pointer.

This is why v2 tracks successfully initialised MMUs and frees only
those entries.

Thanks,
Karl
