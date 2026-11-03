Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702559;
	b=s7FOo7HlyygXVnFjylDI3lNVgRlfI9F3a327gbHYrt0JbO+HtMh0xoVRLLbVfPjj+tgg
	 07u9YO9AHngfRklvrKIjtiobjoJiZCOyKlchPG/tFu0IO+WotYjdam8IBDD+tHsBv6/Ny
	 YMOzVXcr446QiA33Yz/FDTB0QqZH1nXyeKU2XMksKVbOzid9vZWsfwGkGsuxgSEoPh7m4
	 ga5uQxcANG9+c2ZDEVdZx7bN4152CkBGJM6unJDqc8ZMxBsz3/qXEqRY3Wh6ccXQEy9X3
	 xjDJKIG1EqVDxU7sXVs73g7iKrO1IL7X8fc7CEmaBJDvBjjY/CwdS/BOPg2Yeb4Cyvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702559;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=jF+dmpn8iQMH78dTHJ5iTki9ohaDdksNiAWtPrpropo=;
	b=ls5GO26YujEn9iREGVEhtK333edWCC9rlUsDyh1ShJhPTjAHY76PQ5gLfnW21DGV2P5S
	 HpMgGtuDs/DlYHWFfXDPjDpIpTLU5vYbASso2RcktqRowvrIhlK40GZnGlowvYe5zHJ0G
	 pqU66ivTzHbDBFpkJFNBxqkBOUN6eI/I+wQ+LBa238gu648uiCbGOou1AGUzsDsaf4txd
	 HXgejS1eL/DmddgjBZUKiEvBG0cNpxiiR2hwBwi92vhthMLhRX2tDf7u1QcsPmiWoCppz
	 RR2o7QIyS/dM4TZA99jmKAUUCmyoVDt6VlYeTJs0Tx+6K1yQBF4VHV2c4FfHF2JmnyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i863nRVA;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2709E606D816
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2709E606D816
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=i863nRVA
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48e6eb21a8fso1615798f8f.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 02:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793702557; x=1794307357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jF+dmpn8iQMH78dTHJ5iTki9ohaDdksNiAWtPrpropo=;
        b=i863nRVAHbZEd3/l2aPVaffTCtrUCNJfflaJF2AJVsWUnzszEuP37uqBENGK6IvKCw
         okhqOOT8eg9jTy0LRE+nSw+QHOry9MmgTi72c3KhAOc28gq3BfuSdYgyZb7ZGQKAcwUU
         8JPjkloZBgNQpcNakS8umCeP+jgiuV9W1X7WE2sCYQJgvgBOY3jxA4tzwtlmjtJpaMEz
         60Q3m+Vsl6BoMLNLQQ2XUL96jC6/NQjIlaYI7rcN2PoQsYpNdEdnAXN+S3HN5JwyBmaW
         Hii5xV2KK5LE8fPdpjcV4dJ0JIvVgWy6sz4lKI2WHuBpmOmAYjNi7U77o/6LWCVitMGx
         SkQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793702557; x=1794307357;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jF+dmpn8iQMH78dTHJ5iTki9ohaDdksNiAWtPrpropo=;
        b=NCnPzRXV9Tl3x3GXNQ4xQX5lx9Gp0I1Brr8YgWPyW5dW9NlXIsIhjMDcYAn8tSwPL8
         58Z/8PIX230UBCnT85CfS4z2/naW5cfsNPrFBcP6JZbO0JHY3cRp+/jmn9nTdDj+fwaq
         zH+Rytko43pjBlhzT1bizN1PCkccRMJA5FFS4YRQDSDuJEKeZLRWB6ZnsIrZWagJhGBU
         ETM2tirlGqdYnvyQ9q6Sa5TXLMlMmuneyewqwPzoCI08fEJGvWDjkyhA473pF+siHDUf
         Z9owEtTE1pW1nMKqqo57/CggwUfQG69i0XAxQotX1YB12ztF5Ky8Gd1KACHDopZDnGPz
         CHrA==
X-Forwarded-Encrypted: i=1; AKwUvBw2bv8XwzCCeYSlwsNhAke63ULkDMMIbotQCo46G/7v9cE2m80W+cN1HgqXtU7+gGqxhu5tfjI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SYKl7tHevCdEn0jUQuR2iJmdHlT8GLo+/UNoF2DqF+Ks4XdhG
	rakxNw3e4mHDS2t+e8HVoO8jfHtU4pFgcYxjLeDC1XLc0GUAyLD8Io1Z
X-Gm-Gg: AYBFou3pSotsxGES+Sh46oyS0C0Xz91iPdxj/9YBMxu4+X0zoRJfNzlzH7g/kQAz7PK
	9m2ITQ1Kk3ZNCFq+7I2bnCgOl2DTrN8qK+EY6nd/vLUSrScowNd+QOUdqdEHsyF0XEiMYx5pr1Q
	mB5MnBCERpRdqxQJb3YkZerD9pmNMOYIKn4W4FlzZXf/l2ea6o9kNypPHlZZXpUZt5HdODvzi3s
	rRawiS5CPbxupoHrlRzE63ytOMYmmupRK+2aQhLPY0FvGoy4bymZmmCIIRyXk9bZjNjFmACQ4qk
	afCVVm4tyfZ++KsCRAuOkg6o+sKb0sy/vIsGK/C1Lb4cl+xqaN7KqgH+ixnQ8b2Y9OrKsDvkn1C
	H1sgkRMKHpPfdK0n2ZT1FVOBwpWlRBq2IrivbEtZc8aQ+3coJgx+HViQFZrC+BSyrLivFr24AEx
	lmJ9+C20Jblt3DiDQ3bYzvw+VJFoJC1ujxsNz9E8yABFIndazXFom8KDT3nvCVj8h7jCk01X/9W
	7Y8gdMiB4dEzZcRuvYfclhi+47quTwSUbwsYEB0rHqBguhOyd0KFsCsqplC1WB3BigWlYlWoV/C
	P88wGSz4vvBbZ9khIrdhLmSwCBpbo6uy50qXcDGfGl3O
X-Received: by 2002:a05:600c:871a:b0:4a7:d9b1:b684 with SMTP id 5b1f17b1804b1-4ac14ec7947mr293082145e9.2.1793702557391;
        Tue, 03 Nov 2026 02:42:37 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2ab00ff3dsm94074165e9.14.2026.11.03.02.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 02:42:36 -0800 (PST)
Message-ID: <0fdec467-55b0-4354-8bd6-58874c2c20e5@gmail.com>
Date: Tue, 3 Nov 2026 11:42:34 +0100
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
Subject: Re: [PATCH v2 1/5] mm/mremap: fix hugetlb reservation leak on partial
 move
To: Josef Bacik <josef@toxicpanda.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, David Hildenbrand <david@kernel.org>
Cc: Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
 stable@vger.kernel.org
References: <20261102-b4-mremap-pre-split-v2-0-d281dd11ad7d@toxicpanda.com>
 <20261102-b4-mremap-pre-split-v2-1-d281dd11ad7d@toxicpanda.com>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261102-b4-mremap-pre-split-v2-1-d281dd11ad7d@toxicpanda.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/26 12:45 AM, Josef Bacik wrote:
> Moving a part of a private hugetlb mapping with mremap() leaks the huge
> page reservations of the parts that stay. They are not returned when the
> mapping is unmapped, when the process exits or when the pool is resized.
> 
> fixup_hugetlb_reservations() takes the reservation map away from the old
> VMA while that VMA still spans its whole range, because the moved part is
> only split off by the unmap at the end of the move. hugetlb_vm_op_close()
> then finds no map in the parts that remain and returns nothing for them:
> 
>     mmap() of 4 pages, MAP_PRIVATE | MAP_HUGETLB    HugePages_Rsvd: 4
>     mremap() of the second page to a new address    HugePages_Rsvd: 4
>     munmap() of all of it                           HugePages_Rsvd: 3
> 
> The source is unmapped in this case, so the number of VMAs ends up where it
> did before and the check against sysctl_max_map_count stays as it is.
> 
> Fix by splitting a hugetlb VMA in prep_move_vma() before a part of it is
> moved, as commit 597e4b9ab48a ("mm/mremap: fix locked_vm leak by splitting
> VMA for MREMAP_DONTUNMAP") does for an mlock()'d VMA. A backport needs that
> commit, which is tagged for stable itself.
> 
> Fixes: 550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage backed vma")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> 
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
