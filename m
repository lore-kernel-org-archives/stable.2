Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408782BDC23
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 03:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785296150; cv=none; b=qc9aYCtHpO8Xwcdhl/jJMu1413dwrU99H7aFTOtdm1g9XUHa2+rPI/0UlkjkeinGppcObShyWwFl+sCPUApPeLCJa5d8LQO9r+ymb+dxlgQjuWMWcHV6d2JaTRLf/TczQENe7mnAjWdQQ9wyg2erV0xK2ucBYwEIqZnxaLRdakk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785296150; c=relaxed/simple;
	bh=hv1BbaK9NYnr3/8WS8iJT3Sqa7QMm0v4gauUj/giG/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iZkvZNhaExXFadCsgECWsZWm/X0njLDLQ+oF5UvXHn9Zrf56bUIJfQLGMf2CA7jlCo5bfaW4+u4/KdkDqzIU8jjTtGlEi0S9HUWmNlIGoMtNWF8B4KgXC6ELpAa4FvxP8YDdeN8LlorhQzZlvWogCkUhMYvMcTVloT97APM/bfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpklrB4E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpklrB4E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DBE61F000E9;
	Wed, 29 Jul 2026 03:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785296148;
	bh=+7Go37gtU98cFLZaflYEpxWrUw0sh+lHQZKjYfL3U8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WpklrB4EIRd4CX1LpvERxygGDlMQLMPTrJktxp6x9NhahcdSTW1Q2TuJumZfkHX3S
	 gkBv52nmnlSxTEhi1PiZN9GfttAmM8j4uTqFbwslWBk7g3kcdQBKBURRlPPWxapN+R
	 fFRjM9srWNdEkMBTK2xSywTP39176EQ8awxt7/XzsgZzJ9dPGxDixpQorWsALD0RBn
	 OjQanAhavtAyF5IMZoaSY8/03IxGmooJOQNQjTYiQLOZdYD0hWpsj1HNlau1XXQnth
	 4om+NMLja45nl7LMsb5p8raSA9JMpqrkM4j8CUVijIixE/dSi/XjH/ATG27zDFhVT8
	 VzCZbZtWAXyeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Alex Elder <elder@riscstar.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] net: ipa: fix SMEM state handle leaks in SMP2P init
Date: Tue, 28 Jul 2026 23:35:45 -0400
Message-ID: <20260729033545.1286767-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072133-buffalo-cortex-74ca@gregkh>
References: <2026072133-buffalo-cortex-74ca@gregkh>
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
index 2112336120391c..5030e23df1eed4 100644
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

