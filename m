Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9187B36BCDE;
	Mon, 24 Aug 2026 17:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787592890; cv=none; b=MoXzF8EUW8PkrKFmnBsmTU8YZCiM7HixAGW8+kplmvyzERRyS4Y3pFMbwKvnPDUG6yf7ej4ColjG8rTGArgOqeDjHdedDxVZtbqAy8HAwuJhdktPWNrex0B9y2I/sCuXvVbApLJd/2t7GWzhZ6HKKmL0lCU4QQy01VEYmfWbWBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787592890; c=relaxed/simple;
	bh=yjc8HlWqmVNSKZG/SR+Cp6c+u42UrCXZb429EESc1AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abbfbZmn2f3mAEPsh/hZ03TEV/HY2hR6lzjeuGxzw/B+Ccnx1XdUwWVXI3qYigUeyxVbjP/ZVxPGU/782YNVGGYxmnMlMVwXuuZc+cxM3S0RqL/ZwtYr+YVJVpgXXrTWsePtxjAjBH2ApAFdbJlHKBPECVTkNVk4Vc52HPwx3ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBpjK7Ss; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBpjK7Ss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448B41F000E9;
	Mon, 24 Aug 2026 17:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787592887;
	bh=q2URyPiTE9DqDInlTIyU81XWFuh1tNvRjD/s5w67S4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DBpjK7Ss7t+ODnO+95kIf028bJZfCfXMED32n/xj0GiMowpHQJbS8/L6qacYck4GG
	 pK8S73t8R6VSFQEe2lMB/TiBiM2JZBiHM7jSYX5qhNBURZQ/FrVAwS87iufwaB0ZZz
	 7LXrnaomjC7G1EpDvws/cs5wDAZjhJTr255W/jZ1RcdkTod0UYqOcoFEELkLakYDY/
	 OeWUgbrSpzoukARYrnu+GZ6NC++kGFJ+yJURkT1QLXFzpTG6IWSjUe2YOklOsqalvK
	 LtIAswW9r2x0bBGzSM1W2IkTher2lgBACPGPQc8BRXAb4mBv3AdE8pgiCeJmAe3//X
	 Jb8p1fjkYXNEQ==
Date: Mon, 24 Aug 2026 18:34:42 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, Fuad Tabba <tabba@google.com>, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Christoffer Dall <christoffer.dall@arm.com>, Wei-Lin Chang <weilin.chang@arm.com>, 
	Yao Yuan <yaoyuan@linux.alibaba.com>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] KVM: arm64: Fix spurious warn, null ptr deref on
 S2 teardown race
Message-ID: <aox6a50IKICiQ7EX@gremlin>
References: <20260822-kvm-arm-nested-virt-fix-v2-0-ac4059a0eaa6@kernel.org>
 <87tsolnuh0.wl-maz@kernel.org>
 <aoxD4omq8gKYdFKL@gremlin>
 <87ecfno6kh.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ecfno6kh.wl-maz@kernel.org>

On Mon, Aug 24, 2026 at 04:56:46PM +0100, Marc Zyngier wrote:
> On Mon, 24 Aug 2026 14:15:29 +0100,
> "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
> > > With the commit message for patch #1 trimmed to something that fits on
> > > a couple of standard terminal screens ;-) :
> >
> > Haha sure will put it on a diet and respin :)
>
> Oliver can probably do so when applying the series.

Even better :) though Yao raised a good point on the 1/2 so maybe better for me
to respin with that applied? Or could do as a follow-up.

>
> Thanks,
>
> 	M.
>
> --
> Jazz isn't dead. It just smells funny.

--
Cheers, Lorenzo
