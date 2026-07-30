Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964B14766A8;
	Thu, 30 Jul 2026 23:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785453679; cv=none; b=aomg3zObKQ16frQf/2AyzBalo6GKISxGeQeHf6Dejq25ivl48zcCKBRbdCPEv3G6YnRVkJRgGqgIMhMk90/vIawwWG0rHSs5C+StWFlr20Loo5fnIi6s2L4vIDX16d205Ul0AGvJerDJiJKB10UKtA+YQ/kPu6szjU6uaVwSHEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785453679; c=relaxed/simple;
	bh=UWv9aO6Ltl53+gNrcXHmibVEU6RwbY8BZ0HA+GF9Ro8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=C5bmiHriWIpADIcXudtKn7ATeCA38PLhKhwZ3WSRJkrecdSfudhXbdz/8kBKt8TgAC1UE/RofBdBoE7Q3GoJ2KASx/xivLjl0N1lQCOl1GhwQQaNKwi7y3mhNw/lrB2xS5UszZARqAa5RXeU1/EbQtbSTFJyc6T4flSLhWjaPR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ro4EwhtM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ro4EwhtM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07E61F000E9;
	Thu, 30 Jul 2026 23:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785453678;
	bh=nnkYsDKBh6+z8y/O7CyvuiMiHf8n9xKBJ8Nn5YjUWSY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=Ro4EwhtMUp0QMg6o42tZeo9WHfPJNwKSRfAub7cSv6oCE9khjUcgRpSG40k6eCbVe
	 7Ho6gfit2owh1GOSFIHYbpOo5FrxCMihdrNjTJwzwpS3FOxNTxQTu05J1pqKg+/eDh
	 SV7FBnru40RgG2769Xj4T5QNY5zEvj+1IaG+3zLhr8WA3Cwm1FC7dMcieiQJvD+wHd
	 YoAFlAGC+c5c+O1b1wAr22nyjl+E9oeleYzT+1j0bloUdBKjR4s14vxZzZZ8TzECt9
	 H47SAcRI69neIgdLFuLXlSwJMtmnj/LrLD52CxblMVvlFEusVGXs2Gs52FhPjP2FeE
	 TZ42mm5XJ4uJA==
From: Mark Brown <broonie@kernel.org>
To: lgirdwood@gmail.com, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: linux-sound@vger.kernel.org, kai.vehmanen@linux.intel.com, 
 yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev, 
 liam.r.girdwood@intel.com, stable@vger.kernel.org
In-Reply-To: <20260730054822.5913-1-peter.ujfalusi@linux.intel.com>
References: <20260730054822.5913-1-peter.ujfalusi@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: ipc4-topology: Refresh copier IPC payload
 before widget setup
Message-Id: <178543892863.343356.875041647435692561.b4-ty@b4>
Date: Thu, 30 Jul 2026 20:15:28 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev

On Thu, 30 Jul 2026 08:48:22 +0300, Peter Ujfalusi wrote:
> ASoC: SOF: ipc4-topology: Refresh copier IPC payload before widget setup

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.2

Thanks!

[1/1] ASoC: SOF: ipc4-topology: Refresh copier IPC payload before widget setup
      https://git.kernel.org/broonie/sound/c/0c0e418dbcf0

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

