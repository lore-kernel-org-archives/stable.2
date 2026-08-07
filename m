Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F7423D7F4;
	Sat,  8 Aug 2026 12:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786193373; cv=none; b=Pfx8gEeNRrw4oQpddqc9ghuMQUugtnYVq7PpAagEVzErGQG+qvGOrMMsUN9wn+ZnbPCZh9INZmpiEUHYfE0u6hQbBr5zEORxuqZObn6AzxO59U5mcZL8+YUfBYGpvn+34Vf0TIVZx6fVYib6kFYkKi8ya99wEyV4f32ZNGMhjyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786193373; c=relaxed/simple;
	bh=z/05ltFweUpfJy5/kzHBfj9G9Hd54kRZPyQ954z5xkc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M5CCoUH9+tc04BJ7AmGiTi+vSf9YvK3AM95IzMpuufKW2X4je9v++u3vwC+HtWu7NYfjvX+2wCN/PRwPlFUCxe2/bUWJYd+WmXQs1lYQ3HBhlQkFJ2fLi7q1fBLnx1nGfwsISkl/YyronWiTFAlxdOPbLRxXn/HemDLZRVEMYUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aE+RKUUK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aE+RKUUK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C385F1F00A3D;
	Sat,  8 Aug 2026 12:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786193361;
	bh=Ylfe+ScvPwL9rryrkNZcg56d8u7e9g3Ai/SvGyrbmYM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=aE+RKUUKKGkEIfgFNfYKd3yRC3x9DD/ySp0htwSEHjzuc111QB0zsfLXNEtGnWZOw
	 FfZ9cgOYh8IO1rAmYG2He0jNvZ00Gq6vzYwJnf2lUIm90K9UqW97uTbNn5xrVFb9lk
	 8KOX7nG2oXMUJgRSWoeks1GwcY2lT/FvFkB0wsY1aF3cofUa37HkYgpkIDiRWM6Rl/
	 Qt+97wb3m/g75g7Lzg+Q9T1vE7MctFKgD9pnaD893mE11TeUZ0mF5VgjEBCF4NUJj2
	 Kk1sEuQ/NQwoewYtAbczlDozE1lNSeKFLAQ0hV00bRed4mEOR7LrpreE4RPGJed91k
	 oosHILmEpwfIA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260805122728.12362-1-peter.ujfalusi@linux.intel.com>
References: <20260805122728.12362-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH 0/2] ASoC: NXP/Freescale: sort the reg_defaults tables
Message-Id: <178611444677.279158.6874752821645565602.b4-ty@b4>
Date: Fri, 07 Aug 2026 15:54:06 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev

On Wed, 05 Aug 2026 15:27:26 +0300, Peter Ujfalusi wrote:
> ASoC: NXP/Freescale: sort the reg_defaults tables
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

[1/2] ASoC: sgtl5000: sort the register default table
      https://git.kernel.org/broonie/sound/c/437fbdeb6069
[2/2] ASoC: fsl_easrc: sort the register default table
      https://git.kernel.org/broonie/sound/c/84c5d79aebe6

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

