Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0658952B1F8;
	Fri, 18 Sep 2026 21:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789765412; cv=none; b=UHz5HpfRLRuCwTjtcohF0zsv/I8SAZ920nUY0+LfsrUgJVgaTNh+mOvCJFh8O3ch/DUIICD0F7Auq9h0R2/7P/S2dceuplTTqXG5FK+eS8DV4gzN3oLlgqEeuxkpApZUTD5nUz1rOU49qmN4rsj0YriuIXC4n0x57bGqKb0Poh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789765412; c=relaxed/simple;
	bh=V5XAPZna1/qHgXZ6xvcIZwJueIBR1QxLkynxC2XCh5s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z9TlGfVesGKxWm5xBsFFGimG3SM+m8NJPAByu6Yh1WI6wzZE5ffwgjVV80svX9re/NDa012Cpbk5p745yLPcqYM/j72cfhSGCv9poDsbvyjxeGAiTSHRMm+e8U7r4cxmQgeK50up7eLVKvjuVUAfaioeVaI6Ip/QLdubaMLJZGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9fH/xRZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T9fH/xRZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF5D1F000FF;
	Fri, 18 Sep 2026 21:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789765410;
	bh=mA9dC3GYx2Bl8KyibMZr6jJl09qLF6emQ4NCK0WRzvA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=T9fH/xRZVyyQ8imxrWf1kjJI/b2XmAEDnQorCZ06wVV9zLD4mXy15Z+D4+jucjeN6
	 +P077rHiqEuhKA889/C/vz7H19FecYUVmqqF3WV4reC3hXzIB1rRl6/ZJZ4QLk+z3l
	 AH3EiIfrCcxbeWdU5Uv/++Jbls+YSa7ptvOXe2y20jbiSFTggIHIad9wY6XWIczZH+
	 ac34lzLiQ5QjstlFqzE5TxTHVELHmaBbvNAA8Iz7q9Q7xcK6A+XCBfPs3YV6NC/FPT
	 3TladJJUgPsPwiB8XEeQGjaLLC+W515xsLO4pZQ2UaovRUt7gQl9n0K8BG31Po1FtR
	 Xy+d6kvf6VXiQ==
From: Mark Brown <broonie@kernel.org>
To: oder_chiou@realtek.com, lgirdwood@gmail.com, perex@perex.cz, 
 tiwai@suse.com, Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: derek.fang@realtek.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 13667453960@163.com, stable@vger.kernel.org
In-Reply-To: <20260914104551.377880-1-yijiangshan@kylinos.cn>
References: <20260914104551.377880-1-yijiangshan@kylinos.cn>
Subject: Re: [PATCH] ASoC: codecs: rt1017-sdca-sdw: fix uninitialized
 stream_config->type
Message-Id: <178975471204.1812520.2370627273452430638.b4-ty@b4>
Date: Fri, 18 Sep 2026 19:05:12 +0100
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
 h=from:subject:message-id; bh=V5XAPZna1/qHgXZ6xvcIZwJueIBR1QxLkynxC2XCh5s=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqracdczkDdsQqu914m6vbzRme6PHTbq0GuV4lB
 OVsNX1ZT9yJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaq2nHQAKCRAk1otyXVSH
 0KWMB/sEDG4MBwKZSrZEfw1QzdgvL408qxuBdTv9OPtc5TRGmrvWDnpFor/HeVGr+J4TZis3pVe
 3wyDbIPbDQP6btc4kAyfkAQGvQ0tDBuYPiCKVEXq0JSP64Q00M1PY8xLsLHYY4lhXMXS8W2bz9g
 gm/opsqBONbyIhvyx68i7kZXA5VI3Pjwpg0CCWJFoD4Q7346DIBOSIfsRHPetF3LnMt7wQJf5IZ
 GOjdX2lr0iHkfiOYiuyuWfElEenG8ekb68Jo0npu+zqD4t9mCwFeiMfVLaOyziyXGO1Ae24Nk6B
 ApzhzKLYP7y5QIcINbr85IGL0YUUrnJt95xZpupuedwuRamH
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 14 Sep 2026 18:45:51 +0800, Jiangshan Yi wrote:
> ASoC: codecs: rt1017-sdca-sdw: fix uninitialized stream_config->type

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: codecs: rt1017-sdca-sdw: fix uninitialized stream_config->type
      https://git.kernel.org/broonie/sound/c/174d16088419

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

