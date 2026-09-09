Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380BE538D76
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788953291; cv=none; b=B4Hf08VSLY3tgoBBNmfcmhc8FGBXetp82duwXPFbSw/Vu6k+nCTF+Sz2Z48I2i7NoBLkay7rIV25qjWiMUlCDWPZs41He0quERdCj3PRcsVGDjOWJ62WC5geKdUqMM/W0A5artm+zidyYfb9Ux77sbUuojv61jxAhWuhvnov8b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788953291; c=relaxed/simple;
	bh=DKcIaMy6fDKg35yoC0wQ0G5b+RSr4eZoQ7ycufPPRMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEyGivHlPsTPm74KVBi6AYVxEdKTZzgALjQ90P4kBDZuvzHljNN87qoq6ripHPSVWMrfUpTqxpAsNEuG91uVa6aWlJs5F1TAVcf7MdrCeg1yLHPdS7PFJ7ehSrMOSLRMhQz9E55YppG7XbrP7inur2PCN7+JwwgJTKavcZ4ads4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JUieiD1j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JUieiD1j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A601F00A3D;
	Wed,  9 Sep 2026 11:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953289;
	bh=KxOeYgumFDj/2ZQV7MiWdVsTKAWOmtkFEoeBqHvycdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JUieiD1jk9v+Z6U+MTHzjQfUfxAL9bAzMjRjLKpueVVvY4wQwEaIsYam2fwcvTbwt
	 QcbkrVpqoIccihWWYxaJlsMby2U8qBgm7ejlfUD4VXD/m/GxliMig0ms9soipi5Uqw
	 etPwpew1oIMzo7X/RbKftvPGVrqi3pf+BuHiU9Hk4xeMiVvogKFPapPmkx3u8xxUeA
	 aF6h39nGI1jG/hn3SzTf+n92a4B0a8avcOx9J/NVQe9LGbUP0HS2JqaK7HaotchyZ5
	 aj7GcW8PHQMyWrVgqd3yN1F1tkndD0b/JCdJ0umteoen5cbDlISrMF8w8IPRKdwuGa
	 cIBR8FtEohuQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] remoteproc: pas: Replace metadata context with PAS context structure
Date: Wed,  9 Sep 2026 07:28:06 -0400
Message-ID: <20260909112807.1846537-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090336-dweller-sepia-b585@gregkh>
References: <2026090336-dweller-sepia-b585@gregkh>
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

For this 6.6 dependency backport, retain the stable SCM file location,
peripheral argument naming and split MDT init/load API. Define the PAS
context locally in the SCM header and allocate and initialize both
contexts directly in adsp_probe(), before memory assignment and subdevice
registration. Use the existing free_rproc error path on allocation failure;
the newer allocator helper and its cleanup labels are absent here.

Rename the existing metadata-release implementation and export to
qcom_pas_metadata_release(), matching target c06c5ab4945392, and update all
callers. No new functions are introduced.

Use the target's local PAS pointer naming in adsp_load() and release the
DTB firmware directly on MDT initialization failure. This preserves the
stable error handling while removing the extra firmware-release label.
Keep the load-error metadata-release label for the target to move into
the dtb_pas_id guard. Align its call-site context so the original target
can be cherry-picked without importing the later PAS loader or IOMMU
refactors.

[ sashal: Reduced backport -- upstream b13d8baf56016 touches 5 file(s), this
  backport carries 5. Not backported here:
  drivers/firmware/qcom/qcom_scm.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: c06c5ab49453 ("remoteproc: qcom: pas: Guard dtb metadata release with dtb_pas_id check")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/qcom_scm.c            | 14 ++---
 drivers/remoteproc/qcom_q6v5_pas.c     | 78 ++++++++++++++++----------
 drivers/soc/qcom/mdt_loader.c          |  4 +-
 include/linux/firmware/qcom/qcom_scm.h | 10 +++-
 include/linux/soc/qcom/mdt_loader.h    |  6 +-
 5 files changed, 68 insertions(+), 44 deletions(-)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 4c5c2b73d42c2..211558f33a746 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -456,16 +456,16 @@ static void qcom_scm_set_download_mode(bool enable)
  *		and optional blob of data used for authenticating the metadata
  *		and the rest of the firmware
  * @size:	size of the metadata
- * @ctx:	optional metadata context
+ * @ctx:	optional PAS context
  *
  * Return: 0 on success.
  *
  * Upon successful return, the PAS metadata context (@ctx) will be used to
  * track the metadata allocation, this needs to be released by invoking
- * qcom_scm_pas_metadata_release() by the caller.
+ * qcom_pas_metadata_release() by the caller.
  */
 int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
-			    struct qcom_scm_pas_metadata *ctx)
+			    struct qcom_scm_pas_context *ctx)
 {
 	dma_addr_t mdata_phys;
 	void *mdata_buf;
@@ -522,10 +522,10 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
 EXPORT_SYMBOL_GPL(qcom_scm_pas_init_image);
 
 /**
- * qcom_scm_pas_metadata_release() - release metadata context
- * @ctx:	metadata context
+ * qcom_pas_metadata_release() - release metadata context
+ * @ctx:	PAS context
  */
-void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx)
+void qcom_pas_metadata_release(struct qcom_scm_pas_context *ctx)
 {
 	if (!ctx->ptr)
 		return;
@@ -536,7 +536,7 @@ void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx)
 	ctx->phys = 0;
 	ctx->size = 0;
 }
-EXPORT_SYMBOL_GPL(qcom_scm_pas_metadata_release);
+EXPORT_SYMBOL_GPL(qcom_pas_metadata_release);
 
 /**
  * qcom_scm_pas_mem_setup() - Prepare the memory related to a given peripheral
diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index f6336bf4a38b9..ceaf4e3f68247 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -102,8 +102,8 @@ struct qcom_adsp {
 	struct qcom_rproc_ssr ssr_subdev;
 	struct qcom_sysmon *sysmon;
 
-	struct qcom_scm_pas_metadata pas_metadata;
-	struct qcom_scm_pas_metadata dtb_pas_metadata;
+	struct qcom_scm_pas_context *pas_ctx;
+	struct qcom_scm_pas_context *dtb_pas_ctx;
 };
 
 static void adsp_segment_dump(struct rproc *rproc, struct rproc_dump_segment *segment,
@@ -190,44 +190,46 @@ static int adsp_unprepare(struct rproc *rproc)
 	struct qcom_adsp *adsp = rproc->priv;
 
 	/*
-	 * adsp_load() did pass pas_metadata to the SCM driver for storing
+	 * adsp_load() did pass pas_ctx to the SCM driver for storing
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
+		ret = qcom_mdt_load_no_init(pas->dev, pas->dtb_firmware, pas->dtb_firmware_name,
+					    pas->dtb_pas_id, pas->dtb_mem_region,
+					    pas->dtb_mem_phys, pas->dtb_mem_size,
+					&pas->dtb_mem_reloc);
 		if (ret)
 			goto release_dtb_metadata;
 	}
@@ -235,10 +237,8 @@ static int adsp_load(struct rproc *rproc, const struct firmware *fw)
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
@@ -286,7 +286,7 @@ static int adsp_start(struct rproc *rproc)
 	}
 
 	ret = qcom_mdt_pas_init(adsp->dev, adsp->firmware, rproc->firmware, adsp->pas_id,
-				adsp->mem_phys, &adsp->pas_metadata);
+				adsp->mem_phys, adsp->pas_ctx);
 	if (ret)
 		goto disable_px_supply;
 
@@ -312,9 +312,9 @@ static int adsp_start(struct rproc *rproc)
 		goto release_pas_metadata;
 	}
 
-	qcom_scm_pas_metadata_release(&adsp->pas_metadata);
+	qcom_pas_metadata_release(adsp->pas_ctx);
 	if (adsp->dtb_pas_id)
-		qcom_scm_pas_metadata_release(&adsp->dtb_pas_metadata);
+		qcom_pas_metadata_release(adsp->dtb_pas_ctx);
 
 	/* Remove pointer to the loaded firmware, only valid in adsp_load() & adsp_start() */
 	adsp->firmware = NULL;
@@ -322,9 +322,9 @@ static int adsp_start(struct rproc *rproc)
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
@@ -710,6 +710,26 @@ static int adsp_probe(struct platform_device *pdev)
 	if (ret)
 		goto free_rproc;
 
+	adsp->pas_ctx = devm_kzalloc(adsp->dev, sizeof(*adsp->pas_ctx), GFP_KERNEL);
+	if (!adsp->pas_ctx) {
+		ret = -ENOMEM;
+		goto free_rproc;
+	}
+	adsp->pas_ctx->dev = adsp->dev;
+	adsp->pas_ctx->pas_id = adsp->pas_id;
+	adsp->pas_ctx->mem_phys = adsp->mem_phys;
+	adsp->pas_ctx->mem_size = adsp->mem_size;
+
+	adsp->dtb_pas_ctx = devm_kzalloc(adsp->dev, sizeof(*adsp->dtb_pas_ctx), GFP_KERNEL);
+	if (!adsp->dtb_pas_ctx) {
+		ret = -ENOMEM;
+		goto free_rproc;
+	}
+	adsp->dtb_pas_ctx->dev = adsp->dev;
+	adsp->dtb_pas_ctx->pas_id = adsp->dtb_pas_id;
+	adsp->dtb_pas_ctx->mem_phys = adsp->dtb_mem_phys;
+	adsp->dtb_pas_ctx->mem_size = adsp->dtb_mem_size;
+
 	ret = adsp_assign_memory_region(adsp);
 	if (ret)
 		goto free_rproc;
diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 0afecda0bfaa3..4f07046954993 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -236,13 +236,13 @@ EXPORT_SYMBOL_GPL(qcom_mdt_read_metadata);
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
index 0c091a3f6d49f..c85bd580f852d 100644
--- a/include/linux/firmware/qcom/qcom_scm.h
+++ b/include/linux/firmware/qcom/qcom_scm.h
@@ -66,7 +66,11 @@ extern int qcom_scm_set_warm_boot_addr(void *entry);
 extern void qcom_scm_cpu_power_down(u32 flags);
 extern int qcom_scm_set_remote_state(u32 state, u32 id);
 
-struct qcom_scm_pas_metadata {
+struct qcom_scm_pas_context {
+	struct device *dev;
+	u32 pas_id;
+	phys_addr_t mem_phys;
+	size_t mem_size;
 	void *ptr;
 	dma_addr_t phys;
 	ssize_t size;
@@ -74,8 +78,8 @@ struct qcom_scm_pas_metadata {
 
 extern int qcom_scm_pas_init_image(u32 peripheral, const void *metadata,
 				   size_t size,
-				   struct qcom_scm_pas_metadata *ctx);
-extern void qcom_scm_pas_metadata_release(struct qcom_scm_pas_metadata *ctx);
+				   struct qcom_scm_pas_context *ctx);
+extern void qcom_pas_metadata_release(struct qcom_scm_pas_context *ctx);
 extern int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr,
 				  phys_addr_t size);
 extern int qcom_scm_pas_auth_and_reset(u32 peripheral);
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

