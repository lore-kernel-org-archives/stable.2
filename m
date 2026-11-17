Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794932078;
	b=uCBQSR4baZL1tUm+Ye83qNR9rdbwJXqZybVp9hIVpiF8IafWdKvax2QJybT6LkI3TfNh
	 CLJPTch7UOKq18yMAzdVvxngJnx3XbuXWrdoegAQpTxUd//XqRiXIFeklS/CxQLK1q8s/
	 JT2s1fix4yRMOK48jEKAg3NkMqH9YQR65z305ky54SN+BK6kDqQ5M+Hi743d1k2mo+sR6
	 KoKgDHjvVb5CELTY2r9R4PERFq85Cyl0mU4OPOxwP8nv1MtpLSGynAH35SZBu5NgawWKq
	 Bx2r2Rhqx03yTuJV3r0GuqRD9lof5fjX/FBpehFCiqgxulOoxKu+b9Q9s8s6eKAqH3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794932078;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=MR1xRYnj436fLp3aLgKX27ILFiGpovdg1sC0kRmzkQI=;
	b=hIPOOh32SuIY6SEMKpX/U9SrN+kfHpZDBqmq2Aaz4wKarE2gf6QUhbLw6mMQdtF/KCGk
	 Zgr6mFewcTB0/b94TzbIqqfOP5YFiB9+BXYCDea+PpLxnNoq176za+ypYTy/NRIMyRDcT
	 oJvxkZikyg8poXgx3JU0i4Qq39w0lIUzOWfwPmWrn7F/dyM9PpyDONa8M46hWKUooe0um
	 CZXfIY3L1XZg5bDwrhLUqO+UwS4z+RpSntsCC6+vamyumu0yHstPmpt/mzXc2AnJNyS4p
	 5n+fMBkHvWEpNkcHMwjxJOktLaBV9cx1OiyPRL2v09hyzYViou7o5VxwIDiQelii8MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cmXdPsoM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0268606A31C;
	Tue, 17 Nov 2026 16:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cmXdPsoM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27FA1F000C5;
	Tue, 17 Nov 2026 16:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794932078;
	bh=MR1xRYnj436fLp3aLgKX27ILFiGpovdg1sC0kRmzkQI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=cmXdPsoMbsw9UNICW1NDgSR0etn2+menqMAWnT2/DPxH1t82SIcS3YKhQVne5aUd6
	 +ZsxbSByf4u1g4b+rDCY1SJg0rsudPsxQF467Pm/T5VGc68caaAlLeGJdSaiGBbKVE
	 CFA9B09B0zx+JWHd00CXJPB0x/rVZ/L1hHA2xDxte4QLAuH/FwWTc0y3hRUids7JZz
	 6voI1zd/6rdF9wjqhxGYtXjjk5HqnatnPt1MEMllN2JImFRiTGK5ZN+7w7ofkYDMuE
	 7wT6zGRelR4IYfi7wyw9pHFQyJ/mL9XsA9tpIMOjjdVacvPBzMZaEtIvNmCtGsRQBB
	 /E4VTQUwVGL9Q==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, "Nicholas E. Andrade" <sdnick484@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261109-for-next-v1-1-54a06f391bda@gmail.com>
References: <20261109-for-next-v1-1-54a06f391bda@gmail.com>
Subject: Re: [PATCH] ASoC: amd: acp: fix PDM ring buffer address on ACP7.x
 resume
Message-Id: <179492850122.77896.9729881633236440429.b4-ty@b4>
Date: Tue, 17 Nov 2026 15:15:01 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145; i=broonie@kernel.org;
 h=from:subject:message-id; bh=XLdVceKGMkefgP7qnEm3Yg0rwyp54kMlJBBcemDLiUE=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLL+1GYVXpM72vtRdPmmFwEPRFofTj+r9uaL87dg3+MM+
 z31GiIiO0pZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCRB5EM/yzumRSvPjQ18Vi6
 yInjTpMXurR2La2quMBidf9HUF3RAnOG/zE7yxo62A0X/Pld0pJ9V62XIbfxQeeF38+2HL7Z4Wq
 wjAEA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 09 Nov 2026 10:22:35 -0800, Nicholas E. Andrade wrote:
> ASoC: amd: acp: fix PDM ring buffer address on ACP7.x resume

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: amd: acp: fix PDM ring buffer address on ACP7.x resume
      https://git.kernel.org/broonie/sound/c/a3d8527ed469

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

