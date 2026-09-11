Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997EF3D9DC5
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153169; cv=none; b=q/qmNTNqIagGXBNN2dlhld7GYNYMePuB4J+1ddHBQLq8GvK4pwMNuS/dH3kx+XDaXKWjzkSj3bs/hXs/jFsOgzAQNdOQELWlXNLz65FYhYfzBybxvfD8lQhYo9mBmnsknbRD5xSep0vHLqW/k/j2JS4+gxlGHQHBLyfz/VD2eEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153169; c=relaxed/simple;
	bh=+8g1zYfV+MqP/XVrXDogisrA+xn3PtXe8rEowf+uAHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DGR0tMVMYJ8699IHSiu7sxjnxnD2KPqbt+ZAdEkfMIlcn8sy0H1yzwj2V6G7+lZzjLIOA71LF7dzaT6VwzF5DX0WwL1Z/I5eumlVKrcB3bdT3zIkXH94Uoq4sM0ywncPJKsu7whmrtcw9ZlMg8TWJixFC5fAFwEf8h/H5Gr2IgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ik2q7jxm; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ik2q7jxm"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 484581477;
	Fri, 11 Sep 2026 11:59:23 -0700 (PDT)
Received: from thinkpad-e142931.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 035873F7B4;
	Fri, 11 Sep 2026 11:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789153166; bh=+8g1zYfV+MqP/XVrXDogisrA+xn3PtXe8rEowf+uAHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ik2q7jxmZUlUQgLOnijwkrlcbYbUaprkqRz02YZdoOtjfNkvAWALo7KkgbMfpfSYF
	 5khDKX9d7ji4DtxIcIXo7jGqb+zmK/Cn2IFgA1l8DEuJJZJbqZOpb2RAVCz5KxPLki
	 Lk1Kxlta61VcAk5TTWLOCcvzZSUby+04ueiTzjJ4=
Date: Fri, 11 Sep 2026 19:59:16 +0100
From: Wei-Lin Chang <weilin.chang@arm.com>
To: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: Steffen Eiden <seiden@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Fuad Tabba <fuad.tabba@linux.dev>, ljs@kernel.org, 
	Shen Yongchao <grayhat@foxmail.com>, Karl Mehltretter <kmehltretter@gmail.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v4 2/2] KVM: arm64: nv: Delay freeing of shadow S2
 structures until VM destruction
Message-ID: <nmzxx2xi7cgzu3aswov2h7abzytbbirw4gzove5yfm3q5x72of@dwjxd6ut24ew>
References: <20260911162203.1919330-1-maz@kernel.org>
 <20260911162203.1919330-3-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911162203.1919330-3-maz@kernel.org>

On Fri, Sep 11, 2026 at 05:22:03PM +0100, Marc Zyngier wrote:
> We free the shadow S2 structures from kvm_arch_flush_shadow_all(), which
> is a Bad Idea(tm). Freeing the page tables is fair game (this is what
> this callback is for), but freeing the container that could still be
> referenced by another part of the system is not great.
> 
> Instead, grow separate destructors that gets called when we tear the VM
> down for good. From there, we can nuke both the individual MMUs as well
> as the global array that points to them, safe in the knowledge that the
> vcpus themselves have been destroyed already.
> 
> Fixes: 4f128f8e1aaac ("KVM: arm64: nv: Support multiple nested Stage-2 mmu structures")
> Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: stable@vger.kernel.org

Reviewed-by: Wei-Lin Chang <weilin.chang@arm.com>

> ---

[...]

