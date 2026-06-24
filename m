Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5133BBFCA
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 14:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311079; cv=none; b=D9LTLpTQ/2HsntTuTZyIZmrrb2s1GiEZCf9GKhKKov+gfY1LYou+13MX5YwnfD+yCZ5Al3D8f5qe7gapKZyhm5DLJ0nfc2MkB8rnbAY1GnJexBexNkUUiGk+dkLQTt1C9iF5snXQhvODKGLQNKW65GDuTBDN2CYh9xVbOo2vtZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311079; c=relaxed/simple;
	bh=+GvPHtbjBfoeFHgSA3GIQrRzol9K7XiFhRwqivJDapw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=Fy0m/9eRmHpDn73IHrqRW23ni3ZYB3I+uk5E5MfqTqEjYa+WlUdXmpjDs/G2wsO4QIMtpcCeQoyywTrVUeLcS/QvMCUgNiCgGQdPcrbo/ZxiPhO4Wj0GyxZGx0N2qaXa8ZXXBifXxLQnlPMBcOz0/NeezDzSgSG+VD/u6SPkD0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcMSf/jl; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcMSf/jl"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36dac5d5d05so520691a91.2
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 07:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782311076; x=1782915876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bC7GeOhZGz0je76Vr4XAaqeVuPBssFAF57vnDxsL79M=;
        b=AcMSf/jlCJU2ILuSt+66WbpetxY2HadsHQVxaA/1YzNOwOVJf6n4RLaG1DmmcY6C7p
         TIlPgl5GFj2+dPxYJTMwPia9v9Oh8ViLz3dd8+7bhnGkU8x2iGj0nQxSfc+MsXKNj/AL
         x0mJtdLNhk4c2+6dcqg5wYXcNiPXJO1vZks1nY9wk5yS5gzhdt+gneIE3OI5jHv4Xeaq
         DiReOB/Y4FQHNP5xcG8OzvSCbTqCISOt70ReiblXb8Pac7claoinWoXJFNrsMshEt589
         fFCCiCHURgnayZiapliKnusbAgNylNCa7+XnbSDGBFbW3uneBo7Fbi/kvv4nOj1QPDJp
         fAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782311076; x=1782915876;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bC7GeOhZGz0je76Vr4XAaqeVuPBssFAF57vnDxsL79M=;
        b=BAEt2VcmikCkHo2TO5ZKMIbJPMe8YoyvaYRFRgaZSn7Q3G0lrnDVyt3D6yxOXf97rv
         iV85i5BabLf0SpNOiZiJlHjquaxy563Hof8fdMTRZIkZ+L7X4xVf/EUvI+MyhgAaG8fM
         55WY1sg6LsqU+UZbJEG+NjG6PLhT3KSLI78MLVj011thkp80bIIW4PXR80rDFoAgQExj
         bcZngUxER8HwP5HN7lIYeNG0+x9S7B7ymIRfgdOOAvSaMkO5IblNCheDanA6LvhzI/hF
         d1DJ4Iq7FNwexULquAn9jj/M0WLL8TxU2auxQSdulhlJMODyC0LySz+AKlAPdUOP1kgh
         UtMQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro7uhpb6TLKD2vnCnPM6ZSUsarXFZLLaVmfuMxZOeQuZ/1RZD9ugUEaGdvQMCBOSovKf+tNzxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx09ZkqEIk/ktwNXub/RZgaifhFUQvjuBF2C3Afteouf4FMcNcJ
	jVuc/5J30fojSGjmhR0K+hTkVIRdX5x2kraFGfJ2+NlT7TmvdaQ87H4w
X-Gm-Gg: AfdE7clcCxlqUBenuTdfIxABnARF7SMpRVQajwTepa+MMTwKHQQVzYDiFuPFtoFAYUS
	1nG0xRBaYTDZ670+qxDxzfEWSQ3bH4sUISlFWv2hQJd7EkOi5+7pFOSj4G5Z+PHCMxVcQSoH2qt
	8Gf15uxprP1uOvPPmyFFp4vzHbPMtaA3IjLvYfzttXFwXjo+iP0SDyKlp9mtaE91VlWol+2r2kb
	Qb45fz+vl6zDRYCanVMi/JeHyCmn5nE3iRmiLLVJBpjRJQ9Jjp/ZtKWh+GLwvTqkrMhleYVHfw2
	c4i8yn0diHb7dgB+dXVCpe++s3/wmEo8S3i6qE8O7ePLtoCOhSe6kMyPYJtX44N0atHQZNsaOr7
	fpPI/LjZQItolcWm8zp5JempC8lSstfacRgBqae+uC2N2O6IXntHLxAYA+aXvEY8E5ZCOkL8b/E
	TUkwh6HR46o/sCHqk=
X-Received: by 2002:a17:903:1d0:b0:2bf:3309:ecce with SMTP id d9443c01a7336-2c7e15804acmr39177245ad.28.1782311076310;
        Wed, 24 Jun 2026 07:24:36 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7439f86aesm135035155ad.49.2026.06.24.07.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:24:35 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Salvatore Dipietro <dipiets@amazon.it>, willy@infradead.org
Cc: dipiets@amazon.it, abuehaze@amazon.com, akpm@linux-foundation.org, alisaidi@amazon.com, blakgeof@amazon.com, brauner@kernel.org, dipietro.salvatore@gmail.com, djwong@kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-xfs@vger.kernel.org, stable@vger.kernel.org, vbabka@suse.com, David Hildenbrand (Arm) <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@kernel.org>
Subject: Re: [PATCH 1/1] iomap: avoid compaction for costly folio order allocation
In-Reply-To: <20260624080639.17100-1-dipiets@amazon.it>
Date: Wed, 24 Jun 2026 17:51:18 +0530
Message-ID: <o6h0w2m9.ritesh.list@gmail.com>
References: <20260527162412.19922-1-dipiets@amazon.it> <20260624080639.17100-1-dipiets@amazon.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Salvatore Dipietro <dipiets@amazon.it> writes:

> Hi Ritesh, Matthew,
>
> I wanted to kindly follow up on my summary from May 27th regarding the best path 
> forward for this patch.
>

Hi Salvatore,

Sorry about the delay. I did bring this topic up in one of our internal
ext4 community calls. And to share some context, MM community thinks we
need a better long term fix for this problem rather than patching call
sites and/or playing tricks like - 

diff --git a/mm/filemap.c b/mm/filemap.c
index 4e636647100c..f2343c26dd63 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2007,8 +2007,13 @@ struct folio *__filemap_get_folio_mpol(struct address_space *mapping,
 			gfp_t alloc_gfp = gfp;
 
 			err = -ENOMEM;
-			if (order > min_order)
-				alloc_gfp |= __GFP_NORETRY | __GFP_NOWARN;
+			if (order > min_order) {
+				alloc_gfp |= __GFP_NOWARN;
+				if (order > PAGE_ALLOC_COSTLY_ORDER)
+					alloc_gfp &= ~__GFP_DIRECT_RECLAIM;
+				else
+					alloc_gfp |= __GFP_NORETRY;
+			}

Unfortunately most of the folks might be missing free cycles
to work on this problem right now :( - Hence the delay in addressing
this..


However - I would like to bring this problem to other MM community
members as well who might have an interest in this space. Can we look
into the proposed solutions from Salvatore and suggest the next steps
please? 

Maybe if someone can share what is MM community looking  for here - I
guess that will be a good start. Looking into the table I think
Salvatore had also shared a diff for kicking kcompactd in the background
[2].

[2]: https://lore.kernel.org/all/20260506123326.17293-1-dipiets@amazon.it/

(Sorry I still have few other things on my plate before I start look
into this more actively. But let's hear from others, who have better
knowledge than me on this.)

> To recap, we benchmarked all proposed variations and shared the results:
>
> | Patch                          | Change Location        | Avg TPS    | % vs Baseline |
> |--------------------------------|------------------------|------------|:-------------:|
> | Baseline (no patch)            | —                      | 101,979.75 |       —       |
> | v1 (original, iomap caller)    | fs/iomap/buffered-io.c | 141,194.20 |    +38.45%    |
> | Ritesh's suggestion            | mm/filemap.c           | 139,200.61 |    +36.50%    |
> | Matthew's suggestion           | mm/filemap.c           | 143,863.82 |    +41.07%    |
> | kcompactd background           | mm/page_alloc.c        | 134,278.47 |    +31.67%    |
>


-ritesh

