Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1524457C1;
	Fri,  7 Aug 2026 07:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786089386; cv=none; b=OuhP872pWTuZXoUZG9Ff6E4WO5rxsMFBvlButtCwFUBf4I4Ujb3VJWC8ejFDNHs03dDS8DFDH6LVVGe/FTV8Epeiebq4hFUsiakLjRWcgQ8UG459aPdhy5jvpUfCMDgwANHoIjHzBpglItmP/wpgB6Gc1S6qFsIN9xDHTeUTgtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786089386; c=relaxed/simple;
	bh=oyVRhR1TNBr0DW6tX+1TFPm1LvfPdRg6gJ0vayk/f6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLZGJ4N6o3xds8MC7gGzp/mOOQqbYW9GRdvO/FrSNrVFwhds2PaYutQtOTEnFfPxd9csjBDa3hT0C5LrlzH7hBg7bd206KGNyLfB860/FDzTMap+zGXrvl7mVE2UHEzSWLLncmg3JBUUMW2DDTJb75S3oDe6THCPaV5h1KtRNnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WFXQZd0H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WFXQZd0H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EAEF1F000E9;
	Fri,  7 Aug 2026 07:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786089381;
	bh=DuTbhGDESxW5SYdiKxOKeo8YSHlG74hc713ySFoLcFo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WFXQZd0H/P4+IrzmV6PaAKS6CyT5AJQfsoz4uiCaF3x+xvt4bVJECwmT1N0lb3Vdl
	 RwIEZt35x273RjdXUJmkj+LDrJjBSxoslF0pePvwk8eU0Ax9grn44Nkdgj20t46Euf
	 yy49NXGwW5uvAqj/+y+lGf+fepncckkzq2BGIc25GUTbzK4BanJE+CMucR902Znlsd
	 WKuCHDexYjoOh/xA57MISforYypGuEK50fStw3ZNFK0PIXaPRhjYpKbPCxA6qQ4W0g
	 8srIHFw6Zm9HJnL6wtUoLhaw8MkR1cqZlTOLMq4Km0mLe6VtBjN0fcUFlSFyhifrl3
	 d0wy8LHaIQpgw==
Date: Fri, 7 Aug 2026 08:56:00 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: sparkhuang <huangshaobo3@xiaomi.com>
Cc: akpm@linux-foundation.org, bsegall@google.com, david@kernel.org, 
	dietmar.eggemann@arm.com, juri.lelli@redhat.com, kees@kernel.org, kprateek.nayak@amd.com, 
	liam@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	mgorman@suse.de, mhocko@suse.com, mingo@redhat.com, peterz@infradead.org, 
	rostedt@goodmis.org, rppt@kernel.org, ryabinin.a.a@gmail.com, stable@vger.kernel.org, 
	surenb@google.com, vbabka@kernel.org, vincent.guittot@linaro.org, 
	vschneid@redhat.com
Subject: Re: [PATCH] fork: reset pointer tag of vmapped thread stack before
 vfree
Message-ID: <anWPTt4DE-Q8PKry@lucifer>
References: <anSVlVpUXrA8ra_z@lucifer>
 <20260807065351.93659-1-huangshaobo3@xiaomi.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807065351.93659-1-huangshaobo3@xiaomi.com>

I'm sorry that whole reply is more AI slop and I'm not reading it.

I have zero interest in chatting to an LLM via a middle man.

On Fri, Aug 07, 2026 at 02:53:51PM +0800, sparkhuang wrote:
> Hi Lorenzo,
>
> Thanks for the review. You're right on the process points ??? I'll fold
> those into a v2 (real name, Assisted-by: tag, drop Cc: stable, trim the
> comment, correct the Fixes: target). I won't re-spin it just yet though,
> for the reason below.
>
> I want to be upfront about where the analysis actually stands, because
> I'd rather not push a fix whose rationale I can't fully back up.
>
> The one-line change itself is sound and follows existing precedent:
> c08e6a1206e6 already resets tsk->stack to 0xFF, and 528a4ab45300 does
> the same in scs_free(). A 0xFF-tagged pointer bypasses the KASAN tag
> check, so vfree_atomic()'s llist_add write to the freed region stops
> faulting regardless of what the memory tag currently holds. That makes
> the reported false positive go away ??? that part I'm confident in.
>
> What I have *not* nailed down is why "memory tag: [ff]" shows up in the
> report in the first place. On the 6.18 android-common tree:
>
>   - At allocation __kasan_unpoison_vmalloc() tags vm_area->addr with a
>     random tag (0xc2 here) and sets the backing memory tag to the same
>     0xc2, so they match at that point ??? the report is not from the
>     alloc path.
>   - c08e6a1206e6 resets tsk->stack to 0xFF (SP can't be tagged); its
>     commit message explicitly notes the stack *memory* still gets tagged.
>   - The only caller of kasan_unpoison_task_stack() ??? which would write a
>     0xFF tag into the backing memory ??? is the idle-task path in
>     kernel/cpu.c. It is not called for normal task stacks, so my earlier
>     commit-message attribution to that function was wrong.
>   - page_kasan_tag_reset() only touches page->flags metadata, not the
>     physical memory tag, so that's not the source either.
>
> So what flips the memory tag from 0xc2 to 0xFF between allocation and
> the RCU callback remains an open question. My suspicion is the async
> vfree_atomic / delayed_vfree + page-reuse interplay during the reboot
> SIGTERM storm (the trace also shows page flags kasantag=0x55, a third
> value inconsistent with both), but I haven't proven a specific path.
>
> Accordingly I don't have a deterministic reproducer. The report is
> reproducible only in the sense that it shows up during reboot with heavy
> thread churn; I haven't been able to trigger it on demand.
>
> Given that, I'd like to hold v2 until the 0xFF source is understood
> rather than ship a commit message that hand-waves the root cause. If you
> or the KASAN folks have a view on whether the reset_tag fix is acceptable
> as a "stops the false positive, mirrors existing precedent" change
> without a fully root-caused explanation ??? versus waiting ??? I'd
> appreciate the steer.
>
> Best,
> Shaobo

--
Cheers, Lorenzo
