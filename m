Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725420;
	b=oHsjVBzE697wmRHlmqmVOJZO6fB8GtT5QQrUPAMKBkxQ1oiOW17NgpxxY+Awebin1hyp
	 y/LZu5OSVIgxgQlHsJeI+w47oww8Rxxl7r9P2Cd+M3uLFqaboY4O9AigBoNTrNpYlyUaP
	 caFzssQc++Aho7pyV72kEuLzmxlJLEAiFBeZKOeobdmtZ807VwuBAvPV6re0N+P/vIMK5
	 QTFPFsnLTHrA0WAVaKFOehbM2kIUGe4/A9HQ00mDm2vMaHd41NxPyoa/XUV7686DAYp8B
	 N8YRWGyGQIbe2ujyrrkGmAEps2iMUA8qwHKVwxsGtii4v7F8JLCAJtkw5At7qT0b19w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725420;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=Z0HCYOLsSGr5UkBh+IhznoAbi6k1ZjyzG78Iy+nQLrs=;
	b=SpLmsXH3BmQf95+UMxSYzCsEThyTKrW83nKqrNNTgflFosr2BYKsyRVqsls03OEUk1mc
	 CFYYgrg8cpwntJCzV2klon+3gqWnOOeKmMcZ2jZme/4pqrhxw+cQvwTlHdqOIZN6flK+L
	 OAKGiP9NwkJHS0gl7d2jnYuapHvOHXkAZ1IJU/LSWw5NnjJtg+XBAvkWYNKJKCL9WJhUN
	 Gn8iewO76p6pMVZwTsuE1VaBTd3ZHJw7mRBPkXyfUOqOSYKqFo/J9hQgI+Oab6nc6mM/t
	 cWEjt6Sd4FJ7ZsmxxFlcHp7q5rVHNqOLcqN7IhvwHLtVSG6HAWY2xX95CaASKyT7sVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6chWzjo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A177A606D827;
	Tue,  3 Nov 2026 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6chWzjo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56ACB1F00A18;
	Tue,  3 Nov 2026 17:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793725420;
	bh=Z0HCYOLsSGr5UkBh+IhznoAbi6k1ZjyzG78Iy+nQLrs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=g6chWzjoabqhu62aUfoiBWaD16eUnrSN2c1B3AAtE9pYrTymLTrOOd74dyrvabgqK
	 zSsWUpSZ47G1qPXBm+D0tA+ATBaFgMM8I9SK6efpI28YcGOynKyCKbFfCdV8AyCr+n
	 V2tyo7U40rxeK1W07C/K0ywwReKzXI0e4ueHhIgxI04Qe1I3Hsy8lS6Ke/XkuX3uhk
	 KoGzYeeaxjMOEYqBfXins0hhLpNfvv+A1n6vAfZuBTPjuMHBn41alPrxhBk78mwgxo
	 uZkXawat/Knme28FTRQh6QbVC+l4Bzseks7SchlLJiJMhlPRRuYeHn2w027/dMVUi4
	 WMzo3CngNzDyA==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 485DB255729B;
	Tue, 03 Nov 2026 17:03:38 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Tristan Madani <tristmd@gmail.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jorge Eduardo Candelaria <jorge.candelaria@ti.com>, 
 Margarita Olaya Cabrera <magi.olaya@ti.com>, 
 Misael Lopez Cruz <misael.lopez@ti.com>, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, tristan@talencesecurity.com
In-Reply-To: <20261102165340.1558853-1-tristmd@gmail.com>
References: <20261102165340.1558853-1-tristmd@gmail.com>
Subject: Re: [PATCH v6 0/4] ASoC: cancel pending delayed works on codec
 removal
Message-Id: <179366159252.2186205.9607100672021463096.b4-ty@b4>
Date: Mon, 02 Nov 2026 23:19:52 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1777; i=broonie@kernel.org;
 h=from:subject:message-id; bh=fUCAoE4UzcTLsSTNshH6xWqRfcKzXtKH9tBdUScr77w=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJeCb+a/tFQUeS+LQPzHdMXn/q87YKfK8fcvbWGQW82x
 7zmYyc7O0pZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCRV5MZGfZv7f/SN5k9OnNZ
 x9zJTFW81sfLzCr3fyj0iGV4a+py7i8jw8GSnndl++5a3Pj3uIzj2JpTLdoGJf8Or1Xx7I7aMp/
 nADcA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 02 Nov 2026 16:53:36 +0000, Tristan Madani wrote:
> ASoC: cancel pending delayed works on codec removal
> 
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> Several ASoC codec drivers schedule delayed works for jack detection
> and microphone polling but do not cancel them on component removal,
> leaving handlers that can run against freed memory.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.5

Thanks!

[1/4] ASoC: rt5668: cancel delayed works on component removal
      https://git.kernel.org/broonie/sound/c/965bad6195d0
[2/4] ASoC: rt5659: cancel jack_detect_work on component removal
      https://git.kernel.org/broonie/sound/c/ca3efbaa8aeb
[3/4] ASoC: twl6040: cancel headset jack work on component removal
      https://git.kernel.org/broonie/sound/c/0f367f70e185
[4/4] ASoC: wm8994: drain delayed works on remove and probe error
      https://git.kernel.org/broonie/sound/c/905d79dffa3e

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

