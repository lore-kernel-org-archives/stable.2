Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F074840EB9B;
	Sat,  8 Aug 2026 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786193380; cv=none; b=fDsC2QcjwmmAsiZ3J9L8HT06keJl0Qwbd4GL6+Ap8ERgZAzBLa+xnKEGva2czk4uPkFgcPg5z8PLWZyfdxxszJMOht/DDK//87pILTjW0ZSr1ODWhkD4y7ZH0DSdKwcNcm3cCut908xi1r0mEdQMtQHSs24h3jefhyYKMxiZY5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786193380; c=relaxed/simple;
	bh=CrkUy5FkcOFE4m5SizaLlAr1/b/2p4Jr+PpRw1ne7xw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=S5Ad0QTHkIdDZTmCww0PpcoACq0oKljRZ0Phl9w+XveN1aM2gXWUNRIRtftTrY0g+L4+k92GyDolZ2hcytAL2TctJ0qKsDcs3aRgvSH9t/B2d874PtBQkqQfUYvWxsiQ+ODp/uRzYgxwVXfIErdS6/60vBrP/TsBwk7pEmQiCNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkY4GB5v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkY4GB5v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F2821F00A3E;
	Sat,  8 Aug 2026 12:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786193368;
	bh=7K/Dn3oJ3GB8cTQwbCB4pS+huon1UkmPMR7nVOu/ULM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=lkY4GB5vbiQM18yKJnF4ycIP8jALyHJMh70TZeDrbXHNS/jbTX6M9Ng1/rgrQ1LG6
	 XOc7g0H3riM2ID+rXEC7NNLZkNgA0VggIysas1jwvNdmtLc9TK375qpOKO/8P2sIkQ
	 KaKBV3LQXqxuSUAcTu7mjNihhiDdHwJylU85HtgWPtL1xvdksF/B/M0AIZJayWvBE9
	 Z8BnvNjRFFsohRUittmZu6AQN1PY42t5gz95sEvjj1S+GGWsZRz4OCrEkcQCgujTqt
	 8IzSCY2BKl92tsuhAxtawOlibkGwuHHmVqOiGvfEdfU89SN+QH19OUEZ508UnOLCCw
	 y/fMm+3hRm6mg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Oder Chiou <oder_chiou@realtek.com>, Shuming Fan <shumingf@realtek.com>, 
 Jack Yu <jack.yu@realtek.com>, Derek Fang <derek.fang@realtek.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>, 
 linux-sound@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260805090240.16991-1-peter.ujfalusi@linux.intel.com>
References: <20260805090240.16991-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH 00/17] ASoC: Realtek codecs: sort the reg_defaults
 tables
Message-Id: <178611396385.279158.2481466653912917281.b4-ty@b4>
Date: Fri, 07 Aug 2026 15:46:03 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev

On Wed, 05 Aug 2026 12:02:23 +0300, Peter Ujfalusi wrote:
> ASoC: Realtek codecs: sort the reg_defaults tables
> 
> Hi,
> 
> reg_defaults must be sorted by ascending register address as
> regcache_lookup_reg() locates the entries in it with bsearch(), see commit
> fd80df352ba1 ("regcache: Add support for sorting defaults arrays").
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[01/17] ASoC: rt274: sort the register default table
        https://git.kernel.org/broonie/sound/c/6a147d177819
[02/17] ASoC: rt286: sort the register default table
        https://git.kernel.org/broonie/sound/c/c30771968b53
[03/17] ASoC: rt298: sort the register default table
        https://git.kernel.org/broonie/sound/c/aa4c472b0f4a
[04/17] ASoC: rt700: drop duplicate reg_default entry
        https://git.kernel.org/broonie/sound/c/90ad6a29809d
[05/17] ASoC: rt700: sort the register default table
        https://git.kernel.org/broonie/sound/c/18f21e34493b
[06/17] ASoC: rt711: sort the register default table
        https://git.kernel.org/broonie/sound/c/55fe63530772
[07/17] ASoC: rt711-sdca: sort the register default tables
        https://git.kernel.org/broonie/sound/c/b8fdd467bb5d
[08/17] ASoC: rt712-sdca-dmic: sort the register default table
        https://git.kernel.org/broonie/sound/c/b9339ee3fccc
[09/17] ASoC: rt712-sdca-sdw: sort the register default table
        https://git.kernel.org/broonie/sound/c/efd430c4d042
[10/17] ASoC: rt715: sort the register default table
        https://git.kernel.org/broonie/sound/c/d729804a92dc
[11/17] ASoC: rt715-sdca: drop duplicate reg_default entries
        https://git.kernel.org/broonie/sound/c/c9875bba469c
[12/17] ASoC: rt715-sdca: sort the register default tables
        https://git.kernel.org/broonie/sound/c/61a0321e4bc2
[13/17] ASoC: rt721-sdca-sdw: sort the register default table
        https://git.kernel.org/broonie/sound/c/70e0481c196e
[14/17] ASoC: rt1017-sdca-sdw: sort the register default table
        https://git.kernel.org/broonie/sound/c/5b48ce0356b1
[15/17] ASoC: rt1316-sdw: sort the register default table
        https://git.kernel.org/broonie/sound/c/7b48eccfbb9b
[16/17] ASoC: rt1318: sort the register default table
        https://git.kernel.org/broonie/sound/c/2a8e4b7114f6
[17/17] ASoC: rt1318-sdw: sort the register default table
        https://git.kernel.org/broonie/sound/c/3673b33633a5

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

