Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA3543DA59;
	Wed, 16 Sep 2026 07:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543168; cv=none; b=uT3gkhh8ZGbS/jMNCn4pJ3uybLU+orad1H7sk5zZtcfhJsYW/LBid9JfJFYyu7bRSs34oNC8ymLk4o4x4TldEpfT3QCgIY4bugFlYycKVskgqXuL+9vm6yybbOQ7MRetvmuaqhFjdNn6z+1aX0cce2K/d4ThUt5zIw0evClTGS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543168; c=relaxed/simple;
	bh=+vhw1Wo/YC/nC2Y1GnuAl2izxJZP5sTbuDJdJge6hD8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZF2gp2UubGzU/sXHwZkxI7CJSwn/w8PKmZvCxG1VB0WCV9DVbhMTuc+eWUM8XZPH8/YoeVSb3kMJMnruSFRheMFY4GM7DIWjZwcGSq3tGR2t9+uuYplOTMG+hJAHR74wmoZSchEx0JN0e0oKTEFTvgz2uVer004jvCZkUsf2QG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAB3eTfsQqpq3AnfBw--.41311S2;
	Wed, 16 Sep 2026 15:19:08 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	neil.armstrong@linaro.org,
	perex@perex.cz,
	srini@kernel.org,
	tiwai@suse.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH 09/20] ASoC: codecs: wcd939x: Fix device node leak in wcd939x_populate_dt_data()
Date: Wed, 16 Sep 2026 07:18:40 +0000
Message-Id: <20260916071840.1966850-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAB3eTfsQqpq3AnfBw--.41311S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gry3uFyrJw1xXr4rZFWUArb_yoWDKFbEg3
	y8WrWqqry8Wr92k3yDXF4Ivan2gF4xurW0yw1jyr9rGayUXFWfAwnxtr93uFy5Zrs7Jay5
	Z3WjqF43W342kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VU1VHq7UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwgMA2qqQJUKPwAAsg

In wcd939x_populate_dt_data(), np is obtained via
of_graph_get_remote_node() to check if the remote endpoint exists,
but the returned reference is never dropped, causing a device node
leak.

Declare np with __free(device_node) so that the reference is
automatically released when exiting the function scope.

Fixes: 10f514bd172a ("ASoC: codecs: Add WCD939x Codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 sound/soc/codecs/wcd939x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd939x.c b/sound/soc/codecs/wcd939x.c
index 01f1a08f48e6..022f7b02237d 100644
--- a/sound/soc/codecs/wcd939x.c
+++ b/sound/soc/codecs/wcd939x.c
@@ -3182,7 +3182,7 @@ static int wcd939x_populate_dt_data(struct wcd939x_priv *wcd939x, struct device
 {
 	struct wcd_mbhc_config *cfg = &wcd939x->mbhc_cfg;
 #if IS_ENABLED(CONFIG_TYPEC)
-	struct device_node *np;
+	struct device_node *np __free(device_node) = NULL;
 #endif /* CONFIG_TYPEC */
 	int ret;
 
-- 
2.34.1

