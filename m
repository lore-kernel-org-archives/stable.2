Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F298A25CC74;
	Mon, 12 Oct 2026 15:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819357; cv=none; b=APAnWzBxc3ZG0W/+cLA/MlCCx+t2Jv8iqtiUSjqomdfLQ/EU/vfqHvCBIoGo/2o/zBjuQ0GKvB5rOdxrmuDSdPpWMTw5pA9bEd0tRJRPfF1R600obaJh1cN7DrtPNGH4Vdb24CUzM8jr00I1Ru2qipuoBVFuPXU5xQ8HO/d4hJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819357; c=relaxed/simple;
	bh=3NlCppqlh9IN+OUBU1U01H7S97jTJiDfAUXtzFgU1ic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lOZXeBUfwI97Sc4PAPwj+IS6c9oibI6YJV3dECv6nKzgByIFEYyBlE314xe/cmmaLOIr1mZDmDeihbH2yMZjL22LIXZ4+jve43ZC1v+G9Y5GSK2oRXCCNOe0fgI2v8tDcpPJ+bceUiiRpHSiMMikIpnvdDu3v/6ldmKgLKeltBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fDeKJRIQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fDeKJRIQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4809D1F0089B;
	Mon, 12 Oct 2026 15:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791819356;
	bh=3NlCppqlh9IN+OUBU1U01H7S97jTJiDfAUXtzFgU1ic=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=fDeKJRIQoUWqxjV7n4Ky9J09n+IIRHAAi7VsV3lDRQxJgy0ajNzavSe2IJZmQo8C+
	 RFQGyiEnACBiv5JFmeVZTOsdi3v30Gj4yk94TzBtLIIO8a3K+zzt3e2kYb/MpOqpsN
	 S/+jNKrosp68mtox8Fy1xkpF6qC5OhaodQPuyRKoiXo40wqvP6dkzgXSUl3tGh6DUW
	 fnVEzWB+2DotZlfr0oTJcLRUG8dNtWoNaCE2loO2fTGN+IDvS2QOpYPUOxhhMsPF3O
	 bMByXt7/Tkqi/81h6Ol/avfWmWeC0EoLgSqd26mtPqr6YaHXb00BhQkpkPtrGZfDyn
	 ba5o9eQotuKzg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>, Oscar Salvador
 <osalvador@suse.de>, Dave Hansen <dave.hansen@intel.com>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, =?utf-8?B?Qmo=?=
 =?utf-8?B?w7ZybiBUw7ZwZWw=?=
 <bjorn@rivosinc.com>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Kevin
 Brodsky <kevin.brodsky@arm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Alistair Popple <apopple@nvidia.com>,
 linux-mm@kvack.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Muchun Song <muchun.song@linux.dev>, Muchun Song
 <songmuchun@bytedance.com>
Subject: Re: [PATCH v2 3/4] riscv/mm: fix missing destructor for hotplug PUD
 tables
In-Reply-To: <20261010112457.49485-4-songmuchun@bytedance.com>
References: <20261010112457.49485-1-songmuchun@bytedance.com>
 <20261010112457.49485-4-songmuchun@bytedance.com>
Date: Mon, 12 Oct 2026 17:35:53 +0200
Message-ID: <87a4ojaq3q.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Muchun Song <songmuchun@bytedance.com> writes:

> Commit 8472cc4503eb ("riscv: mm: call PUD/P4D ctor in special kernel
> pgtable alloc") made alloc_pud_late() run the PUD page-table constructor.
> However, free_pud_table() still frees non-reserved PUD tables directly
> without decrementing NR_PAGETABLE.
>
> Free PUD tables through the common free_pgtable_page() helper so that
> constructor-backed tables run the matching destructor before being
> freed.
>
> Fixes: 8472cc4503eb ("riscv: mm: call PUD/P4D ctor in special kernel pgta=
ble alloc")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
