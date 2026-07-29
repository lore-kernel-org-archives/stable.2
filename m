Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899893C1D42
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340311; cv=none; b=cqqIIovgjau1MYcF15xQ+kfl2bx4ZgYqcMgK2kzvt/RlHBj6gyoxe0gFVTpjwdVKvaSoof7gaRmrddxJ5g5AncJIptcZGMEdKTkw2JOpvZFgR+AUprpafMlyaXIBZt84FpA8CiTkJE3PDIqbx11sWKtJHvXZdEmSaiWm8CV8cUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340311; c=relaxed/simple;
	bh=3y5nrMz8xIQ4s5U2m01fcFJ6ByY6ABWNngdHi6N7Do0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NTIW9y5Z4oab5Cf7gf8cXGE3mFgteFNyJY3jQJGk23DIHT82anDEXE0qWCfAdj9mmZr+EFhbGGUZdelX78VxTOb9m3VyHUIJMYgtmKLMsmzluv12T93bQPyvVveaHBMF33MhU5Cs9fzG1arYg8C/9AFmDI045D2S2bG1DO+Xjxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9Frb1RI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9Frb1RI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33EBD1F000E9;
	Wed, 29 Jul 2026 15:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785340310;
	bh=9zFNktncHLqSFqIUlsu3WMDte5q1lBnnq+JyyEme6WY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R9Frb1RIKk4zaIm6B6YcUYQSa+slYeVyNf84v4cuEs06sMQwuv8NDwXcCkYnEyB0p
	 +LJC86YrE6NPICQBgAE8yU1IWnzaGy4q6n3dbfoifGV5Vt04gMDgBdGT0L5jxA/2TZ
	 Dsd7zhVGyAtNtjtjXJYyFpwn5d43BZv7lSu4FzuxCIjjgHrSes5jV/gWXbubOaXaUi
	 pKS9NsWSzWrS5rBQO01o6w4WTwkT3IkJOstJB1eXmbAgp/y2Qz/wcUCo0m4YRU7nm6
	 BaYL1eM6Q8q2tRdQu5lsCGaWmS+pMHsRPdScoaa8g7A/Vphm14ThPrZo5xwcPvQt9A
	 J5W3vcVmW2FFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peng Fan <peng.fan@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] pmdomain: imx: Fix i.MX8MP power notifier
Date: Wed, 29 Jul 2026 11:51:45 -0400
Message-ID: <20260729155145.3488605-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072113-ditzy-crested-16d4@gregkh>
References: <2026072113-ditzy-crested-16d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peng Fan <peng.fan@nxp.com>

[ Upstream commit 72422525f641f68bed6ca3389d29ee3f41fdea33 ]

Using imx8mm_vpu_power_notifier() for i.MX8MP is wrong, as it ungates
the VPU clocks to provide the ADB clock, which is necessary on i.MX8MM,
but on i.MX8MP there is a separate gate (bit 3) for the NoC. So add
imx8mp_vpu_power_notifier() for i.MX8MP.

Fixes: a1a5f15f7f6cb ("soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ulf Hansson <ulfh@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/imx/imx8m-blk-ctrl.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/imx/imx8m-blk-ctrl.c b/drivers/soc/imx/imx8m-blk-ctrl.c
index 29f00ff82c520f..1b87823d835d36 100644
--- a/drivers/soc/imx/imx8m-blk-ctrl.c
+++ b/drivers/soc/imx/imx8m-blk-ctrl.c
@@ -502,9 +502,34 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_vpu_blk_ctl_domain_data[]
 	},
 };
 
+static int imx8mp_vpu_power_notifier(struct notifier_block *nb,
+				     unsigned long action, void *data)
+{
+	struct imx8m_blk_ctrl *bc = container_of(nb, struct imx8m_blk_ctrl,
+						 power_nb);
+
+	if (action == GENPD_NOTIFY_ON) {
+		/*
+		 * On power up we have no software backchannel to the GPC to
+		 * wait for the ADB handshake to happen, so we just delay for a
+		 * bit. On power down the GPC driver waits for the handshake.
+		 */
+
+		udelay(5);
+
+		/* set "fuse" bits to enable the VPUs */
+		regmap_set_bits(bc->regmap, 0x8, 0xffffffff);
+		regmap_set_bits(bc->regmap, 0xc, 0xffffffff);
+		regmap_set_bits(bc->regmap, 0x10, 0xffffffff);
+		regmap_set_bits(bc->regmap, 0x14, 0xffffffff);
+	}
+
+	return NOTIFY_OK;
+}
+
 static const struct imx8m_blk_ctrl_data imx8mp_vpu_blk_ctl_dev_data = {
 	.max_reg = 0x18,
-	.power_notifier_fn = imx8mm_vpu_power_notifier,
+	.power_notifier_fn = imx8mp_vpu_power_notifier,
 	.domains = imx8mp_vpu_blk_ctl_domain_data,
 	.num_domains = ARRAY_SIZE(imx8mp_vpu_blk_ctl_domain_data),
 };
-- 
2.53.0

