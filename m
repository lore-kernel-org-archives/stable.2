Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793125921;
	b=uZj9KyP5x+R6BhsF3gsh2ZulmhigxgpFQIJRSoJ1aHBYE0kQ0jpPEBS+wVJh6F4+kr6E
	 mi18E/yzTB/xG5/2NEUGVbYhP5atgKhDVQcmehA8UHyq+uBD8fCyDV4t1Sl9BhQVv3n4K
	 GQ1ALO6hWE67eXmiUULjKz3fup1Xp+Xz1o42SUnTSjIQtY+ozwRaN8e38bfrWXwoFYdNU
	 RPMoA1dwqNqMNnPkNjslWBwNfJqMPCICpKNPqNs1+vpgw2ByErUnXy7bk0auglowebjh3
	 Chaj1bIc9TBK2xfibT//HAnwQIVXFz3cS2yBc4XDR8usHgpkTicRdB9PYqPUZJwj3gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793125921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=LVq6pbjr7FsFX3prA+jfg0dfmRTCJpqiA9RsFP438sw=;
	b=JkmZWkLM5byZOqTWn86eoYvLaiCQcQPBhxw/s6EtxhAEUmYRcO5paPDqPyxDVBm41uBs
	 auWX1EpBOqea8h2n3OxUte7fNaCn1/k3I1q/sPMJ/YP2OUBaOMDXOPDAqIH4myhuVD3kw
	 9tqa8LBCIK6OSVFzmq0K6WwZ9H603nLWU1myi66BBAO4fhi3TqHOWs+aygdVPDBv0YEPl
	 dgxB3RlHpwzD3OXnIxiePlD9HNWGa7tc/0s7nR0UAW43w0rmk00oj8ZiR5KQ99TCBQ/q1
	 jY3HHMK+/GeBxOkcbdL1FGcvv1mHwLCk5jzAzJNqSPohFS12tDY0kuGS1gKK/9pD04A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=lypTbGDv;
	arc=none smtp.remote-ip=209.85.217.41
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE96606A31D
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 18:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AE96606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=lypTbGDv
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7907f01e487so37815137.2
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 11:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793125919; x=1793730719; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LVq6pbjr7FsFX3prA+jfg0dfmRTCJpqiA9RsFP438sw=;
        b=lypTbGDv9HXoXDplC1h9HTmdWs3Ne+a1E1GEgcrBl/cUspHpD0qUZdu30mLxxu1Dod
         hbR++bOoVCAAsyA1Vj5k3obbQ2ShURlDQTHWf08loKzCV+gEjUVeHln4IVGLt6JsECXX
         lScDcvmNCNJl1HE1VPiOnEjoCtc+/0J57Ie1guszv1R+DG2dJdO1gcaC/I2W/RKrwV6a
         Gfq38J8lMRYiiHpST3lfY30EP+Fim99usn/e1OVDkFkb9Ak7/YnvEbbdr67pIufNLOVy
         /I2o6l+S469PWtxGxJM8UbYQ5fCj919Wh2d29Jefpp9jBh3bcFJb1hUcIWCOqf/Yxn2Z
         VNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793125919; x=1793730719;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LVq6pbjr7FsFX3prA+jfg0dfmRTCJpqiA9RsFP438sw=;
        b=jAohV3KUcKg+yOG/fGYgGeRWCje2JmEXE5S4mXnszQ4olLOHizcZck+OfzXC3MHbwF
         TwCEi75X/L9J6ZWt8KNNcNqtpN7kv/ECE/YP9ceF6+uEEOe4LP0jbCh8Cve3q3lHpKEe
         wCa0UmsYG3mnu/JZ28odi8+kCPAHeno9fJ8z+vK34lH/oV8LEs1RQRJte1sUoWQxwQQL
         wUJvg2kai2Ly7mdo/pzsXQq2/OMewsiPcwmdkkoDIl63c0nGr0q4FVeJBLN0XtBUthp2
         cxkJms2XeZqZjmKnc3Xc92iqDajfqVTCTkM3kb2KxsZWOY/IlkOjJbqvNFnM3G1QSRtw
         zHyA==
X-Forwarded-Encrypted: i=1; AKwUvBwQK/pMoCIDyPbJ2AqF6D56hrctKEP+W4MP2JIePPVhQGcnXiDibU4sSgFdNn1fcWW1HDRnWgM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIGmXF1uk1cdueOmk+NxSYP6vK/tCMTdUEhMgFfBUBszo3nWKYM
	uBsZDBkpP1HF+ZlauuF48sItL97JeHEZShmwtEBZdG3DKJRgPNMXTqkVLjJO23XDGMpiJDC5il9
	RXDtyJc0=
X-Gm-Gg: AYBFou2FsRAI/PqyuVPmbdXvU2Yl+EIKXWkiFUAAsARaH7YsvcwGGiLnNNeisUiyfVv
	93gEFpyg0JawXkY+fnd1wbVn54jmmpX6ropISpvclHm4EXJdDmvfRlJJQxmzAsh0fStJ0+rMnpb
	KiJFioQkkKNDRL/wfhyALf5Pc4e12sxGmEwgYhNVbOxZcP4V5uG2YWaYW4CnQbxI7AdE0ET4r4k
	me5/VupK/bJcSOiwVakxGw1PtiuNel6NDEqMclb3F/HPj4zGtPUU1jrpm5PV7WuiK+SJcaj43FQ
	QNJwkqLmt19sAaw76hI8IRTnW5yTVywkWMzwk04AMasgCJLnYqFNUmyUobzw3peMTLgNR1G2XOo
	332UuNnlFzsMz95+3/0Wt2iJjA8es8jue5S1c0r5bDdVg8KmC40fTt68zCj4zPrKm7t36vrZEFX
	4NAGkCU4Fzy7UfxYHn78H9e8e1R1TXQACLtJkyancHVj5WGJQhHKjh3eJ1UbeEbczsPuhyzIGPf
	LXRJxhX/b3/vVy9jumMrwUMMIrJPf9L6LV0T+SdmzspOc5SFZUP1ojzCslqTdJZCpJFPazAxT6A
	73lHHUw1QaWbZKIaBqs/mQbgvKs=
X-Received: by 2002:a05:6102:1481:b0:7a2:7ccd:280d with SMTP id ada2fe7eead31-7d03a509f02mr71066137.8.1793125919047;
        Tue, 27 Oct 2026 11:31:59 -0700 (PDT)
Received: from [192.168.86.58] (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47a6bff7sm109225116d6.5.2026.10.27.11.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 11:31:58 -0700 (PDT)
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
Subject: Re: [PATCH 1/9] mm/page_alloc: don't undo a racing
 start_isolate_page_range()
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
 David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261027-pgalloc-ai-hotfixes-v1-1-9c7d1aca801e@kernel.org>
References: <20261027-pgalloc-ai-hotfixes-v1-0-9c7d1aca801e@kernel.org>
 <20261027-pgalloc-ai-hotfixes-v1-1-9c7d1aca801e@kernel.org>
Date: Tue, 27 Oct 2026 14:31:57 -0400
Message-Id: <179312591750.3837667.585125681248029246.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-10-27 16:46 +0100, Vlastimil Babka (SUSE) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> start_isolate_page_range() fails with -EBUSY if one of the pageblocks is
> already isolated, i.e. if somebody else is working on it. It restores
> the pageblocks which it has isolated itself before it returns, as its
> kernel-doc says:
> 
>   We then clean up by restoring the migration type on pageblocks we may
>   have modified and return -EBUSY to caller. This prevents two threads
>   from simultaneously working on overlapping ranges.
> 
> alloc_contig_frozen_range() nevertheless calls undo_isolate_page_range()
> for the whole range in this case, which clears every isolated pageblock
> it finds. The only ones left at this point belong to the other user of
> the range:
> 
>   CPU0 offline_pages()                CPU1 alloc_contig_frozen_range()
>   start_isolate_page_range(A)
>     pageblock X: isolated
>   migrate ...
>                                       start_isolate_page_range(B)
>                                         X is isolated: -EBUSY
>                                         (own pageblocks restored)
>                                       undo_isolate_page_range(B)
>                                         X: not isolated any more
>   test_pages_isolated(A): -EBUSY
>   (again and again)
> 
> offline_pages() repeats the migration and test_pages_isolated() until the
> latter succeeds, which is now impossible and the task spins until it gets
> a signal, while the free pages of X are handed out by the allocator again.
> 
> If X is released after the last test_pages_isolated(),
> __offline_isolated_pages() takes pages which are accounted as free off
> the free lists as MIGRATE_ISOLATE. Thus NR_FREE_PAGES stays too high, or
> hits BUG_ON(!PageBuddy(page)) if one of them has been allocated.
> 
> For another alloc_contig_frozen_range() or cma_alloc() the result is a
> spurious -EBUSY.
> 
> Return the error, like the function did until it was reworked.
> 
> Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock granularity")
> Cc: <stable@vger.kernel.org>
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Given i separately found this exact patch and tested it

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

