Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0449E4477E3;
	Tue, 18 Aug 2026 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045339; cv=none; b=T+hxszPcqK+LsF7Vj2yIR7C7FPyZGjceJ0pppByiesKB98I/izyRpbhOLZ/Yaw/ycAsBNJqT+s6vaJO7pWM2L39IrrNgCOspxjXeXz/YD2kS7dkb97t9DZJoqN2VkLfXFF/KYV1PqoNTF4EJy7ajMqnfxLgCNszQxBsMjtOzdDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045339; c=relaxed/simple;
	bh=yGKWtTtB8qCetm6PKKsEdSMFOGYN4pgH1pq58IzI2yE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q+F8hU62ilx8B/jGJhp8KjiQCE57lKbVp/gsOxCYbUx7mUMXSGUa3ag8sSfi9NKXAcVXea5RN0/eNCFLF588JpIcxF5l8YOmE7VnVBGV0mxltHqgLk7IJmgegtDoaZIsp5nP9SUo8u3oHYh+EtyWjn/OvJU6OxcVt79mqypLsrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=EnE3qhYb; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="EnE3qhYb"
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
	by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id C888F808A9;
	Tue, 18 Aug 2026 12:28:46 +0300 (MSK)
Received: from i111667286.ld.yandex.ru (unknown [2a02:6bf:8080:51e::1:6])
	by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA id fSRm579aVa60-byn6Zwkx;
	Tue, 18 Aug 2026 12:28:46 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1787045326;
	bh=7IH1QIAY53h9U4U7xIyaF8f7jTuqENrkvRN3BnBc67s=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=EnE3qhYbtgq2rgnNXni3QJJvvf1cxw6YUSBHJr1ZmOQhpdm7RwPUPAnZjkZRYAsRf
	 FU4JsIxZu76t636TyXM7stOTZP7khjZXIg1N7HDVwbv+emp7cHFfgO1gifmksC3xgQ
	 a05rowDVJt+Xl/1dTbO/Odb4lgOOBz+3v6Pe4H8A=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Andrey Troshin <drtrosh@yandex-team.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrey Troshin <drtrosh@yandex-team.ru>,
	Sasha Levin <sashal@kernel.org>,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-media@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10 2/2] media: mediatek: vcodec: Fix a resource leak related to the scp device in FW initialization
Date: Tue, 18 Aug 2026 12:28:41 +0300
Message-ID: <20260818092842.1975-2-drtrosh@yandex-team.ru>
X-Mailer: git-send-email 2.51.0.windows.2
In-Reply-To: <20260818092842.1975-1-drtrosh@yandex-team.ru>
References: <20260818092842.1975-1-drtrosh@yandex-team.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiasheng Jiang <jiashengjiangcool@gmail.com>

[ Upstream commit 4936cd5817af35d23e4d283f48fa59a18ef481e4 ]

On Mediatek devices with a system companion processor (SCP) the mtk_scp
structure has to be removed explicitly to avoid a resource leak.
Free the structure in case the allocation of the firmware structure fails
during the firmware initialization.

Fixes: 53dbe0850444 ("media: mtk-vcodec: potential null pointer deference in SCP")
Cc: stable@vger.kernel.org
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
[Andrey Troshin: backport fixs from
 drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c 
 to drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c]
Signed-off-by: Andrey Troshin <drtrosh@yandex-team.ru>
---
Backport fix for CVE-2025-23160
Link: https://nvd.nist.gov/vuln/detail/CVE-2025-23160
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c
index 27f08b1d34d1..eacea997eae0 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c
@@ -65,8 +65,11 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(struct mtk_vcodec_dev *dev)
 	}
 
 	fw = devm_kzalloc(&dev->plat_dev->dev, sizeof(*fw), GFP_KERNEL);
-	if (!fw)
+	if (!fw) {
+		scp_put(scp);
 		return ERR_PTR(-ENOMEM);
+	}
+
 	fw->type = SCP;
 	fw->ops = &mtk_vcodec_rproc_msg;
 	fw->scp = scp;
-- 
2.34.1

