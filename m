Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4823B14AF
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784836744; cv=none; b=OjD0I/MliExEK5rGR4uZlkN5VSr1lwHfoJ3kOpUNZW92jYASyvLE2rluMQjdRxYPsSFrXKkgyV1NgfAvQR7/HYt7ENRxYvXyFQATi/zlUFBombs82YRm+9ODucSjfm7VbxpB5XlKxJ0JdhxEGkqLCmELBWo07HYmQjsGy8+jiuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784836744; c=relaxed/simple;
	bh=JXhixZKLzM1QRFPGdkuVglLeVJ3mGkMRqGHWYszYmlU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sw8nyL5WO4mkUFr4Uio5r53v94bnDOfFfxS1T3pwSAcdI8AcviaRaXJnvmpHbC6ZMLLD5eaZRqBMLCiLewrXw0CL6VuBCsLUCRNktFusNQTtqEHYA6PN56hxepqMMGi+QM3oYCNU7PVNJa3exRHl2jnp/dENJEQM/8OgyZUmPO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sr4rJ4yC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sr4rJ4yC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E441F000E9;
	Thu, 23 Jul 2026 19:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784836740;
	bh=49+iDMEZ92Zjx0smVVY3FwIEkZeE7pWo7NJ+6n36Qb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sr4rJ4yCm3dP2XuILJZt4eF9NZdBo8MEOXDST8qnhvZQ+3N3mTN6lwp0PCBLzYjL8
	 sX5W/6XwpYmt+g6Bv/aKoMDl6BSKnXJK8pK6t1pfvhBsjSovgjwAKQie+097hLMNa2
	 bztPVkpLoTISREHu6GAwo953h5dT17l+w/bUJg3iqNcxXEmWBuHAio3/hRtFGRKvZB
	 +5nbqUQ28PaZsBwpKiQPom8Nyn/lSIfYzcaWVSpoankw3XMzQAzyNCXCz+Ngn+QCDL
	 rnE2G8D4f8Y6sHDk9AR+UUQPPeVdgv+rZY6ilhkig+YCye0B+3x/T1qhqZp8HAU5RJ
	 cIHWg9wfGNm9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tanmay Shah <tanmay.shah@amd.com>,
	Beleswar Padhi <b-padhi@ti.com>,
	Michal Simek <michal.simek@amd.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] remoteproc: xlnx: Check remote core state
Date: Thu, 23 Jul 2026 15:58:58 -0400
Message-ID: <20260723195858.3684427-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072001-fleshy-why-ba7d@gregkh>
References: <2026072001-fleshy-why-ba7d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tanmay Shah <tanmay.shah@amd.com>

[ Upstream commit a48df51d23138388900995add2854cda4aa68e55 ]

The remote state is set to RPROC_DETACHED if the resource table is found
in the memory. However, this can be wrong if the remote is not started,
but firmware is still loaded in the memory. Use PM_GET_NODE_STATUS call
to the firmware to request the state of the RPU node. If the RPU is
actually out of reset and running, only then move the remote state to
RPROC_DETACHED, otherwise keep the remote state to RPROC_OFFLINE.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
Fixes: bca4b02ef92e ("remoteproc: xlnx: Add attach detach support")
Reviewed-by: Beleswar Padhi <b-padhi@ti.com>
Acked-by: Michal Simek <michal.simek@amd.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20260428221855.313752-1-tanmay.shah@amd.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
[ replaced the unavailable zynqmp_pm_get_node_status() helper with a direct zynqmp_pm_invoke_fn() call and exported it for modular builds. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/xilinx/zynqmp.c        |  1 +
 drivers/remoteproc/xlnx_r5_remoteproc.c | 50 ++++++++++++++++++++-----
 include/linux/firmware/xlnx-zynqmp.h    | 13 +++++++
 3 files changed, 54 insertions(+), 10 deletions(-)

diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
index 02da3e48bc8f35..dc9c5d32108d57 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -461,6 +461,7 @@ int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 *ret_payload, u32 num_args, ...)
 	return do_fw_call(ret_payload, 8, smc_arg[0], smc_arg[1], smc_arg[2], smc_arg[3],
 			  smc_arg[4], smc_arg[5], smc_arg[6], smc_arg[7]);
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_invoke_fn);
 
 static u32 pm_api_version;
 static u32 pm_tz_version;
diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index 5ef586fd37bca3..a238b45bf2f2c6 100644
--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
@@ -959,16 +959,6 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
 		goto free_rproc;
 	}
 
-	/*
-	 * If firmware is already available in the memory then move rproc state
-	 * to DETACHED. Firmware can be preloaded via debugger or by any other
-	 * agent (processors) in the system.
-	 * If firmware isn't available in the memory and resource table isn't
-	 * found, then rproc state remains OFFLINE.
-	 */
-	if (!zynqmp_r5_get_rsc_table_va(r5_core))
-		r5_rproc->state = RPROC_DETACHED;
-
 	r5_core->rproc = r5_rproc;
 	return r5_core;
 
@@ -1221,6 +1211,7 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
 {
 	struct device *dev = cluster->dev;
 	struct zynqmp_r5_core *r5_core;
+	u32 payload[PAYLOAD_ARG_CNT];
 	int ret = -EINVAL, i;
 
 	r5_core = cluster->r5_cores[0];
@@ -1266,6 +1257,45 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
 		ret = zynqmp_r5_get_sram_banks(r5_core);
 		if (ret)
 			return ret;
+
+		/*
+		 * It is possible that firmware is loaded into the memory, but
+		 * RPU (remote) is not running. In such case, RPU state will be
+		 * moved to RPROC_DETACHED wrongfully. To avoid it first make
+		 * sure RPU is power-on and out of reset before parsing for the
+		 * resource table.
+		 */
+		ret = zynqmp_pm_feature(PM_GET_NODE_STATUS);
+		if (ret < PM_API_VERSION_2)
+			ret = -EOPNOTSUPP;
+		else
+			ret = zynqmp_pm_invoke_fn(PM_GET_NODE_STATUS, payload, 1,
+						  r5_core->pm_domain_id);
+		if (ret) {
+			dev_warn(r5_core->dev,
+				 "failed to get rpu node status, err %d\n", ret);
+			continue;
+		}
+
+		/*
+		 * If RPU state is power on and out of reset i.e. running, then
+		 * assign RPROC_DETACHED state. If the RPU is not out of reset
+		 * then do not attempt to attach to the remote processor.
+		 */
+		if (payload[1] == PM_NODE_RUNNING) {
+			/*
+			 * Not all the firmware that is running on the remote
+			 * core is expected to have the resource table. The
+			 * firmware might not use RPMsg at all, and in that case
+			 * resource table becomes irrelevant. However, we still
+			 * need to make sure that running core is not reported
+			 * as offline. so do not decide remote core state based
+			 * on the resource table availability
+			 */
+			if (zynqmp_r5_get_rsc_table_va(r5_core))
+				dev_dbg(r5_core->dev, "rsc tbl not found\n");
+			r5_core->rproc->state = RPROC_DETACHED;
+		}
 	}
 
 	return 0;
diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
index ae48d619c4e0ac..2f1c71f0cea76c 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -164,6 +164,7 @@ enum pm_api_cb_id {
 enum pm_api_id {
 	PM_API_FEATURES = 0,
 	PM_GET_API_VERSION = 1,
+	PM_GET_NODE_STATUS = 3,
 	PM_REGISTER_NOTIFIER = 5,
 	PM_FORCE_POWERDOWN = 8,
 	PM_REQUEST_WAKEUP = 10,
@@ -544,6 +545,18 @@ enum pm_gem_config_type {
 	GEM_CONFIG_FIXED = 2,
 };
 
+/**
+ * enum pm_node_status - Device node status provided by xilpm fw
+ * @PM_NODE_UNUSED: Device is not used
+ * @PM_NODE_RUNNING: Device is power-on and out of reset
+ * @PM_NODE_HALT: Device is power-on but in the reset state
+ */
+enum pm_node_status {
+	PM_NODE_UNUSED = 0,
+	PM_NODE_RUNNING = 1,
+	PM_NODE_HALT = 12,
+};
+
 /**
  * struct zynqmp_pm_query_data - PM query data
  * @qid:	query ID
-- 
2.53.0

