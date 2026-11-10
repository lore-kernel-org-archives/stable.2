Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327794;
	b=U27qWcF5NiOosx7bkqoKWnprVl4VAdOKwhoscEDDUnxh3nk5kMYgiNtCqXmY47d1GmHl
	 FkFJYS80B2SFl2PEm9gdwD8aixaRsj1KaqrseCc0dCO3wywfVLgAdGZT0ByGD50hLuk0G
	 E852FWNFaWcixmUdlvsa9isup72Do0NPtC2TB84LFYVjTtgWDGn5HWKV6mWdi4miaEzK+
	 W888rydEuqGY1W5VGV83BnqnvuN9vE2gmNQPljd0K3GqD5qgSQv5mzBaH9GgJsfzPmnIW
	 ej2l5A85EmIOaZq1+Jyjfc706fsFIJRK2eRTC67pjqzsD6a2M49YAT512SyeE6vvf6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327794;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=9YuRkRGnxp0vWQ1dHMpnKuM8tkA2uFdXTQzJ8jzW5DI=;
	b=NwdI61t8tJ69o/yQWSSGRW+k6VaCAR3v5xkh4ASjlaalxBZtI5vJqkO9/mTtw8GF7Lox
	 Oca915Ig9Lr5+KEB2ilgTFxvW3Locy5LvPS9eIu2BTsWFKcLlJD1d20HzXVFa09xhVg7z
	 kl73LvyzXwMGPeefFmfU6PofOk7o2pX/K/yfSPvwLUrHTvdwm024oeQNR/EwloscALJLA
	 7FcSErX5vgqkl20smsEpb4DorSr7nEev6mkMJIb3vrCPMpMVBfW1RkCxD7Ud0CyKgUWVf
	 pBoRLWLcxEtNeqzBXPfZMZXX6+/iwWb0KzkgLXO10nBYmWS9VwjDnt2TfIrq52r74Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=debian.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47DF606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:23:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C47DF606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b305d38bafso17397467b3.3
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 08:23:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794327793; x=1794932593;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9YuRkRGnxp0vWQ1dHMpnKuM8tkA2uFdXTQzJ8jzW5DI=;
        b=YIhrYSmupAlru6IIMBE0RtOHewlq03R2ibshwV/fV41ht1hyEu+P8bEU0ECxtUPGVo
         HyQo9EKB4JvK24fALLZ0xmZFBnUU/RFxtfCwfBL41Tr0Pp9xiJe6CWc3SIxikoD/2kc5
         36m4WQerQhdTISs5sFwwHejJ5Qp7cdgxkLkJN2dbEto0HZc2gMFNTLEz7kZDzHZmBooi
         7bGPYZG8mcdJyt7ZMc8xhdCHZ2tmiP4pZ6Qi+j4XWhUERcvy76JNTh4PAJbvM0qOomPK
         Ftz8bBB+WbfUtVKMPa3t+GGw7Y/7Xdzjlq9LxE4otA2xMNB/ISTHX2CtBTzHNFd8QCDx
         qRRg==
X-Forwarded-Encrypted: i=1; AL+hErG0pqKuAK99m1ddLgrr3wUL+Q7epQOiv9JQqoG/FnzNg07+SerRAPwFiUdybvicpr0uCy4EvMM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Iaz3WbhNJ9LaqfZZyJenk2w237pOc8E2nT/3pe4XRXUgNY2/f
	YgLuetyigAbRXXal/13HKTvNg/FO5AJVtNW15QRGR8Na2PLmf5zPSPhg
X-Gm-Gg: AYBFou3jbHTH7iZ2M6phAAFW02YtE1oXUfmahmmZ5+0NlaLAeaKAWn7Z6dZKYLLTIJn
	0GSfJ6FCQmDdx9aVxDKzgaDU+C22dJcTJbLLAGRR52JAuGdmOJAqae2ksIPUXGeA4UVGhz9tna7
	jhQAKhVQc7ErmNOJ2/E2thLHq7O6D1UZw61VpXbFAZ+dQVGORVmJRHbi/twwHqCOszIFC0OiIRs
	ErVGLm2Q4X5XAMjeUtejUkzjlMsyEnp+9N5rCBIif3WcmzM+zWIR302MXrQFKJotJvzNlGFRKba
	OkoCHdfOR6W8tFpKs5K8Hl2J0TFLYA4hgrbN+xwxyl2JcpZJZoeSoLmOY/4uHrO4r9jVK3G/hPm
	ubVpb0cp3Vci0jrAOx+ck+WqyW1+RWVKNb5oEXGCn3BhtbyLeYepW87l2zR/u5fyp0e93de+UlK
	pGmtf5aTDrmu+OPXgPb/kkJS5ufcLG5ERkVMC43Y3ngTi62mzVDznzbI1/qQHlqZDnLK6hftWg3
	qjEL7w9oPGzMwtXXYVlBaoJ1NQ1YduG86yIBXISuw4kSljeIZUAt87SPFn9mcCmqVZ2uABd4CYM
	oyWeHQTx+FX79Yo3u68=
X-Received: by 2002:a05:690c:6607:b0:8b1:901:b9ee with SMTP id 00721157ae682-8b392a58fdcmr20600847b3.13.1794327792882;
        Tue, 10 Nov 2026 08:23:12 -0800 (PST)
Received: from gmail.com ([2a03:2880:24ff:6::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b39324bbf5sm22932117b3.1.2026.11.10.08.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 08:23:12 -0800 (PST)
Date: Tue, 10 Nov 2026 08:23:11 -0800
From: Breno Leitao <leitao@debian.org>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@kernel.org>, stable@vger.kernel.org, 
	Sashiko AI review <sashiko-bot@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/6] fs/proc/task_mmu: fix make_uffd_wp_huge_pte()
 prot-update race
Message-ID: <avNEgmvYdoukt6MS@gmail.com>
References: <20260529172331.356655-1-kas@kernel.org>
 <20260529172331.356655-2-kas@kernel.org>
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
In-Reply-To: <20260529172331.356655-2-kas@kernel.org>

Hello Kiryl,

On Fri, May 29, 2026 at 06:23:25PM +0100, Kiryl Shutsemau (Meta) wrote:
> The non-hugetlb sibling make_uffd_wp_pte() does this correctly via
> ptep_modify_prot_start() / ptep_modify_prot_commit(). Mirror that
> pattern for the present-PTE branch. The migration case stays as-is --
> migration entries are non-present, so there's no hardware update to
> race against.

I am  seeing this on next-20261109 (arm64, PAGE_TABLE_CHECK) while the
pagemap_ioctl kselftest runs next to a workload that migrates pages:

    WARNING: mm/page_table_check.c:206 at __page_table_check_ptes_set+0x168/0x178, CPU#21: pagemap_ioctl/894691
    Call trace:
     __page_table_check_ptes_set+0x168/0x178 (P)
     __set_ptes_anysz+0x50/0x240
     make_uffd_wp_pte+0x104/0x1c8
     pagemap_scan_pmd_entry+0x1b98/0x1df8
     walk_pgd_range+0x7b4/0xd00
     __walk_page_range+0x108/0x510
     walk_page_range_mm_unsafe+0x150/0x3e8
     do_pagemap_cmd+0x418/0x7d0
     __arm64_sys_ioctl+0xc08/0x1338

given you've touched this recently, I am wondering if you've seen it.

--breno
