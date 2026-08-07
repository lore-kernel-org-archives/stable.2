Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52872E7F3E;
	Sat,  8 Aug 2026 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786193370; cv=none; b=MzPdVU/uv6q9LiG61lnMsfcSfp5+Guf2eqlbT1tGLi1J0chwjEfMganCocT7/fE4k22Fp6+qjp0AEbul2IbOWSoyFofri6zNjFJBXvxn7TG2m9oVq/f/6crMThz76qWlmjWjTJ54PLl7PPcs0Fkiwqc7hOH3fHmQ82ykxyZiNHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786193370; c=relaxed/simple;
	bh=wW+964WrOZXMIYKyQCkoXUuuKIhO9GYFJy8q/qz9JLQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=AVeHtAgEE0yEcin6ckYvxgtD2CnRg9YNcjh2yi5DJEcAFC6mf3IIs49ENdaSSWWSROhrc5j8rhCvDjGWU2g8y31B3P3PkZe7HNLXFJStaoZ1qPy2QHdsKfx1Gv55Fatz0EQJ+iFFVQODTDsiApAf4BTTTP5PvETweIy2isNm9iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHutJrxb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHutJrxb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C4A1F00A3A;
	Sat,  8 Aug 2026 12:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786193357;
	bh=M5ZPoAEIUHwbjWWW2JLT0aI6rFuqGWleMIbJljKspOw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=MHutJrxbWvZPUAIYTnFOIvGopUHg1pFBDr88Wvdx3Yk+sDNXYQo6Qtideh2tCN5LB
	 /C/qOF80xVIy5CdmniRw8P4WI3pIpnlw7sWOA9Dp99xjJfz6y/whnUKT5a9fgpKPxX
	 3PgXCx2NdidwvpUQxg/aRTk8ks5KlpeM5b3H7kbGD6zMVcqv8lAWkQewGvOnclcwJl
	 HkdguCxfMhcRQskzUwbH7r73Hzqk5G2fbzImYZupTAEF98euQKEYKJtpYdiMkZA2QL
	 yxQS5z4K6ek4jHBJNbcewNpVEJObpndETV/AatQFmSNsEQbRSPvLy3Z6gqgi9J2znM
	 if1S2rZJr7QBg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260805122811.13713-1-peter.ujfalusi@linux.intel.com>
References: <20260805122811.13713-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH 0/4] ASoC: codec drivers: sort the reg_defaults tables
Message-Id: <178611478037.279158.4736277980772221276.b4-ty@b4>
Date: Fri, 07 Aug 2026 15:59:40 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev

On Wed, 05 Aug 2026 15:28:07 +0300, Peter Ujfalusi wrote:
> ASoC: codec drivers: sort the reg_defaults tables
> 
> reg_defaults must be sorted by ascending register address, since
> regcache_lookup_reg() locates entries in it with bsearch().  When a table is
> not sorted, bsearch() cannot find the entries which follow a descending step,
> so regcache_reg_needs_sync() falls back to reporting that a sync is needed for
> them.  Those registers are then written to the device on every regcache_sync()
> even when they were never touched.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.3

Thanks!

[1/4] ASoC: ml26124: sort the register default table
      https://git.kernel.org/broonie/sound/c/d4d0e6e2355a
[2/4] ASoC: cx2072x: sort the register default table
      https://git.kernel.org/broonie/sound/c/b927853f7007
[3/4] ASoC: max9860: sort the register default table
      https://git.kernel.org/broonie/sound/c/5c4cf173b7eb
[4/4] ASoC: sti-sas: sort the register default table
      https://git.kernel.org/broonie/sound/c/bbd73fb224ca

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

