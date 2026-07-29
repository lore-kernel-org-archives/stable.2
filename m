Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769DF389E13
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 03:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785297189; cv=none; b=Cs9mlSqSwbaeRgONRvpeD4Q3aw3XrwlnIcJboKwepTo/V4IhgN4AeknndpBI657w//dJr8erFuEHEui9+MCv+tfV0PC9l6LYa5LpwhzELLOyNZrZMk+ZTzMZj3fOkJjAJtLKrf/ECcvoSBRHONW3g38PKVCQFvbVpLDhnkwrwrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785297189; c=relaxed/simple;
	bh=U9XPNW7kHUfTwaIJooXDcp4XrkMrtir8apP6xmYTAB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sCcWwkpiocWHeATgHkbTCx+nk+kb61xserFO9XJShhWPbPWh/yCgJHn237CIWZLscEVSd6xpKsCrY7vCsTg7w0HluqVZLFqAer5ak2rg47WU9kqmUVzZP9wXDv1JSER3bC4ox0RaZdw7ZOL79sbika0yHOO5e3xxHRW1yj0gobw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWajiBL9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWajiBL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BBA1F000E9;
	Wed, 29 Jul 2026 03:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785297188;
	bh=I6/EtvOLSpQq1+Vq0YMme1hphr1BP7JbQgSQ3WI51vA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oWajiBL9gS2GkRWGq4+PrhivFo8kU0e4C9CMRRka4uAJTOS29HLS3MFpkNIO4p7jb
	 cGyLCBLnmXVPSzSWJkVCeqbLc3XPB7jT7/0bQ+n4eb6jRU4Ld3IiMwV/Vx+qPPU+oI
	 RC8ZUMOPEP8qQIkrJGdcHWFHyzVngzrEH6+mZ8AMmQIJ6f9vHDIZsK0FyjzC8WQepB
	 XkDuXAPir0oqdEzqM9riBmTVAi5TVhWEN+ugK2d6EnorRsMdVIZ8msasVuBrJldrb7
	 pC4I1PiRATClwAgwQj8UWGylOLKMnXopVLe2K/8iG4W1qRQcEI9UJoc2/Ysftlkads
	 RPZ7wdWlG2ZcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Alex Elder <elder@riscstar.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] net: ipa: fix SMEM state handle leaks in SMP2P init
Date: Tue, 28 Jul 2026 23:53:05 -0400
Message-ID: <20260729035305.1378970-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072134-prodigal-galley-8431@gregkh>
References: <2026072134-prodigal-galley-8431@gregkh>
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
index a5f7a79a19238c..20758612582b6b 100644
--- a/drivers/net/ipa/ipa_smp2p.c
+++ b/drivers/net/ipa/ipa_smp2p.c
@@ -222,19 +222,27 @@ int ipa_smp2p_init(struct ipa *ipa, bool modem_init)
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
 
@@ -279,6 +287,10 @@ int ipa_smp2p_init(struct ipa *ipa, bool modem_init)
 	ipa->smp2p = NULL;
 	mutex_destroy(&smp2p->mutex);
 	kfree(smp2p);
+err_enabled_state_put:
+	qcom_smem_state_put(enabled_state);
+err_valid_state_put:
+	qcom_smem_state_put(valid_state);
 
 	return ret;
 }
@@ -295,6 +307,8 @@ void ipa_smp2p_exit(struct ipa *ipa)
 	ipa_smp2p_clock_release(ipa);
 	ipa->smp2p = NULL;
 	mutex_destroy(&smp2p->mutex);
+	qcom_smem_state_put(smp2p->enabled_state);
+	qcom_smem_state_put(smp2p->valid_state);
 	kfree(smp2p);
 }
 
-- 
2.53.0

