Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C39D22D4C3;
	Thu, 18 Jun 2026 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781819547; cv=none; b=LxZrh3L9MIZx2pHCs5zteB9cJaJ3O/tOcZM8hhpNzqVE1vvXQT9uLGpftu7SnGmx/SelEFO0EndIGqpVHav4lhnQibVhi+qK8/R2cvqqyPDeOEl0k4xlYRjuSYBIwaNG5Y58Kg/gzT5Hr8eMViQVx+js54XD5HHfmZMW0xM5PdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781819547; c=relaxed/simple;
	bh=v41KJ4v+dQvq/CxvSaOJ/jvjxo+BqduvdqvMxfSacHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzIRSP8WsrtmtISvRmNO5eDCpwceikJ7h1Lwsj3+JywBjvgyRcrGw/jt3v5KZEOqbcMYuThjAchEru4uTWxfdFcLY++9heO6aRqCCdyUIHJM9b73Mg+iKMQeIY3GYmfEaoHpynsQQjrohvPbM5pHHQ+WRPRN+aE6QTrr5kKCWVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STgThfhb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STgThfhb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7291F000E9;
	Thu, 18 Jun 2026 21:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781819545;
	bh=zOQ59vanl4P6qfmRFaXM/RAmGrRLBBPBrQiFh5bwZz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=STgThfhbmVFgko+VFg32ANBYYi1oVlspsO02ppuCMmb/wnGPbf+Bd/sDU+EMn6D6B
	 +Y5e3glHoBE2P8v67jYdJbpn57YxpxDfVzpUbsmHgc1kRD9u6vwTzgZhs2CxytBI2Z
	 oLPZQPHJhnM1E+mVfgXD/F6y1hfEe/XquAQrFq39lbTXF/b0UjsETb5rpyeRvIddCR
	 1NCbHNz8M3HATnXEOCj92KsShnBHbk8RQtl79g2540LYQyo7natXJtuE3oZ8DLYz8o
	 iy79Je36he7vQ3J95kiP45YlL9Uavr1q0k/sQ8RTaFGLuPuRzC4tICIgF0PWnNc1wp
	 crBSKvBGOXFFw==
Date: Thu, 18 Jun 2026 14:52:24 -0700
From: Oliver Upton <oupton@kernel.org>
To: Wei-Lin Chang <weilin.chang@arm.com>
Cc: kvmarm@lists.linux.dev, Marc Zyngier <maz@kernel.org>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>, stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH RESEND v2 3/5] KVM: arm64: nv: Re-translate VNCR before
 injecting abort
Message-ID: <ajRomJ-Y3EOxJUU-@kernel.org>
References: <20260609185514.746507-1-oupton@kernel.org>
 <20260609185514.746507-4-oupton@kernel.org>
 <yw6b7zx2qxjckkut4lzkuqekh2omttwmulvqbslk27wt3vu6mp@ostr7avq6a7e>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw6b7zx2qxjckkut4lzkuqekh2omttwmulvqbslk27wt3vu6mp@ostr7avq6a7e>

Hey Wei-Lin,

Sorry for the latency on my end.

On Wed, Jun 10, 2026 at 02:46:18PM +0100, Wei-Lin Chang wrote:
> Just a comment using this thread:
> 
> While reading this, I found this part of the code (not this patch in
> particular) a little bit difficult to reason about. I think it's because
> kvm_translate_vncr() is doing many things, and there are multiple
> potential failure reasons e.g. s1 walk fault, no memslot, gmem/user mem
> faultin errors, MMU notifier check, etc., and they are all mux'ed into
> an error code with some context visible by the caller.
> 
> So in kvm_handle_vncr_abort() we demux the error code and handle the
> errors with the help of the context (vt, is_gmem). We essentially have
> to keep track of what error codes correspond to what error reasons.
> 
> Do you think it is better if we refactor and handle the errors when they
> occur? Like inject the exception back to vEL2 right after getting the
> results of __kvm_translate_va(), and finish up the abort handling there.
> Same for other cases.
> 
> I can try it out and make it concrete if you also think this is
> reasonable. Probably after this series gets applied when the comments
> from Marc & Sashiko are addressed. (I reviewed and don't have additional
> comments though.)

Yeah, returning error codes for 'normal' behavior is extremely difficult
to work with. TBH, I'd rather we go a step further and rework the whole
software PTW to only return errors in the case that we have to report it
to userspace.

Otherwise, aborted walks due to guest behavior should ideally return 1
and and inspect the walk result to differentiate between a successful /
aborted translation.

Thanks,
Oliver
