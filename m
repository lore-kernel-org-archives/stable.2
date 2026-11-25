Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795647126;
	b=wm0NGFZx/MfsrhKj5QVlOVhkc47A8m12n8HF/Q8WyVxQ3i6tQk5iYCx0Beo25DvCVvVo
	 hxRqPUuZceiH7zmG8O5EGndjuwtEZqFnU7kmlQANudRa8rkr3Ph55AUsRw05rcmSw1lNC
	 YzzKM+7mIsaQ87NLxpgfK7C5Z9I2tBOir/F0reu97bhk3KjY/cZgPbGDzmdiMY007aYyT
	 Z8kfb7UYifALaBEcqKrZXtD8Bb7rvlnngvxsFusC1gqY06kYnfG71vcr56u4DYFpTF1gg
	 I8vo42oYYOyjrmFGQq+LMwcT3zzIMI96vX9iReVMBKfn+lSTq/tJCV2/O8OdP1JA2Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647126;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lL9hw+IR+AsTGtPTwf9R+JgSVV6KkFIrNc6QulH/3ng=;
	b=yg3OuIjKTf108VQaoj+zww82Y45TinTgWVZpGxa/p6gyrnmkMexEBqC2U9h8atTLIJP6
	 p9XG4mb+uA7ETC3xpQ0KM5N08uuvdqYyLzD59WTYNDNaq2QuDcqXdEDWI2+aiy5WSdWbo
	 wPEDttc8DaSDbfHGUzcCBr0YxDYwsmeVf9FEJFRvNRPm2GW0yO5vQu/9sRHUcBI4MMK38
	 u3yyIeuztew8bkQgySUnYmvq5opNazFpz7FnLs7YXhOwWDLsxHmSuLhoW1jVitYvKB41d
	 m/vAZqQxyUj0XGNNPjnXV2Qt1v5BonlymUyITwJyNDCjSge3toho0neiIVKFB2HWcsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i0vYrnFZ;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724F0606A333;
	Wed, 25 Nov 2026 22:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 724F0606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i0vYrnFZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795647117; x=1827183117;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cCsfnVMbsbvUsz7NlCkCYdoWATo5my9yPtnqQXeAT2Y=;
  b=i0vYrnFZyppadQKoYm2t6RU3GZRJvbr1z1Xbl+YWPz9QK1vKqLTulbDI
   cuyaAMUG+V2r3SXB4ORaUYrG3TcIzRjG6B+iKAN43sS8yAjkd1rns90dt
   UW1lVgWDgQWfxHor0YRysQ7LV45Xj5BQdRskjusMcqL72gLBR8Cg9rNhc
   d/eV12y23fsErxAmbFZ5IJBYcd0165Ou0wqSloiB/+591VPpTBP+PkC6r
   OvyEnbjdC9AHenzo5weDksO2IWjm5uHiwv1UGjZL75mlqNt51pSqaE48s
   ZUkwxxnWzYb9YzsYFATkin9vY8LkK791AKESiFprMUEEaqPmALO3gY6dB
   Q==;
X-CSE-ConnectionGUID: TZtGP/UTSICHaBUsTGBIaA==
X-CSE-MsgGUID: Rudz4ZU0SlmdJt/RNlGUpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4450661"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4450661"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 14:51:55 -0800
X-CSE-ConnectionGUID: 6IsUBNbXT2qbdb5gX2byVw==
X-CSE-MsgGUID: VzQRx/u9Q6qIhqZa13CSNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11996936"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 25 Nov 2026 14:51:55 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	willemb@google.com,
	netdev@vger.kernel.org
Cc: Tian Xun Ng <tianxun.ng@bytedance.com>,
	anthony.l.nguyen@intel.com,
	oss.patchbox@gmail.com,
	emil.s.tantilov@intel.com,
	richardcochran@gmail.com,
	milena.olech@intel.com,
	konstantin.ilichev@intel.com,
	stable@vger.kernel.org,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 2/6] idpf: ignore Tx timestamp replies once removal has started
Date: Wed, 25 Nov 2026 14:51:39 -0800
Message-ID: <20261125225145.4126333-3-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261125225145.4126333-1-anthony.l.nguyen@intel.com>
References: <20261125225145.4126333-1-anthony.l.nguyen@intel.com>
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

From: Tian Xun Ng <tianxun.ng@bytedance.com>

On remove, idpf_vc_core_deinit() keeps the virtchnl transaction manager
up until the vports have been torn down, so mbx_task keeps processing
replies while idpf_ptp_release() frees the Tx timestamp trackers. An
async VIRTCHNL2_OP_PTP_GET_VPORT_TX_TSTAMP reply handled in that window
reaches idpf_ptp_get_tx_tstamp_async_handler(), which reads
vport->tx_tstamp_caps and takes its lock after
idpf_ptp_release_vport_tstamp() may already have freed it.

Once IDPF_REMOVE_IN_PROG is set, wait for a mailbox task that may be
running a callback before releasing anything, and make the Tx timestamp
callback return when the bit is set. Matched replies to synchronous
transactions are not affected, so the vport teardown still receives
them; mbx_task is requeued straight away for that.

The last patch of this series sets IDPF_REMOVE_IN_PROG on shutdown too,
which would otherwise expose shutdown to the same window.

Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
Cc: stable@vger.kernel.org
Signed-off-by: Tian Xun Ng <tianxun.ng@bytedance.com>
Reviewed-by: Emil Tantilov <emil.s.tantilov@intel.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c     | 12 +++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c |  3 ++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index c89783966bae..348c7875134a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3262,8 +3262,18 @@ void idpf_vc_core_deinit(struct idpf_adapter *adapter)
 
 	/* Avoid transaction timeouts when called during reset */
 	remove_in_prog = test_bit(IDPF_REMOVE_IN_PROG, adapter->flags);
-	if (!remove_in_prog)
+	if (!remove_in_prog) {
 		libie_ctlq_xn_shutdown(adapter->xnm);
+	} else {
+		/* The transaction manager stays up for the teardown below, so
+		 * async replies can still arrive. Wait for a mailbox task that
+		 * may be running an async callback; callbacks that run later
+		 * see IDPF_REMOVE_IN_PROG and leave the state released below
+		 * alone.
+		 */
+		cancel_delayed_work_sync(&adapter->mbx_task);
+		queue_delayed_work(adapter->mbx_wq, &adapter->mbx_task, 0);
+	}
 
 	idpf_ptp_release(adapter);
 	idpf_deinit_task(adapter);
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
index 14dba40a993f..1422b30d09a3 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl_ptp.c
@@ -550,7 +550,8 @@ idpf_ptp_get_tx_tstamp_async_handler(void *ctx, struct kvec *mem, int status)
 	u16 num_latches;
 	u32 vport_id;
 
-	if (status)
+	/* The Tx timestamp trackers are released on remove and shutdown */
+	if (status || test_bit(IDPF_REMOVE_IN_PROG, adapter->flags))
 		return;
 
 	recv_tx_tstamp_msg = mem->iov_base;
-- 
2.47.1

