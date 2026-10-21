Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792562191;
	b=XbhFViz6a9Kf7s0qBG9z3nGWO1Gutv/x3AwsgzsU1JMFgNppt0OKlG16Ju7J5JxXeLhY
	 sIk1f9DVcgG3k4BiE18znqRI32mgXcNsseMuzfwPjJYswbDnb/+cSK0156fMRPjINKB/r
	 DWCF+GgrVoqDKYsOw9m1k+sD2elZf2JU+42K9LpWROUTzadCeIaiM8o5v0BmN8+jzGFx7
	 azcOVRnKVcJG07OB8BA2ZnvvPP1xS/6HiIrRudXFW8Qzs2JIaqK6Tf8LK220YukrWx94d
	 Sy+hlzwNjzjQowsEOPsDCgc0soPNLMa8GAiZJHIttvls6mWXicqvyfJi5UrHdsaK5bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792562191;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=noqW2q3tliwA7l9SCHRgFT9oXvb7LtEfC22fYjKJb5s=;
	b=jX2mjYvwxGOD4bhE1AwObJOVq97kJS2cnnd9Ia+cuZVIoEVR0cDkT6GUe1wDe9mVoq8C
	 i+QttXyOiHSaRxIW9nW3sz99Mf87YPE9FOYGsiUlFvb8qxtecXtx5ETVZWNxEG3AUdAU/
	 ryS4Q3Lj0L723qNDFezKLdchO5xdcyNzL/Ctf3tiX6+J6i3grKXaUdfnovYF/mm1h7Q9a
	 +7vJHc8BGBG+DAiK43eqhkLRVL0iA4GRELSs/lcEFIoHLFqwXn6tJ4mPF4oG4lpB/9bME
	 ZLj2m5j3gQpn9RwUZwdXFE1ZAwIqKholAMyrCsEbJzYyxcuqNmdb1I43MzVHlKL3czw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AJJ5oC4l;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223ED606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 05:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 223ED606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AJJ5oC4l
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1ec92f655so3229605e9.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 22:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792562189; x=1793166989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=noqW2q3tliwA7l9SCHRgFT9oXvb7LtEfC22fYjKJb5s=;
        b=AJJ5oC4l+oQX1jPDp2TgcWVDKF8b45qXEexORcvbFsxTDzXMeFiuE23WDV9pZ8ABT0
         XbP3B+qgAzYod6/rCUDuhPqp7ZHVLRlXwoVTxlCPOPor80zdQSCCmlv0PZUSVGe9/bu9
         8RQoM6CEq+TARtwScmODykboKTVGBUp1bGNfqdae6Pp60vLB6gsfEYxSnAF71rmJDcMG
         mxVuyRczeKYX3k76ul/ukzH6jhERI0eE4nqYeqCiLF5wU8z/AuuAq1E9vTBWB/sBSN0N
         1v/amZdNEczfHnxTNJZpOYTKdGpaQQSwwr6tjXKzobpX7qxJuYjmh1Aji9ljaRWno14O
         R1WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792562189; x=1793166989;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=noqW2q3tliwA7l9SCHRgFT9oXvb7LtEfC22fYjKJb5s=;
        b=gwJMuNX2qJ9wLjL8zMYyEe5EeIDxjIjx1caxYHgfkYzarFQgm5VPGEtolsj8y7DeHL
         yVLXJGbFT6wd8AIUXRfkPObFOyHPQrtOL0v3aLEdJgsZKhehbcN1qB45Cr40+y5z5EPv
         14HBPppMr9acEJKydiv0h8zkw8tJ7ogPrWRVzvY+Hdhiskmf7CUmmqDr662eBqp8SWOm
         93mAbkAJU6TatIt3GRQMlUgfcIlNAKUDUHLJvYIL1AxqP4QO/IABcSOykoKQfVLLb5U/
         L3/1LIHGFH02MSSvnW/nqkuf0d+QaXm2rbYOypr2M0oSFF6hencKFwMrqaIEY59vAToF
         bj5A==
X-Forwarded-Encrypted: i=1; AKwUvBwU1D5fiaF0ctRhKLTKXMb4FJLxrCKfSaWSdmQirzpSHY2wn42kQDRloihJgXAxUiBh8Zcyvh4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLohkge07fiRNir0OUOz8NowDd3YfdPZ+vYDbBEgCIBEp9O3nO9
	9vkLtbEboxreiC+iIaxU11AYqw2Uo9WgHm8stlOAABGLQZy8jSocJcex
X-Gm-Gg: AYBFou0lHZgGQ2cJmG6IqcqWtZZ4moX726hBTNRM4wwfx27kxBghrrJgLfl5AqRoqtA
	5yhOkCtUzyHM+yjUVCokyFU2/PkyHIys6VK3Go7NWH0L4E31tflT7WkGhxqiQeesMQNpOCaj7LH
	SmrVJLMtBuJbtSejKF0po2q/kVbBBlKE1bmMR9nPrT8WENCwfCycA2anF6kZ52iwz3aToJ8DZ8j
	186x8zW3n8nEN8QEceQ/qN6LvFFHn9HMIwD7QkJBj08lyzHJl35uzb6UBngulNCibCveQGxgTKW
	6WI+SRqE9ji7qB8aJ5GHViMZdLxQUIdpZEjgve/KSQlLfVOqqXWQm/jgaep0aUrvTG0ONwmCWlj
	4tTwtOMNXgjjAfIHYXpxL37g+Ivv9JCSJZZH6gYKvXbaSc+6mlETvioYAOmA2dbBtiRIlnZUI0D
	FEUaHaww9AqCS35VSpeepPDPxnXpSSkvHs9MKvia+hp3FSt4N8HWR4TAZaxERYt8pZMRjQsPbU5
	Si+m39RJMDaWJoXGYIVRaSpqX0MKhDMHETGw3eds9CHQZLSyBIZrUJ00ZjHAwr/V4OnJL3nYeuo
	IAEBRMBDY+Me1aLd7QqM9F0eq25LY64LVssleG05VUwMFXJa8yezrnRaCIxkcH7sjKTvHRwPmPf
	tc2sw5IIer3ZU3g==
X-Received: by 2002:a05:600d:864f:20b0:4a1:d49e:9ce with SMTP id 5b1f17b1804b1-4a1f4c4d55bmr73200075e9.2.1792562189221;
        Tue, 20 Oct 2026 22:56:29 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-095-117-105-001.95.117.pool.telefonica.de. [95.117.105.1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e25835b1dsm3374756f8f.40.2026.10.20.22.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 22:56:28 -0700 (PDT)
Date: Wed, 21 Oct 2026 07:55:55 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Alexei Starovoitov <ast@kernel.org>, 
	Alexander Duyck <alexanderduyck@fb.com>, David Hildenbrand <david@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: skip shuffling and reporting for no-lock
 frees
Message-ID: <athTqt0vljgHb8q-@gmail.com>
References: <20261005063515.6312-1-kmehltretter@gmail.com>
 <f5e7b114-2bda-49e3-974f-170211501203@kernel.org>
 <20261020110948.wv_yGAhQ@linutronix.de>
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
In-Reply-To: <20261020110948.wv_yGAhQ@linutronix.de>

On Tue, Oct 20, 2026 at 01:09:48PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-10-20 12:02:01 [+0200], Vlastimil Babka (SUSE) wrote:
> > > An instrumented PREEMPT_RT lockdep run forced a random-bit cache refill
> > > while calling free_pages_nolock() under a raw spinlock. The unpatched
> > > allocator reported:
> > > 
> > >     BUG: Invalid wait context
> > > 
> > > The attempted lock was batched_entropy_u64.lock in get_random_u64().
> > > Lockdep showed the raw test lock and zone->lock both held.
> > 
> > In slab we solved this by using prandom - commit a1e244a9f177 ("mm/slab: use
> > prandom if !allow_spin")
> > Could be better?
> 
> I hated it at first but now that I looked longer at it, it is not that
> bad.
> 

For v2 I can pass allow_spin to shuffle_pick_tail(), keep the cached
get_random_u64() path for ordinary frees and use per-CPU prandom for
FPI_NOLOCK.

For page reporting, the issue is NMI rather than raw spinlocks in
general. free_pages_nolock() may be called from NMI, while the reporting
path may queue delayed work. I would keep the FPI_NOLOCK check and add a
comment explaining it.

I will also put is_shuffle_order() first as suggested.

Karl
