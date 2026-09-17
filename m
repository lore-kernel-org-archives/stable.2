Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D6A51A134;
	Thu, 17 Sep 2026 16:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789663596; cv=none; b=N+1mqOgqi9PtiK+jt/6fOxnnmEtsyGpbFZnkU2C0sHluqTgHcAPGNypmmLgRQ8OvCTHYna2OfyBHoCwNuB5v38TL0O6w/pncmhVc8dIH7X8hWf7oeIbq2PIMr9GjeorMLhWonWeODtzJfLkskuej/5US0htWRYPhmwkOGlSD5rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789663596; c=relaxed/simple;
	bh=8RIfnfRH+aOZKq7lB5+mDcmjSHUGSrRgsrUz5ma4HUs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JGE3AyKcShRQyiZTxBBzH2yzMCoe4+91lRr53i2NoFynluFSjwklbnjzvG08I2kgjX8YtWL1/Aw2MH8oQl50eyd7JZFRlkr/s1J/rMAW0nkXjJPSvU2glx05hWmW+ZIrNgZkUVfzOkKnOBXkyEVBZmEPRK49d6p8jCAuafxjT8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACnEDthGaxqzsCECA--.739S2;
	Fri, 18 Sep 2026 00:46:25 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: broonie@kernel.org
Cc: ckeepax@opensource.cirrus.com,
	cw00.choi@samsung.com,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	perex@perex.cz,
	tiwai@suse.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: arizona-jack: Fix runtime PM leak in arizona_start_mic()
Date: Thu, 17 Sep 2026 16:46:25 +0000
Message-Id: <20260917164625.2163097-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnEDthGaxqzsCECA--.739S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFy8tF45KF17Kry5JrWxXrb_yoWkKrc_Ca
	1fuw1DurWjgrZ2ya1DZFn8Z397uFyDGFWfZa1qyF4UtFWUKan8ZryUAr9xCrs2q3yfXa43
	A3WDuFW3A3srujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAANA2qr9nBTXwAAsJ

arizona_start_mic() takes a runtime PM reference before enabling mic
detection, but the error path taken when regmap_update_bits_check()
fails returns without releasing it, since pm_runtime_put_autosuspend()
is only called in the !change branch. This leaks a runtime PM reference
whenever the register write fails.

Release the reference on the error path as well.

Fixes: fbdc60b2a787 ("extcon: arizona: Correct error handling on regmap_update_bits_check")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 sound/soc/codecs/arizona-jack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/arizona-jack.c b/sound/soc/codecs/arizona-jack.c
index a9063bac2752..09a100846fdb 100644
--- a/sound/soc/codecs/arizona-jack.c
+++ b/sound/soc/codecs/arizona-jack.c
@@ -274,6 +274,7 @@ static void arizona_start_mic(struct arizona_priv *info)
 				       &change);
 	if (ret < 0) {
 		dev_err(arizona->dev, "Failed to enable micd: %d\n", ret);
+		pm_runtime_put_autosuspend(arizona->dev);
 	} else if (!change) {
 		regulator_disable(info->micvdd);
 		pm_runtime_put_autosuspend(arizona->dev);
-- 
2.34.1

