Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794871959;
	b=u44A+kDB8isTXq+AfqMCbOdWzgjw/gBwMDEl5PnIC7pusVyNtxPMwUU4Svqbh1UreD06
	 vU5sM5Rdq7raLlVQq9n50JJr63L+5limZ2Qw2qVM0MKvyk528rTG95P2nOZQ938SqwXb4
	 JwEMH4wN56015RewxwwoAAv6DCRV8bf1fMJzGzAr+RlLzcXU5O2cC5yTjKSxJ/cdK3552
	 unVcDpdMC4badtko2+62bykjeS2xSiz2BBAWtg8fE4lKulRoUpIUvrvIazoilWZoklqiT
	 7uSJ/LVd/JdJDtNUWI8hrBkuYV3cl9kg6nzbfjYUZTWpAr25eaX5mPUJi1W5xPXs6dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794871959;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=CjJOa9pxfBY67skITJoff1qKTIBeFQGtw0SmjfMNZrk=;
	b=GKzUQqAs4dR3bSBWH26ss5QtFs784wlIHF/zTdyDZK5aK/7FKR/BPwtxq3X+0u0NtlQE
	 wsO8/h36yHclk2Kfdlp00MkduvA2KHCKXAKqe0mkS89Ccpp4NTNDEoQsPMF3fzQFxcNLK
	 5KBE3ukjBrYPgahusbIFBnEquQFoq/zmlRr7PJadWwcTTEPW62GjNmQksomB6P5QOJAgj
	 U8BuLW8+5HAWSpDlWeQiE1KV+FnvmJZQ89VAyMij/e9tWwzsateovcAvihQIaEWAt6nVN
	 YztbKych0ptUVdhBBc1blqVrweB5HObNu8eoi699lfCcJJCN45H90z+1aNO2Hn6t8dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BHB7Bvjz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA0C606A329;
	Mon, 16 Nov 2026 23:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BHB7Bvjz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CC81F000C4;
	Mon, 16 Nov 2026 23:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794871958;
	bh=CjJOa9pxfBY67skITJoff1qKTIBeFQGtw0SmjfMNZrk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=BHB7BvjzOKYUP/DoGXz9RByoziXYqSVsKF4NI4CcKfB3ihRfPj/UqkeeQkQ+oMcwS
	 XtzXpncGGDknMVX5IrFtSo9C5d2luz7SVlK2NTYg8a9QhQxW7l+NjMYOLVDP4WuKuy
	 zHnUX7CntjyORQ3SpOqsuDSJq9JDWABgg+/uBZsa8krp6wuddiwptVcySiw3qwAH1c
	 i1SS5KqiCV22Yve2sx5QaSapn3BSu2zoJBw9KjwfeCjM+D933+ir7UpYwMw/lb4s0V
	 Ga/BV8jgk9WyQuT3YmioHN9OjSqJQ0Zg9hDnvrr+8kzGuAJ7WTICYkAftK6+P/gW29
	 a95AHCWUaNobA==
From: Mark Brown <broonie@kernel.org>
To: Oder Chiou <oder_chiou@realtek.com>, Tristan Madani <tristmd@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Bard Liao <bardliao@realtek.com>, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, tristan@talencesecurity.com
In-Reply-To: <20261107172637.2729867-1-tristmd@gmail.com>
References: <20261107172637.2729867-1-tristmd@gmail.com>
Subject: Re: [PATCH v3] ASoC: rt5668: fix teardown order and stale state
 across card rebind
Message-Id: <179486212736.2504946.14896239104739207727.b4-ty@b4>
Date: Mon, 16 Nov 2026 20:48:47 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1154; i=broonie@kernel.org;
 h=from:subject:message-id; bh=7UaAgydiEe4+VfqLZWblxZ5JDhwAroXxu5zblQmnhzI=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJ+T5qcl3nshl3sr+5vxfdf8Oz+F5N8kOdA3763CRd61
 zP1H2uW6ChhYRDjYpAVU2SJy+J+WV/yeg3fwYVtMHNYmUCGMHBxCsBE/B4x/LjnJMLCt+44P8e3
 lrr5PXybYgsYFVU1nPyCZBVcg3TrGP67W0fuMF544fr/1SrC9Y7elw60zJ84cY1FoOqeWUlyy+o
 4AA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Sat, 07 Nov 2026 17:26:37 +0000, Tristan Madani wrote:
> ASoC: rt5668: fix teardown order and stale state across card rebind

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/1] ASoC: rt5668: fix teardown order and stale state across card rebind
      https://git.kernel.org/broonie/sound/c/49e6f7bc51e4

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

