Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56623C3F7B;
	Wed, 14 Oct 2026 10:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791973586; cv=none; b=WKyrrR1RjVOLkB5Y2prs3V3ttuB85YIk//V7UpmXEVHcNjQ65rJsAPOq8jv2VgaLFAVcpFOD3ZCQwYLsAesO9HVDCJCenQ4MiCMoPbyHZniJQTQsvqIh3kbc3djeaEHeBM87L2s/BgJjnjs33wzPDEICYxxfEVEU8ZzZywOjO+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791973586; c=relaxed/simple;
	bh=eEwD/rk+GiCQSggNZcLZ8E08bkpy39mNXadrL1hxNpY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lclg9vKgaBf0s9fDaUVM5JQhKy2oPlrccrn17Ls/GuwXPEXpEo7Npc0QFWQsGPYZEohlvVKD9q98zQsWx9X9/ghBlcxZEkK0xe5zSbVKO2GLeu7uBBq5uWjlVQi3HAfhK2Yb5qD2PiVxCG6o2Zbc7UGcYuLV4mQJcL0pRTU47kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=kl5+lJwP; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="kl5+lJwP"
From: Denis Arefev <arefev@swemel.ru>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1791973579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eUD8b20Zl7D+KHbQzbiKippwor7cNZzQh1VqHI5iaAc=;
	b=kl5+lJwPHteYy6k/3BZBpOidZJcjs9Y4DCcfjQtYQ0nfPIlEzWdGxA+slzjuLi9uIYULBH
	fQL5KqwgRm5tgtta/EyAPiAwAcRDBv+nSsJ4E7pWAaYdvAkXiWYgZjPRUWygTxVQ5mxP6c
	uH5H6OYjFWGqYkWEigFfU8SkcKAmmhw=
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: cs46xx: fix unit mismatch in DSP code area bounds check
Date: Wed, 14 Oct 2026 13:26:18 +0300
Message-ID: <20261014102619.16415-1-arefev@swemel.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ins->code.offset and code->size are measured in 32-bit words, while
DSP_CODE_BYTE_SIZE is the size of the DSP code area in bytes. The
check ins->code.offset + code->size > DSP_CODE_BYTE_SIZE in
cs46xx_dsp_load_module() therefore allowed up to four times more code
than the code area can hold.

The shadow buffer ins->code.data is allocated with
kmalloc(DSP_CODE_BYTE_SIZE), i.e. it holds DSP_CODE_BYTE_SIZE/4
words. A firmware file with a code segment larger than
DSP_CODE_BYTE_SIZE/4 words (28 KiB) passed the check and caused an
out-of-bounds write in shadow_and_reallocate_code() and an
out-of-bounds read in snd_cs46xx_download().

Compare the sum in words against DSP_CODE_BYTE_SIZE/4 and cast it to
u64 so that the sum cannot wrap for large code->size values.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Denis Arefev <arefev@swemel.ru>
---
 Compile tested only
 sound/pci/cs46xx/dsp_spos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/cs46xx/dsp_spos.c b/sound/pci/cs46xx/dsp_spos.c
index 6fd4f629d1d5..a77e6f5a14ad 100644
--- a/sound/pci/cs46xx/dsp_spos.c
+++ b/sound/pci/cs46xx/dsp_spos.c
@@ -393,7 +393,7 @@ int cs46xx_dsp_load_module (struct snd_cs46xx * chip, struct dsp_module_desc * m
 		dev_dbg(chip->card->dev,
 			"dsp_spos: module got no code segment\n");
 	} else {
-		if (ins->code.offset + code->size > DSP_CODE_BYTE_SIZE) {
+		if ((u64)ins->code.offset + code->size > DSP_CODE_BYTE_SIZE / 4) {
 			dev_err(chip->card->dev,
 				"dsp_spos: no space available in DSP\n");
 			return -ENOMEM;
-- 
2.43.0

