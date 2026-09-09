Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F35501F58
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949716; cv=none; b=eigJYuqOPfGQ8bRseEtDkPdK+UOAo4BOrB64OJJawhQECHFxwxvNx1uVPPE7kuPlWqUnS6mqwKKMQi03Op1VbYvxiK71hG2bVmy6u15om54+VdfPOBexEvzZO4E+N68gjHkRkyIf46PSlwHXLtKYlIwSlHeGwpHBy7QcKcGRqyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949716; c=relaxed/simple;
	bh=0SleGGZ13CFOFbO9J0cbYEFaVEfocQgj260Awn0pNG8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=nqrjkU7kI8SeyB0lgDU0RTalhsvp2JIkgQVktvDgKNWeLnFncl/6TLtyesmgfCb+yqvnbsg7FV2+OrR1ywU3Tshe95jcK0Lo0OjsIxj/lpg3TrDtCTsK0gjxbZE1hfLwqx90bWMPhJ1ZJh4zoCqvi1RNOhPTKg00n3t3IRIE4qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tBaloAYP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tBaloAYP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42581F00A3A;
	Wed,  9 Sep 2026 10:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788949714;
	bh=kiZKfJpcKhzfBw9OynkSU9ZdDk7N17PGC0lD6ZR/N+g=;
	h=Subject:To:Cc:From:Date;
	b=tBaloAYPIy46orDrB+pFRirVNPTtQD26Kc/VdEWZHSS5MWzasmksWjp3me3a6Gl18
	 NOIUxxllYeCgKamGjfKdC/p1fjhdXdaywGuuVygz9uHCibbI8hbsl+GsiBQNjMqe+m
	 o4bQMTZwo/lAbV7QlUsr9RBS0ECoxHvY0IgVM4c0=
Subject: FAILED: patch "[PATCH] ASoC: tegra: Sort ADMAIF register defaults" failed to apply to 6.6-stable tree
To: jonathanh@nvidia.com,broonie@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:17:51 +0200
Message-ID: <2026090951-framing-embark-144b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 18d48bfd1bc178da7cfc7a1be3eaa1c8cb10f05c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090951-framing-embark-144b@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 18d48bfd1bc178da7cfc7a1be3eaa1c8cb10f05c Mon Sep 17 00:00:00 2001
From: Jon Hunter <jonathanh@nvidia.com>
Date: Fri, 21 Aug 2026 16:37:33 +0100
Subject: [PATCH] ASoC: tegra: Sort ADMAIF register defaults

Commit 4b05ccb17f92 ("regcache: Sort the local copy of an unsorted
reg_defaults array") exposed an issue in the Tegra ADMAIF driver and now
the following warning is observed:

 tegra210-admaif 290f000.admaif: Driver needs fixing: Unsorted
  reg_defaults, sorting the copy

This warning occurs because register defaults in the structures
tegra186_admaif_reg_defaults and tegra264_admaif_reg_defaults are not
specified in ascending order which is required by regmap. Fix this by
sorting the register defaults according to their address. Note that in
order to do this it is necessary to split the macro ADMAIF_REG_DEFAULTS
into separate RX and TX macros to the RX and TX registers.

Fixes: f74028e159bb ("ASoC: tegra: Add Tegra210 based ADMAIF driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
Link: https://patch.msgid.link/20260821153734.158426-4-jonathanh@nvidia.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/tegra/tegra210_admaif.c b/sound/soc/tegra/tegra210_admaif.c
index 7299c6bfcf15..87e898cc35e4 100644
--- a/sound/soc/tegra/tegra210_admaif.c
+++ b/sound/soc/tegra/tegra210_admaif.c
@@ -26,94 +26,162 @@
 
 #define CH_RX_REG(reg, id) CH_REG(admaif->soc_data->rx_base, reg, id)
 
-#define REG_DEFAULTS(id, rx_ctrl, tx_ctrl, tx_base, rx_base, cif_ctrl)	       \
+#define RX_REG_DEFAULTS(id, rx_ctrl, rx_base, cif_ctrl)			       \
 	{ CH_REG(rx_base, TEGRA_ADMAIF_RX_INT_MASK, id), 0x00000001 },	       \
 	{ CH_REG(rx_base, TEGRA_ADMAIF_CH_ACIF_RX_CTRL, id), cif_ctrl },     \
-	{ CH_REG(rx_base, TEGRA_ADMAIF_RX_FIFO_CTRL, id), rx_ctrl },	       \
+	{ CH_REG(rx_base, TEGRA_ADMAIF_RX_FIFO_CTRL, id), rx_ctrl }
+
+#define TX_REG_DEFAULTS(id, tx_ctrl, tx_base, cif_ctrl)			       \
 	{ CH_REG(tx_base, TEGRA_ADMAIF_TX_INT_MASK, id), 0x00000001 },	       \
 	{ CH_REG(tx_base, TEGRA_ADMAIF_CH_ACIF_TX_CTRL, id), cif_ctrl },     \
 	{ CH_REG(tx_base, TEGRA_ADMAIF_TX_FIFO_CTRL, id), tx_ctrl }
 
-#define ADMAIF_REG_DEFAULTS(id, chip)					       \
-	REG_DEFAULTS((id) - 1,						       \
+#define ADMAIF_RX_REG_DEFAULTS(id, chip)				       \
+	RX_REG_DEFAULTS((id) - 1,					       \
 		chip ## _ADMAIF_RX ## id ## _FIFO_CTRL_REG_DEFAULT,	       \
-		chip ## _ADMAIF_TX ## id ## _FIFO_CTRL_REG_DEFAULT,	       \
-		chip ## _ADMAIF_TX_BASE,				       \
 		chip ## _ADMAIF_RX_BASE,				       \
 		chip ## _ADMAIF_CIF_REG_DEFAULT)
 
+#define ADMAIF_TX_REG_DEFAULTS(id, chip)				       \
+	TX_REG_DEFAULTS((id) - 1,					       \
+		chip ## _ADMAIF_TX ## id ## _FIFO_CTRL_REG_DEFAULT,	       \
+		chip ## _ADMAIF_TX_BASE,				       \
+		chip ## _ADMAIF_CIF_REG_DEFAULT)
+
 static const struct reg_default tegra186_admaif_reg_defaults[] = {
-	{(TEGRA_ADMAIF_GLOBAL_CG_0 + TEGRA186_ADMAIF_GLOBAL_BASE), 0x00000003},
-	ADMAIF_REG_DEFAULTS(1, TEGRA186),
-	ADMAIF_REG_DEFAULTS(2, TEGRA186),
-	ADMAIF_REG_DEFAULTS(3, TEGRA186),
-	ADMAIF_REG_DEFAULTS(4, TEGRA186),
-	ADMAIF_REG_DEFAULTS(5, TEGRA186),
-	ADMAIF_REG_DEFAULTS(6, TEGRA186),
-	ADMAIF_REG_DEFAULTS(7, TEGRA186),
-	ADMAIF_REG_DEFAULTS(8, TEGRA186),
-	ADMAIF_REG_DEFAULTS(9, TEGRA186),
-	ADMAIF_REG_DEFAULTS(10, TEGRA186),
-	ADMAIF_REG_DEFAULTS(11, TEGRA186),
-	ADMAIF_REG_DEFAULTS(12, TEGRA186),
-	ADMAIF_REG_DEFAULTS(13, TEGRA186),
-	ADMAIF_REG_DEFAULTS(14, TEGRA186),
-	ADMAIF_REG_DEFAULTS(15, TEGRA186),
-	ADMAIF_REG_DEFAULTS(16, TEGRA186),
-	ADMAIF_REG_DEFAULTS(17, TEGRA186),
-	ADMAIF_REG_DEFAULTS(18, TEGRA186),
-	ADMAIF_REG_DEFAULTS(19, TEGRA186),
-	ADMAIF_REG_DEFAULTS(20, TEGRA186)
+	ADMAIF_RX_REG_DEFAULTS(1, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(2, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(3, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(4, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(5, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(6, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(7, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(8, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(9, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(10, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(11, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(12, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(13, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(14, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(15, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(16, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(17, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(18, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(19, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(20, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(1, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(2, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(3, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(4, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(5, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(6, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(7, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(8, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(9, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(10, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(11, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(12, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(13, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(14, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(15, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(16, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(17, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(18, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(19, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(20, TEGRA186),
+	{(TEGRA_ADMAIF_GLOBAL_CG_0 + TEGRA186_ADMAIF_GLOBAL_BASE), 0x00000003}
 };
 
 static const struct reg_default tegra210_admaif_reg_defaults[] = {
-	{(TEGRA_ADMAIF_GLOBAL_CG_0 + TEGRA210_ADMAIF_GLOBAL_BASE), 0x00000003},
-	ADMAIF_REG_DEFAULTS(1, TEGRA210),
-	ADMAIF_REG_DEFAULTS(2, TEGRA210),
-	ADMAIF_REG_DEFAULTS(3, TEGRA210),
-	ADMAIF_REG_DEFAULTS(4, TEGRA210),
-	ADMAIF_REG_DEFAULTS(5, TEGRA210),
-	ADMAIF_REG_DEFAULTS(6, TEGRA210),
-	ADMAIF_REG_DEFAULTS(7, TEGRA210),
-	ADMAIF_REG_DEFAULTS(8, TEGRA210),
-	ADMAIF_REG_DEFAULTS(9, TEGRA210),
-	ADMAIF_REG_DEFAULTS(10, TEGRA210)
+	ADMAIF_RX_REG_DEFAULTS(1, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(2, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(3, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(4, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(5, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(6, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(7, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(8, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(9, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(10, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(1, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(2, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(3, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(4, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(5, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(6, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(7, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(8, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(9, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(10, TEGRA210),
+	{(TEGRA_ADMAIF_GLOBAL_CG_0 + TEGRA210_ADMAIF_GLOBAL_BASE), 0x00000003}
 };
 
 static const struct reg_default tegra264_admaif_reg_defaults[] = {
-	{(TEGRA_ADMAIF_GLOBAL_CG_0 + TEGRA264_ADMAIF_GLOBAL_BASE), 0x00000003},
-	ADMAIF_REG_DEFAULTS(1, TEGRA264),
-	ADMAIF_REG_DEFAULTS(2, TEGRA264),
-	ADMAIF_REG_DEFAULTS(3, TEGRA264),
-	ADMAIF_REG_DEFAULTS(4, TEGRA264),
-	ADMAIF_REG_DEFAULTS(5, TEGRA264),
-	ADMAIF_REG_DEFAULTS(6, TEGRA264),
-	ADMAIF_REG_DEFAULTS(7, TEGRA264),
-	ADMAIF_REG_DEFAULTS(8, TEGRA264),
-	ADMAIF_REG_DEFAULTS(9, TEGRA264),
-	ADMAIF_REG_DEFAULTS(10, TEGRA264),
-	ADMAIF_REG_DEFAULTS(11, TEGRA264),
-	ADMAIF_REG_DEFAULTS(12, TEGRA264),
-	ADMAIF_REG_DEFAULTS(13, TEGRA264),
-	ADMAIF_REG_DEFAULTS(14, TEGRA264),
-	ADMAIF_REG_DEFAULTS(15, TEGRA264),
-	ADMAIF_REG_DEFAULTS(16, TEGRA264),
-	ADMAIF_REG_DEFAULTS(17, TEGRA264),
-	ADMAIF_REG_DEFAULTS(18, TEGRA264),
-	ADMAIF_REG_DEFAULTS(19, TEGRA264),
-	ADMAIF_REG_DEFAULTS(20, TEGRA264),
-	ADMAIF_REG_DEFAULTS(21, TEGRA264),
-	ADMAIF_REG_DEFAULTS(22, TEGRA264),
-	ADMAIF_REG_DEFAULTS(23, TEGRA264),
-	ADMAIF_REG_DEFAULTS(24, TEGRA264),
-	ADMAIF_REG_DEFAULTS(25, TEGRA264),
-	ADMAIF_REG_DEFAULTS(26, TEGRA264),
-	ADMAIF_REG_DEFAULTS(27, TEGRA264),
-	ADMAIF_REG_DEFAULTS(28, TEGRA264),
-	ADMAIF_REG_DEFAULTS(29, TEGRA264),
-	ADMAIF_REG_DEFAULTS(30, TEGRA264),
-	ADMAIF_REG_DEFAULTS(31, TEGRA264),
-	ADMAIF_REG_DEFAULTS(32, TEGRA264)
+	ADMAIF_RX_REG_DEFAULTS(1, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(2, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(3, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(4, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(5, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(6, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(7, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(8, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(9, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(10, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(11, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(12, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(13, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(14, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(15, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(16, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(17, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(18, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(19, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(20, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(21, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(22, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(23, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(24, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(25, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(26, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(27, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(28, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(29, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(30, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(31, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(32, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(1, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(2, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(3, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(4, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(5, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(6, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(7, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(8, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(9, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(10, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(11, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(12, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(13, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(14, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(15, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(16, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(17, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(18, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(19, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(20, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(21, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(22, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(23, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(24, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(25, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(26, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(27, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(28, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(29, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(30, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(31, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(32, TEGRA264),
+	{(TEGRA_ADMAIF_GLOBAL_CG_0 + TEGRA264_ADMAIF_GLOBAL_BASE), 0x00000003}
 };
 
 static bool tegra_admaif_wr_reg(struct device *dev, unsigned int reg)

