Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BF327F18B
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780311741; cv=none; b=lgDmuhqnliv6oV2VlNndth4cAsozdhdLaDeMKwXZWJgz2tOIEnaS8cwu3bPuosI3tSVlnbY6K8xe9qYe80Gc01IHNxEb3YAutftfJEfzZHYnpP5KTmXquCphz2U4XPA2OouDuZQcKqM7+KU9WC3FmfavqKN+4VpVIivAHV79BoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780311741; c=relaxed/simple;
	bh=dht9jC8AGYORsvh9xj3JCeCV0lJ+aLtstXlWr3BvYTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s85AWpo0uc5bdkF51iWMruMneIRvzWULyI4MM/qLGQMX+uJOqTi0hY58/fYtKiIBc4sSXLhOla28Vw0JfPvyGd6Bh3N17KfWaN/lHjEaYq2JoP6mcsuE4N2VhDcAOppoOMlVXDh3tChXb/mU7O4TrSQaqUirDQurd0KHwjuoyCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+TfLTV5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+TfLTV5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA341F00893;
	Mon,  1 Jun 2026 11:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780311740;
	bh=kMKUMo4CXOTfMGg9F5UbhppyLRfu5916qOMmGvrYpDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l+TfLTV53/adeE1Y521UMunYrPqvmeD0zowYj5pfVw+MYuSRCJrYc/ST6LdzuE+MN
	 ++nfX5JXpGMrD0R6uqlWT6C6KN+u63zbviaKTWSVpBtfh6rn4ak3apl6NGtxdbRDJ0
	 lFyLljGCm++bU0JhN4VkCjq/1efnkHEIjXCdFSX0LEeJK/xPYR2F6UAQhioN1F+cgx
	 AOtoWcTHWVuI9aAnumOzYdPy81+lYdlBjtEnOtl8oubTvNPkCSb44G3Lek2nrWAUQA
	 aMiJQC7eMW3XhjGyFi+Ek4drPimsloDSLQ2CgYuxMcE0lyuoj+V3gnne9nOcJkOp0g
	 Gm4JOehRqLZgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wayne Chang <waynec@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] phy: tegra: xusb: Disable trk clk when not in use
Date: Mon,  1 Jun 2026 07:02:17 -0400
Message-ID: <20260601110218.439979-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052823-reemerge-wick-01cb@gregkh>
References: <2026052823-reemerge-wick-01cb@gregkh>
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
index e1c8ce06bf5a0..559224f9d0cd9 100644
--- a/drivers/phy/tegra/xusb-tegra186.c
+++ b/drivers/phy/tegra/xusb-tegra186.c
@@ -612,6 +612,10 @@ static void tegra186_utmi_bias_pad_power_on(struct tegra_xusb_padctl *padctl)
 	value &= ~USB2_PD_TRK;
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
 
+	udelay(100);
+
+	clk_disable_unprepare(priv->usb2_trk_clk);
+
 	mutex_unlock(&padctl->lock);
 }
 
@@ -636,8 +640,6 @@ static void tegra186_utmi_bias_pad_power_off(struct tegra_xusb_padctl *padctl)
 	value |= USB2_PD_TRK;
 	padctl_writel(padctl, value, XUSB_PADCTL_USB2_BIAS_PAD_CTL1);
 
-	clk_disable_unprepare(priv->usb2_trk_clk);
-
 	mutex_unlock(&padctl->lock);
 }
 
-- 
2.53.0

