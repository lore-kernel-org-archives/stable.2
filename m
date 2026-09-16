Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452783FD96E;
	Wed, 16 Sep 2026 07:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789542586; cv=none; b=dyebXmlvyrtHjKpx9PkThB+jpvp1fvFokc+86VeyJS5ztCvNQdWy1553MDSEFUBW1hjdoOzHteUe1UDf2Eink8t38b0URCls1QKnVb4NH4YE5LNu7cANOxodihi0fLSn7yBzwOARc3CGoSCWABJEq9jXI+DjBPzCiNAODm7pGv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789542586; c=relaxed/simple;
	bh=ryCd3CPpqqZzwz//BiKcPgW8B/POumMrzQTjiW2c7WU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k0LT7Y3R0bYG+RhnhBVzcVW6dhYXm9kHDlenmojUs9k0dUchibrob0wZtBSCb2ilWYxlN/C2V3OxAx69L0C3pp8KiXfBQMGwEfHcjUIH3n8R0ADZTKMdAobf4vmd6+Nfx3qPbId8Bs2oQC+xtbZRCHIpTElZoo5MwvbxeKGuL4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACXmjiuQKpqaPHeBw--.59725S2;
	Wed, 16 Sep 2026 15:09:34 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: arnaud.pouliquen@foss.st.com
Cc: broonie@kernel.org,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 05/20] ASoC: sti: uniperif_player: Fix clock leak in uni_player_init()
Date: Wed, 16 Sep 2026 07:09:06 +0000
Message-Id: <20260916070906.1965935-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXmjiuQKpqaPHeBw--.59725S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKF45Jr1UJr17AF4UWFy5twb_yoWktwcE93
	yj9r1vqr9rCFWayw1qqrs3AFsYgF18urZ5KF47KF43J34DGws5ta4jqryxur1rWw4rKryk
	Ary3Wws7Awn3WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUw5l8UU
	UUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAQMA2qqP7kEwwAAsG

In uni_player_init(), player->clk is acquired via of_clk_get(). If any
subsequent operation fails (e.g. regmap_field_write(), devm_request_irq()),
or upon driver detachment, the acquired clock is never freed with
clk_put(), resulting in a resource leak.

Switch to devm_clk_get() so the clock is managed automatically and
properly released.

Fixes: 76c2145ded6b ("ASoC: sti: Add CPU DAI driver for playback")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 sound/soc/sti/uniperif_player.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sti/uniperif_player.c b/sound/soc/sti/uniperif_player.c
index 45d35b887e4e..34a604688cc9 100644
--- a/sound/soc/sti/uniperif_player.c
+++ b/sound/soc/sti/uniperif_player.c
@@ -1078,7 +1078,7 @@ int uni_player_init(struct platform_device *pdev,
 		player->hw = &uni_player_pcm_hw;
 
 	/* Get uniperif resource */
-	player->clk = of_clk_get(pdev->dev.of_node, 0);
+	player->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(player->clk)) {
 		dev_err(player->dev, "Failed to get clock\n");
 		return PTR_ERR(player->clk);
-- 
2.34.1

