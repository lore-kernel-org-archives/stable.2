Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5C333D6F8
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791134162; cv=none; b=aoI33mt8M5dfCh2+f4Jt4nHkQRFmEQ+bQPim+TrTvR08Z1bzkhosIAR0P96yzNzN8K7ff6wpMFqFKzBzzYwClpS6Behnj/RuPuFS6m8Zl5xwPH37pcQGpU5VG1Qq1+bT9xK1EONgVdbziHgB3SWUvj6g7prUEetcRoZ35J38fpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791134162; c=relaxed/simple;
	bh=RGYWIbgJ8PHYz+oHewxe8E7kL9IU9+dZSkPj5DTgVos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwDvAu8P2dFAhIEpCu8lqZMnC0jKWyPiCGkw3Zgt7eqFbL9dmxOjClVhX6j/J4KkTjsYEJJJpVXrwHlU07TPha7Mb7i1N8B3/PU7dfiACarNF4Z0lcCzPidaBkmh7o/DyOZNrrDqLV3pmI7E28EBGPO2buddwG89dDErfPY+N7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoTWsAm1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoTWsAm1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618F61F000FF;
	Sun,  4 Oct 2026 17:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791134160;
	bh=Okj//XznIMDyKEGvTEsN1pOVlTZBbb0PN1CwLKPUqww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eoTWsAm1LifkKefgvcfPN4u9VmJK2Pyu4T4yIWiRbimf6usgrZIaTl0cdVH6XIWwG
	 VMK3TQhoYSucNe5dI9Z2oWuFldrrbcCbx8MeXgKlkJ9TeEszB5+CbGdwEdtjqM/oTY
	 +mN+2rt7ecUNRQg79Xm4/rIqevXiep232BJJDacGABYs65Z3j81GX9Wv9YN35t+tY1
	 NKwE+uK3wlyE9HHVW8sWCILulrdVSKFGnfxcqCo67FlgXQsI17W77I/jJERRbiw5UW
	 J5Z9Uk3MPAgrMkkWmxwUUz4/NVVRVdwYYcbA4QGunGxnr5SfWrxzEqFu6IXAKqWHRV
	 V9dyRN6c48TVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] wifi: wlcore: Fix runtime PM leak in wlcore_remove()
Date: Sun,  4 Oct 2026 13:15:55 -0400
Message-ID: <20261004171541.901037-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004171541.901037-1-sashal@kernel.org>
References: <2026100446-quaintly-establish-1f37@gregkh>
 <20261004171541.901037-1-sashal@kernel.org>
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
index 535b47e54d6ab..45563dd3d212d 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -6749,8 +6749,10 @@ void wlcore_remove(struct platform_device *pdev)
 
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

