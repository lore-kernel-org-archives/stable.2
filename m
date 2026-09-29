Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8E452CCD9;
	Tue, 29 Sep 2026 13:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790690008; cv=none; b=P/qCuctWa9cveJLavE8fqn7BUcSU6DDl7XJf+RW1glID5SUTnrcTNdqB2ZTklWDov4OsvdxwX6ciJXEahwfmJPeWtcvDo/i8sMj4yXRCmTBfX3BipIS/T41kQhoj+MhGSb/5EgjzOh9/sEDznmOr6V3Jzyp8aMiOnlJCaQ35tYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790690008; c=relaxed/simple;
	bh=70w3EKLMILMaFBQJ/Oy5PxHafQ/QfQ3X8Sz2BQG8k/M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Yv8V5jEfQN1PAOblJTkAc4bU+pvFGjsgGTCQtyPpbyuOsOBwsRjS8ogXCOyy560dLuySKk8nv+RKYq1pJbN3Bk35MgMoiPVeBRSfFzKstYtfGwJr82uy9MVXJH3ed/XTl504IMtqJyh55O3ruc/+aSGqaRFWevWBotjJ8+7amw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoDM0qoW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoDM0qoW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2B41F00893;
	Tue, 29 Sep 2026 13:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790690007;
	bh=T7yy7HSKbMPvX0YflCUGb8cY7EyJIdxulN89my8c2iE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=AoDM0qoWuclmwKFilUsRN/uCiLFzlv93ye0qIdN1pemrVW/ZerrsK51OwQE4ZmZsk
	 KYVlr4mWpuEYgxUaCc1wUHocP3XaKjkY9X061qsSddJq92/Ct2WjFsr+00tGxwvWIZ
	 BZBIH6Ebi5kRVWvCSGTRMU7nG4nS/Bv4GjCM1+diA2ZFKTuaSQRddyv4gq2VC+WxTy
	 ivflwFy480vK22+1YcCxJCGnY6nWiaBU5Z6vIPoKK8zA6fcSOalPtSgaVlYbAmt2y/
	 v8YPzYDMTxpfDbnUIb1LmJVKoMxuxY0rEJCsjrwfIluUL2aJK40Gqt9+1Q1TVKJXBK
	 pVxhBymJYtbtQ==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Liviu Nicoara <lnicoara@thinkoid.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jonathan Marek <jonathan@marek.ca>, Johan Hovold <johan@kernel.org>, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260929115755.6096-1-lnicoara@thinkoid.org>
References: <20260929115755.6096-1-lnicoara@thinkoid.org>
Subject: Re: [PATCH v2] ASoC: codecs: lpass-wsa-macro: rewrite the
 interpolator volume after enabling clocks
Message-Id: <179068739600.115027.7662196606588120659.b4-ty@b4>
Date: Tue, 29 Sep 2026 14:09:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1187; i=broonie@kernel.org;
 h=from:subject:message-id; bh=70w3EKLMILMaFBQJ/Oy5PxHafQ/QfQ3X8Sz2BQG8k/M=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqu8LSim74HhE1l86wgNgF13FStS6QCP1+V3BTm
 tIaPGBNC4WJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarvC0gAKCRAk1otyXVSH
 0GulB/9G+u74tWE68vXEWpEGaI3aypMLks42rOy5BaXiCz59OW8g4PCXtSpAprjykQUPGV/mUaB
 wvgG+jIZi52q4s2eYjBkAYymrOoPF9uOmKBFWDEMyMPJV3QQ6Z/s2NJ7ADnyBTJco86Zu0XP7Z3
 Mzk7vnwbLOAIT3VOCjiSS8WDQ6vGzKsPYM+2lvW7get+x126sp9nwG9eEP89QQTTpqnU2nrtGl8
 ueyX2c9KlzsidlTl8udrvD2fy3O1i19U857v4QoFKjxxO8wbnsiKGLDaO1rtSPq1G8ft6CQRQiD
 lAgWv78uec4zROLovQRPGYcPN1mcanqIJhwUBUWthtYn8xjM
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 29 Sep 2026 07:57:55 -0400, Liviu Nicoara wrote:
> ASoC: codecs: lpass-wsa-macro: rewrite the interpolator volume after enabling clocks

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: codecs: lpass-wsa-macro: rewrite the interpolator volume after enabling clocks
      https://git.kernel.org/broonie/sound/c/b2047b8cadad

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

