Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501D24FDA64;
	Tue, 29 Sep 2026 09:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675978; cv=none; b=vD5w/wVsROifgHJcXs6+epXq4gefMKx1orydROe87+OLq0cKfzWvPbwIvsGWQ3NO1vqb8QiGud3jIHjV1c7CZu2DKtujwY7mDX9m5PQDtXP+otpkkrQ0d79I1gBHed4iwr3F33P4fUVmXsebUqWTcA1IuvFU38RrMk0fwzHPVbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675978; c=relaxed/simple;
	bh=hK0kh0Xiaud7iwNb/yv5bX9EAKvyQ6CeQ2L/JfAVaiA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ru124t314Cu0GXLwDoQKo9I4qT6kFx1RN9U3nQJg7GUntkF3jOV+bpNGr2blWFoVBqIxZb2qibJwZXOpLGPqlrGVB2L4pGn7pLdw0qzjtSw0dWiuuooLvuxMacpJV0p0AqLxDpftO7kjCkQj+axhV3MMzOg+dWTnNoMBd5yFHCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=gh54OO+G; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="gh54OO+G"
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f7d6b509;
	Tue, 29 Sep 2026 17:59:26 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shenghao Ding <shenghao-ding@ti.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: pcm6240: do not free an unrequested IRQ
Date: Tue, 29 Sep 2026 17:59:20 +0800
Message-Id: <20260929095920.2092147-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0ec9ad96903a1kunmfdd787152361bb
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSRhDVk8dSRoaTEseTBodSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=gh54OO+Gu2C9WS0GY0f01WRY7AiQpS1KJreX5K85XbYAoRrYzZpKgOcoKEu1x1gGOyoAaTeJEdQvMUu+UX0JP7qZuvurbxFYp1M9ihWDdJPhVmgfBvZvPOhdmfz5p74RmlFV+xk/EkJ/DUYa1sX1rDqQ5dF4H1BMlJQ6PghnOWM=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=5POcp1hOjf6IWyFD6hoC49B2jX+hDAjZ5Fek/E4YdS0=;
	h=date:mime-version:subject:message-id:from;

The driver obtains an IRQ number from device tree but never requests an
IRQ handler for the PCM6240 device.  Removing the device must not pass
that number to free_irq().

Leave IRQ ownership to a matching request path if one is added later.

Fixes: 1324eafd37aa ("ASoc: PCM6240: Create PCM6240 Family driver code")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 sound/soc/codecs/pcm6240.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/pcm6240.c b/sound/soc/codecs/pcm6240.c
index db85ae2f8..7a8c8f53f 100644
--- a/sound/soc/codecs/pcm6240.c
+++ b/sound/soc/codecs/pcm6240.c
@@ -2019,8 +2019,6 @@ static const struct regmap_config pcmdevice_i2c_regmap = {
 
 static void pcmdevice_remove(struct pcmdevice_priv *pcm_dev)
 {
-	if (pcm_dev->irq)
-		free_irq(pcm_dev->irq, pcm_dev);
 	mutex_destroy(&pcm_dev->codec_lock);
 }
 
-- 
2.34.1
