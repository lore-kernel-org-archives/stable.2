Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA46B277818
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 02:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791166206; cv=none; b=XaOwGmNhT9HQWz2QEtmxVH37L+nGvwou9MCQ+ompreu99sQVDw4PFk34Tp75yowVG7kze/01XOP3FK4fosbaW1epYJy9r8Mp/OfGtDIlgj1ysAjmB45P3dSO1yjleOX41L8Y1Jj6Yjoyww4SQC/TZYZZq/gABGELNz/8QkQ8EG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791166206; c=relaxed/simple;
	bh=7lfT/55BV3tyPWrID3PJOTiEfbaU/Il64WbaoUwKstE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YivEg2y8ifUKWDhCbAVPTnL2c/3NexVzyll90+wELa86c+noxemX3+ZW/CAuH9vtkFdQeHff0CkY0HFFgyz7EQtvln5PvznPPki3/VYGbqaHsnhZv/OwLdKlAyX8RDaEZMXYmaUyXv2jch1KWm/5sPoREDhXbScAbk0qVm54wy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KleIurow; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KleIurow"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524951F000FF;
	Mon,  5 Oct 2026 02:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791166205;
	bh=aLzeC1M8HpWztifxQZz67vTkZCi9lRvN06sdiiCct3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KleIurowq01soDjNxyOHDCKtfg+XzeKmRA3ojQKXQUzq6ZKdowSN4TnNFsuDXdGj0
	 yYuZMHL171WZxFNESSulY31sb/QzZ4JE5pw4IwU0c6rpqNjJfUpJAVeK+oHyVgYjl8
	 eYMe7sfl4xexz5t2pMLNF/kTQeb+CtdgKWfloYat9kmZMUzDLblzmlxgyo64QnDSkp
	 3Z2Va0/3gTEWxevg1jbITExQa3Hk6uJjOpUmtGlWocxCzkikAZHH9ASYVWUr/ajndY
	 SOYg4qb65CkvFTe3yfTaxPG7XuJ0d5umf8PMD28/3EYYy6nPJKEEwWjc1x2EKHnY6T
	 ZpYkdrLDqia2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] wifi: wlcore: Fix runtime PM leak in wlcore_remove()
Date: Sun,  4 Oct 2026 22:09:58 -0400
Message-ID: <20261005020518.1103315-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005020518.1103315-1-sashal@kernel.org>
References: <2026100447-retainer-dude-dd4a@gregkh>
 <20261005020518.1103315-1-sashal@kernel.org>
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
index 28022749f5d6b..e4ac9c0a7bbb7 100644
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

