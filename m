Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FBF209F43
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 03:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785295224; cv=none; b=nFh8XxMaJpJ1Wd2ARWixd1u8IXzKYHbfpvxxn7xg4qxOeISAKLAtaJBmDiWeuvi9H4mOSg1Y9OGE3FsSdVYR9uVmiUG7o/iqOwHtYPKXGCTbShBxPrp4tvCnqGGVueppgoSFS6hHdv6Me1jiH8AOtges/f9pUNHau7rsf4rjAeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785295224; c=relaxed/simple;
	bh=Sh73miKYB6uYbxoBDAbeOehREZPwxWoWuKi9QRU7fXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxF3QKdcd7/AiIgbEcDZKSdV1NOgc0BOMFyZm79m/R1oJZNellgUu7HqpoDMT+muMWTw0MYTuvSmup38AnJKqlsrB6baWZ+5i2q+0J7/a387mgNUXMU+L3R77GQT5nZSfHzhDXR9hSUEGwUv2N1P6v6btcM7AShxU45DRwvtxj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxJjkXti; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxJjkXti"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FDB1F00A3A;
	Wed, 29 Jul 2026 03:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785295222;
	bh=Xntsj1reXEcDjAlqPx5ROKdUKmE5ZaNGEF7cvxchLAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fxJjkXtiHfLKSGN1/7c5WQZvmb6DG/Xu5zkL86GCLczIa94angxGE0gXAlZJt7ibX
	 p8vXBoXkndhk4Hjd31xbglchOXDTJyg/MAJnP1DjbIqAc0izBCzdSBZoy4q5d6HiiB
	 lE6CXYiZy4Ntp2Ai3+F3U/yPv2vjP+sqS0L4ZI6+mOZHhwsBue9HLA9ddsypi2aiWw
	 x18pIAGTFQUN4e/VEW1Jbdt2xjm0RsbbqiwY9LkRFwPByu96KkahkqLflBt5k/+5Bb
	 Lqs05EGy1bfIRhX9UYljlxpDCF4faEMdlLRYGmOVQrUS8dsG3+rb9bEXvym+YNDcKS
	 y5QzaxdVP8wXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Alex Elder <elder@riscstar.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] net: ipa: fix SMEM state handle leaks in SMP2P init
Date: Tue, 28 Jul 2026 23:20:20 -0400
Message-ID: <20260729032020.1223984-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072133-carload-confess-3274@gregkh>
References: <2026072133-carload-confess-3274@gregkh>
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
index cbf3d4761ce357..225d952c01af81 100644
--- a/drivers/net/ipa/ipa_smp2p.c
+++ b/drivers/net/ipa/ipa_smp2p.c
@@ -233,19 +233,27 @@ int ipa_smp2p_init(struct ipa *ipa, bool modem_init)
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
 
@@ -290,6 +298,10 @@ int ipa_smp2p_init(struct ipa *ipa, bool modem_init)
 	ipa->smp2p = NULL;
 	mutex_destroy(&smp2p->mutex);
 	kfree(smp2p);
+err_enabled_state_put:
+	qcom_smem_state_put(enabled_state);
+err_valid_state_put:
+	qcom_smem_state_put(valid_state);
 
 	return ret;
 }
@@ -306,6 +318,8 @@ void ipa_smp2p_exit(struct ipa *ipa)
 	ipa_smp2p_power_release(ipa);
 	ipa->smp2p = NULL;
 	mutex_destroy(&smp2p->mutex);
+	qcom_smem_state_put(smp2p->enabled_state);
+	qcom_smem_state_put(smp2p->valid_state);
 	kfree(smp2p);
 }
 
-- 
2.53.0

