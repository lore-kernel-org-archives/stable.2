Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804C13C6600
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869855; cv=none; b=JHkaMNBTl/e76gbGGW34ul+Kln7GjGuZ07s9PY7thMqBkC5io5a3/rbkulGP4ZNj0pNPqlBLeAPj7/q2JGwcbnRboztYzOf8ofIZQTU1Q88tlHLqMunebauP4KHBbuTiuhE/eIFqkNZUjTMiJV/siZAhmXpwhvxZ0X9flYFvyPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869855; c=relaxed/simple;
	bh=KOKAcQ4BYmCCUAIYNxNL7pI1GxS3Ci8vFm9kJeeB0M0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ts/Yk0G6722YM44jazGmvaq9dQgP90mINSNQd4XLMSfrYxOvGHIMAnsJiWtvDHEmPqdf5JruKHz5VA6QKTkmiZMzrqE6nLmKcAuomClPsNGiMvMTa4C8+fhXbLlSOSEIacQK53EIhIv49rI4JhWjJfLXVzMp9DehclCqCkF4GFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mi3RXaYS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mi3RXaYS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF1C1F00898;
	Thu,  1 Oct 2026 15:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790869854;
	bh=YmJNy3oFWhIRZFtfF6YAIvJtvccvbrXx+2twIX2a7lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mi3RXaYSY4tqfSNdPxdE8W/s6uZpmmUa+wH8hCOiyWg0AmeysR2AIhiCxvV6WqI31
	 E7Cgvt2zChm+dZI8RPDXoszRx8WpjEA0/tw3K4QYl47KaVDSzm2XRVwSg3Cy8OAgLs
	 ZlprY/QyzgZrOPS0P9HmsrOpPAlfQGZJ28Fj79GWMAWuLeIhJfs16cbmf/Ez3HwKBZ
	 +R3qZ0bv/l1FvYzQ9QHO6yp/pjpL06FeTBzgXVBgBYLbx88bc6y8KNVAi4jdLCN4zm
	 n39XixA+nKp0LF/CMkjbKoqbC1iLTNRsjRB7+Lc2P/V6qL06zmE+GgmuHMKQNpvrOs
	 e28pMnkCDxT5A==
From: Will Deacon <will@kernel.org>
To: linux-arm-kernel@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>
Cc: catalin.marinas@arm.com,
	kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	broonie@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64/fpsimd: signal: Forbid non-streaming SVE payload on SME-only systems
Date: Thu,  1 Oct 2026 16:50:43 +0100
Message-ID: <179086063838.2740899.986966739708665243.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261001130836.1410888-1-mark.rutland@arm.com>
References: <20261001130836.1410888-1-mark.rutland@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 01 Oct 2026 14:08:36 +0100, Mark Rutland wrote:
> When system_supports_sme() is true but system_supports_sve() is false,
> restoring a specifically crafted SVE signal context can result in the
> task erroneously having non-streaming SVE state. Subsequent attempts to
> manipulate the task's FPSIMD/SVE/SME state can result in a variety of
> problems, including fatal EL1 UNDEFs.
> 
> In such configurations, the kernel always creates an SVE signal context
> when delivering a signal, and this can only be in one of two states:
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64/fpsimd: signal: Forbid non-streaming SVE payload on SME-only systems
      https://git.kernel.org/arm64/c/e060d9069b49

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
