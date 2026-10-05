Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACA34AD4C8
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791217100; cv=none; b=iDVo93s47mWzW4ROCY9NqXqjDl6eoNhqwfysfAH6dttn9qE1yet5B/vmcdjvQ+okZFVrt6SYRz+X3YC8ZCw6nVzF4PBdkOTrOQEg5fDZjOABqgW260CDpnJXwenJ+gVrrZLBmKmrxPWOcatAB97qgRKvcMuh5TWOA7esPK9PGa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791217100; c=relaxed/simple;
	bh=yzSX0IfxHv2O+YMG/+rHqESNfSJDUU9GtXajFMiaIqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ul0OEzf/eBJA8jswNPYXjMmkxU2Hyefa0XrGC2i/xiNJP7vGnp1cKKYlOa1bUsc0oRTdqYH1AKuXHskBi4lN42fUoBg2F7F3jE1rGypsZidvPOxTYx+BIiQ5O4xh5aWsbYLjKr7Fh30VyJKMP6pRHAPf4oadxBnDZFgoVeZJEFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cm7bnImL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cm7bnImL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907A11F000FF;
	Mon,  5 Oct 2026 16:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791217098;
	bh=8bD15CTuKbZDqUmDorNElkPAzJVQhAUoB/NnW4hUrUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cm7bnImLIm0auauWcbsXPoEHQ++wRCDlFxQ0xcHy7UxC4gkqf1ynchssPrO6+5hY8
	 XIjcUyKNkqtyMnUevnZuLj54r1Gp4RMEVGtnxopheD5VWL8IdUkQYm2DdHW0UBEala
	 Ry09Wul+csV9U5pzlDJ/o9EF6XXcjuS17vZEMp7gXqG2G9O/g6OM7Ks93XrbYituKb
	 XDW5hVvuUC9sLz8r0Hykd6KT+D8DEnXoFNslD5aRhTID+lKaLLvYWayRmnAzIGgO9m
	 ZfXPLpsq1EPW6vViTKKBzO5xI5N5eG4IAvlvrTumSUoCO6VqnIfovH/imrC8C5sVj2
	 0Q5lwt8dlS+sA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Ni <nichen@iscas.ac.cn>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] usb: ohci-spear: Remove unnecessary NULL check before clk_disable_unprepare()
Date: Mon,  5 Oct 2026 12:18:13 -0400
Message-ID: <20261005161720.3050479-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100503-protegee-laborer-f4f5@gregkh>
References: <2026100503-protegee-laborer-f4f5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Ni <nichen@iscas.ac.cn>

[ Upstream commit a891b9aebcc7406fe2f439d184bac3948fb08645 ]

clk_disable_unprepare() already checks NULL by using IS_ERR_OR_NULL.
Remove unneeded NULL check for clk here.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20250617042050.1930940-1-nichen@iscas.ac.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: b1b0f8bdbbc8 ("usb: ohci-spear: disable controller wakeup on removal")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/host/ohci-spear.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
index 5cc05449281c8..ed019c459ea0d 100644
--- a/drivers/usb/host/ohci-spear.c
+++ b/drivers/usb/host/ohci-spear.c
@@ -105,8 +105,7 @@ static int spear_ohci_hcd_drv_remove(struct platform_device *pdev)
 	struct spear_ohci *sohci_p = to_spear_ohci(hcd);
 
 	usb_remove_hcd(hcd);
-	if (sohci_p->clk)
-		clk_disable_unprepare(sohci_p->clk);
+	clk_disable_unprepare(sohci_p->clk);
 
 	usb_put_hcd(hcd);
 	return 0;
-- 
2.53.0

