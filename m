Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4625D4C4F69;
	Wed, 16 Sep 2026 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789553269; cv=none; b=Ylj+3eJzBLapiJgRp06HeKWIIKHRO8rAP7KjQ27qbIoD4PAKPjMB9pUZg8bMEumETAETf+bE9hdObiH+u3JZ5CAf/IwgBWgyvV4yfCZ72/kTIk9BpKdzJQMwQTxl3BVFPAWXr7s6R/r4yjZFxOS+UpdVRgHJFPkDDg4XdrKCSlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789553269; c=relaxed/simple;
	bh=bP4qvlLX8TzoI+hY/MiOjw8LoIFxJdNiut9Kmvnz7+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VXyQRfLc1LshMHlGgrZUkbPeL9z2oGrAreNLOOpdQoB7wYNTiIbHuQfR4ecyw6J9HSKWN/LaYVSxp0VrB+CccjCx8a3BTdRt7M2E4kmC5x9S+6Tqv5AkZMg8L9ngozxLY3pAqFri23pDRNN05lCGaNu43K24r3Zl6+rA5DyBSTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACnrjxiaqpq9NzgBw--.30652S2;
	Wed, 16 Sep 2026 18:07:30 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jose.Abreu@synopsys.com
Cc: Laurent.pinchart@ideasonboard.com,
	airlied@gmail.com,
	andrzej.hajda@intel.com,
	architt@codeaurora.org,
	dri-devel@lists.freedesktop.org,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	linux-kernel@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	simona@ffwll.ch,
	tzimmermann@suse.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] drm/bridge: dw-hdmi: Fix DDC adapter leak in dw_hdmi_probe()
Date: Wed, 16 Sep 2026 10:07:02 +0000
Message-Id: <20260916100702.2012915-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACnrjxiaqpq9NzgBw--.30652S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw4DAFWUGw1rCr13Ww4rZrb_yoW8Gr45pF
	ZrJa47Kr1FvF4xtayxA3W8ZasIka97JFWF9rWUAwnxZrn3XFyUZrZ8JF1aqr1UAasrWw43
	trnYqFZ7Za4qvF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9S14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCV
	W8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6r
	xdYxBIdaVFxhVjvjDU0xZFpf9x0pRLqXQUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUMA2qqP4etCQAAsP

dw_hdmi_probe() takes a reference to the DDC I2C adapter specified
through the ddc-i2c-bus property with of_get_i2c_adapter_by_node().
All the subsequent error paths unwind through the err_res label, which
releases the adapter with i2c_put_adapter(), except the invalid
reg-io-width path which returns ERR_PTR(-EINVAL) directly, leaking the
DDC adapter reference.

Jump to the err_res label instead of returning directly so that the
DDC adapter reference is dropped on that error path too.

Fixes: 80e2f97968b5 ("drm: bridge: dw-hdmi: Switch to regmap for register access")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 0296e110ce65..1da12e4616fe 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -3400,7 +3400,8 @@ struct dw_hdmi *dw_hdmi_probe(struct platform_device *pdev,
 			break;
 		default:
 			dev_err(dev, "reg-io-width must be 1 or 4\n");
-			return ERR_PTR(-EINVAL);
+			ret = -EINVAL;
+			goto err_res;
 		}
 
 		iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
2.34.1

