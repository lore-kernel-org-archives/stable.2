Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F8B52B1D2
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788971211; cv=none; b=e4hH0Cjjg+3aVrzHeuw5BscGNyLE12gmEQnoaPphgb941VAuLSiYhaar3t63jxy8/H89bchxLn7S5e5Gb9jvDZceg+pnDzXLY4m8cfw6GrMwLlN9bu3LwpgPWBY9ICYmk4zZ6KkteSPIq4SfagsKI42WF9D7UIH3BhvD5uiNl4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788971211; c=relaxed/simple;
	bh=HmeDDNeQ/3NMvDPIFPht0qpkPsKUdJjd1H7Y0u+LshA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YGLIHYjyTjkpKgAv3Bu5SDbdx+4JpPiBJ+zgbFASPDtfhZHhVOKrplLRQIWjREA4qDJn5sOsZ9f7p3cjOsSSHSd73MTQa/WFejRZc0Qp+YPDmRFjiYB5bZW0jPGfT2oF1Yo6tb9juKYoVR1R8n9pjP4qHd6fKhdKvzTivFlwKm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWS2/hDJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWS2/hDJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E341F00899;
	Wed,  9 Sep 2026 16:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788971209;
	bh=QgMRnJUoA6ihoNehYK8KF1Sk2lxPjBKOa50C8gKOwhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WWS2/hDJcii+TEJhchvgSpVrkFYeKAVhpwP7Nk0oMZG1FsWUadvTfXPBxyd+thLxG
	 gVdnLY5gn5dLgneeokn4ZBjjdWcNh1lQ0fBTUx3vEh6NXQFcYYCpPwo5olLBD4Zk7p
	 y61rIDSxZ2kEJBsfjGOlBs/JvlH3SVVS4FpI7v7IFJNsw//zZ8duQFp/MEE/h72Vfq
	 c4HhJIfIRpr1SnBFAEDhgvApAp465CqVFLmvk4iWAQ5i4d8GYLHldt2oRRaWNW3KH2
	 js4p51vo5QkHExK2Gu/Xnj/2m5qsIM/bhwakVRApwNhZ9Y7tpZIU1r6jHiVFP2AOSX
	 Wuyzl8IXgyLqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Karolina Stolarek <karolina.stolarek@oracle.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/6] PCI/AER: Check log level once and remember it
Date: Wed,  9 Sep 2026 12:26:41 -0400
Message-ID: <20260909162644.2981443-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909162644.2981443-1-sashal@kernel.org>
References: <2026090327-shy-dealmaker-b70c@gregkh>
 <20260909162644.2981443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Karolina Stolarek <karolina.stolarek@oracle.com>

[ Upstream commit c8f6791e33a7757025285db26f3b382cdcb7f7cd ]

When reporting an AER error, we check its type multiple times to determine
the log level for each message. Do this check only in the top-level
functions (aer_isr_one_error(), pci_print_aer()) and save the level in
struct aer_err_info.

[bhelgaas: save log level in struct aer_err_info instead of passing it
as a parameter]

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://patch.msgid.link/20250522232339.1525671-13-helgaas@kernel.org

[ Stable adaptation: Keep the 6.6 pci_printk(), __print_tlp_header(),
cper_print_aer(), and aer_isr_one_error() implementations.  Initialize the
saved level in both branches of the existing interrupt handler and in the
firmware and DPC paths, without importing the upstream handler refactors.

Prepare the two TLP header predicates for a8bf2dd750de ("PCI/AER: Emit TLP
Log only for unmasked errors").  This tree lacks tlp_header_logged() and
the newer capability-dependent TLP logging support.  Provide the predicate
as a macro containing the existing AER_LOG_TLP_MASKS test, and name the
capability-register value aercc.  The capctl argument is intentionally
unused because the legacy test is capability-independent.  This preserves
the supported error set and the existing four-DWORD header reads while
allowing the target's two mask changes to merge cleanly.  No functions or
new PCIe logging capabilities are added. ]

Stable-dep-of: a8bf2dd750de ("PCI/AER: Emit TLP Log only for unmasked errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pci.h      |  1 +
 drivers/pci/pcie/aer.c | 34 ++++++++++++++++++----------------
 drivers/pci/pcie/dpc.c |  1 +
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 278af5b263bff..e5202e8411683 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -420,6 +420,7 @@ static inline bool pci_dev_is_added(const struct pci_dev *dev)
 struct aer_err_info {
 	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
 	int error_dev_num;
+	const char *level;		/* printk level */
 
 	unsigned int id:16;
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index b9d9339bc0fdd..c275ac9bb4e41 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -93,6 +93,9 @@ struct aer_stats {
 					PCI_ERR_UNC_UNX_COMP|		\
 					PCI_ERR_UNC_MALF_TLP)
 
+/* Only the legacy, capability-independent TLP header errors are supported. */
+#define tlp_header_logged(status, capctl) ((status) & AER_LOG_TLP_MASKS)
+
 #define SYSTEM_ERROR_INTR_ON_MESG_MASK	(PCI_EXP_RTCTL_SECEE|	\
 					PCI_EXP_RTCTL_SENFEE|	\
 					PCI_EXP_RTCTL_SEFEE)
@@ -668,21 +671,18 @@ static void __print_tlp_header(struct pci_dev *dev,
 		t->dw0, t->dw1, t->dw2, t->dw3);
 }
 
-static void __aer_print_error(struct pci_dev *dev,
-			      struct aer_err_info *info)
+static void __aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	const char **strings;
 	unsigned long status = info->status & ~info->mask;
-	const char *level, *errmsg;
+	const char *level = info->level;
+	const char *errmsg;
 	int i;
 
-	if (info->severity == AER_CORRECTABLE) {
+	if (info->severity == AER_CORRECTABLE)
 		strings = aer_correctable_error_string;
-		level = KERN_WARNING;
-	} else {
+	else
 		strings = aer_uncorrectable_error_string;
-		level = KERN_ERR;
-	}
 
 	for_each_set_bit(i, &status, 32) {
 		errmsg = strings[i];
@@ -698,7 +698,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 {
 	int layer, agent;
 	int id = pci_dev_id(dev);
-	const char *level;
+	const char *level = info->level;
 
 	pci_dev_aer_stats_incr(dev, info);
 
@@ -711,8 +711,6 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
 	agent = AER_GET_AGENT(info->severity, info->status);
 
-	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
-
 	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
 		   aer_error_severity_string[info->severity],
 		   aer_error_layer[layer], aer_agent_string[agent]);
@@ -772,10 +770,12 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 	if (aer_severity == AER_CORRECTABLE) {
 		status = aer->cor_status;
 		mask = aer->cor_mask;
+		info.level = KERN_WARNING;
 	} else {
 		status = aer->uncor_status;
 		mask = aer->uncor_mask;
-		tlp_header_valid = status & AER_LOG_TLP_MASKS;
+		info.level = KERN_ERR;
+		tlp_header_valid = tlp_header_logged(status, aer->cap_control);
 	}
 
 	info.status = status;
@@ -1062,7 +1062,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 {
 	int type = pci_pcie_type(dev);
 	int aer = dev->aer_cap;
-	int temp;
+	u32 aercc;
 
 	/* Must reset in this function */
 	info->status = 0;
@@ -1093,10 +1093,10 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 			return 0;
 
 		/* Get First Error Pointer */
-		pci_read_config_dword(dev, aer + PCI_ERR_CAP, &temp);
-		info->first_error = PCI_ERR_CAP_FEP(temp);
+		pci_read_config_dword(dev, aer + PCI_ERR_CAP, &aercc);
+		info->first_error = PCI_ERR_CAP_FEP(aercc);
 
-		if (info->status & AER_LOG_TLP_MASKS) {
+		if (tlp_header_logged(info->status, aercc)) {
 			info->tlp_header_valid = 1;
 			pci_read_config_dword(dev,
 				aer + PCI_ERR_HEADER_LOG, &info->tlp.dw0);
@@ -1147,6 +1147,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 	if (e_src->status & PCI_ERR_ROOT_COR_RCV) {
 		e_info.id = ERR_COR_ID(e_src->id);
 		e_info.severity = AER_CORRECTABLE;
+		e_info.level = KERN_WARNING;
 
 		if (e_src->status & PCI_ERR_ROOT_MULTI_COR_RCV)
 			e_info.multi_error_valid = 1;
@@ -1160,6 +1161,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
 
 	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
 		e_info.id = ERR_UNCOR_ID(e_src->id);
+		e_info.level = KERN_ERR;
 
 		if (e_src->status & PCI_ERR_ROOT_FATAL_RCV)
 			e_info.severity = AER_FATAL;
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 3c3ecb9cf57af..b1aa1bd4aa365 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -257,6 +257,7 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
 	else
 		info->severity = AER_NONFATAL;
 
+	info->level = KERN_ERR;
 	return 1;
 }
 
-- 
2.53.0

