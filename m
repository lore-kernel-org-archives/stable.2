Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096071;
	b=FEuM66kxpYvJRFGCVxWO07F1ttvjojdsYErM3dv5PrY/M7xIF1/+aNXb6ktQzQXAtCuJ
	 1VCaVAbQzR7enq+qLd3AxAAqizgXlYMhw9CI2eHZBhCe0l5GZYpbaF4FfXX8dSUsxnGyX
	 jDUMPbr/VlWJf0HQv7nDO7XTjMomFvTWvTBf/KEVGe2g8Mm4vtz+0HANntOuEV3GsOEqZ
	 YIApvHC6Wtkmb/tKtQBMdbww35uLsszefeu/U06EaQ6uHVIRlQHjtwsCp1heL0v832JvW
	 dIJOD7MDyeU6WRBoodrvahkKfYewBn9xPKD+yqFT7ey79t3uDouHmLzS7lkfGOeWKKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096071;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=pV2o9KSUGm6ks634juMQPCOu5KrGLDfQVoB76XP1OTU=;
	b=E9jbPw3SbZm0ElsdrrrqqAsfnExkDzzUCB7bhm5Z3Vk1/l5617cWbkKB7kM3lpN81uul
	 B9SZnM9ThF/7r0Ew3IzgAN2nbc3WWETOn+OZ4dTjYN931XNjsAfYmJl5yZM5SkTfEOSd7
	 YE+z6PGZvzT3FknDW6as6zlmsNc0ndopb08+ToLiFFMD/xY+7sMUSa3F3z+xs7x9tFUFw
	 UBT9C31HnQHDTTEtIo3bWpbQBRxJdp6WJ0Kav66bdBVvo02zmmVHI7SZwtR5ADEMIknpp
	 WhUKQnHfFsQ4JBuAyZ7rUxlDDgXG2S3ggw7NCo10vnDvvb+ivYJUQdKifTL+aMNqxqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Cg5xV/ri";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D2C60A2615;
	Thu, 19 Nov 2026 13:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cg5xV/ri
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCD6A1F00923;
	Thu, 19 Nov 2026 13:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795096070;
	bh=pV2o9KSUGm6ks634juMQPCOu5KrGLDfQVoB76XP1OTU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Cg5xV/rifGT+vBk0r0qOAOdrVDX2uKQGs3Pv6IR5iRTQM9oJeei47EKtr7cm5J8V8
	 2AJkfqR1I3xoaA5RZfHAW357zl+RWjSikRjbF0k2ZP68Gfj2LRJqnl86ldMSHenbhP
	 PVj+rPtVbKPz1Twh2PhwtWBq8CuS+oePo3BDY24mQ4LR8GbnjgPHdwfbC/sQli0md7
	 ALowlG9PfJYq7MXhPBvBnhbfqn9Vg+bSWyCRfQHG+HmS13wfy1tpckgHLqlaSfABbn
	 abknRDNeJa3XVCKkGCt7KeDO3uDPoc6ENQTtabvsjV998Vm6yxWamVJMtiFJdq5tgh
	 yl+vPgPA5o5tw==
From: Mark Brown <broonie@kernel.org>
To: Srinivas Kandagatla <srini@kernel.org>, yzddMr6 <yzddmr6@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261115-upstream-q6dsp-clk-drvdata-v1-1-4d7dbea52e52@gmail.com>
References: <20261115-upstream-q6dsp-clk-drvdata-v1-1-4d7dbea52e52@gmail.com>
Subject: Re: [PATCH] ASoC: qcom: q6dsp-lpass-clocks: Set driver data before
 registering clocks
Message-Id: <179500957901.349622.12400179007846918256.b4-ty@b4>
Date: Wed, 18 Nov 2026 13:46:19 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1159; i=broonie@kernel.org;
 h=from:subject:message-id; bh=pmK2pUw157FCEpTJkuQI8zV+eBL+T38cqNjovMfug9A=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLL+/WPiOe69QTn8a3v9mzuKmz6IVW+repMRvNLd2C9+Y
 uelvcvKOkpZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCROxMYGZbsXm3ZZPBgxUbf
 kwFLlvBof5HMiXwVyGF1QG2dzJ+pWv8Z/sexdXwOMLii8OrtogPrdv7aNnmPe8sM42yPwM8qN3b
 7G7ABAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 15 Nov 2026 21:12:57 +0800, yzddMr6 wrote:
> ASoC: qcom: q6dsp-lpass-clocks: Set driver data before registering clocks

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: qcom: q6dsp-lpass-clocks: Set driver data before registering clocks
      https://git.kernel.org/broonie/sound/c/bd6e011c8121

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

