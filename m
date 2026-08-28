Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861E9286A4
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 05:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787894652; cv=none; b=avk0rHZlqN1FO45T2ygamE7m5F/vBaYbLHR/yi38oDEMckxrxrEQGgsmSwT2w0pLv1InOCNZq3OJ1McAwpsrk+lX08pefT8krWReHPSwMklavouiSTLTQyBOu8ozAZ9LKSZRR9qlLN33QmFXhjWKKLmoHFtt+kiyM+YI7Ow+oH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787894652; c=relaxed/simple;
	bh=K+ZoWSvdtuv+zp7fG7QQ4He3HE7k/kZ2282FdtBWhCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U8FW76Lu5ligjcxJ9KphzZyAcBo6jZuZphe8xW6fdH6nF0HdfKxDbEJjSD2jS36RHVw7IVdkPFLJ3iGNW1Mpr3/vtxjDi+0+KZy+IptCsgDeo0HcM5s7abzB3IACSYHqVl/zqpWyuxLj+SXjKHT3os5om/OEHoHrbJYGMG7txIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lwpsk4tp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lwpsk4tp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA3B1F000E9;
	Fri, 28 Aug 2026 05:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787894651;
	bh=5j+FCz4rKjoj80q7E14FFvYQ8g8rZBJjtX2t8y1Zmcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lwpsk4tpDZ7va6glYoM7pGHvH6YJJiqCgE5ifRRF3FN7Hxr4hxiXamPBxRzMCoXNa
	 4vJMEkkmVLl5KkOnKwzRWBomlwow03Ef8aRGkSSOfvUipQRWlqjwwMJ4bMFnZfhMO1
	 ucjbn78OcHF7sO5JbMnJ1TSAKd3B29lS6cAjeVGQ=
Date: Fri, 28 Aug 2026 07:24:09 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Cc: Willy Tarreau <w@1wt.eu>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, security@kernel.org,
	andrii@kernel.org, memxor@gmail.com, eddyz87@gmail.com,
	Amery Hung <ameryhung@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] bpf: Invalidate dynptr clones in every call frame on
 release
Message-ID: <2026082839-cosmos-whiny-e081@gregkh>
References: <apD0GtLd8lXgXD2e@1wt.eu>
 <apESuZfLOKdGsqCx@DESKTOP-F439VFF.localdomain>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apESuZfLOKdGsqCx@DESKTOP-F439VFF.localdomain>

On Fri, Aug 28, 2026 at 12:46:49PM +0800, Xu Yunxiang wrote:
> unmark_stack_slots_dynptr() walks clones only in the submitting
> pointer's frame. A program that clones a ringbuf dynptr in a subprog,
> submits the clone, then submits the original in the caller is therefore
> accepted: the caller's STACK_DYNPTR slot is never cleared. The second
> bpf_ringbuf_commit() flips BUSY on an already-committed header and a
> userspace consumer stalls.
> 
> Walk every frame and invalidate matching STACK_DYNPTR slots, the same
> per-slot work destroy_if_dynptr_stack_slot() already does in one frame.
> Leave the existing WARN_ON_ONCE(release_reference()) as a swallow: a
> hard -EINVAL would reject legitimate programs that release once in a
> different frame than they acquired (6.6/6.12/6.13), and on 6.14+ the
> second lookup fails because the ref was already deleted.
> 
> Depends on "bpf: Invalidate dynptr slices by dynptr_id on release" only
> for the slice helper call inside the new loop; the frame walk is
> independent.
> 
> This is the minimal stable equivalent of the cross-frame half of
> 308c7a0ae8859. That refactor is not a viable cherry-pick for stable.
> 
> Cc: stable@vger.kernel.org # 6.6.y 6.12.y 6.18.y
> 
> Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
> ---
>  kernel/bpf/verifier.c | 43 +++++++++++++++++++++
>  1 file changed

Same here, you lost the authorship and signed-off-by of the original.

greg k-h
