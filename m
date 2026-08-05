Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D12F38E8C7
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785953621; cv=pass; b=TzgSoIXZc8wRpAiF0pAUcjvF9cUugwwgf9qGAB7I+AeCMHaFpIHRLTH9Wol3DODNhBAyJ4Xm0AtJetApFqQm6ocwpXC715nSOhAeUboHH+i7FLmeM6DGgD6l5hfZyoasHuVSX0TeTjytRZebSoyaLAghkeQVrAkQDK4A6OXVhq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785953621; c=relaxed/simple;
	bh=VttIK0xBzWBUBWmIkqwiW97WNyQTZbTR6HIBNbzaOsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ww5pGz0zpnidkSp1Q9E+xAR6LAx8hjRTt565BBQjVtfeA/YNlsvXNxn0XXZUSoA9FiBifaFsBcEPwVPbGfaZRzDfqeJVZgsz7Btu0T6lTFjNFfnI+KeBKGRAFNemcTQZxS6xT3+Fih4O3qcRdNb3Tr7PaTxTTcH5c0oqzvA4EPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JFUn9go4; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JFUn9go4"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f84023916so1169414f8f.3
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 11:13:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785953618; cv=none;
        d=google.com; s=arc-20260327;
        b=bucQfM1BMJHb6Xs5yUPlGKt7rQG4IUmcNq6B5QofhUua7QKAVEoDUzKdN9FWjQo8h1
         d1hUUZrlWzaowHK/fjWJfYBmR5nnfGsC9NeNtLmGDZoPptbpsg3KrFNI0V07zwRwU8DA
         zI8MaxCqjmO1u1Q8+tHctJ4YxkQUXwJOU/zD0uOROjJzMMF8yWe7W9zvx+tmtchJsLtP
         1Vs24/VVotXrAgpdYlz+/9j2H4xG/fPANiUN431t3IzAgY7XtoqniiwP9EOm87xLRCbq
         32zT59/NsSb9Y55RfaaOIRioScZ1prQz+EAsqdRCcLz1fYsEOHzLWFBll3QteSST1uMM
         jn+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VttIK0xBzWBUBWmIkqwiW97WNyQTZbTR6HIBNbzaOsQ=;
        fh=+Ld3PrZIgevPev5CXlZ2nja4RDYuESCl2GX6pTdpYVU=;
        b=hLfWPoDpjeB9Lwxjzw4L2oCKPczBpoVqWDhbL/o3sofvv9zI0ST/pLGjn250TkA2Bc
         /3nPKCZQjoC7OzXVDur/s7G1GvPkqFJKrw5rkYlKRn7plFEeDVB1W7919J1OzD26df23
         5pcJmNJNIBZII7ac1gtx07x9nqrDZsNFU07rn3r6cCI0Ax9feZLHQkxPsjs3RnZ60GvW
         AELcTWlcpGFp+3OuKyZmwtjYMremKiuUMzHhLQtyV9Qv6CZ9Qab7wIpgypVxRySabYLH
         y0bLeeGDUayXs16fuwj+om9dAxR0nqyO9x0mB8zO2pUY5oLPvr/XDZKPYSL6AR0Phz1k
         BgBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785953618; x=1786558418; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VttIK0xBzWBUBWmIkqwiW97WNyQTZbTR6HIBNbzaOsQ=;
        b=JFUn9go4TcZPaf/G49funvgRIK84LUNDxqUNvmBbfsvUO2RBPVESKU3nSR4z/8RDAu
         cq9zzpd0bk6BQX+tNcu3b0bxJMdTJrf4VqNZIiSVVkGLyyFfTpeQLEW6JpqJK4aCTGLH
         dEj91FszSTHoQKlyfvQE7W8PwcJchgmRyLGq/md7NMotiSzrjVWOizlnpXShHssCMsbw
         se8JKYWqZZtU86Vj3kIIb/kSQijuS4nlxxk/bFvQjab5m5o7PYEVXGJ4i5ZAxHQxMS3l
         RQDSRRgm7Qn1Ids/FjV7wktiEX6jw7EGt65/0ODmGFTwqn8YonxwJZaUXNW/BVHDta72
         5/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785953618; x=1786558418;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VttIK0xBzWBUBWmIkqwiW97WNyQTZbTR6HIBNbzaOsQ=;
        b=i0HxDdOJXZUWd+TWbfLqdmwitZOycJD3PRkUtgpVtFeIxgbvH5WinVBA4p5NufUidv
         4XmNcrcuMCcLRTIk16qxT1SPaTvgBpnuCwrryZa5a27oR2IJOto9P4ezmqCsZmipuXzi
         92DAXwYBzBDexVvklwXgB8XTeOxXP3Ve+cr5TQQe+DmE3JFTq5YAFKMGBDhAJLTe27hC
         cvb+WVZ9dhPUulyjPQeaYJoj4VEnrOY7HjsVSjI9TFJvKvK4y7yDy0iNPUCDrDXTlTR0
         fluXkrR4QrcRcK6jF2MW3o6bjZP33ug9t/qhcfcBUV+/ZRh6q/SzfF++7+w4DuhZC4w9
         O1FA==
X-Forwarded-Encrypted: i=1; AHgh+RrBb4mG9dlq/uXJjHsxjl5LdfFjXyLIS5j3hdqGVX+yjrYKdUvyE1MlyKQSSGuw7apx63/dXTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzdH7BqLGRlzFJoUtoqvIprOAfglyAarS1bnANtxKVfNVAuKst
	hxZYujTLzcFkRPfL5TZ/IwQViEeE3ExXuCwaIYlRary58/YFH8Ka/IJKBJ7ePqYmkMUPvOvZmcd
	PI+5MmdNcrEjilhtgH8dQ57+KZ4X2l/1zc1B8
X-Gm-Gg: AR+sD11FzLGlAE3cRCLKenE95INe2aHzghhdWbXsEAmksN1L/RsvNgHpwqtY1CbD9Zz
	Nl5aYX+ktscwTEfx3kR8h+SpVCjG1Wd7aJA6mzRH0nS6P7OAV3lu1b953MslczK1xmtrfrwkEP6
	rXfk+JQxy6O/oLicytdNg2YUE9io76U28sH3Ly3ayxWZIKD/VGeahdIAWuT02H9AzC2OGn9IUcg
	zfLWfGK9RHZ3z8O3hqHM0ai0/ZNZA0n7W9DSD2ar33B7IwEVPNprhb/bAzxzWophTqhxRh/sEVj
	KX8+iHeSKd+2puUfQdKMXF7xmHW0cpXjlKA7CJCulTufK/eaa5i+l0gtFwWtccJ24kYTJMSXsxL
	Ia2to67AESLI3
X-Received: by 2002:a05:600c:1d23:b0:499:51b8:d649 with SMTP id
 5b1f17b1804b1-49951b8d652mr45542765e9.3.1785953618093; Wed, 05 Aug 2026
 11:13:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <amufiuAaZbuDdKkQ@cmpxchg.org> <20260731071900.38942-1-jiahao.kernel@gmail.com>
 <amy8gAN33W4QsM5R@cmpxchg.org> <6e16a760-d84d-98e1-433e-3233a9dd2236@gmail.com>
 <94d74382-2e2c-8f8e-35e6-1ecafdcc445f@gmail.com>
In-Reply-To: <94d74382-2e2c-8f8e-35e6-1ecafdcc445f@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 5 Aug 2026 11:13:25 -0700
X-Gm-Features: AUfX_mz21OIvgUV13HlTkmRouDqof-qc0oL4x2fG4bWuvZaziIySVbUWkVknIP4
Message-ID: <CAKEwX=OuXHCV1G67AgJa+S42O0S+u+CGyOKcg9HqJ_6Pu_=5hg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] mm/zswap: Support batch writeback in shrink_memcg()
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, yosry@kernel.org, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, jiahao1@lixiang.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@kernel.org, 
	mkoutny@suse.com, muchun.song@linux.dev, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, stable@vger.kernel.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 11:21=E2=80=AFPM Hao Jia <jiahao.kernel@gmail.com> w=
rote:
>
>
>
> On 2026/8/1 08:31, Hao Jia wrote:
> >
> >
> > On one hand, this avoids scanning the same entry multiple times within =
a
> > single pass. Since the second-chance algorithm rotates referenced
> > entries to the tail of the LRU, entries on nodes with a large number of
> > zswap entries require at least two shrink_memcg() calls to be written
> > back, whereas entries on nodes with fewer entries might get written bac=
k
> > in a single shrink_memcg() call instead. On the other hand, we also

Same thing happens if you have more entries, no? Say you have 64
entries and 96 entries in node 1 and node 2, respectively. Then you
need to go to round 3 to reclaim an entry in node 1, and round 4 for
node 2. What's special about 1/2 rounds vs 3/4 rounds?

I think it's probably fine to just pass SWAP_CLUSTER_MAX as nr_to_walk
- we're applying equal amount of reclaim pressure to 2 nodes. Without
prior information, seems like a reasonable strategy to me. I think
what you did is already a pretty big improvements to status quo - we
can always add more fine tuning on top of it later if needs be.

> > avoid spinning repeatedly on entries that fail writeback.

SWAP_CLUSTER_MAX is 32, so I assume it's not going to spin for a
terribly long amount of time?
