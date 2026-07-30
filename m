Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF463CE0AE;
	Fri, 31 Jul 2026 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785498377; cv=none; b=GZE4Kqu8d0PA1N0QS74vMmu1/mp9iG/0HRoJYOG6kmmqYLx3b+h+GvDWRhML27N74j1mt0SVxSgC/vjwTIV8TszY0A2GQmtaQ/saLEJ2FbDLu8MmaLZSEujtT90+hRoHQK9AuiPa9DSEZwzOVE0Qc7XkJp3ujzGzkxhTFV1SH+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785498377; c=relaxed/simple;
	bh=5CVk8e8y9Dy+9uvbGMxumiV8mp6Am8zTynb+N+9fPEk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uI+dqH+6SYFvaf7+QQO2lsWI3fvZxjAjyHrih+29L1oOnqYckJ30k7IORL1XHHa3CHzQKfoiCqT9HwnZwpwGkMwU0c61dFLcWVWtUexLlz4JXKLEhp8wCdEDAw4llx7PxapL0Jv/sllGo8IDEBWruObxuzZA22s0aELV6pnlP7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVXDQ7qy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVXDQ7qy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C281F000E9;
	Fri, 31 Jul 2026 11:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785498376;
	bh=cYwkvveGzOvaHWVmOm2EmMojIcsTsK3ORSt0rxXVUQQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=AVXDQ7qy7KiqWA/vOmHZUmaUuvLeElo4IsBVBeuj/hYix9aVHv79YfYewn94THSD0
	 Ublt4s9fTtpGneofw7qsT9mI+3Q0TBUt8XSzhL6NGvRi+ctwGDNu5ZYFQA/jeYPPUh
	 /S4MICeuCVl/E+T4YTlMRJh3D+OMP9VzJRCzVHHw+cStiwiWClBrSKVlhDmQxsWG0n
	 dvF+2PTk1bDSzzYbzIlEuQk5uLiXO9itJ6xZZh1PajeiDbsUNIpFgbw4qI7KIw+6Sf
	 XJy7PF+pW8JtVaoSMXKlc3eU4Uka1jI0T9u6VFe6L/Yb3lIEXVWVmCaSB6mLUrYzJQ
	 CLaYpueYGT6aA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev, 
 stable@vger.kernel.org
In-Reply-To: <20260730071724.22296-1-peter.ujfalusi@linux.intel.com>
References: <20260730071724.22296-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: topology: Use acpi mach from the machine
 driver
Message-Id: <178545000052.556383.1793438238658443429.b4-ty@b4>
Date: Thu, 30 Jul 2026 23:20:00 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev

On Thu, 30 Jul 2026 10:17:24 +0300, Peter Ujfalusi wrote:
> ASoC: SOF: topology: Use acpi mach from the machine driver

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/1] ASoC: SOF: topology: Use acpi mach from the machine driver
      https://git.kernel.org/broonie/sound/c/ae63720dd7c3

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

