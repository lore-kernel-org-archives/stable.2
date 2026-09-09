Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B7E3955E2
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 18:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788977693; cv=pass; b=Fr/ujATRdLimrpH8DccLVRchBRshp7dWY/fQ/BRDItoKDcmyHow93jsD7J732GQZmZFvRCKEqHKOo1BrvKsJimxB529CrMYRfg6yYliEF8Dd84Zef9/hSiiomTTz2qQLRCchSCnnzclFypaJWVjMv8twSK1aCFXXGzUmUx3UV7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788977693; c=relaxed/simple;
	bh=8Rbwum/U7LCRDIoamxX4vkzVMHdBBlYCRplQYltoFwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OkPuUCYSvTsMasonDrykw2bJ421D9p0cRDpEP6+SMGF1WQ8Ky3gc31rn+LRwCoyVPldscTW4zSSK5zrSSfeNiabE77xALp2LsoNDLwyziWi4yBWen+0swS8tps8n1BhJAnxwoPqqaLCqOeDq4GceZj+Mqyps0E9izpjnS7G/Hk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WN95Zj4o; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WN95Zj4o"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-48449f62b93so938981f8f.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 11:14:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788977689; cv=none;
        d=google.com; s=arc-20260327;
        b=TQmQQHHZ6m1v6G5rkGNM07UuQ6T/nAJK/aaE3qTGki6zWjodLwGwTnewQlIAxzi3xi
         JNtxddotewe32pJCFzwg+yRRiEP+AK/S/r4eoXQ/EpiHCefpoHFVRNGSMfdRzfoZR42C
         TezQOiQUwZY0w+z5PfhI63h9ZF6UXpWcqEOIG+KFAwwXmxL58UgFU7YAoajd7lZWCODK
         WrgLvpZpL1GIfcoFRQsSutI/HXfeADPnaJMRKOOmQvgnA55qK6DKbamuEQEvAzqZybmq
         aEVaYFro9TOOjwS0edrX6lKyhnfMC6gJNCzlQ2LkZBAibPMHaZwY/8XuUBwzepMbmDFc
         eyUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yzFysYL2ZWVkcNchNmKkU5ZyseGFGQP3llm4Y/4N/1o=;
        fh=PSQGUuHuiuDna2kVgY1EhwUibJbXOL8z5fGJF+rau3A=;
        b=KQVtPkvd+g8KiogyXbtOhyiSlKF7VRt38PigMgfoUdtrwIyi3O/LPomYMoGjs16ja0
         KqW1WAO/XQC3pt2ZFJCoDRO5cyNURfFwx3IB8BxddvhUNGSbbAFMf7jC8tu3V84L+ECr
         3Dsc9irTkduwVWD11putCDiDYS2N6V4Kob69BpgZGStIcWGIi+qvMFgjYdZYVZow3FqQ
         td3OevhB5sKxSlNqswagBQKfB7s2XCJtrubo3eG+HF3o6CLktfJkPZgdqDVrP4Vb40FZ
         U6wZKQ36hQjb3BmW4AQQ4blDIPQqI9WdDfDpSRONm5/bMAi3nAJQer8URbe60qJjm0gL
         4ljQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788977689; x=1789582489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yzFysYL2ZWVkcNchNmKkU5ZyseGFGQP3llm4Y/4N/1o=;
        b=WN95Zj4oHPDimCRJ23gIbpFry0UwEXlhDdqIy7oXlIOXscy9lcHC4y65WXj4efS/0u
         aCl/y60hye6neCwBzOYsFFOQnw+oO0Gx7+a/lZdC7gkZy5YcFwb9nBiXh1lCxEzPqtlJ
         17KfwWxd5uCV+Fy8qmDe5PW5NJj40kMmgdKJ+FM8M5O4iH4scT+pwyCX3LbAsGyyvyF7
         0JdhkGfFZMOcJKjOWEK9IBYc4Sx9mSVlKsBlUKJIdUHH52ZqBvesmxKG0kcy7/1PF4Dx
         2xMRUJCPA1nfRzY5D3uM9zMFW9pNuQ47u7fWcGDc2uBwa8CGANtZMjjGrLj3KSbIK8qG
         7iQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788977689; x=1789582489;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yzFysYL2ZWVkcNchNmKkU5ZyseGFGQP3llm4Y/4N/1o=;
        b=hdVN1GdT56MpjwlZhdCanfogE51ojEY41sf9No88XbW1pHTm2eK9qTYA7hy1VWbPMD
         phCzDZkFFYmemSTl5uaM47Nf1CrqRtioqj0LfIY8gzasGeQqjDSK0vGfgTOMrjZNPanq
         WqZUx8z+enz5++FTJ4Na7tPDRdg36T/coUhJ14ZlRspS3hzC5N4OUa+JWveoprBCd6Sj
         ZpiA75ECAHk+HP0NUKbHXef8hjal4R6WqX6WpiHOYez8StsKaZ8kKtuY1dw4aDtzGbsZ
         v97gn82Gcr7UeaEIZXMW5Y5TcIIvFPRzWt8/83WsPmDn70l3sKCXx0V2eWmCUzfb1M+H
         Iobw==
X-Forwarded-Encrypted: i=1; AKwUvBy4IH2sxrW9D48HplAFvC/i/jVlvQpRNAyDTWBtvzqh01Lty6INGPep8qxCb1xxQHawcJdH+N4=@vger.kernel.org
X-Gm-Message-State: AFuF++n5gNQ/i3RrhlqPE7byv1tDobGzQRzNroRBaAmgV9UIiauhrJBh
	kiQHT7Ioep912B3FHc7k4fN7JK9YHJAIXpZjTm1G13Def/bQTKh+JzrzWoXac4CJnWQODDWQcUV
	W9bB1w5NSQY8T6OZ8DGX5cfZqtaNTZV4=
X-Gm-Gg: AYBFou1ZD3e7yuU7IMGgH/YMFMlYPyWHSLGOTkBaFXLNXzrQxIQZLGBORTYGvOsFF+j
	KZA/HvPWT0Nw3r9KUyRv0V+QDbRFPpR/CudCIPc+0qY0jhfkRJsRVOeRJ8KVsPX8+23xldnwVQJ
	VtdlegN9smODHdJ7Nu9YqryGl4hn8LGEwKEXNZpVtoQkOuKSaHrGAwkhOQv6ONqLLNrpL+oWddA
	gL+P5P+3VrtYL4JXPSrd5py1h2PjxG5Pg+u8WMu0M+kT+8tiBmtTrYIIQYmBggWdBM53tonTrp3
	r0JQzjhFZC7I4ig6o6iMjbRwP6/q5lY2Q6MRfS1OamrobxpWS/c2kpDi3WHW4xvoLKmf6Xdi273
	4tZ0N6rLyeV0=
X-Received: by 2002:a05:6000:1a87:b0:485:8ddf:7a5e with SMTP id
 ffacd0b85a97d-486e0f6c965mr825042f8f.11.1788977689104; Wed, 09 Sep 2026
 11:14:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907161938.1932355-1-usama.arif@linux.dev>
In-Reply-To: <20260907161938.1932355-1-usama.arif@linux.dev>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 9 Sep 2026 11:14:37 -0700
X-Gm-Features: AcwNN1X__zB3pEsdnxmwwgsAIlWtg2QfI_AHwOPpV_fdj1oiSItGXQAyV9ijLiw
Message-ID: <CAKEwX=PDTPk3d-e7z2GYka33jatuqxy-ES3uSfyg=-L65YMaLw@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: don't fail a large-folio swapin whose range is
 not in zswap
To: Usama Arif <usama.arif@linux.dev>
Cc: yosry@kernel.org, Andrew Morton <akpm@linux-foundation.org>, chengming.zhou@linux.dev, 
	hannes@cmpxchg.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kernel-team@meta.com, stable@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 9:20=E2=80=AFAM Usama Arif <usama.arif@linux.dev> wr=
ote:
>
> thp_swapin_suitable_orders() and shmem_swap_alloc_folio() sample
> zswap_never_enabled() to decide whether a swapin may use a large folio.
> zswap_load() samples the same one-way static key again once the read
> reaches it.  Nothing serialises the two reads, and in between the task
> allocates and pins a high-order folio, which can sleep.
>
> If zswap is enabled for the first time in that window, a large folio that
> was correctly permitted reaches zswap_load(), which rejects every large
> folio with -EINVAL.  swap_read_folio() treats anything other than -ENOENT
> as "zswap handled it" and skips the backing-device read, so the folio
> comes back unlocked and not uptodate: SIGBUS for an anonymous fault, -EIO
> for shmem.  The data is intact on the swap device - it was written there
> before zswap was ever enabled - and the not-uptodate folio stays in the
> swap cache, so every retry of the fault fails the same way.  With
> panic_on_warn the WARN takes the machine down rather than the task.
>
> Scan the range instead of rejecting the folio.  The caller has pinned
> every slot before issuing the read, so zswap cannot start a store or a
> writeback into the range and the scan is stable.  If nothing in the range
> is in zswap it is all on the backing device: return -ENOENT and let
> swap_read_folio() read it.
>
> A range that does have a slot in zswap is still refused, because zswap
> stores large folios as order-0 entries and cannot reconstruct one.  That
> stays reachable - a slot shared with another task can be stored inside
> the same window - and refusing is correct, since the alternative is
> returning the stale device copy.  Report it as -EIO rather than -EINVAL:
> the request is valid, zswap just cannot serve it.  The only caller
> distinguishes -ENOENT from everything else, so that part is a
> documentation fix.
>
> Fixes: 242d12c98174 ("mm: support large folios swap-in for sync io device=
s")
> Cc: stable@vger.kernel.org
> Co-developed-by: Alexandre Ghiti <alex@ghiti.fr>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Acked-by: Nhat Pham <nphamcs@gmail.com>
