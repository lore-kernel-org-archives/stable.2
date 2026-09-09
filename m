Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB96C582BB7
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 14:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788963070; cv=none; b=ZbbebL1HrBLhgmpEv/dAD09DLqBmpyfPi7gopxZSMBzdox4hMfun32MW2irWXlkk19CaAVVvuaRxmyww+GJXFX2pNz9zCI25hRznG6ucYzeDAdM22R4I6yVF4jm+wN7FVOYaNuNYTTe+WLu19Vy3QjFiXRrM9Q9sPe5cev8WthQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788963070; c=relaxed/simple;
	bh=bDE4iaQQ0f+JKDnJlkFzmnXKvshAzuNQ8h0I4keZzSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQDPyBAIAHkrsDc/kG3sVWullOcN49BGFz/RXjk3V9a5IOpes0XbxqY/oduzM/hbgzgi6Vo0q0p1NL0gdeSO263A4xauQ9FqnzI/haOvvFJQNZppRgdOEUWkpZnsmQu/ICniZ9zdY6w9IRtbd0K6Q/3dgvTLBSj5MWSfU6gqP5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ek8we6Fy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ek8we6Fy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58F71F00A3A;
	Wed,  9 Sep 2026 14:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788963068;
	bh=hqyxBGGTXpHDdCDtJTEKG8PKN8g+epnjZZf8LCJwTi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ek8we6FyUYQg87a8nI2geWgEBy31JKHxeuEcOcr7t9stki/pLjdNvpf+wB5QReCsl
	 QOH9kxWVXNBcbB9F/9xKfVT6D4TAQ7X/kBa+JLANvJCP1cQCOg7TpfPUb331F0uRSZ
	 3UyvzVasL81oTI9PNouPJKbUqenxIPwuqGSblrE3j6l7ud6xpo+0ATuVQdASCu7pY/
	 n+FUAkSnjxSV1Y3Bz8jfRd5P5Euno6sLiy7Ki0xhSXSXSze/UPJ2dDLFDXfqPA6Uok
	 6lVFoNNnJT561OMhp7RMH/lY4fYNQmlVxBrp/mrSC9iLqLum2Oml1s5v2zF9Igo40H
	 L/lug5nLw2FMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/7] platform/x86: ISST: Use local variable for auxdev->dev
Date: Wed,  9 Sep 2026 10:11:00 -0400
Message-ID: <20260909141102.2383363-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909141102.2383363-1-sashal@kernel.org>
References: <2026090334-lumber-underfoot-3bf9@gregkh>
 <20260909141102.2383363-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

[ Upstream commit 8c5a689eef5b1c1eaddd17b0b1f2609d3f66c5b0 ]

Define a local variable for &auxdev->dev and use to shorten length of
lines. No functional change is done.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/r/20240423204619.3946901-6-srinivas.pandruvada@linux.intel.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>

On this stable branch, keep the ISST_HEADER_VERSION check in sst_main()
and use the local dev variable for its existing error message. The
upstream major/minor-version handling is absent and is not needed here.

Also assign sst_inst before reading its number_of_power_domains in
isst_if_get_tpmi_instance_count(). This preserves the existing count
calculation while preparing the insertion point for the NULL check in
3de2776e9d7073765c10c2326c2bda5926811ea6. The stable tree does not need
the upstream partition-counting helper or any new functions.

The stable tree also already contains the ISST read/write-blocked caller
from 8bed9ff7dbcce, but its TPMI provider still has the old int-pointer
locked/disabled API. This fails the x86 allmodconfig build. Adapt the
existing provider and its declaration to the bool-pointer API from
72dd14d241e1c, decoding status bits 5 (read blocked) and 4 (write blocked)
as defined by 8df012a7f5131. Return the raw status word from the existing
internal reader so debugfs retains its locked/disabled output. This
supplies the missing status handling without adding any functions.

Stable-dep-of: 3de2776e9d70 ("platform/x86: ISST: Add a NULL check for sst_inst[]")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../intel/speed_select_if/isst_tpmi_core.c    | 30 ++++++++--------
 drivers/platform/x86/intel/tpmi.c             | 36 ++++++++++---------
 include/linux/intel_tpmi.h                    |  4 +--
 3 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 1f29642546613..c41c9a6fe3378 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -312,12 +312,11 @@ static int sst_add_perf_profiles(struct auxiliary_device *auxdev,
 				 struct tpmi_per_power_domain_info *pd_info,
 				 int levels)
 {
+	struct device *dev = &auxdev->dev;
 	u64 perf_level_offsets;
 	int i;
 
-	pd_info->perf_levels = devm_kcalloc(&auxdev->dev, levels,
-					    sizeof(struct perf_level),
-					    GFP_KERNEL);
+	pd_info->perf_levels = devm_kcalloc(dev, levels, sizeof(struct perf_level), GFP_KERNEL);
 	if (!pd_info->perf_levels)
 		return 0;
 
@@ -348,6 +347,7 @@ static int sst_add_perf_profiles(struct auxiliary_device *auxdev,
 
 static int sst_main(struct auxiliary_device *auxdev, struct tpmi_per_power_domain_info *pd_info)
 {
+	struct device *dev = &auxdev->dev;
 	int i, mask, levels;
 
 	*((u64 *)&pd_info->sst_header) = readq(pd_info->sst_base);
@@ -355,7 +355,7 @@ static int sst_main(struct auxiliary_device *auxdev, struct tpmi_per_power_domai
 	pd_info->sst_header.pp_offset *= 8;
 
 	if (pd_info->sst_header.interface_version != ISST_HEADER_VERSION) {
-		dev_err(&auxdev->dev, "SST: Unsupported version:%x\n",
+		dev_err(dev, "SST: Unsupported version:%x\n",
 			pd_info->sst_header.interface_version);
 		return -ENODEV;
 	}
@@ -1129,9 +1129,10 @@ static int isst_if_get_tpmi_instance_count(void __user *argp)
 	if (tpmi_inst.socket_id >= topology_max_packages())
 		return -EINVAL;
 
-	tpmi_inst.count = isst_common.sst_inst[tpmi_inst.socket_id]->number_of_power_domains;
-
 	sst_inst = isst_common.sst_inst[tpmi_inst.socket_id];
+
+	tpmi_inst.count = sst_inst->number_of_power_domains;
+
 	tpmi_inst.valid_mask = 0;
 	for (i = 0; i < sst_inst->number_of_power_domains; ++i) {
 		struct tpmi_per_power_domain_info *pd_info;
@@ -1268,28 +1269,29 @@ int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
 {
 	bool read_blocked = 0, write_blocked = 0;
 	struct intel_tpmi_plat_info *plat_info;
+	struct device *dev = &auxdev->dev;
 	struct tpmi_sst_struct *tpmi_sst;
 	int i, ret, pkg = 0, inst = 0;
 	int num_resources;
 
 	ret = tpmi_get_feature_status(auxdev, TPMI_ID_SST, &read_blocked, &write_blocked);
 	if (ret)
-		dev_info(&auxdev->dev, "Can't read feature status: ignoring read/write blocked status\n");
+		dev_info(dev, "Can't read feature status: ignoring read/write blocked status\n");
 
 	if (read_blocked) {
-		dev_info(&auxdev->dev, "Firmware has blocked reads, exiting\n");
+		dev_info(dev, "Firmware has blocked reads, exiting\n");
 		return -ENODEV;
 	}
 
 	plat_info = tpmi_get_platform_data(auxdev);
 	if (!plat_info) {
-		dev_err(&auxdev->dev, "No platform info\n");
+		dev_err(dev, "No platform info\n");
 		return -EINVAL;
 	}
 
 	pkg = plat_info->package_id;
 	if (pkg >= topology_max_packages()) {
-		dev_err(&auxdev->dev, "Invalid package id :%x\n", pkg);
+		dev_err(dev, "Invalid package id :%x\n", pkg);
 		return -EINVAL;
 	}
 
@@ -1301,11 +1303,11 @@ int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
 	if (!num_resources)
 		return -EINVAL;
 
-	tpmi_sst = devm_kzalloc(&auxdev->dev, sizeof(*tpmi_sst), GFP_KERNEL);
+	tpmi_sst = devm_kzalloc(dev, sizeof(*tpmi_sst), GFP_KERNEL);
 	if (!tpmi_sst)
 		return -ENOMEM;
 
-	tpmi_sst->power_domain_info = devm_kcalloc(&auxdev->dev, num_resources,
+	tpmi_sst->power_domain_info = devm_kcalloc(dev, num_resources,
 						   sizeof(*tpmi_sst->power_domain_info),
 						   GFP_KERNEL);
 	if (!tpmi_sst->power_domain_info)
@@ -1326,13 +1328,13 @@ int tpmi_sst_dev_add(struct auxiliary_device *auxdev)
 		tpmi_sst->power_domain_info[i].power_domain_id = i;
 		tpmi_sst->power_domain_info[i].auxdev = auxdev;
 		tpmi_sst->power_domain_info[i].write_blocked = write_blocked;
-		tpmi_sst->power_domain_info[i].sst_base = devm_ioremap_resource(&auxdev->dev, res);
+		tpmi_sst->power_domain_info[i].sst_base = devm_ioremap_resource(dev, res);
 		if (IS_ERR(tpmi_sst->power_domain_info[i].sst_base))
 			return PTR_ERR(tpmi_sst->power_domain_info[i].sst_base);
 
 		ret = sst_main(auxdev, &tpmi_sst->power_domain_info[i]);
 		if (ret) {
-			devm_iounmap(&auxdev->dev, tpmi_sst->power_domain_info[i].sst_base);
+			devm_iounmap(dev, tpmi_sst->power_domain_info[i].sst_base);
 			tpmi_sst->power_domain_info[i].sst_base =  NULL;
 			continue;
 		}
diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index 9c38e44177df6..6922b46f6532a 100644
--- a/drivers/platform/x86/intel/tpmi.c
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -228,6 +228,8 @@ EXPORT_SYMBOL_NS_GPL(tpmi_get_resource_at_index, INTEL_TPMI);
 #define TPMI_CMD_LEN_MASK		GENMASK_ULL(18, 16)
 
 #define TPMI_STATE_DISABLED		BIT_ULL(0)
+#define TPMI_STATE_WRITE_BLOCKED		BIT_ULL(4)
+#define TPMI_STATE_READ_BLOCKED		BIT_ULL(5)
 #define TPMI_STATE_LOCKED		BIT_ULL(31)
 
 /* Mutex to complete get feature status without interruption */
@@ -243,7 +245,7 @@ static int tpmi_wait_for_owner(struct intel_tpmi_info *tpmi_info, u8 owner)
 }
 
 static int tpmi_read_feature_status(struct intel_tpmi_info *tpmi_info, int feature_id,
-				    int *locked, int *disabled)
+				    u32 *feature_state)
 {
 	u64 control, data;
 	int ret;
@@ -294,16 +296,7 @@ static int tpmi_read_feature_status(struct intel_tpmi_info *tpmi_info, int featu
 
 	/* Response is ready */
 	data = readq(tpmi_info->tpmi_control_mem + TPMI_COMMAND_OFFSET);
-	data = FIELD_GET(TMPI_CONTROL_DATA_VAL, data);
-
-	*disabled = 0;
-	*locked = 0;
-
-	if (!(data & TPMI_STATE_DISABLED))
-		*disabled = 1;
-
-	if (data & TPMI_STATE_LOCKED)
-		*locked = 1;
+	*feature_state = FIELD_GET(TMPI_CONTROL_DATA_VAL, data);
 
 	ret = 0;
 
@@ -318,12 +311,21 @@ static int tpmi_read_feature_status(struct intel_tpmi_info *tpmi_info, int featu
 }
 
 int tpmi_get_feature_status(struct auxiliary_device *auxdev, int feature_id,
-			    int *locked, int *disabled)
+			    bool *read_blocked, bool *write_blocked)
 {
 	struct intel_vsec_device *intel_vsec_dev = dev_to_ivdev(auxdev->dev.parent);
 	struct intel_tpmi_info *tpmi_info = auxiliary_get_drvdata(&intel_vsec_dev->auxdev);
+	u32 feature_state;
+	int ret;
 
-	return tpmi_read_feature_status(tpmi_info, feature_id, locked, disabled);
+	ret = tpmi_read_feature_status(tpmi_info, feature_id, &feature_state);
+	if (ret)
+		return ret;
+
+	*read_blocked = feature_state & TPMI_STATE_READ_BLOCKED;
+	*write_blocked = feature_state & TPMI_STATE_WRITE_BLOCKED;
+
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(tpmi_get_feature_status, INTEL_TPMI);
 
@@ -332,19 +334,19 @@ static int tpmi_pfs_dbg_show(struct seq_file *s, void *unused)
 	struct intel_tpmi_info *tpmi_info = s->private;
 	struct intel_tpmi_pm_feature *pfs;
 	int locked, disabled, ret, i;
+	u32 feature_state;
 
 	seq_printf(s, "tpmi PFS start offset 0x:%llx\n", tpmi_info->pfs_start);
 	seq_puts(s, "tpmi_id\t\tentries\t\tsize\t\tcap_offset\tattribute\tvsec_offset\tlocked\tdisabled\n");
 	for (i = 0; i < tpmi_info->feature_count; ++i) {
 		pfs = &tpmi_info->tpmi_features[i];
-		ret = tpmi_read_feature_status(tpmi_info, pfs->pfs_header.tpmi_id, &locked,
-					       &disabled);
+		ret = tpmi_read_feature_status(tpmi_info, pfs->pfs_header.tpmi_id, &feature_state);
 		if (ret) {
 			locked = 'U';
 			disabled = 'U';
 		} else {
-			disabled = disabled ? 'Y' : 'N';
-			locked = locked ? 'Y' : 'N';
+			disabled = feature_state & TPMI_STATE_DISABLED ? 'N' : 'Y';
+			locked = feature_state & TPMI_STATE_LOCKED ? 'Y' : 'N';
 		}
 		seq_printf(s, "0x%02x\t\t0x%02x\t\t0x%04x\t\t0x%04x\t\t0x%02x\t\t0x%016llx\t%c\t%c\n",
 			   pfs->pfs_header.tpmi_id, pfs->pfs_header.num_entries,
diff --git a/include/linux/intel_tpmi.h b/include/linux/intel_tpmi.h
index fbc1b94abaceb..bfdc75393adae 100644
--- a/include/linux/intel_tpmi.h
+++ b/include/linux/intel_tpmi.h
@@ -46,6 +46,6 @@ struct intel_tpmi_plat_info *tpmi_get_platform_data(struct auxiliary_device *aux
 struct resource *tpmi_get_resource_at_index(struct auxiliary_device *auxdev, int index);
 int tpmi_get_resource_count(struct auxiliary_device *auxdev);
 
-int tpmi_get_feature_status(struct auxiliary_device *auxdev, int feature_id, int *locked,
-			    int *disabled);
+int tpmi_get_feature_status(struct auxiliary_device *auxdev, int feature_id, bool *read_blocked,
+			    bool *write_blocked);
 #endif
-- 
2.53.0

