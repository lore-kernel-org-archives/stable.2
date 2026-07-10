Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8B72D5C7A
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783650630; cv=none; b=hD0S2cZxlsmndXDLhV8iCRCBGtVeZTFrHJzzkoh8WNLk4P7PEpllewGLzq7bY/WaV6+DmDTEG8lHHHbZ0n+mr/mhsldqH1PvGGSpRs6oa4zCxEyC3I2+JiMG87y0teg4WgnkgbW0zJ+HqinzqRQdg0b7vnPB9NSjzvMjJBKdYFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783650630; c=relaxed/simple;
	bh=6rcoTl5xiJEaGPQJTsD/mlHreqv+V88NduNqHg/I68c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XgtpH+6QB2diycCo8VQD4Kg9apx0ufGyb0hBMMI9WknUcCJATkSorGln4/3Nv9qgRbNTuQSUfk6KrHJtt1mzA4PLOtTmqSmELCa26czFf2J4x+dXj+vJTUB4wWSDYhvcFt+k4p/AmsE7zF0icGl1UMbRzfx15SlApv5f40ihuOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W3IXwVlr; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W3IXwVlr"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e5b048375so18372385a.1
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 19:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783650626; x=1784255426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q1TRFmapyBVbWd7VNMC/WNlG0M10kUIkWE/yDLtryY8=;
        b=W3IXwVlrpdh/nw+w5EVAlyHj2b5V5rWxHpPSkVLTKjnitNDJchdV7u569SzrgX8p2A
         Geo43uJinvaV6oNpkfdsRU4w7llp+YNB0p7jnDiNBiYKjr8tw8jKbqS8PwBTHQOc33zq
         pPBpLGsTh+/BaLsLJt1NcTnpyZHkWp8OjQWaF0oH6UmYG8yCovju5ifJ/fxZKV0cruj/
         bCp4/dReYn/3IeJwi0pndAE453lkculHadIDwsN4KM51qm+aBcmXFu+4QfmmhnG6IvCe
         3BTrs2A6GA99+WwHwO7Z9QdkqeXP+3oFH1jnVMI/XDYjn33HBECcb063YH4PrP7AD2Dy
         IxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783650626; x=1784255426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q1TRFmapyBVbWd7VNMC/WNlG0M10kUIkWE/yDLtryY8=;
        b=lZsKAri5Ty99yt9o6hhPzBR52l6VyRy98Tfgm62zVrHr/MaeV66THJ4jAMnBrUUCoO
         j292SnXvi0YlsxavLcAr6IO4IGmTOICZNHhAJJfCmIFQTlOZ0FoQucXJR3Y6LIPRHgzB
         jrKOXkzr8Q5/KWTPnncqQdoc9Aq17FYsAwvtdAJ/OR25YzdYNWYTnqXKTgOMHWdaibRi
         r/RME9MUJNXHpgsXr4s3rECjJckQPJH9jrTRcQRb1cZ449h2oeRED815y1bgdxJnYhKJ
         YlELhnSYR9ixc5oIE19nCTV96EOtAiOT183ygwQTaSh256GTHYCtd36vYYYU4x8vxBt/
         x89g==
X-Forwarded-Encrypted: i=1; AHgh+RrM3uct1g1F2rjZjPHIsEYusHwA2nxWhsna7xVVixb5MXunJo0ZenyES1Idp8xeW27iYoek/ho=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz94ZmRPUWJHzcbryZ7nhc6H8v7vSHTpM0vAzymvUhdLrmdR6xc
	dmwL3b8W7Urmw+6xPXz2wWuZMK5YaWfvEN6mXn17ns1xM6X0/UjT9hAK
X-Gm-Gg: AfdE7ckeGfrPxcCkJBVY/i/y8wKiyRWq5aTF0ZhH3WU73sKu/zRd7gOiUrvKqhlUU5B
	/n8q851Pht8F9kc/jGNU8frndfsykG9WZhN50bJfa8HUSVBflroA8G9CG8O+oAoGnuAizxx3myf
	teapW6YSdKZY7+ojMOAIQJEMKGLjHjzq1f4s0Q3mlbwfqPtMWnuAjnVU/+CT85SW5+IVzu1FGQp
	zcTfM5d4XSMPmsgfUuw/YjrHYqF8RMiYmiGPxbF2xuEbYZgWQAfRyHlR4/BB2vvLBDnQMADe6kz
	n4MeIjVvhh2qMyKMOi4tKfzTddKiRnPtBjqPitiHXpzdejGeyeZn2Md1UXLbKkro41ZxagMlA0p
	1p1Gs9W4asv1Q+/Bm2A8NIT7qvrpcoDYXdEBhw6OvtIaaPSzMSpntZRcEJbjeKEqcoLLA0YqIDS
	T0soWHPhZ6yk5mObCdTrxI0/1GszGn6uD9HsYwo0TrOw914Z+5ndyUeOTP7BhfPEw5qylOXz4W2
	vnwt6E7CgcDTkvAiDswhPW23yB8wl22TNlOcV4Oc14=
X-Received: by 2002:a05:620a:2842:b0:915:abc4:b580 with SMTP id af79cd13be357-92ecf5ddb30mr1039946985a.49.1783650625775;
        Thu, 09 Jul 2026 19:30:25 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5cf9d9bsm88854685a.28.2026.07.09.19.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:30:25 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: kwilczynski@kernel.org,
	Damien Le Moal <dlemoal@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] nvmet-pci: add KUnit coverage for endpoint queue IDs
Date: Thu,  9 Jul 2026 22:30:15 -0400
Message-ID: <20260710023015.3744082-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710023015.3744082-1-michael.bommarito@gmail.com>
References: <20260710023015.3744082-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Add KUnit coverage for the PCI endpoint target queue-id boundary. The tests
model the case where target-core max_qid is larger than the endpoint
transport's ctrl->nr_queues, confirm the common qid check accepts the
malformed id, and verify the endpoint callbacks reject out-of-range
Create/Delete SQ/CQ requests before indexing transport-private arrays.

This covers the regression fixed by the preceding patch.

Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/nvme/target/Kconfig   |  11 ++++
 drivers/nvme/target/pci-epf.c | 120 ++++++++++++++++++++++++++++++++++
 2 files changed, 131 insertions(+)

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 4904097dfd490..ea64bbe9882c5 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -127,3 +127,14 @@ config NVME_TARGET_PCI_EPF
 	  capable PCI controller.
 
 	  If unsure, say N.
+
+config NVMET_PCI_EPF_KUNIT_TEST
+	bool "NVMe PCI endpoint target KUnit tests" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	depends on NVME_TARGET_PCI_EPF=y
+	default KUNIT_ALL_TESTS
+	help
+	  KUnit tests for the NVMe PCI endpoint target transport.
+	  These tests exercise transport-private queue ID checks for
+	  Create/Delete SQ/CQ commands when target-core max_qid is larger than
+	  the endpoint controller's available queue arrays.
diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 5bddda09c0538..e2eb96f32fab5 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -20,6 +20,9 @@
 #include <linux/pci-epf.h>
 #include <linux/pci_regs.h>
 #include <linux/slab.h>
+#if IS_ENABLED(CONFIG_NVMET_PCI_EPF_KUNIT_TEST)
+#include <kunit/test.h>
+#endif
 
 #include "nvmet.h"
 
@@ -2667,3 +2670,120 @@ module_exit(nvmet_pci_epf_cleanup_module);
 MODULE_DESCRIPTION("NVMe PCI Endpoint Function target driver");
 MODULE_AUTHOR("Damien Le Moal <dlemoal@kernel.org>");
 MODULE_LICENSE("GPL");
+
+#if IS_ENABLED(CONFIG_NVMET_PCI_EPF_KUNIT_TEST)
+
+struct nvmet_pci_epf_kunit_ctx {
+	struct nvmet_ctrl tctrl;
+	struct nvmet_subsys subsys;
+	struct nvmet_pci_epf_ctrl ctrl;
+	struct nvmet_pci_epf nvme_epf;
+};
+
+static int nvmet_pci_epf_kunit_init(struct kunit *test)
+{
+	struct nvmet_pci_epf_kunit_ctx *ctx;
+	unsigned int qid;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	ctx->subsys.max_qid = 8;
+	ctx->tctrl.subsys = &ctx->subsys;
+	ctx->tctrl.drvdata = &ctx->ctrl;
+	ctx->tctrl.cqs = kunit_kcalloc(test, ctx->subsys.max_qid + 1,
+				       sizeof(*ctx->tctrl.cqs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->tctrl.cqs);
+	ctx->tctrl.sqs = kunit_kcalloc(test, ctx->subsys.max_qid + 1,
+				       sizeof(*ctx->tctrl.sqs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->tctrl.sqs);
+
+	ctx->ctrl.nr_queues = 2;
+	ctx->ctrl.tctrl = &ctx->tctrl;
+	ctx->ctrl.nvme_epf = &ctx->nvme_epf;
+	ctx->ctrl.sq = kunit_kcalloc(test, ctx->ctrl.nr_queues,
+				     sizeof(*ctx->ctrl.sq), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->ctrl.sq);
+	ctx->ctrl.cq = kunit_kcalloc(test, ctx->ctrl.nr_queues,
+				     sizeof(*ctx->ctrl.cq), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->ctrl.cq);
+
+	for (qid = 0; qid < ctx->ctrl.nr_queues; qid++) {
+		nvmet_pci_epf_init_queue(&ctx->ctrl, qid, true);
+		nvmet_pci_epf_init_queue(&ctx->ctrl, qid, false);
+	}
+
+	test->priv = ctx;
+	return 0;
+}
+
+static void nvmet_pci_epf_qid_control_test(struct kunit *test)
+{
+	struct nvmet_pci_epf_kunit_ctx *ctx = test->priv;
+	u16 status;
+
+	status = nvmet_check_io_cqid(&ctx->tctrl, 1, true);
+	KUNIT_EXPECT_EQ(test, status, (u16)NVME_SC_SUCCESS);
+
+	status = nvmet_pci_epf_create_cq(&ctx->tctrl, 1, 0, 1, 0, 0);
+	KUNIT_EXPECT_EQ(test, status,
+			(u16)(NVME_SC_INVALID_QUEUE | NVME_STATUS_DNR));
+}
+
+static void nvmet_pci_epf_qid_oob_test(struct kunit *test)
+{
+	struct nvmet_pci_epf_kunit_ctx *ctx = test->priv;
+	u16 bad_qid = ctx->ctrl.nr_queues;
+	u16 status;
+
+	status = nvmet_check_io_cqid(&ctx->tctrl, bad_qid, true);
+	KUNIT_EXPECT_EQ(test, status, (u16)NVME_SC_SUCCESS);
+
+	status = nvmet_pci_epf_create_cq(&ctx->tctrl, bad_qid, 0, 1, 0, 0);
+	KUNIT_EXPECT_EQ(test, status,
+			(u16)(NVME_SC_QID_INVALID | NVME_STATUS_DNR));
+}
+
+static void nvmet_pci_epf_qid_reject_all_test(struct kunit *test)
+{
+	struct nvmet_pci_epf_kunit_ctx *ctx = test->priv;
+	u16 bad_qid = ctx->ctrl.nr_queues;
+	u16 status;
+
+	status = nvmet_pci_epf_create_cq(&ctx->tctrl, bad_qid, 0, 1, 0, 0);
+	KUNIT_EXPECT_EQ(test, status,
+			(u16)(NVME_SC_QID_INVALID | NVME_STATUS_DNR));
+
+	status = nvmet_pci_epf_create_sq(&ctx->tctrl, bad_qid, 1, 0, 1, 0);
+	KUNIT_EXPECT_EQ(test, status,
+			(u16)(NVME_SC_QID_INVALID | NVME_STATUS_DNR));
+
+	status = nvmet_pci_epf_create_sq(&ctx->tctrl, 1, bad_qid, 0, 1, 0);
+	KUNIT_EXPECT_EQ(test, status,
+			(u16)(NVME_SC_QID_INVALID | NVME_STATUS_DNR));
+
+	status = nvmet_pci_epf_delete_cq(&ctx->tctrl, bad_qid);
+	KUNIT_EXPECT_EQ(test, status,
+			(u16)(NVME_SC_QID_INVALID | NVME_STATUS_DNR));
+
+	status = nvmet_pci_epf_delete_sq(&ctx->tctrl, bad_qid);
+	KUNIT_EXPECT_EQ(test, status,
+			(u16)(NVME_SC_QID_INVALID | NVME_STATUS_DNR));
+}
+
+static struct kunit_case nvmet_pci_epf_qid_test_cases[] = {
+	KUNIT_CASE(nvmet_pci_epf_qid_control_test),
+	KUNIT_CASE(nvmet_pci_epf_qid_oob_test),
+	KUNIT_CASE(nvmet_pci_epf_qid_reject_all_test),
+	{}
+};
+
+static struct kunit_suite nvmet_pci_epf_qid_test_suite = {
+	.name = "nvmet_pci_epf_qid",
+	.init = nvmet_pci_epf_kunit_init,
+	.test_cases = nvmet_pci_epf_qid_test_cases,
+};
+
+kunit_test_suite(nvmet_pci_epf_qid_test_suite);
+
+#endif
-- 
2.53.0
