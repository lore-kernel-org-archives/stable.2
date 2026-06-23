Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AE51DD0D4;
	Tue, 23 Jun 2026 03:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782184751; cv=none; b=EPlMk7fQovS+CaYnlMQUXP9NKReMH8B81wMAbnPaX4Cpy0wvtJd5fdzGw2CWp9Eu1loGcsb6wnqpO2ZlyBzhN6CAR1Mwo6BVISnr6bT6i4Vr5UNwyokoWsNqg5gZJsTtnigbJ3TZ+JGcFmDguM6SoFYzg0hk4WbBmOFRgWwAJDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782184751; c=relaxed/simple;
	bh=YllO2QVTAT1SFaMzvpUbzJxA7PweExikM79fzqpVlcg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PCNyIm0aiDmstriAshN9V0QmLoEgZNfy+Hsw+9sLoCppJoU3xeOHxYwQvYi99OVSnhA4JiE5K1ikqlv95jsqULE5rEl/iAZKzS7fGwV1yr7B4vDpWjNxwlEN7yrx4MTYz7r3QYeID2WGVOLbPmtxttWvWezJ/XFBiWrOvlpBofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=OAt6C8kf; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="OAt6C8kf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1B
	uUpZ90jBptaMLID11KjRp832BAUFG617V2AppAcJo=; b=OAt6C8kfv/uuxglvDk
	BvIO7Fmbx9jahvnYLQZKEKxfIlZ+rkXRdKQWc72yd640waGhyDhO8FDyUj1r/01r
	C0dywpy+a1Po1x4gpM6aq8gtc2wbFE36EuAcGVLtvLtMoZFccZ0+NMhyN9zokhTk
	J5Hq1QcXwrKG8bGMwzZV1/XLI=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAnuBcI+zlqJmmCDg--.9919S2;
	Tue, 23 Jun 2026 11:18:34 +0800 (CST)
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
Subject: [PATCH] net: ipa: fix SMEM state handle leaks in SMP2P init
Date: Tue, 23 Jun 2026 11:18:31 +0800
Message-Id: <20260623031831.1788454-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgAnuBcI+zlqJmmCDg--.9919S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF1fGry3Xw4ftF1xGw1kGrg_yoW8XF48pw
	s8CasIkry5AFWIg3ZrCry8WF98u340grs8GrZ8Kas5uay3AF4rJF1kKFyrJay0vFy8CFyD
	Zw13Aa1Duay5ZrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piVT5JUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxgrpWGo5+wpUrQAA3m

ipa_smp2p_init() acquires two Qualcomm SMEM state handles with
qcom_smem_state_get(). However, neither the init error paths
nor ipa_smp2p_exit() release them.

Use devm_qcom_smem_state_get() for both state handles so the
references are released automatically when the platform device
is removed.

Fixes: 530f9216a953 ("soc: qcom: ipa: AP/modem communications")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/net/ipa/ipa_smp2p.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
index 2f0ccdd937cc..d8fd56949082 100644
--- a/drivers/net/ipa/ipa_smp2p.c
+++ b/drivers/net/ipa/ipa_smp2p.c
@@ -228,15 +228,15 @@ ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
 	u32 valid_bit;
 	int ret;
 
-	valid_state = qcom_smem_state_get(dev, "ipa-clock-enabled-valid",
-					  &valid_bit);
+	valid_state = devm_qcom_smem_state_get(dev, "ipa-clock-enabled-valid",
+					       &valid_bit);
 	if (IS_ERR(valid_state))
 		return PTR_ERR(valid_state);
 	if (valid_bit >= 32)		/* BITS_PER_U32 */
 		return -EINVAL;
 
-	enabled_state = qcom_smem_state_get(dev, "ipa-clock-enabled",
-					    &enabled_bit);
+	enabled_state = devm_qcom_smem_state_get(dev, "ipa-clock-enabled",
+						 &enabled_bit);
 	if (IS_ERR(enabled_state))
 		return PTR_ERR(enabled_state);
 	if (enabled_bit >= 32)		/* BITS_PER_U32 */
-- 
2.25.1

