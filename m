Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAAF42A164;
	Tue, 28 Jul 2026 11:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785237339; cv=none; b=rbrab/Oh6d3Q/snEj7qSRtL9QweqGeS49ccA9LocsEevoF5I2mVrtyea3ke9u5+VdkF0FDpHzKZJ0ca4ZT+Kk02dm3X8q9uZEHGKnblP/MJD/v9AGIfsjSEQs3o4brIJvkV59gg6OnC/BU72BW+pbaXff48wCCZZEu07SVUFUAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785237339; c=relaxed/simple;
	bh=oqJscSya1yXNvQobIBiu/hc68+cSQZXlWBCWpieasoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lXdmmvrXtoCuscYmEc4jFEkxb0e2862um47ps3WWN92ynFfcg30h2Yu709afLgRIFyQbEGfgLfUHbfIpNaP0GtputqeiG5qIM6NoMMWGjx/xeA1QnoFSpLU/rFpqe1cfTsPPLiy3d0jbvkTJjTBfKKFyHOTjDw7Sl4G8Fp6Qg/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcNFcxaV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcNFcxaV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7491F000E9;
	Tue, 28 Jul 2026 11:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785237338;
	bh=xVF4mkeG431UaBjqsM0k0WtN0kGDgCLNowxClYevd/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GcNFcxaVq8q99R3jJK+nVtOR/0Sr//p0Cc6v1f9FuDMh1e3cW0sZGjtHkIo4Ve2sH
	 NWvNo2evGes9zLHviNLnPGfzxBAFutwLhTXgKfAFiktKonywkex6DrN3ZV4EEsCRHA
	 nEHHY/prRZlqUmX8YYmKfyzvFEswhxc0GpXDPKvqHrUH2BXxb5HqybL4FSOhoJw/MU
	 cCG2ASyqx2SIdwCOA+Bkhuk5n9hp6MeYSs4G1W4XOaozQ4bnaLswOrlIzAyPlMddnA
	 pI4hmmbMIv0dSrY4nIS0+wYcvKOXwUtQF0JCQExtJDhgyRpIJZ5eGb4IL99THlF/1M
	 dQmiEcW5tI0CA==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Karl Mehltretter <kmehltretter@gmail.com>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	James Morse <james.morse@arm.com>,
	Liu Song <liusong@linux.alibaba.com>,
	shechenglong <shechenglong@xfusion.com>,
	Jonathan Marek <jonathan@marek.ca>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arm64: proton-pack: Restore the nospectre_bhb command-line option
Date: Tue, 28 Jul 2026 12:15:25 +0100
Message-ID: <178523456585.2480895.13455325016626613930.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726182253.6939-1-kmehltretter@gmail.com>
References: <20260726182253.6939-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 26 Jul 2026 20:22:53 +0200, Karl Mehltretter wrote:
> Commit 7f1635737823 ("arm64: proton-pack: Fix hard lockup due to print in
> scheduler context") moved the "mitigation disabled" printks into
> spectre_print_disabled_mitigations(). For spectre-v2 and spectre-v4 only
> the pr_info_once() calls were removed, but for spectre-bhb the whole
> branch went with the print:
> 
>   -   } else if (cpu_mitigations_off() || __nospectre_bhb) {
>   -           pr_info_once("spectre-bhb mitigation disabled ...\n");
> 
> [...]

Applied to arm64 (for-next/errata), thanks!

[1/1] arm64: proton-pack: Restore the nospectre_bhb command-line option
      https://git.kernel.org/arm64/c/2f6fc0612607

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
