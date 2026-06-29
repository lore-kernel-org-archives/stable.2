Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B3640BCB3;
	Tue, 30 Jun 2026 11:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818266; cv=none; b=IrX1jyH3L3U5S1qwMZnoRd3ZodyXg9TV9QIj3eAoW/Ud2O5bm+VHEITk6eE2Axbf869WqwbYnMpaFeQ+bvD43pCWDrOwUt0UzCnOBmvo+B7NSJuGbd+n4CxcNn0Qmk10PfoXEP+gEuJpzd/JfZaBxoADJb7ITHq46NdkLOjRUI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818266; c=relaxed/simple;
	bh=MGIVC1DD8VgY6uxmoyuNQeSC350bu+eTLIq3Y3zrEcY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=X8ASltYaFZ/TA4jC3hOatu4cloHdMM9SZVcavoRtV8daYoQjetZFOf3XWyV+hymeff6hVetHQgV6KnbPT9woRdb0CcocX725515GLNWey3UeTs5sFBdacAeAWojIOAqIfu1eV523Lhm5z/p9iujb1FhEGDBdzi5Ve8cMXZrHMGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFK0l3E1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFK0l3E1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CF41F000E9;
	Tue, 30 Jun 2026 11:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782818265;
	bh=ZsPYKC6AycrrPJdSWjAj1t46PsKiW9etUXR1D/I67WY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=oFK0l3E17xGRshVCxuEHIF0zFyK3pzKFOSDTgLHFCpFZ45Lur/CoLFb3KEdc9HH/o
	 DiyiKZ8zAU3lYBCy0BvumgcQmbu1XduCevCbsh5ovXJvpwnrNkWrMdZGGpgRjVYrnb
	 inINxy7c0s1VY+ZxGRe0UQfFn1lgPzhevCWXJKF4/wRe9s6rHLGF4J6vS598AJJ39Q
	 GQNW9AjpLJaFBbPHhFB9pH1nFMIUT/NJVMGLcCh/M5CRwl1O/1bF+/r5hKdzu9hy3n
	 vCGX2MTiAdW2XZfKYbib6Ga4gO3jjylh0amI/oLVIpXAkzWRkYnp2QrStmMWVIhppV
	 6/zU7DctmzYbQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com, 
 pierre-louis.bossart@linux.dev, rakesh.a.ughreja@intel.com, 
 Haoxiang Li <haoxiang_li2024@163.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260622145645.1184986-1-haoxiang_li2024@163.com>
References: <20260622145645.1184986-1-haoxiang_li2024@163.com>
Subject: Re: [PATCH] ASoC: hdac_hda: Fix hlink refcount leak on component
 registration failure
Message-Id: <178275551205.47562.11203769256312535290.b4-ty@b4>
Date: Mon, 29 Jun 2026 18:51:52 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163; i=broonie@kernel.org;
 h=from:subject:message-id; bh=MGIVC1DD8VgY6uxmoyuNQeSC350bu+eTLIq3Y3zrEcY=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqQ6XWlzibOxaaUVPE2n57uaW7bCIS4oVOzlxF3
 w10vnLoBJWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCakOl1gAKCRAk1otyXVSH
 0EYHB/96+0yDbrmPdUWE4g3+sYhnpg1x1hOKoVTiBDQRMspgfs4CW8yLMwvplT1YhIXgSZtAiwX
 88mwliSWNskSqR3Nbb30rk5IGc5dmEpmNb73xG/Eh5hQhTKTHNS7jUicCc227xIV+bZ7fL02ufK
 c6KiFbih6S5WuWt11MiEyQVNx4Nu5NGHivysCg94BrTfwhrjFFiG+lnYueq3ZiXfurjr7vgTzC3
 LzuALXff0HtJ/TOzoKv7GWr18DKaFik8x5qEnZoN0i/eA1OzX4X+HsOvY6DbAuPgVL7Y/xx7EFj
 ZD+6NrUwYeha/zJPe+lZZTMHA/zr2FS6SjCskb2XRYfG3Ze8
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 22 Jun 2026 22:56:45 +0800, Haoxiang Li wrote:
> ASoC: hdac_hda: Fix hlink refcount leak on component registration failure

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: hdac_hda: Fix hlink refcount leak on component registration failure
      https://git.kernel.org/broonie/sound/c/6ad4892c4f5c

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

