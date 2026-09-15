Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A6A3BA225;
	Tue, 15 Sep 2026 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789495577; cv=none; b=SKk5vm5bFIH2BEPIu9lL4EpuBk9FglTM8bLMPFK7nvrXdbcZTkBgAZPgrYaF3/C5JP5dE0w7l3No0feG33md8Bp9uNYImg8nxaT4uVXCA6XMVV/1fpmTvcKrgPzQWxIdinTtIYav7yqbSR7FxWkCJy4KYrcSM3y/7CTwFD7FZfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789495577; c=relaxed/simple;
	bh=zIPvObjpAoqO7Ie+Fc4fhffMiCRixWDLqIsQyi/pW+A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=rcPIRyu9hG1I1mWQgZf9ai5f2Il2CVPCwbKKxgyepWW4R+8WnynI1RXJyberKe+hRsfH/vw7pjVlekDS7tWM0hM+JwSdjPp6hzc8b7ps8saiYBMUdaCj5rW10utlakVPBlbzWne7tr7+95t3+4tLAXpHrd4mCcFfchIsl3C7uak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDTpyCON; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDTpyCON"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD291F000FF;
	Tue, 15 Sep 2026 18:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789495576;
	bh=b3RSP11LW1inOXy1WYQFlzUnLYr8htlLznsfLEYzeiQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=nDTpyCONeriaxyogVPcE+fi439LvkMACcZLdHjV92nmwSUKsKUFr85t7G4c5YV4bg
	 lbgjRTBC0RC/D0cmfX2yEBRRD+yxxtqBF6WQuwLexjiTTnipCLnsWBCP/jUSXxGiuA
	 mRwIrP6QCSzSq7GyDZVKLMJ308UUtpU8pyUP5wj/vrMD8uorwplb6WZRdcZY+6srBn
	 qWcXso2Cn6cHYpoN9J3Bq3lvKx1De41IRt5TvBb18W0QnSvfwDCvmKDtKAmYu6CvWc
	 Vj4xxmR3gbVWQws8hTzAivyLjVQMAIZ5HvFtxe8GzWljYfDISLoIQFXQxcOPZfvGbL
	 BzcHRLu/1gOug==
From: Mark Brown <broonie@kernel.org>
To: Haixu Cui <quic_haixcui@quicinc.com>, 
 Hao-Qun Huang <alvinhuang0603@gmail.com>
Cc: virtualization@lists.linux.dev, linux-spi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260913032049.11209.alvinhuang0603@gmail.com>
References: <20260913032049.11209.alvinhuang0603@gmail.com>
Subject: Re: [PATCH] spi: virtio: Use the per-transfer bits per word
Message-Id: <178949033618.151760.3989188928636801395.b4-ty@b4>
Date: Tue, 15 Sep 2026 17:38:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1109; i=broonie@kernel.org;
 h=from:subject:message-id; bh=zIPvObjpAoqO7Ie+Fc4fhffMiCRixWDLqIsQyi/pW+A=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhqyVnSIzDeeG/+MNDo7Y2q5SkS1aMGWDl1mLIKPx9HVz+
 6W0sjk6GY1YGBi5GGTFFFnWPstYlR4usXX+o/mvYAaxMoFMYeDiFICJtM9m/56561JHiMeiJBnN
 FR9ZGF4pxFZ3aK6df2CjwQ6zZ+k7pk0XmaOYEVv+cfkOoXzhvkk6Z0JfP3gbc33f1Pu7tO1bdZn
 O+XJrrzgjLbBnwVrHmf/Pyzt+ubJPTOmrfNJlPTvWlW9/RjnzcrTnPIpXSnj55G14fdnjqk8x3U
 WXr07rDGSUiyjxKI5amr4rZn/rvmln+VRM1mv/6jCU0dnA/CKp43SJ0wXuf0GbJW4pVrXM7J50Q
 7MrxChsTc2fD4YWId1FN2waMi8++3oukiVpzjbfD94vL0s/lg3/PfdL2bQ6eVFu3oO2MV+KlP9o
 quq8qq+RzeyeGefD57KI6XJb+qy9T7Qt9dUDjY2s8jwB
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sun, 13 Sep 2026 03:20:49 +0800, Hao-Qun Huang wrote:
> spi: virtio: Use the per-transfer bits per word

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.3

Thanks!

[1/1] spi: virtio: Use the per-transfer bits per word
      https://git.kernel.org/broonie/spi/c/095858324f06

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

