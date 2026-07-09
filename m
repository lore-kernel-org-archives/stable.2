Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD81723C50A;
	Thu,  9 Jul 2026 13:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602302; cv=none; b=gNF5IIXa47uKr9bKb1JYCyK5KW6Jj7oHCfYCOZ4UiOgdDzoqjngxrL8CifSW1ysEGTvpEMEc4E7YKS4vIg1+bkAludFh6JUu5c9cbpRQepOLJut9pUwXa5b0l4B9z8Kmnt6h6xQS3sHzXy1jo9h3SrCFdjoEIEDsEtBhsJkNqUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602302; c=relaxed/simple;
	bh=5cQ1MvVzGoEMly6FKDV1MbZCNuTfmM0NIZmGOh++1OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e+V2xSHrQPbQniceQIVaakNHIMWV+zHrI4owBFdUZDvs0jJSGa3J06ariXyRMXP10LozYqTo6cbh6+JpqQFZDlMBE4VMtogC6/jC1OotIqUzUZIgFOkDZM2QtSQVTGdykAWwFL06Q5dihDaopVE7okGKNxZtfXZbzGpDsYx3EN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nRhiftOj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nRhiftOj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26521F000E9;
	Thu,  9 Jul 2026 13:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783602301;
	bh=G++RZEmCeNoDH/zm1Tlh7TeemrMdtVnw8vgcH4JHdcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nRhiftOjARCH5qxLazcdRO4ADlrDm1VQ0kmPgMdAOZmQfviJZYZILtA64Vh4nys0r
	 hMAKorQH6SHjzRAP0abrj+v7p5a/g8gkFfwox54ir2wuglwYH9mYn98eC6UcDjA75j
	 vWqxiZy0iA7ngXqYXpuCvACC8kPSqRQRKvEkBJRw=
Date: Thu, 9 Jul 2026 15:04:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Carlos =?iso-8859-1?Q?L=F3pez?= <clopez@suse.de>
Cc: stable@vger.kernel.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 6.18.y 0/3] KVM: x86: Backports for VM entry
 failure due to stale CR8 intercept
Message-ID: <2026070939-credibly-latitude-7fda@gregkh>
References: <20260709072247.3305784-2-clopez@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260709072247.3305784-2-clopez@suse.de>

On Thu, Jul 09, 2026 at 09:22:44AM +0200, Carlos López wrote:
> Backport for bb365a506b1e ("KVM: x86: Unconditionally recompute CR8
> intercept on PPR update") with two prerequisite patches.
> 
> Resend: fix destination emails (did not properly send first version to
> stable@)
> 
> Carlos López (1):
>   KVM: x86: Unconditionally recompute CR8 intercept on PPR update
> 
> Sean Christopherson (2):
>   KVM: x86: Move update_cr8_intercept() to lapic.c
>   KVM: VMX: Grab vmcs12 on CR8 interception update iff vCPU is in guest
>     mode
> 
>  arch/x86/kvm/lapic.c   | 28 ++++++++++++++++++++++++++++
>  arch/x86/kvm/lapic.h   |  1 +
>  arch/x86/kvm/vmx/vmx.c |  3 +--
>  arch/x86/kvm/x86.c     | 35 ++---------------------------------
>  4 files changed, 32 insertions(+), 35 deletions(-)
> 
> 
> base-commit: e46dc0adfe39724bcf52cea47b8f9c9aed86a394
> -- 
> 2.51.0
> 
> 

Can't take these until we get backports for 7.1.y first, right?  Please
submit them, and then resend these.

thanks,

greg k-h
