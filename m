Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CE84AB1A5;
	Fri, 16 Oct 2026 13:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792155754; cv=none; b=ra0JchyjPq+hziQtoGib+DqGTJ+c6Jie3QsvUigUKdFhSHZqe5dQuo3HqGFpOkN0UyeSN99ATpis4fvx8Jzj/6s4hJqhsizow8Zqub+qox9P1hKbYDMI1HhC3M1kZCn97i4UvurEBcVta+KrN95H0K0xN3R/hR/bLDhOkhuO57w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792155754; c=relaxed/simple;
	bh=GevFRnjD6Ig8EjAQZq4UzeVYLlO8Aaj0Vthsk6qSqPY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mStMMw1/+phSOi6K9UfrXFbq8i4JzrAI7Ma6Kw4gaxxiT+gHfFtBKBzuWiAIeHdzD3XdWHsrNaxZ6N79kNjaTkUzmnZJIruWLMTtOl5WrLTwW7qaRZSjpxNAxuWiFlAs10re/bh0MFwjxc45A5qsH/FjUVaSEsITLMjDPglAqdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aGuDfZL2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGuDfZL2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE0C1F000C4;
	Fri, 16 Oct 2026 13:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792155751;
	bh=oku8C3GKIf+osygZCNHgCGPKd9IX5fayQn6YjyGY5Tw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=aGuDfZL20H0i3U9anbqiNAVczx+7fDz93Tev1AOK2QmOnGqf4QFoFLmnNIbIBNSiX
	 b6v15zzNIXDXR21bynsfXdmdzLew0i+cZ6VHcbPKhuNXd5lpZ9+cec64VJHGXONcT5
	 uQ39RkwXEHgvdLxhhUFss8mW/9ZPOeW/kQMQe1j2+d2hLfFN+aFpuMCNt/7MQwmh2u
	 tCQjfgKATFkw6dtzwZ6RRoHd3HkDa+OGHPEJsEPmy9umafNVj3PGW5xMh9AsbyXmxf
	 uTHFz53KRSfZNkfNAS7mPrmMdbqSsenXyEsjCwOg90NmZ9Pg3NrGbQ89tB+rCpDJ0t
	 +HTWHjmXNSMVA==
From: Mark Brown <broonie@kernel.org>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Art O Cathain <art.home@gmail.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com, stable@vger.kernel.org
In-Reply-To: <20261016-dell-14s-acp-v1-1-89b40d95720c@gmail.com>
References: <20261016-dell-14s-acp-v1-1-89b40d95720c@gmail.com>
Subject: Re: [PATCH] ASoC: amd: acp-config: force SoundWire probe on Dell
 14S DS14265
Message-Id: <179215283207.2297680.15416457685370017821.b4-ty@b4>
Date: Fri, 16 Oct 2026 13:13:52 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1147; i=broonie@kernel.org;
 h=from:subject:message-id; bh=GevFRnjD6Ig8EjAQZq4UzeVYLlO8Aaj0Vthsk6qSqPY=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLIuKSQ/nnyv9EfWMkPpeUuEX6vNCJv4+qSWT6qM77aSh
 n+5dU6POkpZGMS4GGTFFFnisrhf1pe8XsN3cGEbzBxWJpAhDFycAjCR1rsM/8yF/bvPfO14vVNz
 dZLf9Htre5NYMg7y/l+09uRsrYeTRYsY/nucj9saZjRPV+oq19wb25WvMCgsrxT8tGipuYOt+LS
 WyywA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 16 Oct 2026 11:29:30 +0200, Art O Cathain wrote:
> ASoC: amd: acp-config: force SoundWire probe on Dell 14S DS14265

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: amd: acp-config: force SoundWire probe on Dell 14S DS14265
      https://git.kernel.org/broonie/sound/c/38cb2ef26b64

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

