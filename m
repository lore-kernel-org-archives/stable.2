Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795212055;
	b=RxRhuUBzKdwf4JS+RiDDMn3Z72QPISBezRXRqZzfdbx8dgLo8Nl90xmac82hp8ctAnZg
	 2y5sdKKbqVCW9ThDRhkFCvffqCkOADsEQFQ12DW3vFGcqM+mAk+AxdCP1B5Jxvo3h2iXy
	 DZec0jh/0I8gFeZgYQhKG+exXlyV9mtwQynx9804RUz7VNeMtHEbm/qzEg61hmzXExGhN
	 EB5tN1LECtcXechxAwQdxPZ4rh00P4vRgVmxZhCreUMunRC3H/G+1FpQeyvZ4pxOOwRyT
	 naIex712Y1RS+9OBvbn6k+qaks83TIeOp51f/EHuuGSf0k+w2lqQyh85S2VjDAg0VrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795212055;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9Zn9OK3P0GPapzeQKIbZPwvIdHQqPvGIT2cs0W1rR9g=;
	b=emHt0zB6oi5GHttq//vZmrz1Ue1vbPWQbk0Ry8seY8feC8iidTQgyNPRhTqZ6+5hbkYC
	 49QRJ0G38t//KAxAnzCGSuPARbZmkkQsCdn/NCnmswjjThUzHuyTD9ocwX4H/+0PEfX06
	 78cNcYaKUU16rclMuxXoykqSSTygb8Jat6JuGqsdeDqucTV2YynZ91/dLNywm22siNFXV
	 m+KRayPfL0j/3eC1g1lP8+vF0Ay2v82daZRUPPbT5S8ylXQ+k8XyZ/dCe4GENtEpw4/L1
	 AFnCp9He6C3Ds6NZMP1XRUWTEdMETci9vWGhMGQu7BdBlq8byQ9brFsOa9r2JLbqgnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lFrlU0a8;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045FB60A2606;
	Fri, 20 Nov 2026 22:00:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 045FB60A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lFrlU0a8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795212051; x=1826748051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=79Vi1iqtA/28yjPminAcVGflVNOn+08MjEk6EYbSLTw=;
  b=lFrlU0a8G0mL5pRSW5kn1DOoPStyTqo5YPoYt+1mYTBS56krw3qLpA4+
   O1/Jfoe7GAWv016m+wIqi0Cg2bEdwRRhxJSu9DNNAbpuHpduq86WXmM0z
   JgZL+6v1xo+2bodrAbpnrjI0hroiuxTTz9cIJoY8B0FIZTQOI86C5D3ob
   MNngTZu1brA1dJWVqeL8VuG1jkNkymCREx5Se1TYJ7Gc72ulE5E0Sje+t
   Q88cRdJ7XP8Wncro+dY1gRHUZcL3RrGmMDp7k5NOWzWcamz9fbxyjoFB6
   aYBXfdM4wVPZHD0fmUz1zlSEqjL8IcqOD3L6ZD0n3a4dOQQrAwo7coph7
   g==;
X-CSE-ConnectionGUID: JjWyv6gLTD+ZO0aPjDTgQA==
X-CSE-MsgGUID: W62pZNkAT52IiQrpQcGINQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3995058"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="3995058"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 14:00:37 -0800
X-CSE-ConnectionGUID: m7wucdqGRW21rDICZbUC+g==
X-CSE-MsgGUID: VGQXylz3SEmFptKtKn2s2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10775827"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 20 Nov 2026 14:00:36 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	anthony.l.nguyen@intel.com,
	ripatel@wii.dev,
	xiaolinkui@kylinos.cn,
	xiaolinkui@126.com,
	tomasz.lichwala@linux.intel.com,
	jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net 4/4] net: fm10k: shut down the service timer during removal
Date: Fri, 20 Nov 2026 14:00:20 -0800
Message-ID: <20261120220022.3133664-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261120220022.3133664-1-anthony.l.nguyen@intel.com>
References: <20261120220022.3133664-1-anthony.l.nguyen@intel.com>
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

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

The fm10k service timer rearms itself from its callback. During PCI
removal, timer_delete_sync() waits for a running callback but does not
prevent a callback or another service path from rearming the timer. This
can leave the timer referencing the fm10k_intfc after free_netdev().

Use timer_shutdown_sync() to permanently prevent rearming before teardown
continues.

The issue was identified by code inspection. No runtime reproduction or
trace demonstrating the failure is available.

The patch was not tested on real hardware. No hardware- or
firmware-specific runtime result is available. Validation used source
review and available build or emulation checks.

Fixes: 54b3c9cfad6b ("fm10k: start service timer on probe")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Acked-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/fm10k/fm10k_pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
index afe939f8f4ef..c830417b112c 100644
--- a/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
+++ b/drivers/net/ethernet/intel/fm10k/fm10k_pci.c
@@ -2243,7 +2243,7 @@ static void fm10k_remove(struct pci_dev *pdev)
 	struct fm10k_intfc *interface = pci_get_drvdata(pdev);
 	struct net_device *netdev = interface->netdev;
 
-	timer_delete_sync(&interface->service_timer);
+	timer_shutdown_sync(&interface->service_timer);
 
 	fm10k_stop_service_event(interface);
 	fm10k_stop_macvlan_task(interface);
-- 
2.47.1

