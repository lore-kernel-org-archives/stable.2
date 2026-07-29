Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5902C15A0
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 03:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785295652; cv=none; b=ju+L6uc8FL1l6y1YaTmOAK996k3EtMP8i0Ujk3LwajKAyEhbeqUdnQUNO0Q7/I665R7xgaOTis3LZi8kab7sV71SCQDhXjHev95Lz4h+G1qJS57Ez3LBWIk4HsR1iTVt/PiSxmtVkm7YhJHsUylqNN6Kgcec8TYc25i9wEaBLFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785295652; c=relaxed/simple;
	bh=/AAGFtcS65JO1KLQ4eSHGQRwvGUZ3/p3Y2LicXh7gC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cddLfrAcjsOwf4omINESQJ52TkermMNaWzbDhIcEPSZ+FAADRnVmwhVAGgtt++Pm1Qvyk537KwaCgmBRsPSB07YucipuDqzjD59uKlNSCA/f86XtvQM1IJ8hZTUVlU+UaYaNCc8quqMFMC6H3aQoyoypDq5hwU7nG0ejCiJO1dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMEhcmXp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMEhcmXp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65AE61F000E9;
	Wed, 29 Jul 2026 03:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785295651;
	bh=uAPYz8rk1WoAxE+iJ3+WqIe63P+VPX17ToSs0rnqNx8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nMEhcmXp3GdyAZ2s+WXyELoSeoA955xmJAe/YUOsy55uTDSmwW6RIOJwWofPkQZLU
	 P0xYMchmE0wFDNU+iie07bDgije9ixpgmjx1pNjTtVSGyPFbi+U5oC3PVv69PxRf00
	 UepJk/I9WgA8ztODaUf0XFmS6RaZvUjHQuRfxramOIH0u21frZg6syGBCVpezHeNcr
	 NEuSfWaGItgP3WJWY0frVlBh3+4mZOKXzBi/Ec31pEJXdYSAsunU1Kz8toy79+PJTe
	 UAMFZAeKHsQjsXXJgT/8ec7FmQhnlcwEPllkxNdvjOa3EFCtUy/o4JzxxWGE8ZvNPD
	 uwQVSU9rsTSHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Alex Elder <elder@riscstar.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] net: ipa: fix SMEM state handle leaks in SMP2P init
Date: Tue, 28 Jul 2026 23:27:28 -0400
Message-ID: <20260729032728.1258267-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072133-urologist-directed-e696@gregkh>
References: <2026072133-urologist-directed-e696@gregkh>
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
index 5620dc271fac33..358588e82ce018 100644
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

