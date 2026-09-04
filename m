Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE56D4457CF;
	Fri,  4 Sep 2026 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788516216; cv=none; b=N6xawto9geJGeWlvBD477QnwcqtY3tH4FoszASi16q04uSgNhId7QJ54Y8In3591oGGpjxoL9u/qolqv4W4DFsFf9U6C6+6I3CwSFpHYpb+u1i27uulpRyCs/dYAT5+urzCYEceUTFsUA3zATemchZr6sO2738/ekTjcj93WCAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788516216; c=relaxed/simple;
	bh=M1vZqPD+4vQsNANJR+sQ007pkNH6Vmq/4XYKUlLLSSg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=oGLeMmcIM2RxXhoPAK5NAmBg/ttdvTxcyZ+dkGv8a8Q/r760USlbN3/46pkudtFmXnA7N3sTeiRWotK6bwY2UukrNU3oX5+EkEywnyv2OW7IAkf6ETgF3PJ4L7+SVA4lnKpKbo2ZfEafnbtlgIuR+Csp/D7qOUueKOPrpZd58dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=xkxWhQlU; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="xkxWhQlU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1788516208; bh=uoOzDZAWnJsWiO6JD2emY2QKQ6LRtpmLOtpWO9+xJq8=;
	h=From:To:Cc:Subject:Date;
	b=xkxWhQlUYxl0stNa8t4bhRfA09/1sLUKlhXc0kZh8Jvxdz1R5BvVXHlYg+vdolDdW
	 /d6cmwb49w/wVkD0KdwLRCHLTCZT6Fkh/s39HzIiI2sdCNCgIfrnVb1xUjrzJwQyhL
	 waVWSahTxJj0332SVRXFezT04gmzl4/gKy8X4yQU=
Received: from ws006419.mbzu.ae ([5.195.0.150])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 679E487; Fri, 04 Sep 2026 18:01:39 +0800
X-QQ-mid: xmsmtpt1788516099tz2afw6ez
Message-ID: <tencent_B0189529F550458590E3BA614EAB800FBF08@qq.com>
X-QQ-XMAILINFO: MqrcRCpyXC2G804zZZefQ1CweJmOuOcT296XVGv53lkvPGThFIeOAQvAZexdZT
	 ZF2Q8MdzCBXv+rWpJt9uV6wsp7j1a5NIkhCleh2p/sGxft71k04XZkV+aUnGGLQkfZUbg0YbI2CA
	 D+ROGP0+oxW0aRzbxtMqncStyzmmDh4v1EvaXmuhHyNHpTANKRfFct3JsDMWJrQd+QkuxkE2ujf1
	 NJRvE5dXY20JeH+eGz1qd/sQb3x2X+DVn2fxvMGiuRAkSHKiTZaBXFtV+RA91RKuH891/ZD6Is5U
	 DB4e1cqV95LAVSc1GIQVN5A5brsb8mKiC3hcE2qq/GZ7y+uEGV8Ne0W6QD649yqYsZ82D51ShChC
	 P+GP58j4Kjq9zukp+C6/F/rPQmPP2lSNXsAko1VXHbXUuGk6dP/iEAFIxCfJiZ6dNDRsZMC/xPb9
	 UYEzbbsWQmdRC/Cw84q3YhquUfL+sai+SkzjNJFCvrkMEX6caVJRxaY13NUUh4imNxFNYkpD9Vxl
	 3pjhzLutPE5qjcMf3xMAfqsp3/B6MFBFqSA2cZKZL2ocmiM4nN0h+7WxAqMQp8hS97dWpOrdLyJw
	 4GbljK6gAGTDe7eWr0Fj0+CKJUwn0kXHJwBI+JxR4HluNxAEWHpR3M+IT2IDywExrgk0zp/pBRQs
	 FoVR/yk8GLzVkycEvLziQwoJkfw4CNGnsMrwmQJN7ozD/kTQ7gz0cmbL1CNyJ28SidTlMRn5gHqv
	 fCKCdIf7kcoBpQnQbG5/JLzm6vMmL0tLXmeVG67IsYQrN05MR4V6LhmcjH4BLRBoNbZGzfczAwUg
	 2pVNTp9fle6GE/HXaJ0udOOVuNQzFhQAC9ZKcHuL/buI5wermR1IvMegFmeZnu6ct4yge+3rSAqb
	 Z9hUYpPIr3OdTqRip6dKE87o8jZ2XtjzN5ASjJFmhnGEaWLc9tWEiBW4gmzGox9nArXcQYw0xbBA
	 ALc8sIdQ3H2+EqSDsF7OWXUuLtx9bvROpQ/ecf59uBpMcXv5oA9MLDbT8wPastSOJiXHuZlUqw01
	 tFWfbVQ241n1p3FAKqbhMpw8e784O1VNKMZPg2PA==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Jiawen Liu <1298662399@qq.com>
To: Lukasz Luba <lukasz.luba@arm.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	stable@vger.kernel.org,
	Jiawen Liu <1298662399@qq.com>
Subject: [PATCH v2] memory: exynos5422-dmc: handle clock enable failures
Date: Fri,  4 Sep 2026 14:01:35 +0400
X-OQ-MSGID: <20260904100135.251091-1-1298662399@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return values of clk_prepare_enable() for fout_bpll and
mout_bpll.

If enabling fout_bpll fails, propagate the error. If enabling mout_bpll
fails, disable fout_bpll before returning. This keeps the clock enable
count balanced on probe error paths.

Fixes: 6e7674c3c6df ("memory: Add DMC driver for Exynos5422")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Liu <1298662399@qq.com>
---
Changes in v2:
- Use the full author name in From and Signed-off-by.
- Add Fixes and Cc stable tags.
- Generate the submission with git format-patch.

 drivers/memory/samsung/exynos5422-dmc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
index 788d49c688b1..98c319552583 100644
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -1297,8 +1297,15 @@ static int exynos5_dmc_init_clks(struct exynos5_dmc *dmc)
 	if (ret)
 		return ret;
 
-	clk_prepare_enable(dmc->fout_bpll);
-	clk_prepare_enable(dmc->mout_bpll);
+	ret = clk_prepare_enable(dmc->fout_bpll);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(dmc->mout_bpll);
+	if (ret) {
+		clk_disable_unprepare(dmc->fout_bpll);
+		return ret;
+	}
 
 	/*
 	 * Some bootloaders do not set clock routes correctly.
-- 
2.34.1

