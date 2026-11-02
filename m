Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706996;
	b=fkiov60AePa0aMTqZ9GRCEuaEDUAnui/OKu0WmfdPbtpyOxm/p/wotTd8R9MzxG591k8
	 DORHv5ytjduhUZeM78hnN+eg5vZhu6lkNRNWklu4pe5VSyGF+OnyoVDKPEaFgwVNPC/zM
	 Eii9qSC8/FmncVcQcP1Q1xXZiJUyPuQ1E67bSXpRRoraiVKWawuPh0u0L46vua/3PrOEX
	 cc/tzu7zfcz9ABqbvCLqzRCan6yXmX08hdC7cNuXQEW0VySeFaDh5/bh3gJJaD9ILBBz2
	 gjH3LKpcSYN24J5WhLoD4CV+/7x70vfRMTbJNiaBr7cVuSDYHDgC7KqEq1n0PTUCFUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706996;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=jIxAGmi/bgc1YwjeYYPC92LW6SDaXY3wvvNSqHMVOzo=;
	b=5kbYsFvEQTxgnFdsJkMj77OLlNBJ8DkhZNlP4gqD/0F51lj7GmmbZIGHjWk2Jl2FBfeo
	 s60E5noW9CGcWsVu1fp36ZPFJiAyXZTkBuJ9DI7xS8vIDv4jAqxbDuMbf+IEEg3wapB5c
	 3Pub/haUI1koY2z4A++SOybL0UEvBEpbehWbeM0L5clBYVYuyFMV/zmuqhfQn0bjz7YHL
	 eAHohytyLkGC6nMUyzvGCUhT2dEs83MRLqqZppDqGCc4Bglj+B6SaNpfPLkIX8YMeYs2n
	 pFAmcP8I2XikI/bJkvF+32jMXhQdE2O2CRNYo01CWE35n70p2+KP9zbj6Ax5f6UeWlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=beiGC7cT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0218606A326;
	Tue,  3 Nov 2026 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=beiGC7cT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 259C11F000C1;
	Tue,  3 Nov 2026 11:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793706996;
	bh=jIxAGmi/bgc1YwjeYYPC92LW6SDaXY3wvvNSqHMVOzo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=beiGC7cTr4lU3Q7w6zlSeY0xJntwgWJsFPmvv061El7XYesdH4hNmWlXfgEBuaxR1
	 /3wy1vmHwS1+qakvR4rUETDJ6HlORLHb+V5yC+hrPAsQ8+do9pGo9kNLHSKgXsreP9
	 Es8OPmwoSlMXLGyXLwXjyR3YTz8lMdltfWBDdbgYsaUsPDH6caoxk6QMC061jKjohd
	 nYpUUOZsnvxNKqBqmPfAfZ/ivQC/XKPn7R/IKjgeCrHsHReigB+OsRPCQiVdDYdI4y
	 ejm8gMOF10K1g+GP5kbqkq77GCZtTju5UHIuQdVbZ4A/Ij7c7PUt6Tfc7U7t37K3Bw
	 A8DlBZfKO0QMg==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 59166253B042;
	Tue, 03 Nov 2026 11:56:34 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Sunny Luo <sunny.luo@amlogic.com>, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, Myeonghun Pak <mhun512@gmail.com>
Cc: Li Youhong <liyouhong@kylinos.cn>, linux-spi@vger.kernel.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
In-Reply-To: <20260913043745.35022-1-mhun512@gmail.com>
References: <20260913043745.35022-1-mhun512@gmail.com>
Subject: Re: [PATCH] spi: amlogic-spisg: Balance runtime PM and clock
 cleanup
Message-Id: <179366146354.2186205.11571999677156537831.b4-ty@b4>
Date: Mon, 02 Nov 2026 23:17:43 +0000
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

On Sun, 13 Sep 2026 00:37:45 -0400, Myeonghun Pak wrote:
> spi: amlogic-spisg: Balance runtime PM and clock cleanup

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-7.5

Thanks!

[1/1] spi: amlogic-spisg: Balance runtime PM and clock cleanup
      https://git.kernel.org/broonie/spi/c/67e3d31893ab

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

