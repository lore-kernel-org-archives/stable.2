Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770D73090D5
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780311067; cv=none; b=greKhTnr3+vgWQov+1O+oatLeDlWdmjF6uuU5yuf9HEPZRLLhSFV3TwHfOHIIWCN8MSWFe5YuKSVQdUNdMFuUYQdFALvL4Ns8yhjgS6nyAgzriYcGp8mQiv1WAzREm1V16HiwdbNdL/HNx22ugXJmWxin+3evX87dUVja7cNVeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780311067; c=relaxed/simple;
	bh=TDgQeZMwUYAuJ4kTDek61tTRDbiyNEkKCS+zlA6auRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Al9cljlyOIOf7iyE/moqikYrELIeiKrB8t8c0LUbduFCbmJiPSTDPePrSSLpwFrgUTza7tbEXyYj0MBXGPwNE0fbHecsIVXq82wnRFjJwToj6lzjFlQkUP5j1SCfNCQMIzbvzYtC0hKlRLeoT8KVcNL2APL79T2hlOQdmLAYhOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOzb8+p+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOzb8+p+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906771F00893;
	Mon,  1 Jun 2026 10:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780311066;
	bh=SLrOdKOCeCbU9WdLXn5LeVz/2GBiP8XqN7Lad8dnYzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JOzb8+p+tjSqkUw+PSiQ+XWI++Nxl4xX73cpcWf+9scC5kaJpP9HuDiWHOqJ1Uf6q
	 0QsLYQKdViz7zRIiv2Q1nMnewqfEyskve37fBHsuX+UoE/udLqsAWz5vGfNJhm7BPV
	 p/7E7rdwYgE+ZoQKTEtJkAX4bQq87GYo28Qy490v39J8UgC+BZz3TWBG1q1p05gPRb
	 tyLk0jWzPLi9Iw2cJCbWI24rJp7cLHNwBga7TASJmnpleY2KPS90zQ2pRC3xUA9w/u
	 N4mIG1YvW+2P/z4GoJtzAnDE7XrxS1ypNjWKSLkvbKDrQw/dH0kHTkTMfMHaXYEziE
	 lVtio7eZw+tXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wayne Chang <waynec@nvidia.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] phy: tegra: xusb: Disable trk clk when not in use
Date: Mon,  1 Jun 2026 06:51:02 -0400
Message-ID: <20260601105103.376449-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052822-poking-retrace-342b@gregkh>
References: <2026052822-poking-retrace-342b@gregkh>
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
index b36c1e954f318..b778bdeeee59d 100644
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

