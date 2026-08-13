Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8E43630A0;
	Thu, 13 Aug 2026 08:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786608629; cv=none; b=E41g0hr+evHAjKe73IDgKO882ETN7GuvIUOeyb1l9fv/TvJ/O7suyr/25h4ReetYo6XKZTJrzizg2quBtdgqz6wu1UiIk08t70yLzLprfKvbmQxdw6GaTFdRg9c4jYEj9oHTSbQmhvF97BOBUx6yfaNu9GmYoyMyDUlwJsF5+1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786608629; c=relaxed/simple;
	bh=dnEup+Kc6+pT9TcV2xwC+VnvGp8HIr4CMIrF+XXiEfU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ppnEx8JP+gWS1l1vu0pFPY38/rdeyqb5xuWpsXB81NAZ589IKqy5zvI7K0VWl1LysBw8taKbD4zhg8niMoBBPJkdF+qU9OBRSZtM0Ccz9rCpZJmGvPG6mVRHoHRCRklXAGwX9PfYfn+G7Yi0Lqjea1/7AAMxf9M8kFMhCQIU2ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 6cd5abf896ee11f1aa26b74ffac11d73-20260813
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:39354584-532e-4e7a-86e8-18d543b610ba,IP:0,U
	RL:5,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:e03f14b9a3e5196c8f329a50f697268d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:93|82|11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 6cd5abf896ee11f1aa26b74ffac11d73-20260813
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 237327502; Thu, 13 Aug 2026 16:10:19 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: maddy@linux.ibm.com
Cc: mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	nayna@linux.ibm.com,
	gcwilson@linux.ibm.com,
	kees@kernel.org,
	ruscur@russell.cc,
	jjalvare@linux.vnet.ibm.com,
	bryantly@linux.vnet.ibm.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH] powerpc/pseries/pci: Prevent double free of VF PE map
Date: Thu, 13 Aug 2026 16:10:13 +0800
Message-Id: <20260813081013.549622-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On failure of pcibios_sriov_enable(), drivers/pci/iov.c calls
pcibios_sriov_disable() unconditionally. pseries frees
pdn->pe_num_map without NULLing it, both on the error path of
pseries_pci_sriov_enable() and in pseries_pcibios_sriov_disable(),
so the dangling pointer is freed again when the core cleans up.
Set pdn->pe_num_map to NULL after kfree() in both places.

Fixes: 9a7f6b438664 ("powerpc/pseries/pci: Associate PEs to VFs in configure SR-IOV")
Cc: stable@vger.kernel.org
Reported-by: sashiko-bot@kernel.org
Link: https://sashiko.dev/#/patchset/20260813035323.245229-1-yijiangshan%40kylinos.cn
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 arch/powerpc/platforms/pseries/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index 6fc13f4a79a3..13d0baea5786 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -154,6 +154,7 @@ static int pseries_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 	if (rc) {
 		dev_err(&pdev->dev, "Failure to enable sriov: %x\n", rc);
 		kfree(pdn->pe_num_map);
+		pdn->pe_num_map = NULL;
 	} else {
 		pci_vf_drivers_autoprobe(pdev, false);
 	}
@@ -175,6 +176,7 @@ static int pseries_pcibios_sriov_disable(struct pci_dev *pdev)
 	pdn = pci_get_pdn(pdev);
 	/* Releasing pe_num_map */
 	kfree(pdn->pe_num_map);
+	pdn->pe_num_map = NULL;
 	/* Release PCI data */
 	remove_sriov_vf_pdns(pdev);
 	pci_vf_drivers_autoprobe(pdev, true);
-- 
2.25.1

