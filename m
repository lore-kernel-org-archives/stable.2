Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794532114;
	b=XBx+SdWVLhYd/EJTytZzSViLPN75/6i8KBv/ioIRZllKA/Tr6bgQ57iuTgRqZHiXCF+3
	 3df25j5+vfEndAyfYNEbbyXlKkGdl2kTHLcmoRvZPggjCIvXgFizvKtzKIaXDXTvWnEA6
	 2u8X7GxdCWacRadOQj9ncJSVeFN3KY49LbBfNo2BZF64WFHYPYD6aiNwZaz5YnvXR3yvq
	 P3+uPBjZEeZ1s+8eNlVvcVSYzSAThZtFV8AW76WzmfJLIK9Hge5zfOlA2IHNPDDFgRWcN
	 eVLlbn84BENmNxF7c5UNeCdhreOJe84HyQxVo/PrIbjlPCSmkVLIzVn49M5FbZrxk0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794532114;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=6mKfsE2m1surULkycD7HQgfLz0qt2LKkwV1QgEcEtLM=;
	b=SZQ7yFeFyFhjsdiGwZL3yyNUwmWw1j1Af156hxHPhzmB0a/Z1akWwfiP4Nszodxp473S
	 cyUvQi44EoMSoW6IlECKcBtC/wZG5sS0gM1h6+WT9zQsZxvz4z6bRi5wdSWNlvlBFBxo1
	 XxxdKdGYrmM3K6XTMlEXtB89rLGkZ70DzyFyh0shvtnIYUfUCVzp8Mrr756RZkE4stN6K
	 dfHSKZTW8V+4HiNIF0tat6YCWom4joGJRZSYELja6hQ2tQ8QrJJO+TvjMa3utyb46wBhB
	 EfF/b9GsWp/63KHme2QPZygdAb5ZSgHioYJozWm2qII0Bk5YmqJyv60Kwzxs7Hv4pMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="j0/nUGqK";
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A62606A333;
	Fri, 13 Nov 2026 01:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2A62606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=j0/nUGqK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794532114; x=1826068114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=69Y+r+H1NTvSh/GiYErO30dYltN2QSlJy2tThmel4rA=;
  b=j0/nUGqKYfAENZuR94gFwQxiUQotCx/0c8znP+ptJJBAyhZMquFca2rw
   lQdVPJeYM4J4FhOwOqoEwOi0XaV+RHYRFaYD4m/01PPH1cuYMLCrqpbsN
   /xRmfbQ5cYGyKOOSMOxaXuXxleIIHD3RJVav6frBzXmWynZG9i3NxhCjN
   YtFIEcnL3dyqNyoljzYXoBdeUwfvl7+S6ZAehVd6tMl+1PqOPzp/5BlW4
   IgnrB0vgNw2m4cplaLw0ir39+KdS1eyjn4jMbcnKzc6f4Cxf0r/a+RLqt
   oZua25mYhP/X26n8VZqpURPFCUUDr9GVbdaPv9DN68P3cdkDyGBK8lhUa
   A==;
X-CSE-ConnectionGUID: gAxqCI6hS4ar/pwEJ7NhlQ==
X-CSE-MsgGUID: HMBK/7wCQJaP0a2pJmYiPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3252596"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3252596"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 17:08:31 -0800
X-CSE-ConnectionGUID: ekFHjqcYSaSHfQPNSl5zPw==
X-CSE-MsgGUID: z+eNeXrNSOKtR+6eLppP8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9214835"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 12 Nov 2026 16:58:29 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	anthony.l.nguyen@intel.com,
	tj@kernel.org,
	skunkolee@gmail.com,
	nsvatoslav515@gmail.com,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Alexander Nowlin <alexander.nowlin@intel.com>
Subject: [PATCH net 2/3] igb/igbvf: disable work items before device removal
Date: Thu, 12 Nov 2026 16:58:19 -0800
Message-ID: <20261113005823.130021-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261113005823.130021-1-anthony.l.nguyen@intel.com>
References: <20261113005823.130021-1-anthony.l.nguyen@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

A watchdog work item that is already running can queue the reset work after
the remove path has canceled it. The netdev Tx timeout handler can also
queue the reset work until unregister_netdev() shuts the interface down.
In igb, device reset interrupts provide another enqueue path. The reset
work may then run after free_netdev(), resulting in access to the freed
adapter memory.

Although igb_reset_task() checks __IGB_DOWN, checking the bit already
dereferences the adapter and therefore cannot protect its lifetime.

Disable the watchdog work first and the reset work second in both drivers.
Disabling the work items also prevents racing attempts to queue them during
device removal.

Fixes: 760141a53e5d ("igb[v],ixgbe: don't use flush_scheduled_work()")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 4 ++--
 drivers/net/ethernet/intel/igbvf/netdev.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index d4a897a8c82c..933dd1c29950 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3887,8 +3887,8 @@ static void igb_remove(struct pci_dev *pdev)
 	timer_delete_sync(&adapter->watchdog_timer);
 	timer_delete_sync(&adapter->phy_info_timer);
 
-	cancel_work_sync(&adapter->reset_task);
-	cancel_work_sync(&adapter->watchdog_task);
+	disable_work_sync(&adapter->watchdog_task);
+	disable_work_sync(&adapter->reset_task);
 
 #ifdef CONFIG_IGB_DCA
 	if (adapter->flags & IGB_FLAG_DCA_ENABLED) {
diff --git a/drivers/net/ethernet/intel/igbvf/netdev.c b/drivers/net/ethernet/intel/igbvf/netdev.c
index c686ee120a14..125876a18b5c 100644
--- a/drivers/net/ethernet/intel/igbvf/netdev.c
+++ b/drivers/net/ethernet/intel/igbvf/netdev.c
@@ -2901,8 +2901,8 @@ static void igbvf_remove(struct pci_dev *pdev)
 	set_bit(__IGBVF_DOWN, &adapter->state);
 	timer_delete_sync(&adapter->watchdog_timer);
 
-	cancel_work_sync(&adapter->reset_task);
-	cancel_work_sync(&adapter->watchdog_task);
+	disable_work_sync(&adapter->watchdog_task);
+	disable_work_sync(&adapter->reset_task);
 
 	unregister_netdev(netdev);
 
-- 
2.47.1

