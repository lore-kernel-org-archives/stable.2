Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32F44A2630
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210811; cv=none; b=feHBZ5+Hv88cWQmIpcyMaiGMheTyhF8/HMgsDiPVSVar0xAMo5NzfZS3lLlZjH3ikDhQeVjlQe9Rf2kNbK3YTQ+gMsi/NoxR/2yca3dBV0zH+7EqUEyd8Ei2cTyieHM0JtCui6xoOmyfQGiXDTgfA60qUUbBgjiglV9w4JStBaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210811; c=relaxed/simple;
	bh=F7g699FHFNmON/sU31KiAu2p0YlwzEsijWE/WrhBRs4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CQ/aMExhBzbdhhR2DqKD5mkRt75i3IoY1fZseuNVKb7U04xgXp7QSgUVJ6K8D8ym0LhEc8XFWoF/ia/90dbZFAQkUWL4KnhxfermB7svCIQwR+avcLfQ0MBMY9+IxssLrq87E8rQ01MbxWXYb57Mueene1yq/A0bxJMANuwhcZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1CZWX5Y/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1CZWX5Y/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDA91F00899;
	Mon,  5 Oct 2026 14:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791210805;
	bh=Ebm0vswDpfWpXyAISQCTLmCbaJdyZl0vGZeiIv/tDBg=;
	h=Subject:To:Cc:From:Date;
	b=1CZWX5Y/Ut5dScfb86vM9FKc2lK5KffeKFAQ2PCqqZIuUzuwoiLJ47MDGA4KpdPBl
	 K07CzxSbRIuUovHS7+KYeIa+DIGtlOVkQm6MnKP9jPjtiFkuqMaxHAL+30QYb1oOnz
	 rPx5DcTBSCgmx6ZwbtrtZW7O/KiYZOa163pdVmkU=
Subject: FAILED: patch "[PATCH] mtd: spinand: Enable QE on all dies" failed to apply to 5.15-stable tree
To: han.xu@nxp.com,miquel.raynal@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:33:07 +0200
Message-ID: <2026100507-ventricle-congenial-44f0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 63d6cace2c4a7f36c1cb44f1bb5e0f3ef19e5c7f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100507-ventricle-congenial-44f0@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 63d6cace2c4a7f36c1cb44f1bb5e0f3ef19e5c7f Mon Sep 17 00:00:00 2001
From: Han Xu <han.xu@nxp.com>
Date: Thu, 13 Aug 2026 08:07:24 -0500
Subject: [PATCH] mtd: spinand: Enable QE on all dies
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The QUAD ENABLE (QE) bit is stored in a per-die configuration
register on some SPI-NAND devices. When a device contains multiple
dies, updating the QE bit only on the currently selected die can
leave the remaining dies operating in non-quad mode.
 
Iterate over all targets and update the QE setting on each die
during initialization to ensure consistent quad I/O operation
across the entire device.

Tested on ISSI IS38SMW04G8B.

Fixes: 7529df465248 ("mtd: nand: Add core infrastructure to support SPI NANDs")
Cc: stable@vger.kernel.org
Signed-off-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 8bf9301f25e7..bea352dd82d7 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -281,8 +281,26 @@ static int spinand_init_cfg_cache(struct spinand_device *spinand)
 static int spinand_init_quad_enable(struct spinand_device *spinand,
 				    bool enable)
 {
-	return spinand_upd_cfg(spinand, CFG_QUAD_ENABLE,
-			       enable ? CFG_QUAD_ENABLE : 0);
+	struct nand_device *nand = spinand_to_nand(spinand);
+	unsigned int target;
+	int ret;
+
+	/*
+	 * QE is a per-die setting on some devices. Program each target
+	 * individually when enabling or disabling quad I/O mode.
+	 */
+	for (target = 0; target < nand->memorg.ntargets; target++) {
+		ret = spinand_select_target(spinand, target);
+		if (ret)
+			return ret;
+
+		ret = spinand_upd_cfg(spinand, CFG_QUAD_ENABLE,
+				      enable ? CFG_QUAD_ENABLE : 0);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
 }
 
 static int spinand_ecc_enable(struct spinand_device *spinand,

