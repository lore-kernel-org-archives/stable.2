Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792440809;
	b=r/1V3ssJIy6mOI59TX1Hy0BuX6D2xbg05zaLwISO3x+rA0t32sZ4nskUE8viYFBMEjhs
	 ScQcvd0g0CFrSua8zo57DS/cAMgeymIeWzsXppkje3UlxmezaZp1I+L/FlmW+JhQlyopV
	 dwtkua8YDW7KCCx8J9051gipYleC/4auY41MfEvdV9E7bU+wECgXr5kHl6MqLW9ca+KTd
	 JgGzT5YF5PBzBT8Py5lJxoWzTEXqimPIEFkX6UEsBAwZOvlHDxPT3ffKjS5HtMUClIomo
	 NDoA8cUp7GtIBGyTAxdlZmhZ21edsB3RaGMr6a+DhFNslC1IuP2hN73CZd4I0Ni3L/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792440809;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=33VILW/iOz2Ho7n7DFsaPmdMpjSfqsU0e30Nc2GjpZ0=;
	b=5rkvnTIhPrT4u8/S7qp7XeMeK/Uj6L6GfODzlzbXnREONJMlE/E+IdeKJ5Bqtc7M4wJk
	 L42Na0D0tXuwQykUsioKMCqGrqi9xHH/cWzY+17/Ep3/r+/GKwDlSr+dInBX1CbBv+aKw
	 JU8ko+4bVOrwQ8iRsET5BBBeQ0ucwJGw4Uc89hPGcc0IEiFkJLZUK74yg2I7kY6jUgUq8
	 M9JrVFIy7i/WU/fsLli1fFP8RPpvijHl8aC4cD5nD7SR7Seev+h5t3xatjwRR0DQ03JkK
	 v2Z6LHZl/qVJQ52ZvJYpxRLYcaZZMKPU/C0LPDTa29f3p7HTlwAOEmUCKE9/+yNHAcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmpxchg.org;
	spf=pass smtp.mailfrom=cmpxchg.org;
	dkim=pass header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=Qw06nLbI;
	arc=none smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A17606A31D
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21A17606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cmpxchg.org header.i=@cmpxchg.org header.a=rsa-sha256 header.s=google header.b=Qw06nLbI
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b0d91601bdso296727b3.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 13:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1792440807; x=1793045607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=33VILW/iOz2Ho7n7DFsaPmdMpjSfqsU0e30Nc2GjpZ0=;
        b=Qw06nLbIl6vgcbPwBJNaM6cguWt+HvtAQKKN8jK+h3l3Tpxby7v/7B1zWmhf+sYXTQ
         quIXO+5TRQpqMi5nfR0qq2KQMZMg1D4Azg2seDePtoylhZOeqSzzs4eO9nryfv5mPFD4
         l7qkR/mmAG0Voijmtar/Yz9AJu3K/uHqoPzlNsYmKHctwaW5T9nGjw5zShcfWHJ2yG2w
         lMHbt1tYYGH7vc5jqT5j/hx5trBryn9+kMmDFhoLDNCYcOFdTm3wA4HdBsTm0O+T74XM
         FHZzGVX1QcPE9Ozg+XNpcPqTJgVonXNosaV3lOrkCn5Wykxs1aTlXXKNTWzSTzpzPXN/
         /Nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792440807; x=1793045607;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=33VILW/iOz2Ho7n7DFsaPmdMpjSfqsU0e30Nc2GjpZ0=;
        b=2W3SYmKroV/lfudMgSXcWBbmu+jErrBpcJrfE14jhXHGHrhxkhGZMJtHHLa/QAt5VA
         jC5XK6DjdU3cklLex7Lf2vSxPPPUKecC1rWZNsxElUByBJ9O+Tnmz9kDEoX1E3cCPYtp
         SB3u2yInjwRHJ+QB6sC2kntga3jLmiYF93nWLda/GzkKAbTfAfswpYzK/Yh2ZRaIrJmC
         +2BDzn1YMIVZrRziC9x+PJU9E6NGu3M8UEa85T72BeoW/q272+iXxQuRH7iWfAj6mD2+
         lo4Qu1AHlysJ/vVyXLzbgSi9eKIcgXNFJ6R1nfEkAC4k3/1QeGDsIuNDjLz0z/4gM3lm
         XBuw==
X-Forwarded-Encrypted: i=1; AKwUvBzPQFxYa81nWI50y9kVtC7iaFCOWDS2kFUORON0meUKaLMjyPfPF29tfqoor0FoMD0fFAQUXwk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJNTEv+IAllxHXLQCeCgb41NA2yjw9hoQj8bTW3zcjFFKhRa94x
	hnGvjiMab/FN+IkR3liZNnKlWqK1EoCD7kx6TMewdaYWUpWnE6v7AkwbHzipfjW4d24=
X-Gm-Gg: AYBFou3E+0KITdXUjZdVC4KDr6SPlxWfDubKxYWZfb2/kpehWGjxiHxIRM94YJ16A4X
	xW1emd6CsvKhaPBOakn9NsV600g8pdTYlcno6sn54c2YOWu3nlCkjqrccO1Z4raH4KOikzRfaqF
	4Jy+xB2eKc+ossiDA/c05Cqn2aQTQNeOJGU2R3z/9l9ABsSrZYFe20LeRLxtCdLoiCOuXJsH9wm
	zh7BO3Sud2GaOWye27J8UrZEx5DD44NkmQC6V9FgaGzBrNQJlMqz2fAglvlUOGJ/Xer0hhedbwr
	76GOQ3PLGDrEitn8jd9eo9ZQv0EynrkULR46Y2tHX+QkRfb6YzZOe0g3ayA4/z2sxS1ZizyQG51
	w2uwOD2BDA/YJ1B7HQqw4lX5EqrxNdz2+ke+Y1RF+4JkTjEDcXa2lHAPne2yvlpBooTWBelUKyn
	r/L5zY4krFbF+42zxp4JV+5WLBA8arCbdjsiDUJFVRI9cp+7nMU4Tcec/6wOwyiYfXaEC5sA==
X-Received: by 2002:a05:690c:4992:b0:8ac:e48c:4f97 with SMTP id 00721157ae682-8b1201bff9emr666537b3.24.1792440806814;
        Mon, 19 Oct 2026 13:13:26 -0700 (PDT)
Received: from localhost ([2605:8600:200:1d58:2ffc:79a5:7374:fa95])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b11b8117ebsm4601537b3.16.2026.10.19.13.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:13:25 -0700 (PDT)
Date: Mon, 19 Oct 2026 22:13:21 +0200
From: Johannes Weiner <hannes@cmpxchg.org>
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
	akpm@linux-foundation.org, vbabka@kernel.org, surenb@google.com,
	mhocko@suse.com, brendan.jackman@linux.dev, ziy@nvidia.com,
	flyinrm@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_alloc: let the highest memory node recover from
 hopeless state
Message-ID: <20261019201321.GJ371161@cmpxchg.org>
References: <20261019184850.3427905-1-gourry@gourry.net>
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
In-Reply-To: <20261019184850.3427905-1-gourry@gourry.net>

On Mon, Oct 19, 2026 at 02:48:50PM -0400, Gregory Price (Meta) wrote:
> free_frozen_page_commit() clears a hopeless node's kswapd failures once
> its zone recovers above the high watermark, but only if another memory
> node exists for allocations to fall back to.
> 
> The test `next_memory_node(nid) < MAX_NUMNODES` finds only memory nodes
> with a higher id. The highest-numbered memory node therefore never
> recovers on this path, and its kswapd stays disabled until reclaim on
> that node makes progress and balances it, or demotion is re-enabled.

This seems to be the express goal in the commit referenced by
Fixes:. Can you explain why this premise was wrong?

The patch in question also only added another re-wake event. It didn't
remove one. How can it be at fault for kswapd getting stuck?

> In many cases, direct reclaim many never fully run against a lower
> node (CXL/kmem), and that means its kswapd can end up full disabled
> in rare situations.
> 
> To reproduce, fill the highest memory node with bound, non-THP anonymous
> memory and no swap until kswapd gives up, then free it: /proc/zoneinfo
> keeps showing node_unreclaimable 1 for that node. A lower node recovers.

> Count the memory nodes instead. Adding first_memory_node != nid to the
> existing test would also work, but a count says directly what the check
> means: some other memory node exists.

I don't understand what "having more than one node in the system"
means for re-igniting kswapd on this one node.

Generally I don't understand what the heck we're trying to do with all
these patches against the hopeless state code. It shouldn't be that
hard, right?? If kswapd on a node failed for whatever reason, let it
sleep until direct reclaim makes forward progress, or other frees
(unmap, etc.) put the node back above the high watermarks (which means
enough of the unreclaimable pages were freed to justify a new wakeup
in the future to attempt reclaim against new pages).
