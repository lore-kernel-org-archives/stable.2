Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13A639CCE6;
	Wed,  5 Aug 2026 01:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785894720; cv=none; b=Jiuck62Ug7SkrGyWFMHetD5FaRBVi0DVZvbn16zFeAbg9zl9qfbKQyhMg9q1Lobdccb7wKIllMW5DOlK3HoCJqec0eNVOBz3V1xU6dJHy8fz0PYXvy00LQTiZFgLz/TQrz8RuUHaITFd4jAwnaxcgFsl14XzSTEv/IR+erb+dkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785894720; c=relaxed/simple;
	bh=xQwZt1dW57OnpZs1t80tkglKmClzHGk9IrDYcbwTxMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MUQjIqjne9Y7OZJa8vNSzZA3dq8YM6PNqd0r0eipynqlStomi9wYHptwz5Y3wS1AJjgH2tTyVo4Xut+M9LU5qH6zr8vhXhfVWq1Uk9giRpaOGiKVJeApu0vqpI+dV7Zy8SAvjgerK7eHTAqVwKBESA0/CLSklyqCsdflTPguUP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3b9c0598907011f1aa26b74ffac11d73-20260805
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:84385bbe-49b2-44cd-8475-8df0ec9c52be,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:c154534e334365aec05743fc3df83f4d,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:-
	3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,A
	V:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3b9c0598907011f1aa26b74ffac11d73-20260805
X-User: xiongweimin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 704129269; Wed, 05 Aug 2026 09:51:53 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc: Michael S. Tsirkin <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eugenio =?utf-8?q?P=C3=A9rez?= <eperezma@redhat.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 Markus Elfring <Markus.Elfring@web.de>, stable@vger.kernel.org
Subject: [PATCH v2] vdpa: solidrun: Free IRQs after request failure
Date: Wed, 05 Aug 2026 09:51:53 +0800
Message-ID: <178589471328.1556376.15570536900532373521@kylinos.cn>
X-Mailer: git-send-email compatible Python smtplib
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Unwind IRQs already requested by snet_request_irqs() before returning a
VQ IRQ request error so a later DRIVER_OK retry starts from a clean
state. The IRQs are requested and freed while the PCI device remains
bound, so the driver cannot wait for devres cleanup at detach time.

Fixes: 51a8f9d7f587 ("virtio: vdpa: new SolidNET DPU driver.")
Cc: stable@vger.kernel.org # v6.3+
Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
v2:
- Keep the config IRQ request failure as a direct return
- Free already requested IRQs only after a VQ IRQ request failure
- Add Fixes and Cc: stable tags

 drivers/vdpa/solidrun/snet_main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_m=
ain.c
index 28d55315d..3e2cea1e4 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -418,11 +418,15 @@ static int snet_request_irqs(struct pci_dev *pdev, stru=
ct snet *snet)
 				       snet->vqs[i]->irq_name, snet->vqs[i]);
 		if (ret) {
 			SNET_ERR(pdev, "Failed to request IRQ\n");
-			return ret;
+			goto err_free_irqs;
 		}
 		snet->vqs[i]->irq =3D irq;
 	}
 	return 0;
+
+err_free_irqs:
+	snet_free_irqs(snet);
+	return ret;
 }
=20
 static void snet_set_status(struct vdpa_device *vdev, u8 status)
--=20
2.43.0

