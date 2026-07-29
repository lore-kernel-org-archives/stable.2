Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E02486E74
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333203; cv=none; b=nzTVxC3AIuqMYmcP3jvQaJzQqXQrHvucyBx590XWjq5/iubK2XIKk+5lJ76zZCSJkR7cHPYnyKHCucvZTGQiidrA70pdTExUUbMAcI8bGkNkqeN+rKl8KSRlO5XmNurKP5XmJl4va0Tuf+1gAKv/9uQQOFD3lEDUnmJvOpTQtZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333203; c=relaxed/simple;
	bh=uDJ+08cuSCaS1YWSE3x8VcHQS1BlGZH1vuNimY7AjpM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qd7267/8corRZIbk3WVn035k+h4ZlthCket5eEX5mafA5wreQaxd49sL4DqAbciQKJg7QaqkaIeYsT2YkK/ySui2GyMXj4L2gCAHvR79tSn/6RiYjvoPXCmulbGrjGqNUveYuodq57s3ZrssjnL0NnCrs+wvvKJ/6Ttx4is73ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jTBBnoYo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jTBBnoYo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8762E1F000E9;
	Wed, 29 Jul 2026 13:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785333198;
	bh=YCjePWFLpbvwfJ+9KhwlsrttaB8k5Vm7KXwKgw7gp0k=;
	h=Subject:To:Cc:From:Date;
	b=jTBBnoYo2S3iJC7m9HG22gDiRq4qwKqZ80eHdCFLGZ5B/2w7a4fDiuPb52AhlqdkY
	 ka/H4N05AAdF41DFOW9KmVoLKnzHLXS1IevZeXdqna94uKR+DbHNMsrfWQNrCdFN/0
	 dzWqUDje2CS0tWxBdJBvYCQKNRr7ZsIvrNJDknBY=
Subject: FAILED: patch "[PATCH] net: pcs: xpcs: fix SGMII state reading" failed to apply to 6.12-stable tree
To: coiaprant@gmail.com,jiawenwu@trustnetic.com,kuba@kernel.org,maxime.chevallier@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:53:04 +0200
Message-ID: <2026072904-shallow-icing-2a9f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x def9a4745e105145133e442dd8a1c126caf0f553
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072904-shallow-icing-2a9f@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From def9a4745e105145133e442dd8a1c126caf0f553 Mon Sep 17 00:00:00 2001
From: Coia Prant <coiaprant@gmail.com>
Date: Fri, 17 Jul 2026 15:43:25 +0800
Subject: [PATCH] net: pcs: xpcs: fix SGMII state reading

Commit 2a22b7ae2fa3 ("net: pcs: xpcs: adapt Wangxun NICs for SGMII mode")
added a path in xpcs_get_state_c37_sgmii() that reads speed/duplex from
BMCR after AN completes. However, BMCR does not reflect the negotiated
result on the hardware where this has been tested:

- On RK3568 (MAC side SGMII), BMCR returns a fixed hardware reset value
- Wangxun engineer Jiawen Wu confirmed that on their side, "BMCR looks
  like it only wants to be return as 0" [0]

The correct information is available in CL37_ANSGM_STS, which contains
the actual link status and negotiated speed/duplex.

This bug was previously masked by phylink core, which overrides the PCS
link state with the PHY state when a PHY is present:

        /* If we have a phy, the "up" state is the union of both the
         * PHY and the MAC
         */
        if (phy)
                link_state.link &= pl->phy_state.link;

Thus, when the link is down, the PHY's link_down state is applied on top
of whatever the PCS reports, hiding the broken PCS state reading path.

Modify xpcs_get_state_c37_sgmii() to:
1. Read link state from CL37_ANSGM_STS
2. If link is up, report speed/duplex from CL37_ANSGM_STS
3. Remove the broken BMCR reading path entirely

Also properly set state->an_complete to reflect the AN completion status,
and clear CL37_ANCMPLT_INTR when link is down to avoid stale state.

[0] https://lore.kernel.org/all/000c01dd1593$2ac0b0f0$804212d0$@trustnetic.com/

Fixes: 2a22b7ae2fa3 ("net: pcs: xpcs: adapt Wangxun NICs for SGMII mode")
Cc: stable@vger.kernel.org
Tested-by: Jiawen Wu <jiawenwu@trustnetic.com>
Signed-off-by: Coia Prant <coiaprant@gmail.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Link: https://patch.msgid.link/20260717074324.3250043-2-coiaprant@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index e69fa2f0a0e8..0337e2bcc012 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1058,6 +1058,7 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 
 	/* Reset link_state */
 	state->link = false;
+	state->an_complete = false;
 	state->speed = SPEED_UNKNOWN;
 	state->duplex = DUPLEX_UNKNOWN;
 	state->pause = 0;
@@ -1069,6 +1070,8 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 	if (ret < 0)
 		return ret;
 
+	state->an_complete = ret & DW_VR_MII_AN_STS_C37_ANCMPLT_INTR;
+
 	if (ret & DW_VR_MII_C37_ANSGM_SP_LNKSTS) {
 		int speed_value;
 
@@ -1086,35 +1089,14 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 			state->duplex = DUPLEX_FULL;
 		else
 			state->duplex = DUPLEX_HALF;
-	} else if (ret == DW_VR_MII_AN_STS_C37_ANCMPLT_INTR) {
-		int speed, duplex;
 
-		state->link = true;
-
-		speed = xpcs_read(xpcs, MDIO_MMD_VEND2, MII_BMCR);
-		if (speed < 0)
-			return speed;
-
-		speed &= BMCR_SPEED100 | BMCR_SPEED1000;
-		if (speed == BMCR_SPEED1000)
-			state->speed = SPEED_1000;
-		else if (speed == BMCR_SPEED100)
-			state->speed = SPEED_100;
-		else if (speed == 0)
-			state->speed = SPEED_10;
-
-		duplex = xpcs_read(xpcs, MDIO_MMD_VEND2, MII_ADVERTISE);
-		if (duplex < 0)
-			return duplex;
-
-		if (duplex & ADVERTISE_1000XFULL)
-			state->duplex = DUPLEX_FULL;
-		else if (duplex & ADVERTISE_1000XHALF)
-			state->duplex = DUPLEX_HALF;
-
-		xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
+		return 0;
 	}
 
+	/* Clear AN complete status or interrupt */
+	if (state->an_complete)
+		xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
+
 	return 0;
 }
 

