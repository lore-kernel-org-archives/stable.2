Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB835111A5;
	Tue, 13 Oct 2026 15:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791905324; cv=none; b=SoWTXM2WQnY2K6z+XovnsZ3VY+9+yztODM/PjFliZCEAhHDK+2epLIhqaW48L48J7NQQl6/uC4v7icFBpMHwEQKT9T3ca4qkkDEJENL9hnidh94cfY26vO259UA6hI0wwQhoa1wG0yLlciuz+aLTeyHk2wjTCgMcoRtDsfvpmd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791905324; c=relaxed/simple;
	bh=VyrB3W7tU1vHvqwDMFncfJCiP7vtq+hwRw3287yxDhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfimuKJCRPiqnsVvCTiSmZ74Dqk80ZxM1l/65Y2E34LbdAWLzJ8dmqdTKtcPY1A2T/Ay0d3FjKXtuC8pQADSl0HtuyKc3Koryw6SuSfXErOiZDP8DeQPazbHdJuQKXh00YN29YtIDkROK8k5A/bmLJ2x+6xJYsYnchnQCsUzG5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwTOQBRG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwTOQBRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7671F000FF;
	Tue, 13 Oct 2026 15:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791905323;
	bh=rpQaXQHsfNbA2Umv0Rjna/4DmJUX1U/rU1Wpq5ut3+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MwTOQBRGVY7W2Yhfo7LL1mQkXqfrGrnudQPxAzNuEe5IMwWPmMK1eSwbS2QClo3zR
	 TU3e5hgcgXuasBi2Ib1HD5PBnPIrxAzkYHQcTH45QV5qSQr9cfA2d9QmYrOx4rF2cQ
	 xvBx/aHYTlqC52w/i7gB8l31YNz0ODhtp2srIp5DS4xKFAS7I1lr4szn8EUiGaCJXU
	 PmACM5psGRfyjW84bvScwf91VQAWTQ6ajf8hmsoiLLEoj3rYkfbbrytClpq1OtOQbt
	 iW/26OxYS0u36xmtz1iGPaftKJIS8pftvkSe07OMW8bzBX71mciLCppKOZdyINpEN2
	 Ed9NGlN8s/XIA==
Date: Tue, 13 Oct 2026 16:28:36 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Stian Halseth <stian@itx.no>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Andreas Larsson <andreas@gaisler.com>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] fs/proc/task_mmu: fix lost maps entries above 2^63
Message-ID: <as5M1BSWcPDHjEWt@gremlin>
References: <20261013152106.1834364-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013152106.1834364-1-stian@itx.no>

On Tue, Oct 13, 2026 at 05:21:06PM +0200, Stian Halseth wrote:
> When a read of /proc/pid/{maps,smaps,numa_maps} resumes, m_start()
> rewinds *ppos to priv->last_pos so that the vma which did not fit into
> the previous buffer is shown again. It only does so for last_addr > 0,
                                     ^
This could do with a newline between paragraphs.

> meaning to exclude the start of the file and SENTINEL_VMA_GATE, but
> last_addr is a signed loff_t holding a vm_end. sparc64 maps shared
                                                ^
                                          Here too.

> libraries, anonymous memory and the stack above 0x8000000000000000, so
> the rewind does not happen there and one entry is lost at every read()
> boundary.
>
> Reading the maps file of a process with read sizes from 64 to 8192
> bytes in steps of 64 loses lines at 126 of the 128 sizes, smaps at 123
> and numa_maps at 97, and the proc-maps-race selftest fails 4 of its 6
> tests. Python's sys.remote_exec() reads maps with fgets() and fails
> intermittently when it misses the libpython data mapping.

These numbers are hard to understand it's like playing numberwang a little
bit ;)

It'd be good to simplify this by saying something like 'testing revealed
that lines are not correctly read from /proc/$pid/[maps, smaps, numa_maps]
etc.' or at least something that's a little more readable.

>
> Skip the rewind only for 0 and the two sentinels instead, with an
> addr_is_sentinel() helper.
>
> Fixes: 5631da56c9a87 ("fs/proc/task_mmu: read proc/pid/maps under per-vma lock")
> Closes: https://github.com/sparclinux/issues/issues/111
> Cc: stable@vger.kernel.org
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Stian Halseth <stian@itx.no>

Please stop respinning so fast thanks :)

We generally want a ~week between respins for newer contributors. At least
a day.

5 minutes is a bit much...

This looks reasonable to me, but I want Suren to have a closer look.

Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 5c54aebe21182..24c2a5079f080 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c

> @@ -339,7 +344,7 @@ static void *m_start(struct seq_file *m, loff_t *ppos)
>  	 * Reset current position if last_addr was set before
>  	 * and it's not a sentinel.
>  	 */
> -	if (last_addr > 0)
> +	if (last_addr && !addr_is_sentinel(last_addr))

I think last_addr > 0 was fine, but it's not really a big deal.

--
Cheers, Lorenzo
