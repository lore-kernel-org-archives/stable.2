Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE1035AC24;
	Tue, 13 Oct 2026 02:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791858676; cv=none; b=tZC7naY/emznaDIuz6l2cvcjjCCz/Xoe2B9MG6kUoh/47eMZq4vzktaLplESNdThKWQiCBS8oUwCerbA15VFUlrQP5EjsmigaLlKAAK300TfyZbyVoJQc77bdOM1u/fWKwJWOXw7Jk7TWtvlLoF8XVLUnUaghQ1/rQSMThBdJ7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791858676; c=relaxed/simple;
	bh=VVlDTCYpT4L/Bt6WCv3BFWtYDHtR4t8pJNJRYof18UU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=i258zza5kLF8JctJLeBEYyL78v7I+fq/O0fp5/9ZepI+BGl66JegFJAmiLvpo2cEtouZgsgBlnsxeoCXiVPnuQP80zjfAJ2ir61qUC1h5WlizOWEzVs3of55IzYEejG0sKKmwhHPIEUmB4hEaecAHb7KLqWhSOZNyZiaAOUkSqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ex3bO/Fc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ex3bO/Fc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AE01F00893;
	Tue, 13 Oct 2026 02:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791858675;
	bh=neF1X1SW8f+CZ9aYnUdm8uqTfZ53Y+iDZ67qd/EFbto=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ex3bO/Fc0+ngjO39stCKwVk9Hhrd7Rifhq8ICQiBsfVb3HzvVvtZSrGzLxkxqd+0U
	 VLhJbkRlvRhudx0ySSyQeBPTjSDeHdu/kDYU/bsXoTKFOYkEV6o2q2M5XgxrDd31WQ
	 PGabwoaz3EcC7qUr+ttZxY9i9xXwWCFmuR7C0n1Q=
Date: Mon, 12 Oct 2026 19:31:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Muchun Song <muchun.song@linux.dev>
Cc: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>, Muchun Song
 <songmuchun@bytedance.com>, David Hildenbrand <david@kernel.org>, Oscar
 Salvador <osalvador@suse.de>, Dave Hansen <dave.hansen@intel.com>, Paul
 Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, =?UTF-8?B?Qmo=?=
 =?UTF-8?B?w7ZybiBUw7ZwZWw=?= <bjorn@rivosinc.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, Alexander
 Gordeev <agordeev@linux.ibm.com>, Alistair Popple <apopple@nvidia.com>,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] mm: fix missing page-table destructor in
 pagetable_free()
Message-Id: <20261012193114.77147e0a43affa8ee1ae896c@linux-foundation.org>
In-Reply-To: <145CD5DC-6457-4E1E-8B9D-AE7D1EDB0AB8@linux.dev>
References: <20261010112457.49485-1-songmuchun@bytedance.com>
	<20261010112457.49485-2-songmuchun@bytedance.com>
	<asy-b7_C3SjnmSaS@gmail.com>
	<145CD5DC-6457-4E1E-8B9D-AE7D1EDB0AB8@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 12 Oct 2026 20:55:06 +0800 Muchun Song <muchun.song@linux.dev> wrote:

> 
> 
> > On Oct 12, 2026, at 19:15, Jose A. Perez de Azpillaga <azpijr@gmail.com> wrote:
> > 
> > On Sat, Oct 10, 2026 at 07:24:54PM +0800, Muchun Song wrote:
> >> Since commit 49f599666420 ("mm: call ctor/dtor for kernel PTEs"),
> >> pte_alloc_one_kernel() runs the page-table constructor for kernel PTE
> >> tables.
> >> 
> >> HVO (HugeTLB Vmemmap Optimization) uses pte_alloc_one_kernel() when
> >> splitting a PMD. Restoring the vmemmap backing pages does not collapse
> >> the PTE table, so a later memory hot-remove eventually frees it through
> >> pagetable_free() on x86-64. That releases the page without running the
> >> matching destructor and leaves NR_PAGETABLE elevated.
> >> 
> >> Make pagetable_free() detect constructor-backed pages and run the
> >> destructor before releasing their memory to fix the problem.
> >> 
> >> Fixes: 49f599666420 ("mm: call ctor/dtor for kernel PTEs")
> >> Cc: stable@vger.kernel.org
> > 
> > is the x86 case covered for 6.16-6.18? as far as I can see, x86
> > free_pagetable() only uses pagetable_free() since bf9e4e30f353
> > ("x86/mm: use pagetable_free()") in v6.19, so the backport wouldn't
> > change anything there. or am I missing something?
> 
> Yes, you are absolutely right — thanks for catching this.
> 
> I double-checked and indeed x86's free_pagetable() only starts using
> pagetable_free() since bf9e4e30f353 ("x86/mm: use pagetable_free()"),
> which landed in v6.19. So for 6.16-6.18 the prerequisite is not present
> and the backport would be a no-op there.
> 
> The correct trailer is:
> 
> Cc: <stable@vger.kernel.org> # 6.16-6.18: bf9e4e30f353: x86/mm: use pagetable_free()
> 
> Andrew, would you be able to update the trailer in the patch when you
> pick it up? If there are further review comments that require code
> changes, I'll fix this trailer as part of the v3 respin. Thanks a lot!

I don't know if/how the -stable maintainers handle a comment like that.
I expect it's more reliable to do this via Fixes:.  Possible?

