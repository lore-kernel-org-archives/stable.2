Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429453;
	b=e268LlB1kxs1gMcj5/+4mE/hi9ov/9dSAHsnr4xQ8dlczgpqH+I7BhBX9KO7c6Iuz9hc
	 mhGOWPRvUD/bJMu6yxWnG8E1QusGBTf82XyYd21UCNxY0kkus1yfgA+kcMoB2rP1OdH/K
	 +bBBRM8BUDFhEJDS89LgyuKAEdZ2q6aqWPZ19HwXmO6l7FbpTPbpq57hXlou7lx/12Xbu
	 WGMMrz0WT4ZByl/0+Xi1fpdAeJ2X74A3P5ZMPhWVKP+iHq9CDwKbg66ZrUHAJUGUhslUT
	 /zbcdIMoEFz2d8VKoQyyuQxb69CnGpSJBSYkaIOBZ1Lo0b14chqdUmyev33pbvlWSQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429453;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=rps6TtDmHIcD10anjq8kEU746e79jCWLB0bftobjVh4=;
	b=bilQnoLwFIsFP5CZRzYob/SUWgFg1uoK+eDZLcG8WHqOseyBXF6lqVMMHXwHnfG/inRO
	 x5SmGRo6ZeRBe689l+FOd6bHzqh5CFlRhoV829acKDdg5ACbx4eOFKwy9kr+v727VZLR+
	 P/0xyj6rl/pDi376pB5vEhgeKAYKWn+wKSIVb4W1gdH+KMpJsY/YIos7w0h+Mx12uNDzb
	 Wsy84X5gudZq/mpG/pXaERyR4K7WCOikEkWyW9XtdBtebTsqezFAoSJViUH/adw7RODir
	 utE9nucBf4NMSi0GvZVEsNtqTHymKeEjcfuIgKaW1Xpu7P/qXYT1+We1vyGdQxpqEug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=e137jv80;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F8E606A32A;
	Mon, 23 Nov 2026 10:24:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36F8E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=e137jv80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=rp
	s6TtDmHIcD10anjq8kEU746e79jCWLB0bftobjVh4=; b=e137jv80IvmOYa/aRZ
	es6zKrRccgxszvPy7Na0qZcBo8TscQJ91gFkGAv7/zRF58YNPaDFrp+NiqSrw/Qt
	sV0ZnwjN3XNxU+FpzRFtHfyYHcjn6gGyruf1tN/jDsY6Ib9DlTNHStdAF9AUQijo
	CTVQGOEmberivpwqAJrvSVXiY=
Received: from user-VMware-Virtual-Platform.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wAH5xIaFARrfGJ_Jg--.63062S2;
	Mon, 23 Nov 2026 18:23:23 +0800 (CST)
From: Ziheng Wei <zihengw03@163.com>
To: Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Ratheesh Kannoth <rkannoth@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] octeontx2-pf: propagate ME IRQ registration failures
Date: Mon, 23 Nov 2026 18:23:22 +0800
Message-ID: <20261123102322.8620-1-zihengw03@163.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAH5xIaFARrfGJ_Jg--.63062S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrykXr1xCw15tw43tFW5KFg_yoW5Gr18pa
	yruasF9F18tF1fZr17Aa93AF15GF4DKry8C340kw4fAr45Jr4qvFWY9F4j9rn5KFWkWF1q
	qFW0yrWfC3WqyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jfDGOUUUUU=
X-CM-SenderInfo: p2lkv0ljzqjqqrwthudrp/xtbC7RvmN2sEFBvbtgAA3q

ME request_irq() failures are only logged. The next request overwrites
ret, so SR-IOV is enabled without its ME handler:

  request_irq(ME) fails -> ret overwritten -> SR-IOV reports success
                        -> ME events have no handler

Return ME errors like FLR errors and unwind all IRQs already registered
by the failing call.

Found by LLM-assisted static analysis. Build tested with allmodconfig;
no runtime fault-injection test.

Fixes: d424b6c02415 ("octeontx2-pf: Enable SRIOV and added VF mbox handling")
Cc: stable@vger.kernel.org
Signed-off-by: Ziheng Wei <zihengw03@163.com>
---
 .../net/ethernet/marvell/octeontx2/nic/otx2_pf.c   | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index cb602a4ad..9263be611 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -213,6 +213,7 @@ static int otx2_register_flr_me_intr(struct otx2_nic *pf, int numvfs)
 	if (ret) {
 		dev_err(pf->dev,
 			"RVUPF: IRQ registration failed for ME0\n");
+		return ret;
 	}
 
 	/* Register FLR interrupt handler */
@@ -224,7 +225,7 @@ static int otx2_register_flr_me_intr(struct otx2_nic *pf, int numvfs)
 	if (ret) {
 		dev_err(pf->dev,
 			"RVUPF: IRQ registration failed for FLR0\n");
-		return ret;
+		goto free_me0;
 	}
 
 	if (numvfs > 64) {
@@ -237,6 +238,7 @@ static int otx2_register_flr_me_intr(struct otx2_nic *pf, int numvfs)
 		if (ret) {
 			dev_err(pf->dev,
 				"RVUPF: IRQ registration failed for ME1\n");
+			goto free_flr0;
 		}
 		irq_name = &hw->irq_name[RVU_PF_INT_VEC_VFFLR1 * NAME_SIZE];
 		snprintf(irq_name, NAME_SIZE, "RVUPF%d_FLR1",
@@ -247,7 +249,7 @@ static int otx2_register_flr_me_intr(struct otx2_nic *pf, int numvfs)
 		if (ret) {
 			dev_err(pf->dev,
 				"RVUPF: IRQ registration failed for FLR1\n");
-			return ret;
+			goto free_me1;
 		}
 	}
 
@@ -271,6 +273,14 @@ static int otx2_register_flr_me_intr(struct otx2_nic *pf, int numvfs)
 			     INTR_MASK(numvfs));
 	}
 	return 0;
+
+free_me1:
+	free_irq(pci_irq_vector(pf->pdev, RVU_PF_INT_VEC_VFME1), pf);
+free_flr0:
+	free_irq(pci_irq_vector(pf->pdev, RVU_PF_INT_VEC_VFFLR0), pf);
+free_me0:
+	free_irq(pci_irq_vector(pf->pdev, RVU_PF_INT_VEC_VFME0), pf);
+	return ret;
 }
 
 static int otx2_pf_flr_init(struct otx2_nic *pf, int num_vfs)

base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
-- 
2.43.0

