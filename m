Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CBE3033E9;
	Sat, 18 Jul 2026 06:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784355589; cv=none; b=L1w+uHH+H9QPqeP5h+lJPk7mOb2gX2Ysnz08f2LjXSXjbuVY2GgVY0L7vdaLU58l4rICa3k+I7kqBV6/X6qYN83ij1XrQHJ5Wdn8vSwoiGelBhnQrUGFoNLhGopkAjWVetGtvjZrlvR3/Ps/C8DGLhK9lwublhjGgbvR6RQwpTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784355589; c=relaxed/simple;
	bh=FoGCFCvwyGZW9MzyAyxb5vILM2PseAQAD2D6SMY43oo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ck0zHST/I8ruNYWF22EfiF9YGGb0YYA8ulZJeS39HngF2eoX30jVQHe0pIUvj/gHnce8K4sST12jPCa2Dc8MtqPxoLLqhcqSH14NpOP9sdMsJZLN6egJPQGqTuA3ICybwNuv/UxSJ3CS4dO7ZHiurMSum0pvnDtOisdNRoYGIn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a54440ae827011f1aa26b74ffac11d73-20260718
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:aa229de1-5b93-4bf7-a093-92fe2663594a,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:aa229de1-5b93-4bf7-a093-92fe2663594a,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:2e8df5f657f352ce2f4664dca231ff15,BulkI
	D:26071814193738HHCTBC,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|136
	|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:nil,Bulk:ni
	l,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE
	:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a54440ae827011f1aa26b74ffac11d73-20260718
X-User: pengcan@kylinos.cn
Received: from lenovo [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 970417700; Sat, 18 Jul 2026 14:19:34 +0800
From: Can Peng <pengcan@kylinos.cn>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	rajat.khandelwal@linux.intel.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] iio: pressure: mpl115: Fix runtime PM cleanup on probe failure
Date: Sat, 18 Jul 2026 14:19:09 +0800
Message-ID: <20260718061909.428476-1-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mpl115_probe() enables runtime PM when a shutdown GPIO is present and
then returns the result of devm_iio_device_register(). If registration
fails, runtime PM remains enabled and autosuspend remains selected.

The same unmanaged runtime PM state is also left behind on driver
unbind, as the IIO device registration is managed but the runtime PM
setup is not.

Use devm_pm_runtime_enable() so runtime PM is disabled automatically
on probe failure and driver unbind. Also unwind the initial
pm_runtime_get_noresume() reference if setting up runtime PM fails
before the matching put.

Fixes: 0c3a333524a3 ("iio: pressure: mpl115: Implementing low power mode by shutdown gpio")
Cc: stable@vger.kernel.org
Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
 drivers/iio/pressure/mpl115.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
index 16e112b796ba..9e77b76bd1fa 100644
--- a/drivers/iio/pressure/mpl115.c
+++ b/drivers/iio/pressure/mpl115.c
@@ -204,8 +204,17 @@ int mpl115_probe(struct device *dev, const char *name,
 	if (data->shutdown) {
 		/* Enable runtime PM */
 		pm_runtime_get_noresume(dev);
-		pm_runtime_set_active(dev);
-		pm_runtime_enable(dev);
+		ret = pm_runtime_set_active(dev);
+		if (ret) {
+			pm_runtime_put_noidle(dev);
+			return ret;
+		}
+
+		ret = devm_pm_runtime_enable(dev);
+		if (ret) {
+			pm_runtime_put_noidle(dev);
+			return ret;
+		}
 
 		/*
 		 * As the device takes 3 ms to come up with a fresh
-- 
2.53.0

