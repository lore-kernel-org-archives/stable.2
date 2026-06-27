Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD5A19E96D;
	Sat, 27 Jun 2026 18:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782584059; cv=none; b=javVV8tCBecz+ci62MdjqtVliVD6ch54LxSYKbCfe2VY9NQAtN8acpf2S6fPurSq0GypgPlfHktfh+WpaJKNq67NoNcdfDpp7Qnf4QxMKc1cE4I2hbN9wluO4g5DjLM8/bNQRgQgk+1VBiAwyneS2M0LFYwzVM3zX+Gr3hxNd/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782584059; c=relaxed/simple;
	bh=VLytSmv76aAtmvOH4sOQyjPk/l3NyF8qD/q6hgZZ37E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZ+yb7uAL2zHRqOlbih4BroLb4JATVWLu95oBU10pV/MF788BuY25iIEswINZIqMb46nhEA+1laoTJLQZNN8IwY1GuhGTv9FEF/XrNEjt8OBgXvBqTN1oEeOPiE9BIJw7xgZGxw1LVEK7gpkxa/1PFUcBM1jd4809KpkAHbx1rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APO/n1Yi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APO/n1Yi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75ED11F000E9;
	Sat, 27 Jun 2026 18:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782584057;
	bh=NCFBk4z1YdNB5CVZ8KnAPTlpBzRh0FzV5le6Diwn4J8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=APO/n1Yie1DJOoHiEh3PHnZKJaDxiKeBnXG3mCW4hU2hfInX5KM9w+oxNPkNzOgf8
	 GJ1kjU2jw6KbofMQaCdX9OxrG+opwbCtAJt9r5Gc0q1+8+P1M2iYecpShEl/iR9uME
	 kpAdB7yOL6g2O7FxMSll3QUs12QaZa3sDJFYWwst50QZkDWxPbctcqrS4Zpc2FHanY
	 7agH9nQpSzt3OXFSZylcj7Ora+wKMS63XVsUhRbmuw46VRk0/Bk3boqH+vk7n04r4u
	 umzWxlRF02l8nVmTh2lDL3EYiy2ubaeTGDF5ZcaHNlvlVylM12F7XpyUAh0SrJveR7
	 gbd+KDzm7S3wg==
Date: Sat, 27 Jun 2026 11:14:16 -0700
From: Oliver Upton <oupton@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	Steffen Eiden <seiden@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Will Deacon <will@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] KVM: Move kvm_io_bus_get_dev() locking
 responsibilities to callers
Message-ID: <akAS-LN7XZMaZdAQ@kernel.org>
References: <20260627105105.1005990-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260627105105.1005990-1-maz@kernel.org>

On Sat, Jun 27, 2026 at 11:51:05AM +0100, Marc Zyngier wrote:
> kvm_io_bus_get_dev() returns a device that is only matched by the
> address, and nothing else. This can cause a lifetime issue if
> the matched device is not the expected type, as by the time
> the caller can introspect the object, it might be gone (the srcu
> lock having been dropped).
> 
> Given that there is only a single user of this helper, the simplest
> option is to move the locking responsibility to the caller, which
> can keep the srcu lock held for as long as it wants.
> 
> Note that this aligns with other kvm_io_bus*() helpers, which
> already require the srcu lock to be held by the callers.
> 
> Reported-by: Will Deacon <will@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Fixes: 8a39d00670f07 ("KVM: kvm_io_bus: Add kvm_io_bus_get_dev() call")
> Link: https://lore.kernel.org/all/20260626111344.802555-1-maz@kernel.org
> Cc: stable@vger.kernel.org

Thanks for respinning.

Reviewed-by: Oliver Upton <oupton@kernel.org>
