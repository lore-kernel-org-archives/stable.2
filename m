Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE717EEC0;
	Mon, 20 Jul 2026 02:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784515426; cv=none; b=WLu+aZDa9STum32iUDGZsTXd85Q7065BuA1MtHNUW/QdK18nJ+d1csR8RfPzRE5uVAroPha+93LHMqQJg66dFRuEjLYuqjfF3edA7R0M4MTN7W8LMxE95vnuA8LiwDQ/AN/kOWos1Wbs377emJL4BDVIGd6/Wi47sQVsqe1w3D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784515426; c=relaxed/simple;
	bh=JJsMLVgRSyYjliyQp5DQUKo30Ta2dKKx+588j/SipgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d4yhg/hO8kCRkBtyMIYJtvEhN4L+rR3YycLfTrr5NXAALsk5hnGVO7au7OJ+NgTLCkcp9hSxyLRMZL+SMkQHxjtuTZhV8TyBd0+F5Zbqvrv4Z8I2Ci4r4NGR04bFpJmunwwZlium/Svzat344NuA8ZYEBvJopMOeAqxppfiGk7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cf74bfc883e411f1aa26b74ffac11d73-20260720
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
X-CID-O-INFO: VERSION:1.3.12,REQID:96632555-3f73-487f-b06f-f8075fcf91b0,IP:15,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:15
X-CID-INFO: VERSION:1.3.12,REQID:96632555-3f73-487f-b06f-f8075fcf91b0,IP:15,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:15
X-CID-META: VersionHash:e7bac3a,CLOUDID:e7f483f8c67471445c725d1721675d65,BulkI
	D:260720104338WNCU67J1,BulkQuantity:0,Recheck:0,SF:10|38|66|78|102|127|865
	|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cf74bfc883e411f1aa26b74ffac11d73-20260720
X-User: pengcan@kylinos.cn
Received: from lenovo [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1255639351; Mon, 20 Jul 2026 10:43:38 +0800
From: Can Peng <pengcan@kylinos.cn>
To: jic23@kernel.org,
	jonathan.cameron@oss.qualcomm.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] iio: pressure: mpl115: Fix runtime PM cleanup
Date: Mon, 20 Jul 2026 10:43:12 +0800
Message-ID: <20260720024312.27037-1-pengcan@kylinos.cn>
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

Use devm_pm_runtime_enable() so runtime PM is disabled automatically on
probe failure and driver unbind, and check pm_runtime_set_active() so
setup errors are reported.

Set the autosuspend parameters before enabling runtime PM. Once probe
has completed, the driver core queues an idle request for the device, so
an explicit pm_runtime_get_noresume()/pm_runtime_put() pair is not
needed to start autosuspend.

Fixes: 0c3a333524a3 ("iio: pressure: mpl115: Implementing low power mode by shutdown gpio")
Cc: stable@vger.kernel.org
Suggested-by: jonathan.cameron@oss.qualcomm.com
Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
Changes in v2:
- Drop the explicit pm_runtime_get_noresume()/pm_runtime_put() pair and
  rely on the driver core idle request after probe.
- Set autosuspend parameters before enabling runtime PM.
- Update the commit message accordingly.
- Link to v1: https://lore.kernel.org/all/20260718061909.428476-1-pengcan@kylinos.cn/

 drivers/iio/pressure/mpl115.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
index 16e112b796ba..2929ea8e4e01 100644
--- a/drivers/iio/pressure/mpl115.c
+++ b/drivers/iio/pressure/mpl115.c
@@ -203,9 +203,9 @@ int mpl115_probe(struct device *dev, const char *name,
 
 	if (data->shutdown) {
 		/* Enable runtime PM */
-		pm_runtime_get_noresume(dev);
-		pm_runtime_set_active(dev);
-		pm_runtime_enable(dev);
+		ret = pm_runtime_set_active(dev);
+		if (ret)
+			return ret;
 
 		/*
 		 * As the device takes 3 ms to come up with a fresh
@@ -215,7 +215,10 @@ int mpl115_probe(struct device *dev, const char *name,
 		 */
 		pm_runtime_set_autosuspend_delay(dev, 2000);
 		pm_runtime_use_autosuspend(dev);
-		pm_runtime_put(dev);
+
+		ret = devm_pm_runtime_enable(dev);
+		if (ret)
+			return ret;
 
 		dev_dbg(dev, "low-power mode enabled");
 	} else
-- 
2.53.0
