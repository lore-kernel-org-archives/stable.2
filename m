Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C729C3803D2
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 02:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785292809; cv=none; b=HC2+uB6RivXpOeA4vDJx4phBSo+2l/C/O5vA/uFYhXbT3lqEtGTkMkjn1LWNdoF7vdDQzWSzIiHqeaZibE5yckdKdzoRuXJwmledlFZpj5CcyoHXmu1MlWBCCFZrVZT2iVZinf60BabdAVbxtalhtB9EKalufhwJdRlO1GFrMU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785292809; c=relaxed/simple;
	bh=t3zUMrjSEcbDF9wMn8BjWrhYZcQmTOArbQ2FlN4cD7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FN/XRf3iq/gW4JDkZ0NltYxmEqhE8jnCun20wtnWvb4GU3dvRhL25lCDWUvSaH8d2LkI2NQg3c0XnYfCFNIof+2dW1Q7R7Q7NLquU4ROp9V80Zftofcxm8ZSmaBi4LN5nf+LsBdtIDuwHdoiMR0/yKD1Cp0q5Phn/PGZdIqkQ9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=doXAmChS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="doXAmChS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD891F000E9;
	Wed, 29 Jul 2026 02:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785292807;
	bh=4/lZW4aFs+D51h/kM5neAXcaXW2itVua9wAuxjz/W/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=doXAmChSZ7eLYrA1FPjvdr92FSynVZ6TCobfgh8ssyDrgbzzx+zB6rp19tMSuP6up
	 3essIU7UQAWSxk+9QqaFVfrkw5pR5Aol0XB/gTG3XogJJ97SfR29VWyk9bbRQ48337
	 9KkpHT8IWdfCa7VMXheELm6hqF88h+1DJVilnFNAmu14f9wn2+J0CZS6JgAu6gEudJ
	 n1/4D5NIIcBDkqEe4J4zqIK/3s5ToKnB+2ZPo+wqJKRv0/da1cJ8txpCy4dlWxGkoT
	 6AzH8YfiOYxMZG9YTS3HWE3ewxRsgmEZGwl+GwtffYC2BAXWr7/1+7C7QBIgyWq1Ip
	 vy0Rqt30Oo3SQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Alex Elder <elder@riscstar.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] net: ipa: fix SMEM state handle leaks in SMP2P init
Date: Tue, 28 Jul 2026 22:40:04 -0400
Message-ID: <20260729024004.1127220-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072133-astonish-sandpaper-1cd4@gregkh>
References: <2026072133-astonish-sandpaper-1cd4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoxiang Li <haoxiang_li2024@163.com>

[ Upstream commit 96ca1e658ae459276292bd6d971ab5d8c7e0379a ]

ipa_smp2p_init() acquires two Qualcomm SMEM state handles with
qcom_smem_state_get(). However, neither the init error paths
nor ipa_smp2p_exit() release them.

Release both handles with qcom_smem_state_put() in the init
error paths and in ipa_smp2p_exit().

Fixes: 530f9216a953 ("soc: qcom: ipa: AP/modem communications")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Reviewed-by: Alex Elder <elder@riscstar.com>
Link: https://patch.msgid.link/20260624065955.2822765-1-haoxiang_li2024@163.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ kzalloc_obj() context line kept as kzalloc(sizeof(*smp2p), GFP_KERNEL) since ipa_smp2p.c was not yet converted in this tree ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ipa/ipa_smp2p.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
index fcaadd111a8a30..0c184f6f91c6f2 100644
--- a/drivers/net/ipa/ipa_smp2p.c
+++ b/drivers/net/ipa/ipa_smp2p.c
@@ -234,19 +234,27 @@ ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
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
 
 	smp2p = kzalloc(sizeof(*smp2p), GFP_KERNEL);
-	if (!smp2p)
-		return -ENOMEM;
+	if (!smp2p) {
+		ret = -ENOMEM;
+		goto err_enabled_state_put;
+	}
 
 	smp2p->ipa = ipa;
 
@@ -291,6 +299,10 @@ ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
 	ipa->smp2p = NULL;
 	mutex_destroy(&smp2p->mutex);
 	kfree(smp2p);
+err_enabled_state_put:
+	qcom_smem_state_put(enabled_state);
+err_valid_state_put:
+	qcom_smem_state_put(valid_state);
 
 	return ret;
 }
@@ -307,6 +319,8 @@ void ipa_smp2p_exit(struct ipa *ipa)
 	ipa_smp2p_power_release(ipa);
 	ipa->smp2p = NULL;
 	mutex_destroy(&smp2p->mutex);
+	qcom_smem_state_put(smp2p->enabled_state);
+	qcom_smem_state_put(smp2p->valid_state);
 	kfree(smp2p);
 }
 
-- 
2.53.0

