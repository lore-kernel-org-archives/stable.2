Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAD53A2E00;
	Mon, 24 Aug 2026 11:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569745; cv=none; b=TDrG8uYxe4nJCv3edd+ZMuYUjNj7EfUIVniPEpkylgrujNY9CGchr7OhUPhgOyaMsxaGZPN57lq9B8NZyY/RGcwy4HHi4uM7sTlfGlbnIpQDy4KSLxOxVcsR2lwUl9I6dEAEfnJIbItmHzv9jkAAcrdtrHDtDbXyv8WA993v0rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569745; c=relaxed/simple;
	bh=FRPPBePravLtlCKr3qNwIwJEmdieroVSjAep8FWl1kA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJH3vkam0lnw7H2oSGHFGpJfpzunGKUL/G07EIatdWK0cegZJnW/7Nej0z7XTlwuIxKdTOlI1z5+vcQ1w0XUkJAukRARcJ8aKXXjzgChuv+UBPyiY1QHDXTTOsYizYrfAHIw1higYKf6dfRSH9/Pnpqm+mkVE6M14ufOWyLVChA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNe1YYIl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNe1YYIl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 508671F000E9;
	Mon, 24 Aug 2026 11:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787569744;
	bh=fZkHgvgEO8RpEDJnWnxIGKrcvJnO5W8LsXcKRsHQFeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZNe1YYIlDOOgljZkVmleYw+CtH+Rb37EkPkT9fQPTuTaZEKdBqXbe4J8lGMj9LkyB
	 6mgbans8mPyD5VxUO2CH6LnwiXKrTFyK0ujHMHNSQBiMjDLkLcFdTib1ddVEjZULlY
	 IB1JwwUm3NYjTxfVu0CN5Et4A2nZ/TxXNQqZeJ4UlqoPdFYFecOtj048tWW8gYqEM7
	 iHD8PovAke6lOiYYXBx+tjfhHq+FHQdg9ifdb1DL5XhyCHF1xtFR5cRDq9wO3nk0lg
	 9u85wreMm2P8Qu/SGry4hW+nfH8agPBD77ZzhCg4LlG6oetgRTciMH44Q6yrPy9mxR
	 xL+b/UfCWuWWg==
Date: Mon, 24 Aug 2026 12:09:00 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Wei-Lin Chang <weilin.chang@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, Steffen Eiden <seiden@linux.ibm.com>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Oliver Upton <oupton@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>, 
	Fuad Tabba <fuad.tabba@linux.dev>, Shen Yongchao <grayhat@foxmail.com>, 
	Karl Mehltretter <kmehltretter@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] KVM: arm64: nv: Delay freeing of shadow S2
 structures until VM destruction
Message-ID: <aowmMrvuy1vYYnKd@gremlin>
References: <20260821161829.1032561-1-maz@kernel.org>
 <20260821161829.1032561-3-maz@kernel.org>
 <myjs4ge5zolj4drqql7lewoazu6simr32acdgi3jgy65quolhc@amx3hctoyuth>
 <aowl4sQHuoooFhqS@gremlin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aowl4sQHuoooFhqS@gremlin>

On Mon, Aug 24, 2026 at 12:07:25PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Sun, Aug 23, 2026 at 03:11:31PM +0100, Wei-Lin Chang wrote:
> > On Fri, Aug 21, 2026 at 05:18:29PM +0100, Marc Zyngier wrote:
> >
> > [...]
> >
> > > +void kvm_destroy_nested(struct kvm *kvm)
> > > +{
> > > +	for (int i = 0; i < kvm->arch.nested_mmus_size; i+= S2_MMU_PER_VCPU)
> >
> > nit:                                                     ^ missing space
>
> Ack will fix on respin :)

Sorry I have not had my coffee yet this morning :)) this is Marc's series and
not mine... :P Disregard...

--
Cheers, Lorenzo
