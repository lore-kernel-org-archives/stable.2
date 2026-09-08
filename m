Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEA14E8DED;
	Tue,  8 Sep 2026 21:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788903914; cv=none; b=JB36N7T+aNU6hqymAPMyjondHiBuUW5Tw/GMcsZOiWVKp3Ji6YQdEGVIrA6i9MPNoXxRNZin8s+S4OTYOy7uGtP8ci/MpmPfJyTANKlMVR+JqHebWQ/ZUN3dbm7umsvE3+akYwtPK8srv9eoesSWXc53wmj9mKupg8QZ73NquLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788903914; c=relaxed/simple;
	bh=FfR0aWZBhU/wTv65AvoItant66VOF26Dmn1lIGg+fGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rydUZb5SfEhNxNos+QFEE8yq3p/bWtVUUeOxR1TMWhWMLlleTvFjzlEyh91pIBtDpZf3yXCYiUzVvX+a2oswLeUa41jyZH9CS0n0ByNv0npmJtW80baD6ITyxNF3Y+zGanTysZWg9yRRmA2jwTUptNDwKmsKUlXRuVNnHVpPlsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d8gf9wx9; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d8gf9wx9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788903912; x=1820439912;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FfR0aWZBhU/wTv65AvoItant66VOF26Dmn1lIGg+fGo=;
  b=d8gf9wx9e/TP829SOH48ABk4T579Jrtsmwb9Iu9dEPH1drCgV8W6188y
   LDkcZYsGbNILOEfQYv9r+mjWLP0zoY2pO34sDLE9KQXdj059VCBATbSRn
   j6KnZfXMyHTOXJeD3wzL2TH1uPgv62ouvbD4Nzm5pHzAJ+LdXUaU793/P
   9CmYqraBrZzmYhR3GlfV6zCO65r9z7sw+N8rj9M5EU7Ta27we1xeSVXN2
   Get7st3maQU+UDL+amsyhfDmk0bUJlVZUMyoks6Cq5Y1hxYnCRc4y+Pc2
   Lo/FEjuMnrvAnk6ej3j0Yl/euSFD5lhgyorjz+kqnkNNbGqR9olyQVQ64
   A==;
X-CSE-ConnectionGUID: ma7m7GbwQuaHrem3dJr1XQ==
X-CSE-MsgGUID: iFwyeitzTbCmawEDO/8uRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="106836220"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="106836220"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 14:45:09 -0700
X-CSE-ConnectionGUID: 96lnYt9nS1G+qAJogwSa5g==
X-CSE-MsgGUID: axy68LGRQXCNTcZAN+vsDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="269782504"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 08 Sep 2026 14:45:08 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	anthony.l.nguyen@intel.com,
	ae878000@gmail.com,
	joshua.a.hay@intel.com,
	sridhar.samudrala@intel.com,
	milena.olech@intel.com,
	vadim.fedorenko@linux.dev,
	willemb@google.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	jbrandeb@kernel.org,
	stable@vger.kernel.org,
	Samuel Salin <Samuel.salin@intel.com>
Subject: [PATCH net 1/5] idpf: disable DIM work before freeing q_vectors
Date: Tue,  8 Sep 2026 14:44:56 -0700
Message-ID: <20260908214502.528440-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260908214502.528440-1-anthony.l.nguyen@intel.com>
References: <20260908214502.528440-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Myeonghun Pak <mhun512@gmail.com>

idpf never drains the Tx/Rx DIM works before freeing the memory they
live in.  tx_dim and rx_dim are embedded in struct idpf_q_vector, they
are queued from the NAPI poll via net_dim(), and idpf_vport_intr_rel()
ends with kfree(rsrc->q_vectors).  Nothing in the driver cancels them.

idpf_tx_dim_work() and idpf_rx_dim_work() then run on freed memory:
idpf_vport_intr_write_itr() writes the ITR register through
q_vector->intr_reg.tx_itr / rx_itr, void __iomem pointers loaded out of
the freed q_vector.  No configuration is needed to get there --
IDPF_ITR_IS_DYNAMIC() is defined as (itr_mode) and idpf_vport_alloc()
initialises both modes to IDPF_ITR_DYNAMIC.

Draining after idpf_vport_intr_napi_dis_all() is not enough on its own.
idpf_net_dim() is called from inside the
"if (napi_complete_done(napi, work_done))" branch of the poll, and
napi_complete_done() has already cleared NAPIF_STATE_SCHED by then.
napi_disable_locked() waits only while (val & (NAPIF_STATE_SCHED |
NAPIF_STATE_NPSVC)), so napi_disable() can return while the poll tail is
still queueing the work, and a plain cancel_work_sync() would be
re-armed behind the drain.

Use disable_work_sync(): schedule_work() on a work with a non-zero
disable count is dropped by clear_pending_if_disabled() before
__queue_work() is reached.

Move idpf_init_dim() to idpf_vport_intr_alloc() so the works are
initialised on every path that can reach the drain -- the three
"goto intr_deinit" sites between idpf_vport_intr_init() and
idpf_vport_intr_ena() get there without the enable side having run.
Nothing re-enables them: rsrc->q_vectors is freed on every exit from
idpf_vport_open() and on every idpf_vport_stop(), so the count dies with
the object.

It is a race, not a deterministic failure -- net_dim() only schedules
once DIM_NEVENTS events have accumulated and the profile index changes.
A KASAN ifup/ifdown loop under load is the way to see it.

Fixes: c2d548cad150 ("idpf: add TX splitq napi poll support")
Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
Cc: <stable@vger.kernel.org> # see patch description, needs adjustments for <= 6.9
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Tested-by: Samuel Salin <Samuel.salin@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 24 ++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 24b91be25676..9ba9c2952d78 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4145,6 +4145,26 @@ static void idpf_vport_intr_ena_irq_all(struct idpf_vport *vport,
 	writel(rsrc->noirq_dyn_ctl_ena, rsrc->noirq_dyn_ctl);
 }
 
+/**
+ * idpf_vport_intr_dis_dim_all - Disable DIM work for all q_vectors
+ * @rsrc: pointer to queue and vector resources
+ *
+ * The DIM works are embedded in the q_vector array that
+ * idpf_vport_intr_rel() frees, and the poll arms them after
+ * napi_complete_done() has already cleared NAPI_STATE_SCHED.  Disable
+ * rather than just cancel, so that a poll tail still running past
+ * napi_disable() cannot queue them again behind the drain.
+ */
+static void idpf_vport_intr_dis_dim_all(struct idpf_q_vec_rsrc *rsrc)
+{
+	for (u16 v_idx = 0; v_idx < rsrc->num_q_vectors; v_idx++) {
+		struct idpf_q_vector *q_vector = &rsrc->q_vectors[v_idx];
+
+		disable_work_sync(&q_vector->tx_dim.work);
+		disable_work_sync(&q_vector->rx_dim.work);
+	}
+}
+
 /**
  * idpf_vport_intr_deinit - Release all vector associations for the vport
  * @vport: main vport structure
@@ -4155,6 +4175,7 @@ void idpf_vport_intr_deinit(struct idpf_vport *vport,
 {
 	idpf_vport_intr_dis_irq_all(rsrc);
 	idpf_vport_intr_napi_dis_all(rsrc);
+	idpf_vport_intr_dis_dim_all(rsrc);
 	idpf_vport_intr_napi_del_all(rsrc);
 	idpf_vport_intr_rel_irq(vport, rsrc);
 }
@@ -4235,7 +4256,6 @@ static void idpf_vport_intr_napi_ena_all(struct idpf_q_vec_rsrc *rsrc)
 	for (u16 q_idx = 0; q_idx < rsrc->num_q_vectors; q_idx++) {
 		struct idpf_q_vector *q_vector = &rsrc->q_vectors[q_idx];
 
-		idpf_init_dim(q_vector);
 		napi_enable(&q_vector->napi);
 	}
 }
@@ -4578,6 +4598,8 @@ int idpf_vport_intr_alloc(struct idpf_vport *vport,
 		q_coal = &user_config->q_coalesce[v_idx];
 		q_vector->vport = vport;
 
+		idpf_init_dim(q_vector);
+
 		q_vector->tx_itr_value = q_coal->tx_coalesce_usecs;
 		q_vector->tx_intr_mode = q_coal->tx_intr_mode;
 		q_vector->tx_itr_idx = VIRTCHNL2_ITR_IDX_1;
-- 
2.47.1

