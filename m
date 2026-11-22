Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795370591;
	b=OdsS4NnS/w9Ew9XQUzAAnbbRh402uTO6itKPJ31P8Xu14XxaQl1V+WlIOw7bsHEVOlLs
	 dR59rtOUHTiwCcTdp07b6QTFfknuRtm39J+JewukXAvomr3k2KQvIeIRTrC2cPak27PyL
	 AzWr36/YkiYQwF19VTNsdX3gzCFKqe3rPbvDAOPhK869q8ZNLq1ue9XPwJ6vQZyp43zHx
	 OvMEJOGiD8mY/601dRQ6aqxBQOe3FdBTYV3I1Xfar8wbWA58oi0CK2KQTlPSrj43lX74y
	 0sLn5Pa/rk2dfn27IaC/Y9BJGiGCkjXrtu5P6d8pawAtyJxbOAoo/s5nwkaKf1zsOLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795370591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=EWsKXAM/g+dJIEPiarpqPbtvlz+whrT4/Vo/Gurv3ys=;
	b=OeShscqn/4D1fRDYbAThwb2fKsRVdGGdHguvx7uDdMnw4ljOeEHpRm3cnomv4lXZGF5R
	 tmkFpSXd+u4ax7OoxpPhT4h08z0C/KbLWo+EPWshGZxY3pC+onTxu7vHH1v34uPeZBaFx
	 DGlsfMbKOcAtgQixidCteB/+TvyDbuEZr+6S7JZJyQrXSnJx8m188b1ab/E78VXFxsZKM
	 0YcMNNTntFkNfVpmavHGhzJwxJz/k/4YeorqQgW9/VM+Wb7v5tiPzVE14+UN/tzFESKKz
	 iz0B+4mOnDf713bb2jPsnukHYTi3feiYr+9ZsmUJ5+iPUjuYolX1nqkaimMDBptX2fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N9xoI5mK;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD6C606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 18:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CD6C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N9xoI5mK
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-497614c95f0so1429187f8f.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 10:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795370589; x=1795975389; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EWsKXAM/g+dJIEPiarpqPbtvlz+whrT4/Vo/Gurv3ys=;
        b=N9xoI5mKWIDtHAeZ7FtRl/tOVrHICnWj2a4AR1+6j3HIpL/rqwMJI12lft2TdSuKG3
         rK9CLk8RJ70Jf60yNRqxkdAd49pitLEY6XTmP3WYvwDKAlvgWtAGCAY/HsJnXSvnZceg
         kozMmINspd5SaZ63Q0z3S4X4eRpN7C0aL79szRisnA88p+6n5Zu/Z+Zmx5UD7OA8wYoh
         BDZ5o4kItypO5lqpWJP6xkVegRi4obe1YmUwmUlkPOgNpEQijvfg/aOc98/ViivN/ugo
         Rg7+afXmLl0kl3BEespNbfaUdGUU2+6zy1e8dwALF1/VRAXHvn5WmG7e0MZBEmxCL4DZ
         Y9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795370589; x=1795975389;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EWsKXAM/g+dJIEPiarpqPbtvlz+whrT4/Vo/Gurv3ys=;
        b=cHW5gFy+7ExTnjSUE0GJ62CucAjMuwSt8CJbk3EM9LBjChLYBbM0ocooYXKyvnEQv6
         RkSRzUIcIphh4alXFon+FJ3Cd15xfciFkfw4LZi8XMyf13ABdxL5asb7U5e/vEhCdheD
         XDw9i/5EvJTgPhB1esvKv8ZF9/Sg1YTz90zw0410grJlNt7mnHqEfDOH9yg5tuQNOBWI
         gkYHpJen9LECdg1NTcJj3oMUOpU0s8HxkVzE+XSIvXfEMTFKyiQinz9h7pT8F0G30wWF
         CpPehg2buGeB+dsHn8eYk2gIit2PN4e317jGTjSfxfO2R8Ic7WQ4SS/t/l8vA+7N1Sgo
         Olzw==
X-Forwarded-Encrypted: i=1; AL+hErE9Lsk43PLtLN+5NC2YvxkPCd+C2xSNYyy3Zxjf+8z/OedhvfQNtuWltZp9G6jl0Cd+TULX7EE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+czExjBP1L+adgestZum236W1zQyker3y4CeMp09WMrKgbWi0s
	xCPlByRI+cqjz5ZVy2v80Z71JfM8s8jmlhfZLq7bNKRyOOAogbYZujGl
X-Gm-Gg: AZFdTZezgqqgSqayvSM4pEYQx9FQwLPPNLP+duior4UxBCxOuJgLseS4qfLH+srbC6I
	9gBP7OqoqQX2DAommnw6wI7FDZ7Crl8N1jHvpjSr+jfH+qENmgASCyFpGLQS+2x98mDW4laAdJ5
	bQ9ULfqsKXZfsxWPQoVoBGGHlP4tbrRYqyRUMhkJuz4xfHGx4fhYj2HNwbGsZEpasohmHi0LXmM
	MoadSdpJPF5oy60XBM6Gr/NDY6Q8CXdnSlAFi+s8K+eTmMkc6PbzjQrWIKFrEkMNYvuixQ0aqVb
	Kb1Nsyel+L6bJghODlQ9DrfKp6JckTaN6AxP59HBSc5kEtXCxINbTPL3mvUpqEn8+BsF3vbvGo2
	L3Hthl7eSbbNWtyOBb50Bt20MWzp0r32zMiOvWUb1fCBALc4KKnm0+vS3nOw+GoC65ecHPZskoZ
	y6G2sIngFAWgRI6Id6xjnz5L/386dzw9sx+4FKE8TLgqXbKutzR1dwMwtyitWWRZDteiEIxXDw2
	A/eVaow+vDOmBUASYy2B3fuosZ4LLDwTSxbb4ntLkANcos3y3fc3tLBfWkZ/d1aMM/gsSOy7rT/
	zTRJrUcCjdi1x6QTDmVjbz6o
X-Received: by 2002:a05:600c:4e0d:b0:4bb:69b2:d3b3 with SMTP id 5b1f17b1804b1-4bb8881eea5mr202859665e9.27.1795370589422;
        Sun, 22 Nov 2026 10:03:09 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb9067846esm139868215e9.4.2026.11.22.10.03.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 10:03:08 -0800 (PST)
Message-ID: <725b9135-2e01-44c0-b30f-dab16d3932cc@gmail.com>
Date: Sun, 22 Nov 2026 19:03:06 +0100
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
Subject: Re: [PATCH 1/7] mm/vma: error out on invalid bounds in
 unmapped_area_topdown()
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>,
 David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Kees Cook
 <kees@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Ollie Wild <aaw@google.com>, Adrian Bunk <bunk@stusta.de>,
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>,
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Joey Gouly <joey.gouly@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org, Chris Mason <mason@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
References: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org>
 <20261121-some-more-ai-fixes-v1-1-236e925d9b64@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261121-some-more-ai-fixes-v1-1-236e925d9b64@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/26 5:02 PM, Lorenzo Stoakes (ARM) wrote:
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

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
