Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FDA4156EB;
	Sat,  8 Aug 2026 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786193390; cv=none; b=ZScuCRaj315uHMn3ZxRuT1+kJba7reOtoz/OfBZbMNNf3NYHKygjblwigOL817gPDZbDEXfRsqh3EiruqvNBGwV8+xWzZ61qDkBvhzeWOyf0jWmndN3bIR7bazjj6YzHGZwayg1DjxtpkfchPZgz+C2IuEIF23QjKSz/yGOKuhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786193390; c=relaxed/simple;
	bh=3/zmR+iG281i6SJjjbWhTBc79m9ocW1KPCVmRaLca9s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CafinCr5DvNXD5MrNMt15SwmrYMJsMDxf462TBOQAMcIr3dVyJEJu8YvonhiO0bYXP7o/LCZ87k7DNKQTwOUlA6lW8OsMCo7364v9hOOEhr4Re1goMyY/U5ypCOmVlaKhvxQJMYntFT5zwJnwX+Z8f80Zfw7fncQcTbIhWzzrUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WumAEGlR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WumAEGlR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13391F00A3D;
	Sat,  8 Aug 2026 12:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786193377;
	bh=OPyIRppVHBDsF8z6XGGyoUSRn5EECbcEg9MP8wE6EqQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=WumAEGlR9/BT/f1dqsUDxQKadyrcB5Euw5IZP/zUCJejF3PKuwNBI6FrTmJDQSPLn
	 9nIQa67WSco4RG1CUrHHXjNTtXKkBYfM5dl7ypckck7zSrgnVeUl2xxo9b6toc85nC
	 EAgMQlOmS4DLcMeU6k0UL5hEYg5KjtUf3qzJk7mEiJruzGD+jwLT7fc5h9CYFGpagd
	 orhYdiAriZGtTiuBWexupVpHAvqil/eiM8hv+viaPa22nK9jlTuWuz6TRZiC/SjWGM
	 6k8uX1p2TkNknt5OT5tF8Q3224ieqKAFkeNBVeJdfnbxYE/CjY4el0QyFwocEssbAp
	 i6sSZb5EvYfRA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Sheetal <sheetal@nvidia.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260805122748.13090-1-peter.ujfalusi@linux.intel.com>
References: <20260805122748.13090-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH 0/3] ASoC: tegra: sort the reg_defaults tables
Message-Id: <178611462702.279158.14167209262768966207.b4-ty@b4>
Date: Fri, 07 Aug 2026 15:57:07 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev

On Wed, 05 Aug 2026 15:27:45 +0300, Peter Ujfalusi wrote:
> ASoC: tegra: sort the reg_defaults tables
> 
> reg_defaults must be sorted by ascending register address, since
> regcache_lookup_reg() locates entries in it with bsearch().  When a table is
> not sorted, bsearch() cannot find the entries which follow a descending step,
> so regcache_reg_needs_sync() falls back to reporting that a sync is needed for
> them.  Those registers are then written to the device on every regcache_sync()
> even when they were never touched.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/3] ASoC: tegra210_i2s: sort the register default table
      https://git.kernel.org/broonie/sound/c/597273563d90
[2/3] ASoC: tegra210_i2s: sort the Tegra264 register default table
      https://git.kernel.org/broonie/sound/c/82da8df38800
[3/3] ASoC: tegra210_mixer: sort the register default table
      https://git.kernel.org/broonie/sound/c/f70bc276fc7f

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

