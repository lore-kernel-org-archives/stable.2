Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AF949E5CF
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210811; cv=none; b=j5YlaOM3AMHB8ZXMmbRO95g7HXd3ZbR14OAL3dp0K9t7taes8EI/uimpZ5S9ouAULJL27vJDGKYmTz4OnnyXQTp/ddwT5jVpKIGDWVisbHaYpGMDMovCvYxkQNXbXURTPRRfiyj/pNaGS93KHmqV5ytFIVrtCGz2Jv1Q18CZX9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210811; c=relaxed/simple;
	bh=sDL9ohIjafullaETzeVH/NHvfv/1AzFb9Uyv8vurato=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=e9tgwc9IAea7NqSBdsblSIfQOE4cPnObAj/DfNZeBgtcAKc++il5g38EbhOAFvTUKLUazyLA+Cc4TPgEO5YbYzgeI0Yjn71YgE0TiiHMd82KEhavhM82IUk2knFVRKJgLJon0zw+YwynKY1/5jz6YN/hMxI5bCxT1bSOqgbEtXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OZ+pmGqX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OZ+pmGqX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166AA1F00898;
	Mon,  5 Oct 2026 14:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791210802;
	bh=8YXLt2nlg32EIQou8piv9MSE58pPjDczmL7GHIw1vIg=;
	h=Subject:To:Cc:From:Date;
	b=OZ+pmGqXSusNKVp9RMO8aBeYENGOoQJ6/Id6a/PaUtgvY/9BJoNOHOOcw33YgZ9Yk
	 gFz2LnUYfjKB6KGv68iDVawaWkdFUQ8OvjmF9fBP+D2W7ef6tMeFkFb+SBSSbLjcTW
	 5JdnLinbsTvLzJZoNe+Opm6GqpCAbNxVTIdnfufA=
Subject: FAILED: patch "[PATCH] mtd: spinand: Enable QE on all dies" failed to apply to 5.10-stable tree
To: han.xu@nxp.com,miquel.raynal@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:33:07 +0200
Message-ID: <2026100507-that-landed-061a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 63d6cace2c4a7f36c1cb44f1bb5e0f3ef19e5c7f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100507-that-landed-061a@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

