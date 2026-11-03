Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793688487;
	b=KtJFaf6ITZ4GjWHXDQbEunOXm+deKjFfD6Z/BYnYee+diL9QscaotMAAK0DHFndFwJEH
	 rEHBK/kmyw2awrX9VJ76bypOww2AX63sOMEDdlFqFLupaDLAKDNZgdJfra3rCGsX91zzJ
	 SV7tslMI/dy6Eta1IHgAD/1ZtiZDMzKX1JakhugZWCFT1jQVFZ8GSsgNQkm2xjYThj7Rs
	 gHMkWQmvevM/aD+9L9U0Kr0f2GuGxoaWrUnVUiYgNu1VzjXTpCXaC6ealYaREjZ0AYSCc
	 6S06SatITZFO7wOq9f4VXPqIko+Eg1bOqVzwWGGw1hiJF7FCMzZc7jkAGh7Rm9vYuDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793688487;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=BEpx4mzlOOqyUINUk4SDvd6Ib9n2DHRGd3CmNo6thCA=;
	b=r5MIBBOqwJvtiCQBzdM1w2lDGZf3hfI3KIJkHqzKZ3O109P3E1kNgaf7fAEx7+qiWWfE
	 wBaXjIIzc+1ZypCwlvHa6ckvwBV2qu0KboM3BTjG4j+wv0UqSpAKeSPNkCqtIaU6Wrmul
	 rO57KSPqJYNmA4OY74URpRWwHyQbR8mkHvuhJ1QYgMlI4gciq0dUtKtg0gf2qZOCtDNOw
	 ytLF6hERs7R7qXdRJESjmfimmSCBBncX1ShgVAInMMEnug5ZuDi5xVghKD7gAgGl7rhrF
	 nBL9TXMVuqBKj4exl+Y7pGG1jF8v4gf8vVtn5NtuTpx+ASBAOk+vrOIS4uLqTMeohaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E506606A324;
	Tue,  3 Nov 2026 06:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E506606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACnt5iWg+lqloI5AA--.238S2;
	Tue, 03 Nov 2026 14:47:50 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	luca.ceresoli@bootlin.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/bridge: lt9611: Put DSI nodes if device tree parsing fails
Date: Tue,  3 Nov 2026 06:47:59 +0000
Message-Id: <20261103064759.1059044-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACnt5iWg+lqloI5AA--.238S2
X-Coremail-Antispam: 1UD129KBjvJXoWrurWkuFWkGw15JFy3uw4xCrg_yoW8Jr18pF
	47WFyFkry3uF1xK3yYy3W8ta4ak3WDtFWxCFWDG3WF9w1rZF47Z39IvFyFqry8ZFyUKr1Y
	yF48trW7GF1DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r
	4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbtl1PUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgYAA2rpWmWI-QAAsK

lt9611_parse_dt() obtains references to the remote DSI nodes before
looking up the downstream bridge. If that lookup fails, for example
with -EPROBE_DEFER, lt9611_probe() returns without releasing the DSI
node references.

Use the existing err_of_put cleanup path when parsing fails. Both node
pointers are zero-initialized, so this also handles a missing DSI node.

Fixes: 23278bf54afe ("drm/bridge: Introduce LT9611 DSI to HDMI bridge")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/bridge/lontium-lt9611.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index 2d1a28261037..3c3e91e19fbd 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -1116,7 +1116,7 @@ static int lt9611_probe(struct i2c_client *client)
 	ret = lt9611_parse_dt(dev, lt9611);
 	if (ret) {
 		dev_err(dev, "failed to parse device tree\n");
-		return ret;
+		goto err_of_put;
 	}
 
 	ret = lt9611_gpio_init(lt9611);
-- 
2.34.1

