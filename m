Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 068524779BC;
	Thu,  1 Oct 2026 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790893503; cv=none; b=SMhCv5mFmhjQp0sU/19IYt3+GLFayN8fEb4YoU4Iq9JprNFPIS2qzUBLajBox5yXehukR5gVSJZo7z8JdL16I8k0e8i+miALhcViKOviy5nfW2U9TeRKfUDmVZkKuO2adjGTUy/Q1aYy4OaZWv6YWnB4/x4/Cfnc1iFCI9JGsWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790893503; c=relaxed/simple;
	bh=5b/+qBTi9d75MgdpbDSh2kieKiISjkB8E7yYnVwC68o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kZe3Turl430eGMX4WqlRiXsDSOCwxeF3qqLXa7dLEjWTgq5cH9pGLaY5IKha/O32s1zpE6zgMLPjUaGUaVo3zwwtfpwp/2hXc0uAEUnucorskjN6bX1TPckUC7ZezctLjkPmqR/tls1i1QxAddceRNo9Rvm/mMNR0TiRSFvDwPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cyF95hDF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cyF95hDF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790893501; x=1822429501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5b/+qBTi9d75MgdpbDSh2kieKiISjkB8E7yYnVwC68o=;
  b=cyF95hDFAmdf0IABtupgQ8XzY56ufUCzjmShYI6oUF+WA0SVyBRSRivM
   4i/LQ5YKT8/2Uz1uMdSt/juiYLkBkKYWFh7xTjQUmhaUqJJ3Tso19eezP
   sIkFtLWLkz3Zk6l2PYX8J5uf/POvzn0P8EM0rTeowppxL3y0GIY/FwE+3
   PnJGnx9YzOAghYqk6b/rMCY9dFeG+oruFYndMBbHeWhrnC91HjD6H64+I
   63KMPGX7tkMOZE2f0+Y7tOTlvxMAFS0nVnzLF1wY2BX5JMWnOQfXzUM2s
   LdELPjaQ5YpbYUDPZTvOk86LPHxGOdXqZP56lRzkG0Zn9R6kEB8sheZlb
   Q==;
X-CSE-ConnectionGUID: KEIlsda7TwmzaNscxD0XJg==
X-CSE-MsgGUID: NR9rM86tRF2ZyMKr6YvBHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90567695"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="90567695"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 15:24:58 -0700
X-CSE-ConnectionGUID: qgpt2mCDRcmI9twxnPGTKg==
X-CSE-MsgGUID: DMIrsDUBSdOJjx3JfnytBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="279863765"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 01 Oct 2026 15:24:58 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Paul Moses <p@1g4.org>,
	anthony.l.nguyen@intel.com,
	florian.bezdeka@siemens.com,
	meng.ding@siemens.com,
	tkusters@aweta.nl,
	jiayuan.chen@linux.dev,
	pulehui@huawei.com,
	richardcochran@gmail.com,
	dima.ruinskiy@intel.com,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Avigail Dahan <avigailx.dahan@intel.com>
Subject: [PATCH net 2/6] igc: only strip RX timestamp header from first buffer
Date: Thu,  1 Oct 2026 15:24:35 -0700
Message-ID: <20261001222443.3500206-3-anthony.l.nguyen@intel.com>
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

From: Paul Moses <p@1g4.org>

igc_clean_rx_irq() strips IGC_TS_HDR_LEN whenever a descriptor reports
IGC_RXDADV_STAT_TSIP. For multi-buffer packets, continuation descriptors
retain TSIP even though the inline timestamp is present only in the first
RX buffer.

Subtracting the header length from each continuation buffer truncates
jumbo packets by 16 bytes per continuation and leaves the packet length
larger than the received data.

Only consume the timestamp header when skb is NULL, which identifies the
first buffer of a new packet. An skb carried in rx_ring->skb remains
non-NULL when packet assembly resumes in a later NAPI poll.

Link: https://lore.kernel.org/all/20260625-igb-rx-ts-fix-v3-1-99b3efa08dca@aweta.nl/
Fixes: e1ed4f92a625 ("igc: Refactor Rx timestamp handling")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 95f7747b347b..b94a08791102 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2658,7 +2658,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 
 		pktbuf = page_address(rx_buffer->page) + rx_buffer->page_offset;
 
-		if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
+		if (!skb &&
+		    igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
 			ctx.rx_ts = pktbuf;
 			pkt_offset = IGC_TS_HDR_LEN;
 			size -= IGC_TS_HDR_LEN;
-- 
2.47.1

