Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47C01419A4
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 01:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784856302; cv=none; b=kV2DAM1mn6Yug34I3/sVQeG1pu9C82/VEML+H4lhqpFC7BB+4p2nMDI7++cX7VvHU4kWtqgB6OCDzIr2GAaUKP9cKoNpXuRBvpjM7zda95XRMo/uccxZ2mBGTsakvNi3bqD4c7H+12H765/0mRPD0GE+aE/dwJbp5E0Gcy4QCR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784856302; c=relaxed/simple;
	bh=2gKDLoklNsi19H9aCzD1oqHhyBAGgnhHAOe5yObL2cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DpzJvv8Vo2EUthB2ao+3Sp7w3NjbDYRlv0g4kdzyOz+ReHPm5WluWNa0BUNfErQ/b1Wousseg9I4SNxJzQr7h3SpkdOS65Qy8ARAeAOqJcqldxd8Z3An4xehvUourTXPWOfkB9N5C+OWRKvuStNe7AkALwCPfkxKDeCUds7Kxvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L50rqSLI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L50rqSLI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B531F00A3D;
	Fri, 24 Jul 2026 01:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784856299;
	bh=Asw3Y5GK3bQs2B2Q5PlXfq3NAjRXaQG3+svdCK2/YtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L50rqSLIbBsQ3Pu4f11O1Zgz00Kz4wdzcLa4Fz6QCyCpiJTb3mMJnI+aZ1RDB3o1w
	 n706y1on5dY9hPWgND1exbK64z2839dW+QPMf9lVEqBoP9MDTfJHGJIMUrMEULsbrD
	 uC1KiitK+NPBDqyFFFGKdbw1TMeM2J8YaJffXhmtnQJtm7PsnJMVzRSoLLI+8ScC8t
	 p4w1ULwwmxIgq/0/fLxzw2brHEDfajs2S3VCnpAh7FDOyoLPlpuQSUHElmONQkVsT+
	 y8xPqLN1fBFUV97soYSFa1V0D0RyYvb0gcmPR4OIxoAPpWAQYIwLK5qJLrRItOFRqc
	 kvjai/pE2OJYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tanmay Shah <tanmay.shah@amd.com>,
	Beleswar Padhi <b-padhi@ti.com>,
	Michal Simek <michal.simek@amd.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] remoteproc: xlnx: Check remote core state
Date: Thu, 23 Jul 2026 21:24:56 -0400
Message-ID: <20260724012456.3832700-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072002-pelican-liftoff-70cd@gregkh>
References: <2026072002-pelican-liftoff-70cd@gregkh>
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
index 5578158f13750c..7d4c7c248d9c41 100644
--- a/drivers/firmware/xilinx/zynqmp.c
+++ b/drivers/firmware/xilinx/zynqmp.c
@@ -386,6 +386,7 @@ int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 *ret_payload, u32 num_args, ...)
 	return do_fw_call(ret_payload, 8, smc_arg[0], smc_arg[1], smc_arg[2], smc_arg[3],
 			  smc_arg[4], smc_arg[5], smc_arg[6], smc_arg[7]);
 }
+EXPORT_SYMBOL_GPL(zynqmp_pm_invoke_fn);
 
 static u32 pm_api_version;
 static u32 pm_tz_version;
diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index d1c069704da8d9..88561f282f9bc4 100644
--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
@@ -927,16 +927,6 @@ static struct zynqmp_r5_core *zynqmp_r5_add_rproc_core(struct device *cdev)
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
 
@@ -1189,6 +1179,7 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
 {
 	struct device *dev = cluster->dev;
 	struct zynqmp_r5_core *r5_core;
+	u32 payload[PAYLOAD_ARG_CNT];
 	int ret = -EINVAL, i;
 
 	r5_core = cluster->r5_cores[0];
@@ -1234,6 +1225,45 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
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
index d7d07afc0532d7..e1f3f2053cc1d8 100644
--- a/include/linux/firmware/xlnx-zynqmp.h
+++ b/include/linux/firmware/xlnx-zynqmp.h
@@ -143,6 +143,7 @@ enum pm_api_cb_id {
 enum pm_api_id {
 	PM_API_FEATURES = 0,
 	PM_GET_API_VERSION = 1,
+	PM_GET_NODE_STATUS = 3,
 	PM_REGISTER_NOTIFIER = 5,
 	PM_FORCE_POWERDOWN = 8,
 	PM_REQUEST_WAKEUP = 10,
@@ -518,6 +519,18 @@ enum pm_gem_config_type {
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

