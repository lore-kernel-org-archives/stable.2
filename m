Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557C9448B9D
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 17:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788543845; cv=none; b=H4jGsY9a2ibE5cQMbkSbBg1o7MWGH5DOmnuaRysL9/cqZ2nk1M+NLghILST2sWAnbii9JmWONspvxP6WqeakMxuSKsHFlRNIP9RSUcEKghKX51XS6Ba/obA09JEGtV1mTssJeL6Di1PDXV2HkZG7gVZAJq8Uz8OR6LOEth53RyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788543845; c=relaxed/simple;
	bh=LAzhxC16UU+/rnLyUKWUpbnsD1PlWbcpokqyOn+1QWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBw6Kqd3EhP9G0+KoIMWYBwBlUkHfPF0ziMQU85HzVnvFLvR7pYs5ROn97Lli8NM06qMA47ld1Dn1WGwPyVDwVTelxehNU5fDGKFpGGjqLEX+xc7QTSdBcSVlK6Rhuc464z87b788ulPXUMIW/gTDaewAUbA3LjAaNBBzkKkxp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=SmyUMwyf; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="SmyUMwyf"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC521152B;
	Fri,  4 Sep 2026 10:43:58 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D31E43F7D8;
	Fri,  4 Sep 2026 10:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788543842; bh=LAzhxC16UU+/rnLyUKWUpbnsD1PlWbcpokqyOn+1QWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SmyUMwyf0fOz70a6iHmJ+0r0316naU9TPE7vIrtpLEUdB3KCGgXUiWsWHn4o/cKUt
	 sod5v8VTNcFXtS2tCLd7b4DTqfvyTiDwB7q15s5kcOyC/ZczcxTHpihXp7RjInDgTZ
	 gw7h7vMgIzP4x3iXIayPrYKYO4xHtkXtWicQGoEk=
Date: Fri, 4 Sep 2026 18:43:54 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: ada.coupriediaz@arm.com, ardb@kernel.org, catalin.marinas@arm.com,
	cl@gentwo.org, david.laight.linux@gmail.com, james.morse@arm.com,
	maz@kernel.org, peterz@infradead.org, ruanjinjie@huawei.com,
	stable@vger.kernel.org, usama.anjum@arm.com,
	vladimir.murzin@arm.com, will@kernel.org,
	yang@os.amperecomputing.com, ryan.roberts@arm.com, david@kernel.org,
	ljs@kernel.org
Subject: Re: [PATCH v3 00/21] arm64: Preemptible this_cpu_*() operations
Message-ID: <apsDWloW0TX4BHXB@J2N7QTR9R3>
References: <20260904161758.376504-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904161758.376504-1-mark.rutland@arm.com>

On Fri, Sep 04, 2026 at 05:17:37PM +0100, Mark Rutland wrote:
> This series reworks arm64's this_cpu_*() operations such that they do
> not need to disable preemption.

Please ignore this posting for now. I'll spin a RESEND or v4 next week.
At least one patch didn't make it to the list, and some CCs have been
dropped.

Mark.
