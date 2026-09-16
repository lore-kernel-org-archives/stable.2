Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820DF4D9F6B;
	Thu, 17 Sep 2026 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644738; cv=none; b=pTEm/IY4cA5aQDaAkvviwtAXrsXbZolPhEoRHt3euCLQL0bH1CcLB2U+FwmmrvD1kYXy2i2Da4MQ/Xy+J5zsZ0hmSNNAsS//Ogw/sEuDwcVjkBJpkgp72yHzY7vVmHDxLsryz/HtX2S+fTG4vVkmX/09zI5KeG/paHJ34HqK0+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644738; c=relaxed/simple;
	bh=tZkMYfeUlMMOkb3JC824uePsRTHVBfKjh94Bu36UGdk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=TFOnloScu3ldQw+NQnsawcjpcH/dq2Hb+HYyiGdmgAiimeBPycTfFPP7u3d/QMJvK+DHJLEFxLRoQDZhaZY3hmtniJMs9+wCvbwkLkKZe62U13PP1zuizYxGFIJ6xKZnVPhzHsrGMRi5LiqXTWkE4bVfTqCZugKqvDdax8aKQqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtPAJ4UQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtPAJ4UQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6811F000FF;
	Thu, 17 Sep 2026 11:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789644737;
	bh=dMkH28TbGq5J9Hj3LtfnwFQ9xmEwq0M7slB1J8B0kd0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=RtPAJ4UQ22Oi8cClEqqizf64yFxgAZbSJA50x+dGE9GJssIqSKxtIj1VYjT+PX6+5
	 wz0897k4rkvulq17UuYpMsKDlw/72JOQrzTl8zRPzhKalgYbDthtRIp+RI8oocDPKu
	 iT5VJN8VTToIU5EEAeMvXk9WcGsBXE48tDXMNLn1QAhtU3W0DuOpgxqswIIMDBzEEt
	 Ko9fTJomx3v705P51g2thQ/5Nd7IQVUKxSUlr2esTIsEHV8Kt7MUhFBq9PE9d3MGa1
	 8CENT6HauB2mY+jaZFeVjq1PR6JrXgAQNFXBpUlJJX/o752wlLJoOWSbrLra8vIhfu
	 WKHwzbvQa95TQ==
From: Mark Brown <broonie@kernel.org>
To: oder_chiou@realtek.com, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: shumingf@realtek.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 13667453960@163.com, stable@vger.kernel.org
In-Reply-To: <20260914104712.379574-1-yijiangshan@kylinos.cn>
References: <20260914104712.379574-1-yijiangshan@kylinos.cn>
Subject: Re: [PATCH] ASoC: codecs: rt712-sdca-dmic: fix uninitialized
 stream_config->type
Message-Id: <178958559020.100121.9019101554729887095.b4-ty@b4>
Date: Wed, 16 Sep 2026 20:06:30 +0100
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
 h=from:subject:message-id; bh=tZkMYfeUlMMOkb3JC824uePsRTHVBfKjh94Bu36UGdk=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqq8+8GMXahanaM/HfKgCkmBIRHbYYSsxy3+cgP
 heZyOgBTZ+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaqvPvAAKCRAk1otyXVSH
 0CtQB/9ZIgGlbUWZAfXEWnQna6jWPd4052/J8rE43kO4A2NYUV8fuSIn3aZ4QU6YgEA25Ku5mw0
 yTRJA4OugYery2kR6+++dkUj7bdHUJ3dzCijfp3ncutDarAJ3Ci6AEJM9hR5IqRH7sqp3FTmfYJ
 bmtOUUBQV3xM0b1fYNbt5DwwO1+Z1SV2hFhh8l9UvhwXVyRYEUyMhEF1Sc3MiPDBSyFO0ksMMh3
 43B6mTHJ+/a5jEw77DwWi8/olfjFgdNIzuijpzhJ6jpaPBd7oHpSNJTwD2sVA3/VtUO5ecNWY5g
 6NbVxeqoP1TtF7D7Y24GDu5qbC+79+YgvKp8BZB9Z7EpCMdK
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 14 Sep 2026 18:47:12 +0800, Jiangshan Yi wrote:
> ASoC: codecs: rt712-sdca-dmic: fix uninitialized stream_config->type

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: codecs: rt712-sdca-dmic: fix uninitialized stream_config->type
      https://git.kernel.org/broonie/sound/c/03a5699a0a04

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

