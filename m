Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9494359A6D;
	Fri, 12 Jun 2026 15:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781278854; cv=none; b=Eqbv0H/KQWAJegMhOOUJQmL3VmSunipmGx93A8gfE4TQRlkS9eSO6FQhDEXgi05MBpMZckbUorzOQBHxd9nij+CZgYjhSewrzNkAV+Wa9TAJVGxtxFYbIPhyoVSLJfXG2kEz8xZgps39r0huMb2rCejjVcrtld765+M7/maZTZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781278854; c=relaxed/simple;
	bh=ys7fbEWrM3IoWeNbEfQSWHANKrDDlIfPDcdZ1JN0ack=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skwvUCSSXCv1kVz5ZQy8iiqZ46SxukOQ23++sDYjtPTflooo6Jfqz663Kftp/oh+ZdE4ZMKUX8g6z8JqAcFUBoW/CRCUYE0OUuXGEjZlbeoEqigfIeh5shMyOfucNTormU8bi7XgXH21278Pme/vIdsEI3Hqk+NZu+rHFAkrEKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dvXPIKZP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dvXPIKZP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MSuCSDG1sU373sc8ON+XkioeC7GLN1a88jygCwBOnYc=; b=dvXPIKZPaw73Y0JqKWErAvQefP
	Wh6y94usAOWBmmh404EKRSORtrHMVXHhFiJLqzUOOlBqN70mipLzbYT7groNmZ7qylybv2Fp1JCKX
	XZC2RqOYh76rZtw+tWrMlhT/uzikmYWy+g618q4bni3F8CVR2v59H8eba3oFfR/0iUW1I4SvHYcg/
	BsR2n+fLDBy7FGG+iy86oLlOxMEjpuyrkt1ClzrzZTf+tQ41COirrBo6atewj3bdLlyc3Gw8FCMV0
	m828BXBRhFOKUkjrBAHJbb/1Qnmx1x2qfwTae6kIUP9U6Kfxchfr6tOtc9gf+Fa7mnHJL1DTSk3PG
	j9VnrZ9w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wY3zc-00000006aqQ-11hs;
	Fri, 12 Jun 2026 15:40:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 561A73005E0; Fri, 12 Jun 2026 17:40:22 +0200 (CEST)
Date: Fri, 12 Jun 2026 17:40:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, bsegall@google.com,
	dietmar.eggemann@arm.com, juri.lelli@redhat.com,
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org,
	mgorman@suse.de, mingo@redhat.com, rostedt@goodmis.org,
	vincent.guittot@linaro.org, vschneid@redhat.com,
	shakeel.butt@linux.dev, hannes@cmpxchg.org, riel@surriel.com,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] block: invalidate cached plug timestamp after task
 switch
Message-ID: <20260612154022.GC42921@noisy.programming.kicks-ass.net>
References: <20260612094042.3350401-1-usama.arif@linux.dev>
 <20260612094520.GA42921@noisy.programming.kicks-ass.net>
 <789fd34a-d051-4f98-bd66-e3d99ec2dbb1@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <789fd34a-d051-4f98-bd66-e3d99ec2dbb1@linux.dev>

On Fri, Jun 12, 2026 at 11:02:58AM +0100, Usama Arif wrote:
> 
> 
> On 12/06/2026 10:45, Peter Zijlstra wrote:
> > On Fri, Jun 12, 2026 at 02:40:42AM -0700, Usama Arif wrote:
> > 
> >> +static __always_inline void blk_plug_invalidate_ts(void)
> >>  {
> >> +	if (unlikely(current->flags & PF_BLOCK_TS)) {
> >> +		struct blk_plug *plug = current->plug;
> >>  
> >> +		if (plug)
> >> +			plug->cur_ktime = 0;
> >> +		current->flags &= ~PF_BLOCK_TS;
> >> +	}
> >>  }
> > 
> > If you can guarantee PF_BLOCK_TS is only ever set when current->plug,
> > this can be reduced further.
> 
> Thanks for the reviews!
> 
> The invariant holds at set time (the only set in blk_time_get_ns() is
> gated by if (!plug)) and through the only legitimate plug clear in
> blk_finish_plug() (which goes through __blk_flush_plug() that clears
> PF_BLOCK_TS first).
> 
> However, copy_process() sets p->plug = NULL for the child but doesn't
> strip PF_BLOCK_TS from the inherited flags.
> 
> I think the if(plug) is a good defensive check, but can also do the below
> if you prefer?

I think that's worth the extra few lines.
