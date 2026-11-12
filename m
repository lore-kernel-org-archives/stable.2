Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794494771;
	b=o/mbF4vT3L+RNzP2uKLU7+H0jIkufOyHlXiPHIBa/ONdl8uJnLhIC/J9n2ws9RXAmxzl
	 xFE1QYdoIwOaOJwywlyPDpe0PzCAbmlLOwMjTrFzPDAASrjG0NlVLhIr8miE1K8OrROTT
	 NdozWVeRz294OpHHTVX5R8wfNpJ5KM+TEFmm58pssWeNYS2BCgg4WbjE5xKcICxmTbZlm
	 TH/ZjM04oBYbnyLpScz1OV/rGo4mTL5SOZKdtWOoIVmJo6jROKLkWowhGJrDDpqYFbrs7
	 6Wao3N2TPBfI+zskQJYHOx/VJt4McN54Tl7/+cFbmFtxsx2C0iMuiYL4/FfeZPrCq5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794494771;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=BFy9u/Lz/j1zu1UciRBWtjJF5+BPg31bTX7GjReY5Wc=;
	b=UHNrS0gv1342XxPb+/Pdm8YryLWNYUbl4TJ74JlfHB2Vn+i/DgcZNA92QEaLp+aVu3NR
	 hKHxJHgdZ/mvgoThS5XAIV4pgrVUCjucIMn8yDptdupIf9CgI3hgMsfsbTdN9Y/ZMN7zu
	 jFjuDGDrM+TqcE8UzoLyPRf+NNEuiTs43uMXpkrhZY4yO0Ol+bGoMBR2kuplZRVL/YI40
	 Kl/qfvDvUT5SbMmGBvDoJewWsZhQsrU44JFtPuDLUicYMMeaalPNZawQwc1d5RYZeVe3y
	 8GzRftq2PgSpyit+YJ4NGv5F5ZRnetZJ1S4v14FGzbHOjiadQ8GIBZbUUQndrnYvUng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=JX1cQ+Td;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192DF606A321;
	Thu, 12 Nov 2026 14:46:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 192DF606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=JX1cQ+Td
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4824A1516;
	Thu, 12 Nov 2026 06:46:07 -0800 (PST)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E720C3F673;
	Thu, 12 Nov 2026 06:46:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794494770; bh=5IqOtTt0AmJdnXGpyO4sEh+N/5oyMsw1pG8wT949+5g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JX1cQ+TdoX2Xj0hHNr0KAuI9aYqWK68oXoyp16N+OQH5mHE5wrsQLYlIhrjDYBlBj
	 8L0bJPCsw9B7H4CNUiF2CnK9WZYFXGBLG8BYHLNmWOXuRJnb1hBmoy613khDIPIyUB
	 6xhR0R3dBbm3x9Yus8KnOCFXPPHxylHg4VHoqZxU=
Date: Thu, 12 Nov 2026 14:46:07 +0000
From: Leo Yan <leo.yan@arm.com>
To: Shuai Xue <xueshuai@linux.alibaba.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, gregkh@linuxfoundation.org,
	yeoreum.yun@arm.com, suzuki.poulose@arm.com,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coresight/etm4: fix missing disable active config
Message-ID: <20261112144607.GJ9176@e132581.arm.com>
References: <20261112135406.71749-1-xueshuai@linux.alibaba.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112135406.71749-1-xueshuai@linux.alibaba.com>

On Thu, Nov 12, 2026 at 09:54:06PM +0800, Shuai Xue wrote:
> From: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> commit 895b12b7d7b8c651f73f57a1ea040d35aa7048cb upstream.
> 
> When etm4 device is disabled via sysfs, it should disable its active
> count.
> 
> Fixes: 7ebd0ec6cf94 ("coresight: configfs: Allow configfs to activate configuration")
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> Reviewed-by: Leo Yan <leo.yan@arm.com>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> [ shuai: kept spin_lock()/spin_unlock() in etm4_disable_sysfs(); 6.6.y does not have the raw spinlock conversion ]
> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>

> ---
> Note for stable maintainers: this is patch 1/3 of LKML series
> 20250514161951.3427590. Its siblings are already in 6.6.y: 2/3
> (53b9e2659719) as 1cd09aaf47a5 and 3/3 (408c97c4a5e0) as
> b3b4efa2e623, but this one was only ever picked into 6.15.y
> (c7f2b00d5e17e) because it does not apply cleanly to 6.6.y without the
> raw spinlock conversion. Without it, each sysfs enable/disable cycle
> leaks one config_desc->active_cnt reference and the module reference
> taken on the config load owner, so the configuration module can never
> be unloaded.

Makes sense for me. This backport should be applied on both 6.6.y
and 6.12.y.
