Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795362632;
	b=scTUSI33WEz+PtoxYXXT994yBsRdfJLvKWEcM0MHIakW3Ab8JlNcTRxWhrysdb1r3J59
	 i3NQH1qBi3s2unPq8pD/WfHNAsMYe/HZ2cSiJXXgUEwy0S8cJIepNTwMtZ/27Q3lUOfc6
	 Zs91wIan/RssOLZ/jrkrJ+FgONq2AQ5HL8akOrNZ0Dwx3o/AKIQ/XYRJqggoZx6FV6KVX
	 fxcNrn0DDTZP15b23yzUN/jfnjn/Gj07DQXvj39pkq2hq+z98ieHtyWH8fsIeor/GVKrd
	 WWPGGlDLeZ4bcJbemE1U1exNu5wm2AExEQDugZ9ssdaUPWCA6wHisjg/W7GBmmxe7Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795362632;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=sfE9ffid3qsS6HCt6GKuvhh3G4tRqIqs8ErTq4gAbSQ=;
	b=TcIV9VF3QIdW8s3PoYzf443Rr5QzsH1dan5Xzd0tlq821ZwzN+OkeQGrWg1291GC77tC
	 Rkz1o8AE/4pVy+rOGbbeRqH/9d9YN88xfIVy5Mo/oS6YwNfEgtLAob+A4eu9iWTAFS/08
	 xWFO6Yy3gIaiMqZI+DNjYJrBkfPRqXBkDxTo2njA2xe/zaffTHSlvHOvj3cfaSlspf+ow
	 lzMNkh4/xuQJYHOW70XxRKEzJYTS3wfU5S5at9/PiKixAJxTKmDim96UbFgwuMEwYdk6o
	 5XDsDRoZMyEheg3PyV4bfSIIy7auuKYJO2fYbwAoyhzZS20+FwGLaFQAkFtgaKilapw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=OgKwPIfR;
	arc=none smtp.remote-ip=209.85.222.169
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF6A606A320
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 15:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AF6A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=OgKwPIfR
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-9496317b730so340008785a.1
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 07:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1795362630; x=1795967430; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sfE9ffid3qsS6HCt6GKuvhh3G4tRqIqs8ErTq4gAbSQ=;
        b=OgKwPIfRKSH//EHfV78H8sJQIJN9osAZKX/yzjEBiUhKFGnGbDpHsJSFL56iYakt8d
         HhCzE7DZcOCNdeqb62py0VyW8fgjBlu6kEhvajaEkcb9TmV9Aj/AFwqlhRmAgs4T7ORe
         zd8f729xHnnL06gk3Y4qpxq5BihkKGQio4NtyaofeWCOeDjuzFaQ8arW9ZkI0eGJdRxa
         iU/yNf9qnwf7/T2TJ5yt/btT61EwrH+mwlynA4nO3PitkDbdOjglY/4NplJsy6u1izDZ
         bAXbNkD1cwesAmZ8GwaOBRHlj+TqEhUe4SEiwytgjcB+qicO/rPZtLM49l4GbWfrL9+X
         ChmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795362630; x=1795967430;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sfE9ffid3qsS6HCt6GKuvhh3G4tRqIqs8ErTq4gAbSQ=;
        b=oKyLKEXOE+aAO5P+DLJcMKWUwFT+AOJ7fsKDFEWSxhMmX5KFtWhRfVDwu0pKRi/Voq
         FuwpnbAc7vb2//pMU+rT3+U0PXOZ8y6gB4LopVlGNGiy9OzINjSNT6nGVUmZeVJuti/v
         I8Eu9z5DfZOv9ePrJRRYAwV+AulnaJWSjz6WQK8hdDDVVf7J1b+znsRdkEtU3fk/GVJ/
         Mp4N+zUh0eXwa1zfVLHXOlW+NaPNxAnjP1Cw3EQ1VPmG46yM4A13fJTb1qqrEWdcsFOr
         I/xKKvHRSJt/5WdOp75BV7TAvGT5yCUXPajx/GshQdXcIJlYPtHMteqGh7xEoyP+x4Ax
         bmYA==
X-Forwarded-Encrypted: i=1; AL+hErHF3qmV5aLlqbRFpf3XyCg67kCtbgZUF2M4FPvS+O/os3k3nI4MbOgQKE2LqY7JLbXda/s6TGo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8VqSKBOlI7Y6E4dHlAz1SQY9eGIEiiz8CCvswDJyUkdqRkZCkE
	N9zsiykghCn4EgJjFw2bn8NPOka9J9C/MreD/cl8rfFn4PEEvo5XhAxE9TlXLlS2lAM=
X-Gm-Gg: AZFdTZebKJEAwLmgGGGivWHt8cLV0K6+njWmCFBFqJweRyu9Z2V1higmtMKfLVclwL/
	CQD4v2iJHNjtoORBALSFXyZ9KlJoLfhuZHrNiUeDgF02nkTo+JRJH8OQvQphMMBzjYDRf5i0pcJ
	/XtVhQSVA4ZcHRMVS7xNt8fCfCMjlSdxi4K7XGyS/4Vr4pbiKzQk4/jHT9C2imcE6YD/jKcMiJj
	b9uiqbOtK9dkYQg9Uh/Avvwy/DO2GIfLVxUre3gjybltYFYUbRKfuk7z8uA/0O4FeWmclfAzTzo
	L2NUS6qyn7N4rr0icHA4Kzk44TV9c2YyBX+ZHyvfByUWJ5/U2bbf/2QraM89616hf2yEgLUXtLc
	rDd/XunelfSmI3AAvs5aPLv5BtorVXA07pdxTCHf5onfMQ9kyk81JYEuUMjQCY2GvZzRRUomEPX
	8U6blviQsdc7IV/yQcWP01wcMxL5Z0rPHVr1JPO3M0P5yvJUQWjUQx+D1aejoYHE6ojjWCLY3wj
	uQ00ia2mOLsJDKn63CYIEQEKfKlz+ThHTUZ1ceA4Cua+Vo7qWRe6wxDHZmpNeiz8Nu+mbi90uou
	3x/AWs+mVLhFjfQ5KKHu5gmpYjbWZUhTwAYpjVbGv7vm+IBqeFRjs0u5Fq6IoMX/LzGxvYErI6Q
	yxBVb5mstj8z7QtDzB7bFzVOdcOuM
X-Received: by 2002:a05:620a:4713:b0:93c:a468:2db1 with SMTP id af79cd13be357-949bab11618mr1604125185a.58.1795362630552;
        Sun, 22 Nov 2026 07:50:30 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb41a341sm626128785a.37.2026.11.22.07.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 07:50:30 -0800 (PST)
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
Subject: Re: [PATCH 4/7] mm/vma: fix uncharge after failed stack relocation
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, 
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
 David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Kees Cook <kees@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, 
 Ollie Wild <aaw@google.com>, Adrian Bunk <bunk@stusta.de>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, Joey Gouly <joey.gouly@arm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org, 
 Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 stable@vger.kernel.org
In-Reply-To: <20261121-some-more-ai-fixes-v1-4-236e925d9b64@kernel.org>
References: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org>
 <20261121-some-more-ai-fixes-v1-4-236e925d9b64@kernel.org>
Date: Sun, 22 Nov 2026 10:50:29 -0500
Message-Id: <179536262938.412063.9413830491196612418.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-21 16:02 +0000, Lorenzo Stoakes (ARM) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> An execve() that fails to relocate its stack can underflow
> vm_committed_as, and the commit limit of vm.overcommit_memory=2 then no
> longer holds.
> 
> exit_mmap() uncharges vma_pages() of each VMA with VMA_ACCOUNT_BIT, so
> the charge has to match the size of the VMA. relocate_vma_down() expands
> the stack VMA by the relocation distance without a charge, and relies on
> its vma_shrink() to make the two match again. But it returns with the
> VMA still expanded if move_page_tables() can't allocate a page table,
> for example at the memory cgroup limit, or if vma_shrink() fails:
> 
>     relocate_vma_down()             charged    vma_pages()
>     ===================             =======    ===========
>                                     L          L
>     vma_expand()                    L          L + shift
>     move_page_tables() fails
>       return -ENOMEM
> 
>     exit_mmap()
>       tear_down_vmas()
>       vm_unacct_memory(L + shift)   -shift
> 
> On x86-64 with 4-level page tables, the distance is up to 16 GiB for a
> 64-bit program, and about 128 TiB for a 32-bit one.
> 
> Fix the issue by giving back the charge of the stack VMA where its
> relocation fails, and excluding the VMA from what exit_mmap() uncharges.
> The argument pages of the dying task are then outside the commit charge
> until exit_mmap() frees them.
> 
> Fixes: b6a2fea39318 ("mm: variable length argument support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

-- 
~Gregory

