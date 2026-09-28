Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D67633E37C;
	Mon, 28 Sep 2026 21:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790629365; cv=none; b=BRGfg2XDCIW2n9bLRxJyx+Ln/N/naPhUJzQK0UI+pfgXN0ZhyxCP09zuuIuWu4HJ9q3txHVPsIUJHjJO0gdZqhwsgHoSfljJZY5pbu49fErXhxWOlYPT9+P42JEQJ+W81d5RtBRGAfgPJjOJhcw77zydPRHbpGhNQtQc8ylUG9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790629365; c=relaxed/simple;
	bh=YIBTHCMGPr7u/AIAx7AOxyZ4KyASKRxONHbPcn7COCE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XzjgB9uKL7DSOnRX+El+d90nSv3K7Xv6FFxKgtZhW4x/CkEVXiXLcD+VJBNaIIB0OIlH3HrM1sKXbEzG7Pcjk+pGP/WW1ABIlfKNzjQNG2dn9UoBsLAqvlQXYbZniRfVTpYm1zD6SlVFxb3IAKe/TDgjRevLQozlPvIllIzj1dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zo//HJtk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zo//HJtk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D9C1F000FF;
	Mon, 28 Sep 2026 21:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790629364;
	bh=HZ/WEzkBIU9A05VT2kgF1uov4xnMpyIeWcCto5V+UAM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Zo//HJtk0ZRMBObe0pGjJ+7D/yPjufR5VbAEon0YR5/LnI4gJzxd+BoQtU7jAlGaO
	 yCwER3GhPxEzoBVdqpVTCAsAtz9fF/Uh2cvPDcX4MhoNx3zJoliaLHPlC7coEaCrDK
	 oppvm3CXYrOkUeJDBq8I0klvtz6J/EBIIyk9ewaSNF7wNYx0EO1AvphnK1ZCDv+zLJ
	 3uvnji23o7GEtvX7mKoBdObHEEhPMRp5hf/KiR9oLOLHtrmD7TienIdFcThAbQtUbt
	 5cJZbzgJaxWaiTxl9SkLIk71b3FRVBLB1ThLZ+1QKDCgGKiSDYp1ayQrMWfix850X0
	 FuV1PTyR73VoQ==
From: Mark Brown <broonie@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
 srini@kernel.org, tiwai@suse.com, vkoul@kernel.org, stable@vger.kernel.org
In-Reply-To: <20260917164853.2163184-1-vulab@iscas.ac.cn>
References: <20260917164853.2163184-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: codecs: wcd9335: Fix SLIM interface device leak
 in wcd9335_slim_status()
Message-Id: <179060118005.139547.15844525180224544063.b4-ty@b4>
Date: Mon, 28 Sep 2026 14:13:00 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1174; i=broonie@kernel.org;
 h=from:subject:message-id; bh=YIBTHCMGPr7u/AIAx7AOxyZ4KyASKRxONHbPcn7COCE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqutXwQWqY68SZP5CED+FTQSEMkzIdSUM1Sl5Eo
 lCsZIEF6TaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarrV8AAKCRAk1otyXVSH
 0CBAB/99HDxwcX0HGWcGraeAByZixlcAeb6lkQi2HGG/xbxP2ZLwRCv7gtr5wUPCECd4TDqTc87
 ZB9ah035VqSO6XlxujIKAug+ol/Gc6B6z1yyTf5dL4EiYPuxreX7I6Misd9wfwNIhCHhGkcFF3e
 PjzwHBkN0ckL04HKdoT8zNxiERPAp5dYi8RwO0QAjHet994kjAygemTxzS4zpZ+FXzMc6h6x/9x
 Y60dbh7z8V1DF3wr6aANU+D/ZfV3Ai9QhNGaVBl9ORyxANqTY9dbmv7XMU0MGqQcwBJvFvR6oI7
 aESgtxsOmCkzjP8kr+lAoRxFL1y+VHhQMqKINnxv0ld+H1Gs
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 17 Sep 2026 16:48:53 +0000, Wentao Liang wrote:
> ASoC: codecs: wcd9335: Fix SLIM interface device leak in wcd9335_slim_status()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: codecs: wcd9335: Fix SLIM interface device leak in wcd9335_slim_status()
      https://git.kernel.org/broonie/sound/c/082723fee626

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

