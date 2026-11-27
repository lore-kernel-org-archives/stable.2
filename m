Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795784959;
	b=y5xtFNJxe5nGcj6zY6XAPxTTZ4wC7DX9xynIpFWOEUy4ldUi5xd2YOKOzHIYKbbAFIW2
	 ldjnq+1YUPo0ujPnBw+m02XNboN6icxmKpshUSw3JnhvV2R9tnb6oO6qH82l970chrqNC
	 O6UfqK1Tk4by5FYT4Ft4wzlDdNhB/WeQfJ/1nUDNZxZpq4E/YiTQ2X5fuVU3Oc2r8SQ6a
	 uJzLjC02E9fuFGAtUHHRqc/oQE1Xv9h2h/K6d25gRJ9yusIrNcjMCkR/yb6AVmFQXB+cf
	 WDkBTRvu0A7dcWGB7DCvmtMMu88GQpSoNiWuRsEvqy/IQZTPlpIazIgQtfOyk1dT/zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795784959;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qHbHYz43YWfZNtecSxmfo42fT9cp3l2S8acs9GzZ4jY=;
	b=JJ3s8jqSBEeiUpU+nbyydIzvMTwI/IuQXNDVU8cMukCxV8tNtmLsNHWBEUiTL0HnEcEo
	 Wa1hb/zai/wAc+oJXFbDY4c02m3N3sjw6mh7xMfKSvrlIeHuPnOoW56ZpamAAKYab9FX/
	 TjOQV7kQorMf9NWsDDWu3JogNAn6fFXu5l+r43opE8HVADc6/T4z2ys1idWbL+//GBh+Y
	 BUkSw3ezhvzkMDAfItpbE1HezFq+Fq6Ao/wQF59LnD9qj7EhJexqJCDp1ZsGS4G5bPXsz
	 iFUyoNLzY9XJj14ErbELyESLuPmoMQ/xyFLXsyfMycHUc6uOEVGLt/aIyAeYlHlLSpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cSQRCE9r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C299C606A31C;
	Fri, 27 Nov 2026 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cSQRCE9r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC701F000C1;
	Fri, 27 Nov 2026 13:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795784959;
	bh=qHbHYz43YWfZNtecSxmfo42fT9cp3l2S8acs9GzZ4jY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cSQRCE9rtZWbqs8BskTfYhaLYnl4o3V65Leu8Y3BSZ23IXSzi6NNdUvEAN83FudU1
	 vpbuBzm6ryzEC5VP26oO/V/MsRfa+53D5YLRl+Mr14crccXQuDiutKKWxUz2hrOO4N
	 3rPKL4eBBwSmCjTWhp48fdnr5sYNI1Og/nmPLnAJ/2fbSjhirmN0fDJZd7Am//+wJE
	 k16dOvqA2pfGde6rTks4Ctm+wVdJbl2YfqsVXfbyDT548hRwUTdmB/RR4IExxOS6lf
	 FThf1XFd8RW2zn4MF94XF8wW65TXPTINu2xDyZGiO3AXU6T2mGw0SIIQC8QkIdlIcy
	 x8CoGvHq9idhg==
Date: Fri, 27 Nov 2026 13:09:11 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Leonardo Bras <leo.bras@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Christoffer Dall <christoffer.dall@linaro.org>, Jintack Lim <jintack.lim@linaro.org>, 
	Wei-Lin Chang <weilin.chang@arm.com>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Usama Arif <usama.arif@linux.dev>, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: Top up the mmu memcache on user fault for NV
Message-ID: <awl76RV-OOU7i0xm@gremlin>
References: <20261126-fix-nv-cache-topup-v1-1-a22c936872fe@kernel.org>
 <awlwTGHVjoO72YFw@LeoBrasDK>
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
In-Reply-To: <awlwTGHVjoO72YFw@LeoBrasDK>

On Fri, Nov 27, 2026 at 11:58:04AM +0000, Leonardo Bras wrote:
> On Thu, Nov 26, 2026 at 05:28:29PM +0000, Lorenzo Stoakes (ARM) wrote:
> > The S2 user fault path tops up the MMU memcache (used for page table
> > pre-allocation as the point at which page tables are installed may not
> > allocate) except when:
> >
> > * It's a permission fault AND
> > * dirty page logging is disabled AND
> > * pKVM is disabled
> >
> > At which point it is assumed no page table will be allocated.
> >
> > However nested virtualisation adds another edge case - the mapping size of
> > a shadow S2 is clamped to that of the guest's own S2. If the guest
> > hypervisor replaces a block mapping with a table, a permission fault on the
> > shadow block has to be mapped at PAGE_SIZE, which requires a page table to
> > collapse the block into.
>
> Can you please expand on how would that happen?
>
> IIUC when a guest hypervisor replaces a block mapping with a table, it
> calls a tlbi in the range, and L0 will trap and remove the Shadow S2 entry,
> then next access shouldn't be a permission but a translation fault.
>
> What am I missing?

That's a great point, actually :)

But nothing really enforces that L1 does that for sure, even a bug could produce
that, and you really want to avoid the host getting in bother in that case.

(The host kernel has to behave properly no matter what guests do).

I was able to (get claude to) repro this easily.

But actually I think there's another case too, even assuming everything's
well-behaved:

* vCPU B: Writes to a read-only shadow block -> permission fault, exits
  to the host.

* vCPU A: Concurrently does its break/TLBI/make on the L1 S2, replacing
  the block with writable pages. The TLBI clears the shadow block.

* vCPU B: Now handles the fault. It's still a permission fault as far as
  the ESR is concerned so we skip the top-up, but the L1 S2 now says
  page rather than block, so we go to map a page and have to allocate
  page table(s) for it.

This needs the mapping size to have changed (otherwise we just try to relax
permissions, which doesn't allocate) which can happen when splitting,
replacing pages with a THP page, etc.

In general I think just topping up regardless is the better route, but for
a backport this is the least big change to fix this.

>
> Thanks!
> Leo

--
Cheers, Lorenzo
