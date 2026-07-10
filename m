Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D972D5926
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 02:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783650583; cv=none; b=Me4Y82wfmA5cychklRPplJbVbQ9b8hPagnf1G+dgjkZCdBJzUqu1kcc54m0tK/onExPGK1CGy/Bwmju3sTH654YHTc5JLKqmguDGrnQdfcBb2UClH/+BoQGXCv4BR6F6+g+SVlfr+ayPpo8+tpnTL1q7xJ9tSMNBmjEbBt0DTaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783650583; c=relaxed/simple;
	bh=oh1kfYgKX27DSge+HLhXzF1K4TKLBE9pDdto0ALosBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gr9HDg/MN6olVyFms4kN90HCD3Emw4kcyNiRkxC75EWgjHID2Q+PNKzY07KI5Uig9RJyIvx0Ng7XMwHZi8U20cJE0QnHM0XxV7SyA1ftNgg1zd159qgQztnBmJf6r/8B6r3sbKpJZ0ENttG4U7P3Kb1rkf2ij81DJzdS/z/4kLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtM4fSCk; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtM4fSCk"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c167c58f2so2712701cf.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 19:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783650581; x=1784255381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mSn3YhBAthUo8TVHErzQl7PVMQ/a9rmwb+lYlYlzHec=;
        b=WtM4fSCk8WQVq7J3/jep0Lo27p7P+M0h82njpmB26KnPQSTV8wXuhm1qZZ9QiWXE3r
         fpIGnKo/7pP5gZiI3s4tjXkM+BMhT7nzDmvcQDUfEqLYRkKrJKyBzVrAAt3SUXI1pT3w
         t8dwCj6pIUmaWHIE/UF2bl5RPnu6mpRR2QJZwvgMqcyjESrfzONxx0rOs2rAGNIbb7YS
         rLl16skn7nyRscKTvnOEBFYyG4x3p3k/JQDjX+zJVR2OHxJF8bl3LlF/ya/KHJNkBvx4
         xFxOfVx2e3yUYLzayo35fRoZaPe/ArH3E5z+djbea/wNdrN2T5nCE/YSv285WJ0tO+Z8
         oXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783650581; x=1784255381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mSn3YhBAthUo8TVHErzQl7PVMQ/a9rmwb+lYlYlzHec=;
        b=OXOLy6Hj4dv/1VwWc3NCqWI6U1uWPWUgwQ51PfdqfEJnk2Kg+va5WaznipeztLncgS
         MAXO4JgTOBvPmTk5k2Ais1iMNVY533qOLSJAOln522JtWDfvQW8zGouYP07Hfv4vF4pT
         YMHZT8SZCAIYokKtIIcgt3ej9mbrpu8mDC5j19TAc0n9RdxXjSlDF71tWBkmwIqXdfv1
         6ckc3IL1NUK0bamAyLGJUTYUO/1Oy4VAIIvzTA401vsRFE7oLH8c5G0VJIyVHfTCK9fl
         7z0ULpep4nuQr5c2woxeCBx+2XvlOmGrww3m8STJP6ydw+9HKEJ7ZVPhBb/UwtrTpGaw
         AGsQ==
X-Forwarded-Encrypted: i=1; AHgh+RrcMVQ953H2lVlQ9o4FmZW6tJBmjtt8RQwfV3jXw3qRXs3RONGwoK2malVWTPx4E695J/lrsCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwnd/K/zogUHMcI6SCk/WuhgbS4UtFjVJ2nE+M2C7Tw41WT4hM
	MTpCkOmB1Wz174ycHC+Gv4iPN8NQbRIghcWVpkp84pOwbX2pLUSXQIac
X-Gm-Gg: AfdE7cnuh71wjRrVst7wGYAGBmZ9nEriQJnnWGt3wsRVA73VEEqpkh/fd2/1Hl8luFo
	aj/WiLgXkYl07hPaVmMebBbGW4Ar5FFuhlb6HzV9lQo4apEAWCBp3RQPhDrtm0pUsozBM8TaW72
	h9aqry4wIW1e9XkLrwsuRWvgtEpuD4Z8zKyknWBwk1zFdtY4WGcuu1naHGiNi2syz/vh4/w1eS6
	9z21jmbi/PL9RGfV6Von25waeMe2LOb6PHensloefboOJop9/zzAR0nwcCUHWD38P/udNN4VzEU
	J+hyyRyo+UCbM1Sj7awkSqRlvzsZ1qPK032W50ULvJIXHu8cUHkQk3cuRHGkGGiT6qJHibnjrmZ
	yNIVEdHMTLRwD0P3Vx4L2quvorqo5uSZKOrN83QbZGIz93Y+rXRAk2GsBIZN5Wg0Sb6wxEOJDcZ
	Zz6efjK+JxqWiUpSYtJQeRkOh4pXttCIcnuaZhbu5Rs+0blq5XHGlr+ANAs37mJzYAGxqND4cic
	bf3rcYp61KeTzJYICk6QqzK4GPCyI4V
X-Received: by 2002:ac8:5a84:0:b0:51c:1967:5091 with SMTP id d75a77b69052e-51c8b3b4c44mr109183901cf.41.1783650580950;
        Thu, 09 Jul 2026 19:29:40 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caafd8b4fsm6951101cf.31.2026.07.09.19.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 19:29:39 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Justin Tee <justin.tee@broadcom.com>
Cc: Paul Ely <paul.ely@broadcom.com>,
	James Smart <jsmart2021@gmail.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] scsi: lpfc: add KUnit coverage for EDC descriptor bounds
Date: Thu,  9 Jul 2026 22:29:32 -0400
Message-ID: <20260710022932.3741311-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710022932.3741311-1-michael.bommarito@gmail.com>
References: <20260710022932.3741311-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Add KUnit coverage for lpfc_els_rcv_edc() descriptor-list bounds. The
tests live in lpfc_els.c so they can drive the real static EDC parser
without exporting test-only symbols.

The suite covers a valid congestion-signaling EDC descriptor and a
malformed EDC payload whose top-level descriptor-list length exceeds the
received payload. That malformed case documents the frame rejected by
the previous patch.

Assisted-by: Codex:gpt-5-5-xhigh
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/scsi/Kconfig         |   7 ++
 drivers/scsi/lpfc/lpfc_els.c | 154 +++++++++++++++++++++++++++++++++++
 2 files changed, 161 insertions(+)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index 19d0884479a24..e0f01ddd22707 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -1163,6 +1163,13 @@ config SCSI_LPFC_DEBUG_FS
 	  This makes debugging information from the lpfc driver
 	  available via the debugfs filesystem.
 
+config LPFC_EDC_KUNIT_TEST
+	bool "KUnit tests for lpfc EDC descriptor bounds" if !KUNIT_ALL_TESTS
+	depends on KUNIT && SCSI_LPFC
+	default KUNIT_ALL_TESTS
+	help
+	  Internal validation coverage for lpfc EDC descriptor list bounds.
+
 source "drivers/scsi/elx/Kconfig"
 
 config SCSI_SIM710
diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index 5408b116f2d5a..0711f88da3f1a 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -12574,3 +12574,157 @@ lpfc_cmpl_els_uvem(struct lpfc_hba *phba, struct lpfc_iocbq *icmdiocb,
 	lpfc_els_free_iocb(phba, icmdiocb);
 	lpfc_nlp_put(ndlp);
 }
+
+#if IS_ENABLED(CONFIG_LPFC_EDC_KUNIT_TEST)
+#include <kunit/device.h>
+#include <kunit/test.h>
+
+static void lpfc_edc_kunit_prep_stub(struct lpfc_iocbq *cmdiocbq,
+				     struct lpfc_vport *vport,
+				     struct lpfc_dmabuf *bmp, u16 cmd_size,
+				     u32 did, u32 elscmd, u8 tmo,
+				     u8 expect_rsp)
+{
+}
+
+static void lpfc_edc_kunit_release_stub(struct lpfc_hba *phba,
+					struct lpfc_iocbq *iocbq)
+{
+}
+
+static int lpfc_edc_kunit_issue_mbox_stub(struct lpfc_hba *phba,
+					  LPFC_MBOXQ_t *mboxq,
+					  uint32_t flag)
+{
+	mempool_free(mboxq, phba->mbox_mem_pool);
+	return 0;
+}
+
+static void lpfc_edc_kunit_setup_hba(struct kunit *test,
+				     struct lpfc_hba *phba,
+				     struct lpfc_vport *vport)
+{
+	struct lpfc_iocbq *free_iocbs;
+	struct device *kdev;
+	int i;
+
+	spin_lock_init(&phba->hbalock);
+	INIT_LIST_HEAD(&phba->lpfc_iocb_list);
+	INIT_LIST_HEAD(&phba->elsbuf);
+	phba->link_state = LPFC_LINK_DOWN;
+	phba->sli_rev = LPFC_SLI_REV3;
+	phba->__lpfc_sli_prep_els_req_rsp = lpfc_edc_kunit_prep_stub;
+	phba->__lpfc_sli_release_iocbq = lpfc_edc_kunit_release_stub;
+	phba->lpfc_sli_issue_mbox = lpfc_edc_kunit_issue_mbox_stub;
+	phba->pport = vport;
+
+	free_iocbs = kunit_kzalloc(test, 4 * sizeof(*free_iocbs), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, free_iocbs);
+	for (i = 0; i < 4; i++)
+		list_add_tail(&free_iocbs[i].list, &phba->lpfc_iocb_list);
+
+	kdev = kunit_device_register(test, "lpfc_edc_test");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, kdev);
+	phba->lpfc_mbuf_pool = dma_pool_create("lpfc_edc_mbuf", kdev,
+					       LPFC_BPL_SIZE, 8, 0);
+	KUNIT_ASSERT_NOT_NULL(test, phba->lpfc_mbuf_pool);
+	phba->mbox_mem_pool = mempool_create_kmalloc_pool(1,
+							  sizeof(LPFC_MBOXQ_t));
+	KUNIT_ASSERT_NOT_NULL(test, phba->mbox_mem_pool);
+}
+
+static void lpfc_edc_kunit_teardown_hba(struct lpfc_hba *phba)
+{
+	if (phba->mbox_mem_pool)
+		mempool_destroy(phba->mbox_mem_pool);
+	if (phba->lpfc_mbuf_pool)
+		dma_pool_destroy(phba->lpfc_mbuf_pool);
+}
+
+static void lpfc_edc_kunit_run(struct kunit *test, bool malformed)
+{
+	struct lpfc_hba *phba;
+	struct lpfc_vport *vport;
+	struct lpfc_nodelist *ndlp;
+	struct lpfc_iocbq *cmdiocb;
+	struct lpfc_dmabuf *cmd_dmabuf;
+	struct fc_els_edc *edc;
+	struct fc_tlv_desc *tlv;
+	size_t payload_len;
+
+	phba = kunit_kzalloc(test, sizeof(*phba), GFP_KERNEL);
+	vport = kunit_kzalloc(test, sizeof(*vport), GFP_KERNEL);
+	ndlp = kunit_kzalloc(test, sizeof(*ndlp), GFP_KERNEL);
+	cmdiocb = kunit_kzalloc(test, sizeof(*cmdiocb), GFP_KERNEL);
+	cmd_dmabuf = kunit_kzalloc(test, sizeof(*cmd_dmabuf), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, phba);
+	KUNIT_ASSERT_NOT_NULL(test, vport);
+	KUNIT_ASSERT_NOT_NULL(test, ndlp);
+	KUNIT_ASSERT_NOT_NULL(test, cmdiocb);
+	KUNIT_ASSERT_NOT_NULL(test, cmd_dmabuf);
+
+	vport->phba = phba;
+	ndlp->nlp_DID = Fabric_Cntl_DID;
+	lpfc_edc_kunit_setup_hba(test, phba, vport);
+
+	if (malformed)
+		payload_len = sizeof(*edc) + FC_TLV_DESC_HDR_SZ;
+	else
+		payload_len = sizeof(*edc) +
+			      sizeof(struct fc_diag_cg_sig_desc);
+
+	cmd_dmabuf->virt = kunit_kzalloc(test, payload_len, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, cmd_dmabuf->virt);
+	INIT_LIST_HEAD(&cmd_dmabuf->list);
+
+	edc = cmd_dmabuf->virt;
+	edc->edc_cmd = ELS_EDC;
+	tlv = edc->desc;
+	if (malformed) {
+		edc->desc_len = cpu_to_be32(0x100);
+		tlv->desc_tag = cpu_to_be32(0xdeadbeef);
+		tlv->desc_len = cpu_to_be32(0);
+	} else {
+		struct fc_diag_cg_sig_desc *cgn = (void *)tlv;
+
+		edc->desc_len = cpu_to_be32(sizeof(*cgn));
+		cgn->desc_tag = cpu_to_be32(ELS_DTAG_CG_SIGNAL_CAP);
+		cgn->desc_len =
+			cpu_to_be32(FC_TLV_DESC_LENGTH_FROM_SZ(*cgn));
+		cgn->xmt_signal_capability =
+			cpu_to_be32(EDC_CG_SIG_NOTSUPPORTED);
+		cgn->xmt_signal_frequency.count =
+			cpu_to_be16(EDC_CG_SIGFREQ_CNT_MIN);
+		cgn->xmt_signal_frequency.units =
+			cpu_to_be16(EDC_CG_SIGFREQ_MSEC);
+	}
+
+	cmdiocb->cmd_dmabuf = cmd_dmabuf;
+	lpfc_els_rcv_edc(vport, cmdiocb, ndlp, payload_len);
+
+	KUNIT_EXPECT_TRUE(test, true);
+	lpfc_edc_kunit_teardown_hba(phba);
+}
+
+static void lpfc_edc_control_test(struct kunit *test)
+{
+	lpfc_edc_kunit_run(test, false);
+}
+
+static void lpfc_edc_oob_test(struct kunit *test)
+{
+	lpfc_edc_kunit_run(test, true);
+}
+
+static struct kunit_case lpfc_edc_test_cases[] = {
+	KUNIT_CASE(lpfc_edc_control_test),
+	KUNIT_CASE(lpfc_edc_oob_test),
+	{}
+};
+
+static struct kunit_suite lpfc_edc_test_suite = {
+	.name = "lpfc_edc",
+	.test_cases = lpfc_edc_test_cases,
+};
+kunit_test_suite(lpfc_edc_test_suite);
+#endif /* CONFIG_LPFC_EDC_KUNIT_TEST */
