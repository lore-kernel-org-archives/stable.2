Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795362916;
	b=1f0ycD+3px4vqpQH31dmN57e8pp3LDebCSYLC2MI6RY1Q6OhnrvLuBrOR4d5DEfVecbH
	 eNpZ737fKl3hgNzcEUQUwXF3KvojQc/NFyOr1De/5ZfF9uvjy5BlMuVog1d0VYfpPqoP2
	 SlKX1uY4ZBbXDHiTZQpxSilRS0P80kk8iuWAvFiAYKw9aCQqrlIitLhdhels+sLqBNNNP
	 j5hjuVJUoT1fdbivb2TDRZjZJBwzg4zg6sO6ZPpxuYqlYGgEA4vkhWdvEQJqBRRrFMpi9
	 bQUylAJ+juKQo2RNw14ZNfm0zBStKRmT+WLrhrXayXYwTFp5IaLdpztQNyeNcHiHkZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795362916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=+uDV1lXj3AvoHsrklYuKinbzjoCQBGsYSjr36ZrsvEY=;
	b=AZpB39HnXmF1a5snZB5DEAM/A8sEgihJWACvGaPYRbPSlEVZQio7cGLynW8q0tqZ+54/
	 /VbVuiDzI5Lac7qVr7PWdKRuWg8DbwG4A5lxhRcvwSg6LyNk7KsEy7cOhgYk4AvVqKzdj
	 VQFKXyGqkegSIC21Zb5onmWgALzcpyTQ+bzdsFVIXscy8ikbxqmZVjOisSIivLipddnUw
	 a5yd2m9KjWvCNHeAkyVlgXNBJ/7brxrmGULXFuICakvep6GfwPgp+qz/3oHO2McnF4V65
	 /pgY8WiWv/z74ZS/JK1dVL2T1RrhY3Cp4fuxiqL69iXCNqlE8ZtaZ5ctTvgq9AiZ1Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=BZU9E2zb;
	arc=none smtp.remote-ip=209.85.222.181
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A13606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 15:55:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3A13606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=BZU9E2zb
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-94965745d92so280300285a.2
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 07:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795362915; x=1795967715; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+uDV1lXj3AvoHsrklYuKinbzjoCQBGsYSjr36ZrsvEY=;
        b=BZU9E2zbalfvSwLV2ErK9bFqqRwi+LKRQkqwDv0z1qleh0ZRRLHhIa33xk7cV93UH/
         QADirfvFUgDjzTXsK+A8w3Adg51xgwyJOlh29SBEhiJKJziAzBgQUdW7IZwlnjf3DEmF
         3havt+aptoaf8o+a2YsZr9JwAYr4Jt3kvihb5DUXROEVl5mbqMs4RUzQJQRke1aAuGi6
         4yzXJ9l+5q849hrA1+BqSsqkwT76L6Naveg1+H9+x6z+Y+D4gvsHiTrZIfEuMfft1pte
         gCCFGPvNLDNCgmWpbo728+hKoOAA7luagFSPDWJnO3ijI9eFJx70aJVmYAg3OSwi16Ws
         1ELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795362915; x=1795967715;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+uDV1lXj3AvoHsrklYuKinbzjoCQBGsYSjr36ZrsvEY=;
        b=mSoK50zdSiN5xnx94n+g5fRJmh2+hhCOmuRyVJuPV9xHjWy//GDp1CqffjFwgDiMmA
         bDwq1Gay1mdH9g9ZyYTejOsWs5b1sdSs/DUSjN18iOP65rnfWZydfPi9gMyKkmn3ySuS
         AlbwZJsgs3OxgOMDskaOg45qZ5W1cXCfMPxA+XobNLYSMVIyUY34vd75hqcCvTPy+KjD
         CGW3UXzwlRXF/zwLPBMr8mFtaUTH4DswD/5sprlOPLhHQ1jdaUr31Hqo0R2eA1kreUa5
         Ci3v6m7KPJB5ubP2EBK3dz11evrqBupyjR962CmYp+KdsLEd7Kq8TjM3XEDyrD/fynSw
         YVbw==
X-Forwarded-Encrypted: i=1; AL+hErHrn9HX2Xnl17+TOOhH5+x7b5Ebgp5HZZ4s3zLWu14FxdL+g0WVcbNq7USjCKLVQbRvXL8xgKo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/zO43nDAQeV2WX+zq2LOPWqAdEeLSApI7ExuON59fg2aa7aRGL
	izjSlRGgnUF68J+BeaHJUYtWQ8JN76qG8BLFLkihfTI81vozLzx1l/GGUSsiIyP+UvY=
X-Gm-Gg: AZFdTZdp00u8+mzacEfKW+UnuwXPEA6bZ/MA1P9+w7Aov//DXYKtE4dYdzVJriXmGIk
	AS9VthWNYG0dEmuMKNFKlBHUJkklUAYHNMwL0wxUhreZNAhq6ioiPNdtaRkjo+qjViSjUpy6L40
	NYuRU5rWYOlUTtGrj59NH2vbI7f6PDR+n+HzuTDqwPcJVSQ+pgIAiDoxaU3DbxWNEN/du04iYbP
	FFFXO3UFQdvvZ9gI3W+u32rx2mVCZ2KhmiuH3VFRwL0BOeJO807V35FHXWFm8EUo6XsXb0ICEIo
	YLFarHcQU+DR5WhWA3XfT52B6BrtfFIOZQ1f3tdrd8BvwqZxynHmvBFDpQWNZVjt/W7A5npO+Ny
	ufeB//8CmH/RXva5RigU+/o8OQeT0TbgpXz8/RZyOvxvZpsBUvTEmbm1V5thAl0e+c9OEIyWlF4
	ADxyRjsJs1jJesnzdFaz1OvkBkVvOzgzy7d3AM0TSb9VmJ6DiBRb28XDtzWwYUPf99TFiyPd11K
	NbdH/3mTXWL02xmspeZGrsncCz/erBEqKJ9j72ZX1FoOimjFpBGFaqQq7KEL6xVkTeRx9FccszS
	G8NGW9APpEI9AleCUTZUNQteLDxfzeqEx6cTSsMYqmpYk9jZ9FrujsJ6YrV59DL7qI/tykP1TAm
	btisc4U8kmcECW1FmOk+iwFZXQw3D2w==
X-Received: by 2002:a05:620a:40c2:b0:949:5db7:b32a with SMTP id af79cd13be357-949ba9be85fmr1561480885a.43.1795362914014;
        Sun, 22 Nov 2026 07:55:14 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb3c2abesm622434985a.26.2026.11.22.07.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 07:55:13 -0800 (PST)
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
Subject: Re: [PATCH 1/7] mm/vma: error out on invalid bounds in
 unmapped_area_topdown()
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
In-Reply-To: <20261121-some-more-ai-fixes-v1-1-236e925d9b64@kernel.org>
References: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org>
 <20261121-some-more-ai-fixes-v1-1-236e925d9b64@kernel.org>
Date: Sun, 22 Nov 2026 10:55:12 -0500
Message-Id: <179536291280.412063.6169498898856535364.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-21 16:02 +0000, Lorenzo Stoakes (ARM) wrote:
> unmapped_area_topdown() suffers from a class of bug arising from a mismatch
> between how maple tree functions and VMA iterator functions express ranges
> - the former inclusively, the latter exclusively.
> 
> This is problematic with an exclusive upper bound of 0, as it translates
> to an inclusive upper bound of ULONG_MAX, that is a range which extends to
> the end of the address space, and start < end or equivalent comparisons
> evaluate false in a situation where in fact the expression should evaluate
> true.
> 
> unmapped_area_topdown() calls vma_iter_area_highest() to position the VMA
> iterator into the next highest empty range spanning [low_limit,
> high_limit), iteratively reducing high_limit without checking whether it
> has reached 0.
> 
> This can result in a [low_limit, 0) pair being passed to
> vma_iter_area_highest() and thus unexpected underflow. Consider:
> 
>     vm_start        = 0x30000
>     stack_guard_gap = 0x100000
>     info->length    = 0x1000
>     high_limit      = vm_start_gap() = 0
>     high_limit - 1  = ULONG_MAX
>     window          = [low_limit, ULONG_MAX]
>     vma_iter_end()  = ULONG_MAX + 1 = 0
>     gap             = 0 - info->length = 0xfffffffffffff000
> 
> The result is page aligned and below the IS_ERR_VALUE() range, so it
> does not look like an error. What follows depends on the caller:
> 
>  - mmap() with no hint can fail with -ENOMEM while space is free. The
>    bottom-up fallback is skipped, and __get_unmapped_area() refuses the
>    address as above TASK_SIZE.
>  - On x86-64, find_nearest_trampoline() can pick the address for the
>    uprobe trampoline. _install_special_mapping() then inserts a VMA
>    whose vm_end is 0, and exit_mmap() frees kernel page tables that
>    every mm shares.
>  - On powerpc64 with the hash MMU, slice_get_unmapped_area() can pass
>    the address to alloc_extended_context(), which then writes out of
>    bounds of mm->context.extended_id[].
> 
> mmap() can succeed with an address from the wrapped window where the
> range above TASK_SIZE is too short for the request and its alignment
> padding. On s390 that range is one page, so this takes no more than the
> default stack_guard_gap.
> 
> Fix the issue by converting the loop into one that explicitly tests
> low_limit < high_limit.
> 
> Additionally, simplify the logic by declaring the VMA iterator in the
> loop (it is reset on each iteration anyway) and exiting with the correct
> output value on success rather than performing a goto when an iteration is
> required.
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 58c5d0d6d522 ("mm/mmap: regression fix for unmapped_area{_topdown}")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

