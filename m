Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAE546D560;
	Fri, 11 Sep 2026 08:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789116253; cv=none; b=dxslZydIfkw51X6CDdiSV0hAq6YPRNIWEh9OyHdvHwvvyouUaPEwDXcXOczGPey0hkCo3IlCzpQrr3akr3NdVqkhMsPlLJhpX52fMDu/caixSgysMtBP/WH10Dl5rd/mdDkL8XFyMluiJ+TrIVXoIXwnASsAm9F+zM8iBE9nM6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789116253; c=relaxed/simple;
	bh=vg4F0k6m+4+kzUXRLBavhu3U7lVZddOyXeiUGCg25js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tJEvfzaLfL1nshbRzGsA4zwj69B6sdU0ai0WSKmDRabQU+mwMC8QorqyZAiuq127wjvYcr5U3T2q1EGij2pv6bhrWGzEKNGGQWPzpFvHiLmE71g1Yqf7bC2re8140FX0yDlN3o10B1ITRdmqSmp5XTd6jCOWs//nkYEMeccyxGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8LgwFy4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8LgwFy4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 493C41F000FF;
	Fri, 11 Sep 2026 08:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789116251;
	bh=vg4F0k6m+4+kzUXRLBavhu3U7lVZddOyXeiUGCg25js=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O8LgwFy42EhGdTvVn3EhBaT0y7CkuGzg0ms4nYS/vmCIFDDimi6eIzv4AkEWKgqms
	 NqGCc+KcmrlqlgNtlz+n2ZAn4mt+1d8Bp4pARgvV6UsRPlOL3iAudNnMeciIWjKC2g
	 486vaVWTK2vW3Ce1Dm30Xl8nAZ/wEBCEXjyK94T711Dc/0VHsFU/6aSgynNNqRxpf3
	 jUhoSBJLZ+TLgVKvf4VfidcqsZ5rYg5XPEDJQ+S6G75ShYzOAq41nS1ot45lnbwUV9
	 hu0hOO4mEzBDl9SIyLCAAQzW4jVsQwHfyNqVmRRU3S1ewkAB5uqLuUA2BaFjAaBLi+
	 sYgWQPd8DNDsg==
Date: Fri, 11 Sep 2026 09:44:04 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Jonathan Davies <jonathan.davies@nutanix.com>
Cc: catalin.marinas@arm.com, christoffer.dall@arm.com, 
	fuad.tabba@linux.dev, joey.gouly@arm.com, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maz@kernel.org, oupton@kernel.org, 
	seiden@linux.ibm.com, stable@vger.kernel.org, suzuki.poulose@arm.com, 
	weilin.chang@arm.com, will@kernel.org, yaoyuan@linux.alibaba.com, yuzenghui@huawei.com
Subject: Re: [PATCH v3 2/2] KVM: arm64: nv: Fix null ptr deref on nested
 wp/unmap, teardown race
Message-ID: <aqO_SORFOAXDyXw_@gremlin>
References: <20260901-kvm-arm-nested-virt-fix-v3-2-b154676f7e4c@kernel.org>
 <9829c704-9592-4235-b97c-dc1f5e4ea795@nutanix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9829c704-9592-4235-b97c-dc1f5e4ea795@nutanix.com>

On Fri, Sep 11, 2026 at 09:12:20AM +0100, Jonathan Davies wrote:
> On Tue, 01 Sep 2026, "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
> > This means that stage2_apply_range() can drop the kvm->mmu_lock and
> > thus concurrent progress can be made in lockstep with
> > kvm_arch_flush_shadow_all().
> >
> > If kvm_arch_flush_shadow_all() advances ahead of stage2_apply_range()
> > and completes its operation it guarantees a NULL pointer deref.
>
> I've reproducibly hit exactly this problem when running nested guests
> with concurrent memory compaction on the L0 host. This patch fixes it
> for me perfectly (applied to a 6.18 kernel).
>
> So, for what it's worth:
>
> Tested-by: Jonathan Davies <jonathan.davies@nutanix.com>

Amazing, thanks :)

--
Cheers, Lorenzo
