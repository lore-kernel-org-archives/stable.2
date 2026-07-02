Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28ED3384CEC;
	Thu,  2 Jul 2026 06:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782973044; cv=none; b=Q8W0ZSDdPbgEdh/Yn4QSyORwNK0qxaOzqshQNbfhs7P8ZCVDWj4qDMUIYXcdyPm1fF9B9a2/ioxFpwDMktuKS2Fj00aT7jTwrIaeayF5DRdSuKFCkIqRxAeDaPgo6tw0cXr3C4CmYk+ESHHFwIJl08AnHPUtLWxmh4SJiN9iZZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782973044; c=relaxed/simple;
	bh=Q/SQDMycS9q9/9zbE4ZuGp3Naa6I5bigT4tbBnjlnhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLHE6hgdMojiIRpKf/tOu3elpfPhQKeMgTyWTdxsuHCIXqOSthW8Y9JMnU1tClyE7aTOremE4IzYjhSd9l69lBof/02Lt0b/zR0hYUm5glcqsme1X5uBrlt8aem2g0ew3M0r3qXilHEOtTrxaAF2wke8tOppHbbfgjvYlpRLwz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JGq1OIOP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JGq1OIOP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E021F000E9;
	Thu,  2 Jul 2026 06:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782973041;
	bh=1opG8KVKCkJTM4GDzfVHg07XwVYvSaDsnS3cERZdy7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JGq1OIOPdp5JvKbv9Ct4JH5C2W5v3DSnOAMEt8X8r/QJlSz9G05k39jJkjDG3BiF/
	 llHrDHXFGXRax0Er6yiKTZWCgyI3p6KZONQHurhZ4P8urH07VCMjlueXpFsOw9oOWi
	 hF7B2B6f+S488eyrgg0G9xd0djStAZePEGLEL8bI=
Date: Thu, 2 Jul 2026 08:16:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Colton Lewis <coltonlewis@google.com>
Cc: stable@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Mingwei Zhang <mizhang@google.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Backport ARM64 VHE boot fixes to 6.6.y
Message-ID: <2026070224-small-apprehend-b71b@gregkh>
References: <20260701204342.2654385-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701204342.2654385-1-coltonlewis@google.com>

On Wed, Jul 01, 2026 at 08:43:37PM +0000, Colton Lewis wrote:
> This series backports VHE CPU boot fixes to the 6.6.y stable branch.
> 
> These fixes are already present in the 6.12.y stable branch (and
> newer), but are missing in 6.6.y. They are required to enable booting
> L1 guests with nested virtualization enabled (kvm-arm.mode=nested).
> 
> Without these patches, a 6.6.y guest boots with HCR_EL2.E2H
> incorrectly configured (because it misses VHE-only detection or early
> initialization), causing early boot hangs/trap loops.

Why is this needed for 6.6.y?  Why not just use 6.12.y and newer for
systems that require this new feature?  What is preventing that from
happening?

thanks,

greg k-h
