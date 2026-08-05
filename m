Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAE8477991;
	Wed,  5 Aug 2026 16:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948908; cv=none; b=Ak9khUhw21v6HnfFiMu2AOaJDt6hBMqmlGIowe88MEwtXCuLpuoqS81X9E9TK1yhrSsnzbUSkcMvNdNMvtcP18MQF8Moax9hTQvoYFPEDZyoQkZfOhXJzBf9yltJ2j2EyqsTKw5BS3IptfGnJfclM3Yf8eyoVc5IPDRCKR5RHjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948908; c=relaxed/simple;
	bh=Sf0Tk+tP20TD0UdStM9peTKl+H9jFpV+CzkXEqhsAl4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uP/lx3UFssauyEGUDU5mg6HmkZCehmUcfXPYG2LVfn2pdW3NeAWAgGhnYM58YHZmLMydcWx6ZVf2vuNH8y5ENLBVD3rQMLVfyN6CPkbWfR+EnBu8tgNSpuPOS0DCyI71I1BPM1HuUg/tvV6fBv7cMdDqlWexHA+CStmB0lEj9RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=v2E4D0zr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="v2E4D0zr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AF31F00A3A;
	Wed,  5 Aug 2026 16:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785948906;
	bh=y/Xo6oFfSvfj1zh+rhXXcNboxnlTqNc3vaBkdgumDs8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=v2E4D0zrSHz84NoMOT/N5xD2ffO+tWDFQxb+rv7JssylOXqG/9CNmDq6w5SBv6Le6
	 cKl++OCnqbi+g96XX2whiBiZhAsEU430M8CwOeqTC7VjbdMRG+xZP7Qg6pAvqE9qqV
	 WvIervouVCFUIY3n97UiCgoh6bbQZwf6w0pxmnu4=
Date: Wed, 5 Aug 2026 09:55:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hao Ge <hao.ge@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Abhishek Bapat <abhishekbapat@google.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v3] alloc_tag: fix undetected compressed tag overflow
 when profiling is disabled
Message-Id: <20260805095505.1c2cbc150441cb20a74ba9bb@linux-foundation.org>
In-Reply-To: <20260805090633.141001-1-hao.ge@linux.dev>
References: <20260805090633.141001-1-hao.ge@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Aug 2026 17:06:33 +0800 Hao Ge <hao.ge@linux.dev> wrote:

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
> This silently corrupts /proc/allocinfo: allocated pages get attributed
> to the wrong call sites, so the statistics it reports are wrong.
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

Thanks.

AI review points at a cpuple of possible things, one pre-existing:
	https://sashiko.dev/#/patchset/20260805090633.141001-1-hao.ge@linux.dev

"Does this unintentionally result in a denial of service for module
loading, preventing critical drivers from loading when they otherwise
could have just disabled profiling and gracefully continued?" sounds
pretty obscure and I doubt if we care?
