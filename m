Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655AF4BB26E;
	Thu,  1 Oct 2026 22:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790893515; cv=none; b=a2bJ3yD7tFQRDHj+KkVFtA5kJIfMkKTW++jJJq1jyW6Co/j2OibRLNg6r42lec3EMc8JbvIqbahJdyU/vqcmSkR5v/Eg9VXx7mrwW68n15At5fCaBACasP/DNXRjWSsrVjQWb63F2RhxI5EIbAmXtE/IJYNp3r4wdvTx+fTMqpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790893515; c=relaxed/simple;
	bh=922dQtw1BGB9slToBQUERWi3HhtlWCsxkanlmpw9gbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNFu07x0VT/FKrmaD+iy7rY4LAZU1Oq2euTYigFabtqM3af+6cozMh06VgAUYamfj85LY7a0cgEDZLER7av4FJ3w/mBwpTy5ROfJ6eDM7php4AWHzl1a1FY5RpyGepOKCbyF0z12fSJWNAI4y2hjFP7kB7rQwD3AL0zrLjWlBAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Owm7Ry1i; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Owm7Ry1i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790893503; x=1822429503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=922dQtw1BGB9slToBQUERWi3HhtlWCsxkanlmpw9gbg=;
  b=Owm7Ry1ivmHXJ8MSIOJ095PbtAolcmnjQTys99+iWWC/WvuIALpQpu9D
   6Cgd+ch7utvwD63F7MshUsWPLwoPRTqqtGgv7d5abCMjJKHBdFs7iKYET
   W2k1m8QBwE2VQhAXFv0UXbdNiIonlXDoFunl9ZiP3R8Eu0JV8jqSlYHaN
   lfrSbljpuWAO+uEBkgs6qH1nrnAaZXgwANu0eGfnjkBclTahCk9VDkbzN
   NJW6NQdO/XGh9C7pchUmWcUFFSHXGSL0XdBWOgXSdzozbS9cm/EQ7R3Nq
   ZjP7D/EUVWyITnVUgUDuWCJyok1TfAd+635f0KVuUnAYecC6EMHpaKX6O
   w==;
X-CSE-ConnectionGUID: wqqVdqxQR5yPikv5CCUKiQ==
X-CSE-MsgGUID: Pryl/lPbSO6jTRq738I3dg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90567730"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="90567730"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 15:24:59 -0700
X-CSE-ConnectionGUID: AOHb83bFSoezk2USQ6ejVw==
X-CSE-MsgGUID: TfBNDDkBRTeBH5sJn2muDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="279863780"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 01 Oct 2026 15:24:59 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	florian.bezdeka@siemens.com,
	meng.ding@siemens.com,
	p@1g4.org,
	tkusters@aweta.nl,
	jiayuan.chen@linux.dev,
	pulehui@huawei.com,
	dima.ruinskiy@intel.com,
	raanan.avargil@intel.com,
	gil.fine@intel.com,
	stable@vger.kernel.org,
	Javier Herrera <javier.herrera@afronta.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net 6/6] e1000e: add system to disable K1 list
Date: Thu,  1 Oct 2026 15:24:39 -0700
Message-ID: <20261001222443.3500206-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261001222443.3500206-1-anthony.l.nguyen@intel.com>
References: <20261001222443.3500206-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Javier reports seeing packet loss issues related to the re-enablement
of K1; disabling it makes the issues go away. Add the reported system
to have K1 disabled by default.

Reproduction steps (from the Link):
Plug the cable and ping the default gateway on the LAN. No suspend/resume
involved, machine freshly booted and on AC power. Nothing e1000e-related in
dmesg apart from the link up/down messages; no "Hardware Unit Hang".

Default (K1 enabled):

  $ ping -c 30 192.168.10.1
  --- 192.168.10.1 ping statistics ---
  30 packets transmitted, 18 received, 40% packet loss, time 29734ms
  rtt min/avg/max/mdev = 0.211/0.315/0.384/0.046 ms

The lost packets are spread over the run (seq 6, 8, 9, 11, 13, 14, 16, 19,
20, 24, 25, 30), not a single burst. DHCP on this link also takes 1-2
minutes to get a lease, consistent with incoming packets being dropped.

With K1 disabled at runtime:

  # ethtool --set-priv-flags enp0s31f6 disable-k1 on
  $ ethtool --show-priv-flags enp0s31f6
  Private flags for enp0s31f6:
  s0ix-enabled: on
  disable-k1  : on

  $ ping -c 30 192.168.10.1
  --- 192.168.10.1 ping statistics ---
  30 packets transmitted, 30 received, 0% packet loss, time 29713ms
  rtt min/avg/max/mdev = 0.169/0.251/0.468/0.054 ms

  $ ping -c 30 192.168.10.1
  --- 192.168.10.1 ping statistics ---
  30 packets transmitted, 30 received, 0% packet loss, time 29677ms
  rtt min/avg/max/mdev = 0.101/0.222/0.360/0.064 ms

I have only compile tested this, but Javier has tested that disabling K1
on his system (Lenovo ThinkPad P14s Gen 5 (Intel), I219-LM [8086:550a])
resolves his issues.

Cc: stable@vger.kernel.org
Fixes: 578294b8b60d ("e1000e: Reconfigure PLL clock gate timeout and re-enable K1 on Meteor Lake")
Reported-by: Javier Herrera <javier.herrera@afronta.com>
Link: https://lore.kernel.org/intel-wired-lan/CAKRuCQLWEcci9hPgNUmvq44Bd2H30T5_vP=exMjsknXMN5Yh9A@mail.gmail.com/
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index ad9b88c9af22..6f85dab5c55c 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -67,6 +67,13 @@ static const struct dmi_system_id disable_k1_list[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Dell Pro 16 Plus PB16250"),
 		},
 	},
+	{
+		.ident = "Lenovo ThinkPad P14s Gen 5",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad P14s Gen 5"),
+		},
+	},
 	{}
 };
 
-- 
2.47.1

