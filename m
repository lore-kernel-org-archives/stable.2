Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C321221ABD7
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787494305; cv=none; b=tWkuRjfR57XdDhZ7KoueyzE+Ycy0hHsE3kSiRX4KgMPhGvy/7BmjqI1ZZ0tGCnHSu0UMwbA9ocznICdlX5joay3ozNn1iYqDcBMUt/h9HZ1qCErJkAgBRN0g60HH2QCmNcPIWBAfH8KmXDN0VV+idK+JDvceRfnHQwrKICIgQ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787494305; c=relaxed/simple;
	bh=AyfgfvLgQ9A0Z6I7mjhvW+PLd9XuvJuK1ro6+adR6ok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kr/tCqC1jekijD8df3q+lsITCeTGUbZb/IyeKQT1LZfz07snlgurHyXO+5bwL+LkqX5NyjTYHdzKoKi6P+or9ca2VW2ZIKDs49Ax7KSe5Uq/s07hDpjDjvcBztGCdm7RM0OHIptC+hev7RapHbsz1USHAYLfCt033MrNmgUQZSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=JMHEa7DQ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="JMHEa7DQ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59E5B1756;
	Sun, 23 Aug 2026 07:11:39 -0700 (PDT)
Received: from thinkpad-e142931.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E82AA3F85F;
	Sun, 23 Aug 2026 07:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1787494303; bh=AyfgfvLgQ9A0Z6I7mjhvW+PLd9XuvJuK1ro6+adR6ok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JMHEa7DQF8ibFmNHUBZUnV+oAyuiPWBgVk+DZV2lAR5W9UsECi8dTn+LW7p4fLMRP
	 WDEN1BeBTdYXjejRLFAV3zLlSwD+MktEC55977rh0oqtITCLSE3iEtqmm7OyG7mOHb
	 X7xbdI22x/LC+FSafNp7UO8pAhU7xISh0nIaP1t0=
Date: Sun, 23 Aug 2026 15:11:31 +0100
From: Wei-Lin Chang <weilin.chang@arm.com>
To: Marc Zyngier <maz@kernel.org>, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: Steffen Eiden <seiden@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Oliver Upton <oupton@kernel.org>, 
	Zenghui Yu <yuzenghui@huawei.com>, Fuad Tabba <fuad.tabba@linux.dev>, ljs@kernel.org, 
	Shen Yongchao <grayhat@foxmail.com>, Karl Mehltretter <kmehltretter@gmail.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH v3 2/2] KVM: arm64: nv: Delay freeing of shadow S2
 structures until VM destruction
Message-ID: <myjs4ge5zolj4drqql7lewoazu6simr32acdgi3jgy65quolhc@amx3hctoyuth>
References: <20260821161829.1032561-1-maz@kernel.org>
 <20260821161829.1032561-3-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821161829.1032561-3-maz@kernel.org>

On Fri, Aug 21, 2026 at 05:18:29PM +0100, Marc Zyngier wrote:

[...]

> +void kvm_destroy_nested(struct kvm *kvm)
> +{
> +	for (int i = 0; i < kvm->arch.nested_mmus_size; i+= S2_MMU_PER_VCPU)

nit:                                                     ^ missing space

Thanks,
Wei-Lin Chang

> +		kvfree(kvm->arch.nested_mmus[i]);
> +
> +	kvm->arch.nested_mmus_size = 0;
> +	kvfree(kvm->arch.nested_mmus);
> +}
> +

[...]
