Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A64E414A09;
	Tue, 28 Jul 2026 21:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785272972; cv=none; b=lMGjBXuYr6vzJ58+cYLl8IZfEhgjwLp9QBZ9EEUKwnSxwV/rmog9IlyboR35VL9EgqSi2vu7bia6lVldnqslphWM+1e89k3l8HEnR48bKJqvbmip5svDHjqqHGMpccGFM2mduOAUhlgtWIcOpc4B6mo66lVczG7aQUf/8RQKpMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785272972; c=relaxed/simple;
	bh=S165AWhYvprY0OIqzoJF8oXM1PUgT43QWtqOabp5gyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmoGzTQl8A5F7+IaXA7dmaIO7fBbonAIlo+RHVAZ0E4BagqsmsWKJ1hNS/SFE4ctewUYEjabO17rURWVb7Ui16sT+mnAL9bPDmSjFZ76D6CAbJ37+/N/VhBjaNdXSKNMvBX9R7zoKwDRXH7YUIbnK+sPQnx9j0wF2KciBCPZwsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d8JhbnJC; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d8JhbnJC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785272971; x=1816808971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S165AWhYvprY0OIqzoJF8oXM1PUgT43QWtqOabp5gyQ=;
  b=d8JhbnJC8T/qDcxSCGeLVwXXVW1UAZT26RV3C7eJdgoZVhEWEMFMtQrp
   nGQUMwZn3sVfvd3Uxkrs9jQlOwvfXgo2lVDyoSQj+8Q309Yg/vbIyoqrQ
   Lh7smKTqQdaNZR52VVgp7zt6K6WYRzMQkcMn3gM3Tv0oIs2drL4sYAZeb
   IbeZpYEIf1Rek5UdxwsBCard5BkAkjcsYrsqlKl9An3e1pKDpJ0MDG24X
   LXg4PBB4Y4GzJAcRBA5+HcIfOSMFbOfMs9as3ndZRRWvLWXVRJwLo6HfR
   /+HrLozrFTbBZAy2zvv69j73wVAixx4Jjrr0bjSA2iPUmRbOBChFG7aG2
   w==;
X-CSE-ConnectionGUID: Ri2xmw2kRReZQbwDKfJ5KQ==
X-CSE-MsgGUID: 2vwjd/RnSYa3o4VjYo9Ifg==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85885076"
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="85885076"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2026 14:09:19 -0700
X-CSE-ConnectionGUID: h4ipjVblRx66Nf/5HBD0Ug==
X-CSE-MsgGUID: LU/uXXYnSnuHNMlrQ5flcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,191,1779174000"; 
   d="scan'208";a="258558964"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 28 Jul 2026 14:09:18 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	anthony.l.nguyen@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	dima.ruinskiy@intel.com,
	advoretsky@gmail.com,
	stable@vger.kernel.org,
	Moriya Kadosh <moriyax.kadosh@intel.com>
Subject: [PATCH net 08/10] igc: remove napi_synchronize() in igc_down()
Date: Tue, 28 Jul 2026 14:09:05 -0700
Message-ID: <20260728210909.3042004-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260728210909.3042004-1-anthony.l.nguyen@intel.com>
References: <20260728210909.3042004-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Carlier <devnexen@gmail.com>

When an AF_XDP zero-copy application is killed abruptly, the XSK pool is
torn down but NAPI keeps polling. igc_clean_rx_irq_zc() then returns the
full budget on every poll, so napi_complete_done() never clears
NAPI_STATE_SCHED.

igc_down() calls napi_synchronize() before napi_disable(), so it spins
forever waiting for that bit and the interface never goes down. Drop the
napi_synchronize() and let napi_disable() do the job -- it sets
NAPI_STATE_DISABLE, which forces the stuck poll to complete. Reorder it
ahead of igc_set_queue_napi() so the NAPI mapping is cleared only after
polling has stopped, matching the recent igb fix b1e067240379.

Fixes: fc9df2a0b520 ("igc: Enable RX via AF_XDP zero-copy")
Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Tested-by: Moriya Kadosh <moriyax.kadosh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 2c9e2dfd8499..b3883a5a7d7a 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -5352,9 +5352,8 @@ void igc_down(struct igc_adapter *adapter)
 
 	for (i = 0; i < adapter->num_q_vectors; i++) {
 		if (adapter->q_vector[i]) {
-			napi_synchronize(&adapter->q_vector[i]->napi);
-			igc_set_queue_napi(adapter, i, NULL);
 			napi_disable(&adapter->q_vector[i]->napi);
+			igc_set_queue_napi(adapter, i, NULL);
 		}
 	}
 
-- 
2.47.1

