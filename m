Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE78320393
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 08:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780475589; cv=none; b=a2pfAIyW0KHmQsvLfK9nlqINfX3AzwOLIW0XLr9XeFN96ADNKZDJu7kbW8MwnFsthmKulJu986XTJYvdRA5hHVh/py81x2+GE5HR22ccHUzYfP3KaXpueZ8/jdZJ/jMNIIQ2nnM4TCOeypTp+y0AXVOzikrjBGCwd/DwAK1AvnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780475589; c=relaxed/simple;
	bh=Uz1RjswCeA/Fz8spKsWvoR+hdKlw4PdkZqHE0W+qeSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eF+2GUqA9OX+haenYsyCK0BciGdBx4vMUU5tWXmjOvJ78Z3cDAIhJ+fyBsRQ3cqGFe0oW/eiNrhZGcJNFsUTIbLFnDPSkIgMrR0TT5tEpF0uuUigm+Z8C1toCY8DJ1wEurlfYiEB+KC+aFpMs5lln9dIw7zrEsHy3fsW80RxJHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HtViXr9t; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HtViXr9t"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4A4C14BF;
	Wed,  3 Jun 2026 01:32:55 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C52CE3F86F;
	Wed,  3 Jun 2026 01:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780475580; bh=Uz1RjswCeA/Fz8spKsWvoR+hdKlw4PdkZqHE0W+qeSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HtViXr9twxEGB7KSW6DwsKLyqFAi/JyGWpsBTQ43sQAaOhuBuQjF1aJeS/+49U5i9
	 7HYo+HyRnFvS+xEBU4myLqijPLkh/VzXXWTA3SO/jcIYK7Zj/N7z4MixMdbqRp384+
	 ZW1RIFlRwGR3TCTZhtLK5gozmjExCRvcyDaxsv0w=
Date: Wed, 3 Jun 2026 09:32:56 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Xiangyu Chen <xiangyu.chen@windriver.com>
Cc: gregkh@linuxfoundation.org, stable@vger.kernel.org, will@kernel.org
Subject: Re: [PATCH v2 6.12.y 0/2] proposal to fix CVE-2026-23346 on 6.12 or
 older kernel
Message-ID: <ah_muKGPxsrhG_98@arm.com>
References: <20260603012314.4100773-1-xiangyu.chen@windriver.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603012314.4100773-1-xiangyu.chen@windriver.com>

On Wed, Jun 03, 2026 at 09:23:12AM +0800, Xiangyu Chen wrote:
> Changes:
> V1 -> V2: According to Catalin's review comment, using backport instead of reimplementing fix.
[...]
> Will Deacon (2):
>   arm64: io: Rename ioremap_prot() to __ioremap_prot()
>   arm64: io: Extract user memory type in ioremap_prot()

The backports look fine, they are nearly identical to the upstream
commits apart from the pgprot_t and ptdesc_t types.

Thanks.

-- 
Catalin
