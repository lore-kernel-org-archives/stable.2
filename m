Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3417D12B94;
	Wed,  5 Aug 2026 21:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785966225; cv=none; b=tOcCylVknZ3vkFuVQO/7gnYxBEKse8xJEX+VysKZ+HEybNWoPfNAUTRpc1LeQiSCUtm1R66ypn+nLpB7wRCeut3Aylg5c0/LGt990E63KBSjtcrg/s4FBUvVXITtz2XobStn6gqtaB6Cok9kZIQqNXTW67RkfU3GhDOjgYC6Jvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785966225; c=relaxed/simple;
	bh=8RHbAmv6KRpmCG+t6ywRPdDYHla/g7QvFbRePRfjcu4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AqktX7vQPRfxH3G0m/RPyjvDCIVcn+TRoN8My+W3FdsmzNnJAAJjR6+8C2YTfyk1DWO0wcoFw9bDAZ+Sp0V8/n8HoBgfUOZgQZy/3rYp0woGwj3WYpQgy2Dj3KTIPiz2dXYB4ClOkLKy3YcWEvWN4qXie/zt3lx6ZhM21ZZW4h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtG8QosS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtG8QosS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61DDC1F000E9;
	Wed,  5 Aug 2026 21:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785966223;
	bh=zAe38Q5XdGCCXXc3FNB8yIO9yBYGhs3n3bWbvpfLc84=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=LtG8QosSP+djHHDFCX9ScHQ1sNvfHyEGbeOMnrdFYOigp3YPV+hchYYtIAI6OzU6J
	 mfm/p6WzxPEx6UlyNOouX1hg80LDX6RCULi9IiMvqjt70RVlIJJ5xbtVK+NZD1H8di
	 khduHimyLasGbT0fXzvRueUH9/rTNIz5P+4w91kZ1z2JH8TgrDoZMVLKlNtrr6JpfU
	 eqfjYfr6XbLSv6nvvAI7hOKDJr0OYpxEgp/ecED/c+KK34Rp+4q/60paSgu2EAKIvO
	 T6/2hIcugRN1UkQ5M3QbemqN4gADu1yBg5U8aDmVa6ru+uciN67170wO/XtxK+9WqF
	 AndBF8awEn7pQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 David Rhodes <david.rhodes@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, 
 Vlad Karpovich <vkarpovi@opensource.cirrus.com>, 
 Paul Handrigan <Paul.Handrigan@cirrus.com>, patches@opensource.cirrus.com, 
 linux-sound@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260805082413.26174-1-peter.ujfalusi@linux.intel.com>
References: <20260805082413.26174-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH 0/3] ASoC: cs35l41/cs35l45/cs4265: sort the
 reg_defaults tables
Message-Id: <178593344382.199927.10716148204313114159.b4-ty@b4>
Date: Wed, 05 Aug 2026 13:37:23 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1590; i=broonie@kernel.org;
 h=from:subject:message-id; bh=8RHbAmv6KRpmCG+t6ywRPdDYHla/g7QvFbRePRfjcu4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBqc66HTi8P8Qr8Uj5/34H2qnom5wOayqdm2JgVg
 h6FXQHNAoSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCanOuhwAKCRAk1otyXVSH
 0Gv/B/4jvCZvYTJob5mLW5Bz1trrT5+4Kk/425fX/PH/mNxL5XHr8I4FvunCAIeN08iVDjnYdRn
 nLG7FGp4eaFNjYZ50XXetCn4S7hC4zRjRaFkDcFkVBetGaU1YlRPycMmTagTpetYcpBgMDIx16r
 5vhuJfyFQDTuuUzZi152D3ZILZWfS3LPv9+TnL6x5VdapCOOF2FZVE3npNp8cIsXSZEkqMFZD2h
 6U5OWQUFax+L2BbP2UVH5T/ttCIfEL57imUFUaD+Az3es8xkE3reinT2mAgvwL8wUnF+GB/SRpw
 4Yz3u5cyZFXLN+Z2uHfggSxLNZJVxN2CyYQn1LjR/TUp5Tzx
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Wed, 05 Aug 2026 11:24:10 +0300, Peter Ujfalusi wrote:
> ASoC: cs35l41/cs35l45/cs4265: sort the reg_defaults tables
> 
> Hi,
> 
> reg_defaults must be sorted by ascending register address as
> regcache_lookup_reg() locates the entries in it with bsearch(), see commit
> fd80df352ba1 ("regcache: Add support for sorting defaults arrays").
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/3] ASoC: cs35l41: sort the register default table
      https://git.kernel.org/broonie/sound/c/d74aac116cfb
[2/3] ASoC: cs35l45: sort the register default table
      https://git.kernel.org/broonie/sound/c/f39a68ed08bb
[3/3] ASoC: cs4265: sort the register default table
      https://git.kernel.org/broonie/sound/c/e4fe3e046524

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

