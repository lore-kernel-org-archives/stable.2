Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8431839D6EF;
	Mon, 24 Aug 2026 11:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787569651; cv=none; b=JDGu/1CsEcKzg+WbbqrD0s+e581A4KUVkhjSIJIKk1518C9faH95I/67c8SrXr7oBAAUAYZnJdtcNTdNO4uQVciNqn4VCRf0nqw5dc5uK5VUsQ33NwQjSpll6sJjELWJuoZRKxouB+Rh+oVo3zDgn7PhY03vB6EpkoKEkd33Kvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787569651; c=relaxed/simple;
	bh=meoQ4YhUPOWx+PKcrvgQL6RkE9AZOtuHfqaXyZGpzFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyIZ7qNs+BmXqYXXEo3LQ15eb/CccCBwQaxxfVzttlfgSKyyEn9kLWxX+ZWLGF1hOg6cMBAcnbYePccT39H4363NeTTf6iS86eE1q6pTT88nyvST0IzJCv0lGab8dYJ90MZmNFHIunRoWMp8VkGVcvsxI3hHWM7SkGjcZFRmwp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dc1Dcpgx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dc1Dcpgx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966F21F000E9;
	Mon, 24 Aug 2026 11:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787569650;
	bh=Z1c5VU/tF7UHH11M1RoR7ZdAC67p9CnNgwtWnc1vGqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Dc1Dcpgx1HL94nR6AD7Cil26lFoX3Hu3VN4VC3A7PP+nW4WtwX1umap0UBuPrLBsL
	 8jsoLYvJvB4f+zrd4BTehXzme9xLwAqrv+gmcNv6qUSdTKFQvCPrrqFX+kGfTbKql6
	 7Vor6kcsABOie6nBEJrLoa+j4Hm1NnTq1n24WLuKbvC/zSvJf2NDUIAQgWQEpguaUD
	 LMXlxGjidRnt+NJSsQaMOdOuccSW/dI4l375jzYu0np0ulKHOfERu2AqhAs5Sw9DXi
	 zH7HEkuNYoSiJO2F/GzhT6HBX2VMngWAanvnVcSBpiiBA8MbY1rnI8W9q3QnVMWOiY
	 hWFBwuWZrw8xQ==
Date: Mon, 24 Aug 2026 12:07:25 +0100
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
Message-ID: <aowl4sQHuoooFhqS@gremlin>
References: <20260821161829.1032561-1-maz@kernel.org>
 <20260821161829.1032561-3-maz@kernel.org>
 <myjs4ge5zolj4drqql7lewoazu6simr32acdgi3jgy65quolhc@amx3hctoyuth>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <myjs4ge5zolj4drqql7lewoazu6simr32acdgi3jgy65quolhc@amx3hctoyuth>

On Sun, Aug 23, 2026 at 03:11:31PM +0100, Wei-Lin Chang wrote:
> On Fri, Aug 21, 2026 at 05:18:29PM +0100, Marc Zyngier wrote:
>
> [...]
>
> > +void kvm_destroy_nested(struct kvm *kvm)
> > +{
> > +	for (int i = 0; i < kvm->arch.nested_mmus_size; i+= S2_MMU_PER_VCPU)
>
> nit:                                                     ^ missing space

Ack will fix on respin :)

>
> Thanks,
> Wei-Lin Chang
>
> > +		kvfree(kvm->arch.nested_mmus[i]);
> > +
> > +	kvm->arch.nested_mmus_size = 0;
> > +	kvfree(kvm->arch.nested_mmus);
> > +}
> > +
>
> [...]

--
Cheers, Lorenzo
