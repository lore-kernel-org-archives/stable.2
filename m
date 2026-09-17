Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C734DA9C6;
	Thu, 17 Sep 2026 11:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789645962; cv=none; b=MREMkdQfUuhKVT0wtyDIANfMcoCxDx66BmgFfyJD35+lfYtQm8kOHpg/9dwxjSJmuP3+0SmxhpBQDl/5TjZvP025MvAxudZxrpuD5fev/N6E9TT+2rWalbTDC7xbT795pQg0jtPW4sLBjSKArQwEZWOQrtND9mjDSGcyM6r3cso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789645962; c=relaxed/simple;
	bh=bVswK+dkCyTbPCTTduNsxpsGcVttkURQYjJqvedOub8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LF5HUd1VEGWeHeK1na7HAISJG7qEUfCNNtbhabX+yjvzhnTZ5g6kYM3Ki01U9MbEezDq5HovZLttxcQhHfEqd1JF10shDzlXNn0ETMgXXFvR/6YAyPUTdJQ3Lx5GWr+AI+QIYN3sT6r3yzD9WBs8s7M4BVPxNVap0Hq8wLdX4jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAXgDpw1Ktqm_B_CA--.65344S2;
	Thu, 17 Sep 2026 19:52:16 +0800 (CST)
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
Subject: [PATCH] net: ipa: Fix enabled_state leak in ipa_smp2p_init()
Date: Thu, 17 Sep 2026 11:52:16 +0000
Message-Id: <20260917115216.2149867-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAXgDpw1Ktqm_B_CA--.65344S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF13Zw1xCw18AFWkKF1Dtrb_yoW8XF1DpF
	s8Zaya9r95WF4xK3W7WFy8Wr9Yvw4xKry5G3s0y3s5Cay3Ar1rtF1vkFyFya1kAFW8GFn8
	tr1ayFn8uayrZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPmb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
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
	Xa7IU878n5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwENA2qrrRl3TwAAsF

qcom_smem_state_get() takes a reference on the state, but
ipa_smp2p_init() returns without releasing the "ipa-clock-enabled" state
when the bit number is out of range, when the smp2p structure cannot be
allocated, and on the error paths that free the structure. Release the
reference on all of these paths.

Fixes: 530f9216a953 ("soc: qcom: ipa: AP/modem communications")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/ipa/ipa_smp2p.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
index 2f0ccdd937cc..78f6df2cad76 100644
--- a/drivers/net/ipa/ipa_smp2p.c
+++ b/drivers/net/ipa/ipa_smp2p.c
@@ -239,12 +239,16 @@ ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
 					    &enabled_bit);
 	if (IS_ERR(enabled_state))
 		return PTR_ERR(enabled_state);
-	if (enabled_bit >= 32)		/* BITS_PER_U32 */
+	if (enabled_bit >= 32) {	/* BITS_PER_U32 */
+		qcom_smem_state_put(enabled_state);
 		return -EINVAL;
+	}
 
 	smp2p = kzalloc_obj(*smp2p);
-	if (!smp2p)
+	if (!smp2p) {
+		qcom_smem_state_put(enabled_state);
 		return -ENOMEM;
+	}
 
 	smp2p->ipa = ipa;
 
@@ -288,6 +292,7 @@ ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
 err_null_smp2p:
 	ipa->smp2p = NULL;
 	mutex_destroy(&smp2p->mutex);
+	qcom_smem_state_put(enabled_state);
 	kfree(smp2p);
 
 	return ret;
-- 
2.34.1

