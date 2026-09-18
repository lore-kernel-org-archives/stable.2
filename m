Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAEB3DD521;
	Fri, 18 Sep 2026 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789765406; cv=none; b=Mua2actymtydjKDB6URybqOxesNo1ONFyWEd/zGcAIkdNRiu3/qjBLubXjozKfZYOrjB91GUmNbwdz3gRE2r8MesdvMSxVeNuPuGpbwsnQPkbOSK6W+E61KkEJm4v9j0BBMFLWEHbkf8JzsLsxCGDTqipHC/I+Lh5+Ee6H0mdyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789765406; c=relaxed/simple;
	bh=CwHoc4ZVYGzWx9PnPQWbk1BSZlHW64DYNXiHBxOUPG0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kGE2j4DyY+BqqiwKV09nc6Ket24fDRugJB5kRjtgn6OQ7CkxC4eQxUxXiKoKDWPEcRNkLOYUfrryZfkirLRSh0MobIjKw4+i0VWfafGaOL6b65wUtfylBoF1KLHGEem7U6R20R+G2bQSkBtvWerT7W2mc4LG0l1HImCU8VnmNmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnCI60Xq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnCI60Xq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391951F0089A;
	Fri, 18 Sep 2026 21:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789765404;
	bh=dhmDpXu1C4/MjBnY4A4TGayfqScAD6ccHOkF3hUkU7o=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QnCI60Xq2g16nh7A93bCjg92H3KOcRIudejRhvKfJcFGt8lPKICDreHDwN5UR4fwS
	 k9BsEY5vZi2X/wz5pYvNwp/aIT6knGEdd9zk3hS3DP1MQXZmYDtNAcjW/M9+O1ZArk
	 lFggfygh6pFURbXY9tf3+CHJ20dQ3XC9RbjuV/mMLIFEGBF/VHCCwsOMgXClCBE30s
	 KS4gRATzopA3e7qhcT+B32YFKUupz2E276wuZZGDGR9Ifmh/wXiDyeddpJbzLVrK0E
	 ju/0dZ+C7ADIlTWLdL2hXg+YAzJ1593KYc+Aoacth0mdJLe7Xsyf78HZ1wGbVMHwEV
	 UNulvyRU+u8ew==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: ckeepax@opensource.cirrus.com, pengpeng@iscas.ac.cn, 
 pierre-louis.bossart@linux.dev, ryans.lee@analog.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 13667453960@163.com, stable@vger.kernel.org
In-Reply-To: <20260914104456.376666-1-yijiangshan@kylinos.cn>
References: <20260914104456.376666-1-yijiangshan@kylinos.cn>
Subject: Re: [PATCH] ASoC: codecs: max98363: fix uninitialized
 stream_config->type
Message-Id: <178975466213.1812520.177787774882724798.b4-ty@b4>
Date: Fri, 18 Sep 2026 19:04:22 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1140; i=broonie@kernel.org;
 h=from:subject:message-id; bh=CwHoc4ZVYGzWx9PnPQWbk1BSZlHW64DYNXiHBxOUPG0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqracWDnjZLmqVXvviOC0KIwCF8WeGzJD3Lm0LR
 1fMPJ+8EiyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaq2nFgAKCRAk1otyXVSH
 0JBFB/9C5WdZdtMa2ceED7h/6UpsXtiQYGHzf158LZQdRVZq1c+ysuH3ykAnDAVD3fxklh4upsB
 TYGJGHztwAOHXhKM4nnOlOnoSGayc90TcQSi1EpzgRebpAUkop5x9gRWzWFiKuWWkPMLnwe14WT
 fXrCrzF4FNsHLWjyocXowsEji2dvf488SnSw9gV5oCt4I7RD2Rj9/ay4WZadaPxRFBP4Eq8/nbP
 sW7sJJvxtI9SNAAq8dhBy57LIEuOj+0Q8VNd3lQ2xI/d4t7gcVwLmOJ1d8Bv0ynknCToh7e+fjE
 JJPG6jRF3htxwP0KwvVTcpW7WJNcmUL8MVaAk5anXmwpVUu3
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 14 Sep 2026 18:44:56 +0800, Jiangshan Yi wrote:
> ASoC: codecs: max98363: fix uninitialized stream_config->type

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: codecs: max98363: fix uninitialized stream_config->type
      https://git.kernel.org/broonie/sound/c/bcd61aa247c2

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

