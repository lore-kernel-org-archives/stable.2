Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333263;
	b=OW7jvT2eICNKg18EYg+gSaNM15eCcdTRz3Wjh26sT9nslqSgIDQBR9y5uLt6AbA4aRpP
	 R7fomvh4tEPPQ73Nonq695pd0nRrlXsZoJYJOHSlKKkc0wP8Li3y1c8tt0A0SniXav6qm
	 fX2/9UI2Dy9MTw89IUexNqsa8ddhezRWSf1DZoPWPQ3W5yhmNxfcMqEOL0tkCLl2zExSs
	 7v2byjdLLIRR67/aAjiMbIzg0694Yvz0hEnhxrtoyJJtp7YGnos+Rk0CXK0/CXrvTurJY
	 Wod43cFSCqLVqLnjt9QRJlVzwnhcu60cBoByRN8YM3+s/qrFE/aq4XetDbseCfxammg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333263;
	h=Received:DKIM-Signature:Received:From:To:Cc:In-Reply-To:References:
	 Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=oUTVKVZBrwxGxt0Mr4xJN3r31IUaa+CBW4hgSfVG54A=;
	b=XAkFu8papU1pH4Arl4UvAceJeyT5Xka2vCXALMAj+NpNDTZzJ6qEzN0njjbX71492iZa
	 SAmRPCQ7FBD4otx9CZBxeVhgkKLlbzG5ZIn1qU5LSlA9NBCVoQW4L/Gus5KzzU3FEttpV
	 eTSYiAfobEs9HCwH+W4HXktpvQYIVdkycYx8FYHd5PJyJJsGhogLO9JQh1JrSL4gftEru
	 6NyWpZPUe6rge/n9PZJePh3Y/yldqFgFJ6LAo20ArMZBxEfeLABsshXl+Z8emEn0YIQ6o
	 TeeYcgyKZZ8v1ItGgyj9qbPntBN3qM6xheo84sVObauzH6ml3qUwFx/goMvY/VfOW+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fKhTajo8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC5060A2603;
	Tue, 10 Nov 2026 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fKhTajo8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4651F008A1;
	Tue, 10 Nov 2026 17:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333262;
	bh=oUTVKVZBrwxGxt0Mr4xJN3r31IUaa+CBW4hgSfVG54A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=fKhTajo8WXUqGCLW8q4TmupMrrdSW99JyEHi5u2/zChi/465iqqbFnpLrWa0rSl73
	 5Qm+Fv9IGLr2TdbWCkQDYJ0+jkl26SuEc0LPVQT5+1ySzfDuE2lARnkP1wsrs/+7jB
	 4HN4s7lioiW+OCTyiHXVXfcohfYZ8ZvFdjPx2HLw0ij2PuQpGxyL8sfCEpwEtwrk2C
	 v/YSZmzDabdICh4GNUIJfOLtjGchhXhzf/Ax7dVcstkMmZnc2NqmUp9wMmcLx6p6Ej
	 oxtKYLm18aSTMBLadUOciVDxP9rrpN96BsA/CJXTAqCy6X0CfCqGe2KsyeQnZgDMBF
	 tFaPhrDXcenRA==
Received: from traversing.sirena.org.uk (localhost [IPv6:::1])
	by traversing.sirena.org.uk (Postfix) with ESMTP id 553D831676A1;
	Tue, 10 Nov 2026 17:54:20 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: andriy.shevchenko@linux.intel.com, Liam Girdwood <lgirdwood@gmail.com>, 
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Daniel Baluta <daniel.baluta@nxp.com>, 
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, 
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, 
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Baoli Zhang <baoli.zhang@linux.intel.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20261109005604.1004362-1-baoli.zhang@linux.intel.com>
References: <20261109005604.1004362-1-baoli.zhang@linux.intel.com>
Subject: Re: [PATCH v2] ASoC: SOF: ipc4-topology: Fix pin format leak in
 process widget setup
Message-Id: <179431595505.125181.14472070728673514959.b4-ty@b4>
Date: Tue, 10 Nov 2026 13:05:55 +0000
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1155; i=broonie@kernel.org;
 h=from:subject:message-id; bh=achqlWaFsdegsGaImWfH+pTbm+LYUgzJoODLhHgcboM=;
 b=owGbwMvMwCWm/754w+YLFp2Mp9WSGLI+R/n8l972z9vr3iy+EM4PZ11ba/eezXh/KPBpIk+yn
 VkG33S2jlIWBjEuBlkxRZa4LO6X9SWv1/AdXNgGM4eVCWQIAxenAEzkWC7DH55PAhlHA6vvBK6q
 fZjUFsgXfqzb7/bn3ReesR94bj3nQBsjwyft4rne/s2frPSrrTJKizN0Yv+WiSw0CNve9qhmxnQ
 DHgA=
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

On Mon, 09 Nov 2026 08:56:04 +0800, Baoli Zhang wrote:
> ASoC: SOF: ipc4-topology: Fix pin format leak in process widget setup

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-7.4

Thanks!

[1/1] ASoC: SOF: ipc4-topology: Fix pin format leak in process widget setup
      https://git.kernel.org/broonie/sound/c/e5c09fe3f9c8

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

