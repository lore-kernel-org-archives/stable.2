Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12602DB79F;
	Thu, 17 Sep 2026 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663900; cv=none; b=EfcvxHlIQs1aQumraEUfZzzJ5AXjkAo939Ef3jNsCcMGIGL1SEluyeAWGloWexayzBt5bdaWQj53u2JLZgfYfngqrZUAHrrgRWNji+nCvgGGBOxWcBPtIqr0JrFbN3PafGHR5mqNw6H7Cp1eqaFCFr1L6ojixcA1fI1Jtok7RJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663900; c=relaxed/simple;
	bh=syyvC04pOKZpxGgq1oPwRcYuvMyyc7WD8rEDfR8kBCc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DZJFm27qlj9O87ojZQ6I/+/hF0RO8ylAH2EEjsDGSNp1kD6nlJzSq9B4UmRUngYB/28LLM+fWyST2izcN9ieDK9ifG6OKRDFxZY+u0I7N+cUC7g4XCPDxjSB5zllro65CNvs4qaTt7OE6OinlBcul49OHrdg68fophnMhHln45Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACH8z2SGqxq+9OECA--.7119S2;
	Fri, 18 Sep 2026 00:51:30 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: broonie@kernel.org
Cc: ckeepax@opensource.cirrus.com,
	krzk@kernel.org,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	perex@perex.cz,
	s.nawrocki@samsung.com,
	tiwai@suse.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: codecs: wm8994: Fix runtime PM leak in wm8994_mic_detect()
Date: Thu, 17 Sep 2026 16:51:30 +0000
Message-Id: <20260917165130.2163278-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACH8z2SGqxq+9OECA--.7119S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XrWUtryrWw1DXFy8GF1xZrb_yoWDtrg_Wa
	n5Wa97Zry5KFZxKrZrKF4rZF93ZF4xC3y8tr90vrnxJa42yF4rJrn8JFs8CrW7Ww48Z3W3
	ZFnI9F47AryIvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
	87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7Cj
	xVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr
	1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I
	0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbUPEDUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwMNA2qr9thUTgAAs-

wm8994_mic_detect() resumes the component before configuring the MICBIAS
pins, but the default case of the micbias switch returns -EINVAL right
after taking that reference, skipping the pm_runtime_put() on the
success path. This leaks a runtime PM reference on every call with an
invalid micbias.

Release the reference before returning -EINVAL.

Fixes: f5a2cda4f1db ("ASoC: wm8994: Ensure the device is resumed in wm89xx_mic_detect functions")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 sound/soc/codecs/wm8994.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 1d64c7c42ed1..bfbb8a56b563 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -3535,6 +3535,7 @@ int wm8994_mic_detect(struct snd_soc_component *component, struct snd_soc_jack *
 		break;
 	default:
 		dev_warn(component->dev, "Invalid MICBIAS %d\n", micbias);
+		pm_runtime_put(component->dev);
 		return -EINVAL;
 	}
 
-- 
2.34.1

