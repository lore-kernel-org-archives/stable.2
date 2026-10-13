Received: from mta1.migadu.com (out-106.mta1.migadu.com [95.215.58.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF75381EBD
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 02:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791859850; cv=none; b=knD3izNlpOWnX82oTzcJYTMeIEQXDf8R2AiRlzNuKqSU9WCCQ8piSYf2xw3h+pnPr4OGHDRfP9u7kMvLBSN6IycQqEgCAjTQXTbPDxAFhCFbUKPZk6eI6ZUh1JWELO3IkX2eZI+oz0kRpaPtrXp6gag6ggmu4Lll8atC8LF+hVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791859850; c=relaxed/simple;
	bh=8wMdqUD76bepHOzOME5xbGf9H6wBMPJCOauRyfPWxJE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ubg72RDhNf/v0rPE9horKYShRdwMFYaj/yOtkkCmCxGjS5SZgC9wYj1WJLDf9XxeuAX+yVJeq4L57ENXHcT0pvq8VgooCKupRmaWX2KEVXGWilK4AIHEidaG62M2LpjUXGysF12ZnwMcR+Fn5l7Q+l8YpWszHhl4EeILKeKFV3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oNPtqFiX; arc=none smtp.client-ip=95.215.58.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oNPtqFiX"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=8wMdqUD76bepHOzOME5xbGf9H6wBMPJCOauRyfPWxJE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791859845; v=1; x=1792464645;
 b=oNPtqFiXxOnTU0X6djyqNB5Ani+3gr1I6RXWS1BqRJvAY16ZMR4dOS8JM5773LU8YHIiFcjn
 Bv1zvPpk1o0kxvVbA+SeDa2/4LNFdl6no0YIWSlHSQSsaH5xf3Rwttgyrl7E+zB/DFCIZSlN+8C
 ChXlTFK6PauB81+RAz+tia2g=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a849ca26c8b26880;
	Tue, 13 Oct 2026 02:50:38 +0000
X-Mizu-Trace-ID: a849ca26c8b26880
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
In-Reply-To: <20261012193114.77147e0a43affa8ee1ae896c@linux-foundation.org>
Date: Tue, 13 Oct 2026 10:50:21 +0800
Cc: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
 Muchun Song <songmuchun@bytedance.com>,
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
Message-Id: <200A83B9-233C-44C7-B4AF-0900BA1E09DF@linux.dev>
References: <20261010112457.49485-1-songmuchun@bytedance.com>
 <20261010112457.49485-2-songmuchun@bytedance.com>
 <asy-b7_C3SjnmSaS@gmail.com> <145CD5DC-6457-4E1E-8B9D-AE7D1EDB0AB8@linux.dev>
 <20261012193114.77147e0a43affa8ee1ae896c@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 13, 2026, at 10:31, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Mon, 12 Oct 2026 20:55:06 +0800 Muchun Song <muchun.song@linux.dev> =
wrote:
>=20
>>=20
>>=20
>>> On Oct 12, 2026, at 19:15, Jose A. Perez de Azpillaga =
<azpijr@gmail.com> wrote:
>>>=20
>>> On Sat, Oct 10, 2026 at 07:24:54PM +0800, Muchun Song wrote:
>>>> Since commit 49f599666420 ("mm: call ctor/dtor for kernel PTEs"),
>>>> pte_alloc_one_kernel() runs the page-table constructor for kernel =
PTE
>>>> tables.
>>>>=20
>>>> HVO (HugeTLB Vmemmap Optimization) uses pte_alloc_one_kernel() when
>>>> splitting a PMD. Restoring the vmemmap backing pages does not =
collapse
>>>> the PTE table, so a later memory hot-remove eventually frees it =
through
>>>> pagetable_free() on x86-64. That releases the page without running =
the
>>>> matching destructor and leaves NR_PAGETABLE elevated.
>>>>=20
>>>> Make pagetable_free() detect constructor-backed pages and run the
>>>> destructor before releasing their memory to fix the problem.
>>>>=20
>>>> Fixes: 49f599666420 ("mm: call ctor/dtor for kernel PTEs")
>>>> Cc: stable@vger.kernel.org
>>>=20
>>> is the x86 case covered for 6.16-6.18? as far as I can see, x86
>>> free_pagetable() only uses pagetable_free() since bf9e4e30f353
>>> ("x86/mm: use pagetable_free()") in v6.19, so the backport wouldn't
>>> change anything there. or am I missing something?
>>=20
>> Yes, you are absolutely right =E2=80=94 thanks for catching this.
>>=20
>> I double-checked and indeed x86's free_pagetable() only starts using
>> pagetable_free() since bf9e4e30f353 ("x86/mm: use pagetable_free()"),
>> which landed in v6.19. So for 6.16-6.18 the prerequisite is not =
present
>> and the backport would be a no-op there.
>>=20
>> The correct trailer is:
>>=20
>> Cc: <stable@vger.kernel.org> # 6.16-6.18: bf9e4e30f353: x86/mm: use =
pagetable_free()
>>=20
>> Andrew, would you be able to update the trailer in the patch when you
>> pick it up? If there are further review comments that require code
>> changes, I'll fix this trailer as part of the v3 respin. Thanks a =
lot!
>=20
> I don't know if/how the -stable maintainers handle a comment like =
that.
> I expect it's more reliable to do this via Fixes:.  Possible?
>=20

Thanks. I used this format because it is explicitly documented by the
stable kernel rules.

The shell-style comment is the format documented in
Documentation/process/stable-kernel-rules.rst for specifying additional
patch prerequisites:

  Cc: <stable@vger.kernel.org> # 3.3.x: <commit>: <subject>
  Cc: <stable@vger.kernel.org> # 3.3.x

See:

  https://docs.kernel.org/process/stable-kernel-rules.html#option-1

A Fixes tag alone cannot express this dependency. It does not specify
an additional commit that must be cherry-picked first. The documented
Cc comment provides both the prerequisite and the required cherry-pick
order.

Would this be sufficient for the stable team to pick up the =
prerequisite?

Thanks,
Muchun


