Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B662C366567;
	Mon, 14 Sep 2026 22:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789426431; cv=none; b=qtEtSLjr5ugVaVHqdS+x6cjX1PVWU+rBIwN7kozJ92fKKFBHR4xcsNCu6QbVFmsTlbsEGwP+LETPtFjMw1DCpXDhIN+i28zXytWOD5G53tQGx62O8T25YtBznuQ8ZjCRVouPxbZROQZo0PErYWXdMwPcTeJpP7ndpXWCOCVIYG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789426431; c=relaxed/simple;
	bh=T5xasH9os4v4epaEnMP3efQ2DNjo+MZCyF3nOJmiL6k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Ub5t2y/U1ErSEz71euzjAfcTTI8A1ylbQXaqFJCbA268XrDkFPfHCB3/b6VxE5kuSrrRxCG0a1Eug9Qquz0742hnscljt9M5QxXoTZPszniPeaSWKcwKzzM1GfXohs25Td6eQng+drdgeVjfRZw6yeLxhSvNNqUCHCV+ChLB1yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpD+3UQx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpD+3UQx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52EA1F000FF;
	Mon, 14 Sep 2026 22:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789426430;
	bh=XKep4A8bbtQC3AdBRVuyPS8K5hwyIDKEZaAfw3Snhq8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=kpD+3UQxCAp2FkoUjMr5IDGxbkoe5O4y28OL5GqTmoPOZWGFfQ2cSrXkYYCNG2YQt
	 e12sufVjX4Avulwpi5IkKvVgWALMe1k9+2qwCRRjsZ4Y3eltgO/gj+v8X4nFK6IQTd
	 WsPDp6JrtgXFliGBLagZLAP3Yiefe04s7mFP5HYBL0px7V/TyNvI4Ps+vTsHOOH23q
	 477FV0p5VqszLYNbQ6AnvXldyOQ2LBE1t2PepIWH6mV1jkk/AdjOlPMvhsdNOCzDrk
	 XKdRhyGS4CFr02rrUd6lNm23zxeiiDY0eVy1TQQV8gomBQrE4RwTbADZdaglOEaUZK
	 B6dR1yWrLf/hg==
From: Mark Brown <broonie@kernel.org>
To: oder_chiou@realtek.com, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: shumingf@realtek.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 13667453960@163.com, stable@vger.kernel.org
In-Reply-To: <20260914104712.379574-1-yijiangshan@kylinos.cn>
References: <20260914104712.379574-1-yijiangshan@kylinos.cn>
Subject: Re: [PATCH] ASoC: codecs: rt712-sdca-dmic: fix uninitialized
 stream_config->type
Message-Id: <178941264882.1239410.4388515452598692969.b4-ty@b4>
Date: Mon, 14 Sep 2026 20:04:08 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1154; i=broonie@kernel.org;
 h=from:subject:message-id; bh=T5xasH9os4v4epaEnMP3efQ2DNjo+MZCyF3nOJmiL6k=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqqHr4fTGqYJP+ARgdzfEjmtrnJZ7kT7QX3X2Ta
 q8yBtDekP6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaqh6+AAKCRAk1otyXVSH
 0I4+B/9dXutNNgMkUFofjl46ZnjpuOoM+X50f7frsK+dnOOEy7F17fCcPWxGYfHBSOm2IQ8rSlO
 m2gCDvjLDhtfBj8ywv71ZurydVm1Cisv7HX5bo0RV2R1KU1Atw9GM4CVL2303fOPYUwt1f/V0ct
 3xeibi88dYkf7mvegEvqXyksD9JBoyLZ7wTVBDThB9u1kUOjL84GBTpIQ6ZN3a/oa6fRRmlqU7x
 u9adTVJweiO3EAE3WbARwc2mYKy7zrkY96W1u9e1I6HLqHIYsiJBEulttEAWCoNOLB7N5yWOEgp
 PoOYFXe6LkzUtRYz9+IhdmDA/FXfpdXVvwyMT7/Uq+/wHbXz
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 14 Sep 2026 18:47:12 +0800, Jiangshan Yi wrote:
> ASoC: codecs: rt712-sdca-dmic: fix uninitialized stream_config->type

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: codecs: rt712-sdca-dmic: fix uninitialized stream_config->type
      https://git.kernel.org/broonie/sound/c/1e76ec00f75d

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

