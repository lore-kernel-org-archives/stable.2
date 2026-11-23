Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795456333;
	b=47nYKX5LL9S58nFrkHZ8akZJSSZIdlnPnFQGmMt/cpYAusaOHE5NNpbH3O5kMQJJdwbD
	 P/YBVXcV2ygW9nKOsd90/FLgxQIfhP3DbfsasAUhMKA9bUh5fwmfpxmuW6cr2bfeVQrOH
	 SsjixU3vLNzs8QdSaT5RxW/J+On8S9VqvlTrDGj23mK9+7oLwQIB2ICT1611Ydt41dJ6A
	 RicFPR5FZhKpnGkNRuOXUoDaaY4uYWBGzhSNECS7WYKYJD74q30zOvpjt8VQGd6AeZNU1
	 93UUIBLEq5UBr9NtmX2PMOj5O6EgLCvo3XaV3zTeJw3ug13rqbFheCoCatPRESnOpvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456333;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MG9wth+FgKJUhgMgr0LKB7NofqtOeeE2/Q/8//33IbE=;
	b=GiEmWIXWGZNI2+0E7lfMj39/0rjGyX0Cj0P6plG8lokLeA9RGMsZHqMUpnXJ0NY08qFZ
	 WeRUx4PVaBJnBUiFQY2HZ4RrX6gRlw4PVvmJ2priyKtV00HDOBsfb8qv6vlsgroyHVlnm
	 xHG/I6AqSi15jsgJqzP83+K3D0ljstPGE33iume0JIUqwrjM16jw+zQCoQF0vpcLpebTO
	 S7HFIV2bcGDPgJR/b7WvmHPGvbWLdar/7agxx9DixPDTqaQrpk+yI6Ux8OUjxMjMZFAW1
	 pbWdZoxJjJmp8rS4B52knZnmMfY/+BZ6wYO7oHNQAWwdlBvTUtJQiLXrelcm8+CkS/A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VzVZdWLS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.177
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA2D606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 17:52:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FA2D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VzVZdWLS
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3ae6a0ffb55so28988481fa.2
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 09:52:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795456332; cv=none;
        d=google.com; s=arc-20260327;
        b=Y+5hRgfFeg2mYtunlCfbNMqJSHmDqVcLbbQNuL04yEPyO0Nc/r2PAHyWX62pnbLuES
         FFTx+g/GjdICHNYSR9tWKK9KWkMSDO2MUr3c7M/t1VZtvyMyhpyBmzV3J1uhHEBoE575
         KaV9V9mQ6+Lzgzk3cKi9uNhn7kvVkRHmqvjrjMGtlbMF1X3EDc/ga2e/T4wy5tZgcUo7
         ziBhCE/utAs+5alrPAj55gfiorl2j6AzfBLBtThs4v5DamXx+0fA/HmVMaBvtxq5zPDR
         EWkLrz2tkyxcKDYKyx/qG683BTQPqM+5vEUhp2tsFes9aFR+R3HTSOc43rEL/SLC4S30
         z20g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MG9wth+FgKJUhgMgr0LKB7NofqtOeeE2/Q/8//33IbE=;
        fh=//dKohM/XUUZEYeFhDO7slJELTM9Yc5eEERIQH2ZLC4=;
        b=m1HDw8iP/YwDecJxa0uah1nb8K3JZYcflnqvKd9XiM+OvytgJbkI7SlFJmgP/qI2IG
         a7NsddIIg+X0Qn/17ToTcNETkoe0BrrIo+PJ0tG7bEwtbtCzp6ESJO6NnC7k/paLqsYY
         Bu4OY5mLeSOVYltX/WWWGPU+Zk8hF3oXX7UjEjQGPoG3FVbVQGl8AM195Hr5rRgn4SQx
         6yWkquH9lSlRX5Ex/byrDROBzlYOgwYOdKw0PLBN6tcwNE+K3wslPApPWdDu66qV5opA
         zIt+4o/+7FpSVAJKWV/bMaLPEK1vFeUKUlmp1RL8wDJ4ip6bhhsYCsSt7Zwdz8tM8L6b
         NKXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795456332; x=1796061132; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MG9wth+FgKJUhgMgr0LKB7NofqtOeeE2/Q/8//33IbE=;
        b=VzVZdWLSgKck9jnCpt5RDvw68VaJmr3oNxnGJ+6vxLUrggnEgO8oKD2bxPlSzauCyw
         1PHMr4dZgM/+M2EBeLNaRWmp/M8Rb4k+jyaFPASscR8yo2lKv3R3z4zrPqfQr3KuNbfu
         qJ8fudx1gpCSTCwYmjnaM10HDEkhnoCNCibUSVSiZfkbDa9jrdhMyqtIwPPXUsIye8/5
         fOSfKDGstpp45f9vJaoFV3ZedyWuC+wc2CXWnBgCmYm/6W0UIanqfYogNjMqej7k7RJA
         cRCIK6JPI/112hMpL8gNCkZ0UKbCjvX4TL8whDIb05sVFnwSdJB/U1hsrBCZkRS8xq+u
         vgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795456332; x=1796061132;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MG9wth+FgKJUhgMgr0LKB7NofqtOeeE2/Q/8//33IbE=;
        b=NJGPM5tqzJrPht5R6X6QHkcLee2+XKr3gvgzKSPjzRr0zlUw84+tNQpJCCyaN06ClV
         8sDN+JTAB8eVzGRx+61fOKmVOWdWFo7srr96fju1AE0yKfsSof+kIMwHZP+MEXdRW3d8
         CxQ/JTvTPK4tT4abxBVZqCVEPP8rEhOjV/i0q/oSUffVnC87mdL7N8ss3n2fSQ5gb1Nc
         MLmtPx/3nYb7kCgGIh0h5PXXNNJvH50/mneuWu5JpIHc3ygzwWR/1m76zgOQQMEmp5dj
         d7xJmHVDSaGQmMI0TT/G5POl8zSepi4N9H5/ye08pSkD4ELAgqYgMrgPAjV3RBDw29Uc
         S1EQ==
X-Forwarded-Encrypted: i=1; AL+hErFJ6zLziZvE1DsNNgEKS0fhMGEjcaEWVcLT/2wjO1pOe6fj6GX7p2wIZH5mVnHZYZwJv44WMjI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+DwJJePbXHbpc9MgZ8h2VccYBS7lrYSgimZWJF3+ayLh+Q/xw0
	FUAG3dWtUGF19YWYqO/YPWQW66zEFA/H5EILzEJ5i1EiHnbZC4PDfXgCe8cIkTirNwxQ+P02mg7
	KAnI0BnyuB5wefrvpX19lE1sSoi3lADk=
X-Gm-Gg: AZFdTZcHEsxh/PaPfAwyml/dHGMvi7hKem7QZP7DI74j/1nG/DbVSghX+1p3MdaV+a4
	MzGVQ+qlLpZkEYjL+ef25am4u8rSshF21BBAX36No1sGyCrfpyysHtiTm99o6JFYIBEGuCvTmYE
	PgmDPMueVMid6+5EUI3GGEtxXnbni+89ANJAuf6rriZ8jz3jPGpz+0OZi8uNCu1u6KdSWoJioOC
	7rJ8ohNotQHq9l4S9SRnmHPO9WC0Jo26Dy1EMhPpjZL0oTG0vWhtXr+c8TLOzVabk/rdGADI73p
	z+pCRRVSV84qVPaym8xmRPPUssFCRef/nUsXPNWzS161bkpWcmjAcFwXENsaK2cHNz5REXQ+6yt
	nBzI0KQ4oBpv+xZ5MqDUJiAleXOAZo2sZIS1DwweyYFAZrrpZF6AoL3zjONI9+B2nHia2xd3HYB
	aqT+1TRH+GuXaeTOMY5dSneqchcp7wT+V++h+B30UeraMddRqYVxmd
X-Received: by 2002:a05:651c:4217:b0:3a3:3170:5420 with SMTP id
 38308e7fff4ca-3ae7f8d44b2mr28562781fa.3.1795456331357; Mon, 23 Nov 2026
 09:52:11 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123-shmem-swap-write-failed-v1-1-41a0115dfbf1@columbia.edu>
In-Reply-To: <20261123-shmem-swap-write-failed-v1-1-41a0115dfbf1@columbia.edu>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 23 Nov 2026 10:51:58 -0700
X-Gm-Features: Aa3M54oC7mW_vSMsZDK130KwbXWLigQruCSyLpfj8hjGPNFnBuMpFbLJ5HWExyo
Message-ID: <CAKEwX=NSxxQ7DB_CbFXNV9TZD8ddwLJry3Unab1OjnFPQwR6KA@mail.gmail.com>
Subject: Re: [PATCH] mm/shmem: don't drop a folio whose swap write failed
To: mt4022@columbia.edu
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Chris Mason <mason@kernel.org>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, 
	Tal Zussman <tz2294@columbia.edu>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 10:21=E2=80=AFAM Mani Tofigh via B4 Relay
<devnull+mt4022.columbia.edu@kernel.org> wrote:
>
> From: Mani Tofigh <mt4022@columbia.edu>
>
> shmem_swapin_folio() drops a large folio that does not fit the mapping
> from the swap cache if the folio is neither dirty nor under writeback.
> The folio can belong to another file and be under swap writeback, when
> the swap entry was freed and reused before the swap cache lookup.
>
> Swap write completion does not take the folio lock.  On a failed write,
> swap_write_end() marks the folio dirty and then ends writeback.  Since
> dirty is tested first, the folio can look clean and written:
>
>   CPU0 (swapin of file Y)             CPU1 (swapout of file X)
>   -----------------------             ------------------------
>   shmem_swapin_folio()
>     folio_test_dirty() =3D=3D false
>                                       swap_write_end(), failed write
>                                         folio_mark_dirty()
>                                         folio_end_writeback()
>     folio_test_writeback() =3D=3D false
>     swap_cache_del_folio()
>     /* X's data is lost */
>
> The next swapin of X reads the slot whose write failed.
>
> Test writeback first.  Both flags are in folio->flags.  If the
> writeback test sees the write ended, the dirty test then sees the dirty
> bit set before it.
>
> With the fix, a folio whose swap write failed stays in the swap cache.
>
> Fixes: fc2c19648d68 ("mm/shmem: fix swapin livelock on a mismatched large=
 swap cache folio")
> Suggested-by: Chris Mason <mason@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Mani Tofigh <mt4022@columbia.edu>

Good catch.

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
