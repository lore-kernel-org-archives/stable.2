Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00FF2C326D
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791033483; cv=none; b=UcHgVjv3j3ACWX39ZeKk8q8RlBd+xenWXiEU49NXEb+7iD/MiQE4XA0lhoniZmuqTMw+2RYnm/10+BF8JslB9h712vcGsLH1FcDvJzHSpKE6zpWYcKI8Z7sp4XZFioKIzzgnbrz5HZocNBO+RXGZeNGUqSe1JTlXnh5gMRJybZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791033483; c=relaxed/simple;
	bh=KtvoA8pjnAGmaPUMhK9sCjsj/uZvFRXzQm/XztXAAe8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=izn2nSXcYJ1xvMwdkryg4lRp9c+qdY6WNqBotUydntxlIdll/zma1/lJ7j6hkPemREOOkIz8RmN/inKaD/PZzjn8LabZ6EigyUW0fXBfSTXsv0ChlwCuxnQpgdeI3VjZC4QWRHOZfbUnA7VXWkJ4OxelInNspn43vtgEBm/juR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YlK+RdiB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YlK+RdiB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244171F0089B;
	Sat,  3 Oct 2026 13:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791033481;
	bh=Egj1eKNlj0FLKweAoIDOPMmV7aLgwyq4Oi9WSWgyzs4=;
	h=Subject:To:Cc:From:Date;
	b=YlK+RdiBZEiLXOR19J8Sxwz2KUSolT5nk6uOlx7EkvoBtnwe1Rd51E+lEuFGhS6mQ
	 9vWshCJOE339L2TYfl6o+cD+e5wkTphWV9QAwE1gecQIvk3Y2LXYSo07Igcz+3PLo9
	 o7NZPzUXOGF3vKnExRPzBLa48WKGM4oRlcpm8qB4=
Subject: FAILED: patch "[PATCH] net: phy: aquantia: fix system interface type not updated in" failed to apply to 5.15-stable tree
To: bartosz.golaszewski@oss.qualcomm.com,pabeni@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 03 Oct 2026 15:17:47 +0200
Message-ID: <2026100347-subside-retiree-87ef@gregkh>
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
git cherry-pick -x 6e0022b5ae3dc5b833af0fcc1578dc20a1d6bc71
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100347-subside-retiree-87ef@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6e0022b5ae3dc5b833af0fcc1578dc20a1d6bc71 Mon Sep 17 00:00:00 2001
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 17:14:35 +0200
Subject: [PATCH] net: phy: aquantia: fix system interface type not updated in
 forced mode

aqr_gen1_read_status() decodes the MDIO_PHYXS_VEND_IF_STATUS register
to determine which SerDes interface the PHY is currently using on its
system side and stores the result in phydev->interface. phylink relies
on this value to configure the MAC.

The autoneg == AUTONEG_DISABLE check is not correct:
MDIO_PHYXS_VEND_IF_STATUS is set by the PHY firmware based on the
negotiated link speed, not based on whether autoneg was used to reach
it. When the link comes up at 1G in forced mode, the register correctly
reads SGMII, but the early return prevents phydev->interface from being
updated. It stays at whatever value it held before (typically 2500BASE-X
from the initial autoneg run), so phylink configures the MAC for the
wrong interface and the link cannot come up.

Remove the autoneg guard so that the system interface type is always
decoded when the link is up.

Cc: stable@vger.kernel.org
Fixes: 110a2432c520 ("net: phy: aquantia: add downshift support")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Link: https://patch.msgid.link/20260923-qcom-sa8255p-emac-v15-1-e82f33720737@oss.qualcomm.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index e95d391a6dc2..096407bebd52 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -544,7 +544,7 @@ static int aqr_gen1_read_status(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	if (!phydev->link || phydev->autoneg == AUTONEG_DISABLE)
+	if (!phydev->link)
 		return 0;
 
 	/* The status register is not immediately correct on line side link up.
@@ -594,6 +594,9 @@ static int aqr_gen1_read_status(struct phy_device *phydev)
 
 	phydev->interface = aqr_translate_interface(phydev, interface);
 
+	if (phydev->autoneg == AUTONEG_DISABLE)
+		return 0;
+
 	/* Read rate from vendor register */
 	return aqr_gen1_read_rate(phydev);
 }

