Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD05259498;
	Mon, 24 Aug 2026 11:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570304; cv=none; b=ARb4Cnu1swKXwjYo5mjME9dNgQEvhegCMZn/r9UjwLaYAUk3Q8Q/kmW7Z9xQVXrfrnoY+9bCvqymo+1mUgqEZRNigosocEyu0djFg011V4JKtl9JW4tFCx0S5AHWxkLtrmP9UCm2QTM2Ccx5ZvH3zFsFEqRnM5BqrsMiuWYY3kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570304; c=relaxed/simple;
	bh=Dr9LEAcuFZwHZs+G+xr87dFTcwxUh7Z010YxFDHr0nU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwWWpsOUctiYFd+VONcrTs9TEG9KOVf949cKNhRbhLjFKzqWljUGGjhq0+IkmxMDiDOPBgnsXoFHXIq9+d51yxXPgY0N7iG0JWTwMec9/Veh3P0I745hCi/a1zCokMv6H2HxUvjoZnROJRenYYAKeHA6w+aBjqjaOnaBpc9U+PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQaPeYY8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQaPeYY8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909021F000E9;
	Mon, 24 Aug 2026 11:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787570302;
	bh=ncfcDW24tgTUaBIvc+gDahPqdeBvJv0bVDHgY+i5uKw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CQaPeYY8aUp59eCWsh629TpndqB58LU0xcEXlX0mLuGKEC+c79cuKJ6HeLvT1e7XH
	 iqkXbts4Z3peJBtrzSaY8LvDXL/eZwIlRiRlOBEwW/iZKUVWqi7Hn40JF1h+iA0Yun
	 UmKaIBo6m4g7YguQXxh8B23pjwzIZZAVmYM2t644ng41FZli2EsalneZ5iMcPbM5KO
	 W4lwIAXGXBNxLY/aJJwUXiEOnjA8DKsXYH8Ojk+jXT/pOH9G6u437QvKzSHcF5JVG2
	 30eNAgVqpoXobKKDU7xtwaip8rTlZGC804Upd/XnlDmfJDBNC9UkHtgaUikU/kCV46
	 lCcZOrPpiz8FA==
Date: Mon, 24 Aug 2026 12:18:18 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	Steffen Eiden <seiden@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Fuad Tabba <fuad.tabba@linux.dev>, 
	Shen Yongchao <grayhat@foxmail.com>, Karl Mehltretter <kmehltretter@gmail.com>, 
	Wei-Lin Chang <weilin.chang@arm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] KVM: arm64: nv: Delay freeing of shadow S2
 structures until VM destruction
Message-ID: <aownGeMYtKV0wDxq@gremlin>
References: <20260821161829.1032561-1-maz@kernel.org>
 <20260821161829.1032561-3-maz@kernel.org>
 <aoiQuVs5jzB5La4i@gremlin>
 <86v7924lqn.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86v7924lqn.wl-maz@kernel.org>

On Sat, Aug 22, 2026 at 09:12:32AM +0100, Marc Zyngier wrote:
> On Fri, 21 Aug 2026 19:15:45 +0100,
> "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
> > > @@ -1310,16 +1319,12 @@ void kvm_nested_s2_flush(struct kvm *kvm)
> > >
> > >  void kvm_arch_flush_shadow_all(struct kvm *kvm)
> > >  {
> > > -	for (int i = kvm->arch.nested_mmus_size - 1; i >= 0; i--) {
> > > +	for (int i = 0; i < kvm->arch.nested_mmus_size; i++) {
> >
> > Hmm why this was in reverse before? :) I guess some product of the
> > kvfree() bit or maybe something else?
>
> We allocate s2_mmus in S2_MMU_PER_VCPU chunks. Which means that it
> complicates the freeing of the these structures, as they can only be
> freed once all S2 PTs of that chunk have been freed. We have three
> options:
>
> - scan forward, and use complicated logic to work out that you have
>   freed the last PTs of a chunk, freeing with a negative offset from
>   the current point in the loop. Works, but hard to reason about in
>   fewer than 3 seconds.
>
> - scan backward, use simpler logic to ensure you have reached the
>   beginning of a chunk, nuke it.
>
> - have two loops, one for the PTs, one for the MMUs. That's what we
>   end-up with due to the different garbage collection phases.

Ah I see, so tear down page tables of the 2nd of the pair, then after doing it
for the 1st of the pair free the chunk, makes sense.

>
> Cheers,
>
> 	M.
>
> --
> Without deviation from the norm, progress is not possible.

--
Cheers, Lorenzo
