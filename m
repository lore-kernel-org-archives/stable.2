Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79DF2F8E9C;
	Wed, 24 Jun 2026 07:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782284441; cv=none; b=T+RVQxSZX5dYBwvJl3tHyR6UWtPTFmDm65yE3Y+L8sMGgj97kESiGiRUoUoHdSQFv9CcunyOW5WFYkq1BIzkALuPfRJ/hjLO8VlfbxTkeqpVFjk9SFjMeMcF+vqJd3rQRYsrLIUlCag06CrOJvMCAelx5JNTGsjqO+hJ3Bhziic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782284441; c=relaxed/simple;
	bh=NDALycz1iIRSXnwLnG+zXOgRA2ZAYGVGRwhsULPuY7s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UzPN9HMooBeGn12gLvvm/A8qfmCSZk86JpBVKaWZmH4tvh7lKamqRAVifeLann8IF86/JOtqdTaoUKF8IMXNC6A4JN/B9jStAe848vSWE3QrSbp54/qC08Los1zwRipzLya+KDDBpo4nezLpGVzpS46zr/3qHMQYaxCGrU7G56Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NPKosWM/; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NPKosWM/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=NI
	t6ovgy9E7cLXqhwIgCmEMV3bGprFBmdZQOBIElmT0=; b=NPKosWM/0mTJs/ytNv
	NZwKTGfjgXA7bJi88mTjLRYnxHuA3X73hwMBEaGeMAIC8ga+NBdPip2rn65B2QYM
	5R956CDADCtG8bjLEHNSt3sUoh9YZx0FO2uQYvrYWKJ/pZefEE8KarUp6z66I5t7
	vohK0eJp0TnWR/CWMnsKNfSx8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3X1RsgDtq2RGRFQ--.40730S2;
	Wed, 24 Jun 2026 14:59:58 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: elder@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net: ipa: fix SMEM state handle leaks in SMP2P init
Date: Wed, 24 Jun 2026 14:59:55 +0800
Message-Id: <20260624065955.2822765-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X1RsgDtq2RGRFQ--.40730S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr1xCF1fCw1DGw4DAF1UKFg_yoW8KFyrpw
	n8uwsIgry5Jr4xKF17KFyxuas8uw4xKrWDGrZxA3s5uFW5Ar4rtF1DtryFyFZYkrW8GF1a
	yw43AFs8WayFvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piOVy7UUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbC7Q6kE2o7gG6bogAA3S

ipa_smp2p_init() acquires two Qualcomm SMEM state handles with
qcom_smem_state_get(). However, neither the init error paths
nor ipa_smp2p_exit() release them.

Release both handles with qcom_smem_state_put() in the init
error paths and in ipa_smp2p_exit().

Fixes: 530f9216a953 ("soc: qcom: ipa: AP/modem communications")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
Changes in v2:
 - Use explicit qcom_smem_state_put() calls instead of devm helpers.
   Thanks, Alex! Thanks, Jakub!
---
 drivers/net/ipa/ipa_smp2p.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
index 2f0ccdd937cc..331c00ad02c0 100644
--- a/drivers/net/ipa/ipa_smp2p.c
+++ b/drivers/net/ipa/ipa_smp2p.c
@@ -232,19 +232,27 @@ ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
 					  &valid_bit);
 	if (IS_ERR(valid_state))
 		return PTR_ERR(valid_state);
-	if (valid_bit >= 32)		/* BITS_PER_U32 */
-		return -EINVAL;
+	if (valid_bit >= 32) {		/* BITS_PER_U32 */
+		ret = -EINVAL;
+		goto err_valid_state_put;
+	}
 
 	enabled_state = qcom_smem_state_get(dev, "ipa-clock-enabled",
 					    &enabled_bit);
-	if (IS_ERR(enabled_state))
-		return PTR_ERR(enabled_state);
-	if (enabled_bit >= 32)		/* BITS_PER_U32 */
-		return -EINVAL;
+	if (IS_ERR(enabled_state)) {
+		ret = PTR_ERR(enabled_state);
+		goto err_valid_state_put;
+	}
+	if (enabled_bit >= 32) {		/* BITS_PER_U32 */
+		ret = -EINVAL;
+		goto err_enabled_state_put;
+	}
 
 	smp2p = kzalloc_obj(*smp2p);
-	if (!smp2p)
-		return -ENOMEM;
+	if (!smp2p) {
+		ret = -ENOMEM;
+		goto err_enabled_state_put;
+	}
 
 	smp2p->ipa = ipa;
 
@@ -289,6 +297,10 @@ ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
 	ipa->smp2p = NULL;
 	mutex_destroy(&smp2p->mutex);
 	kfree(smp2p);
+err_enabled_state_put:
+	qcom_smem_state_put(enabled_state);
+err_valid_state_put:
+	qcom_smem_state_put(valid_state);
 
 	return ret;
 }
@@ -305,6 +317,8 @@ void ipa_smp2p_exit(struct ipa *ipa)
 	ipa_smp2p_power_release(ipa);
 	ipa->smp2p = NULL;
 	mutex_destroy(&smp2p->mutex);
+	qcom_smem_state_put(smp2p->enabled_state);
+	qcom_smem_state_put(smp2p->valid_state);
 	kfree(smp2p);
 }
 
-- 
2.25.1

