Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543571;
	b=1gA90+3Z1udgp3lHpl+Nv3AjArvqihfTFSC/7Orysq8HSOzfibea7SpJqGkiVzWQqkFg
	 IsswDm29tV99LyjSSoOLgVNRcJEOgIDeSMIq+pbOMcxBDu2UErtX3Rw0pp7+tOh8pDW2w
	 VGQsn+lM98EOHjpM//xEvKmpnBGWvA77JzgLxYDdOay/8b7AQ2woNkmdvBlwwqEP0W4Xl
	 V5v33Mzn9LI9IT54kesaOz1Yd3Zb/mYmJbF6cn4KbKLCnelwZ6M0IqqMC5aDkcoUZd0SB
	 yGf2TkmVn898ujohlIk/0Fl85UJSYxgVdxUokVJxACkCzKJ3fEzOAsEysbWcw9C738Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543571;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding;
	bh=kagbCpv1QEtmm+QT0IKoz1HubJ8iePC5aHt6FNXFlZ0=;
	b=thNU4Dss32QPQNwS3nep0VNnfEHuSIn8HFrWWW3Yq9j3de0Jsn22sudDqyoY2IHuPbGe
	 0gZnyssDnQEQxZQnWRWoHaCTUckHHRNkeyZK/WVRe2UDtrhuVC8LyByBz+ptO7nQbdMEf
	 lQj4/RIhgbi8uPz17qiGSEoxwBqJaJzZgNfxLDqS/zkxRBVOpY8m97PPffxvALssOJlvO
	 I4CVEWtuWanLrtzoNrTH+TJz+R6sxFexLAiATvRyExlkkgvEpAauE790UB0n1zPlgqlZH
	 ePjV/eG0rmicMovHsw8djbCPyQYTJ2+m1oYPy4R/joahgTmATNMFcCKfP5Ksd43tvxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=lsmJm5pU;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC51606A68B;
	Tue, 24 Nov 2026 18:06:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EC51606A68B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=lsmJm5pU
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4BF0497;
	Tue, 24 Nov 2026 10:06:06 -0800 (PST)
Received: from LeoBrasDK.cambridge.arm.com (LeoBrasDK.cambridge.arm.com [10.2.212.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D8BD3F86C;
	Tue, 24 Nov 2026 10:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795543569; bh=NZoB2/gQBelnDkcKG2o810x2RG3gJOlJVfE8j9DhwZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lsmJm5pUvXw5zs6ZQXJH7igNWStTyPpD3nzfAq5AtIy5J8p2J1iXcK0YKa+eBD28s
	 E3Bk4Ks6sAeUHkiPBMGwU5Rz4fBeXlu31neTMri1+KVSJiMV+j9F5PUBd81mgRqUYv
	 VlMyutM0mTuozmAp/io0096/63A6y/zc86AExrto=
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
Date: Tue, 24 Nov 2026 18:06:02 +0000
Message-ID: <awXSCgN4JLLKXErv@LeoBrasDK>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <864id6yyjy.wl-maz@kernel.org>
References: <20261123182312.4842-1-maz@kernel.org> <awW5QKqGZAqw1ru9@LeoBrasDK> <864id6yyjy.wl-maz@kernel.org>
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

On Tue, Nov 24, 2026 at 04:38:41PM +0000, Marc Zyngier wrote:
> On Tue, 24 Nov 2026 16:20:16 +0000,
> Leonardo Bras <leo.bras@arm.com> wrote:
> > 
> > On Mon, Nov 23, 2026 at 06:23:12PM +0000, Marc Zyngier wrote:
> > > Should a guest be slightly foolish and submit a S2 TLBI with a TTL hint
> > > that describe a base granule size smaller than the host's page size,
> > > we take the resulting size at face value and feed it to the S2 unmapping
> > > code. Which legitimately screams about something not being page-aligned.
> > > 
> > > The architecture allows us to drop the TLBI on the floor, as we don't
> > > support a S2 granule size smaller than the host's page size. But it turns
> > > out that doing so is proving pretty hard (we call compute_tlb_inval_range
> > > from a number of places, none of which is amenable to an early out).
> > > 
> > > Instead, detect the annoying case, and pretend that we don't have a TTL
> > > hint at all, leaving the size upgrade mechanism to take place and use
> > > the largest possible size for the guest's S2 granule size.
> > > 
> > > This will still allow nonsensical stuff to get through, such as a 4kB
> > > level 2 (aka 2MB) from a guest with a 64kB S2 base granule size running
> > > on a 16kB page size host, but that's not worse than doing nothing, and
> > > the host code won't get shouty.
> > > 
> > > Reported-by: Dan Carpenter <dan@pereq.eu>
> > > Link: https://lore.kernel.org/r/20261123-inval_range-v1-1-815e15797089@pereq.eu
> > > Fixes: d1de1576dc21 ("KVM: arm64: nv: Handle FEAT_TTL hinted TLB operations")
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > Cc: stable@vger.kernel.org
> > > ---
> > > 
> > > Notes:
> > >     Reposting this as a first class patch, as I'd like to plug that one
> > >     as early as possible (and Dan has plenty of other patches in flight...)
> > > 
> > >  arch/arm64/kvm/nested.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> > > index 78d5b18dbd2d6..36e4e83badf0a 100644
> > > --- a/arch/arm64/kvm/nested.c
> > > +++ b/arch/arm64/kvm/nested.c
> > > @@ -714,6 +714,13 @@ unsigned long compute_tlb_inval_range(struct kvm_s2_mmu *mmu, u64 val)
> > >  	 */
> > >  	max_size = __ttl_to_size(ttl);
> > >  
> > > +	/*
> > > +	 * IMPDEF behaviour: treat subpage TTL-annotated TLBI as the largest
> > > +	 * possible invalidation. Don't try this at home, kids!
> > > +	 */
> > > +	if (max_size < PAGE_SIZE)
> > > +		max_size = 0;
> > > +
> > >  	if (!max_size) {
> > >  		/* Compute the maximum extent of the invalidation */
> > >  		switch (vtcr_to_tg0_pgsize(kvm, mmu->tlb_vtcr)) {
> > > -- 
> > > 2.47.3
> > > 
> > 
> > Hey Marc,
> > 
> > I think the changes make sense, although rounding up to PAGE_SIZE also 
> > looks a valid solution in my unexperienced viewpoint.
> 
> No, it isn't the same thing. Taker the example I have given, where the
> host is 16k, the guest 64k, and the invalidation 4k. If you round
> things up to 16k, you're still not invalidating anything that is
> consistent with the *minimum page size* for the guest. Anything larger
> is a multiple of both the host and guest page sizes, and therefore
> always correct.

Ah, right!
In this case, could we not invalidate the largest page size supported 
(64k)?

IIUC:
- To have max_size between 0 and PAGE_SIZE means it's either 4k or 16k, 
  so invalidating the 64k should be enough?
 
- max_size=0 from __ttl_to_size() means largest blocksize supported by 
  stage2 in current TG. 

The two above are opposite ends, no? Like, the first is "this is too small 
for us to invalidate, let's pick something bigger", and the other one is 
"we want to invalidate the largest supported block".

Is it really ok to put them in the same bucket?

> 
> > 
> > I am curious if there is any particular reason not to merge that with the 
> > test below, such as:
> > 
> > diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
> > index 78d5b18dbd2d6..36e4e83badf0a 100644
> > --- a/arch/arm64/kvm/nested.c
> > +++ b/arch/arm64/kvm/nested.c
> > @@ -714,6 +714,13 @@ unsigned long compute_tlb_inval_range(struct kvm_s2_mmu *mmu, u64 val)
> >  	 */
> >  	max_size = __ttl_to_size(ttl);
> >  
> > +	/*
> > +	 * IMPDEF behaviour: treat subpage TTL-annotated TLBI as the largest
> > +	 * possible invalidation. Don't try this at home, kids!
> > +	 */
> > +	if (max_size < PAGE_SIZE) {
> > - 	if (!max_size) {
> >  		/* Compute the maximum extent of the invalidation */
> >  		switch (vtcr_to_tg0_pgsize(kvm, mmu->tlb_vtcr)) {
> > --
> > 
> > Given max_size is unsigned (>=0), and it will be changed again in the 
> > switch case below, I was not able to understand the need to make it zero 
> > first.
> 
> There is more than one way to write similar things, and what I wrote
> made the most sense to me.
> 
> I want to single out this particular corner case, which is not the
> much more general case if "max_size is 0 because there is no TTL
> information". Lumping these two things together makes it, IMO,
> pointlessly hard to reason about the various cases.

Ah, I see it now, makes much more sense to have it that way.

Thanks!
Leo
