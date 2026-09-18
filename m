Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B49752BE29;
	Fri, 18 Sep 2026 21:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789765465; cv=none; b=uEc1xbR/lNcg6OM+0xiqWuOiZG+TkRHt19OIqagNA+JZ7CRNUVczYGjDTc3oAShrVfGvKtoKfj2CWL+YG4le3L3APdzmcafien12HpeqawtB+A5/4bwm9Q0aHN+CZma305u3Fjx4BDeVQgu7OHljAGMi+3yUQwOcHp33rFvq8ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789765465; c=relaxed/simple;
	bh=5AJlRz9VmMd0OmWTXop9FJL4TPvwVoWnT9Jf+6NkEaA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q82bFR30zBJa/YEMu8x4YEs6BKCScKraPf4RPoVgqHLq8PZbe8qhs1V0qSAq3s98tXTq28ygNXFUyOVwTICu522mHtbTyTIBQd9Z7DJvBK2FqKuPgwtbjzVBIlS1uICpe1hoX7B8t6IPT+nOYDc5V6BmdhV3AAGsLNMZAo8KNRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2UINi1L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2UINi1L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4328A1F00899;
	Fri, 18 Sep 2026 21:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789765464;
	bh=ApD+IxRfwZUnT2P7M+n95fYPEL8KAIfr7X/2oYpfSuQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=W2UINi1LQ06TsZlVrYZ91Z8a5wH67ZqHsW7XguLmauRTQvn7Smjnb0w7SZ3WIz1lD
	 dU7AuzpxxuY/SadZnYDKZnbPMiF0zacU47uPSvB05Heof2rK6qdV253sHpYGhv1naS
	 OSLzK7WLLE1sY6XyneC7d1dVTE27f/R7J8HzfMCYDZVt9iLAMOhnE4KiBDQidYTTPY
	 TJxTcjJ8abSCyRmn4+rhbCwWMZg9KjxVbo9Mw1m3+ccxzC/l3w4WBTNY/oHRk281Ex
	 Wz2ie2A2olaE3b6PjPmToLRpeJev/JQiO8xMQgkpg7/AUUfcc5dukZUt7deavaWzRn
	 SzRTOz3m4LC2w==
From: Mark Brown <broonie@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, perex@perex.cz, 
 tiwai@suse.com, stable@vger.kernel.org
In-Reply-To: <20260917165851.2163548-1-vulab@iscas.ac.cn>
References: <20260917165851.2163548-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] ASoC: audio-graph-card2: Fix use-after-free in
 audio_graph2_link_c2c()
Message-Id: <178975107344.1812520.14001092387774117021.b4-ty@b4>
Date: Fri, 18 Sep 2026 18:04:33 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1158; i=broonie@kernel.org;
 h=from:subject:message-id; bh=5AJlRz9VmMd0OmWTXop9FJL4TPvwVoWnT9Jf+6NkEaA=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhqy1y4MDDCI+ZfnraG78y7xqrfPDOKHatKtPpm69/jLB4
 aQsqxFPJ6MxCwMjF4OsmCLL2mcZq9LDJbbOfzT/FcwgViaQKQxcnAIwkVVP2P9X7l9WqqKu69F1
 5JbDzKaA5Z3fP/rznv/0KflsqtLxiCkWraK8NWVhb7uOcqm2uvFPCfmzaM6JKTXcHi4WUTETX/0
 8GcMqUfmW/S1bgdhswycXpDuC6jxFZI+5BL2bst035u2c9FciZprnjGQ2he/eqq1QouWu2aFj9p
 flYfbjjMvT2pi8bHY0PPTW5J7TmbRI8OjycIWtGcdMOXwipvM/yXF88XLNIhf2Y52qyQluX2NT/
 GdGs38SizWV/RV5gfGhBcPyEGWGn5P/v9x11LO4oLFrR++EtGWSy2r/us+o0LV2z2qdJKR+5Lni
 KlGh/e5rjj7heNq2p6s3q3+LmdIPdQP+5p0J/FwcTJp6AA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Thu, 17 Sep 2026 16:58:51 +0000, Wentao Liang wrote:
> ASoC: audio-graph-card2: Fix use-after-free in audio_graph2_link_c2c()

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: audio-graph-card2: Fix use-after-free in audio_graph2_link_c2c()
      https://git.kernel.org/broonie/sound/c/5ea495bccfd7

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

