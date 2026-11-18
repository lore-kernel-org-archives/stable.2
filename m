Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795096373;
	b=hsxsvtt6qZMURilJqRYGECGIYrCeihx5OCdW+kK8sUYNzVqG4y5KpRuSZ0tW+7VxW2CK
	 8kpn9upU+Hj8/KT/kXY83h+jW1yRMvJJCryiJgI99XnTW5y7k5b5rDNG9UVfUR8Pl02Dy
	 vr4yBGmGQWe/onuYhHr6fpceyGM3xvbTpBR/ZIBktHkDwvmkokzsxj/MZlNbXdkuw9NpN
	 O/Q+7Tg4zTss389FYTcp/TQj4Az8hCoVcfY9i+EVfpvYNcKYEegoJt7el5+Z5hl3y/9Tr
	 Xi4CpzuE/Qzgh8L5FAX96fLbalUVxDVWnfHismEMHBjOEqQaBriyAeaw2pizEAL5pqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795096373;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=iVEAi20QpgjOSeBb62ZkLReHu6tTZmFOujbGABRTIK4=;
	b=I2FXYjpjiDgkcbzY5WqVe7rhHHxcFYtdKBMydld9Opkxy8kDFU/ufAc5PrPlIeixLvaw
	 u60Pzvggpl71nbs+Pe03/IxGScakwwembIQaSaP/WLc8PalzxOJwr6XDPvAwLOqoc9hau
	 Q/AArbLWbkZAmEZSUfL8J7cJIGTQL4GVGVgKebcRszP8SjXj94UV/Q54kAkd0i7YFg6B0
	 Deu1dFjGpJVMe0OuRmf89uNOnXzjgj7n/a7NADReAh8QBcUPK/HgZ/0nyZpkuMAZN8BvK
	 Qp2fdxXZwnnUI92vCfL2ssaw2sW1z4n6qUt23yMxVFHJ0Xn6UnSpOmF618CqMzetT6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZrNO49f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F16B606A320;
	Thu, 19 Nov 2026 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mZrNO49f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C710C1F000C6;
	Thu, 19 Nov 2026 13:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795096373;
	bh=iVEAi20QpgjOSeBb62ZkLReHu6tTZmFOujbGABRTIK4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=mZrNO49fR4OQ2Ny+MeA6R1TdNfSu4HqhabtY36ukicz5Z6YOsUaQuQ1teMOLNxDKg
	 V7jZfVgLLNogzRh3kJn1wV8BMJudtbkmqu9FcXNQgu7is3sH2t9icbPIRKW1hQ+tbY
	 FhJDOt01viDrHMRdedgroQqyW6ydAWtfl0wOaVK6y6oO7zRuVV92bvaf1OWwJ37JKt
	 PstBCmRjOfhUIkPSzORbpeAX63xi5ZtFvQFpVneDgC5j+OJ8sJQ6Ex5Ywe3DQDxCPt
	 u0RjVfqzoGj1h1mYr5/5bVxWQvYzd+c0sj/hpM46Z2ixevAPt6KGEe4jrphl9u35tz
	 dtJKYKfqECKWA==
From: Mark Brown <broonie@kernel.org>
To: linux-sound@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, 
 Ilya Muhamadeev <nicourced@altlinux.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261110145835.106381-1-nicourced@altlinux.org>
References: <20261110145835.106381-1-nicourced@altlinux.org>
Subject: Re: [PATCH] ASoC: es8316: Allow more time for headset mic bias to
 settle
Message-Id: <179502564293.810609.7700109656797734273.b4-ty@b4>
Date: Wed, 18 Nov 2026 18:14:02 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fGNjJisRHc5rvyMUiwoyLaXS21Ne2TrC0c+2ulq3XGI=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLL+/Te6znzvRxTfLtdyh8l54vd65uZfiTkjGtpsosEbu
 2hqcvKrjlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAExkTSEjw7SfQhn5336wmsxJ
 3bJn6qSlC+uXflv2Tf8Jh/L07ofKG10Z/mm8M3G6fevIf91Tlwp8v57h/h6T4S/98KmU6Z3HG6W
 8MtgA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Tue, 10 Nov 2026 17:58:35 +0300, Ilya Muhamadeev wrote:
> ASoC: es8316: Allow more time for headset mic bias to settle

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: es8316: Allow more time for headset mic bias to settle
      https://git.kernel.org/broonie/sound/c/232ad4512a83

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

