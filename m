Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795362878;
	b=z0cRyjdpewS81gMBzKsjqt9xIRA98YN105+0TrMQyfxuIuyd+p2piHviGSv8R8XsnCVl
	 QRqsK+TTOllxSEuH0IvLjVdQnmrV8hYsZrcGS0CQbhKLFc5ILFc+iELLPcZs5IL1aX7Cq
	 CfRtSo+ENlooYKBZ7Hsk591AnDRhkriHNDkCAw8OjYSJGQtKauzYC59374SjYQFA8E79D
	 1UwN4I2SFm7yUFZbu22f1AyaCMAo2tSfZgAOo4mkpAwotwZeJhoDVrOMWaXjdAe6hls5h
	 Kwy+zxAVsMdsIjsvVDxMJmv62ohbQev0qBtnGkoyNLzkAsQYfpNQfIQNRweupNtTkPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795362878;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=LdaYsrBV//l90A8xrl2sVTadKpolcP7rxT8hA/4z5oM=;
	b=2h2ipe66iFb2auK8tW9HgWutUa6NZyFOFwz/5jDCU1rzeEMSdc2+gmMU0A+JJMyLp7Gd
	 QR7U5vvfyqkrl9SFQrmhsbGT24XoItXUoBvxrgvxQyTXZMh2x+o3gCCtP9YqfvJKMqy7v
	 xx1CSeK6HAM9h7vPPILBTV3ZmuyKMx5qnlo3gXGhVle5f/wZL/7hfDiFVFd/fsb0e+ICn
	 YJqsD6qo+Y0593laLy7Dcko2FO6GhpMY6GeDh80NyptWWKIrjwmvBiS6qGDH3ZBRBbKvc
	 RrtQRbuK4+MOhII4iTwhI1dxj0Klw/PulhmkK/1epNlVi8tyS7IkwE6p2fOyFlY9Bsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNmCjWZI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FE0606A32A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eNmCjWZI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE61E1F000C0;
	Sun, 22 Nov 2026 15:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795362877;
	bh=LdaYsrBV//l90A8xrl2sVTadKpolcP7rxT8hA/4z5oM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eNmCjWZIsyfkrSTYKobRjGHedyTU5Z9bTCVcyhze465Y5N7+8Wg/9rpFRgsH9Oh19
	 V2EJgQsnodqvhMRObp81DS16vI/ns9pnkk4kVeRBcnCoEqXmX+9HvSuCfGTIANDeS+
	 rTrsNo2Cf4SuVMFD1u8utbp3PPUrpKbSrXYdvPx9+8rJb3oR2njHTIM8rRHS3IzVAF
	 ScdijMJUILXpGgsUcRoigmUcW4SJ8lDb+QgI7VFpEoCHUOoVb+c+MOAzmOAKIIIRcI
	 AV3dydypkslxe8pM4UGYFS0dsvT2D+HktC+ifhTb3Z7cPkOhKQgdu9/D0jVJKotuJE
	 di1FOQYwqlYqw==
Message-ID: <fd2ba9f1-db7e-4d15-9860-4d3930898266@kernel.org>
Date: Sun, 22 Nov 2026 16:54:27 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] mm/ksm: only interrupt unmerging on a fatal signal
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>,
 Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>,
 Jann Horn <jannh@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Kees Cook
 <kees@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 Ollie Wild <aaw@google.com>, Adrian Bunk <bunk@stusta.de>,
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>,
 Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Joey Gouly <joey.gouly@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org, Chris Mason <mason@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
References: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org>
 <20261121-some-more-ai-fixes-v1-3-236e925d9b64@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261121-some-more-ai-fixes-v1-3-236e925d9b64@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/26 17:02, Lorenzo Stoakes (ARM) wrote:
> Commit d952b79136a6 ("ksm: fix endless loop on oom") added a check for
> pending signals on KSM break, so that a lengthy unmerge could be
> interrupted, with the system call then restarted via -ERESTARTSYS.
> 
> However, it assumes that the callers can always restart whatever system
> call started it in the first place (the commit message questions whether
> this was wise).
> 
> Well, it turns out that it was not wise, as this baked in an implicit
> assumption about system call restartability, and it was and is not safe for
> mremap().
> 
> mremap() holds an mmap write lock over the operation, which an -ERESTARTSYS
> drops, meaning that the restart is not in a consistent state.
> 
> This was made considerably worse with commit d23cb648e365 ("mm/mremap:
> permit mremap() move of multiple VMAs"), which can result in data loss if
> you encounter this issue.
> 
> Consider an mremap() specifying MREMAP_FIXED | MREMAP_DONTUNMAP of two
> KSM-mergeable VMAs, where a signal becomes pending part way through:
> 
>     first pass                          restart
>     ==========                          =======
>     unmap tgt1 range
>     copy src1 to tgt1, move page tables
>     unmap tgt2 range
>     break_ksm(src2) = -ERESTARTSYS
>                                         unmap tgt1 range, which now
>                                           holds the data from src1
>                                         copy the now-empty src1 to tgt1
> 
> This results in the user observing a successful mremap() but with src1's
> data missing.
> 
> Without MREMAP_DONTUNMAP, remap_move() would find a gap at the start of the
> range on restart and fail with -EFAULT there instead.
> 
> Fix the issue by only breaking out of an unmerge if a fatal signal is
> pending, returning -EINTR when we do. This makes KSM unmerging consistent
> with many other signal checks in mm.
> 
> Target commit d23cb648e365 ("mm/mremap: permit mremap() move of multiple
> VMAs") for the fix as this made the issue significantly more impactful.
> 
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: d23cb648e365 ("mm/mremap: permit mremap() move of multiple VMAs")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  mm/ksm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 623a2cdb3924..5d320a200951 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -627,8 +627,8 @@ static int break_ksm_pmd_entry(pmd_t *pmdp, unsigned long addr, unsigned long en
>  
>  	if (ksm_test_exit(walk->mm))
>  		return 0;
> -	if (signal_pending(current))
> -		return -ERESTARTSYS;
> +	if (fatal_signal_pending(current))
> +		return -EINTR;
>  
>  	start_ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
>  	if (!start_ptep)
> 

Thanks, I'll queue this in mm-core for the next merge window.

Everything else can be merged by Andrew.

Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
