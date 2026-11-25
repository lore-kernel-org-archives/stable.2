Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608902;
	b=LAYLUtIQS51N8IQv6nXK1LuIHMMlKXxInTATxR52LoUEiUeeUMJYss6X4t8MwFuKW5+S
	 RxhvnfsPz1TMGILRLhxLZ0Cwru8yRxEMChqaMrH1Va9zPDqc6K6aDsSEsN5mwf8of3lAo
	 Bi05ucQasK48Prlo8d+eT0blWggMv6MBEw/aq0uZ7Pke9eLLYxIeWPLRipIwZo7DLwWan
	 0o6LTZFl2iSYK01Tx2CbTEr7VlIzBKWNFfEI6+Ze9bDl5MQd/TJL0/WLJEZjpueNZ/9aj
	 6WwTpTuBUW9NYtH258lc7RBkMNtsepQSqHgzOb1koE2P1pOieDNjoXXSaqP5O96uc7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608902;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding;
	bh=1dlKiXXZxapqG9zmCLzBg4HgKnlbFOylWso5ueo6Lqs=;
	b=r8wLv+r7ZtTzh9ruyFkO2aA7O4D54W6UaYU/hELFKDr5adjkzydFXpaMVHhFanz6TBc8
	 PJTLts6sRqGNipIIqgSXpePQr4TH8byOq+ryjaEYc5k05BhlMOg72l2SlaZ79oscRrP5W
	 jFvxFh100GmHjumaGTnbttkjDZJ0dIpyoojseTYrCixi+tWCfhh/f8xZblwKuobYpX2ps
	 IiScmKxJUSz3b54XSjdl9m2XTJmN85ofvM4evak2R5JM6aOgxSS6iaUbWNc3K1eVbhD8W
	 tc61RL3kacxVeJvOtaUob89mQcjw2e45/kqNMqi57/NbtMH1j65DDGco67b1wvDAuag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=KHoa5xei;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB76A606A32C;
	Wed, 25 Nov 2026 12:15:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB76A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=KHoa5xei
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0EEA82F;
	Wed, 25 Nov 2026 04:14:58 -0800 (PST)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3CD653F86C;
	Wed, 25 Nov 2026 04:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795608900; bh=3ky9MZu7q3SGrdCRfqYJILwZNULnWYwWi99eFamj3MQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KHoa5xeilBF+RK+hbrr2Y7ZE5qO8WxJ58QHngjpz9aWYvycsi7kgc7TteMwFWr72q
	 BxBFdzLppDoHL6b4G/rj+T3b9NpXhCCI3jgnIXnv4vIpLdsXen9gQNgMHQnn22zNGd
	 tZwUIekdnZXXfdMv8pX/KT7JXPo3nw37FGFDrBtY=
From: Leonardo Bras <leo.bras@arm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Leonardo Bras <leo.bras@arm.com>,
	kvmarm@lists.linux.dev,
	kvm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Steffen Eiden <seiden@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Oliver Upton <oupton@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Dan Carpenter <dan@pereq.eu>,
	stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: nv: Upgrade sub-page TTL hint to maximum size
Date: Wed, 25 Nov 2026 12:14:46 +0000
Message-ID: <awbRNvgY3c-Oql-E@LeoBrasDK>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <861p8aypwm.wl-maz@kernel.org>
References: <20261123182312.4842-1-maz@kernel.org> <awW5QKqGZAqw1ru9@LeoBrasDK> <864id6yyjy.wl-maz@kernel.org> <awXSCgN4JLLKXErv@LeoBrasDK> <861p8aypwm.wl-maz@kernel.org>
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
Content-Transfer-Encoding: 8bit

On Tue, Nov 24, 2026 at 07:45:29PM +0000, Marc Zyngier wrote:
> On Tue, 24 Nov 2026 18:06:02 +0000,
> Leonardo Bras <leo.bras@arm.com> wrote:
> > 
> > On Tue, Nov 24, 2026 at 04:38:41PM +0000, Marc Zyngier wrote:
> > > On Tue, 24 Nov 2026 16:20:16 +0000,
> > > Leonardo Bras <leo.bras@arm.com> wrote:
> > > > 
> > > > On Mon, Nov 23, 2026 at 06:23:12PM +0000, Marc Zyngier wrote:
> > > > > Should a guest be slightly foolish and submit a S2 TLBI with a TTL hint
> > > > > that describe a base granule size smaller than the host's page size,
> > > > > we take the resulting size at face value and feed it to the S2 unmapping
> > > > > code. Which legitimately screams about something not being page-aligned.
> > > > > 
> > > > > The architecture allows us to drop the TLBI on the floor, as we don't
> > > > > support a S2 granule size smaller than the host's page size. But it turns
> > > > > out that doing so is proving pretty hard (we call compute_tlb_inval_range
> > > > > from a number of places, none of which is amenable to an early out).
> > > > > 
> > > > > Instead, detect the annoying case, and pretend that we don't have a TTL
> > > > > hint at all, leaving the size upgrade mechanism to take place and use
> > > > > the largest possible size for the guest's S2 granule size.
> > > > > 
> > > > > This will still allow nonsensical stuff to get through, such as a 4kB
> > > > > level 2 (aka 2MB) from a guest with a 64kB S2 base granule size running
> > > > > on a 16kB page size host, but that's not worse than doing nothing, and
> > > > > the host code won't get shouty.
> > > > > 
> > > > > Reported-by: Dan Carpenter <dan@pereq.eu>
> > > > > Link: https://lore.kernel.org/r/20261123-inval_range-v1-1-815e15797089@pereq.eu
> > > > > Fixes: d1de1576dc21 ("KVM: arm64: nv: Handle FEAT_TTL hinted TLB operations")
> > > > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > > > Cc: stable@vger.kernel.org
> > > > > ---
> > > > > 
> > > > > Notes:
> > > > >     Reposting this as a first class patch, as I'd like to plug that one
> > > > >     as early as possible (and Dan has plenty of other patches in flight...)
> > > > > 
> > > > >  arch/arm64/kvm/nested.c | 7 +++++++
> > > > >  1 file changed, 7 insertions(+)
> > > > > 
> > > > > diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> > > > > index 78d5b18dbd2d6..36e4e83badf0a 100644
> > > > > --- a/arch/arm64/kvm/nested.c
> > > > > +++ b/arch/arm64/kvm/nested.c
> > > > > @@ -714,6 +714,13 @@ unsigned long compute_tlb_inval_range(struct kvm_s2_mmu *mmu, u64 val)
> > > > >  	 */
> > > > >  	max_size = __ttl_to_size(ttl);
> > > > >  
> > > > > +	/*
> > > > > +	 * IMPDEF behaviour: treat subpage TTL-annotated TLBI as the largest
> > > > > +	 * possible invalidation. Don't try this at home, kids!
> > > > > +	 */
> > > > > +	if (max_size < PAGE_SIZE)
> > > > > +		max_size = 0;
> > > > > +
> > > > >  	if (!max_size) {
> > > > >  		/* Compute the maximum extent of the invalidation */
> > > > >  		switch (vtcr_to_tg0_pgsize(kvm, mmu->tlb_vtcr)) {
> > > > > -- 
> > > > > 2.47.3
> > > > > 
> > > > 
> > > > Hey Marc,
> > > > 
> > > > I think the changes make sense, although rounding up to PAGE_SIZE also 
> > > > looks a valid solution in my unexperienced viewpoint.
> > > 
> > > No, it isn't the same thing. Taker the example I have given, where the
> > > host is 16k, the guest 64k, and the invalidation 4k. If you round
> > > things up to 16k, you're still not invalidating anything that is
> > > consistent with the *minimum page size* for the guest. Anything larger
> > > is a multiple of both the host and guest page sizes, and therefore
> > > always correct.
> > 
> > Ah, right!
> > In this case, could we not invalidate the largest page size supported 
> > (64k)?
> 
> Because that's not what the absence of TTL means.
> 
> > 
> > IIUC:
> > - To have max_size between 0 and PAGE_SIZE means it's either 4k or 16k, 
> >   so invalidating the 64k should be enough?
> 
> No.
> 
> >  
> > - max_size=0 from __ttl_to_size() means largest blocksize supported by 
> >   stage2 in current TG.
> 
> Yes.
> 
> > 
> > The two above are opposite ends, no? Like, the first is "this is too small 
> > for us to invalidate, let's pick something bigger", and the other one is 
> > "we want to invalidate the largest supported block".
> > 
> > Is it really ok to put them in the same bucket?
> 
> That's the *only* thing you can do, short of not invalidating anything
> at all. The commit message alreayd explains the IMPDEF choice that is
> made, and why it is made. Let me explain it again:
> 
> - An invalid TTL allows us to ignore the TLBI altogether. No ifs, no
>   buts. This is definitely an invalid TTL.
> 
> - However, by the time we reach this code, we are committed to perform
>   an invalidation, and we can't backtrack (doing so would be really
>   ugly).
> 
> - Our next port of call is to still perform an invalidation with
>   something reasonable. Since the TTL is invalid, only the IPA tells
>   us anything. And for any IPA without any range information, the only
>   sane thing to do is to invalidate the largest possible size.
> 
> You could refine this a bit more, but frankly this is not worth it. We
> are already allowing a broken guest to do some invalidations, but
> there is no need to go out of our way to do anything more.
> 
> The end.
> 

I think I got the whole picture now.
Since guest page size has to be at least the same size as the host, it 
would make no sense for a guest tlbi to ask for an invalidation smaller 
than the host page size, and therefore it's an invalid TTL hint, and we 
should invalidate the whole block, because at this point we can't 
backtrack.

FWIW:
Reviewed-by: Leonardo Bras <leo.bras@arm.com>

Thanks for having the patience to help me understand!
Leo
