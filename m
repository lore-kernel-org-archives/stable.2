Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804767;
	b=4yS3GaM/MblYzvhLJWovQCbrkLcBdKlARFfV334u3emV5keM+U1/QAq2NVNPKUYx7yay
	 +wfRlex5CtlUdQ787PV5xc2sfeyB1/5sHb4VJz0HkNcbg3/8QcqSQDjwXPpslzbBAATuB
	 5aU+eK3eqfkxVHf7uIj1RT5WKYA1FdzPdFhbqkUQ0ayV4AOgYcLT8T/hRaC4L8SR6fqfT
	 PzkmvNMA0c76XqDZyooudidFyVKJSm0+vPDDXGJU9aLNo0tSGPsL4yX4+IihHCIWAy9iE
	 XmEGtDTpWlo/sZszoNdiwvKn9/GCuYg9FJ4efBWsEokVDg0XfOKYguUM0x6YfUSKTPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804767;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Rt6jiCTme7Bu2nT6G9JfCElWruKPjrStlWbVNDTGPVs=;
	b=q4yPTsltz3NpPtFtApWqFNY73nWgpzvlBie+neCYUs9KwpvwDpSxBcZBSoYKJZRb/GBD
	 mTgCPfHK0kGs7FDhK5IgkmKMOmdZINUuQPMs3DuHDgBt4ytECgR0JDC1noHB3h3SCALhv
	 9VJjxGLq3iWs8HT86gxg63Z+jfhn/dvlVttqVr05cjBCfxq+GCInrnXP1hLP/z+Jk/wkw
	 MRo2I0RqvQexl0gEdhZYOoGe4n+3BUHRmOoJY3FtSHdd6TrpiGtNfTky53Tmx4JS0N3MI
	 fJUdCiC8v2Roq1SPFcvT/Mas0McP0R3RtO5JT2J+M6MHFleQXYQnYuO7nid02ImuJkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mPw1udGB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDC7606A31E;
	Fri, 27 Nov 2026 18:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mPw1udGB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D481F00899;
	Fri, 27 Nov 2026 18:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795804767;
	bh=Rt6jiCTme7Bu2nT6G9JfCElWruKPjrStlWbVNDTGPVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mPw1udGByHOkvYuKQAQ87MgyOrR7sxpDEx3MmpSWzNP09dJ6oT/srKGMAtdkGFONa
	 aaot8wwukbYvGSj33IGSjnfmuoCnwM7t3wRDBxPT0y3gKx9b8B9dtEMgduFDV0Sufp
	 RpMBrACcuraNUJJWYUbIjya0s2ErClv68YiXcchoJFVi5yczjMQbNGrLyEVDsQl72f
	 E7qgDiyh8qBex3aboLodbn1TmMruvjkdtlAyDb/BJYh1lJ1Mw1VbTCgPj6rDY/a7ZI
	 PtI5Q9FU71G7psdaCTxutG+iTdvg41GcxCE39GLPr9z9dkchNirsXVYtHUtON1ntO5
	 HQq4OVu3WZpFA==
From: Will Deacon <will@kernel.org>
To: mark.rutland@arm.com,
	Yingjie Wang <1075151112@qq.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bbhushan2@marvell.com,
	gakula@marvell.com,
	gthiagarajan@marvell.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] perf: marvell: Fix DDR PMU polling period unit
Date: Fri, 27 Nov 2026 18:39:08 +0000
Message-ID: <179580037668.1449191.1672332199405896029.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <tencent_592E3D2D89322E934E28FE593E67826AAC09@qq.com>
References: <tencent_592E3D2D89322E934E28FE593E67826AAC09@qq.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 27 Oct 2026 11:22:44 +0800, Yingjie Wang wrote:
> The poll_period_sec parameter specifies the overflow polling interval in
> seconds, but cn10k_ddr_pmu_timer_period() multiplies it by USEC_PER_SEC
> before passing it to ms_to_ktime(). This makes the interval 1000 times
> longer than requested: the default of 100 seconds becomes 100,000 seconds.
> 
> The driver relies on polling to handle counter overflows. Delaying those
> checks can leave programmable counters frozen at their maximum value and
> lose events until they are restarted.
> 
> [...]

Applied to arm64 (for-next/perf), thanks!

[1/1] perf: marvell: Fix DDR PMU polling period unit
      https://git.kernel.org/arm64/c/caee2c799f89

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
