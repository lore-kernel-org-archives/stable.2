Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B461E486E77;
	Fri, 25 Sep 2026 10:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790331285; cv=none; b=u6tRC6jZFdd2HLk5lh2qN8MCpSEK2VNhgD1rM5jyXfYxLNxhNuMR5hsb08FhAy6myT3h+xwyYFC+tSOYkoMcOycFOMSue4aPYQNq1uF5E8wrPU8dPNQcWZXFhZMo7t7/A4d6lUKirHmMv2zZ7YPGuQxz72/B9Mn0gnWxbB2eqWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790331285; c=relaxed/simple;
	bh=JQIxVB0oqnuP4+oBYrvJljmHTa0VHtI7ECOeuhqcOlI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=VOt6Lmb0o8Pc0ipIxpLgayTiodvRAHqNxniAOleOGY1owjnNoPVT0JWPB/CxDFdUK4vCWROumNTzTeKobht7XTc3ZaYV6T9GkncGZ1IJTnPqERFUwboxZuswUYn1ZpthjUHcbgZJDXNtsomO88tpamne58/3smCfA3inYs5hJFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEdufjTQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEdufjTQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2622C1F000FF;
	Fri, 25 Sep 2026 10:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790331284;
	bh=h81p+/WUiM444rAiso3jElDzbwxcpynpDQ3rEUmKhuk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=TEdufjTQGEal8HR9dKMtXe4esTljyAJVi6Bl4KFriDhqy6a0DjEgHvph1BIpmJNY1
	 f9slBBjBNMUYkH2fpSI96Eq7aD5vsPFdVLHGJmOrtngTMnPvVEPEUTfsFUhkPApV+N
	 nvTxAW/bU7p0/y0m9JxmxZMdX00YB2tCrOMqH5Z0bsf3azabAP9S9rUBMTzn8T5U+t
	 2NFIVvWgXFwETWbqokEmQQaiCc/+y92Y+fOXAzjE/GEjRIpj3VvE9/XOMHfA2onHaI
	 6fYsn/J5ZncB9zqVdwsb6vajXhXYf69i8p9zBjQNlB43FNaibOAzeBhh+Op3GzB/8F
	 UkFX7P13yte/w==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Oder Chiou <oder_chiou@realtek.com>, Junjie Cao <junjie.cao@intel.com>
Cc: Shuming Fan <shumingf@realtek.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260920024232.710189-1-junjie.cao@intel.com>
References: <20260920024232.710189-1-junjie.cao@intel.com>
Subject: Re: [PATCH] ASoC: rt712-sdca-dmic: fix drvdata type in the gain
 controls
Message-Id: <179027670381.149798.4298821407869809389.b4-ty@b4>
Date: Thu, 24 Sep 2026 20:05:03 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136; i=broonie@kernel.org;
 h=from:subject:message-id; bh=JQIxVB0oqnuP4+oBYrvJljmHTa0VHtI7ECOeuhqcOlI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqtkmO0w+psGH7KQRmVVDWq6mnSqyQUMCXVfUXH
 vJdKcYf5miJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCarZJjgAKCRAk1otyXVSH
 0N9VB/9BdF9Mh6f/f2c+nMQ66cDFnVJ8TbYAdm5/8kZkWlyLYDIcuC8+SZRIY4g+nXTtiVO810W
 dzNCb2MYcorqlKIqAcOXhHyF5WAs7xvOU5t872Wh4w2wLGh1mLRlZHOyLATtXX52tHJn/qewrLt
 yd95+1dQDm/MZibl7pBC9vx6zgkVYE1iizPZ6tQVeJgjHFcVyfyoYHHvlR2CWgjy6iniZ+yFoR8
 5c+KfNg0ooqxnlJirUEq2gqTcVcBCo/fPESJtKd6nHH8pu8N2AkfSdo+VVs/hrfoSWHyJ0GijeD
 Z4aF1W8lyo5govfaGGhP5S7nonDUKR6/zEX6DORZv4TD3bKW
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 20 Sep 2026 10:42:32 +0800, Junjie Cao wrote:
> ASoC: rt712-sdca-dmic: fix drvdata type in the gain controls

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: rt712-sdca-dmic: fix drvdata type in the gain controls
      https://git.kernel.org/broonie/sound/c/0bc42544a4a0

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

