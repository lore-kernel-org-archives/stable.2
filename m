Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37108449B1C
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 19:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662567; cv=none; b=p5g/s4oXYIJrtesvTpQHR+Fe6iOQr7JFzK4MkZUmRwJVcrXcOfeNHLPKOpbcHjCop+YfDSLw1MSfBymK/OQJgG4ax0itC7ua8Rt5O3WWTpwZWYfntf7wxzmyQE9EqGjvsDqb51ZEF1tQPb3+E398dcxO7jPLhOBMclTHo0AlrJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662567; c=relaxed/simple;
	bh=jKcp+CTMJABN9Gegbva1e66PHc9ckpSltWsluzTOQiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzSzWoslUIQb3rKJvebaejXkPY1W0FOFAHaVFn+Ef3RZQSsQAxTY9WZU93SnTHPysLOvQX2yKXQYd1K2WfsoVUSRg3/v4r0D29fiszUi/Cqerq9k+p52la2oY1apONczXjenSlF4r27P9gu3ffkXH1EFOWptki5vsq9Qzs3gaDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=goISuFlD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="goISuFlD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D02E1F00A3F;
	Tue, 21 Jul 2026 19:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784662566;
	bh=0AXdTUFQ774D7tizwlqn2QPU8rqkGk04ZHU2hjzHxNA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=goISuFlDv0yqEODycy5huYk765GOdyx6C2JCTni6TFGKQecXFhU9TaaoGlo6Qgkyv
	 At6Zw0pjE1qmLQW694UXDefI5HDj9R+iBWJ+H+x85sVVhJHLUW5T4xDoduJS7gmoqa
	 ywWp7QsnKm0667GhWC6Nogen7CGrZw+zPUA8jvWKht38kBdQLzyamwNG2YYNzrD+yk
	 0a9Bnfg4HXkKclvwc9kgTFXsD92BLw9gmrZJxGle7TcTXlyd8VIbHwrh+fD1vX+Otx
	 dzwuE7Dokawt3NPgZlvFCsj8Qv+oWN+3+YzSvyq2krSqWpsb4Ltg1ezDDJe4a66iSB
	 pTqH2chWUawNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] i2c: davinci: Unregister cpufreq notifier on probe failure
Date: Tue, 21 Jul 2026 15:36:03 -0400
Message-ID: <20260721193603.410310-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071619-till-joyous-84a7@gregkh>
References: <2026071619-till-joyous-84a7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoxiang Li <haoxiang_li2024@163.com>

[ Upstream commit e43f32816a1b1fe5a86279411626fe3a9be56d45 ]

davinci_i2c_probe() registers a cpufreq transition notifier before adding
the I2C adapter.  If i2c_add_numbered_adapter() fails, the probe error path
releases the device resources without unregistering the notifier.

Add a dedicated error path to unregister the cpufreq notifier after
i2c_add_numbered_adapter() fails.

Fixes: 82c0de11b734 ("i2c: davinci: Add cpufreq support")
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Cc: <stable@vger.kernel.org> # v2.6.36+
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/20260610030513.2651018-1-haoxiang_li2024@163.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-davinci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index c4fb5e9ab50611..fa51f6843932b9 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -864,13 +864,15 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	adap->nr = pdev->id;
 	r = i2c_add_numbered_adapter(adap);
 	if (r)
-		goto err_unuse_clocks;
+		goto err_cpufreq;
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
 
 	return 0;
 
+err_cpufreq:
+	i2c_davinci_cpufreq_deregister(dev);
 err_unuse_clocks:
 	pm_runtime_dont_use_autosuspend(dev->dev);
 	pm_runtime_put_sync(dev->dev);
-- 
2.53.0

