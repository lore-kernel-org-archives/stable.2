Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5652EBDFA
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562974; cv=none; b=bwC1sLzhOxwEPb/M4a6zSsRFsCk0A5X6VkNRQclIPnYMIIo7lGs1aH62NoXTV0fOTAnRsPGy53Wmim0gyfBVu06qcqTi6OayGg5WyFRXHH+2TH1UCqfgHqTvZ/8EEwYGwwRyOSfxkyZK4k3reBCwTbHOnCIQHxVsU7/T6UfHn+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562974; c=relaxed/simple;
	bh=g8TZ/eojoXdjcVlb0j+LBA5w5Yw3jUIBTBD03KOFeRs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=H1XgCUJ5waxSwP1qa3tuYsBGmTV2o1QhDRd7ZeLR4Mizut+s+lPfZA8a9H8Q1ZzUs8ZDEeKNOgQq1GZfETpSuyKItf8x7WqwjBp6wJ5JB2ATfdX9IcG5yS7HezGFtRlwx5uXHnkoZQ5ncI9FdwPm0ZJmYxEeHzS7wxZLeRvxzXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RiPf/zk3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RiPf/zk3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3431F000E9;
	Mon, 20 Jul 2026 15:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784562973;
	bh=lNP/ScfmZN2/MJO63I5xEQWgd2HOSvtf6PvR0jNXziY=;
	h=Subject:To:Cc:From:Date;
	b=RiPf/zk3aqMI1PqtSaEsvrkBalB9zZ5nI/RV5d/FCDq8R6ukVs0Pf13t+iX2f/YHF
	 /GPsBvoyHHy02LvL+9DlXgpOeUfAW5xBc9t3rvi82633sogUghhPVuhm7ZvSsH2mpR
	 VWNi086JfC9oEQXZnplyHSOnW7L3KOPalxFTnauE=
Subject: FAILED: patch "[PATCH] net: ixp4xx_hss: fix duplicate HDLC netdev allocation" failed to apply to 5.15-stable tree
To: haoxiang_li2024@163.com,kuba@kernel.org,linusw@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:52:05 +0200
Message-ID: <2026072005-audition-moonshine-c2fe@gregkh>
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
git cherry-pick -x db818b0e8af7bac16860116a19c341a63d6677b4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072005-audition-moonshine-c2fe@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From db818b0e8af7bac16860116a19c341a63d6677b4 Mon Sep 17 00:00:00 2001
From: Haoxiang Li <haoxiang_li2024@163.com>
Date: Mon, 22 Jun 2026 12:30:15 +0800
Subject: [PATCH] net: ixp4xx_hss: fix duplicate HDLC netdev allocation

ixp4xx_hss_probe() allocates two HDLC netdevs. The first one is stored
in ndev, initialized, and registered with register_hdlc_device(). The
second one is stored in port->netdev and later used by the remove path
for unregister_hdlc_device() and free_netdev().

This means that the registered netdev is not the same object that is
unregistered and freed on remove. It also leaks the first allocation if
the second alloc_hdlcdev() call fails, and the first allocation is not
checked before ndev is used.

Older code allocated the HDLC netdev only once and stored the same object
in both the local variable and port->netdev. The buggy conversion split
this into two alloc_hdlcdev() calls. A later rename changed the local
variable name to ndev, but the underlying mismatch remained.

Fix this by allocating the HDLC netdev only once and assigning the same
object to port->netdev.

Fixes: 99ebe65eb9c0 ("net: ixp4xx_hss: move out assignment in if condition")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Link: https://patch.msgid.link/20260622043015.643637-1-haoxiang_li2024@163.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/wan/ixp4xx_hss.c b/drivers/net/wan/ixp4xx_hss.c
index 720c5dc889ea..7f4645ff90aa 100644
--- a/drivers/net/wan/ixp4xx_hss.c
+++ b/drivers/net/wan/ixp4xx_hss.c
@@ -1487,11 +1487,11 @@ static int ixp4xx_hss_probe(struct platform_device *pdev)
 				     "unable to get CLK internal GPIO\n");
 
 	ndev = alloc_hdlcdev(port);
-	port->netdev = alloc_hdlcdev(port);
-	if (!port->netdev) {
+	if (!ndev) {
 		err = -ENOMEM;
 		goto err_plat;
 	}
+	port->netdev = ndev;
 
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 	hdlc = dev_to_hdlc(ndev);

