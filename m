Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794854012;
	b=Lix9Gwyp1xJYyb57O9q1sHGqOZz/FmJl4PBr13Pzvj+CfcyePXrNH2ZVz/lf5yzq9BnY
	 lnrnWrErOgTMp2HPb/2QPy4489HbldgzdZcwTjwBhEFKTC+hGbskhWuUYvp5CfePO/hGK
	 9r5I7w613zWB23kPrq3oKV2NkyWjq5Z9xlGMaprUd0EaWUJYJ4VJKe6VcndWym9kmSEvF
	 y6GrIVrpMsKSov9nCE6YL8icxVKGK9+Z+kZcs926d56Bk+Ig3m+Hj17WavkXcMEz5kp06
	 2qEBufw8QZiBT1ILU/ZVHcpeAV7qYW+1/QUJR/BGSuPoisgRVJuBy+tUHKAqEiQvLJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794854012;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Zf1hqnxgUUaXyC+52Twk933Fjs/9VQ8uLC08DreXCRw=;
	b=tfsdrOgCMpO1v6ObI7fPZpo+9E11EU/JKUR+P/7AH5crDQT/vhXEhMUCF5dPRG5UiWwu
	 OHZkZvex4bBjR0aLGJJ/lMRJOxfHZfU1DaNHAc9x7cj0+NVZ3BSRm96EKI7NFsl+DnCgH
	 idkvS1hLDERCYZyff0xWt6RGDhGd4tZJDxDpVMNQv/pU7Y2FZvsiXc9CBatcFfD18MHHu
	 BDLrHZOMGaWY+mLNbTi2OvEtw83maY3px145zZBsCf4iPt5FyVZyY6zd7Hna6iBDxmgW4
	 OTT60/2XncB3A/DfAIER1saIS/mlhi27OtlWkZ2afb9jOlxvj4xTPt60dhMN++FoCMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UQww79+A;
	arc=none smtp.remote-ip=209.85.210.45
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2D0606A32C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 18:33:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE2D0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UQww79+A
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-844a8bf7e25so3352954a34.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794854011; x=1795458811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zf1hqnxgUUaXyC+52Twk933Fjs/9VQ8uLC08DreXCRw=;
        b=UQww79+AcALvW1dj0W1OsDNLiDRMYe7F+ykqbHn2PY7/l3tGkUNBQWVfd35Ox2NVoK
         hWcV/85omatpF2td6QBVB7vUyo4uxKJgrfKM71P7WRdKkdQMrkSK7g9FUNXkowQ29JPu
         m7H3nvf8Amp1vXNCuud1FhHbSJmhR8d4NWL0zVdoe5UiDc43BfXpMCS3Eh6J4rBCFa7H
         naFM+9+myGA2Oy/0s/CfHOJstRK/a7Uz2tsELjLpmcMCtgcqMGFRbYo7WRzT4dQLl/i5
         pW70+bDTLaYrc5KJPzDaIEX0kydgCdPyirGE114SSgYONnh2D8wnDv2tcTEGIiFNZNLO
         R+2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794854011; x=1795458811;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Zf1hqnxgUUaXyC+52Twk933Fjs/9VQ8uLC08DreXCRw=;
        b=KR6URur8/vHD6VrIiyhAubRwuNzDzjfVLzaB+C1r9jA07U8K70TLoghLQUR6nKYZd9
         OxNA7f2OUXpEOYZ8NSIJwURV9tQGWI7MYqJeSdFU9alxW6+t6onGQp6v2Jx4tgH66Y78
         TngvUu7fpbDEm3idzQyleY3zmm7QjpBpAb7uKrwfmP7/oAifzGunV/N0/Mrk3fT47YqO
         cpp0D0MN3UKtwNmuRFt06r/LZ4ouh/DENiIqPETH1nb9GU7c3Fu5wgWZaJWfm/tS0C5K
         2y9lylwg3xlTGhXXPwEMBUKvDyYF++qR84eDe4wj1Hr1FzWm+rzzkEX7cYYMoennJO5b
         xjqQ==
X-Forwarded-Encrypted: i=1; AL+hErHxs2XgY9XCNpvAB0JutzbGUQyHUc+knDDXRkNPGT6nNNth6j0cYD45T/FdFdpSnaq8RnpnxJA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9v5N9LLmGShmLvsvZDCO+bhfNSy0WZ6ebbOJFHzxK1BH1PpMPH
	RttCiToWcMWHhNvDtf0IogwA5ddZION4eVyhQj5ZtpC0HoBAl+3ntYjO
X-Gm-Gg: AYBFou139u43KY7PK1kU/k+ZmcVCF4y3WZig6v5TZ3kwpv9jlOpkknCp4mKvq5GU78y
	MCVygq9LM2pPxGV90BbOTDWWts5sLUE6d58lcWBY6mpjmkfRq/jn8Bj78+Zcwb7xPnQMXm9nePR
	GXu0jAru/O5dmEXkVF+ihBN4+XMTURLTktfdCogpaAL6fT8Y7hlgEBAQvontMvvUZuMEqFC3D/l
	bcvHglz9E+6xQLZLMVGw5s2Lump9hvwFJqY9n++ysBtiecp2M2cQcqL8E/WRk62aHo7GUIsLN0W
	MMMwUOypkjVd7QsKmZtwqy2WYoNYwTbSY1zVLOATaAk+fNCWzuOYsvLyIL0Jghi6tpRRBYg/hOQ
	L58MNEEH+dIAH1sfZA7HbXgBsG8H3oztPTDE83jVSFdnkG80ZZIKJiubUXnLcXmQDKUKMQbuT0i
	rj7vvnlfhDawAzgLvaOfknUEgBM5Fig4EWkr4/Rmdc2iUWCrV7gXoCAG5alpheDQZGEYuqGPfH9
	YZJuIrQlerGrCvjWTW5TIyWaBk/2hn8rMtxFB3YJ5Bb/LpcRYHO7PwszhjfzV9f39LEItDyLvg5
	XaleXXE6wAM6NTW63gE+UBVV/Af946Rdyz3+UsuaPUm0hnGHhh5fIL8B5Ou1
X-Received: by 2002:a05:6830:640e:b0:862:c685:84bf with SMTP id 46e09a7af769-862c685924amr3847900a34.4.1794854010849;
        Mon, 16 Nov 2026 10:33:30 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:42::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862ae607cf4sm6939137a34.18.2026.11.16.10.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:33:30 -0800 (PST)
Date: Mon, 16 Nov 2026 10:33:29 -0800
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com, 
	byungchul@sk.com, david@kernel.org, gourry@gourry.net, jannh@google.com, 
	liam@infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, ljs@kernel.org, matthew.brost@intel.com, mhocko@suse.com, 
	pfalcato@suse.de, rppt@kernel.org, surenb@google.com, vbabka@kernel.org, 
	ying.huang@linux.alibaba.com, ziy@nvidia.com, kas@kernel.org, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, kernel-team@meta.com, 
	baolin.wang@linux.alibaba.com, Nico Pache <nico.pache@linux.dev>, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/4] mm: don't PTE-batch a swap-in of a folio with a
 hardware-poisoned page
Message-ID: <avtMXFH75SJFpQjZ@devbig011.atn3.facebook.com>
Mail-Followup-To: Usama Arif <usama.arif@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, apopple@nvidia.com, byungchul@sk.com, david@kernel.org, 
	gourry@gourry.net, jannh@google.com, liam@infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, 
	matthew.brost@intel.com, mhocko@suse.com, pfalcato@suse.de, rppt@kernel.org, 
	surenb@google.com, vbabka@kernel.org, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	kas@kernel.org, hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev, 
	kernel-team@meta.com, baolin.wang@linux.alibaba.com, Nico Pache <nico.pache@linux.dev>, 
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, 
	stable@vger.kernel.org
References: <20261116063624.1382944-1-usama.arif@linux.dev>
 <20261116063624.1382944-3-usama.arif@linux.dev>
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
In-Reply-To: <20261116063624.1382944-3-usama.arif@linux.dev>

On Sun, Nov 15, 2026 at 10:34:56PM -0800, Usama Arif wrote:
> do_swap_page() checks PageHWPoison() on the faulting page, but the
> large-folio batching path then maps the rest of the folio without
> looking at its other pages. A poisoned page that is not the one being
> faulted gets mapped anyway, and the fault that would have reported it
> never happens.
> 
> Skip batching for such an anon folio and let each page take its own
> fault, where the existing check catches it. do_set_pmd() already backs
> off the same way.
> 
> Leave a freshly read folio alone: it is not anon yet and can only be
> mapped as a whole, and falling back would free it with the poisoned
> page still in it, which the retried fault can then get back from the
> page allocator.

LGTM!

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

> Fixes: 508758960b8d ("mm: swap: entirely map large folios found in swapcache")
> Cc: stable@vger.kernel.org
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> ---
>  mm/memory.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index d477a4f986bc8..51e72fb40655f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5158,6 +5158,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  		    swap_pte_batch(folio_ptep, nr, folio_pte) != nr)
>  			goto check_folio;
>  
> +		/* A poisoned page in the folio must take its own fault. */
> +		if (folio_test_anon(folio) &&
> +		    folio_contain_hwpoisoned_page(folio))
> +			goto check_folio;
> +
>  		page_idx = idx;
>  		address = folio_start;
>  		ptep = folio_ptep;
> -- 
> 2.53.1-Meta
> 
