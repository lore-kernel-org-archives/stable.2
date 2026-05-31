Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E692E341660
	for <stable@vger.kernel.org>; Sun, 31 May 2026 23:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780270174; cv=none; b=uCJmrM+Y7fEAGgfer/8vp5eRfZBzicSTfg4OPjiXlEY+xkZ7vp1XoJhuD5G7d4nrV/RMVxlX5N5vcHdZvAiMYTL2uv5rFstbB2TJ3d8GKxxAyiKRXB465rCOuSETZu3zC9JMdMWJhyKVfs4odxEfs0qsKcwFAi+s/9+E9976Kow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780270174; c=relaxed/simple;
	bh=wpN2DMoqi9CmEHMcXbGGMbu29Axnf2IHOptAkTUYXbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWsfsFOhvTx9IO2gL752rwZFBGrMqwBmFSX3kWmzksg+okB8WzOy/NKdqTwHNgKDBHlXscP4znaR3Qr/KmUYSI6A/ejeztdRYpyz5rBAi5qyURBBcXhbxH+AFzzMyzspLmlp2ulclr7qrEkdy1qpqXnvlFk8h+6/AzaNzfejHEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3MSwmDq; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3MSwmDq"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-45ef616daf6so2087137f8f.3
        for <stable@vger.kernel.org>; Sun, 31 May 2026 16:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780270171; x=1780874971; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hQRXdo9YxYwyrzUF+NcSdzn+gwHEuyRiq4J1P14JkS4=;
        b=F3MSwmDqrJ572O84JWel5Y10PTK+Qu0ZEj0/BHeMgVXume+YGx40fQGSAGCHlq4bP1
         xXHlPMuNgCSBBGMBgG842gSM4RQy/+zm8eX9D7uZgFMSuGLu+CsifFZsXdc0ZgObtkDr
         dJB9R6s1MEonwcK8o6snC/F99JU0hGe7BH9qZxSwv56N9ayEAWuG8VxyOo7rMW+KTmvM
         VKWr54ZVBKzIKoGetpO6+7hIHEf2Tsbq0mD+pDUOEKIcN9qrgQqKLaginOxNry7hle6a
         N/7dPS2Pgy3gdWeazu8wvWiC+3Q8W7d9qWAg3jAlVeUCAuX1UE4pqPjV31eWWw8sHtNR
         IGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780270171; x=1780874971;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hQRXdo9YxYwyrzUF+NcSdzn+gwHEuyRiq4J1P14JkS4=;
        b=WtnbtJEMWLY9Vjfr3dycxECGcxt831uh/Zdn/kiPrwDrtxfNxEj8hAX5JBvDzxVt+E
         ABavJYApuXN6fiy1WzMOx3ZqX2shunn1xPhp1E8COOHjk9tTBCatTSWlWyGS5C/V8Wf2
         sgFqiTfWIW7LxPuOUFfoEbTVyZNYwxxgGYb/CLKW88JFCbda/qA97UXGpfKuAPUWYefp
         wYVZtGfWfwCgvaXE0EwWUsxsNaGHA5fjDdL+Di0mbTSbWzwRLt2EFUsxnP48+EUam1+k
         UKfQyHcCtsrWlshKuWQ1nnWF/dSsdm0p991anQsIu+iQOJFygOQ1IlVPei4S+IS04yW1
         wT0w==
X-Forwarded-Encrypted: i=1; AFNElJ/jf4RTNx65EZt3VpNcUpaDYqiA8KyBDrjveMXcU9uImYo+z4fOv0knlV2GGzG6MQZCPpnEpUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE/vRCfQcdmjXNAW8Gi32CLsxUI3+uYoiNR7Wii3AcPKWddigp
	PMd2OK7O4qv8nIwoiMfJHn5BZK+bK3MksZ6O965bvXAgB+0PZHNaPbEBdosDJQ==
X-Gm-Gg: Acq92OGqYwZPlhJFrIzgIN0P8Euk0yz5kw+j4sw4xJPmRvkxKuHbWwbUmSqNTuXMuOo
	/0Csd0X4hHEppiYiz8+opt6TC3KtFpxZZ282e7AVZlIYgzA+EOyMYG/lxQ68tmSt/AsL4vSk1M6
	curs6jAJZq2bSRjItZT7kPekThgB/rA1U4Dj+b7TwGa2JmN2vQETD2TMi/WApwC8eYdJYF65/py
	ASWWu0qDLw3nrOJ9vqv2vNm5UHnadwkUX2amhSohE8QOS1Ii1V+X9xQFSXrktozdGWAFpGRNy6Y
	Ki2dc7hLiTTSGcyn/x9p1CFAWEcpqy5mN+4gRZ9a5n9gxEV1UDXZDEktR2wD9cg8mgyHlHSJkm4
	43JvkdklE+iMNohj733mY2C2QBgS3hctE9qOEU70CP/LW3VOm3KbaSQ4hNIM3n/3nNOtXO/BSR5
	8WWCOruNv0g9iumdCYo4E4S1tqjzYLJFh6+0V70Lk8evyYQz6cMffZcTWifVqMJfX5+3TzgV7Rh
	+s=
X-Received: by 2002:adf:f14e:0:b0:43d:7d24:b510 with SMTP id ffacd0b85a97d-45ef6b5ae44mr11062126f8f.22.1780270171265;
        Sun, 31 May 2026 16:29:31 -0700 (PDT)
Received: from localhost (pat-125-253.wlan.net.ed.ac.uk. [192.41.125.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef354bb7asm20512971f8f.20.2026.05.31.16.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 16:29:30 -0700 (PDT)
Date: Mon, 1 Jun 2026 00:29:29 +0100
From: Karim Manaouil <kmanaouil.dev@gmail.com>
To: Salvatore Dipietro <dipiets@amazon.it>
Cc: abuehaze@amazon.com, akpm@linux-foundation.org, alisaidi@amazon.com,
	blakgeof@amazon.com, brauner@kernel.org,
	dipietro.salvatore@gmail.com, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com, stable@vger.kernel.org, vbabka@suse.com,
	willy@infradead.org
Subject: Re: [PATCH 1/1] iomap: avoid compaction for costly folio order
 allocation
Message-ID: <20260531232929.mn6f76yrnc6e4cpf@wrangler>
References: <20260506123326.17293-1-dipiets@amazon.it>
 <20260527162412.19922-1-dipiets@amazon.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260527162412.19922-1-dipiets@amazon.it>

On Wed, May 27, 2026 at 04:24:10PM +0000, Salvatore Dipietro wrote:
> 
> Thanks Ritesh and Matthew for the continued feedback and guidance on this thread.
> I'd like to summarize where we stand and ask for your input on the best path forward.
> 
> Summary of approaches tested:
> We've now benchmarked all proposed variations (pgbench simple-update, 1024 clients, 
> 96-vCPU arm64, huge_pages=off, PREEMPT_NONE applied [1]):
> 
> | Patch                          | Change Location       | Avg TPS    | % vs Baseline |
> |--------------------------------|-----------------------|-----------:|:-------------:|
> | Baseline (no patch)            | —                     | 101,979.75 |       —       |
> | v1 (original, iomap caller)    | fs/iomap/buffered-io.c| 141,194.20 |    +38.45%    |
> | Ritesh's suggestion            | mm/filemap.c          | 139,200.61 |    +36.50%    |
> | Matthew's suggestion           | mm/filemap.c          | 143,863.82 |    +41.07%    |
> | kcompactd background           | mm/page_alloc.c       | 134,278.47 |    +31.67%    |
> 
> 
> All approaches recover significant throughput. The kcompactd approach (background 
> compaction and returning nopage for costly orders with __GFP_NORETRY) aligns with the
> architectural direction Dave and Christoph proposed, keeping compaction out of the direct 
> reclaim path, and lives entirely in the page allocator. 
> 
> Based on the discussion, I see two possible directions and would appreciate your guidance:
> 
> 1. Page allocator fix (mm/page_alloc.c): The kcompactd background approach addresses 
> Matthew's concern that filemap.c shouldn't know about PAGE_ALLOC_COSTLY_ORDER, and aligns 
> with Dave's vision of removing compaction from the direct reclaim path.
> 
> 2. filemap fix (mm/filemap.c): Both Ritesh's and Matthew's suggestions are minimal, 
> backportable, and preserve lightweight reclaim for non-costly orders. 
> Ritesh's variant differentiates between costly and non-costly orders, while Matthew's 
> is simpler and performs best.

I am not very familiar with THPs in the page cache, but for anonymous
memory, we have /sys/kernel/mm/transparent_hugepages/defrag which
decides what to do in the event of a THP allocation failure, whether to
enter a synchronous compaction or wake up kcompactd.

Check vma_thp_gfp_mask(). Maybe you should adopt something similar called
file_thp_gfp_mask().

The problem with fallback is that your application is never going to get
a THP and eventually TLB pressure might actually end up slowing you
down in the long run.

Also compaction is only really tried if it makes sense. That is if
enough free memory is available to actually perform the compaction and
have a chance of creating a large enough huge page. So compaction is
actually never performed under accute memory pressure. Which means your
system actually has enough free pages, but somehow the compaction is
slow and inefficient.

I am just trying to think loudly here and address the root cause. The
real problem here is fragmentation due to unmovable pages, probably in
your case the page tables. We should work more on reducing pageblock
type mixing. Also page tables can actually be made movable so that
compaction can treat them as movable pages.


> 
> Would either of these directions be acceptable for a v3, or would you prefer a different approach?
> 
> I'm happy to test any additional variations or direction to move this forward
> 
> Salvatore
> 
> 
> [1] https://lore.kernel.org/all/20260403191942.21410-1-dipiets@amazon.it/T/#m8baeeaf48aa7ae5342c8c2db8f4e1c27e03c1368
> 
> 
> 
> 
> AMAZON DEVELOPMENT CENTER ITALY SRL, viale Monte Grappa 3/5, 20124 Milano, Italia, Registro delle Imprese di Milano Monza Brianza Lodi REA n. 2504859, Capitale Sociale: 10.000 EUR i.v., Cod. Fisc. e P.IVA 10100050961, Societa con Socio Unico
> 
> 

-- 
~karim
