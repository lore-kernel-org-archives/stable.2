Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB5E39DBC0;
	Tue,  4 Aug 2026 23:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886957; cv=none; b=lZVQtV7wnplDgTSkXpS3jzu9NArU+P0GA+liDBi2L9boZi+tS0zxViVLQAyWPEHP0tRl57z2QXIPBQumE+hle/CPMbQxwNkGZJdC4qhh+cKJCct8aSkOsz+PK8VMXNUT9aVVxk3r0CJX1IJk4jPZkTMSvVTpHGoBK1CgpgxXv4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886957; c=relaxed/simple;
	bh=RuRtTjLqiutuJOktyF0xgdLiFCL8F1JbOEEXWTXnwds=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=K04bis2OKkoD60jiqHEDN7+xNKFEPcQ/SPdPsr8RVhnJGVuXe6VNcXg1W40ube1w9dRTfsbzWoJcYj1LsQqTB0ajh7s7szhAwA8gEW0TF/cbc36ip6AvHIxG/bbJFDKBpVhVgft6EFCwl5AgtqQ8N3C9F/qh+nweR6VaLDAMiVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=l69+uLQL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="l69+uLQL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78631F000E9;
	Tue,  4 Aug 2026 23:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785886956;
	bh=NBd1rwNWfwuAmmO/dMbZ4a3bEEwd3WjdrKV1S3LKHaU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=l69+uLQLaueo+kUy81oaqCg604IuBYcBj99+Xa4QOJ3UnC7oPzW++BUGer7yFKkpL
	 NQBTuh8fnTX5w4DYSlrEC62FZwYfCEujKbH3nRAKcP24mseR/14c2EsGT5neIfwdUC
	 40xG9LMtdeH5dWu58QdOLFCSEhpEq3Wm3qONH9Ss=
Date: Tue, 4 Aug 2026 16:42:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hao Ge <hao.ge@linux.dev>
Cc: Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Abhishek Bapat <abhishekbapat@google.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] alloc_tag: fix undetected compressed tag overflow when
 profiling is disabled
Message-Id: <20260804164235.69c9473cf00ac70cd2e7ed4a@linux-foundation.org>
In-Reply-To: <20260804064408.105033-1-hao.ge@linux.dev>
References: <20260804064408.105033-1-hao.ge@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Aug 2026 14:44:08 +0800 Hao Ge <hao.ge@linux.dev> wrote:

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

With bad effects, one assumes.

When fixing a bug please always include a complete description of the
userspace-visible runtime effects of that bug.

> mem_alloc_profiling_enabled() and mem_profiling_compressed are
> independent. Once compressed mode is established at boot, it stays
> active regardless of runtime toggles of mem_profiling.
> 
> We therefore remove the mem_alloc_profiling_enabled() guard.

It appears that AI review has found a pre-existing error-path cleanup
issue:

	https://sashiko.dev/#/patchset/20260804064408.105033-1-hao.ge@linux.dev
