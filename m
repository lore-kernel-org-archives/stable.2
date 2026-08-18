Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254D3453A22;
	Tue, 18 Aug 2026 10:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049852; cv=none; b=Nr61BbXRRS/6vU4dE5QA5JG/69qybYAtmDZPdzlYF7GRAHzI+W5MXlOxmN6nYhuIjvh7l4UlSNbdyYeIPr6efEDiG6rukSSO4w4nHrphdCVmL+TlgbS4/nhEtMUBA+eG9cC4E5BlEw1QHTO2ICXJyU2BAq2d6yVNPz/f+4LS5BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049852; c=relaxed/simple;
	bh=dVGF+ZS6XSO4lCuX8vS3zZQ+tdoVgMfWiYwdNhdenbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9AMjRC+feaZzsbyKStz0OAhDgYXFzhdvEJofkJ1qo5LfEeZIYUHF//aEwA1rxU+Aq8Bum84y9VitD0uIHVFQHLCKnGbnL9YmgVQO75iP7ZU+BLeyvSf/O+LakAJS45UaAeGhW+qMztGTJ7e1NofM5KeceqHrlSdYlm3eQ79r+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=nIJI5JaU; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="nIJI5JaU"
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:fa2:0:640:41ee:0])
	by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 6089680C76;
	Tue, 18 Aug 2026 13:44:06 +0300 (MSK)
Received: from i111667286.ld.yandex.ru (unknown [2a02:6bf:8080:c4e::1:16])
	by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp) with ESMTPSA id NhSZiF9aJa60-4rRfuRd6;
	Tue, 18 Aug 2026 13:44:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1787049845;
	bh=7YHeaGtfFB57Boz98X24i52ucfO9TNpH/XKFlY+nlbc=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=nIJI5JaUGYWUGu4b7eUsCGPYS5YkjIs8HMH1xRTwx72c8GvolsMpnW51zcWAc9zIs
	 FaGioWaQId7U5L3yHwqPxVJUIw6gZ25W04/LQpqS35JDtSl2srmoc8sEkIH31be2er
	 BX5Yw2ZVK/lYWgll0W9l7ZZYHVelS/ZQWOGiiIQM=
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
Subject: [PATCH 5.15 2/2] media: mediatek: vcodec: Fix a resource leak related to the scp device in FW initialization
Date: Tue, 18 Aug 2026 13:43:24 +0300
Message-ID: <20260818104324.2033-2-drtrosh@yandex-team.ru>
X-Mailer: git-send-email 2.51.0.windows.2
In-Reply-To: <20260818104324.2033-1-drtrosh@yandex-team.ru>
References: <20260818104324.2033-1-drtrosh@yandex-team.ru>
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
index 27f08b1d34d1..199a64c853bc 100644
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

