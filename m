Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AE4409298;
	Sun,  4 Oct 2026 22:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791151786; cv=none; b=nqvkjfOvOQ0szxwa0FtWd3gJmAMn4f1YFZXFF3DRRd44a7IbHbST1tyjycYR3soGsganWIUpkHSycjPxOs4GvSj4vZJ/zSID0tjS+OsRvqFTM7r4VEFhOf1QKmCkW1sJaJbXk3W7Wtwh8v1t1OZTk1hyDwAsf2CwUmaA7IXuN8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791151786; c=relaxed/simple;
	bh=OtLVyEsaesOT4wzWy0oPxweRW/Mg8IsDyxmkskUHD6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CzQ/1BRIIVkE73ObuEMXqK/RKaew+4moXVpT2jXi/HVAcTHOA8hKW0a2IOAIMzidnGwsO1g22gSr6y8jXgDnoA1PkbyX+wmDlcW8+3M/zKJB0XZ5caoB9+e9JKTwhfnNVN1lmJ2kHS5VWP0IG83sge2SFwzmoBXIaENCSDgIwoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fA7FZlfh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fA7FZlfh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153FC1F000FF;
	Sun,  4 Oct 2026 22:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791151784;
	bh=GEpsd3NY71emI/OU49o6DxhBuREbDH43G5MVLueQf1M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fA7FZlfh2W9/hpnctq9tr1o0yQnOFCnkaOTqTSrBgMzFcNLPjxul2caadNj73wipx
	 dFPny8lZMhs/03/zoLz+mCFJecd6Z7aYLz18RNj2t+9ZLnj6i/QZQHsvAcBW+SP0AX
	 DQdnISC1IIPcW3clt/nPLSzU+B6sePHL3I2jrZbDXw0Hbg8vSyx3H1PORLdpunqvdx
	 tUCwt+dLL2VoD3duJW4n/I4wP1nBQspFDi81xPFtXKW7s4Gs4+VYOZrmpxhC67sjEd
	 7AsKZ1jIVhAMnNMjYmIG0tknP9MPVVXw4XJ6ZjgEiHPELZkSAT2Q2Ipm4aNcmQdqMH
	 7Hw/SrDagQxhA==
From: Will Deacon <will@kernel.org>
To: Khuong Dinh <khuong@os.amperecomputing.com>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: catalin.marinas@arm.com,
	mark.rutland@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] perf: xgene: initialize lock before requesting IRQ
Date: Sun,  4 Oct 2026 23:09:18 +0100
Message-ID: <179114855064.1630764.1277374161771369343.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902072241.3489222-1-runyu.xiao@seu.edu.cn>
References: <20260902072241.3489222-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 02 Sep 2026 15:22:41 +0800, Runyu Xiao wrote:
> xgene_pmu_probe() requests the PMU IRQ before initializing
> xgene_pmu->lock. request_irq() enables IRQ handling before it returns,
> so xgene_pmu_isr() can run in this window and acquire the uninitialized
> raw spinlock.
> 
> Initialize the lock before requesting the IRQ so the handler always sees a
> valid lock.
> 
> [...]

Applied to arm64 (for-next/perf), thanks!

[1/1] perf: xgene: initialize lock before requesting IRQ
      https://git.kernel.org/arm64/c/d4b7b0c77142

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
