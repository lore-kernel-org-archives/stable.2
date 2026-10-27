Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098906;
	b=uQU0pI4LLz+PLnJPjVDXSw0dAReJVcrZ/NDXQqhSa2m9s0VPeyPic6LKVAIghEXS2FgI
	 Upfst7qFUG0QVu8YtPujn/jVKnOi0Mpu3tMUbOjLBApPgPJRbj7O0Zn5CffXTvt0bTP2y
	 R1GPdbPxhnHGnA1Uz/bAZddgsB1EXteX74hwCmpo7u97kraQQQd2sZw7ifhSmo/EHVFrN
	 aOJnlxgVzPBp9HGoAv02vCMoHnuQfHFXYp1rDN+Lm9GSvmADAU21jCE2o8xxuDmFisSTu
	 FC0m86YA+If5tec9btuy5Z3lpADfvMvlCbUL7bEb0JzNWKjW6N/NB3Z5mi4vsnLMX9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098906;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Fsla96GJDZgpbBbLI0F7GwJBHuZuy+RtHn6YyA2Pqg4=;
	b=CET6J3H+abjCwftFfBVX638cL/1chDONpZy5OeelLFNyPCTdbwYCFlWzhgZf9ARBDDb5
	 1d6Rshc3mYwh2tjJNWr9RpW9sk6FW0AwgTnL2xucatuybvG/NcwEhbSGUca3GHGpKfFid
	 offQBcCWL5Mlsjcd+6YbQ+ats40k59Z7qu+S/ij05IwLpUDIo9HB6bqquHLPF1Th1SgyB
	 49QlyHefCb9ps79o35zJm7Q3+O8DMabRNq32/UJEda+8TdmoSabAQzR9AppF5XyqvhMcI
	 IVTzkGfLjC+krEnVSipt2MQ7OZxkE41yS5xhaQ3VCJp+hrcCoHRgluzy9lHRzqGh9+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9zqbCpz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEF3606A31B;
	Tue, 27 Oct 2026 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g9zqbCpz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822C31F01828;
	Tue, 27 Oct 2026 11:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793098906;
	bh=Fsla96GJDZgpbBbLI0F7GwJBHuZuy+RtHn6YyA2Pqg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g9zqbCpzE449qSwJ5mBwjwoFWJVIAqIBeY1ypOKL+ctSEXm0PW3l8pTSthbh31Q8U
	 E5jPUW8eYhvT/A26UEvgvjQGzDL0VO3xZ1rtBD8zrUgsTrVihabJWgKL9dZ8gamGdC
	 t5OcDR9GXLvaLbMOSiF9TwrP5sFtjH+dl2XQpba1FrlYLpTY7mqv1aoAS1eULp3gkv
	 74tx0aDaJrlVWAYWpKEc2hZdRMgJBMpGdJduC/AbF5W80RwoWyA6R1bzJerb+PXLD/
	 y8Pz/sMmC2vg61BvDNDxST7GfeAxV1gFelmQOwThW9RKdG73AKhujvrbgdvGUYzbRF
	 U0tJOWmjuAlkQ==
Date: Tue, 27 Oct 2026 11:01:40 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Li Jinyue <jinyue.li@linux.alibaba.com>
Cc: akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, 
	jannh@google.com, pfalcato@suse.de, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/vma: reset the VMA iterator when merging a new range
 fails
Message-ID: <auB2uBW-EWvfNgzZ@gremlin>
References: <20261025093921.1011927-1-jinyue.li@linux.alibaba.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261025093921.1011927-1-jinyue.li@linux.alibaba.com>

On Sun, Oct 25, 2026 at 09:39:21AM +0000, Li Jinyue wrote:
> When the new range can be merged with prev, vma_merge_new_range() moves
> the VMA iterator back to prev with vma_prev() before calling
> vma_expand(). If vma_expand() then fails, NULL is returned with the
> iterator still covering prev. __mmap_region() falls back to
> __mmap_new_vma(), whose vma_iter_config() requires the iterator to
> already contain the new address and warns:
>
>   WARNING: ./include/linux/maple_tree.h:796 at __mmap_region+0x1a04/0x2398
>   ...
>    __mmap_region+0x1a04/0x2398
>    mmap_region+0x304/0x466
>    do_mmap+0xe7c/0x162c
>    vm_mmap_pgoff+0x1e8/0x362
>    ksys_mmap_pgoff+0x76/0x402
>
> This is easy to hit with fault injection when the new range sits
> between an unfaulted prev and a faulted next, so that dup_anon_vma()
> has to run and fails on allocation before the iterator is
> reconfigured.
>
> mmap_region() used to reposition the iterator itself in this case, but
> that was lost when it was converted to vma_merge_new_range(). Restore
> it in vma_merge_new_range(), and only when the iterator was moved, so
> that the common no-merge path is unchanged.
>
> Found by syzkaller.
>
> Fixes: cacded5e42b9 ("mm: avoid using vma_merge() for new VMAs")
> Link: https://lore.kernel.org/linux-mm/CAGfhM4AaEygReogOAmkmu5UfRYwoBXAMdLMBi4jbakNONbpsMw@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Li Jinyue <jinyue.li@linux.alibaba.com>

Thanks for the report, I'd rather solve this a different way, so will send
a patch with a Reported-by: and Closes: to this one.

--
Cheers, Lorenzo
