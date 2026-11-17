Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794955741;
	b=fJlPhp9W+9sGKnzvcxD4XIZGFZSbJK8WATe/JTNOSpfnYwRPdvrE0ZiLF5wlALPTASgF
	 4HD+EU9Ow6Vyxiry6hyrhPoUBsq9q8zKPlNDgE01YvjCjLhBB2w89zzBpS26qpCNKNN37
	 aZkMj9namWNJZ7ERSQ8pv2gHpU1tTt92xqMKM785RurTvNZeh+9L/FZEoXdXWbWWYz/5F
	 DpnoI9cUkfYUgvHgOlgLonBeRl9rortoIarsWon2OE3zNtNm/TZWpHNy+GfGWR9LeqiB0
	 F2FgZ7GXfGyuWJSJ/pr45SsKA+EV0LLSXM8keTqYTr3y+KMDFgFXslQ0SryzXLZQPFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955741;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ArWVCioqRAYU1DBQ14iLq9nWjOPf/7wvzc8f5ZutiGQ=;
	b=Y9Qk1C/mLT0+nCDsX7xFyTSkHjFTFlA98oQyoREuELJhrh4pk/agxahyWQm+tJmIt1cf
	 DIF1RVOOU16eKz5bq3E9Z3k/k1P99+xV6E7J3zo9CmD68a2DlS617SyopTAUtpK3K6xdn
	 HWY7VXkVyM/9pjVjhEvfk8jvCXBJygN/uurbzoVWAs1l7zQSHX2EKMRsvZzbFt7SmRb8F
	 IYdTZo4gdquqr04EpF3Nuhz41F/SqOA75yemvcEwT3oShXbajmMbDFtAZSV+JX3oMpfzI
	 VKExJ2G+k1ubJ0M3hwXDLDxakQKbCAhohN3xhFfPlLDYrsiBJ0ABjRsNM3fcr/6H4RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UctZxltv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FB8606A31C;
	Tue, 17 Nov 2026 22:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UctZxltv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260741F000C4;
	Tue, 17 Nov 2026 22:48:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794955740;
	bh=ArWVCioqRAYU1DBQ14iLq9nWjOPf/7wvzc8f5ZutiGQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=UctZxltvaA8GSDFkZU1da/WK7ISVXovEKUU3HsUfdT4YVagbG7/Qhz2FFwLqks+uS
	 ibFu/nZLRSDTK/b2G/K5Sw91OnnriorHpie9ITQutchR7mqS00d9Xp/UF6alGd33ei
	 ZVrtJCY3156QmFP0mkb534uxXT3j4b4gI97NpoQhvPCd8BpTF0KfgH1I2GSMxvbUJ1
	 U9QrlpJ8NBbj2OnwNJJLZP6WlzlaWymyvJButqiQlmsN38lLcYESd5YQiJnYhBTd4h
	 g2WFqcdW6fAATxjarhwX2dFULSiBa66COts8XcuHDV9e5dEiFK9ciXx9yQjR2pBHXS
	 oeXlzm6z98sUQ==
From: Mark Brown <broonie@kernel.org>
To: Oder Chiou <oder_chiou@realtek.com>, Hyunjung Ko <hj351016@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261117041323.4010546-1-hj351016@gmail.com>
References: <20261117041323.4010546-1-hj351016@gmail.com>
Subject: Re: [PATCH] ASoC: rt5665: do not block workqueue if card is
 unbound
Message-Id: <179495195777.77896.7427038422401917536.b4-ty@b4>
Date: Tue, 17 Nov 2026 21:45:57 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1127; i=broonie@kernel.org;
 h=from:subject:message-id; bh=AXeVYozYsjRCpxzI2MuR4/w9+tKyWxglsY3orBFdiio=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLL+3LyZndEU3tDvlLTvEEtC4PKXfW9sgncqX1POvblvx
 p49k719OkpZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCRi/MY/ukf4vtaIPvjhZWo
 fWjKRdb5zgKS2lPLH7seU/tko7J1ggXD/9ht3vcLwszWu5x97eiaLbzr+Mlo9xMb3UPkvl9s3VR
 azQ0A
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 17 Nov 2026 13:13:23 +0900, Hyunjung Ko wrote:
> ASoC: rt5665: do not block workqueue if card is unbound

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: rt5665: do not block workqueue if card is unbound
      https://git.kernel.org/broonie/sound/c/337a0fd20549

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

