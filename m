Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E683101C8
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 06:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182454; cv=none; b=RcUgYT7ksBaBb7Gul9BU/Jr8puFcvG5LpJI+Y2eGL2cmxsJw+ZCOLGe7HKH9GbzbVrAk2LYSMLZxM3R7q6Vlor8TP2quKHlfBeXbQq7FyevLWEyBpWUPrwCnTYmhQz91wSfrzWVMw2LcodMFPNc8qLvPdhRl/yUrwlMy76UAF5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182454; c=relaxed/simple;
	bh=bQUz3yTBuVNqdSjgZI11JQ94/W8sIK4FqNX3d0iUlnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDqsAM2e/RU61zx536sj1dzqEYNMIztr/hXSmjPZiKXZcEACg4tlhGElgksUvWvQkxw92bkV3XZiwFJiFLhwRaI8Pl4hzoQEiMEQSrGrxztQ4sJDqmgDSIvHgVwu4UepLuBTfkfxcfTsUIv/Gw1r73QVeNTm0TFdDhliheb/R2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XeB5+d2Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XeB5+d2Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C891F000FF;
	Mon,  5 Oct 2026 06:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791182453;
	bh=53Fe9PY81WjYgk70Pdq1EcGINqocZR6t9YuTmngRNyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XeB5+d2YN7yNBZ60mIqQGU21Zp8oEdAGcnIX9zzLbbSUstPyOUsjuGDpx+R/cXe+I
	 kEl3zhbllt6T/UUDSmo8phi/pS2Nm8hmXd4x4ASDk0m20fv88TbsHxUFmBJtwa9viZ
	 MKGy25oZWGU5Cnt1fkOD9mZwDtEs7Q/6307rpIjWnNWIkZj3rmLs2K/ALiufT4G0Hx
	 Vf7lyMCY0gCkc7BHNIXP6xQr/QmTDVyhWALvpD32zyKSEWec8WRj1UTrJCsXdpmzVU
	 FtSLsCSmUi/xnBKHZasLnAHRTfUtnctoi8GTNSRhkF8hvz/sab0xxAwkWL9Jm9ovKE
	 EzHFGLJpQkp/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] wifi: wlcore: Fix runtime PM leak in wlcore_remove()
Date: Mon,  5 Oct 2026 02:40:46 -0400
Message-ID: <20261005062850.1329066-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005062850.1329066-1-sashal@kernel.org>
References: <2026100447-glade-qualifier-5a63@gregkh>
 <20261005062850.1329066-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit a8b8881d0c1aff544fae190469d86db7b07f43a9 ]

pm_runtime_get_sync() keeps the runtime PM usage counter elevated even
when it returns an error, so the reference taken at the beginning of
wlcore_remove() has to be dropped on every exit path. When the device
was not initialized the function returned early without doing so,
leaking the reference.

Release it with pm_runtime_put_noidle() as done on the other early error
paths of this driver.

Fixes: fa2648a34e73f ("wlcore: Add support for runtime PM")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260917122325.2150910-1-vulab@iscas.ac.cn
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ti/wlcore/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index eb8b75252c36f..73a694ecc7db8 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -6817,8 +6817,10 @@ void wlcore_remove(struct platform_device *pdev)
 
 	if (pdev_data->family && pdev_data->family->nvs_name)
 		wait_for_completion(&wl->nvs_loading_complete);
-	if (!wl->initialized)
+	if (!wl->initialized) {
+		pm_runtime_put_noidle(wl->dev);
 		return;
+	}
 
 	if (wl->wakeirq >= 0) {
 		dev_pm_clear_wake_irq(wl->dev);
-- 
2.53.0

