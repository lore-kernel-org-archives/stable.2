Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0678B4CF499
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 08:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792313311; cv=none; b=V1aWV+0LEdm07r2GAecQ5OK4yXwJbN/+vvrJGi7r1HVvjtJDUDLcztwcQv/QXcUW/ajc8Fw+wmmIaNnU6K+39sNBLwFIaXkKZ1Qm5Ehw3TMtH0bUJ8My68eGSoo7MGdOLHrONsCsPVag7J6PsItd/gImfFAXKvxyrax//Adx8WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792313311; c=relaxed/simple;
	bh=CEOmBKRPRHQvggQ/jUprVScYeABN6UGtUJElxmkh6EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dSxhXMuaRgVAKHjZ3FDkqREqPkpTQFzgi0zOfe9DeMa/04yk3KmvQ+Ttp/KtEpmOzjDZ8uONa0RPOAJ1giASb/+c7Z1+wzKv+gtZMkeuDqvgYFOZZWErNxLbfskkuYUb1Dqtf33P7mcGUNubQIZBM0n1BqugJ+X8v3SSQddZaLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoiJqLSx; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoiJqLSx"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a1dede3c2cso9533845e9.2
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 01:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792313308; x=1792918108; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KN/6iLwfCQ//2avSJv9DQ5CIOHPByLS1SPM2UhK/GmE=;
        b=SoiJqLSxbWoLMSHRYyr2a0L/DpzmLUkhnrTTvmUTMK7uDoHbFHeafunDUH7F88Jv1j
         J7YtCICj9D5Nt3BTbd2qtP4HU6ow8BT65/9mYRK4U8EvUoEr8pqgEMml1tALfGEFVbHe
         u+TKcLqst+vGjmdiqA2Ib1QPuFZ/+N5X1UfZJFKUrIHgumoQfmyHW0DwMR9bpAxHrSBe
         SEaZHNUOx7A2DEnyMCBNOz42YtYa4y1e0vnjLu8mZt9RpyurTmkAC+jk5QAR4muPwTDF
         gZM6PkRf+BBlLxIdFbX41nJ1HeIftWnDp88wMHUGTa+j8wIBzTMrv8bCIj0WnrKxiKxX
         IrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792313308; x=1792918108;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KN/6iLwfCQ//2avSJv9DQ5CIOHPByLS1SPM2UhK/GmE=;
        b=BbGMt/8AEBeGAZbxdR4L8YmHdLkdUdqeaYs8yIPYg3hn5dtzzsISWotrTadsfE/1xP
         ONYowz285m7dWgJgN9qb2+TrbEJUxll8AHgBgwEK6J2coG3GhdIOrZMz++NPVG9cc5JF
         OggWmEFBJQp87Uy/yPl3RyyYqxw0kyP8YwxkvAOudkx+TJ+DiGiwHPFKozFgg3Z6BMO+
         dJG5c4vGmMEa8+Mb35tKqrL8HTyQdKG+6wpB8vVEnslAxC/2xbg0vQBv7ac0c3/aUCte
         VAQ9xfgSwAhNRyi7sdxW0o7uPtaKmnZOAOB/zR7MxjtTzLOlUKG46JjAe2YYFaFLfb5r
         T7Pw==
X-Forwarded-Encrypted: i=1; AKwUvBw1V97TaIoqls2ZxnFUb1U1oA5hql0YuFnp6yuWaZJtQbGXux7fsM6S+JM6d2YY6+DRQBiRIXs=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1N4OqP+pHBB+rcBe1m3pAF1+A0yOLOCSIFfssftOjXt5rf+Og
	89x3Ee3wp8EXE3Wys1kUhAQC13jRoOkiqF2Q8HFz91VVFwhKlB0GTJIy
X-Gm-Gg: AYBFou2i4XmoU4f28UF0kTtayQb5lXnyXga3EtgYZIscwH6VuMIZly9E2cXHUjHXSH6
	jRmpEZwyqplFACq0NY8O5r42+o1qRV0nwbnVcCoEChW4D379BHRs59rieGBUMgrY2gGP3hrTDHm
	sAhPVIkvvEzhXHG2Y2Gf7CTcZ/MwR7cCmT7/eq7h3hHgRLgQLNe+5KkHJQAIOUuPoMw6ynik9jx
	1oSvhXP/5K/UAzyHRfrclCEzf9lWVrm22fsspAUbx9WAaWmwGH5nenXN/Lk4qf6IPZgizb8gXom
	ZC9F00XxFjAw31DajfBmi7co4KDk98Rf7sVXXRruDW/WksQT0YT/spWxKzJcWpRphVi2FFRoTIB
	lND87gOK+FxOSlp0iVwdp54MhGJNgvlSgfdIVzTGn4owdsnNnpk+zIb4hGIsK7Kjw/ufltl6kXC
	Sx/nnYw6+iPS5krr9vdvG/ZlkfeUC4cC5BKzReHhVQJBDQQXaq4DND6853nfUYyTz6PJM=
X-Received: by 2002:a05:600d:8643:10b0:4a1:e00b:a10b with SMTP id 5b1f17b1804b1-4a1e00ba2fdmr28805675e9.7.1792313307895;
        Sun, 18 Oct 2026 01:48:27 -0700 (PDT)
Received: from [192.168.1.18] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c10fe9d3sm248499795e9.13.2026.10.18.01.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 01:48:27 -0700 (PDT)
Message-ID: <6b17c6a5-5164-402f-8d97-2b25f4f9ae8d@gmail.com>
Date: Sun, 18 Oct 2026 10:48:25 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] kasan: fix runtime shadow page table synchronization
To: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Dan Williams
 <djbw@kernel.org>, linux-mm@kvack.org, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, muchun.song@linux.dev
References: <20261018043501.3257632-1-songmuchun@bytedance.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261018043501.3257632-1-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/26 6:35 AM, Muchun Song wrote:
> -		if (IS_ALIGNED(addr, PMD_SIZE) && end - addr >= PMD_SIZE) {
> +		if (IS_ALIGNED(addr, PMD_SIZE) && end - addr >= PMD_SIZE &&
> +		    pmd_none(*pmd)) {
>  			pmd_populate_kernel(&init_mm, pmd,
>  					lm_alias(kasan_early_shadow_pte));

what if the entry already points at the early shadow table? this walks
down into it then, which loongarch does on every boot.

[snip]

> -		zero_pmd_populate(pud, addr, next);
> +		ret = zero_pmd_populate(pud, addr, next, mask);
> +		if (ret)
> +			return ret;

isn't this a separate fix? it's not in the changelog.

[snip]

>  		if (kasan_pud_table(*p4d)) {
> +			if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)
> +				continue;
> +

doesn't this leave the range on the zero shadow, which memory onlined
there later then keeps? would always allocating a table at the synced
level once slab is up avoid that?

-- 
cheers,
jose a. p-a
