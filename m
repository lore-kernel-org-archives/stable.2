Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B3E27EFF7
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 11:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780312093; cv=none; b=IMjpTDcaQXAMno4Rap49jt7H10nKzKxYgBfDOfpaP0+RNBWAAvKD1E8ksKJETv4Zsf78JAINraDCZ/EXZKP47SMaBHYRJj/6uqG0lOqy1pBDWf4lavObuAuL4RLhE3QCvGm6uOMY0Y4WUbAyNL6ei8MFaEBtdawFDsRLkx1crHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780312093; c=relaxed/simple;
	bh=wb6x5xJ+MtPnFEkwZq0O/S4ItxxkgyDNMhbcrOZNLeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NV0aDg8r5em+PcOv2NcHI75Vock5crDisoiXmeKTcoL3pQ2eDXg+Jx6TeX61Z76LJepDQAlIHW1LdnEJ2InfzJ8QVSZmFM45YFgyAnYTPfgUo6JrkH1Z7t255x4uL+jWLuoX7QIzHZWq8o9ZkeMrTG7r3CIj7O6AZvub0Nzi4Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuVijr7w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuVijr7w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA5441F00893;
	Mon,  1 Jun 2026 11:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780312091;
	bh=xc+EO0W5+UL/K7sdNBf7Y63OihmRLDv8IvYLsAsAJ4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YuVijr7wnKci/vhjF/fYsscloQ8jpR9/EQrcSpB/hkj15pnyC7+WEqBeelqvidjac
	 rq9TvwtIjh6P5JmIo6EDMw31pEXFaGacODQ7nVig6IQmBKjNL0vjrQ6rdrptKv/8SY
	 L2gPM68HkuYSgBnGlD9fNZJTvuf1mecqYJP8ekGLVheailUwij3s07ODSTtoixifu7
	 eOz0iDCvRrTdtRQHNmmJ9CfpW6bdnlk22Lw1v6b8nb3/x32zh4mJG0UV3at3K3rXSm
	 zMyU9lrj3i6+rRn1hkdtiKcIMHSrj2Ia79zgI10YrUs4RbnD0KFl0L25SUUUYUQYx5
	 FpyJxFqS4swxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wayne Chang <waynec@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] phy: tegra: xusb: Disable trk clk when not in use
Date: Mon,  1 Jun 2026 07:08:08 -0400
Message-ID: <20260601110809.450763-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052824-womankind-colonize-b053@gregkh>
References: <2026052824-womankind-colonize-b053@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wayne Chang <waynec@nvidia.com>

[ Upstream commit 71d9e899584e11bbd7eaf9934a619c69a15060d8 ]

Pad tracking is a one-time calibration for Tegra186 and Tegra194.
Clk should be disabled after calibration.

Disable clk after calibration.
While at it add 100us delay for HW recording the calibration value.

Signed-off-by: Wayne Chang <waynec@nvidia.com>
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://lore.kernel.org/r/20230111110450.24617-5-jonathanh@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: da110228b54f ("phy: tegra: xusb: Fix per-pad high-speed termination calibration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/tegra/xusb-tegra186.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/tegra/xusb-tegra186.c b/drivers/phy/tegra/xusb-tegra186.c
index d55ba76993340..15d43338cd9f1 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -225,6 +225,10 @@ static void tegra186_utmi_bias_pad_power_on(struct tegra_xusb_padctl *padctl)
 	value &= ~USB2_PD_TRK;
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
 
+	udelay(100);
+
+	clk_disable_unprepare(priv->usb2_trk_clk);
+
 	mutex_unlock(&padctl->lock);
 }
 
@@ -249,8 +253,6 @@ static void tegra186_utmi_bias_pad_power_off(struct tegra_xusb_padctl *padctl)
 	value |= USB2_PD_TRK;
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
 
-	clk_disable_unprepare(priv->usb2_trk_clk);
-
 	mutex_unlock(&padctl->lock);
 }
 
-- 
2.53.0

