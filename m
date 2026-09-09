Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD64A534445
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951268; cv=none; b=Y5byTowDFEQumUnYlgNfs1Jhlzw+wY9Lu0WWJ0mr2UZIWDvSasdjaYpEcU6dMCXFkUoVgFzY7QvGgHR/sqzJ2IyowMR1rUGULt51z+91Nf8IX8bBet83CAWc6xzf43lzJQkkXPYWyZgcoNyprPlFncuwioYifAWVSeVRiPEYhKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951268; c=relaxed/simple;
	bh=zlc14yRTo3McCWYdkQyQbeZSwLbwdn1uZ4d8AGrPbVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NciX2oy5NCA+7Pz3beVt3+PLPgiXxba5X1dgkRs7jQwgDmZyxMQhot+22pCG+Tyid0X2MFKbnLFqMuGvB+9/HLZu3/wrC6oH+C0pl3H6RWhrqbxtzC/TeBPNnbjA21HDHDG3tUNH/cVqsFeTndH3zu2usnDrRzIOGBgn1TJNvQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTWUleP9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTWUleP9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A776B1F00A3F;
	Wed,  9 Sep 2026 10:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788951265;
	bh=EF9VIUEFANj7miEfR4JUhgWgeKkTbUfWFVynMtYH/2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KTWUleP98TH+7wM6JMMnGdx+XpzM59oScDjvtQIb7n5Vvc33/suk0zD81LpjaWX19
	 CIyyZ89bckiPJe0mbTVHqxurpjIvD2wpAkk1Lq7Foe4yvA85MmH+k/WDK6EXk9prPM
	 lJsxN3bfn7lXDsCOMdpi7BK66tzP3Q7W27qo9fkR4PZuZC7Hdm3HjDwJkkA3bf0vJ/
	 thZZ45GEeWu54dEJml6ww0LHMwrCBKxoBYH6xwYcXbc07HnunZRMW+RgAAdJmehuHl
	 iRW5HF7Y/hSJer7KhB1iykD/XpFn3qOPshk9MhRgwe3EgHgC/kH49h/AtaNi1le0rn
	 QupZnSt2lKsKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] remoteproc: pas: Replace metadata context with PAS context structure
Date: Wed,  9 Sep 2026 06:54:21 -0400
Message-ID: <20260909105422.1620618-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909105422.1620618-1-sashal@kernel.org>
References: <2026090336-snowiness-uncle-0a18@gregkh>
 <20260909105422.1620618-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>

[ Upstream commit b13d8baf56016e7eec29395b52d18b91df081d48 ]

As a superset of the existing metadata context, the PAS context
structure enables both remoteproc and non-remoteproc subsystems to
better support scenarios where the SoC runs with or without the Gunyah
hypervisor. To reflect this, relevant SCM and metadata functions are
updated to incorporate PAS context awareness and remove metadata context
data structure completely.

Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20260105-kvmrprocv10-v10-5-022e96815380@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

Stable adaptation for c06c5ab4945392d2c2aded6d832ab6b58cabe351:

This tree has neither the PAS context allocator nor the later generic
PAS service and context-aware MDT loader. Define the PAS context in the
existing SCM header and allocate and initialize it in adsp_probe() using
devm_kzalloc(), without adding any functions. Keep the stable MDT loader
interfaces and update their existing context arguments and declarations.

Rename the existing metadata release implementation and its callers to
qcom_pas_metadata_release(), as used by the target fix. Keep the driver's
adsp names except for the local PAS pointer in adsp_load(). Handle DTB
initialization failure inline, preserving its existing cleanup behavior,
so that the target can remove the shared load-failure cleanup label. The
remaining load-failure path and its context now support a clean three-way
cherry-pick of the target without importing the newer loader helper.

Stable-dep-of: c06c5ab49453 ("remoteproc: qcom: pas: Guard dtb metadata release with dtb_pas_id check")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/qcom/qcom_scm.c       | 14 ++---
 drivers/remoteproc/qcom_q6v5_pas.c     | 84 ++++++++++++++++----------
 drivers/soc/qcom/mdt_loader.c          |  4 +-
 include/linux/firmware/qcom/qcom_scm.h | 10 ++-
 include/linux/soc/qcom/mdt_loader.h    |  6 +-
 5 files changed, 72 insertions(+), 46 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 1609458ccc772..42a5caa406a43 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -567,16 +567,16 @@ static void qcom_scm_set_download_mode(u32 dload_mode)
  *		and optional blob of data used for authenticating the metadata
  *		and the rest of the firmware
  * @size:	size of the metadata
- * @ctx:	optional metadata context
+ * @ctx:	optional pas context
  *
  * Return: 0 on success.
  *
  * Upon successful return, the PAS metadata context (@ctx) will be used to
  * track the metadata allocation, this needs to be released by invoking
- * qcom_scm_pas_metadata_release() by the caller.
+ * qcom_pas_metadata_release() by the caller.
  */
 int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
-			    struct qcom_scm_pas_metadata *ctx)
+			    struct qcom_scm_pas_context *ctx)
 {
 	dma_addr_t mdata_phys;
 	void *mdata_buf;
@@ -639,10 +639,10 @@ int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
 EXPORT_SYMBOL_GPL(qcom_scm_pas_init_image);
 
 /**
- * qcom_scm_pas_metadata_release() - release metadata context
- * @ctx:	metadata context
+ * qcom_pas_metadata_release() - release metadata context
+ * @ctx:	pas context
  */
-void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx)
+void qcom_pas_metadata_release(struct qcom_scm_pas_context *ctx)
 {
 	if (!ctx->ptr)
 		return;
@@ -653,7 +653,7 @@ void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx)
 	ctx->phys = 0;
 	ctx->size = 0;
 }
-EXPORT_SYMBOL_GPL(qcom_scm_pas_metadata_release);
+EXPORT_SYMBOL_GPL(qcom_pas_metadata_release);
 
 /**
  * qcom_scm_pas_mem_setup() - Prepare the memory related to a given peripheral
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index ea4a91f37b506..d7f84eb5b7f9a 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -115,8 +115,8 @@ struct qcom_adsp {
 	struct qcom_rproc_ssr ssr_subdev;
 	struct qcom_sysmon *sysmon;
 
-	struct qcom_scm_pas_metadata pas_metadata;
-	struct qcom_scm_pas_metadata dtb_pas_metadata;
+	struct qcom_scm_pas_context *pas_ctx;
+	struct qcom_scm_pas_context *dtb_pas_ctx;
 };
 
 static void adsp_segment_dump(struct rproc *rproc, struct rproc_dump_segment *segment,
@@ -203,47 +203,50 @@ static int adsp_unprepare(struct rproc *rproc)
 	struct qcom_adsp *adsp = rproc->priv;
 
 	/*
-	 * adsp_load() did pass pas_metadata to the SCM driver for storing
+	 * adsp_load() did pass the PAS context to the SCM driver for storing
 	 * metadata context. It might have been released already if
 	 * auth_and_reset() was successful, but in other cases clean it up
 	 * here.
 	 */
-	qcom_scm_pas_metadata_release(&adsp->pas_metadata);
+	qcom_pas_metadata_release(adsp->pas_ctx);
 	if (adsp->dtb_pas_id)
-		qcom_scm_pas_metadata_release(&adsp->dtb_pas_metadata);
+		qcom_pas_metadata_release(adsp->dtb_pas_ctx);
 
 	return 0;
 }
 
 static int adsp_load(struct rproc *rproc, const struct firmware *fw)
 {
-	struct qcom_adsp *adsp = rproc->priv;
+	struct qcom_adsp *pas = rproc->priv;
 	int ret;
 
 	/* Store firmware handle to be used in adsp_start() */
-	adsp->firmware = fw;
+	pas->firmware = fw;
 
-	if (adsp->lite_pas_id)
-		ret = qcom_scm_pas_shutdown(adsp->lite_pas_id);
+	if (pas->lite_pas_id)
+		ret = qcom_scm_pas_shutdown(pas->lite_pas_id);
 
-	if (adsp->dtb_pas_id) {
-		ret = request_firmware(&adsp->dtb_firmware, adsp->dtb_firmware_name, adsp->dev);
+	if (pas->dtb_pas_id) {
+		ret = request_firmware(&pas->dtb_firmware, pas->dtb_firmware_name, pas->dev);
 		if (ret) {
-			dev_err(adsp->dev, "request_firmware failed for %s: %d\n",
-				adsp->dtb_firmware_name, ret);
+			dev_err(pas->dev, "request_firmware failed for %s: %d\n",
+				pas->dtb_firmware_name, ret);
 			return ret;
 		}
 
-		ret = qcom_mdt_pas_init(adsp->dev, adsp->dtb_firmware, adsp->dtb_firmware_name,
-					adsp->dtb_pas_id, adsp->dtb_mem_phys,
-					&adsp->dtb_pas_metadata);
-		if (ret)
-			goto release_dtb_firmware;
+		ret = qcom_mdt_pas_init(pas->dev, pas->dtb_firmware, pas->dtb_firmware_name,
+					pas->dtb_pas_id, pas->dtb_mem_phys,
+					pas->dtb_pas_ctx);
+		if (ret) {
+			release_firmware(pas->dtb_firmware);
+			return ret;
+		}
 
-		ret = qcom_mdt_load_no_init(adsp->dev, adsp->dtb_firmware, adsp->dtb_firmware_name,
-					    adsp->dtb_pas_id, adsp->dtb_mem_region,
-					    adsp->dtb_mem_phys, adsp->dtb_mem_size,
-					    &adsp->dtb_mem_reloc);
+		ret = qcom_mdt_load_no_init(
+					pas->dev, pas->dtb_firmware, pas->dtb_firmware_name,
+					pas->dtb_pas_id, pas->dtb_mem_region,
+					pas->dtb_mem_phys, pas->dtb_mem_size,
+					&pas->dtb_mem_reloc);
 		if (ret)
 			goto release_dtb_metadata;
 	}
@@ -251,10 +254,8 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
 	return 0;
 
 release_dtb_metadata:
-	qcom_scm_pas_metadata_release(&adsp->dtb_pas_metadata);
-
-release_dtb_firmware:
-	release_firmware(adsp->dtb_firmware);
+	qcom_pas_metadata_release(pas->dtb_pas_ctx);
+	release_firmware(pas->dtb_firmware);
 
 	return ret;
 }
@@ -302,7 +303,7 @@ static int adsp_start(struct rproc *rproc)
 	}
 
 	ret = qcom_mdt_pas_init(adsp->dev, adsp->firmware, rproc->firmware, adsp->pas_id,
-				adsp->mem_phys, &adsp->pas_metadata);
+				adsp->mem_phys, adsp->pas_ctx);
 	if (ret)
 		goto disable_px_supply;
 
@@ -328,9 +329,9 @@ static int adsp_start(struct rproc *rproc)
 		goto release_pas_metadata;
 	}
 
-	qcom_scm_pas_metadata_release(&adsp->pas_metadata);
+	qcom_pas_metadata_release(adsp->pas_ctx);
 	if (adsp->dtb_pas_id)
-		qcom_scm_pas_metadata_release(&adsp->dtb_pas_metadata);
+		qcom_pas_metadata_release(adsp->dtb_pas_ctx);
 
 	/* Remove pointer to the loaded firmware, only valid in adsp_load() & adsp_start() */
 	adsp->firmware = NULL;
@@ -338,9 +339,9 @@ static int adsp_start(struct rproc *rproc)
 	return 0;
 
 release_pas_metadata:
-	qcom_scm_pas_metadata_release(&adsp->pas_metadata);
+	qcom_pas_metadata_release(adsp->pas_ctx);
 	if (adsp->dtb_pas_id)
-		qcom_scm_pas_metadata_release(&adsp->dtb_pas_metadata);
+		qcom_pas_metadata_release(adsp->dtb_pas_ctx);
 disable_px_supply:
 	if (adsp->px_supply)
 		regulator_disable(adsp->px_supply);
@@ -788,6 +789,27 @@ static int adsp_probe(struct platform_device *pdev)
 	}
 
 	qcom_add_ssr_subdev(rproc, &adsp->ssr_subdev, desc->ssr_name);
+
+	adsp->pas_ctx = devm_kzalloc(adsp->dev, sizeof(*adsp->pas_ctx), GFP_KERNEL);
+	if (!adsp->pas_ctx) {
+		ret = -ENOMEM;
+		goto remove_ssr_sysmon;
+	}
+	adsp->pas_ctx->dev = adsp->dev;
+	adsp->pas_ctx->pas_id = adsp->pas_id;
+	adsp->pas_ctx->mem_phys = adsp->mem_phys;
+	adsp->pas_ctx->mem_size = adsp->mem_size;
+
+	adsp->dtb_pas_ctx = devm_kzalloc(adsp->dev, sizeof(*adsp->dtb_pas_ctx), GFP_KERNEL);
+	if (!adsp->dtb_pas_ctx) {
+		ret = -ENOMEM;
+		goto remove_ssr_sysmon;
+	}
+	adsp->dtb_pas_ctx->dev = adsp->dev;
+	adsp->dtb_pas_ctx->pas_id = adsp->dtb_pas_id;
+	adsp->dtb_pas_ctx->mem_phys = adsp->dtb_mem_phys;
+	adsp->dtb_pas_ctx->mem_size = adsp->dtb_mem_size;
+
 	ret = rproc_add(rproc);
 	if (ret)
 		goto remove_ssr_sysmon;
diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 29124aa6d03b5..f38aada2cabf7 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -234,13 +234,13 @@ EXPORT_SYMBOL_GPL(qcom_mdt_read_metadata);
  * @fw_name:	name of the firmware, for construction of segment file names
  * @pas_id:	PAS identifier
  * @mem_phys:	physical address of allocated memory region
- * @ctx:	PAS metadata context, to be released by caller
+ * @ctx:	PAS context, metadata to be released by caller
  *
  * Returns 0 on success, negative errno otherwise.
  */
 int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
 		      const char *fw_name, int pas_id, phys_addr_t mem_phys,
-		      struct qcom_scm_pas_metadata *ctx)
+		      struct qcom_scm_pas_context *ctx)
 {
 	const struct elf32_phdr *phdrs;
 	const struct elf32_phdr *phdr;
diff --git a/include/linux/firmware/qcom/qcom_scm.h b/include/linux/firmware/qcom/qcom_scm.h
index 35f0574082713..6f9862033fc3b 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -66,15 +66,19 @@ int qcom_scm_set_warm_boot_addr(void *entry);
 void qcom_scm_cpu_power_down(u32 flags);
 int qcom_scm_set_remote_state(u32 state, u32 id);
 
-struct qcom_scm_pas_metadata {
+struct qcom_scm_pas_context {
+	struct device *dev;
+	u32 pas_id;
+	phys_addr_t mem_phys;
+	size_t mem_size;
 	void *ptr;
 	dma_addr_t phys;
 	ssize_t size;
 };
 
 int qcom_scm_pas_init_image(u32 pas_id, const void *metadata, size_t size,
-			    struct qcom_scm_pas_metadata *ctx);
-void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx);
+			    struct qcom_scm_pas_context *ctx);
+void qcom_pas_metadata_release(struct qcom_scm_pas_context *ctx);
 int qcom_scm_pas_mem_setup(u32 pas_id, phys_addr_t addr, phys_addr_t size);
 int qcom_scm_pas_auth_and_reset(u32 pas_id);
 int qcom_scm_pas_shutdown(u32 pas_id);
diff --git a/include/linux/soc/qcom/mdt_loader.h b/include/linux/soc/qcom/mdt_loader.h
index 9e8e604211920..f32e2ab72754d 100644
--- a/include/linux/soc/qcom/mdt_loader.h
+++ b/include/linux/soc/qcom/mdt_loader.h
@@ -10,14 +10,14 @@
 
 struct device;
 struct firmware;
-struct qcom_scm_pas_metadata;
+struct qcom_scm_pas_context;
 
 #if IS_ENABLED(CONFIG_QCOM_MDT_LOADER)
 
 ssize_t qcom_mdt_get_size(const struct firmware *fw);
 int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
 		      const char *fw_name, int pas_id, phys_addr_t mem_phys,
-		      struct qcom_scm_pas_metadata *pas_metadata_ctx);
+		      struct qcom_scm_pas_context *pas_ctx);
 int qcom_mdt_load(struct device *dev, const struct firmware *fw,
 		  const char *fw_name, int pas_id, void *mem_region,
 		  phys_addr_t mem_phys, size_t mem_size,
@@ -39,7 +39,7 @@ static inline ssize_t qcom_mdt_get_size(const struct firmware *fw)
 
 static inline int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
 				    const char *fw_name, int pas_id, phys_addr_t mem_phys,
-				    struct qcom_scm_pas_metadata *pas_metadata_ctx)
+				    struct qcom_scm_pas_context *pas_ctx)
 {
 	return -ENODEV;
 }
-- 
2.53.0

