Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792775741;
	b=DCxyi/ybPVzGwLIZPRQUI8PAGYA84IgUvtpRzBbHjBMaMB/YL6JCqtpARkriuN6UEp8N
	 K1X9lhGuz0A008DCysD+F4T8+ul2pHsSo+/myZc2qrvADorQCBOB8N2NK9kr8M2pNHVmT
	 0wUw1v5NGtAU3dupBNYqOhY6h86JP1Gmzg4bliTkULrnUW9n22KqMQM+5qQgXwJXzvaUa
	 RSULDS8UySqmp2rDIeOWAWVDnu03ZhvfHjnijOrwXWheAAqRKR0gEvbzwXfdbKqvKUdTk
	 RFZxUevpA42K6ni2mgH0W2/MsM5DjdcPwetScAl/yrpQcB8oViOiLHf40DV/IiyPZXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792775741;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=5YUyQLMFLCsOs2gRBJ/+NUMSAUZ8mKc9+MNne4j9vVU=;
	b=4AzSIvcAAjZYL9Vc4TOeKTXkn6ramh9iKIq4+aca4A/isyAWtLBGYuwhkyLU6UIgrRAz
	 bdVQ1Wh8o3f97vr46+O0YtasRhwOnyia0ALkXbVBPksCKUTHSSZAmemueNSAw5lCRNgz2
	 psTBMRf9iWvIBNYIC1+2WHRA3jcx1+kkTWLau4ZrlCV0DeCp+h7s2EAWvd8L3hzzWwnhf
	 CBSZDyrCbFvtphobuMdZA8JxrgwKDDrntd6PxIPPXD6zz7A7QFAHHOEUJgyxE1OGdMmlp
	 NdH64eoB6o+lfmdBcMVGDdixxQVpo71TObwuS6qzvdOcaDzl0OK59VmTWCvJDuXXAsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RAlRuumO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC34606A32E;
	Fri, 23 Oct 2026 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RAlRuumO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFD01F01828;
	Fri, 23 Oct 2026 17:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792775740;
	bh=5YUyQLMFLCsOs2gRBJ/+NUMSAUZ8mKc9+MNne4j9vVU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=RAlRuumOm+jIGjIgN8CDBYIAhVL27DWhVeBqhJMjhivZ28sOxge/bn0bKUVbMctHk
	 4EOXtsYF/YWm3h6rLYkpiwp4yKMtIHU3t9g2/th6iXGcP5iGm6zfLjnZOZz20n7cRy
	 WcPaT+S0uzeK8RPVKlEbp5EKHJH40nF8is/6VtmiIAbnTObdQOrb/1v9PeBaSq+A3q
	 Podjx+lRzfRCRpc/3UbVMBFcSupCIjNmWQSheIWn4Z7TErUVYqQYHLTPUCKy2ywTiS
	 xa69rZ/HJEIhR/+2vAG2NGgYVx2gOk+ci5hBObT2FFh/CIQ1K98dTfmk8acP3i3n6A
	 ZHE9yGC9gq5Uw==
From: Mark Brown <broonie@kernel.org>
To: Shenghao Ding <shenghao-ding@ti.com>, 
 Alex Kazinsky <a.kazinsky@ideco.ru>
Cc: Kevin Lu <kevin-lu@ti.com>, Baojun Xu <baojun.xu@ti.com>, 
 Sen Wang <sen@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Annaliese McDermond <nh6z@nh6z.net>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org, 
 stable@vger.kernel.org
In-Reply-To: <20261023130854.93639-1-a.kazinsky@ideco.ru>
References: <20261023130854.93639-1-a.kazinsky@ideco.ru>
Subject: Re: [PATCH] ASoC: tlv320aic32x4: Prevent division by zero in
 divider callbacks
Message-Id: <179276909501.3909521.9367284342268416964.b4-ty@b4>
Date: Fri, 23 Oct 2026 16:24:55 +0100
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1151; i=broonie@kernel.org;
 h=from:subject:message-id; bh=UWT6ICkHTVKOTKI4Mjl7nK3hg5vroc0yiCHRHQSCNHA=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLJuT9P5eMhB9FZrkdK1Hqu8uz/q575lO8XnWsjcdGChx
 ZrmI68PdpSyMIhxMciKKbLEZXG/rC95vYbv4MI2mDmsTCBDGLg4BWAiSpmMDPMWKp9mPHX8yIJU
 5WrJnICfcZfqPVpSNWY+6mCd/6B92laGfxpJNZzyFfHnJ15etm3j041MCnuF5urFPAyenVF5tzJ
 NggUA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Fri, 23 Oct 2026 17:08:52 +0400, Alex Kazinsky wrote:
> ASoC: tlv320aic32x4: Prevent division by zero in divider callbacks

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: tlv320aic32x4: Prevent division by zero in divider callbacks
      https://git.kernel.org/broonie/sound/c/8cf9607d2d85

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

