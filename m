Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4973B399346;
	Thu, 17 Sep 2026 11:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646082; cv=none; b=LXCMapbJE1gyUbWJmjJQml2xfxYUM2u6OF5o0XoeNihgX391+S+P8wpsVzjSRP0vs4fYZ4sHxe5m40huj0YkyWAytWjtqB+hsqQuIaPJHxjfnFrt3/20bOkKme3o4kyv4Zy67WEXmP58+RyGLrkKxTxRFNTUWX84eSE7SK0sqMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646082; c=relaxed/simple;
	bh=9lxPP8kDPuSJxWMnhPEniq+HzO0mLwoHNPgPKOfIJGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P/ynLrLEQY6kK5QKR4ogTg7dwTlLkbv+1gBGZ3Bx0huUNtfp4MOEhKgFsx1OhBTWofe2wT7hqyV9ExBf56p5OOneyiciEcJb7JVIYa5xUHFBLzJBThToU+pNqh0KSiUQifFgUXCaOmoqtQuRr2UFhbMq92qA1MQKTQ4nShLWVdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABHsTvw1Ktqnvp_CA--.2063S2;
	Thu, 17 Sep 2026 19:54:24 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew+netdev@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	elder@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: ipa: Fix valid_state leak in ipa_smp2p_init()
Date: Thu, 17 Sep 2026 11:54:24 +0000
Message-Id: <20260917115424.2149947-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABHsTvw1Ktqnvp_CA--.2063S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF13Zw1xCw18Aw1UWryxGrg_yoW8ZF45pw
	s8Zas8Kry5Gr4xKF17GFyUWF90934xKr98G3sIk3s5Zay3AF4FyF1DJryrAayfAry8Gw15
	Jw1ayF4DWayFvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPmb7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
	0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
	1l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw
	0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZE
	Xa7IU8czVUUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAENA2qrrJp7HwAAsQ

qcom_smem_state_get() takes a reference on the state, but
ipa_smp2p_init() returns without releasing the "ipa-clock-enabled-valid"
state when the bit number is out of range, when the "ipa-clock-enabled"
state cannot be acquired or its bit number is out of range, when the
smp2p structure cannot be allocated, and on the error paths that free
the structure. Release the reference on all of these paths.

Fixes: 530f9216a953 ("soc: qcom: ipa: AP/modem communications")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ipa/ipa_smp2p.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
index 78f6df2cad76..f45225b16722 100644
--- a/drivers/net/ipa/ipa_smp2p.c
+++ b/drivers/net/ipa/ipa_smp2p.c
@@ -232,21 +232,27 @@ ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
 					  &valid_bit);
 	if (IS_ERR(valid_state))
 		return PTR_ERR(valid_state);
-	if (valid_bit >= 32)		/* BITS_PER_U32 */
+	if (valid_bit >= 32) {		/* BITS_PER_U32 */
+		qcom_smem_state_put(valid_state);
 		return -EINVAL;
+	}
 
 	enabled_state = qcom_smem_state_get(dev, "ipa-clock-enabled",
 					    &enabled_bit);
-	if (IS_ERR(enabled_state))
+	if (IS_ERR(enabled_state)) {
+		qcom_smem_state_put(valid_state);
 		return PTR_ERR(enabled_state);
+	}
 	if (enabled_bit >= 32) {	/* BITS_PER_U32 */
 		qcom_smem_state_put(enabled_state);
+		qcom_smem_state_put(valid_state);
 		return -EINVAL;
 	}
 
 	smp2p = kzalloc_obj(*smp2p);
 	if (!smp2p) {
 		qcom_smem_state_put(enabled_state);
+		qcom_smem_state_put(valid_state);
 		return -ENOMEM;
 	}
 
@@ -293,6 +299,7 @@ ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
 	ipa->smp2p = NULL;
 	mutex_destroy(&smp2p->mutex);
 	qcom_smem_state_put(enabled_state);
+	qcom_smem_state_put(valid_state);
 	kfree(smp2p);
 
 	return ret;
-- 
2.34.1

