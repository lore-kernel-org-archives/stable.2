Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BC73F58F5
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511979; cv=none; b=EsucnrE/3fDpIjg+GdG9noYJ3FweaRcxZGlr8j8GAzUgmYhEa5gKEyzhJF3S7x6bkXXDuuHUoA+J5tsFiveOovoEOq8xLEfTgKc200Mg0LkfSpagyZEgYng4POO4p8PL0mjBDSWWzxbNoCiM5sRPd/PtW+cUYdWdAyxdUMUo1Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511979; c=relaxed/simple;
	bh=fASjv53DZwsUggOXhd/KS0Sl12OjEb7SLiFFAfWyVpI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QmghDJdazmI+Zbd6Ratnua2VnDy3UHuwdi/8zLJqdZu1vWQ767zFEFzMbBlCgPHofmHDPC/JsB+kn+FXTOxgnMLWP/PuV61mtGvSCICpQMxL6CvHgmxoLVexp2dhVdcJMjnDzjSKcTGEtwNqJW64l02iqoWg9B+/kNzqunZL4GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 016ba8aca83e11f19a56ed5b684f684d-20260904
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:e2d06210-5bc6-4cb8-909a-482a4ba7c03a,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:b6ab868a27b7a9a21e041c51ec84c36b,BulkI
	D:nil,BulkQuantity:0,SF:102|136|850|865|898,TC:nil,Content:0|15|50|99,EDM:
	5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 016ba8aca83e11f19a56ed5b684f684d-20260904
X-User: zhangyunfei1@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangyunfei1@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 116729281; Fri, 04 Sep 2026 16:52:49 +0800
From: Zhang Yunfei <zhangyunfei1@kylinos.cn>
To: zyf1352022@163.com
Cc: stable@vger.kernel.org
Subject: [PATCH iwl-net] idpf: fix NULL pointer dereference and memory leak in interrupt request
Date: Fri,  4 Sep 2026 16:52:46 +0800
Message-Id: <20260904085246.890745-1-zhangyunfei1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kasprintf() call in idpf_vport_intr_req_irq() can return NULL on
memory pressure, but the result is passed directly to request_irq()
without a NULL check. The IRQ core then stores this pointer as
action->name and dereferences it later from /proc/interrupts and
procfs, leading to a NULL pointer dereference.

Add a NULL check after kasprintf() and bail out with -ENOMEM.

Additionally, when request_irq() fails, request_threaded_irq() frees
the irqaction itself without taking ownership of the name string, so
the caller-allocated name is leaked. Free it on the error path only.
On the success path the name is owned by the irq action and released
later via kfree(free_irq(...)) in the cleanup loop, so it must not be
freed here.

Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
Cc: stable@vger.kernel.org # 6.7
Signed-off-by: Zhang Yunfei <zhangyunfei1@kylinos.cn>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 24b91be25676..86dedf5c1c09 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -4063,12 +4063,17 @@ static int idpf_vport_intr_req_irq(struct idpf_vport *vport,
 
 		name = kasprintf(GFP_KERNEL, "%s-%s-%s-%d", drv_name, if_name,
 				 vec_name, vector);
+		if (!name) {
+			err = -ENOMEM;
+			goto free_q_irqs;
+		}
 
 		err = request_irq(irq_num, idpf_vport_intr_clean_queues, 0,
 				  name, q_vector);
 		if (err) {
 			netdev_err(vport->netdev,
 				   "Request_irq failed, error: %d\n", err);
+			kfree(name);
 			goto free_q_irqs;
 		}
 
-- 
2.25.1

