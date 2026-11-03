Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694855;
	b=RxIxJ3F/n1L+v2JOKc5dMGo/go0WBu3E7Mys8eCRml7cYvcS2xhwvAMhRz2o9gRvkmsy
	 b/0Wac5vWiHPzulP9TikKMKGy0C9L0aKRghRr+YlRhdut8F3rQpbP84dFjiJWpQCwsNlA
	 mz9kNkUbnuKT148oMAsJriGY3yOpFNWHuw1aAa80F8u0/kZEUDk/tS3ywiPC//NG4dtAJ
	 pbizkZ5L0pzvQNQvz17XvTmzpVdJ+kp4/bMbZsm4SAvIlF67i+OMuTnnMo9EvJBSda1JY
	 5cPjXcm66wZaG/zYxEer3zsSOJFEUsZKWWMbgCZD2oBqC3MvcS+AO/Gc1XnJr2kGmzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694855;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=EP/+BovutAzWRTMRDAWAE1I1KxLZSvrN0LvXnXQbAPk=;
	b=MceW22+pzRzC3sFCjB1D3b6XRndbknwri5xpXLTOUgQnku31Ph7LfbuPbBXlHRPhBAyB
	 3W+OYmcCuRNwSbt3gSzdFXIRQEp248oPfb2KMh4rWu8DIyGOTLBTl15tYYmPjlCkOCOXi
	 +SIChJdgEfT/gjMjgJRlg6/ovN56g90LhieXfS+LDc6kGIX+re8983hqNQBRpXCgwKy9t
	 g9NcD5aUGp7s97G70pZm1RRVcgSR8ACp9Eq1HtTxxRlOKp+KnCPy4elYj+ust4esYvJfQ
	 wSfu74Tvm3SmftHVhxW+55fkm0dWffis67bg1O1YHb6jit8Lm/od0XGJQ/EwggdGfbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358C9606A33D;
	Tue,  3 Nov 2026 08:34:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 358C9606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADn9ZaAnOlqNH86AA--.1378S2;
	Tue, 03 Nov 2026 16:34:08 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: vladimir.zapolskiy@linaro.org,
	sakari.ailus@linux.intel.com
Cc: mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: i2c: ov6211: Release controls after control creation failure
Date: Tue,  3 Nov 2026 08:34:17 +0000
Message-Id: <20261103083417.1175861-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowADn9ZaAnOlqNH86AA--.1378S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cry8WFyrJFW7Ary7uw4Durg_yoW8GryfpF
	sxWasrAryUJF42g3WDAF1jk3WakayfKFWDGFZFqw1fZrnaqa4DtrWfKa13uFs7Gr4Iv3W2
	qrsYqFy8GF1UCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_
	Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUMGQ
	DUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAQAA2rpWwr9twAAsT

ov6211_init_controls() returns the handler error directly when a control
cannot be created. Controls that were successfully created earlier and
the handler's allocation are left behind. The probe caller powers the
sensor off on this error and does not free the handler.

Use the existing error_free_hdlr path for this failure, just as for the
subsequent firmware-property parsing and control initialization errors.
Save and return the original control error.

Fixes: fd7cb868e309 ("media: i2c: Add OmniVision OV6211 image sensor driver")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/media/i2c/ov6211.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov6211.c b/drivers/media/i2c/ov6211.c
index 2ad31b2c5249..d82aacc7dcfb 100644
--- a/drivers/media/i2c/ov6211.c
+++ b/drivers/media/i2c/ov6211.c
@@ -360,8 +360,10 @@ static int ov6211_init_controls(struct ov6211 *ov6211)
 				     ARRAY_SIZE(ov6211_test_pattern_menu) - 1,
 				     0, 0, ov6211_test_pattern_menu);
 
-	if (ctrl_hdlr->error)
-		return ctrl_hdlr->error;
+	if (ctrl_hdlr->error) {
+		ret = ctrl_hdlr->error;
+		goto error_free_hdlr;
+	}
 
 	ret = v4l2_fwnode_device_parse(ov6211->dev, &props);
 	if (ret)
-- 
2.34.1

