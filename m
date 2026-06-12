Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0459C76025;
	Fri, 12 Jun 2026 03:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781234597; cv=none; b=OKqDGIJf7Csb2sgwacgeQmJB8AzWyoFYzhSkhZemfPNNBhbmRjJN6EEprEM5hUcq0BE0uizCEhiJr0RUGg8jcxo5ZHFYZ06phgwyThiUmexvUSlZqLlHftbbRhVfgBH2Gf1+NNeywP8J+kNDg9a8E6hF0wEBp0/rNHnQN7+qm9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781234597; c=relaxed/simple;
	bh=AdiZXxf0SM3KOsjDN1O6kcmMnJJvbVKuluzWEHWlPHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z3xMtIMyQjZbNV78mJX6yG65cZDryg2tdWKxzwoauJlVqQ6s/l2dJUkrWMwMVa+ltSMP0GLJ1jYVunlP8YBMlrF+XHGluyrkMYxE5oyzVgsieofKwKGTdxN8918YBo7gKHkqoppuur7o4s2Vk3DbJlHrErtw9uX5e6+69/tbRD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-01 (Coremail) with SMTP id qwCowACnS9SSeytq0w5dAQ--.11066S2;
	Fri, 12 Jun 2026 11:23:00 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: pierre-louis.bossart@linux.dev,
	amadeuszx.slawinski@linux.intel.com,
	songxiebing@kylinos.cn,
	verhaegen@google.com,
	vulab@iscas.ac.cn,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: Intel: avs: Fix d0ix reference count leak on set_params error path
Date: Fri, 12 Jun 2026 11:22:56 +0800
Message-ID: <20260612032256.23504-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACnS9SSeytq0w5dAQ--.11066S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF47Kr15Ww4DKr4xuw1rZwb_yoW8XFWrpa
	1q9395KryYqayv93y7Aa1FvFySkay5A3y3Kr4UGw1ayF15Jr1SqwnagayYgFWxtrWfGwnx
	XFnrKry5CFy5CFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUb8hL5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgoQA2orLjLjngAAs-

In avs_probe_compr_set_params(), avs_dsp_disable_d0ix() is called when
no probe streams are active. This function atomically increments the
d0ix_disable_depth counter before attempting the hardware power state
transition. If the transition (avs_dsp_set_d0ix()) fails, the function
returns an error but the counter remains elevated.

The caller does not balance the counter on this error path, causing a
reference count leak that permanently prevents the DSP from entering
d0ix.

Fix the leak by calling avs_dsp_enable_d0ix() to balance the previous
disable call before returning the error, mirroring the existing cleanup
pattern used when avs_dsp_init_probe() fails.

Cc: stable@vger.kernel.org
Fixes: 700462f55493 ("ASoC: Intel: avs: Probe compress operations")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 sound/soc/intel/avs/probes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/avs/probes.c b/sound/soc/intel/avs/probes.c
index 099119ad28b3..01d9421cf9ab 100644
--- a/sound/soc/intel/avs/probes.c
+++ b/sound/soc/intel/avs/probes.c
@@ -162,8 +162,10 @@ static int avs_probe_compr_set_params(struct snd_compr_stream *cstream,
 
 		/* D0ix not allowed during probing. */
 		ret = avs_dsp_disable_d0ix(adev);
-		if (ret)
+		if (ret) {
+			avs_dsp_enable_d0ix(adev);
 			return ret;
+		}
 
 		node_id.vindex = hdac_stream(host_stream)->stream_tag - 1;
 		node_id.dma_type = AVS_DMA_HDA_HOST_INPUT;
-- 
2.50.1 (Apple Git-155)

