Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59392110E;
	Wed,  5 Aug 2026 01:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785894718; cv=none; b=QxyW1alKtTe2F0k7CkzSB3VJbLRgY4JBQN51yACS1pzCjDtrwPOJxXz3o0ICZYgiyPOrrxDM36gRtglZmzIsFk+y+6ORr3SjyKgpfRVBvtsPR9YS6FDIha5H755gmDpRhda4ZpCjbuJGwCeAkJQR/gik10fkBDufPsD7ORo9cPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785894718; c=relaxed/simple;
	bh=gHiVNy9RsrJu8KEMKYnOTwduvWO3oLxdEvDDl3kf1ew=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LhN9s8/tEDgd/tnk9qFJ5wZX9DiRpNqBVPhpAzVrto75l87VU+xgY3hvJiJC/Rg6s+ZX2TrdWsjzydCyHcO6VOaNPijvAsWYdsQgpqrhtm2QKqxIo/Zu1No+5NcZ53LWU1fEw55CSV83TTLRqkqvmTj02zgC/U+PKyP4oprrmXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 3b682638907011f1aa26b74ffac11d73-20260805
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:1f692cfc-797b-4567-bb27-ce2c08d5066f,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:eefeb8e38f88419a6aa1c663a7fe148f,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3b682638907011f1aa26b74ffac11d73-20260805
X-User: xiongweimin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiongweimin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 781994736; Wed, 05 Aug 2026 09:51:53 +0800
From: Xiong Weimin <xiongweimin@kylinos.cn>
To: Zhu Lingshan <lingshan.zhu@kernel.org>
Cc: Michael S. Tsirkin <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Eugenio =?utf-8?q?P=C3=A9rez?= <eperezma@redhat.com>,
 virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
 Markus Elfring <Markus.Elfring@web.de>, stable@vger.kernel.org
Subject: [PATCH v2] vdpa: ifcvf: Put device on unsupported feature error
Date: Wed, 05 Aug 2026 09:51:52 +0800
Message-ID: <178589471294.1556376.4816776800128323034@kylinos.cn>
X-Mailer: git-send-email compatible Python smtplib
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Route unsupported provisioned features through the common error path after
vdpa_alloc_device() so the allocated device and adapter pointer are
released consistently.

Fixes: 46fc0917bbab ("vDPA/ifcvf: implement features provisioning")
Cc: stable@vger.kernel.org # v6.3+
Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
---
v2:
- Add Fixes and Cc: stable tags

 drivers/vdpa/ifcvf/ifcvf_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index ab6d6ab3b..2af1cec95 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -724,7 +724,8 @@ static int ifcvf_vdpa_dev_add(struct vdpa_mgmt_dev *mdev,=
 const char *name,
 		if (config->device_features & ~device_features) {
 			IFCVF_ERR(pdev, "The provisioned features 0x%llx are not supported by thi=
s device with features 0x%llx\n",
 				  config->device_features, device_features);
-			return -EINVAL;
+			ret =3D -EINVAL;
+			goto err;
 		}
 		device_features &=3D config->device_features;
 	}
--=20
2.43.0

