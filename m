Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474523B95EB
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782225883; cv=none; b=gpB6yHeVMnLvpjCRRNSAdBQ+Y83btKBylhx5i2v9MgS8ziJwNzPHYFu8NiVNXSBQGirdNCX5MftYRCmhV4a+6k3FvAqztdjdXRsDYWXV93hyDDktpGK4OcYz9zDeCqgnsYjxzWFU6d5/Qn985jKdoKY9PkGOeepdwGDXJI2jnKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782225883; c=relaxed/simple;
	bh=OLyyvbXtqpwYtrdcTo4YciOw2e2u9muWYAHapaeDZcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewLGQKvmURL7JI6Ekt/a7csqwjRCfFg0aYKsGmZencn4oDIAxYJmj+AzJdEuQoEbXmIZkDh0misYFOArJKgJaE948vKcHxfQlFuzwL4usCRGLknh4dpIxtYioOHhl3T3Lp004SdHjbOtHlepYJnzVPi+mFcmXhZbfzEzh0O9c28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VLpYZwhv; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VLpYZwhv"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25C6A1A25;
	Tue, 23 Jun 2026 07:44:37 -0700 (PDT)
Received: from thinkpad-e142931.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC4683F632;
	Tue, 23 Jun 2026 07:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1782225881; bh=OLyyvbXtqpwYtrdcTo4YciOw2e2u9muWYAHapaeDZcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VLpYZwhv/YRlKuEE5RRJyglnvSTlYCj0qlJlvr76oFvssE7LthszFJL5YPy8hZPdS
	 NSDnKL+l/Qzrn6Mjp/9ze5FnXE9MCi7mGTU9uIBadRpw2tXON7lIGzcnI1qJ6mQl+D
	 CnQ4No3ZMYwIvYb2KY8JtEKIKtO2n6dX8WbcWB5w=
Date: Tue, 23 Jun 2026 15:44:25 +0100
From: Wei-Lin Chang <weilin.chang@arm.com>
To: Oliver Upton <oupton@kernel.org>
Cc: kvmarm@lists.linux.dev, Marc Zyngier <maz@kernel.org>, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH RESEND v2 3/5] KVM: arm64: nv: Re-translate VNCR before
 injecting abort
Message-ID: <cdcjimpyohzgbttm7fnhzzqbiy2s74y7p2lmap2agutosk4d2r@gj7d5nwdbr6y>
References: <20260609185514.746507-1-oupton@kernel.org>
 <20260609185514.746507-4-oupton@kernel.org>
 <yw6b7zx2qxjckkut4lzkuqekh2omttwmulvqbslk27wt3vu6mp@ostr7avq6a7e>
 <ajRomJ-Y3EOxJUU-@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajRomJ-Y3EOxJUU-@kernel.org>

On Thu, Jun 18, 2026 at 02:52:24PM -0700, Oliver Upton wrote:
> Hey Wei-Lin,
> 
> Sorry for the latency on my end.
> 
> On Wed, Jun 10, 2026 at 02:46:18PM +0100, Wei-Lin Chang wrote:
> > Just a comment using this thread:
> > 
> > While reading this, I found this part of the code (not this patch in
> > particular) a little bit difficult to reason about. I think it's because
> > kvm_translate_vncr() is doing many things, and there are multiple
> > potential failure reasons e.g. s1 walk fault, no memslot, gmem/user mem
> > faultin errors, MMU notifier check, etc., and they are all mux'ed into
> > an error code with some context visible by the caller.
> > 
> > So in kvm_handle_vncr_abort() we demux the error code and handle the
> > errors with the help of the context (vt, is_gmem). We essentially have
> > to keep track of what error codes correspond to what error reasons.
> > 
> > Do you think it is better if we refactor and handle the errors when they
> > occur? Like inject the exception back to vEL2 right after getting the
> > results of __kvm_translate_va(), and finish up the abort handling there.
> > Same for other cases.
> > 
> > I can try it out and make it concrete if you also think this is
> > reasonable. Probably after this series gets applied when the comments
> > from Marc & Sashiko are addressed. (I reviewed and don't have additional
> > comments though.)
> 
> Yeah, returning error codes for 'normal' behavior is extremely difficult
> to work with. TBH, I'd rather we go a step further and rework the whole
> software PTW to only return errors in the case that we have to report it
> to userspace.
> 
> Otherwise, aborted walks due to guest behavior should ideally return 1
> and and inspect the walk result to differentiate between a successful /
> aborted translation.

Thanks for your suggestion!
I'll put this in the "potential improvements" list for now, there are
other fixes I need to work on.

Thanks,
Wei-Lin Chang

> 
> Thanks,
> Oliver
