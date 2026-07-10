Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09F613DDAE;
	Fri, 10 Jul 2026 21:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717408; cv=none; b=PCWz6p3tQ01pzgHN864sooVBQPHdD9OykI5BOHa4KqabTKSjadA1bBWtd1a2qLIIrQdLFFKwIpjGi/hKd3s+hScQb0mlSYbvzzWlgvYFhkr2PR7NbZ0DgjJQdeZ4twob0KxsFpjSTwEh0dgw2/4nA4OfPvwIrd8CNVALUa/dv3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717408; c=relaxed/simple;
	bh=gUFh2jEwowyf3tBPGLOuRxUu0ZrIQ6KUHu9kkmR9BTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aePTFKxhWb1f2W9gniltde32q4zyLP80WKS4ZTUhyvh/s/wgXKlbK81FhhzO0nHBkc0hsub8ysva8ooU82tNRhaj0jDXtjYFYPaw49ldfjIVwFda8YopxqpsgDEoDEhBhztGBo9Re34dzu4pxOfIM2gNbfDU57Vj7VPhwoBogWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJIxyA9T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJIxyA9T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863E11F00A3D;
	Fri, 10 Jul 2026 21:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783717407;
	bh=IxDQXUffjDPiX8s75V9lUlztwYc8UXv2+mVoAik2+IY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PJIxyA9T9LcedZvZtKzFpv4Nv71M/63UFU1MMhcIJ/witPYFfZxgHfa0l5l3+46kt
	 S8jHOqiu9gYMsbCrNw8vyi2rh+mFTGaA5y/q1GxqAMAnyAY2FjVXpfiNIP5qD+lnOd
	 x+gHiqPkYwzJehN+CZ4ENbbhyy4g1NbaMx1nbQ6/l3nfpJC5uiIDnEmI/fdpb7/bxC
	 GS5jVf3EzR2VfcWfBU4XHLnmu429oiVjVzhjB6HOviZFMLcFnUW8YOTwmIaggNUGcB
	 /s/3BXiB253AW0lhVTgW8GBFyc8MrHQQ8oBNocaMftBoE9IqqOuX743M8LC6js1hC9
	 WpYSuyKI5vHig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	oliver.upton@linux.dev,
	gregkh@linuxfoundation.org,
	mizhang@google.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	maz@kernel.org,
	james.morse@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	mark.rutland@arm.com,
	ahmed.genidi@arm.com,
	leo.yan@arm.com,
	miguel.luis@oracle.com,
	kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Colton Lewis <coltonlewis@google.com>
Subject: Re: [PATCH 6.6 v3 0/6] arm64: KVM: Backport VHE-only boot fixes
Date: Fri, 10 Jul 2026 17:03:00 -0400
Message-ID: <20260710163023.agent5-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709223604.12934-1-coltonlewis@google.com>
References: <20260709223604.12934-1-coltonlewis@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 09, 2026 at 10:35:57PM +0000, Colton Lewis wrote:
> Architectural updates retroactively made FEAT_E2H0 optional, meaning
> hardware can implement FEAT_VHE without FEAT_E2H0. On such CPUs,
> HCR_EL2.E2H can reset to an unknown state and must be initialized early
> so later code can reliably detect whether E2H mode is active.
>
> Without these fixes, booting 6.6.y as a guest under KVM nested
> virtualization will hang at boot.

Queued the series for 6.6, thanks. I also picked up the follow-up
"arm64: sysreg: Correct sign definitions for EIESB and DoubleLock"
on top.

-- 
Thanks,
Sasha
