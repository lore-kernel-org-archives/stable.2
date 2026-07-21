Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EFC4302F1
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625874; cv=none; b=P2GEQKs2N4vq3pKQdlXrZezW+qAnXDfnS+l7pC61Krn7P08YG3nziAhJ4ntBs4iV8Q7GBKKj5tCGN+4E1zdUrC77vCsq8h27UKI0Cbl905CmQ6fzKli/H2No3Qphofb57YdL8P8YIfVu8yIw40m0IloqSnCzYvw3UODWWF3Kcjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625874; c=relaxed/simple;
	bh=Qf6Vy+hFfVmvrb5m1na8UsH/S0gRW0Q0wO9mEzdBtwI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UVB7Qgf+ZQ1Asg7olMe36EiqS88a7uT1XPxCChfcTqHD6BIcmI5kOjRxi/vR0SAGMlPLmFpH4yCDFbprK0UyKG7KBrm637VSftJBwzagHrKw9vNwuxd3BKpld4xERNYZPSdfmJ5rbi86jEVllMaYsEzW01P+eSql602DG/UTmF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0b1PhXsn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0b1PhXsn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30AAD1F000E9;
	Tue, 21 Jul 2026 09:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784625873;
	bh=gmF7r7KOEugCq4lSmFfaskiLlMhdRHhA8DHD9JTuo0w=;
	h=Subject:To:Cc:From:Date;
	b=0b1PhXsnMkLaWdchTFjt65H6wQrWECDhVxVwg1ZlREwGE3SU58EkM6fVXcYEzQH/8
	 wVMH1JY/U4lAPmv/qrgZw+zmcCXHo9GTDkpID1NGeufvyu9MwJJHRvKcKohnm4za/w
	 OKAbJdcWHTL8p8COvO7nv5t0fHtACTjNqX2SYO+k=
Subject: FAILED: patch "[PATCH] pmdomain: imx: Fix i.MX8MP power notifier" failed to apply to 6.1-stable tree
To: peng.fan@nxp.com,Frank.Li@nxp.com,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 21 Jul 2026 11:23:13 +0200
Message-ID: <2026072113-ditzy-crested-16d4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 72422525f641f68bed6ca3389d29ee3f41fdea33
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072113-ditzy-crested-16d4@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 72422525f641f68bed6ca3389d29ee3f41fdea33 Mon Sep 17 00:00:00 2001
From: Peng Fan <peng.fan@nxp.com>
Date: Wed, 10 Jun 2026 22:39:10 +0800
Subject: [PATCH] pmdomain: imx: Fix i.MX8MP power notifier

Using imx8mm_vpu_power_notifier() for i.MX8MP is wrong, as it ungates
the VPU clocks to provide the ADB clock, which is necessary on i.MX8MM,
but on i.MX8MP there is a separate gate (bit 3) for the NoC. So add
imx8mp_vpu_power_notifier() for i.MX8MP.

Fixes: a1a5f15f7f6cb ("soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl")
Cc: stable@vger.kernel.org
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Ulf Hansson <ulfh@kernel.org>

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index 19e992d2ee3b..e13a47eeed75 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -514,9 +514,34 @@ static const struct imx8m_blk_ctrl_domain_data imx8mp_vpu_blk_ctl_domain_data[]
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

