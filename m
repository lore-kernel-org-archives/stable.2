Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1B93B101C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980845; cv=none; b=SaV991LAu9Iihn7HjxcNulYBYBgqQm0DRXFOJe34jf2yx5P2g5RHADOxwwldSWN+CC5VIS9ePisZbxPOmq14hS8S83FTSuKR6rJAyt9W8NU2uviuyNVbu1LjoZnHOO+/aFweNF6nJy89pyTLZ+Ou1XmkOrIjrBk6BFsR7yVyMI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980845; c=relaxed/simple;
	bh=XkUJahCtCYjznhUfJeavRt7bAwJVnqdS81M2DnjyZew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUaLilVLzyeYlTYerwQJRDFMshi8IlRBc3NaVHRLRGffbNMiapT0Zkyer5W9EWni7TB4NifxolVP/BGsFpTQgFUz3lqZ1+S7p/ak5YO1tu2xhxsxwDcMaiuts9FHX4yabvFEjp8kPiMaK8kTU9Y3UPwwk1+qOUwO80Z07d3a08A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTIUu/LW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTIUu/LW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCB71F00893;
	Wed,  9 Sep 2026 19:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980843;
	bh=EHD2JHXB9nSmCr0ySZTK9zZHaSPy0BqLAQc1ExOopV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KTIUu/LW+7IpHZKVZBf7/k93yluuNQfMg7mvN2+tj8WpS2BlJxp8SmCJDvsoKsYqF
	 3yXbeivz1uBp+R995ibWT0ezyrMw6QfaFJRBUSoHh9rlN/riTSxQhYZVzUNxiCHzHG
	 HZOGBXmiyiCQQTK5+Pg7d4mChdEKJzhvztg+twCEy/uWjyOfpz/LPj3YGFt9Xno/r0
	 pVeNRC5Y8sOiz6f/KBDUFzrpSytV0fQX32/tq1VpFTxXOfPa1HMEXSRSgjANZee6xC
	 BxIkCxlZOEHKybkjhrvvmHVYru0bcmG7NImX/R6ZafRQAyolYwNKOk3Jvz0tS30Okz
	 gsMnn155Yz1bg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Karolina Stolarek <karolina.stolarek@oracle.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/5] PCI/AER: Rename struct aer_stats to aer_info
Date: Wed,  9 Sep 2026 15:07:16 -0400
Message-ID: <20260909190718.3536304-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909190718.3536304-1-sashal@kernel.org>
References: <2026090327-unfair-disagree-3067@gregkh>
 <20260909190718.3536304-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Karolina Stolarek <karolina.stolarek@oracle.com>

[ Upstream commit 09683a6184ad6fd635831402316651392b56cc3a ]

Update name to reflect the broader definition of structs/variables that are
stored (e.g. ratelimits). This is a preparatory patch for adding rate limit
support.

[bhelgaas: "aer_report" -> "aer_info"]

Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://patch.msgid.link/20250522232339.1525671-16-helgaas@kernel.org
Stable-dep-of: a8bf2dd750de ("PCI/AER: Emit TLP Log only for unmasked errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aer.c | 46 +++++++++++++++++++++---------------------
 include/linux/pci.h    |  2 +-
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f5fa82575defa..fbaccdac99646 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -49,8 +49,8 @@ struct aer_rpc {
 	DECLARE_KFIFO(aer_fifo, struct aer_err_source, AER_ERROR_SOURCES_MAX);
 };
 
-/* AER stats for the device */
-struct aer_stats {
+/* AER info for the device */
+struct aer_info {
 
 	/*
 	 * Fields for all AER capable devices. They indicate the errors
@@ -377,7 +377,7 @@ void pci_aer_init(struct pci_dev *dev)
 	if (!dev->aer_cap)
 		return;
 
-	dev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
+	dev->aer_info = kzalloc(sizeof(*dev->aer_info), GFP_KERNEL);
 
 	/*
 	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
@@ -393,8 +393,8 @@ void pci_aer_init(struct pci_dev *dev)
 
 void pci_aer_exit(struct pci_dev *dev)
 {
-	kfree(dev->aer_stats);
-	dev->aer_stats = NULL;
+	kfree(dev->aer_info);
+	dev->aer_info = NULL;
 }
 
 #define AER_AGENT_RECEIVER		0
@@ -532,10 +532,10 @@ static const char *aer_agent_string[] = {
 {									\
 	unsigned int i;							\
 	struct pci_dev *pdev = to_pci_dev(dev);				\
-	u64 *stats = pdev->aer_stats->stats_array;			\
+	u64 *stats = pdev->aer_info->stats_array;			\
 	size_t len = 0;							\
 									\
-	for (i = 0; i < ARRAY_SIZE(pdev->aer_stats->stats_array); i++) {\
+	for (i = 0; i < ARRAY_SIZE(pdev->aer_info->stats_array); i++) {	\
 		if (strings_array[i])					\
 			len += sysfs_emit_at(buf, len, "%s %llu\n",	\
 					     strings_array[i],		\
@@ -546,7 +546,7 @@ static const char *aer_agent_string[] = {
 					     i, stats[i]);		\
 	}								\
 	len += sysfs_emit_at(buf, len, "TOTAL_%s %llu\n", total_string,	\
-			     pdev->aer_stats->total_field);		\
+			     pdev->aer_info->total_field);		\
 	return len;							\
 }									\
 static DEVICE_ATTR_RO(name)
@@ -567,7 +567,7 @@ aer_stats_dev_attr(aer_dev_nonfatal, dev_nonfatal_errs,
 		     char *buf)						\
 {									\
 	struct pci_dev *pdev = to_pci_dev(dev);				\
-	return sysfs_emit(buf, "%llu\n", pdev->aer_stats->field);	\
+	return sysfs_emit(buf, "%llu\n", pdev->aer_info->field);	\
 }									\
 static DEVICE_ATTR_RO(name)
 
@@ -594,7 +594,7 @@ static umode_t aer_stats_attrs_are_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	if (!pdev->aer_stats)
+	if (!pdev->aer_info)
 		return 0;
 
 	if ((a == &dev_attr_aer_rootport_total_err_cor.attr ||
@@ -618,25 +618,25 @@ static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
 	unsigned long status = info->status & ~info->mask;
 	int i, max = -1;
 	u64 *counter = NULL;
-	struct aer_stats *aer_stats = pdev->aer_stats;
+	struct aer_info *aer_info = pdev->aer_info;
 
-	if (!aer_stats)
+	if (!aer_info)
 		return;
 
 	switch (info->severity) {
 	case AER_CORRECTABLE:
-		aer_stats->dev_total_cor_errs++;
-		counter = &aer_stats->dev_cor_errs[0];
+		aer_info->dev_total_cor_errs++;
+		counter = &aer_info->dev_cor_errs[0];
 		max = AER_MAX_TYPEOF_COR_ERRS;
 		break;
 	case AER_NONFATAL:
-		aer_stats->dev_total_nonfatal_errs++;
-		counter = &aer_stats->dev_nonfatal_errs[0];
+		aer_info->dev_total_nonfatal_errs++;
+		counter = &aer_info->dev_nonfatal_errs[0];
 		max = AER_MAX_TYPEOF_UNCOR_ERRS;
 		break;
 	case AER_FATAL:
-		aer_stats->dev_total_fatal_errs++;
-		counter = &aer_stats->dev_fatal_errs[0];
+		aer_info->dev_total_fatal_errs++;
+		counter = &aer_info->dev_fatal_errs[0];
 		max = AER_MAX_TYPEOF_UNCOR_ERRS;
 		break;
 	}
@@ -648,19 +648,19 @@ static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
 static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
 				 struct aer_err_source *e_src)
 {
-	struct aer_stats *aer_stats = pdev->aer_stats;
+	struct aer_info *aer_info = pdev->aer_info;
 
-	if (!aer_stats)
+	if (!aer_info)
 		return;
 
 	if (e_src->status & PCI_ERR_ROOT_COR_RCV)
-		aer_stats->rootport_total_cor_errs++;
+		aer_info->rootport_total_cor_errs++;
 
 	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
 		if (e_src->status & PCI_ERR_ROOT_FATAL_RCV)
-			aer_stats->rootport_total_fatal_errs++;
+			aer_info->rootport_total_fatal_errs++;
 		else
-			aer_stats->rootport_total_nonfatal_errs++;
+			aer_info->rootport_total_nonfatal_errs++;
 	}
 }
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index fb11201f3fdb5..5cb4896228258 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -344,7 +344,7 @@ struct pci_dev {
 	u8		hdr_type;	/* PCI header type (`multi' flag masked out) */
 #ifdef CONFIG_PCIEAER
 	u16		aer_cap;	/* AER capability offset */
-	struct aer_stats *aer_stats;	/* AER stats for this device */
+	struct aer_info	*aer_info;	/* AER info for this device */
 #endif
 #ifdef CONFIG_PCIEPORTBUS
 	struct rcec_ea	*rcec_ea;	/* RCEC cached endpoint association */
-- 
2.53.0

