Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D2A322B87;
	Fri, 31 Jul 2026 11:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785498374; cv=none; b=lbnaYYpI9Q7zHVE0kJLhEMycSR3ZXGV1dCIirMk9M1qMXk0KwvKejPx0wll4MoaGUdrw2FxJItZov4UYRs9I0FQi9PLDblZnM0x3ZHLdsZb7h1dexaAp2t0yVREPY0p3+xmhJsP/EQY2kZMGs5qfxI4equmdYWS8pXQz3lB0qyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785498374; c=relaxed/simple;
	bh=mRSAZYo6GCABjsRKbuPKzhi8sQ5rVy42x0MYznrY5p4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eSwqHk49AOT45Llwnqtz7ZaeAAvNqquJ5WaIMBuPKcjjCfo623XjkoQrvVb9nzvFwjdLYJu1Q6HOihAflH1uOY+yfHxv8qYIpVnNvYERE/RewEsx4FDclsFcAVAaMSVD4+uHqzgJAsqz7YpedFAURCi3RaU9SN5GKocQrmmu9LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReQUV7pz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReQUV7pz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40B91F00A3A;
	Fri, 31 Jul 2026 11:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785498373;
	bh=+BGrzaifQXiNoTBg8OsZr4joJMAQIACWLgaN+kkkLfU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=ReQUV7pzFhiyF702/SnvFZcU2NHQu3qi0nNs0PEAj/hRuyMMDigEJOYe6i9x16IKH
	 DvIO56bySUrt7a9JbYbkFS3GJuuPT6QyuswevGq5TZMbK7bW00LiL+nC6QurzXuG+t
	 JYei5R3X5wrJvdxNCA4uGS6ECG86nye8+NydNphPCANIP5nc3pRsNUuZQp2qvjr2Ze
	 Veti/UxV+pxix1hDCjRHKq5yI/F54K6qOlLxbKp+v+CTic6RuTKPTbgNOl3+lge3N0
	 kq9pK2d9aYpY8Z12+YjGhgRj/jGAkl9TUlA/QePwQvwyYAkQf5KLSjK/++aVRU3ksV
	 VhFtikh36ab3w==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev, 
 stable@vger.kernel.org
In-Reply-To: <20260730085914.27546-1-peter.ujfalusi@linux.intel.com>
References: <20260730085914.27546-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: sof-audio: Fix error path in
 sof_widget_setup_unlocked()
Message-Id: <178545297273.556383.14194133461657094006.b4-ty@b4>
Date: Fri, 31 Jul 2026 00:09:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev

On Thu, 30 Jul 2026 11:59:14 +0300, Peter Ujfalusi wrote:
> ASoC: SOF: sof-audio: Fix error path in sof_widget_setup_unlocked()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/1] ASoC: SOF: sof-audio: Fix error path in sof_widget_setup_unlocked()
      https://git.kernel.org/broonie/sound/c/e780e4917d43

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

