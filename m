Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E6352CCE6;
	Thu, 17 Sep 2026 17:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789664466; cv=none; b=KJiTJaR5imy7anHD1VfhfLmVz5WZ8//JTjYKt+1+omRBwWJGdHLXn/iFZNeV5oyyFdWYRyt+EzCdrC8zzKGv/9JAaslJ9q5bra/O8vI97ud5+qEt8s/guXisVnFs1tFulIK0UjdlqvhG6kNyk3crPOhe0HkoIzd/1UflRcAqbcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789664466; c=relaxed/simple;
	bh=XwRE6lz8zzUWQqfe5tl5Xvwgi8WlYNQ6+FgbwConfCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B9UJ9ROrBpud2Z0UV/Ci3LdQGEwJ9lXluhn12QJf3gLbqg0N3pTFM2N8juBI8PtV3MCPr8fizJFZx8s25jdkW6RIDx7mzHxf+1l1XC2b8wyzrnSPoE8wPcHB+T7/g5qMAyA5OcLnKvT6IvGMdeJQ3A5MwnOX0Qsv4SmM9fEcB9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAB3pkDDHKxqzfaECA--.7220S2;
	Fri, 18 Sep 2026 01:00:52 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: broonie@kernel.org
Cc: cezary.rojewski@intel.com,
	hansg@kernel.org,
	kai.vehmanen@linux.intel.com,
	liam.r.girdwood@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	peter.ujfalusi@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	tiwai@suse.com,
	yung-chuan.liao@linux.intel.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: Fix use-after-free in snd_byt_rt5640_mc_probe()
Date: Thu, 17 Sep 2026 17:00:52 +0000
Message-Id: <20260917170052.2163636-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAB3pkDDHKxqzfaECA--.7220S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr13CF47Jr48Cry7Zw1fWFg_yoWkXwcEka
	4j9348Xa48CFsa9rs8AasIkwn7Xr13tFW0g3WxtF4kJFWrXFWfJa98KrZ09F4DWw4vgryj
	93Wj9rWxCryS9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2
	jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJwAS0I0E0xvYzx
	vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x02
	62kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr
	1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU5byZUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgINA2qr889g2wAAsM

When the device found by name is not an i2c_client, the reference taken
by bus_find_device_by_name() is dropped, but execution continues with
the stale codec_dev pointer, which is stored in priv->codec_dev and
dereferenced later in the probe.

The device is not usable as the codec, so return an error after dropping
the reference.

Fixes: d48696b91552 ("ASoC: Intel: bytcr_rt5640: Add support for non ACPI instantiated codec")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 40da3eea5fa7..557486c6f28d 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -1764,6 +1764,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 			dev_err(dev, "Error '%s' is not an i2c_client\n",
 				BYT_RT5640_FALLBACK_CODEC_DEV_NAME);
 			put_device(codec_dev);
+			return -ENODEV;
 		}
 
 		/* fixup codec name */
-- 
2.34.1

