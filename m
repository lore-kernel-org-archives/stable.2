Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F874533592
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954465; cv=none; b=Xxqww281Q5CKdF9Uu2lFx4sZXDsUtyx7jyTxliGXWk8gWaz11gCIuCe0CZ0PmmyvywMVQyekelyESKFEzDKricB0Qjg1mrqShHtP76qIZWtQYsEhmbstTcg6141HeLXfWz6JGTjciusXRAbJvWHgO3xnb+tB+dQrwX3xnrTDwko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954465; c=relaxed/simple;
	bh=M0O5MaFcUzOzrsAPQZ/8L4dkuYu7pHljdfYk7A0E808=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MKfYQRXsWjX439fCfWZMEIq+Os5Km4W48utVxZ1aB/lqfW0GJepRA621ZDi8ozdHb+hMXoOQuMlvj6G4dEqhRECIVy5xqsNZhjZKNqNeefiXyeOpn51/21IGEG4ejLFmo1NNPFm6vn4ByQkTQdfX4Z9q98qxxCR0a0nl225oqxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATQ8TQqs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATQ8TQqs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D5551F00ADB;
	Wed,  9 Sep 2026 11:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788954464;
	bh=L81Byu3f4wtboztTOreL3uO3fRWgva9GAW3zLP6aHrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ATQ8TQqsOQmyZSiWj4IC3jG8HTvjjssywsF6pazuyWZhdOKMVeWdSBC4aDEF8OIoR
	 24XX0i8H15rn4IWiWxFFtlnxEEIlfFHz8IP1T03l6IBN+aqNHZ8PxzjEfCbVR4ejDw
	 3AyRkDif7LcGQTK0cm++GgBmqgpTW8vx6hEFfuODMTIV+euyIKHRTrEq0jneqX5q0k
	 R7MVfGlsF0j/sEdUI2VUX1FHUUwRVIK5ppiRl6tI336sSmc6E3i6N9L5v7KhviWIWn
	 e/Mc1pFaNfltdRkIYLEUCs6crKAJwWTxlDiJdLyF4LMTBkVNJbIaFDTzHp/LZ0ESD7
	 KqczZLRU4Zs6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pan Chuang <panchuang@vivo.com>,
	Linus Walleij <linusw@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] power: supply: ab8500_fg: Remove redundant dev_err()/dev_err_probe()
Date: Wed,  9 Sep 2026 07:47:40 -0400
Message-ID: <20260909114741.2012696-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090322-cradling-finance-beb1@gregkh>
References: <2026090322-cradling-finance-beb1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pan Chuang <panchuang@vivo.com>

[ Upstream commit aa5f4decedfb4fc5cd0fe49ab256ad4304d192e4 ]

The devm_request_threaded_irq() and devm_request_irq() now automatically
log detailed error messages on failure. This eliminates the need for
driver-specific dev_err() and dev_err_probe() calls that previously
printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Link: https://patch.msgid.link/20260709033428.362970-7-panchuang@vivo.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Stable-dep-of: 75b1e88d3425 ("power: supply: ab8500_fg: fix use-after-free on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/ab8500_fg.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 71ce28eed463f..bb4ad449391f0 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3185,8 +3185,6 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 				  ab8500_fg_irq[i].name, di);
 
 		if (ret != 0) {
-			dev_err(dev, "failed to request %s IRQ %d: %d\n",
-				ab8500_fg_irq[i].name, irq, ret);
 			destroy_workqueue(di->fg_wq);
 			return ret;
 		}
-- 
2.53.0

