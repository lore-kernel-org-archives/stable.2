Received: from sg-2-4.ptr.blmpb.com (sg-2-4.ptr.blmpb.com [71.18.227.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C273FE64A
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=71.18.227.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787912112; cv=none; b=fMILNIVa++tfhC6b7J5R4ipOSW8NG0EyhsqRRRhDkLIRRhTo23mM/D/i8+ZfetD4asvEZrNtgaBHffSZlXYV44Q2GKwGAxj1Spr3vGf8IuN/ZPTAmhsWDUiQNQKLi3KAtGeHVEgUGfxNsr4GmiZayn6KwR5o+WrAYQnVwu+/M8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787912112; c=relaxed/simple;
	bh=1D0z3XDIxhuLPSl3ONCnGkNcEisGAOG8EjoLCXAfyks=;
	h=Cc:Mime-Version:From:Subject:Date:Message-Id:To:Content-Type; b=h/1OXjIAVysGBbzkuGlMhuCP0XaRyifVJ7veOpsAPTFzAv2y8Q2JVOLg7uR4czA/g/jzYt6xJOcoLz6miawLpFqh1HQKxZEdtX8KgOHBNxMMARFIPSWbZGIVi3SZx/Yq6pa25A09PJ2jfOkJ5TaUUAnWuxqd0HdLg8EfvElBVW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc; spf=pass smtp.mailfrom=cherr.cc; dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b=sbZeiBYK; arc=none smtp.client-ip=71.18.227.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cherr.cc header.i=@cherr.cc header.b="sbZeiBYK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1787912104; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=FVK+0yhgCI3q0pPTOyN+Ad8nUAuXDwjVZzyNNRt6CiQ=;
 b=sbZeiBYKpAWrd+bOcGMsn1aKRqHqkfIzvHOXI15/9QeIYufXRHYA7YxWMplk2Hh9wPRypc
 2fdyv30hLq9liH9Nl+yhZK2qxV+dUT7iVK57q1bI0v0EmrdORv7ja2ZlS56iPz3oY+Otyl
 lKEUj4q1+e6Xd7qmN/2SKVmXw2kfjLqkHlZWIVJXhkOWC3MxNowDLmaLT19UVZpgwpaK30
 8PtdUP33JsMKSIWe2qOQo1HbjmXDjw5rssMasdyPctSuXmY6ou/3AaBRgTk1OdtF1sDFz6
 1emCP95jmsS6k2VebxX5o3zo/zcPsG5t+i8tb42A0IYSU+eY1Pw2Xag0z5XPFA==
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>, "Shengzhuo Wei" <me@cherr.cc>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: b4 0.16.0
X-B4-Tracking: v=1; b=H4sIAKFfkWoC/3WNQQ6CMBBFr0Jm7Zi2VkBX3sOwKMMgVQJmWlFDu LuAcenyJf+/N0Jg8RzgmIwgPPjg+24Gs0mAGtddGH01MxhlUpWbDF1sNZLriFsUDhzx2csN97b mPLMppWYH8/kuXPvXKj4XXw6P8soUF9uyaHyIvbzX8qCX3S+S/4sMGjUenNFWVa5UmT1RwyJbI iimafoA3bnXws0AAAA=
X-Change-Id: 20260827-atl1-cancel-reset-work-54fe8746c623
From: "Shengzhuo Wei" <me@cherr.cc>
Subject: [PATCH v2] atlx: atl1: cancel reset and link works on remove
Date: Fri, 28 Aug 2026 18:14:58 +0800
Message-Id: <20260828-atl1-cancel-reset-work-v2-1-1ee8a5ac2f47@cherr.cc>
Content-Transfer-Encoding: 7bit
To: "Chris Snook" <chris.snook@gmail.com>, 
	"Andrew Lunn" <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, 
	"Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, 
	"Paolo Abeni" <pabeni@redhat.com>, "Jeff Garzik" <jeff@garzik.org>
Received: from [192.168.9.107] ([111.42.148.113]) by smtp.feishu.cn with ESMTPS; Fri, 28 Aug 2026 18:15:01 +0800
X-Lms-Return-Path: <lba+26a915fa6+277ac2+vger.kernel.org+me@cherr.cc>
X-Original-From: Shengzhuo Wei <me@cherr.cc>
Content-Type: text/plain; charset=UTF-8

atl1_reset_dev_task is scheduled from the interrupt handler on PCIe
PHY link down and DMA read/write errors, and link_chg_task can be
pending from link events. atl1_remove() tears down and frees the
net_device without cancelling either work, so a work scheduled just
before unregister_netdev() can run after free_netdev() and touch the
freed adapter.

Cancel both works before unregistering the net_device, as atl2_remove()
already does for its reset and link works.

Fixes: f3cc28c79760 ("Add Attansic L1 ethernet driver.")
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
Changes in v2:
- Point Fixes at the initial driver commit instead of the 2012 rename
  commit; both works and the cancel-less remove go back to the
  original import (Breno Leitao).
- Link to v1: https://patch.msgid.link/20260828-atl1-cancel-reset-work-v1-1-9a2140dab074@cherr.cc
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
