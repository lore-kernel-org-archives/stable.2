Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E672D2877DE;
	Wed,  3 Jun 2026 07:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780470284; cv=none; b=YaBBW3CdtUpe5kIdzKJcqaAjwvA8u4c+frctDYUsHNw1DFdtQo/2MQuCYIpiR2TuVgT5kuGiHIPQvBnZpIsNPppv1iGaKCmc+a04QgHJQMv2H0k5Ks2wv9EkLOHaz3k++8Ce8zYkFg00WEdAe62DZDTwI54CC1/dWawE8e9q81E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780470284; c=relaxed/simple;
	bh=omcsqXZIrjlqQYaLvoAefesboTuwmjaOhgkh4sN/v3s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bMoRtUrHVi256ygIZceYMG42Zhe+7saDYZU62vJoA7Q5VNBOiZovnAC3f04Gwxjx3fTQwqstNeApXi/7zOmF8hhUzEjnez9AbmFVhWiRjTFYrmQi7P3ymq8z7fNBUzOxArlk9rFdd8qNWCBldkzVhHP2Tbgz0L7lxH+suPde3qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7Oq5YUt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7Oq5YUt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59D41F00893;
	Wed,  3 Jun 2026 07:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780470283;
	bh=HJ8mECA75kUOQcjtQgtAIPOPtq8u7hZP0f/rp6Q850s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=n7Oq5YUtLDaMxkOTwEH9/lffKLtQ89ngP7idpkE63mC51fdHY7a/PWDigxIi8vaMg
	 wcb+wa9ls9QKRtkyPKqQOuA2mL0gfYQnlSiiaRRAjGuoHW4CbZAjFDLBQ40WP1F2gY
	 +RrrOE758ljDi+0t31xv3w919ENSVkujHYTW9SEGrT/G1osv7NpWFNlgXPaqT3kKX7
	 +Ex2IHWnU0j4ck0VXO8Bo1dp6jAVdJ11HZfVTgPZdvn3+/oSzg7eqy/fhMpB8BuzrP
	 fXdZFgZlsO1kRw/uAyy6z/u378msePpjBn2paZHN7Q0uLyFO4OMX6SbtJaVpb/Gj0K
	 WiGoDOQRsVWGA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, 
 Jaroslav Kysela <perex@perex.cz>, Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chen-Yu Tsai <wenst@chromium.org>, Jiaxin Yu <jiaxin.yu@mediatek.com>, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 notify@kernel.org, stable@vger.kernel.org
In-Reply-To: <20260527-asoc-mt8192-probe-cleanup-v1-0-1bb834d05b72@gmail.com>
References: <20260527-asoc-mt8192-probe-cleanup-v1-0-1bb834d05b72@gmail.com>
Subject: Re: [PATCH 0/2] ASoC: mediatek: mt8192 probe cleanup
Message-Id: <178041319393.93058.14289988542820157532.b4-ty@b4>
Date: Tue, 02 Jun 2026 16:13:13 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1517; i=broonie@kernel.org;
 h=from:subject:message-id; bh=omcsqXZIrjlqQYaLvoAefesboTuwmjaOhgkh4sN/v3s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqH9IHRwReoqhf5cLMJ8qmFQaLwz8otJHMPte41
 nJ7EnZcH9+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCah/SBwAKCRAk1otyXVSH
 0O4rB/9RHsCPVXWkcxMYSsFb1OiZkZvz4SgI/HeA7wO5PWl6cBpRHbv19PAItK8oTmx9A6n/G9X
 Kr60hNXyoxPL9RPEtE+Ps8mu4/wfAvog9Bj7+a41T6JFdEyHVOMso5Gy3fXCM2uT3MczYZOlt3T
 WiVzj34FPJYHOR1v/CeiC9p3oZxCl/Fym9Y0AzW3HOdW5A15VzOY1lqpCRjP7I90oDaJgqng7KB
 wg5dPmMrDAP0R6DIa+ONoB+DmW5j1oEG9xHseoW4TYru47HWi9FURHAbpAH2da0JW/8eHUCdAq/
 1o/SDmNiPtnSeP8Rhg1v1aaFGLCCRiANmvhkHKq/YjeYEW3D
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 27 May 2026 10:55:45 -0300, Cássio Gabriel wrote:
> ASoC: mediatek: mt8192 probe cleanup
> 
> Fix two MT8192 AFE probe cleanup issues that mirror the recently fixed
> MT8189 and MT8196 paths.
> 
> The first patch registers a devm cleanup action for a successful
> reserved-memory assignment so later probe failures and driver unbind
> release it.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/2] ASoC: mediatek: mt8192: Release reserved memory on cleanup
      https://git.kernel.org/broonie/sound/c/965e17ae6751
[2/2] ASoC: mediatek: mt8192: Check runtime resume during probe
      https://git.kernel.org/broonie/sound/c/e24d5dde56a5

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

