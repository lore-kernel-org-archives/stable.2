Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC701FBC8C;
	Sat, 27 Jun 2026 03:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782532775; cv=none; b=GrPjoUdxd8k4Z41OqnfbQDSU1R2xZ5YbeSVAErpgONjWz6x25MRKsjqxh1Bif8XNVrbCqeNmwEQUFhY7rjXWK8tkG3t7CuXhxjWNo1nE9mJURAs7at9bwneXaDm2oQEDvp2eJhoIMH9316hp1+AbX6au1sTMA7dh1OsOna2gcRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782532775; c=relaxed/simple;
	bh=+1yb5J6htph1BXZleaLWvFAjEOREuksNA/skg13nx7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lUWKj0Z9HPapcYw6mswes+lnA3vFK7WQ3Bz6CagahwszdSqZieEO479JYYD+3leJFhFIsU+9jon5EhtK3imgHAZjMgPavBIowGpbAuOZabUl/JWSagYT0AnXVxvLIws+6qllb3dktesTkG/Gv42kmBUbbrK54PYnso5cYbF67Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowAD3mtOfSj9ql9uBAw--.23021S2;
	Sat, 27 Jun 2026 11:59:27 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: s.nawrocki@samsung.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fix: sound/soc/samsung: snow_probe: leaked of_node references on devm_snd_soc_register_card failure
Date: Sat, 27 Jun 2026 11:59:25 +0800
Message-Id: <20260627035925.60472-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAD3mtOfSj9ql9uBAw--.23021S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw15Kw4DZw47AFWxtFyUAwb_yoW8WF4rpr
	s8GrZIqrWjqr1vvw4FvrZ5uFWI9a4Sgr4rCF4Iqa48AFn8Wrn7XFyUWryxZFZIyFy8Cw1U
	Xry8JayxAay8ZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUyMK
	tUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgILA2o-DDp+xQAAsU

In snow_probe(), snd_soc_of_get_dai_link_codecs() acquires of_node
references for codecs, and of_parse_phandle() acquires a reference for
cpus->of_node. When devm_snd_soc_register_card() fails, these references
are never released. Additionally, link->platforms->of_node is assigned
from link->cpus->of_node without of_node_get(), causing a double put on
card deregistration.

Add proper cleanup of codecs and cpu of_node references on the
register_card failure path, and add of_node_get() before the platforms
assignment.

Cc: stable@vger.kernel.org
Fixes: 27c6eaebcf75 ("ASoC: samsung: Use dev_err_probe() helper")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 sound/soc/samsung/snow.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/samsung/snow.c b/sound/soc/samsung/snow.c
index 66ef49dff1ba..78d7d494d51d 100644
--- a/sound/soc/samsung/snow.c
+++ b/sound/soc/samsung/snow.c
@@ -203,6 +203,7 @@ static int snow_probe(struct platform_device *pdev)
 		}
 	}
 
+	of_node_get(link->cpus->of_node);
 	link->platforms->of_node = link->cpus->of_node;
 
 	/* Update card-name if provided through DT, else use default name */
@@ -211,9 +212,12 @@ static int snow_probe(struct platform_device *pdev)
 	snd_soc_card_set_drvdata(card, priv);
 
 	ret = devm_snd_soc_register_card(dev, card);
-	if (ret)
+	if (ret) {
+		snd_soc_of_put_dai_link_codecs(link);
+		of_node_put(link->cpus->of_node);
 		return dev_err_probe(&pdev->dev, ret,
 				     "snd_soc_register_card failed\n");
+	}
 
 	return 0;
 }
-- 
2.39.5 (Apple Git-154)

