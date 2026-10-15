Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0602C1584;
	Thu, 15 Oct 2026 21:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792100291; cv=none; b=OXXJTxHGAKh/j2h/eJWRALNqR3DbotkjLkkSltLbRRprTzqyJozAk673B/mgAsAFJ7kZ6hXgmIXsf0wd0L2pMz/eULiGhfloekL2TR5DJ+Hw6sMe9vE0ZHVhP93Ma6203yBhrDNN6e8s6EgKRbAbR3S19D3BEYGmpxCAjG4tfFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792100291; c=relaxed/simple;
	bh=NyskZGYPvcyc5NYhV9EPDAjzU3fn9ltRPXvGTBE4SHA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k9m5x4AGV0BgB8JB/6pvLHgWcoRJBWD6YFvnflKq45uNXhb/ChjyCugLz8hwR9cRFNcC8ArmdT8Fxav4ZyQNCcETsvnW2z/wGHEUB3NOrGC84RxWUVM8HEfeDwH1hPtw+D0MBUDVpO6agnPD7ut1gk2g+atP7E5/ytAO+87rlKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBSZflk7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBSZflk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FA21F000C4;
	Thu, 15 Oct 2026 21:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792100290;
	bh=NyskZGYPvcyc5NYhV9EPDAjzU3fn9ltRPXvGTBE4SHA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=nBSZflk7Zh0HN/G7ddLgmzOR0+dSTNhv4kGPzgDPM/FP1Br+CVaWJt1qi8pTWODiT
	 Zugp3PEazDt9cThh3F0Ueuw64x7YDUViwKH+bFRZdZSg5CJroNfCMdmlHdKLah0Pju
	 gVdXZwBRbzEGFhL2zk/JbUU+cWBMT0tr+P8pdm608VLs1VGdNjD6iQQM5THJE+9wR7
	 l8UbIUeA1BxuT0Xp1QI/sumrDf5H5J/XGaazg83WgHuCMWYCdz2oFJzR/JbRo800b2
	 CdSPmoOsOxau0iunTB8sAwIlbw48BmnjT4u2cXDRAfY8SDN3Np2tBxpnclDjnQynaw
	 9Il0mPAZGLqdQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org
Cc: hpa@zytor.com, decui@microsoft.com, namjain@linux.microsoft.com,
 yunhong.jiang@linux.intel.com, ricardo.neri-calderon@linux.intel.com,
 rahul.tanwar@linux.intel.com, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/init: Initialize wall clock in get_rtc_noop()
In-Reply-To: <20260831082528.1623843-1-namjain@linux.microsoft.com>
References: <20260831082528.1623843-1-namjain@linux.microsoft.com>
Date: Thu, 15 Oct 2026 23:38:07 +0200
Message-ID: <87se26d4qo.ffs@fw13>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Aug 31 2026 at 08:25, Naman Jain wrote:
> get_rtc_noop() is used when an RTC is unavailable, but leaves its output
> argument untouched. When CONFIG_INIT_STACK_ALL_ZERO is not enabled,
> timekeeping_init() may therefore receive a nonzero invalid persistent
> clock value and warn:
> "Persistent clock returned invalid value"
>
> Initialize the output to zero, the documented representation of an
> unsupported persistent clock.
>
> Fixes: c311ed6183f4 ("x86/init: Allow DT configured systems to disable RTC at boot time")
> Cc: stable@vger.kernel.org
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

Reviewed-by: Thomas Gleixner <tglx@kernel.org>
