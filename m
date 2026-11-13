Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794532114;
	b=Nm6Sc3YYjQMPwc8rSTjoCKCoIuc8iKxgI/ZSUPDHDJSiO122nr93R3SbLu1XkeUNF/IG
	 7K9RuxX+V/8yMEuLbHFtixCplIqv5liTckvOUbbVWg8ao8fKw/ksXOn+t+0KOnLU1Sd4g
	 G3XFBaWq2HqhvXxoUMasOAsifceyHWnvp8OgjgDEZgky72gBEzzRk6m90YuuFsyq4RlUM
	 wgUTvJtaN4gRd3ZVgx/4/50Cydnj/wSFRucGfJc/61+EmljJxZkYyQtSM9dcTXFWeo8OP
	 rwVI5JAyiYrInO0k9XMv9fs1835pW30Th29JeqsFe2SRgSkfqJ8KQ5OQANjfJuIYrbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794532114;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bt7r9ZwEk3lDT6zqFTUM9+TgOV4W3ba2YUKMbE8LlN8=;
	b=dffyu7kXePN0ATf242AewhBPse6bVMwNWZxUNPVbh92SF0JkhpVQ33D/I7CQ0BOv6NTH
	 gLNANiMAgnIJcbu4KysHEb3HW4Wx0napEkApFmZzctVpXpV1D9NJyPwIWG5NMnxBemxsW
	 C5pOaH60HnRIbfoFLekuxQUVzB6u73K7+FIVpLyeTGqwHNu4wnRmRP5t29QVbKPz0DwNU
	 ur59UcMBF8tU5e1fljeNFTUcfkcS0Ld0XcWUbiLQPYISedDSxWEXHhPvhCLuOPj5aEqrP
	 QqJ5SS9ULVkNsmMR+smibl9Cta7pAe4R9Q1hayOwmEBUeo9+Y6HECgX5Xnak3ozLb2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l3jiFFXR;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87458606A32E;
	Fri, 13 Nov 2026 01:08:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87458606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=l3jiFFXR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794532114; x=1826068114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pPtWGKw8mwXLW7xtg2pB2U3P/jd1ZaEWWN4O4kDLcB4=;
  b=l3jiFFXRdN0dpolEZAotO9TN7lf8Zc7TdluA9dvfUO4UbdGvRfoz/msw
   BxeSszQv3LDVIiFt0aL2/tsFcSRMFBNATMVkiKtyzZPQtYRC9YB1DIlrD
   JdEYXtsXz+4QvfVrOSLGeeT+2DA2q+SZryILY2elBcc/CmIx103W1wn+/
   hg3nAeImdXWzgp1zrLmClB5Z3MBxPBLjsr2nsaUoEQqETv8TRAkzMLNCd
   zWDw10iLv6qAhcro4GdQ6Kvj6XUiSbUOXTh0k2NBFXRfCrbYAm2H8k1pr
   WI76ihIQSycWSeUZznNiv1rXvIW8yjpoQtHf4YqzRo1N5IdwVTo8zFwxR
   g==;
X-CSE-ConnectionGUID: jKGDv3MjSl68SQVR1J37lw==
X-CSE-MsgGUID: FU1iVyBOSv+LEJiz3VJ8DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3252604"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3252604"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 17:08:31 -0800
X-CSE-ConnectionGUID: DGrbrHekSLq1a4V5knp3rA==
X-CSE-MsgGUID: DgrsMilUQTOCEAxz+1CWKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9214838"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 12 Nov 2026 16:58:30 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>,
	anthony.l.nguyen@intel.com,
	skunkolee@gmail.com,
	luoxuanqiang@kylinos.cn,
	syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net 3/3] net: e1000: fix warning in iounmap on probe failure
Date: Thu, 12 Nov 2026 16:58:20 -0800
Message-ID: <20261113005823.130021-4-anthony.l.nguyen@intel.com>
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

From: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>

In e1000_probe(), the error unwinding path at err_sw_init unconditionally
calls iounmap(hw->ce4100_gbe_mdio_base_virt). On non-CE4100 hardware,
hw->ce4100_gbe_mdio_base_virt remains NULL.
Passing NULL to iounmap() triggers a WARN_ON_ONCE on x86 architectures.
Furthermore, on CE4100 hardware, if probe fails before or during
MDIO mapping, ce4100_gbe_mdio_base_virt is also NULL.

Fix this by adding a NULL pointer check before calling iounmap() on
hw->ce4100_gbe_mdio_base_virt. iounmap(hw->hw_addr) remains unconditional
because every code path reaching err_sw_init occurs after hw->hw_addr has
been successfully mapped.

Reported-by: syzbot+ca1ef9e2e234b8d3599b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ca1ef9e2e234b8d3599b
Fixes: 13acde8fffc0 ("e1000: cleanup CE4100 MDIO registers access")
Cc: stable@vger.kernel.org
Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000/e1000_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/e1000/e1000_main.c b/drivers/net/ethernet/intel/e1000/e1000_main.c
index d7f5c6f16142..d7e279b739b8 100644
--- a/drivers/net/ethernet/intel/e1000/e1000_main.c
+++ b/drivers/net/ethernet/intel/e1000/e1000_main.c
@@ -1227,7 +1227,8 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	kfree(adapter->rx_ring);
 err_dma:
 err_sw_init:
-	iounmap(hw->ce4100_gbe_mdio_base_virt);
+	if (hw->ce4100_gbe_mdio_base_virt)
+		iounmap(hw->ce4100_gbe_mdio_base_virt);
 	iounmap(hw->hw_addr);
 err_ioremap:
 	disable_dev = !test_and_set_bit(__E1000_DISABLED, &adapter->flags);
-- 
2.47.1

