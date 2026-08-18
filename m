Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0437E3C10B0;
	Tue, 18 Aug 2026 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787045339; cv=none; b=kW/dxbZ/LX+8VXPfrvpFsksknZeuQWqrIWb3Fi3jJ+nmmXm5cg90C8WbMTBSb6YMbVd3Lca2WwUCsLSwtAPeg8nA4KfAp8tPP6UqIuBOCLgdWA2BY3I46ISt06rGrnXl87M8ARGoEZz7u/Q79JHw/rpTKnTgbaqjz83AWn6U/MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787045339; c=relaxed/simple;
	bh=qSDbSBGYDH07oPwBa+Rp+nBO3HAO/2alQKi/kD/jmxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=imSxM6I9Bk3PAk2jzhNZOdMQWXOXBFE0OHsQundDz+4R6ABEb5ZnPke+RBkAsh/a0OsQgBldr1I6uYxupqe5k3lkIO8JrX8w6NpSRmmHa0ePyH8/wM/uD86gfJRdC1cFK7VCPPClPYejBqYsuPRiw8at1CPmAVADk+t2q1zLuzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=plU/4h+b; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="plU/4h+b"
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
	by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 856AD8085B;
	Tue, 18 Aug 2026 12:28:45 +0300 (MSK)
Received: from i111667286.ld.yandex.ru (unknown [2a02:6bf:8080:51e::1:6])
	by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA id fSRm579aVa60-kPdJBykV;
	Tue, 18 Aug 2026 12:28:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1787045325;
	bh=733PnIbHO+Ohzr6RPQsMlbQJ91Cy5grRI728PGy9aeM=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=plU/4h+bzSlho4oiD8IHRx4LValFVcIx6rHM+y7FF5OeVCrTGT8/Zt0bV8yaiVBZp
	 c5ikFWt89S618rt3+t7W9/fe3okyUpwGO7OOF+gw2nptokfqGVDlR9m1ZSFsb9PbC5
	 iGeBeoOgnKRJAsnD+39fVozuStFm6nWMyM5/Ly4w=
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
Subject: [PATCH 5.10 1/2] media: mtk-vcodec: potential null pointer deference in SCP
Date: Tue, 18 Aug 2026 12:28:40 +0300
Message-ID: <20260818092842.1975-1-drtrosh@yandex-team.ru>
X-Mailer: git-send-email 2.51.0.windows.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fullway Wang <fullwaywang@outlook.com>

[ Upstream commit 53dbe08504442dc7ba4865c09b3bbf5fe849681b ]

The return value of devm_kzalloc() needs to be checked to avoid
NULL pointer deference. This is similar to CVE-2022-3113.

Link: https://lore.kernel.org/linux-media/PH7PR20MB5925094DAE3FD750C7E39E01BF712@PH7PR20MB5925.namprd20.prod.outlook.com
Signed-off-by: Fullway Wang <fullwaywang@outlook.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
[Andrey Troshin: backport fixs from
 drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c 
 to drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c]
Signed-off-by: Andrey Troshin <drtrosh@yandex-team.ru>
---
Backport fix for CVE-2024-40973
Link: https://nvd.nist.gov/vuln/detail/CVE-2024-40973
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c
index d8e66b645bd8..27f08b1d34d1 100644
--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_fw_scp.c
@@ -65,6 +65,8 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_scp_init(struct mtk_vcodec_dev *dev)
 	}
 
 	fw = devm_kzalloc(&dev->plat_dev->dev, sizeof(*fw), GFP_KERNEL);
+	if (!fw)
+		return ERR_PTR(-ENOMEM);
 	fw->type = SCP;
 	fw->ops = &mtk_vcodec_rproc_msg;
 	fw->scp = scp;
-- 
2.34.1

