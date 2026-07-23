Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4B4391E52;
	Thu, 23 Jul 2026 23:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784849556; cv=none; b=KTjv77OpWuQcWRjpqbw34FdqOOqlmToCLc1fbiLToHfd0cm832QjtyTEkmQnGcp+GINA3oPBcHZ+lNMeqeJwtGcBilNCqXgEV63dXog69zNNNSVQ3CxCmgkHZttSu/ibZv1rqWEsqEliZWC77JHBCLseMIkJ1AabqCB9/31WtCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784849556; c=relaxed/simple;
	bh=DhcPr1E0/na9mfbJXUIZ+2IXD+/BRaGW53Xlk3czF2c=;
	h=Date:From:To:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=unAzv6gTHy06JdPm9weBIpRQp1N2/vUQ2RCQEbEWV2cPh4ZhrKGzLa3oWteG+Ak5HZD+ImsMjK3QeeIuPJCy1K41e1ZPHxXH4r7RMEZ2khnMEy91Vn5Y/+jDLoXefd7kfwlKlyZgJlofWWltQFHsljNRJkpKonY6LlK/hhaOYeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=f/SknRcI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f/SknRcI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3451F000E9;
	Thu, 23 Jul 2026 23:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1784849554;
	bh=Hnn7yL0Nr/R1HUS7NQmyspKVad9BEXrUGyw69tYwFFg=;
	h=Date:From:To:Subject:In-Reply-To:References;
	b=f/SknRcIQDU4nSUdLwTCBM+cM+91dauPs197nxRVx1N0wb3jnV3jCafryW7ZOFFW6
	 mpHT5EbCorhe2AhynbP7TbxpHlTRIDogQW4O+ytb05thuP2OtJXAZzs0IZuCW5mmz3
	 fqGiOHS6IgLSc55WYASy9ioVTGMC6KCSVKazcJ9U=
Date: Thu, 23 Jul 2026 16:32:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, "Liam R. Howlett" <liam@infradead.org>, Vlastimil
 Babka <vbabka@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, David
 Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, Michal
 Hocko <mhocko@suse.com>, Uladzislau Rezki <urezki@gmail.com>, Toshi Kani
 <toshi.kani@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Kiryl
 Shutsemau <kas@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>, Ryan Roberts
 <ryan.roberts@arm.com>, David Carlier <devnexen@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, "Denis V. Lunev" <den@virtuozzo.com>,
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 stable@vger.kernel.org,
 syzbot+fd95a72470f5a44e464c@syzkaller.appspotmail.com
Subject: Re: [PATCH mm-hotfixes v6 0/5] mm: fix UAF caused by race between
 ptdump and vmap pgtable freeing
Message-Id: <20260723163233.54b38cfc682a25eb6edf7cc7@linux-foundation.org>
In-Reply-To: <20260723162646.350cf3bf415a0855140d139b@linux-foundation.org>
References: <20260723-series-vmap-race-fix-v6-0-8cc77dcc0018@kernel.org>
	<20260723162646.350cf3bf415a0855140d139b@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 16:26:46 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:

> @@ -1250,7 +1251,11 @@ static int split_large_page(struct cpa_d
>  
>  	if (!debug_pagealloc_enabled())
>  		spin_unlock(&cpa_lock);
> +	if (cpa->init_mm_read_locked)
> +		mmap_read_unlock(&init_mm);
>  	ptdesc = pagetable_alloc(GFP_KERNEL, 0);
> +	if (cpa->init_mm_read_locked)
> +		mmap_read_lock(&init_mm);
>  	if (!debug_pagealloc_enabled())
>  		spin_lock(&cpa_lock);
>  	if (!ptdesc)

btw, this affects your later "x86/mm/pat: allocate split page tables as
kernel page tables".  Which I resolved thusly:

static int split_large_page(struct cpa_data *cpa, pte_t *kpte,
			    unsigned long address)
{
	pte_t *pte;

	if (!debug_pagealloc_enabled())
		spin_unlock(&cpa_lock);
	if (cpa->init_mm_read_locked)
		mmap_read_unlock(&init_mm);
	pte = pte_alloc_one_kernel(&init_mm);
	if (cpa->init_mm_read_locked)
		mmap_read_lock(&init_mm);
	if (!debug_pagealloc_enabled())
		spin_lock(&cpa_lock);
	if (!pte)
		return -ENOMEM;

	if (__split_large_page(cpa, kpte, address, pte))
		pte_free_kernel(&init_mm, pte);

	return 0;
}


