Received: from sg-2-3.ptr.blmpb.com (sg-2-3.ptr.blmpb.com [71.18.227.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054D33D9DB3
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 07:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903357; cv=none; b=b5toghmGWQMKhqHtax1nKaSUcA0Kyz1yGEpqhyDxeDBSU9rApqxy9qQ1o4qCv9NaBG21yZcCZkbLIRDqiTZOVpeV3A5oIh8MexFPxRC4NRL6zCufi7HIqkXSjM07JJTJCZQtTbs3QuJE5Tx8dltuPYKbdYllDPXbrW1Z4Nygvmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903357; c=relaxed/simple;
	bh=89rFYO8B9YjxwIFdQfTSXAkfZ8zjurgofSXdDY+0wFk=;
	h=To:Date:Message-Id:Cc:Subject:From:Mime-Version:Content-Type; b=mg8dUGAZzwJExL/Zutiefo7+UFlCE6CLSlrcmMAS8K0E1+0qkiEQGBmcWr8pReb73Qws0iZuSmmJZXGZB66hnoYgo0tm9Zv8Z0KjdJMQGhySc9xwMuOMl9wIpdypGQtLG438TOOEGegwpI4gaMmdzFFLJ2YhR7Xb8kzNayb+gv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=PiKTKpRX; arc=none smtp.client-ip=71.18.227.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="PiKTKpRX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1787903341; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=z6GmY5dVevoySZJD5dIwlWZ07IO0nYCX63EvQIc5Ifc=;
 b=PiKTKpRXgG40kqDBpKYvn3Q4vOUDS9kPSAlT9E2Cxtkb4g8H+5BPTWzDadXrRseyTFBtrM
 ss5k4AgmNbjWghkaxGzKQ2TUSN4Ji5tOPBwPeyzsWtpP6QQ/Q4ibiocwpZMxxtAchXRPfF
 NvM+UZtJ9mMDrI80LZL3bp8EyOx12unddFKa65SNwDUMxQGNJ8kUrXG7TWUF9Z3f5aYwWv
 cAX/rWHVf7GEt6fuIZQ91+6AvPeREHay6wz27HFRZGwfCmMf9BUmuGvS0cIb2jLJLJ5y38
 kc6XOz4lg7K2pFhJu/7+8QTQQRUTg0lwaKMo4tz7+bUgaJTgk7G4/hE/HRAH0Q==
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGY9kWoC/yXMyw6CMBBG4Vchs3YSqFiIr2JY1PFHq6SYmXpJC O9u1eW3OGchg0YY7auFFM9ocU4FzaYiuYR0BsdTMbna+bp3HYc8NSwhCSZWGDK/Zr3xrh3Rd60 X77ZU4rtijO/f+DD8bY/jFZK/N1rXDxd0qBp6AAAA
To: "Chris Snook" <chris.snook@gmail.com>, 
	"Andrew Lunn" <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>, 
	"Tony Zelenoff" <antonz@parallels.com>
Date: Fri, 28 Aug 2026 15:48:55 +0800
Message-Id: <20260828-atl1-cancel-reset-work-v1-1-9a2140dab074@cherr.cc>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Shengzhuo Wei" <me@cherr.cc>
Subject: [PATCH] atlx: atl1: cancel reset and link works on remove
X-Original-From: Shengzhuo Wei <me@cherr.cc>
X-Mailer: b4 0.16.0
X-Change-Id: 20260827-atl1-cancel-reset-work-54fe8746c623
From: "Shengzhuo Wei" <me@cherr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a913d6b+bdc08c+vger.kernel.org+me@cherr.cc>
Content-Type: text/plain; charset=UTF-8
Received: from [192.168.9.107] ([111.42.148.100]) by smtp.feishu.cn with ESMTPS; Fri, 28 Aug 2026 15:48:59 +0800

atl1_reset_dev_task is scheduled from the interrupt handler on PCIe
PHY link down and DMA read/write errors, and link_chg_task can be
pending from link events. atl1_remove() tears down and frees the
net_device without cancelling either work, so a work scheduled just
before unregister_netdev() can run after free_netdev() and touch the
freed adapter.

Cancel both works before unregistering the net_device, as atl2_remove()
already does for its reset and link works.

Fixes: 03662e41c7cf ("atl1: fix kernel panic in case of DMA errors")
Cc: stable@vger.kernel.org
Assisted-by: GLM:5.3
Signed-off-by: Shengzhuo Wei <me@cherr.cc>
---
Remove-side work cancellation, matching what atl2_remove() already
does for its reset and link works: the IRQ handler schedules
reset_dev_task on PCIe PHY link down and DMA errors, and link events
schedule link_chg_task, but atl1_remove() frees the net_device without
cancelling either work.
---
 drivers/net/ethernet/atheros/atlx/atl1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index 98a4d089270e..b49353a94f5e 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.c
+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
@@ -3128,6 +3128,9 @@ static void atl1_remove(struct pci_dev *pdev)
 
 	adapter = netdev_priv(netdev);
 
+	cancel_work_sync(&adapter->reset_dev_task);
+	cancel_work_sync(&adapter->link_chg_task);
+
 	/*
 	 * Some atl1 boards lack persistent storage for their MAC, and get it
 	 * from the BIOS during POST.  If we've been messing with the MAC

---
base-commit: 45c13f3f9e3bb15fd89ff2864c6f627a3b4b4229
change-id: 20260827-atl1-cancel-reset-work-54fe8746c623

Best regards,
--  
Shengzhuo Wei <me@cherr.cc>
