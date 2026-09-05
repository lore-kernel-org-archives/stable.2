Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.187.6.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D877DA66;
	Sat,  5 Sep 2026 01:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.187.6.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788572798; cv=none; b=Tzqzvg1G+K6DQARo0dZ1xgOYR/aXjllkEMnLqvDtKKfdvyap+OOv6UM8h1IGonuGPZz9OTvPxa/t+NZT5tRonmrf9Np7U/DrFmYAgccC25w4WvoPC/kr7tFdh7UGAa89zJmpCD7CevJha/kuUjD4GJQ1J2pqYr3avtQ2Evu6ivQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788572798; c=relaxed/simple;
	bh=KouDW1qDoJWD1jaiqezuVaYg+AKxnKoaxgcIv1NiC7o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qV2jHH0vvstYp12HcF7SQ9HRLsnO43yl/lrr49UGOcZYUFIYwiUyeuXQ9Dx5abIDwQk9JyUyqWKJK2JJ6FbmD4fJAYIuQKwz/CynXQaIWW51izsJUc2UImq4dVSamqXVCMKNtR0uodnH3R7HtxkK4HU8aN9g2gsuT0bPOxRCUxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.187.6.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wAHwz1sdJtqp7LwAA--.5161S3;
	Sat, 05 Sep 2026 09:46:21 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app3 (Coremail) with SMTP id zS_KCgAHIHJsdJtqqgTxBA--.23681S2;
	Sat, 05 Sep 2026 09:46:20 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: linux-pci@vger.kernel.org
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	Frank.Li@kernel.org,
	den@valinux.co.jp,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>
Subject: [PATCH] PCI: endpoint: pci-epf-test: Free doorbell IRQ on unbind and deinit
Date: Sat,  5 Sep 2026 01:45:25 +0000
Message-Id: <20260905014525.420764-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgAHIHJsdJtqqgTxBA--.23681S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?VlmG0wXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnZPoDCNGYdHSfuFmYJL54WNRmDW6Lulsi3SWS9iggSWYZtbcyxek/B+YnB4qJzEgLiEs
	oAYSUiBQunrsF6X+03ap9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxCry5Cw45ArykWr13Cr1ktFc_yoW5tr47pF
	ZxArykKF4kWa1DXw45Xa18CrWfAF4vq3y09r1UGw13Awn3Xr18tF4Iq3W8tF4kJrZ5Z3Wa
	y3Z0qFnrXwnIy3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Cb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjx
	CEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAF
	wI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwACjcxG0xvY0x0EwIxGrVCF72vEw4AK0wCF04k20xvY0x0EwIxGrwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
	Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jUGYJUUUUU=

Neither pci_epf_test_unbind() nor pci_epf_test_epc_deinit() frees the
doorbell IRQ. epc_deinit() clears the BARs, while unbind() can free the
BAR backing store; if the doorbell is enabled, its IRQ action remains
registered with epf_test as dev_id and epf->db_msg stays allocated. A
doorbell interrupt may already have awakened the threaded handler when
teardown starts, and since cancel_delayed_work_sync() drains only the
command worker and clear_bar() does not wait for the IRQ thread,
unbind() can free that backing while the handler still dereferences
epf_test->reg[]. The leftover IRQ also makes the next doorbell
allocation on the same function fail with -EBUSY.

Free the doorbell IRQ in both paths, guarded by a
doorbell_irq_registered flag set once request_threaded_irq() has
succeeded and cleared in pci_epf_test_doorbell_cleanup(), the
chokepoint shared by the enable error path, disable_doorbell() and the
teardown sites, so no disarm path can double-free. In unbind(), the
drain depends on the driver's own flag, not on epc->init_complete.

This issue was found by an in-house static analysis tool.

Fixes: eff0c286aa91 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index d4905aa..ab8df91 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -95,6 +95,7 @@ struct pci_epf_test {
 	const struct pci_epc_features *epc_features;
 	struct pci_epf_bar	db_bar;
 	bool			db_bar_programmed;
+	bool			doorbell_irq_registered;
 	size_t			bar_size[PCI_STD_NUM_BARS];
 };
 
@@ -721,6 +722,7 @@ static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
 	struct pci_epf *epf = epf_test->epf;
 
 	reg->doorbell_bar = cpu_to_le32(NO_BAR);
+	epf_test->doorbell_irq_registered = false;
 
 	pci_epf_free_doorbell(epf);
 }
@@ -772,6 +774,7 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
 		goto err_doorbell_cleanup;
 	}
 
+	epf_test->doorbell_irq_registered = true;
 	reg->doorbell_data = cpu_to_le32(msg->data);
 	reg->doorbell_bar = cpu_to_le32(bar);
 
@@ -1238,6 +1241,10 @@ static void pci_epf_test_epc_deinit(struct pci_epf *epf)
 
 	cancel_delayed_work_sync(&epf_test->cmd_handler);
 	pci_epf_test_clean_dma_chan(epf_test);
+	if (epf_test->doorbell_irq_registered) {
+		free_irq(epf->db_msg[0].virq, epf_test);
+		pci_epf_test_doorbell_cleanup(epf_test);
+	}
 	pci_epf_test_clear_bar(epf);
 }
 
@@ -1374,6 +1381,10 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 	struct pci_epc *epc = epf->epc;
 
 	cancel_delayed_work_sync(&epf_test->cmd_handler);
+	if (epf_test->doorbell_irq_registered) {
+		free_irq(epf->db_msg[0].virq, epf_test);
+		pci_epf_test_doorbell_cleanup(epf_test);
+	}
 	if (epc->init_complete) {
 		pci_epf_test_clean_dma_chan(epf_test);
 		pci_epf_test_clear_bar(epf);

