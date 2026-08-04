Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786C835AC09;
	Tue,  4 Aug 2026 07:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828233; cv=none; b=fJKP8bMfiGEX5Gb4mYotxZRu+2EeUvUmEUzYdgz7cXSJjVoA6KB78UVrvHgc5GA+0t4QENhgs1FXmfuP/788daICWwiLY/kYjX7t2Vxkaa4RyMDcbqPt+7HdQnAF3eLzOCah3Un49Ku0GZcTSspzpekCyw5Q8hFwT2y8KqknuBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828233; c=relaxed/simple;
	bh=rGvD89MhKlmzZRPMrJPqg9C1kPX4WXWfyL9s4jZGOfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgU8CvrbGoVV8gahC8doXsFlccfQaoHtrbhHOK2nEyN1cayg04uaQJ+AZ+Jo/44Qgg5oiS1YSKezF4xp19kqlqfDnl44RlnDjxDjvt77NavyuwWEFoleuxS/Jhkgc/8xtaxDC32aWeAPbj0STUqb2P4UlQFzFDUXLKCb97SnPMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=c6K/IsTF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c6K/IsTF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XodPIm67WpP4LA6qBjgDmlDJKaqtJYIf0blYppf+Fqg=; b=c6K/IsTFs/obfc9mMbUo+a78NN
	+KLQsR6Gsj5YWNDvhqepfYJipdUylD0UjbkFaC4ZTXd62N0fk0G3b6wuCXftY5GPZuEirQGVeBzU2
	GqllWMnmzrIfmaYCi/cNEHxa7EsQ41WL0rSplnSKH1xyMsnZ+lJ66T5ny0ZDMbiPmBER5OkOfuQ5g
	BxNji25q6AUNdTMnrknXQnyjVW0RD1P7wxDCYBnIuGjxge+gKku5DwHP1ouEv+0EpGB7JhGpTQgtf
	+IqGUneRvXTSFn9VQLbeM4YzYvQLF+Z4NxXLNFjnQ/Aw2yA6qfhCv9S/k6vvQdMh/gXnUJID1FhJS
	eqlQb+Fw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wr9U2-000000015Je-24Af;
	Tue, 04 Aug 2026 07:22:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C7BDE30093A; Tue, 04 Aug 2026 09:22:40 +0200 (CEST)
Date: Tue, 4 Aug 2026 09:22:40 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Bo Li <libo.gcs85@bytedance.com>
Cc: tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	sshegde@linux.ibm.com, jgross@suse.com, wangyang.guo@intel.com,
	seanjc@google.com, pasha.tatashin@oracle.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/tsc: Fix misplaced seqcount_latch_init() in
 cyc2ns_init_secondary_cpus()
Message-ID: <20260804072240.GK687043@noisy.programming.kicks-ass.net>
References: <20260804071128.31022-1-libo.gcs85@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804071128.31022-1-libo.gcs85@bytedance.com>

On Tue, Aug 04, 2026 at 03:11:28PM +0800, Bo Li wrote:
> In cyc2ns_init_secondary_cpus(), seqcount_latch_init(&c2n->seq) is
> called _before_ c2n is advanced to the next CPU via per_cpu_ptr().
> As a result:
> 
>  1. On the first iteration, c2n still points at the BSP's struct, so
>     the BSP's seqcount_latch is re-initialized. cyc2ns_init_boot_cpu()
>     already did this correctly, so it happens to work by accident
>     because no concurrent readers are live at __init time.
> 
>  2. On subsequent iterations, seqcount_latch_init() initializes the
>     previous CPU's seqcount (because c2n was advanced by the prior
>     per_cpu_ptr()), so all CPUs except the last one in the for_each
>     loop happen to get initialized. The last secondary CPU's seqcount
>     is left uninitialized.
> 
> Move seqcount_latch_init() _after_ c2n is pointed at the target CPU's
> struct, so each secondary CPU's seqcount is correctly initialized.
> 
> Fixes: e2a9ca29b5ed ("x86/tsc: Initialize cyc2ns when tsc frequency is determined")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bo Li <libo.gcs85@bytedance.com>
> ---
>  arch/x86/kernel/tsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
> index ce10ae4b298b..84fb80492b01 100644
> --- a/arch/x86/kernel/tsc.c
> +++ b/arch/x86/kernel/tsc.c
> @@ -223,8 +223,8 @@ static void __init cyc2ns_init_secondary_cpus(void)
>  
>  	for_each_possible_cpu(cpu) {
>  		if (cpu != this_cpu) {
> -			seqcount_latch_init(&c2n->seq);
>  			c2n = per_cpu_ptr(&cyc2ns, cpu);
> +			seqcount_latch_init(&c2n->seq);
>  			c2n->data[0] = data[0];
>  			c2n->data[1] = data[1];
>  		}

No, this looks wrong. Note that per the 'cpu != this_cpu' there are only
N-1 invocations. One CPU will not be initialized. Further note the name
of this function, and the name of the function above it.

