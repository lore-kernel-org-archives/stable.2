Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7AE23A99F;
	Tue, 30 Jun 2026 11:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782818261; cv=none; b=MifYUjlTHO1BdhNxQ1DxxLGQTjkEeE4OFh+LMqDyMpCmnutKQxQtcjbxLmAbv/tIomy7O628//kNylmB9WI/DfDPCn9fKwoVAUfW5Zo+OJAAVnw43NGktfEb3EVxlfk3pzXVfRHPw5S3j9VmqdwFjl37btIm07XrjH2RWpSSiMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782818261; c=relaxed/simple;
	bh=+pzVlDLY1JAWqC87iVkSYzzMIyWnp7ilg0qVsvTgGYo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=HxrzwqA5eMqgyLnU1GtMxutkFw2nNLwxfjDbLLUMwHhiI/ZPMHpdI0Sb8ocErhi6fQ2NP800gFUONII/tnfjmAA4/DPg0ds5lLPdQo1APVqLY35Uv2h7x2zHF9PzCaWZdV+9PkXCgqTX3xJru2mX0Ofr1ZChzOjICjT+KSxmdWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCJ+wqT3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCJ+wqT3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181871F000E9;
	Tue, 30 Jun 2026 11:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782818260;
	bh=eWErjEHMXrBAqZq3Vq7mxcKe/AWtpJ3hBdzLT4L4FaM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YCJ+wqT3GlL0vlsc2XBaRSnsNz/cNj4xnc4DbIn7dI1oBWDOLDQJfptWJgRqpptt8
	 /5HoWFgJpaUcZPWB3B9IFbQIForqb6XoZkBPjBBsfdd+UyxSc55HnLL5RCgxpEfk9o
	 O/OfTGUMFkKBLvNaJF9so7sHYzBljZ6S4x6JtEFpTlUBdRY+Ow9BwvYoBc04Ujl5eP
	 dTGbxqMtep2zxQ81cABG5KWSehuSNdNsu4vrY+4IOB40C/Z8yxUcma7s9mQd0yG/0N
	 YF4xrbNQWu4EljaaL/mGAsSvf6W8Lr649eN2bbwIW1Im5711UV+hcGWQgDAuS378Yy
	 iGrD2CPH/ncGQ==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com, 
 emillbrandt@dekaresearch.com, Haoxiang Li <haoxiang_li2024@163.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260622094822.926166-1-haoxiang_li2024@163.com>
References: <20260622094822.926166-1-haoxiang_li2024@163.com>
Subject: Re: [PATCH] ASoC: fsl: mpc5200-i2s: Free DMA resources on probe
 failure
Message-Id: <178275534193.47562.5080617272977636428.b4-ty@b4>
Date: Mon, 29 Jun 2026 18:49:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1135; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+pzVlDLY1JAWqC87iVkSYzzMIyWnp7ilg0qVsvTgGYo=;
 b=owGbwMvMwMWocq27KDak/QLjabUkhiznpZc+NX6T22xu5c8YtyTwvMZXlfi7xxt+aNpL1PK02
 ISERzF2MhqzMDByMciKKbKsfZaxKj1cYuv8R/NfwQxiZQKZwsDFKQAT8Z3F/pv9Lo+/eo5yvmSN
 s+nlU48dlonG8OZsfvP8p4t9i3rFpcN6Ymd+u+54khKy9eI67cokkaDTCywWXg3vLvjSxTopOOu
 xxQGt3B+xvS13bT818u54ebpIOP/hjq6413xHXk6//VJGLpv5sVkyj8H3AI75Uw94TmS958Slv2
 hhypq2/123Sz80VKcucrOT2yeYrnBbvKPd0tQvX1TD8+s9ifZZ89S//pMzCnQLOsvPf+HB61THp
 nbntMmHt5vLK/l9/XRSKZKPM4kt3SKrJeCo8jSp91Ls7402cAnzF5rNvPJps0bdlxTTh97Las+9
 Znvmd8PhgsxM279GU1a9j/SKl9OZMFmWYUl59SeHHQdLAA==
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 22 Jun 2026 17:48:22 +0800, Haoxiang Li wrote:
> ASoC: fsl: mpc5200-i2s: Free DMA resources on probe failure

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/1] ASoC: fsl: mpc5200-i2s: Free DMA resources on probe failure
      https://git.kernel.org/broonie/sound/c/3a89ddcf0c3d

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

