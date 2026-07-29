Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E96323BCEE
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 00:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785285576; cv=none; b=OKjB86t0/58IXppt1lFSgE2/bPAsLEm3Geg546MFP4Y0dcH4o9osYezeqZYQ8/4U/kHTZBkQ0I8r+cyOOe+HCpKrXEcKmmkvZejvE6I3hrW4lCPr29GXO8C2kEHUvRYJ/WWW1FJyMUBYtUZIyGtMc43Q10nBra8Tha/Z/q/lXg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785285576; c=relaxed/simple;
	bh=tR9BDwOT4T6ohKA/vo0ygpL2d0SulS2OAQodWSZcz8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IQTKeJ4qkz7b7+LVbiJFWcoBFC93PwY1gKx2drdYLEI695uAz3sFwyBaCuelrFf+g5rN6bE1ndmo+WP9bzLZrNNepHOLB8BR+f7KqC0Y+PAhCjQURo/NnvGbTnrD2bUE7/CLkozw3DFntz7wPo3kKWePKjrgLeb+7u7jxXaCp3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=TECpgmPx; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="TECpgmPx"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8efef6533aaso3101736d6.0
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 17:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785285573; x=1785890373; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hlDfDH8fw0HdMBSkD+M9GnJly9TjD4Ns9P6nYByTcGI=;
        b=TECpgmPxdYCNdbAZjMwHVrvu5OHV28nJ9fByi8ZVptlqq+ZCJgfrRUu83786lZsZME
         iSF7OoLe6MI2gSMHfkezpcVSIWdpUrbVgxpxjAXmvHncxCQYiuIoC7Jqzmr17tTToPnc
         jpdfNu6uTL2ps4UnmYGyf+KdLO3CS1pRjVq0RL8pAuyXUv5TdKAQTAIruSyfuQ/EUH0u
         J6czNed9L4hyVxsyq7FW30dzp3WORO+ZfXRjKXHWaYjp0iKyob1Kk/7E/21k2bthOWx6
         j/r915WIEKZNv4oLfhaHeEktu20qVYSS0mfPB9gWsPqPddQaSq3ihtifK08fuOtuM5+W
         T2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785285573; x=1785890373;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hlDfDH8fw0HdMBSkD+M9GnJly9TjD4Ns9P6nYByTcGI=;
        b=hI+AB5YyveAqMjc1pLzOadZLKHP99QzUIANLnpS8oXJxAWZSwAm8GRzf/4wnkDKRD2
         07YRt6dRLSuFDUq8rNZuvNd7GFMDRon22cJuCEUHkEo8PKJtYwoS4lrHwyvzM90pQnWk
         SU+A9Yw08Taw4w46JH0CuB04ks3giQG4LhL5bc5pwbK/67JZyUqvpgxyVs0ZNNDS86gl
         Jiy6fbrDv7Cn+9YK05mdO0fWaC1TszvIFljlTxMhZDBmWTKCq4f3tIF+57eYjncwWm4E
         +7FixRTuRM0BHWWC/P+3bDPhzyl33V6kJXmHWQhLBOmwq9B/M51NBrqE9fOoMv3CgKk3
         9hMA==
X-Forwarded-Encrypted: i=1; AHgh+Rompw5zZuBvDvBammWD5FkPRayBVGgeG/zSgWQxUeWztBNwPi4aRjp47930ILhkXEcaTiNpGLU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyv1rDeBH4U7njNQyjAkSQVCIbebxvimeM5tNl40CIlM6JxzJoH
	z9UEVV2CvsIyWNmEHimI5Vr0NRsDyIWJ0SYfCJZwB3VVFmwCk63pmkdwD5QoMHyZwOM=
X-Gm-Gg: AR+sD12EAtmp5dZ4y8AiP9ryORiiROmX66h0ne0Cbk7sKltfuPtpWQCMc8Fx+opPr2V
	+XaOsLljVGzNpin2x/K7WPl5iiXj9Nuuv7O6nUAuKJh5gIMQ1o+aXq/bREc7CYQq9bFNdNZJDAO
	1wCsx7uNd6P+E96bIHNGw49CoD/SvHBMTTrApZQ2+dRxLcuENREW8vOrCKGBaFx3TXnvXhussPN
	RxT8UYeBNeAj1n5+4Db7ojLF5EO49rL06EpQvMgFX8TvUYyutA1AVJYOej5+ycMCNhMGySwlz3E
	pKL95eDrKGhBHPnuZTZP6BcyTFJYaiND4sOPDafz4jcTufxUwl1x3eRsfqGsfMSj0yN79yxPcxZ
	XDU7MVsmK69W9U4rLo8+uWuZuZYh5VBSAozUh/4SQmW6lRo97I+2Og58vLCt4jGgsZKaB4zwRAn
	/EO9J0UQhuq7B27iLbgVCBP8zOj/1b8XSPdDMl+PvtNBIta6DlOYzkIzq0Rj3yNG3O5GvmIcyXx
	VGiVkeNMrF7UxJwHRh9w18w/T9Qr8Q1BlUWSjNvesG0NebCJgS56ahePzUIY6LV3Zs=
X-Received: by 2002:a05:6214:4114:b0:8fd:6df3:b379 with SMTP id 6a1803df08f44-9081743d851mr51993906d6.61.1785285573375;
        Tue, 28 Jul 2026 17:39:33 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dd91080sm11772486d6.49.2026.07.28.17.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 17:39:32 -0700 (PDT)
Date: Tue, 28 Jul 2026 20:39:29 -0400
From: Gregory Price <gourry@gourry.net>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <christian@brauner.io>, Jiaqi Yan <jiaqiyan@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH v7 01/13] memory-failure: Fix hardware poison check in
 unpoison_memory() again
Message-ID: <amlKHkemYQBxFESG@gourry-fedora-PF4VCD3F>
References: <20260728204409.3396238-1-willy@infradead.org>
 <20260728204409.3396238-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728204409.3396238-2-willy@infradead.org>

On Tue, Jul 28, 2026 at 09:43:53PM +0100, Matthew Wilcox (Oracle) wrote:
> The earlier patch (6c54312f9689) that attempted to fix unpoison_memory()
> was incorrect for hugetlb folios.  Before a6fddef49eef, we checked
> the head page for poison (which was correct for hugetlb and incorrect
> for THP).  We are currently incapable of unpoisoning pages (other than
> the first page) in a hugetlb folio.
> 
> Use is_page_hwpoison() which handles hugetlb pages sufficiently well for
> this purpose.  This is racy as we don't have a reference on the folio at
> this point, but fixing that properly requires deeper surgery and this
> is a CAP_SYS_ADMIN path only so this will do for the moment and can be
> easily backported.  It's no worse than the situation before a6fddef49eef.
> 
> The other bug in a6fddef49eef is that we currently clear the HWPoison
> flag on the precise page, which is wrong for hugetlb.  Fix that too.
> 
> Fixes: a6fddef49eef ("mm/memory-failure: convert unpoison_memory() to folios")
> Cc: stable@vger.kernel.org
> Cc: Miaohe Lin <linmiaohe@huawei.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Just trying to wrap my head around the state before/after, assuming
the following is correct then LGTM:

prior:
   pfn_to_online_page(pfn) -> p = precise page
   PageHWPoison(page)      -> checks precise page. Poison for hugetlb
                              is only set only on the head, so bug.
after:
   is_page_hwpoison(page)  -> checks precise page AND head (if hugetlb)
   p = folio->page         -> now TestClearPageHWPoison() explicitly
                              clears the head page poison if hugetlb

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

