Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795370600;
	b=5Kf5HJvSAnMriel+2YSrNyZCQdj0dDC03EI3hXrLVvX4JeCog+BBdL0fLkNVoQItqf+S
	 lBHyv5hjK3pycs8ZWX19KsBovBT8HIM2bBnJsW9Y0JI8dQhgsO6irZT5hihZOilfoTNLh
	 dp7oLe6nUqi8JoYdw9fcCW5NfejF6fvVBeyizv5LO483iPXH+sxc1vAITCk1DVJ34YKsx
	 HkD6D7PmWCMida+8aHcVWE6dcL7+sIkNvqNMs6usr5+lrVQ1C1H+2gqg1oBq/ODsApnUO
	 bXsA6MDSzOu+5xJZA+CjxqRrz7LmvlahYXKrvmwIZQeAbasfMIattHeZWQIK3Nk/D1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795370600;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=rqLv/9YNKuSPNEbPU4wgT4+9l+6I6n4mJ71J8IObdYo=;
	b=oha9l5Xf5iH0UoU0FQRoY/3XV9i8POkNM9h0ZA53r+Hnb0jSgWwX07EbcvfQFPD4+v9W
	 kCZBzjhaLOIXcMLxkfNBTPnHK4tuvRTkePmdmZuDDtAYsKjySnIn6aSi035iWu2d0X/K2
	 RrzQTd2q7x4p5TXQC9hEkQKhngnwnz7YRg6KtUDi8MjARYxWkQRgmoWYfbLw5vhbYZKGM
	 xxac3VRQa7E3TEzTtzIp8VEA4cF40izYjcCei1CRw4vQkvz/R0TVUcV7A4H2zqTHdDCs5
	 9QxcTSCyB5A3R1uj5JJWgi9asuMzHgWiFeijdJjLPm+TlhOC9QVsnGceug8MAk2cswQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ohBus0oa;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C085F606A32A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 18:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C085F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ohBus0oa
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so30789085e9.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 10:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795370598; x=1795975398; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rqLv/9YNKuSPNEbPU4wgT4+9l+6I6n4mJ71J8IObdYo=;
        b=ohBus0oaZinCBCwVJ0D0RA2u4BUN7phsvekjORYrjjy1bfOOfW6WT2YUgmxSU4AhqC
         7Kzwzi9mb8XRAdiFK2rdzWqa2xJxhFS1v0m5pvo5AXiw5X5ei39CqZtqIlCixpWx3brb
         XXMiP3+dNCKt0TD0taQ/Riu7S2tOQhHCK++Yu2MFprO4altgDsaKTMgeOMEmC+GKsA6d
         t8YONzcKVOXwK8RRq7rSaauYoH+cqgUlW7/BGRbQ/c2MCBQqPvgHf/NkEZBVuJKMfu85
         xDhDdGaMlS9V42jZuM6cre0cQYqyk6k+9xF8ZL1/YLPif7QW8yiA/tcLRiyk5rdgLqfW
         mv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795370598; x=1795975398;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rqLv/9YNKuSPNEbPU4wgT4+9l+6I6n4mJ71J8IObdYo=;
        b=cIAIuL317dTP0a45/BWjIfaKXEXz5y/G8aL5hIQMPBw4+Qnp/AOYZo0vLguynMTYb2
         2bGaRFAw16AHvUO/M3utRgIbhNGqhbypyhAdzv79leoakCEhynUA7ZUJRsQnKONk9vpS
         bCiVmh/7L+FNbFrSaMEASKdcweK63LKr0qTZybQ7lecUbvhzleIqSRJp8tTVU5toZqQR
         qDEAsZ+lKANKaRlgjqQbgWxo2TkE6LyIWvN6oxXNkM4W7BYaV7+xrMqaV6GtDXDZkanu
         ifa6R72rT1bjK4u38Puz3YOtZ3hsumMZvNm0aowhCINv7buIYW/NMDjnWaLUt2Snz0DG
         4wqg==
X-Forwarded-Encrypted: i=1; AL+hErHKHByax/JNW5dqlBeWdpymgEyUVRdqbcCI01jneld0LiIRDic9Qftjcmhohg8WYBB5O3mzK5w=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Rmm2q/Jnc/FnrlwRLmeq37/1DR+YBUezU083Oe2oxswTFz3TM
	yygR5f3F1rZhaOxLWqPHbIqu0Zbjxg9rbhLcyT3UbT5RcBk1kFvvwp9U
X-Gm-Gg: AZFdTZf6tQCdrV0WjGmeDSB+qZKzt3c/DBWQQOTpTj9SqXaC7iJEwYlTXLhgXBSzKf3
	1jrN9E+lfSziLELfS9gMOlZUGGdGIbDv51yXkA5QylQZ0Pj7YmbmPfv2azxDhIgUX/CCRxnYbkD
	8g2Ca7H/MRWzdHl6soQfRewq0345R8aboMILU4gMp2bqUXWiTtQE3OcaMyvy7puoaS+nerw3pcr
	bX9v7IFOMeXJGYOqIcLoUQffBKAb4zpuMMAO/iLHInhDQgZnUvxwKrJY6Dot8ujR4C2uG2r5pmv
	AiGxKlIQuBsJAazJ8xoDxKZ6hSrR80cq/qQTp5brMnYV1J1VAn7DyAJvn4VWToOPL5mFLHPWBEV
	m1lEH72UvzL6ZxRUvK7ZgLt1pcebTtgUFEeEXKxiD/E4uwU4mc+lNcnGf7330Xb/fq5FRGQb33y
	sAGlk4UzNwGo+J94uONV5zSBmAX5XAO3pFDIwrC/A4xnkPT1+vabeFqHvbGD3Uj3SHZXVfZM2uI
	h063D1pbIKctqmJe9PJhtLx+JnlIFbB/BtulBguwhf4mnmT5L1TVbLC8idqaE8Xwio70ikKAzX9
	5fl1KXTJreuk5sj6QLdGDtg0
X-Received: by 2002:a05:600c:1d09:b0:4bb:66fd:ad68 with SMTP id 5b1f17b1804b1-4bb888160cdmr206483615e9.14.1795370598069;
        Sun, 22 Nov 2026 10:03:18 -0800 (PST)
Received: from [192.168.1.22] ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884b7515sm383064735e9.13.2026.11.22.10.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Nov 2026 10:03:17 -0800 (PST)
Message-ID: <eca89988-bf36-4d41-996c-1d945be4faf1@gmail.com>
Date: Sun, 22 Nov 2026 19:03:15 +0100
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
Subject: Re: [PATCH 2/7] mm/vma: lock VMAs before taking mm_all_locks_mutex
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
 <20261121-some-more-ai-fixes-v1-2-236e925d9b64@kernel.org>
Content-Language: en-US
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
In-Reply-To: <20261121-some-more-ai-fixes-v1-2-236e925d9b64@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/26 5:02 PM, Lorenzo Stoakes (ARM) wrote:
> If an mmu notifier is registered for an mm while one of its page faults
> sleeps indefinitely under the VMA lock, the registration of mmu
> notifiers for every other mm can hang un-killably.
> 
> mm_all_locks_mutex is shared by all mms, so its holder must not wait for
> something that has no bound.
> 
> However, mm_take_all_locks() calls vma_start_write() on each VMA with the
> mutex held, and thus waits for the readers of the VMA.
> 
> Since commit 4ed4379881aa ("mm: handle shared faults under the VMA lock"),
> such a reader can sleep in ->page_mkwrite().
> 
> Consider fuse_page_mkwrite(), which sleeps until the FUSE server replies to
> a write request:
> 
>     mm A, thread 1          mm A, thread 2         mm B
>     ==============          ==============         ====
>     lock_vma_under_rcu()
>     fuse_page_mkwrite()
>       folio_wait_writeback()
>                             mm_take_all_locks()
>                               mutex_lock()
>                               vma_start_write()
>                                                    mm_take_all_locks()
>                                                      mutex_lock()
> 
> Fix the issue by locking the VMAs before the mutex is taken.
> 
> Additionally, make the VMA write lock killable so a fatal signal returns as
> quickly as possible.
> 
> Finally, update the comments to reflect the change, dropping the lock
> ordering list which begs for bitrot.
> 
> Note that the lock order at the top of mm/rmap.c doesn't appear to be right
> - the hugetlb locks are taken after the VMA write locks. However, this was
> already the case, and can be addressed in a follow-up in any case.
> 
> Target commit 4ed4379881aa ("mm: handle shared faults under the VMA lock")
> as this is where it became possible for VMA lock readers to sleep in
> ->page_mkwrite().
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 4ed4379881aa ("mm: handle shared faults under the VMA lock")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

LGTM:

Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

-- 
cheers,
jose a. p-a
