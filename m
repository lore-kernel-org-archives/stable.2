Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6AC42378F;
	Fri, 16 Oct 2026 08:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792138470; cv=none; b=kR/MRbqH9a2CKQhLAE4uus7deTmvGMB6qTwWXt5lX+I2vdRLprc/dMkw/nYj0HiOz1QnfcwxbfrrKTu/V5A30amYmATJmlzqQTqqxzDhmY+G94q//BdbFrs98iOPGDaTvdDpeFOu4CkUMkOJthmZNSSmbuwlxI0HZbduHzuf3MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792138470; c=relaxed/simple;
	bh=TIwHNW4PKjIUENLKJlEq6MQ/g15eZ57FFIrXUXpNPNY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IgYgoGg+3+wDk8uhHnOUWtTHjJGS8MHHg853HsKH1h2kDPF5fkBewNhqjpg8wrPbsM2/2ZSIrf1UKUZgH5mXMqPFremm8kDW/SgiQH98rwmLaI1j8OeaYb6VFLwzQmo5Jd4v0BEWft/v/jvLdcFVhYEh953AhEhUnqIuZqX/4ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2ENNNE9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2ENNNE9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B700FC2BCF4;
	Fri, 16 Oct 2026 08:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792138469;
	bh=TIwHNW4PKjIUENLKJlEq6MQ/g15eZ57FFIrXUXpNPNY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=a2ENNNE9zHptB0vZm6GiiH8pBP4NFrnCeacgqhgWFfZPYeyCjew3310uBW17aPoG9
	 xPrv/hg3w4G4pZjAsb8TYIEX0kbqDcKmh24t8Crdxp9w2wDsZUv6oY00PFlHCB/oo+
	 PEUrUNFswfEfX7YHZr3kAdvLZ02ZEeX2nq6Ko3J74vGeFBrbUANahNPdcq3XM6Myvi
	 1mQnO3vR2pcjJ6+YAmtkSVK14kydPrgJ7CfuFkynS5TfGxybYQjQihhhbItbDRtfIU
	 TW6KX96CUQ+ecI37eXfdybC+gTOMwcJqNG4Dsfl2kcHmtMOmczfSnPZpocBxLGmf+I
	 hbz82jMoONHPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922C7CCA464;
	Fri, 16 Oct 2026 08:14:29 +0000 (UTC)
From: HuskerMinion via B4 Relay <devnull+mocker-mug-unwoven.duck.com@kernel.org>
Subject: [PATCH 0/2] ASoC: mediatek: mt8183: Two AFE fixes
Date: Fri, 16 Oct 2026 02:14:00 -0600
Message-Id: <20261016-mt8183-afe-fixes-v1-0-f0db51e0c073@duck.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMjc0WoC/yXM0QqCQBCF4VeRuW5gR7fQXiW60PVsjaDFjkUg+
 +5udflx+M9GhqQwOlcbJbzV9LEUyKGicO+XG1jHYqpdfRInR57XVtqG+wiO+oFx54HOS2ji6Kh
 kz4TfUKrL9W97DRPC+v2hnHfmLnv1dAAAAA==
X-Change-ID: 20261015-mt8183-afe-fixes-94ee941c3fd0
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, HuskerMinion <mocker-mug-unwoven@duck.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792138468; l=1641;
 i=mocker-mug-unwoven@duck.com; s=20261016; h=from:subject:message-id;
 bh=TIwHNW4PKjIUENLKJlEq6MQ/g15eZ57FFIrXUXpNPNY=;
 b=0srufWCkTX4PIs/durVAuh0yWhA93Eqq1o4UAZfY1ZVUtyTvHkL7wVZY/k4qH8l0xfn9SYVb9
 NpxhO4RuS75DMgdhPCeNsf7obXTWW2LoPgWcmwSro8JxE2AezOxRG+u
X-Developer-Key: i=mocker-mug-unwoven@duck.com; a=ed25519;
 pk=Q7l9BnP4XnFimCK28K+NVowcECqTaJNXicdBAInot0k=
X-Endpoint-Received: by B4 Relay for mocker-mug-unwoven@duck.com/20261016
 with auth_id=1206
X-Original-From: HuskerMinion <mocker-mug-unwoven@duck.com>
Reply-To: mocker-mug-unwoven@duck.com

These two fixes came up while bringing up mainline Linux on the Amazon
Echo Show 8 (2nd gen), an MT8183 board.

Patch 1 is the important one. On this board the AFE never ran. Runtime
resume enabled the audiosys clock gates while the regmap was still
cache-only, so the gate writes were dropped. With the fix, playback and
capture work on the device.

Patch 2 fixes a wrong register in the UL1_CH2 mixer. I found it while
adding capture routes for the device's microphones. The Echo Show does
not use I2S0, so that path is compile tested only.

I do not know why MT8183 Chromebooks do not seem to hit this. I have no
Chromebook to test on. My guess is that something else keeps the gates
open there, but I have not confirmed it.

Patch 1 was tested on the device with a 6.18 based kernel. Both were
then rebased onto for-next and build tested there.

Runtime suspend has the mirror problem. It goes cache-only before
mt8183_afe_disable_clock(), so those gate writes are dropped as well
and the gates stay open after the first use. I left that alone because
I have not tested a change there. I can send a patch if you want it
handled the same way.

---
HuskerMinion (2):
      ASoC: mediatek: mt8183: Leave cache-only mode before enabling clocks
      ASoC: mediatek: mt8183: Fix UL1_CH2 I2S0_CH2 routing register

 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)
---
base-commit: 764db7a068919c9e3d4618731dd854df43070399
change-id: 20261015-mt8183-afe-fixes-94ee941c3fd0

Best regards,
--  
HuskerMinion <mocker-mug-unwoven@duck.com>


