Received: from mta0.migadu.com (out-192.mta0.migadu.com [91.218.175.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527CD48AE10
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 12:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791809757; cv=none; b=KqJwi6eZdlCc0/HQ6YMN8QkFuOO5iS2TigUPFO893qh6BtOiqq9ZnRahdQdMQUjh0G8Ixy8Wxg8KF50PD4MA5Pg/V38gAAX+/iVnkmfqPb17G1NwJRFP0J0yDwAHinGYRI1Ar1w908D9j2/Fr8qtHcxi8AQ9NZnHvMG5C3eIEDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791809757; c=relaxed/simple;
	bh=zVdDm9vWio9URlOBbk5H1FhupUhm6ZtZOBzYo8Bfqf8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=RqYF4yjfFqR5DcGkj6HWrO/H8T6aJnnq5JpmWrToftc0RsyUhv1bWcUtuKr8OKplnCebzYxo8ccISpiDIAcDs3ddya0D1fsGKYD+171fotaPcskCeYgWHFj7OGTA4oztV+sMKKUPefbk15WyBUoi14Q8NUf25SEoRaxJL4tsw6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XAu/7C3r; arc=none smtp.client-ip=91.218.175.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XAu/7C3r"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=zVdDm9vWio9URlOBbk5H1FhupUhm6ZtZOBzYo8Bfqf8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791809752; v=1; x=1792414552;
 b=XAu/7C3rb/MZ5dpABy25laQ+yvYFKm3jheT5YLO5dLGM8GxZNKSkbbWwuhJ9SEenvzOqbKe+
 0YxDDs/UTQYCjF5V5k4VSp8AhWwcF4nVcYAW6TY0rLP0PqMN9sj3YrGtoc3RhOdNrYZ7YO3XjJi
 GbkgpeK1G0tNxMZ7rEWHlVR4=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 018eb001ca5c019a;
	Mon, 12 Oct 2026 12:55:25 +0000
X-Mizu-Trace-ID: 018eb001ca5c019a
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH v2 1/4] mm: fix missing page-table destructor in
 pagetable_free()
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <asy-b7_C3SjnmSaS@gmail.com>
Date: Mon, 12 Oct 2026 20:55:06 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 David Hildenbrand <david@kernel.org>,
 Oscar Salvador <osalvador@suse.de>,
 Dave Hansen <dave.hansen@intel.com>,
 Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>,
 =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Alistair Popple <apopple@nvidia.com>,
 linux-mm@kvack.org,
 linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <145CD5DC-6457-4E1E-8B9D-AE7D1EDB0AB8@linux.dev>
References: <20261010112457.49485-1-songmuchun@bytedance.com>
 <20261010112457.49485-2-songmuchun@bytedance.com>
 <asy-b7_C3SjnmSaS@gmail.com>
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 12, 2026, at 19:15, Jose A. Perez de Azpillaga =
<azpijr@gmail.com> wrote:
>=20
> On Sat, Oct 10, 2026 at 07:24:54PM +0800, Muchun Song wrote:
>> Since commit 49f599666420 ("mm: call ctor/dtor for kernel PTEs"),
>> pte_alloc_one_kernel() runs the page-table constructor for kernel PTE
>> tables.
>>=20
>> HVO (HugeTLB Vmemmap Optimization) uses pte_alloc_one_kernel() when
>> splitting a PMD. Restoring the vmemmap backing pages does not =
collapse
>> the PTE table, so a later memory hot-remove eventually frees it =
through
>> pagetable_free() on x86-64. That releases the page without running =
the
>> matching destructor and leaves NR_PAGETABLE elevated.
>>=20
>> Make pagetable_free() detect constructor-backed pages and run the
>> destructor before releasing their memory to fix the problem.
>>=20
>> Fixes: 49f599666420 ("mm: call ctor/dtor for kernel PTEs")
>> Cc: stable@vger.kernel.org
>=20
> is the x86 case covered for 6.16-6.18? as far as I can see, x86
> free_pagetable() only uses pagetable_free() since bf9e4e30f353
> ("x86/mm: use pagetable_free()") in v6.19, so the backport wouldn't
> change anything there. or am I missing something?

Yes, you are absolutely right =E2=80=94 thanks for catching this.

I double-checked and indeed x86's free_pagetable() only starts using
pagetable_free() since bf9e4e30f353 ("x86/mm: use pagetable_free()"),
which landed in v6.19. So for 6.16-6.18 the prerequisite is not present
and the backport would be a no-op there.

The correct trailer is:

Cc: <stable@vger.kernel.org> # 6.16-6.18: bf9e4e30f353: x86/mm: use =
pagetable_free()

Andrew, would you be able to update the trailer in the patch when you
pick it up? If there are further review comments that require code
changes, I'll fix this trailer as part of the v3 respin. Thanks a lot!

Thanks,
Muchun

