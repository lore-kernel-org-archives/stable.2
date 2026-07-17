Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383F939CD1A;
	Fri, 17 Jul 2026 12:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784290903; cv=none; b=EvmtW3rj9OhqOKoLMRXzhD3EWVISvBcgnQyC6VI/wwuFnOWSRPoeLn5ybbC9wy5crBOioVQXASPnDAMoyoCMSFyyYwmi2e8bnwpzklcrebDo6IH26tOWPoH77jzNv1AaxAAsxEDgSNMorsJSATRj1YIr4qaRw1FYAYlTjyjYAvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784290903; c=relaxed/simple;
	bh=n4+VnSsAEXFD7jSSFyXe1WCzdpT4t0zXrONp/dMmdgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eNxiC2yD01hXiG8eASJzkdkEDlluyxv+Otp4qJSZ+LYWB0mwMHHy2pfls+piamLkWJ2bvuwMqeoIqMn0SLJ+0DATYGUH5MOjMN5jbfhIZTuSw9WDGaocN1UMYi+WlvZFitb3A1ZwqIpWo/v3nYksWbgdFeiHqQMslwKGZW7FYwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0baa18f681da11f1aa26b74ffac11d73-20260717
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:22accd45-aa8c-42bc-b5e0-a7071514faed,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:e7bac3a,CLOUDID:57d34d09c0b60c2a5a8e9cbc97fbf402,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0baa18f681da11f1aa26b74ffac11d73-20260717
X-User: pengcan@kylinos.cn
Received: from lenovo [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 705577519; Fri, 17 Jul 2026 20:21:32 +0800
From: Can Peng <pengcan@kylinos.cn>
To: srini@kernel.org,
	error27@gmail.com,
	ciprianmarian.costea@nxp.com,
	larisa.grigore@nxp.com,
	ghennadi.procopciuc@nxp.com
Cc: linux-kernel@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] nvmem: s32g-ocotp: add OF module alias for autoloading
Date: Fri, 17 Jul 2026 20:21:27 +0800
Message-ID: <20260717122127.370975-1-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The S32G OCOTP platform driver can be built as a module and uses
ocotp_of_match as its OF match table, but the table is not exported for
module alias generation.

Add the MODULE_DEVICE_TABLE(of, ...) entry so modpost can generate OF
module aliases for OF based module autoloading.

Fixes: 5a356145e968 ("nvmem: s32g-ocotp: Add driver for S32G OCOTP")
Cc: stable@vger.kernel.org
Suggested-by: srini@kernel.org
Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
Changes in v2:
- Add Cc stable tag.
- Link to v3: https://lore.kernel.org/all/20260715011047.177743-1-pengcan@kylinos.cn/
---
 drivers/nvmem/s32g-ocotp-nvmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvmem/s32g-ocotp-nvmem.c b/drivers/nvmem/s32g-ocotp-nvmem.c
index 119871ab3a94..0b57d1b36f29 100644
--- a/drivers/nvmem/s32g-ocotp-nvmem.c
+++ b/drivers/nvmem/s32g-ocotp-nvmem.c
@@ -60,6 +60,7 @@ static const struct of_device_id ocotp_of_match[] = {
 	{ .compatible = "nxp,s32g2-ocotp" },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, ocotp_of_match);
 
 static int s32g_ocotp_probe(struct platform_device *pdev)
 {
-- 
2.53.0

