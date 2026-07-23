Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884FE233704
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 18:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784830372; cv=none; b=bOp+DXdVKlvzsdiBx8uNfd1USKmHEVxDMZbjR4dQ8iDBvazux71gYEGATA48WAfIp2HV8AzuTY2CWU1NiukodHRA8UyNCiUj3/d183iZuxkZlpWGqKEj9v2mnDjA3wbI5tBRajuFk1F1lv0bxUIZd0/79OGxRvuOhR6rSuLKS/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784830372; c=relaxed/simple;
	bh=ol+H1I3+Pvn6k+hOJYgzfYCIp9+MGKQJ2YBjTD3js3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCojqeWZ4PJSQPjER7dpui2mjqRHjf1vtAHQRigJyfuBvDuHFU1jk4cGUJDLPJ218Si6lKp3BbTNdVR/jv0B+k82el3i0vmUhgz2IJ/FAMdbmzb52fR4At+CyvwUGEg/ebbtxwqKuHBacq2Lg39CEFPaExM4M+LHe51sUNMHH0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589AF1F00A3A;
	Thu, 23 Jul 2026 18:12:48 +0000 (UTC)
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yogesh Lal <quic_ylal@quicinc.com>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] remoteproc: qcom: pas: Adjust the phys addr wrt the mem region
Date: Thu, 23 Jul 2026 14:12:41 -0400
Message-ID: <20260723181242.3433785-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723181242.3433785-1-sashal@kernel.org>
References: <2026072052-islamic-scorecard-54c2@gregkh>
 <20260723181242.3433785-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yogesh Lal <quic_ylal@quicinc.com>

[ Upstream commit a376c10d45a8e6ee5ea55791193f90625b35e156 ]

The minidump table in the toc contains physical addresses that may lie
before the physical address of the first elf segment in relocatable
images. This change adds a custom dump function for minidumps which
calculates the offset into the carveout region using the start of
the physical address instead of the start of the first elf segment.

Signed-off-by: Yogesh Lal <quic_ylal@quicinc.com>
Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/1667409129-6254-1-git-send-email-quic_ylal@quicinc.com
Stable-dep-of: ecf9fc18e62c ("remoteproc: qcom: Fix leak when custom dump_segments addition fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/qcom_common.c   | 13 +++++++++----
 drivers/remoteproc/qcom_common.h   |  5 ++++-
 drivers/remoteproc/qcom_q6v5_pas.c | 20 +++++++++++++++++++-
 3 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/drivers/remoteproc/qcom_common.c b/drivers/remoteproc/qcom_common.c
index 10a35560e19123..041199065fc7fb 100644
--- a/drivers/remoteproc/qcom_common.c
+++ b/drivers/remoteproc/qcom_common.c
@@ -101,7 +101,9 @@ static void qcom_minidump_cleanup(struct rproc *rproc)
 	}
 }
 
-static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsystem *subsystem)
+static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsystem *subsystem,
+			void (*rproc_dumpfn_t)(struct rproc *rproc, struct rproc_dump_segment *segment,
+				void *dest, size_t offset, size_t size))
 {
 	struct minidump_region __iomem *ptr;
 	struct minidump_region region;
@@ -131,7 +133,7 @@ static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsy
 			}
 			da = le64_to_cpu(region.address);
 			size = le64_to_cpu(region.size);
-			rproc_coredump_add_custom_segment(rproc, da, size, NULL, name);
+			rproc_coredump_add_custom_segment(rproc, da, size, rproc_dumpfn_t, name);
 		}
 	}
 
@@ -139,7 +141,10 @@ static int qcom_add_minidump_segments(struct rproc *rproc, struct minidump_subsy
 	return 0;
 }
 
-void qcom_minidump(struct rproc *rproc, unsigned int minidump_id)
+void qcom_minidump(struct rproc *rproc, unsigned int minidump_id,
+		void (*rproc_dumpfn_t)(struct rproc *rproc,
+		struct rproc_dump_segment *segment, void *dest, size_t offset,
+		size_t size))
 {
 	int ret;
 	struct minidump_subsystem *subsystem;
@@ -169,7 +174,7 @@ void qcom_minidump(struct rproc *rproc, unsigned int minidump_id)
 		return;
 	}
 
-	ret = qcom_add_minidump_segments(rproc, subsystem);
+	ret = qcom_add_minidump_segments(rproc, subsystem, rproc_dumpfn_t);
 	if (ret) {
 		dev_err(&rproc->dev, "Failed with error: %d while adding minidump entries\n", ret);
 		goto clean_minidump;
diff --git a/drivers/remoteproc/qcom_common.h b/drivers/remoteproc/qcom_common.h
index c35adf730be05f..c3cc6194e4839f 100644
--- a/drivers/remoteproc/qcom_common.h
+++ b/drivers/remoteproc/qcom_common.h
@@ -33,7 +33,10 @@ struct qcom_rproc_ssr {
 	struct qcom_ssr_subsystem *info;
 };
 
-void qcom_minidump(struct rproc *rproc, unsigned int minidump_id);
+void qcom_minidump(struct rproc *rproc, unsigned int minidump_id,
+			void (*rproc_dumpfn_t)(struct rproc *rproc,
+				struct rproc_dump_segment *segment, void *dest, size_t offset,
+				size_t size));
 
 void qcom_add_glink_subdev(struct rproc *rproc, struct qcom_rproc_glink *glink,
 			   const char *ssr_name);
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 776319ab1baf9b..f8661035803c26 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -83,6 +83,24 @@ struct qcom_adsp {
 	struct qcom_sysmon *sysmon;
 };
 
+void adsp_segment_dump(struct rproc *rproc, struct rproc_dump_segment *segment,
+		       void *dest, size_t offset, size_t size)
+{
+	struct qcom_adsp *adsp = rproc->priv;
+	int total_offset;
+
+	total_offset = segment->da + segment->offset + offset - adsp->mem_phys;
+	if (total_offset < 0 || total_offset + size > adsp->mem_size) {
+		dev_err(adsp->dev,
+			"invalid copy request for segment %pad with offset %zu and size %zu)\n",
+			&segment->da, offset, size);
+		memset(dest, 0xff, size);
+		return;
+	}
+
+	memcpy_fromio(dest, adsp->mem_region + total_offset, size);
+}
+
 static void adsp_minidump(struct rproc *rproc)
 {
 	struct qcom_adsp *adsp = rproc->priv;
@@ -90,7 +108,7 @@ static void adsp_minidump(struct rproc *rproc)
 	if (rproc->dump_conf == RPROC_COREDUMP_DISABLED)
 		return;
 
-	qcom_minidump(rproc, adsp->minidump_id);
+	qcom_minidump(rproc, adsp->minidump_id, adsp_segment_dump);
 }
 
 static int adsp_pds_enable(struct qcom_adsp *adsp, struct device **pds,
-- 
2.53.0

