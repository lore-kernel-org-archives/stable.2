Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621BE3A785D;
	Fri, 16 Oct 2026 02:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117222; cv=none; b=EDpzq1CKTrCgPvOlbXv9UqtEO3oP1ratWj5FIQg91P97sqezKU5h/aieVKMm9lD5UaSQGTNAkc3ksVs5E9uK5sV7xBCj7oCasXenaZUhFq5GB60sgOjNwrauCxdEcjYb/wu17a0FK8FjpUHb9/dyjtmhrPcKPVHfDRC7/NJsU10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117222; c=relaxed/simple;
	bh=aAkxculb6WK4een+nld2HVoM1WmI83TH7/WRDQHGBa0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oUjWXxJ0LMWK8uVkTc/6Cjb+rYsksIKO5BZZia3iF0d4QfhQSueyblIJZC+D6acvcKilwivCJ7UKylJYhPYxBhvfEcmBwfGqshDW7btNyjqNOPEkzFGg76F6hpdsthPA0kvROuyfQ0tO2q0klJMp4mejL/XZ5PrPv3utGFxhLqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hf/APCPv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hf/APCPv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CA431F000C4;
	Fri, 16 Oct 2026 02:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1792117220;
	bh=lmL800MhDzqLz11aGRmfqIVYdCooWhPvfrmpDQYpZBo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hf/APCPvm4wO/kVP8/Srv8sXIFsas6E4gZK6pVCUvfbV5Y54ulJdT94YVhW90h8n+
	 5ZkvXCiNDfMlGLRjyYGJsOkQz6sX3kKaSWEVFdw4tguDytc1qG7n48LiDQZOtrGvrI
	 PbeVzE0va94hMd5hKv51ZgPiQbvr7cBuaGyEiFxk=
Date: Thu, 15 Oct 2026 19:20:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kyle Zeng <kylebot@openai.com>
Cc: linux-mm@kvack.org, David Hildenbrand <david@kernel.org>, Lorenzo
 Stoakes <ljs@kernel.org>, Rik van Riel <riel@surriel.com>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka
 <vbabka@kernel.org>, Harry Yoo <harry@kernel.org>, Jann Horn
 <jannh@google.com>, Lance Yang <lance.yang@linux.dev>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/page_vma_mapped: continue past nonmatching huge PMDs
Message-Id: <20261015192020.5336a49bc516219e8254dfdf@linux-foundation.org>
In-Reply-To: <20261016011549.61146-1-kylebot@openai.com>
References: <20261016011549.61146-1-kylebot@openai.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 18:15:49 -0700 Kyle Zeng <kylebot@openai.com> wrote:

> A PTE-mapped large folio can straddle PMD boundaries after an unaligned
> mremap().  If the first part is discarded and replaced with an unrelated
> huge PMD, page_vma_mapped_walk() stops instead of looking for the rest
> of the folio in subsequent PMDs.
> 
> This also affects migration entries.  A walk that stops at an unrelated
> huge PMD can leave migration PTEs behind when migration or an anonymous
> folio split restores the mappings.  Those entries do not hold mapping
> references and can outlive the source folio.
> 
> Skip the current PMD rather than ending the walk on a flag or PFN
> mismatch.  Do the same if the PMD became nonpresent before the locked
> recheck.  Release the PMD lock, clear the per-PMD state and advance with
> step_forward(), so the existing range limit controls termination.
> This covers present, migration and device-private huge PMDs while
> preserving the matching-PMD and split-to-PTE paths.

As always, when fixing a bug please describe the worst-case
userspace-visible effects of the bug.

I asked $LLM and was told

: The worst credible effects are permanent application hangs, kernel
: crashes, and potentially system-wide denial of service.  Stale
: migration entries can refer to freed and reused physical pages, causing
: page faults to access unrelated folio metadata.  Memory corruption is
: possible but unproven; cross-process information disclosure has not
: been established.

But you have an LLM too!  So please never again send a bugfix without
this info.

Also please explain whether there's a reproducer and if so, at least
describe it and confirm the before-and-after results.

Thanks.

