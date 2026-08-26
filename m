Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A22743C061
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 18:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787769875; cv=none; b=Fyzf0ZzAHgR303htG+Aq90Cg+ZiYE/Aj5Q5CxEj5ufkDFfUJUPL4oImKpyO1DjptK249EGaXbn4fjDSHoyfyW/Whm0+uvqkST0aTH9OB7HaSQybQFl2mT82PcqP2rJfUP124kAl6lMtcSEbYmh/8fEEndbt6MUlcaa2SO/oA9KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787769875; c=relaxed/simple;
	bh=K8+JXwQwIChfIJ86bGFQQylRGRVSXo+P9SL8keyK5g0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAkrxNBpiTompkd/i72EEy3DWCdSUcHjHb/BLlxKkScfj/kLD+PJ4ru7MohLVi/vPx16P4mAsrhYcuPEczueB3vP2bgQsZ4upfc3XdcbsJo0MifqfSBtQVtVSSsuswC2rbV5WirdgO2QVbYZrGa/vJIJvhbMdWKPf/KGK0M0XzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVAgCXmu; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVAgCXmu"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8588583a7c3so11870857b3.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 11:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787769860; x=1788374660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SNJYtUVMDII5y7fz/pInb4E0R2wJit2uplr7wHikXAw=;
        b=cVAgCXmulKT4B4fewmojy29YPxzZOwe4PWMwS9I1qmMurSRxjkE+DJqW5Cq/XgVt7F
         j+exYsyZYR767l/h3/cle3MCrAHyOr4nS5DrR0bsHHU105L5yuibqwCXmvU87xKk2ZLM
         RBBsfGmnO/gEaYZskCCTBTxl5pH80RQndepGkFtnhG4WzANFKQxxP0/KhlkUqLYWPFEq
         ay0oUwz+eTrATyhqNItzLjBdhen/LTTqj6BsWaP9wrCQHuv+pm0TKhlRVrb+VyTVfUXW
         GDHwkKp/f4bNSdweh2Dfhq4Y5yeWuA4Lbshcndd+TV78jBNj4hGJOEvBqeu/carZIe3d
         vwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787769860; x=1788374660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SNJYtUVMDII5y7fz/pInb4E0R2wJit2uplr7wHikXAw=;
        b=De/Uy8vKMb1B81XzwvE1NY+6cXlMSsQqURze3a9bkOz/hH2KI0DcRRmNPUPJPMF6VN
         3Rh1jO3tIPX1HrpyL6NNpfOUFMqCiiIFKX8RdYcqOk/J3sRlR7NT5+le13LSbpWQjz+7
         zOF2bUMF/xl/yekiGQFIbQzFeh66+caTPFqWlpgMTXyjqrmI3QzdqP8e/i/ut2KsAxxV
         jgRtNYgAnDWVvRSVEy3ZDLlMMA4aczDpMRGtOKYxKJcgmEqU67ECMZFUOvo4G/5YVr95
         n1RrKImi8fmU/b2dtRgtITNvyc/jZS1adAaMXMcYUM22AGhROUdtIvOZF5qR9QXbSegJ
         5wsg==
X-Forwarded-Encrypted: i=1; AHgh+Rpz+5TDKhRgBg8W7uBK0ytNWc6oZmS0zUJtFIgeRvYs8TqcrQ+Seb/PaeViHPlo5WIhuv3jT9s=@vger.kernel.org
X-Gm-Message-State: AFuF++lAILPuiH7qbktaaFT+AqiMI9Hc5I8/vN10qP3mokQ8jfMxuBrF
	VBYTLup4Avoixm9hi4Dpa5WFdwPtPa9bs51zK0CaOmRI3iP7cNNARL85
X-Gm-Gg: AR+sD10X3InuOtIWaJvp3L25W4MyC2KHMTZqfufqSneKpcyqIRjfmKRsARSKcGVxE30
	NKUMCpEnarPicBfPgoj7e0oY0WDeVkIHMrmmpA76f3S5V6XNQvvWEomclCEE68lCJHJIhXNsr9f
	jN59nfHvTzNkUhcFYgDd7FP7KyUFWeE4T6doxAwtjyP+husBKzECNrUn+s4RGgDCn4kzyptUH6g
	UMH/QkRP6amL2zw+4rm1n+XPOXv5mvGA8AItBgx5Xl7Lm2vhJfyuKP1yuuSDJOLRdMs7TykpFr7
	mgDol60lJSoHtvI9sCHwvk7SBJFpwWInd89yrVmVqQu1DQf1xCJaBXpPDvkN4a1Zrc5uqf9RZOY
	HvCBV+pg+vPf0/NEpQsDA2TmuTLXhr0mMB9Eo3am/9IHAZ+baW3mcdCxxtb55RTzbP9Pn1F56BK
	28lFyW2PMH56KQPlmp6uGWeDk8HMOMXrzya4ATVXmiOG3B5ElDbEH36XIs0OPJFUM5E647CMJwU
	y0uSXE4MPOstv1vtW1YIOEYDcNvsuYug4gDNG0=
X-Received: by 2002:a05:690c:f13:b0:81c:b865:2231 with SMTP id 00721157ae682-857440ff56cmr34556607b3.33.1787769859938;
        Wed, 26 Aug 2026 11:44:19 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8570d04e004sm20970317b3.36.2026.08.26.11.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 11:44:19 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Gregory Price <gourry@gourry.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Anisa Su <anisa.su@samsung.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] cxl/events: Bound the event log drain loop
Date: Wed, 26 Aug 2026 11:43:08 -0700
Message-ID: <20260826184417.1042-1-anisa.su@samsung.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1787768932.git.anisa.su@samsung.com>
References: <cover.1787768932.git.anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_event_thread() drains every log named in the Event Status register and
repeats until that register reads zero.  CXL 8.2.9.3.1 Table 8-203 marks
the register RO and leaves clearing it to the device, so a misbehaving device
that leaves a status bit set spins the thread forever, resending
Get Event Records as fast as the mailbox completes.

Bound the loop on work completed instead.  cxl_mem_get_records_log() and
cxl_mem_get_event_records() report failures and which logs returned
records; the thread stops on the first error and drops any log whose status
bit was set while it returned nothing.  Every pass either drains a record
or clears a bit from the mask, so the loop terminates whatever the device
reports.  Logs are drained best effort, so a broken one does not suppress
reporting from the rest.

Fixes: a49aa8141b65 ("cxl/mem: Wire up event interrupts")
Cc: <stable@vger.kernel.org>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
---
 drivers/cxl/core/mbox.c      | 58 ++++++++++++++++++++++++++++--------
 drivers/cxl/cxlmem.h         |  3 +-
 drivers/cxl/pci.c            | 39 +++++++++++++++++++-----
 tools/testing/cxl/test/mem.c |  4 +--
 4 files changed, 81 insertions(+), 23 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 7c6c5b7450a5..5954ba20f0be 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1059,8 +1059,8 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 	return rc;
 }
 
-static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
-				    enum cxl_event_log_type type)
+static int cxl_mem_get_records_log(struct cxl_memdev_state *mds,
+				   enum cxl_event_log_type type, bool *drained)
 {
 	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
 	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
@@ -1068,12 +1068,15 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 	struct cxl_get_event_payload *payload;
 	u8 log_type = type;
 	u16 nr_rec;
+	int rc = 0;
+
+	*drained = false;
 
 	mutex_lock(&mds->event.log_lock);
 	payload = mds->event.buf;
 
 	do {
-		int rc, i;
+		int i;
 		struct cxl_mbox_cmd mbox_cmd = (struct cxl_mbox_cmd) {
 			.opcode = CXL_MBOX_OP_GET_EVENT_RECORD,
 			.payload_in = &log_type,
@@ -1094,6 +1097,7 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 		nr_rec = le16_to_cpu(payload->record_count);
 		if (!nr_rec)
 			break;
+		*drained = true;
 
 		for (i = 0; i < nr_rec; i++)
 			__cxl_event_trace_record(cxlmd, type,
@@ -1112,31 +1116,59 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 	} while (nr_rec);
 
 	mutex_unlock(&mds->event.log_lock);
+
+	return rc;
 }
 
 /**
  * cxl_mem_get_event_records - Get Event Records from the device
  * @mds: The driver data for the operation
  * @status: Event Status register value identifying which events are available.
+ * @drained: Optional mask of the logs in @status that returned records.
  *
  * Retrieve all event records available on the device, report them as trace
- * events, and clear them.
+ * events, and clear them.  Every log named in @status is drained even if
+ * another one fails, so that a broken log does not suppress reporting from
+ * the rest.
+ *
+ * Return: 0, or the first error encountered.
  *
  * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
  * See CXL rev 3.0 @8.2.9.2.3 Clear Event Records
  */
-void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status)
+int cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status,
+			      u32 *drained)
 {
+	static const struct {
+		u32 status;
+		enum cxl_event_log_type type;
+	} logs[] = {
+		{ CXLDEV_EVENT_STATUS_FATAL, CXL_EVENT_TYPE_FATAL },
+		{ CXLDEV_EVENT_STATUS_FAIL, CXL_EVENT_TYPE_FAIL },
+		{ CXLDEV_EVENT_STATUS_WARN, CXL_EVENT_TYPE_WARN },
+		{ CXLDEV_EVENT_STATUS_INFO, CXL_EVENT_TYPE_INFO },
+	};
+	int ret = 0;
+
 	dev_dbg(mds->cxlds.dev, "Reading event logs: %x\n", status);
 
-	if (status & CXLDEV_EVENT_STATUS_FATAL)
-		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_FATAL);
-	if (status & CXLDEV_EVENT_STATUS_FAIL)
-		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_FAIL);
-	if (status & CXLDEV_EVENT_STATUS_WARN)
-		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_WARN);
-	if (status & CXLDEV_EVENT_STATUS_INFO)
-		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_INFO);
+	if (drained)
+		*drained = 0;
+
+	for (int i = 0; i < ARRAY_SIZE(logs); i++) {
+		bool got_records;
+		int rc;
+
+		if (!(status & logs[i].status))
+			continue;
+
+		rc = cxl_mem_get_records_log(mds, logs[i].type, &got_records);
+		if (got_records && drained)
+			*drained |= logs[i].status;
+		ret = ret ?: rc;
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, "CXL");
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index ed419d0c59f2..cb5372eb2d85 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -803,7 +803,8 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				unsigned long *cmds);
 void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				  unsigned long *cmds);
-void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
+int cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status,
+			      u32 *drained);
 void cxl_event_trace_record(struct cxl_memdev *cxlmd,
 			    enum cxl_event_log_type type,
 			    enum cxl_event_type event_type,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 267c679b0b3c..3daf17835c06 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -514,21 +514,46 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
 	struct cxl_dev_id *dev_id = id;
 	struct cxl_dev_state *cxlds = dev_id->cxlds;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
-	u32 status;
+	u32 mask = CXLDEV_EVENT_STATUS_ALL;
+
+	while (mask) {
+		u32 status, drained, stuck;
+		int rc;
 
-	do {
 		/*
 		 * CXL 3.0 8.2.8.3.1: The lower 32 bits are the status;
 		 * ignore the reserved upper 32 bits
 		 */
 		status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
-		/* Ignore logs unknown to the driver */
-		status &= CXLDEV_EVENT_STATUS_ALL;
+		/* Ignore logs unknown to the driver, and logs given up on */
+		status &= mask;
 		if (!status)
 			break;
-		cxl_mem_get_event_records(mds, status);
+
+		/*
+		 * A failed drain leaves the log's status bit set, so another
+		 * pass would resend the same query forever.
+		 */
+		rc = cxl_mem_get_event_records(mds, status, &drained);
+		if (rc)
+			break;
+
+		/*
+		 * The Event Status register is device owned and read only, so
+		 * it cannot bound this loop; records read can.  A device that
+		 * leaves a bit set with an empty log makes no progress, and
+		 * only the device can clear that state, so stop polling that
+		 * log rather than spin on it.
+		 */
+		stuck = status & ~drained;
+		if (stuck) {
+			dev_warn_once(cxlds->dev,
+				      "Event status %#x set with no records to read\n",
+				      stuck);
+			mask &= ~stuck;
+		}
 		cond_resched();
-	} while (status);
+	}
 
 	return IRQ_HANDLED;
 }
@@ -682,7 +707,7 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
 	if (rc)
 		return rc;
 
-	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
+	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL, NULL);
 
 	return 0;
 }
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index a7da279aa3ef..87e01612cea9 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -372,7 +372,7 @@ static void cxl_mock_event_trigger(struct device *dev)
 			event_reset_log(log);
 	}
 
-	cxl_mem_get_event_records(mdata->mds, mes->ev_status);
+	cxl_mem_get_event_records(mdata->mds, mes->ev_status, NULL);
 }
 
 struct cxl_event_record_raw maint_needed = {
@@ -1805,7 +1805,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		dev_dbg(dev, "No CXL FWCTL setup\n");
 
-	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
+	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL, NULL);
 	cxl_mock_test_feat_init(mdata);
 
 	return 0;
-- 
2.43.0

