Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305CB476076
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 23:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784678330; cv=none; b=fGBCEvYG7fYW/wHLwJJA+9hpA+D5Fu1GnbREM8FgS4ZCTF/nCq4b0ZmkAf7rNsfv9B8wgmA7Ja7kk0rcQylhw77Py4lD+fgT9bCIYNW3YWasVaSINe0TK4qjOEUA2FdSZlEFLdVqRKiHewJt84sIH/QqMcOFMCgZh2gJmZEGfn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784678330; c=relaxed/simple;
	bh=VX63Wqb1IqRq+8tnS1ePPq6bW8SCh6uYdOwBpUU5LKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2lfrX5jbqUguWW6tegCxEVpti7x15IWZ6CuIi8LixOt2ZRUVpC+Bsek3J0dn1fqE9GE/GVzS+VCsl7kxMTwvfl1H9urfWMza98mXnyujoGY5urXSOiZqEUkBR+M7RcttY4hgqc/0RAl6Ik60VguIjAJz3RKryvL/jdS0fPG+y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WwRcC6MT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WwRcC6MT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA801F00A3A;
	Tue, 21 Jul 2026 23:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784678328;
	bh=+unELteHb9G+p6Ki+g4KL+UO81n26xaWr/TaRhOhbuU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WwRcC6MTrwk8gpl6TgiD2YvwGtahie4HZ6PhwpY1RnJu9BmsKbBQk36/7dnP7QWaD
	 xrzIG8lqapkDvlI6MogMp8cSOPiHgt/vPAWwOdZskYzGyqEkLFgdBdgQjzTxIQy7JR
	 N1oGSrv9Q/RFQ1hKVILZ++IfnWwkdF0akNrUSA8q3GOq8sg2gPDrEv84juB0uTJpMN
	 EZUhWff8Z6t3KjgG/uMnlNKF2/IjTWS+gcmmoU18cvf4tgOfrwpR8JPkc3lnt7ZNhh
	 I8nCqkvAkbLoQuONNXcCyELDBEticMtUvUPTV8BsgE9hsP9Nx+C8+wYVRW/10LBuaV
	 uokV2eiR5XKnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] i2c: davinci: Unregister cpufreq notifier on probe failure
Date: Tue, 21 Jul 2026 19:58:46 -0400
Message-ID: <20260721235846.523947-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071619-reunite-unleveled-9bad@gregkh>
References: <2026071619-reunite-unleveled-9bad@gregkh>
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
index c836cf8841850a..fa71e3b619d762 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -872,13 +872,15 @@ static int davinci_i2c_probe(struct platform_device *pdev)
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

