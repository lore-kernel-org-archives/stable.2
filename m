Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795428021;
	b=zaRCtgDf5+7wJN4U4p5kPP+Dv9oR3FOq8wj6CJCs32UskyuL8upARrjdbfWLOcdQKd5V
	 hf0NvqoCfY5SsLYqW6s1h6SiB5m6i471+TjgZCWIKqGhLR+WsuNyD4y2lx+fOJj8QK3qk
	 +s41urPDNvFfX9BMIW1X7VJITG14dPFdC88cdnjXehXjZppHwyXY2vR82uYKS55nDX1tj
	 T4cq+7cY0wqp0m/wGWnYWi8OqurhQvfz9OnS64OLno2LbKBmlqK7aBpFdoelUDHFetCeP
	 kPMZAoNm77dNFCfc46MJLDnI7Bz1zyHL4WkcDfxh931h6J/i5O540sVusIUMceuDWgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428021;
	h=Received:DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-SA-Exim-Connect-IP:X-SA-Exim-Rcpt-To:
	 X-SA-Exim-Mail-From:X-SA-Exim-Scanned;
	bh=PyZ9yQC5Ep4/P10hYAHGznQfdWo4mmzt/SNYST0pY9E=;
	b=f+VQoYhyxSaJfFuqKAYdnJG2h+iJ+iUPxs17mWCRQjfNJRGpiVjjFX3gdvng6KVOaI8B
	 AX8AHdeqOXbNZhAhsvUXB/tD/r1F+pWxr+KpLO+oIPFdN4pRY54lAxwtrcYPKq8+k/EuW
	 7H+kKweYg3Uos9E4gYz/L1CJDHC/alLvS8W40L1dL5giFE/Uykgl47yIhRmtz3xHCt8/z
	 WVG/kFS1fJ5S9E9ggke+HvQ25v92jcU6ZVsYomGmv5hB49YhkS0AETqjHG93JEFnX9bXS
	 +HMPgBtK/0k8hSWqmYrJ48KBq5ITRbQDWSrHXa2APPYg8cbMdiSOrAKMjOR3iJ+sAAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zi9H4Suv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B11C606A327;
	Mon, 23 Nov 2026 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zi9H4Suv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B0F1F000EB;
	Mon, 23 Nov 2026 10:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795428021;
	bh=PyZ9yQC5Ep4/P10hYAHGznQfdWo4mmzt/SNYST0pY9E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zi9H4SuvGgLmReGW5/Ottuna/ZQ5hZ+k6ORJlbhlBFfv1dKS3NMd4j/6mf7lCRd2x
	 3Ylgz/slXhnP0k6Un5Q+su6zCdrBj5KS41eaw101GEZFEB5wz/3lboFZbGFIrv4ZHx
	 U84xpQrHxI3bI1jAGWwjxQjOI/kvjHwWUHjLwhFs1r5SdYzJOQMSpu3hi2A7GcGqqk
	 2D8uvRAUFJxe5CIArpMrVmOfbNenSMvot8t24AATAM7OzkmBQrdwEpDPltG0xcfK7d
	 yqAA3NhatV7/s6XRUb/rA+vp5Du2LoOjKIe0t0GMB7cq0CVJb9A6aUV7IlH8dx23jY
	 Sl7KULA/hft9w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1xVQqQ-00000001tC3-3w8R;
	Mon, 23 Nov 2026 10:00:19 +0000
From: Marc Zyngier <maz@kernel.org>
To: Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Steffen Eiden <seiden@linux.ibm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Dan Carpenter <dan@pereq.eu>
Cc: Karthik Bhargavan <karthik@pereq.eu>,
	=?UTF-8?q?Cl=C3=A9ment=20Blaudeau?= <clement@cryspen.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] KVM: arm64: nv: Reset MMIO state when committing a nested exception
Date: Mon, 23 Nov 2026 10:00:11 +0000
Message-ID: <179542800495.4189470.7702534547191717526.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261123-stale_mmio-v1-1-73f9c67a1bb0@pereq.eu>
References: <20261123-stale_mmio-v1-1-73f9c67a1bb0@pereq.eu>
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
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: oupton@kernel.org, fuad.tabba@linux.dev, joey.gouly@arm.com, seiden@linux.ibm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, dan@pereq.eu, karthik@pereq.eu, clement@cryspen.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, sashiko-bot@kernel.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Mon, 23 Nov 2026 12:47:42 +0300, Dan Carpenter wrote:
> KVM has two ways to commit a pending exception, commit_pending_events()
> which also resets the MMIO emulation state, and a direct call to
> __kvm_adjust_pc() which doesn't.  The EL1 to EL2 path in
> kvm_inject_nested() uses __kvm_adjust_pc(), but it needs to use
> commit_pending_events() instead.
> 
> The scenario is: the vcpu exits to userspace for an MMIO access and
> userspace then injects a synchronous external abort or an SError using
> the KVM_SET_VCPU_EVENTS ioctl.  If the vcpu is in L2 context and L1 has
> asked for the exception, then kvm_inject_nested() enters the exception
> straight away and vcpu->mmio_needed stays set.  On the next KVM_RUN,
> kvm_handle_mmio_return() completes the access in L1's context so it
> skips the first instruction of L1's exception vector and writes the
> MMIO data to one of L1's registers.
> 
> [...]

Applied to fixes, thanks!

[1/1] KVM: arm64: nv: Reset MMIO state when committing a nested exception
      commit: 551e73d9e21ee2a6d045736246eafcd79b32d9c4

Cheers,

	M.
-- 
Without deviation from the norm, progress is not possible.


