Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84512C031E
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559613; cv=none; b=XAwCvhxcXurMRKANdQdmgQOFYpLvHypHoTJF5N4KrP7m0xGHWOcumyGL5bpaYJWh2Tn9PgmkL4PIHG4jloUbFypCBRgU0F0vcRpirQtWaVub3K4GW0qYrN1FXVDeMC4oWbvMD+DwGxVcSA4/x726ag9eClUXv1YuneWkXGXD2fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559613; c=relaxed/simple;
	bh=sxwyR1sE9BzPrpBCdf/SpKcCvHBlFu8Dt/Bgg7NSO20=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bsl6QRnZCpyk8hzALRxmmWx+h54sH9YxqjEWC/iZig3BIXNhY35AKvz2UdMR19eaeBhkYvIs6s/gu7UnvSZOJDIiWBD2RF1y6ZKzgdG2rnTYFQtXQ2LTAp6+1LSsu7JcBvOKOlusaVjKltgs4+SvX+tEp6EQIGifST8y7z7/iY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x/+ZA5sF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x/+ZA5sF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165D71F00ACF;
	Mon, 20 Jul 2026 15:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784559612;
	bh=ikp6QVHtvlvZqA9NCtW+J3qSScLlucy8M1xrGE8Iz24=;
	h=Subject:To:Cc:From:Date;
	b=x/+ZA5sFQyJq/JzweVng3IDZNB+/g/mdVkJcV9/45SIJC9XaNYkEnFe3/0jIAfuSF
	 I+d2vxvLAfOJHvcqO5jn03oEA1uOyzGgLH33wlwKU5OJLd1siiWvNDjXH18ltMDQF9
	 iMNJnA6PGSm54WsHwbWmMk27n0N3hx9LbRl3hDrw=
Subject: FAILED: patch "[PATCH] mtd: spi-nor: swp: Improve locking user experience" failed to apply to 5.15-stable tree
To: miquel.raynal@bootlin.com,mwalle@kernel.org,pratyush@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:00:03 +0200
Message-ID: <2026072003-rocking-alkaline-274e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e1d456b26bf23e30db305a6184e8abd9ab68bbf2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072003-rocking-alkaline-274e@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e1d456b26bf23e30db305a6184e8abd9ab68bbf2 Mon Sep 17 00:00:00 2001
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Tue, 26 May 2026 16:56:26 +0200
Subject: [PATCH] mtd: spi-nor: swp: Improve locking user experience

In the case of the first block being locked (or the few first blocks),
if the user want to fully unlock the device it has two possibilities:
- either it asks to unlock the entire device, and this works;
- or it asks to unlock just the block(s) that are currently locked,
  which fails.

It fails because the conditions "can_be_top" and "can_be_bottom" are
true. Indeed, in this case, we unlock everything, so the TB bit does not
matter. However in the current implementation, use_top would be true (as
this is the favourite option) and lock_len, which in practice should be
reduced down to 0, is set to "nor->params->size - (ofs + len)" which is
a positive number. This is wrong.

An easy way is to simply add an extra condition. In the unlock() path,
if we can achieve the same result from both sides, it means we unlock
everything and lock_len must simply be 0. A comment is added to clarify
that logic.

Fixes: 3dd8012a8eeb ("mtd: spi-nor: add TB (Top/Bottom) protect support")
Cc: stable@kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>

diff --git a/drivers/mtd/spi-nor/swp.c b/drivers/mtd/spi-nor/swp.c
index e67a81dbb6bf..d5f4bf555cfc 100644
--- a/drivers/mtd/spi-nor/swp.c
+++ b/drivers/mtd/spi-nor/swp.c
@@ -282,8 +282,15 @@ static int spi_nor_sr_unlock(struct spi_nor *nor, loff_t ofs, u64 len)
 	/* Prefer top, if both are valid */
 	use_top = can_be_top;
 
-	/* lock_len: length of region that should remain locked */
-	if (use_top)
+	/*
+	 * lock_len: length of region that should remain locked.
+	 *
+	 * When can_be_top and can_be_bottom booleans are true, both adjacent
+	 * regions are unlocked, thus the entire flash can be unlocked.
+	 */
+	if (can_be_top && can_be_bottom)
+		lock_len = 0;
+	else if (use_top)
 		lock_len = nor->params->size - (ofs + len);
 	else
 		lock_len = ofs;

