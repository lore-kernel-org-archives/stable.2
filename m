Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F1E4ED1BD
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 14:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790692664; cv=none; b=dJtDXuoH5G9jmnGPlaRZJO0JgTmbE8RPdEe1Zs++qF5ME68IOeLV6MfbBWUUGcvR7Ym0E7fHMif+djvrX8y4bbtoYV58atpDCsaE/DPMl04iUDVjDGxoreCO7yGayQkWsmbrMVTs468cdyrt+5Uneybs9FUzQRNxwvcIN7ZcYrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790692664; c=relaxed/simple;
	bh=d27ZelXQKR/wSde/tghjrO0nUulIuc70YQmNVyALwQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CH4O5KQ+4AbEGu7ccH8NoYkeeSEC8qKJSZ8odFB9g4BO08qFOcmmNsepKPPDys2DM5ksjYsYiIo5iRmjtDCp5mQO7LGvPUvGNz9bGsTQAjGvfhIGNt3uNnFGrYPKoDU4DmqlMkD098LuctcJsuBKbri/YoPldqkNmt1J/CY7R8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sFh2KhFB; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFh2KhFB"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e6598dd44so27319675e9.1
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 07:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790692657; x=1791297457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pmNAjK5szAdBHkEVJ9XXUgS7YROss1M18tgbGJczwlc=;
        b=sFh2KhFBSYP0nrtK6uSmTpyUmoWqNOUT2E3ugg8Gf2pyCOfPIWBylWhOBwcLbe/n4R
         kvLJIuVaIJG6InvFPZEKw31UfqFNMKOtnIzprFeARbxyMDfiYbZBrKLrEQVUpRYdwpdP
         WCMG+YB3G6CUH++J3LdIvJJVrnPoavOOrv2Zf8BmZOWK0jSGHto4lZL5nRE6CIY6C2oU
         IK7/0CSsrT/Sn1kNwprHg+8rIEvOvvO9zIzy0o9CLV8b7GAvLcVi25/Qd7g7G6kLsw6G
         ZgccQdrsopQTbBsLFlOMY3vpOZXCXDrz9fqXEt8Qahd37CKxGYAe6KdyAfYJ9NwgSCiN
         qa7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790692657; x=1791297457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pmNAjK5szAdBHkEVJ9XXUgS7YROss1M18tgbGJczwlc=;
        b=H9omkTegT3Ka5gJ35JfF5sSi5Xv7vtPr1vfouCDcY+AXWDkBOa1NcF82LS1/WOGNOD
         +bZ2lbM7T6RQiTOWCG3LBvWUbMIRfCItSzXEioOQFLb8FJEQ4UgwtqWb6qDfBObSZXal
         E/Y8Sbe69K8281BhZ2m6MowBOMagnRHOoFttursEVbID8F+Ceu1JIfMwX0am7mgiXDV9
         EpOvn45KA6HXAu0yBBuYWqhsB17BZjqX1//z4DdbYvLYaq/T6DKngJGbrch18sraAzAs
         rjYO5FHftHM087tbwgbgLH73Uag6xYgBMv71yYNZ60uMLsy2eVrNvxGdp/jGcBuPecCE
         URsA==
X-Forwarded-Encrypted: i=1; AKwUvBzAdw/W85zEwggkJQOXgUIMWv89HfwVISStPUmshpNxdjmBxFHV9SBkkKawYvuq8HpBYHRkLIY=@vger.kernel.org
X-Gm-Message-State: AFuF++lvg/W9zgupplgNVIeX1XZYKVGcA56eAW9kLpMYCPToL6Ci/5r6
	2uK/t9W2PbOOimPO0VWlB/3JiNbuHTjL11yqDgrvivkN5aDyHxTbZtEn
X-Gm-Gg: AYBFou1aPf7S68E1fLKqmm+4pk/fS4ryxrpgu+wrsF7Bgn3Le+tJXchIURSB3ilySn3
	Yd99az4p53kyfeB0ElnAlrDhOTdo9mqZcG3vcR7Plp1MtskgWpsxr0cFcD7QYgiFn8JJki6Sak1
	nILAPR7x4evaepdagWCL9IRn7wFwm1SlRo8W7n0SfgMm7V82A1TP/fd5xMJXvqzI1zO2xGXqYZa
	FuhODwuGes951nWuC+aeYYSNTYp260EOY7LYyuwL9K3XL+LaytGM/ACfgZvIkm78bq3qBwM77EI
	Kf78/C0Q/mt4lTKxiLfTI95MHJcxlvyDZecUfxJu/xEPWldJDpn+odZeRvpAmQt04ALUDDsSnxV
	lgsFDD1KZMrE5nstaQDJ/rGWx/Gs6pdzbYV/zZ9kZGzhC19eSi5XJmOk0K4ZfENt9gP3cSkW+N3
	G4vwgs4aDq8oT5/8S3R/+ImzPoJ5z+iLVUMDfio/Oh2Pzd4m8tOGB+GMg5sbwevmqhZUFCwVkET
	VI0tw6LzQFLiPMwWBPQKiiNPcJ6rc/7YPVSNq5O3zIv9RbVXlVWrxLCTYQ=
X-Received: by 2002:a05:600c:19d3:b0:49e:6777:da79 with SMTP id 5b1f17b1804b1-49fe66fb4a7mr278687585e9.26.1790692656888;
        Tue, 29 Sep 2026 07:37:36 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cf8f93csm89716995e9.5.2026.09.29.07.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 07:37:36 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: linux-media@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Antti Laakso <antti.laakso@linux.intel.com>,
	Sarang Sapre <sarang.sapre@intel.com>,
	Bingbu Cao <bingbu.cao@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] media: ipu6: Fix firmware config leak on stream start
Date: Tue, 29 Sep 2026 15:37:30 +0100
Message-ID: <20260929143731.43358-3-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929143731.43358-1-devnexen@gmail.com>
References: <20260929143731.43358-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipu6_isys_fwcom_cfg_init() runs on every first stream start and allocates
the firmware config and queue configs with devm, so each STREAMON/STREAMOFF
cycle leaks them. They are only needed until ipu6_fw_com_prepare() has
copied them, so free them right after. Also check the return value, an
allocation failure would otherwise make ipu6_fw_com_prepare() dereference
a NULL queue config.

Fixes: f625e8d7ffc1 ("media: intel/ipu6: input system ABI between firmware and driver")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/media/pci/intel/ipu6/ipu6-fw-isys.c | 34 +++++++++++++++------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/media/pci/intel/ipu6/ipu6-fw-isys.c b/drivers/media/pci/intel/ipu6/ipu6-fw-isys.c
index 3cad7d8f9ca9..22452f3916ba 100644
--- a/drivers/media/pci/intel/ipu6/ipu6-fw-isys.c
+++ b/drivers/media/pci/intel/ipu6/ipu6-fw-isys.c
@@ -212,7 +212,6 @@ static int ipu6_isys_fwcom_cfg_init(struct ipu6_isys *isys,
 	unsigned int max_send_queues, max_sram_blocks, max_devq_size;
 	struct ipu6_fw_syscom_queue_config *input_queue_cfg;
 	struct ipu6_fw_syscom_queue_config *output_queue_cfg;
-	struct device *dev = &isys->adev->auxdev.dev;
 	int type_proxy = IPU6_FW_ISYS_QUEUE_TYPE_PROXY;
 	int type_dev = IPU6_FW_ISYS_QUEUE_TYPE_DEV;
 	int type_msg = IPU6_FW_ISYS_QUEUE_TYPE_MSG;
@@ -222,7 +221,6 @@ static int ipu6_isys_fwcom_cfg_init(struct ipu6_isys *isys,
 	struct ipu6_fw_isys_fw_config *isys_fw_cfg;
 	u32 num_in_message_queues;
 	unsigned int max_streams;
-	unsigned int size;
 	unsigned int i;
 
 	max_streams = isys->pdata->ipdata->max_streams;
@@ -230,7 +228,7 @@ static int ipu6_isys_fwcom_cfg_init(struct ipu6_isys *isys,
 	max_sram_blocks = isys->pdata->ipdata->max_sram_blocks;
 	max_devq_size = isys->pdata->ipdata->max_devq_size;
 	num_in_message_queues = clamp(num_streams, 1U, max_streams);
-	isys_fw_cfg = devm_kzalloc(dev, sizeof(*isys_fw_cfg), GFP_KERNEL);
+	isys_fw_cfg = kzalloc_obj(*isys_fw_cfg);
 	if (!isys_fw_cfg)
 		return -ENOMEM;
 
@@ -242,15 +240,14 @@ static int ipu6_isys_fwcom_cfg_init(struct ipu6_isys *isys,
 	isys_fw_cfg->num_recv_queues[type_dev] = 0;
 	isys_fw_cfg->num_recv_queues[type_msg] = 1;
 
-	size = sizeof(*input_queue_cfg) * max_send_queues;
-	input_queue_cfg = devm_kzalloc(dev, size, GFP_KERNEL);
+	input_queue_cfg = kzalloc_objs(*input_queue_cfg, max_send_queues);
 	if (!input_queue_cfg)
-		return -ENOMEM;
+		goto err_free_fw_cfg;
 
-	size = sizeof(*output_queue_cfg) * IPU6_N_MAX_RECV_QUEUES;
-	output_queue_cfg = devm_kzalloc(dev, size, GFP_KERNEL);
+	output_queue_cfg = kzalloc_objs(*output_queue_cfg,
+					IPU6_N_MAX_RECV_QUEUES);
 	if (!output_queue_cfg)
-		return -ENOMEM;
+		goto err_free_input_queue_cfg;
 
 	fwcom_cfg->input = input_queue_cfg;
 	fwcom_cfg->output = output_queue_cfg;
@@ -315,6 +312,20 @@ static int ipu6_isys_fwcom_cfg_init(struct ipu6_isys *isys,
 	fwcom_cfg->specific_size = sizeof(*isys_fw_cfg);
 
 	return 0;
+
+err_free_input_queue_cfg:
+	kfree(input_queue_cfg);
+err_free_fw_cfg:
+	kfree(isys_fw_cfg);
+
+	return -ENOMEM;
+}
+
+static void ipu6_isys_fwcom_cfg_free(struct ipu6_fw_com_cfg *fwcom_cfg)
+{
+	kfree(fwcom_cfg->specific_addr);
+	kfree(fwcom_cfg->output);
+	kfree(fwcom_cfg->input);
 }
 
 static int ipu6_fw_isys_init(struct ipu6_isys *isys, unsigned int num_streams)
@@ -328,10 +339,13 @@ static int ipu6_fw_isys_init(struct ipu6_isys *isys, unsigned int num_streams)
 	};
 	int ret;
 
-	ipu6_isys_fwcom_cfg_init(isys, &fwcom_cfg, num_streams);
+	ret = ipu6_isys_fwcom_cfg_init(isys, &fwcom_cfg, num_streams);
+	if (ret)
+		return ret;
 
 	isys->fwctx = ipu6_fw_com_prepare(&fwcom_cfg, isys->adev,
 					  isys->pdata->base);
+	ipu6_isys_fwcom_cfg_free(&fwcom_cfg);
 	if (!isys->fwctx) {
 		dev_err(dev, "isys fw com prepare failed\n");
 		return -EIO;
-- 
2.55.0

