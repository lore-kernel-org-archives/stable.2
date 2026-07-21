Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EC5430CDC
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 19:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663311; cv=none; b=apRQR/xRbn94t7J2c4PcZd+Phb4ZP7Di6u2xXYEPPKi9ccJMC3K+91pTvGmpTY0ibR0Pmn1ZYPMI1dvTVeUiPpa1RKCX/ScoqosTzLBa/OsFGMJ6CY+t989FyIWSWxYVztlHXxRNuU8beJfGofON20C9Qq7pxB8jiGGi2xbJ4Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663311; c=relaxed/simple;
	bh=bwdme1NE14B4S/VgKkVI8lA3G0P8KhhBLbpduVaclLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUuQtX1o0SZfM+zaC3LfzzKExdod2WTGDX5ghQ/xsAehyBh2eHTJhXS4ZzoS+8YGjaKsRQBJ/jnOfWhuNzmaj7rTKTxfQFywPftEtIUdEPiVRLAFF7CzEEneSruqQKgycyHltM2NOn4+UjH0N0e0tL/N7kCBfA9Fg3GdRDIWXTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIQEYtFB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIQEYtFB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C301F1F000E9;
	Tue, 21 Jul 2026 19:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784663310;
	bh=Grf6wlvasYDKfnXzcjuwKiX3UlvdPJvTF8ecOQ9o13A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WIQEYtFBwo+2u5Sv6E436/QyHiFyB1Uy/Xi+76nIpZIiVco5Kiw82w0sa3eEr8Xrz
	 OrkyD04x9Ymoh3f/BXsQx+2jHR1yZlL7LHQlAv/wMSPmqFLaMj/1q8bPKOC9xGKeS+
	 cPR2bn2Ms//xXeiwK3h5U+8U/D8h1exrVGrLdbG2IxGTF40KkOBZsiAfwJL9Y8g19i
	 4KrUcqgL6XnrYYnvadt8FDsTOO7arBZjvvNq7cMKmFbWufDTnWEXbSJR0ve5Ylyx/X
	 H7tf1GZib+giOjuHl8P224tIa3AM6C0Z29sElijh3bOMeERdRxsY5WSLcZ5siWm9L4
	 Rc1wISUGIXFFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] i2c: davinci: Unregister cpufreq notifier on probe failure
Date: Tue, 21 Jul 2026 15:48:28 -0400
Message-ID: <20260721194828.416617-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071619-glancing-hydrated-8528@gregkh>
References: <2026071619-glancing-hydrated-8528@gregkh>
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
index 02b3b1160fb062..359cb7732db120 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -866,13 +866,15 @@ static int davinci_i2c_probe(struct platform_device *pdev)
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

