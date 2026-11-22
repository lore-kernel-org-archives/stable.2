Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795362605;
	b=bXk8euLXRQM9U7/2zRjKBRjnGXROZUuxvKtDKropXCM96wb3oMXNnZ8pt+UuzLKKeDv/
	 XAsYjrTK9X3I/Sa9+UXfYljhRPNEQbgjukRXB8ShuLfqWgPkaL8M25f5gseaw9qCmP0O+
	 B4V/YsManSs/dAO5j6Zvkzt+FHyZOcArTAjQA9Yq5Sxlf/KjAyPn53JiAT2LwWWjGKkZc
	 LYMiCCwLd17z287yP8yykkYK0BaR0G9KAaM6OzFKC3Ye9PqKK+pwtCbNK3+uNUMseVIZo
	 Uxq0Ji7UmmLbY16fQLssJEJhgaIniT0Nnquni54DBYleF4y2T5QjW+FY9GO1i3jJYLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795362605;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=w3rclRjxjm+xEndB7WYb8szsZvXx3T969YLqRHQLZsM=;
	b=NmCWpPITJuTBRpOIPT9Qly8Jwytyx9pli0BDA/60tcR9L9qjaL8RaPYOGWhVaD07Y0nn
	 LthoQgRX5r5pyh6fuykuGyOJNeDzbMHq3LpI1sjPhl6AeNxorJRZRaxI2VoiUlKwE9dbO
	 5YiKt9IKtFkcvO0SPlFedZjPLYsGTE6eSTvGscaE7w6ii11o1EunDjBgQ1gXEMavaru9Q
	 zSGILZjKOIwdN4uJpWTqnahKnoqrJjAa9F1IvMKSZrGYwjrtkiqImG+5Rh/LXwCvqLaOL
	 6Tacp2vK3ALNRSc/rK2imFAgXVep3Kxjq4FWvKooKx5X/IZ6m6RX3U8w683DE3ARn5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=vMtf9LI8;
	arc=none smtp.remote-ip=209.85.222.174
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F931606A32A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 15:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F931606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=vMtf9LI8
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-949680e6d82so310658085a.2
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 07:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795362604; x=1795967404; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w3rclRjxjm+xEndB7WYb8szsZvXx3T969YLqRHQLZsM=;
        b=vMtf9LI8SAQQHliFH/t34mZDF1bj4B8nsH3N8C/j0klKwpKW2ulcuY7/OI39UQ3188
         aN9x2Dp7hxL5Bho6BReLKY/JIgRU1AVtRYJwNMyKGqizkNBvZEIsgs3WqoHVSOLb7x79
         q+FAuV3oNHpqArJdDBC0mAqN18C7lBtA1CY7m/cW5UYA7prgLhoTeH1jRwhYGEXmBMhx
         xgHh/b4uxS8PzqCCWVefUOCJVrYXU6OnS4mh070Fr1SL1pU5biSU2K41qiVzyxPEGJeL
         AuTtNLaVbEvcMMChs/U45GDaKEuvo97Cn/9DtNMH7cUPbgTTJHxFJeIqUgFnWpKN/M/M
         BnvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795362604; x=1795967404;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w3rclRjxjm+xEndB7WYb8szsZvXx3T969YLqRHQLZsM=;
        b=vwcU4D3paxb/uHTdeXzOiofk2o4q8lOEH9jILqCzyJyPjy9loOMP4/3MZjqfEEddG5
         8RTi1teFaG/oz2xIy5xL5TC9Mkkh+iklqxfxKAlt+gj9w547e0DIW5DM/EDDDifwRoJx
         yJiOrbPbBPC26RuHfA44P2OmIqQP0il7ii1ZJQgqnwzRSiVJw5eYXkWGR+Nv3xS/3MeE
         NZp/PhWqkHvO+wIj3z4gQfsHfU46qwHNhkc/ULo7nl7AuwT5XdSVXwSe5Lw0dx+UEkHE
         3g//JWlmB0fstMAU1XeztmA3MT6GJimSjGtNotxfX+Hd618IT3dsWKgnlmikIk4toQw2
         K32A==
X-Forwarded-Encrypted: i=1; AL+hErFksNe2ziYDb5iL4D0J6PdUr0ljl6zaEyBu5zV7waYxsS8+SAkBl4qBB/xUI5+Mk2Xy4uzoUc0=@vger.kernel.org
X-Gm-Message-State: APuU4Z99XaHYNAEFMcIGFd2VNt3j0xs+Y21sARLht3SQpus6qIs3AkDn
	svUKP48s8P9pb0BXTnisXi8R6GY/wPRP8jy1wV1P7UtEBSicopdmx44qgx+x+1TvE4Q=
X-Gm-Gg: AZFdTZcT2KUAoJ8Q8IQDzgxc9+Zp2ABzHkf3YwbDPLqCLsXCpmridfmFPou31yY5LYb
	uQw9flr8EuhriqJC6R32pp4Hp2aIm87fvn9WovuRHGTh94TdC6RB8Z/EZPatITCmT5N5bsnwPZU
	uYL2+/Va1x3MpM7BkvHKVPZPIL0MFt/sZ7HHD1qeICbH8bYeD/0NPAtccJMGofjZMT8AWa5FyJV
	JH7pMvh3wGuhi7PngvXS1GBdhNBThaTPotWGGjyUFbuXRydWpbyGU8pTY4sGa6y7L+EmLKkGdiw
	Pa5bFXEJgDuHpUM/l0QL0aXhalfJYT3MKHYRC1qgE6fsegu2a64KNL8wCRXKEDI6YfIqlU1EwZC
	T5v3BjP/mPQqc2Q9JxIIyg43D1K8Rs46SWMudm9OLzmVNEq+sETo7XiPO2KMMuvPaEQi0AmWEkN
	52djUy6by48Hzm9DmnBV0YL4ycBfK4V+hmrLMDWTNRr9vk39cScpitlFwxrJlXjUKiIJyRDuBEQ
	+qWnQvrTseVPf30nOyBQ7Zfx0LoLlJiBILDngCUSnnJ/1ulWJ86VyAr02YGXTFjNp/PByuxx0SV
	/U5xSByNlIiqXaxUBL0dfe7Ar5bM3dmcoR7BgreLYV8yaNuC1iEpCRWuMb/j7KJSIFUbNpOeeaZ
	FHH1lasA0Apv8VVVhK3O0H18cspTL
X-Received: by 2002:a05:620a:6505:b0:949:744e:12eb with SMTP id af79cd13be357-949baa10b08mr1523882385a.65.1795362604231;
        Sun, 22 Nov 2026 07:50:04 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb41c105sm632888485a.39.2026.11.22.07.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 07:50:03 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 5/7] mm/mremap: apply the mmap() offset limits on
 expansion
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, 
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Kees Cook <kees@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, 
 Ollie Wild <aaw@google.com>, Adrian Bunk <bunk@stusta.de>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, Joey Gouly <joey.gouly@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org, 
 Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261121-some-more-ai-fixes-v1-5-236e925d9b64@kernel.org>
References: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org>
 <20261121-some-more-ai-fixes-v1-5-236e925d9b64@kernel.org>
Date: Sun, 22 Nov 2026 10:50:03 -0500
Message-Id: <179536260304.412063.8485838901368834162.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-21 16:02 +0000, Lorenzo Stoakes (ARM) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> Commit be83bbf80682 ("mmap: introduce sane default mmap limits") made
> do_mmap() reject file mappings which extend beyond the maximum offset the
> file can support, via file_mmap_ok().
> 
> However mremap() can expand a file mapping and only checks that the page
> offset does not wrap, so a mapping can be grown past the limit that mmap()
> would have enforced.
> 
> Fault handlers rely on that limit. For instance dax_iomap_pte_fault()
> converts vmf->pgoff into a loff_t, which overflows for such an offset and
> defeats its i_size check.
> 
> Fix the issue by applying file_mmap_ok() to the expanded range in
> check_prep_vma(), failing the mremap() with -EINVAL if it exceeds the
> limit.
> 
> This means that mremap() now refuses expansions it previously permitted,
> however no file can have data at these offsets, and mmap() already refuses
> the equivalent mapping.
> 
> Fixes: be83bbf80682 ("mmap: introduce sane default mmap limits")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ ljs: fixed up commit msg ]
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

