Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1EC37757D;
	Mon,  8 Jun 2026 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780920845; cv=none; b=nQBZ2EzBlEkhlrNYlVgP7+yvylrtpxtetT9fYAJRyfRIDHuCbYggvqJ/L097a8SdAA0iF4LjwO1zyxRMVbM/AyRU4nf8JWZMFrgG3CpExz3g4LGhm8YUCC3Z7pJGSuCFb2eB68m+wFCnESgUlrgFu+UwMdyBbC1+KyF+OBS/t3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780920845; c=relaxed/simple;
	bh=uAkeFGEr+5/XUKcLzDviNGpTqIZwHK2m9Cprm9WdTZA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l3uqoLVj4/fAjcvX9ap6K7Hx9LA9eY8O33FEJlCG4x+G9u9rSKt+2r3chQQvjVflMhPZ3CL8DteKcteEUObwZgroUUxcFV0AJUWs0o2d79J85ArZ/IqAFsNM9Shhx7a357zk02iursynZTwZWJ0Je3VyIoQCuc3EL+ZYnG4AL8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fNB+Sg4k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fNB+Sg4k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCC61F00893;
	Mon,  8 Jun 2026 12:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780920844;
	bh=ZJAvrbus89Qbks/IJw+0hx15BuYtV9x1JcauYLr8ETg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=fNB+Sg4kojAegBQBisvOiE97KcEM+lqAd5FBdy7T4miiGWcKp02gmTdfQ1Tb8o20i
	 rzVML6h4RUaMKpZ4lUiW+MyY+j0PAVESmsKCFh3X13BIpC/L+8e24+NClS+f2q9lvz
	 bN8zxwVRuGmVqeSl7hZnMRjaXWxT/5Y1IW46sdW8NUAujGYXggVHAEiH9F6mxVNrjv
	 7ryPudnSwufOuQAL3wcf37AY+2buOkV+KgdOZEeftenVdZgCScZCDUYtfz3tG/r8cV
	 wJfUwkUx/RUZba9TAlTut127lqDqIeIRfLqbci/vFcyP7aM8uz3kJsm2dObJKdEFhe
	 htjzGn5KEhotw==
From: Vinod Koul <vkoul@kernel.org>
To: ldewangan@nvidia.com, jonathanh@nvidia.com, akhilrajeev@nvidia.com, 
 Frank.Li@kernel.org, thierry.reding@kernel.org, digetx@gmail.com, 
 pkunapuli@nvidia.com, dmaengine@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kartik Rajput <kkartik@nvidia.com>
Cc: stable@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
In-Reply-To: <20260422064134.1323610-1-kkartik@nvidia.com>
References: <20260422064134.1323610-1-kkartik@nvidia.com>
Subject: Re: [PATCH RESEND] dmaengine: tegra: Fix burst size calculation
Message-Id: <178092084039.97019.1123733589593196697.b4-ty@kernel.org>
Date: Mon, 08 Jun 2026 17:44:00 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Wed, 22 Apr 2026 12:11:34 +0530, Kartik Rajput wrote:
> Currently, the Tegra GPC DMA hardware requires the transfer length to
> be a multiple of the max burst size configured for the channel. When a
> client requests a transfer where the length is not evenly divisible by
> the configured max burst size, the DMA hangs with partial burst at
> the end.
> 
> Fix this by reducing the burst size to the largest power-of-2 value
> that evenly divides the transfer length. For example, a 40-byte
> transfer with a 16-byte max burst will now use an 8-byte burst
> (40 / 8 = 5 complete bursts) instead of causing a hang.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: tegra: Fix burst size calculation
      commit: 4651df83b6c796daead3447e8fd874322918ee4f

Best regards,
-- 
~Vinod


