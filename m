Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0403412C0C;
	Tue,  4 Aug 2026 19:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785872628; cv=none; b=JGleQGBcf2mS/7o9wNnitcvT1dwXXQluBHuj4BX0uIScA2G7mMmFc1LD8Dbjxefjw3NrRyycNGsNfX0GsAX8hjzKSRK+XlMWyLhST75xstVOsTrwr1GTw+V3Lvl53cRVYKRaU+qc6lZ9KwlDMvcqNfcjS0NDLAM/0kBF0mfR4ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785872628; c=relaxed/simple;
	bh=fZk5onsBqhiFIMmR2TtI+PwD54TDRWm+bHwCstALtnw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cJZqcAE0KIv4P8Anxb0WGvHoWZTYZjYd0ZQAIqEsL8oAi/6FrCShI59kakrsTdhUzRr1ptceO9EvpxPecDdf8gh8JkrgnA5rCGR+K4tDqdbKS0KCSiJamVK0fmCrKlt14mas1YFcLiGfnCWn2spfNclIaLX1B7rGgkosbl0JTXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tYyrcYU5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="tYyrcYU5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2448C1F000E9;
	Tue,  4 Aug 2026 19:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785872627;
	bh=InoaC7aRrB/aQ5R5WbCZ9FBzBR+fu6Rt3YL3UZFeJcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=tYyrcYU5qjQvwTyu8VyXMz3Lx36L3PQmSZOB/npx+5K4bmADqOcJVdFHiiFI5yK2d
	 Ihen5TEl74Gwi7/vyQBMv9fy9fTB1orsbUk7yxt0MOi+VapoTwnDG/EptsKBZbsLLX
	 06Uk3IhYjkzTAL1M41p8iJhqRAI/ixLfrd0qIuus=
Date: Tue, 4 Aug 2026 12:43:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hao Ge <hao.ge@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Abhishek Bapat <abhishekbapat@google.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] alloc_tag: fix undetected compressed tag overflow
 when profiling is disabled
Message-Id: <20260804124346.15e4be960ca4ac739f740248@linux-foundation.org>
In-Reply-To: <20260804122038.190270-1-hao.ge@linux.dev>
References: <20260804122038.190270-1-hao.ge@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Aug 2026 20:20:38 +0800 Hao Ge <hao.ge@linux.dev> wrote:

> In reserve_module_tags(), the tag overflow check is gated on
> mem_alloc_profiling_enabled():
> 
>     if (mem_alloc_profiling_enabled() && !tags_addressable())
> 
> If profiling is toggled off at runtime and a module is loaded whose
> tags exceed the compressed-mode limit, shutdown_mem_profiling() is
> skipped. vm_module_tags_populate() still maps memory for the tags and
> the module loads successfully, but the total tag count now exceeds what
> NR_UNUSED_PAGEFLAG_BITS can address.
> 
> Once profiling is re-enabled, ref_to_idx() computes each tag's index
> as its position in the alloc_tag array. update_page_tag_ref() masks
> it to alloc_tag_ref_mask before storing in page->flags. Indices
> beyond the mask are truncated and idx_to_ref() resolves them to wrong
> tags.
> 
> mem_alloc_profiling_enabled() and mem_profiling_compressed are
> independent. Once compressed mode is established at boot, it stays
> active regardless of runtime toggles of mem_profiling.
> 
> Remove the mem_alloc_profiling_enabled() guard. Also return an error
> after shutdown_mem_profiling() to skip vm_module_tags_populate(), as
> the mapped pages would never be reused - shutdown_mem_profiling() sets
> mem_profiling_support to false, so no future module load enters the
> codetag path.

Thanks.  Sashiko pointed at a few things, one pre-existing.
	https://sashiko.dev/#/patchset/20260804122038.190270-1-hao.ge@linux.dev

Is there any sanity in there?
