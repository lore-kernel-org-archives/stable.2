Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA5C30BF6D
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638437; cv=none; b=jDCnrwwBIjlWtRAEI77LxbtSosyPzz8/8Bv1teFhXwz1utR9vnw+yO9/YSYYk803CL10Vq1xJGYv82xs6g2dKrrMB9rCYwyP7apAgbgOsNDFlxSIIxC6a0FYvgETrjptYU0nE9pJrVHHfNZO8gfFFm1VOksbD4ttgrMSxrwWis8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638437; c=relaxed/simple;
	bh=RJnCF7AORXjZSYfvCtmieSkNwWCUvUGJotEd32NMSHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/e7RrPr9kx9y2MMfA0t/gv/r6ceYVGvgSHxV1/QdGwlJcbRMsKZ+gKe7tJtWH4sNkCggBaHs0vE2UbJaq93dRh+lxd+lLWCT8yHI5Bn3XMR6bG+ZErbQQS9TZBEcIhS73JrDRpaWxOSxtI/Z7NGaLDEaqpB2MApyRe1DhW6fpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rqByLWGA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rqByLWGA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3CFD1F000E9;
	Tue, 21 Jul 2026 12:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784638436;
	bh=N+AafY0HXdNh/39FffWCaI4b0NFtFutqt6pFND7riQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=rqByLWGATr7e8YXkEHqubXQMJ7g92+i/CPDk+J+3EBIatHPnpguBP+xdc/Y+NF1Dh
	 KBfUNdVxOfRUTLKZQvZx5xWe/GnutjqgVulhKfLl88VbD14FAgRN14ulRYMaUY0FUR
	 gmNq3B6choB7F/VroLWhSTy0kf94wrO2rqYKUWRc=
Date: Tue, 21 Jul 2026 14:53:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org, Oliver Upton <oupton@kernel.org>,
	Wei-Lin Chang <weilin.chang@arm.com>
Subject: Re: [PATCH 6.12.y 1/2] KVM: arm64: Ensure level is always
 initialized when relaxing perms
Message-ID: <2026072128-eggplant-pancreas-743d@gregkh>
References: <2026072033-wrinkle-closure-7d3c@gregkh>
 <20260721100523.2877434-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721100523.2877434-1-maz@kernel.org>

On Tue, Jul 21, 2026 at 11:05:22AM +0100, Marc Zyngier wrote:
> From: Oliver Upton <oupton@kernel.org>
> 
> stage2_update_leaf_attrs() returns early before writing to @level if the
> table walker returned an error. At the same time,
> kvm_pgtable_stage2_relax_perms() uses the level as a TLBI TTL hint when the
> error was EAGAIN, indicating the vCPU raced with a table update and the TLB
> entry it hit is now stale.
> 
> Fall back to an unknown TTL if none was provided by the walk.
> 
> Cc: stable@vger.kernel.org
> Fixes: be097997a273 ("KVM: arm64: Always invalidate TLB for stage-2 permission faults")
> Signed-off-by: Oliver Upton <oupton@kernel.org>
> Reviewed-by: Wei-Lin Chang <weilin.chang@arm.com>
> Link: https://patch.msgid.link/20260701231620.3300204-2-oupton@kernel.org
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> (cherry picked from commit 100baf0184896f859290a684f864b8200d8ac872)
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> (cherry picked from commit f35e314d4512480316454d3e963c513faa68decf)

This id isn't in the tree, something went wrong?

I'll just drop it and use the real one here.

thanks,

greg k-h
