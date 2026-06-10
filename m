Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4049332EA2;
	Wed, 10 Jun 2026 03:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781060743; cv=none; b=IXRngsE07MZWbI26KGBMtk1K4F9VbIZ44NVBbcsU0zNCLR+vbCre87DmCXL3wVSZCpg3gRaitACVezNUuNa41XN56z7FtxALG4j4APW3SVFq7Lu2/c8+uRDbHRMoPOoHB/WBidl7AqGc0AeUSCvSX6M967L23SEWLorV40OVdjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781060743; c=relaxed/simple;
	bh=2X8rfCAb1oZIX7BnH6JOSP0HmSxgw85ABvwwB2akfCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SOe58rUhBo2nkkIHf9I6uV0RQGFvD5YqXnQvH1zZv4Fg6eoAve5/gTR5vTkBOl5ZM6Wt4Dbs9czZ6iXlX1fh4uN7W+Klj2pY3oEx8jqjvco/P9nKnFkrLij24I5zjvBrsi5MSrA6Fe77kN9jTc4kMlu/mPFTBHnLWd/9wT11Z9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=EgXPldLE; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="EgXPldLE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=y7
	FMWOQHFD1M1H1jdZsZDIeBnKDttX8LgdIEgVZkweM=; b=EgXPldLEjzyg8vWRG1
	t0xx9wVZ3RyjnxmWwtuud4goSw1hE558U+u+TAyjBLGCnKm0PPaKwcqd1qSrXRDN
	k8HRocOlnM/m4S3HsgJKH6KhHmHDS59D7jXTRQPQqSwUweI/Rk87ted9w/wH773E
	lRVq3VGUk+ZluVFegDBLioo1s=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDn7xlp1ChqZkUqCg--.33361S2;
	Wed, 10 Jun 2026 11:05:14 +0800 (CST)
From: Haoxiang Li <haoxiang_li2024@163.com>
To: brgl@kernel.org,
	andi.shyti@kernel.org,
	khilman@deeprootsystems.com,
	chaithrika@ti.com
Cc: linux-arm-kernel@lists.infradead.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Haoxiang Li <haoxiang_li2024@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] i2c: davinci: Unregister cpufreq notifier on probe failure
Date: Wed, 10 Jun 2026 11:05:13 +0800
Message-Id: <20260610030513.2651018-1-haoxiang_li2024@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDn7xlp1ChqZkUqCg--.33361S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Xw47Jr1DAw1xAryxAF18Xwb_yoW8JrW8pa
	17Ca95Cr10gF4qgw1UAr15uFyUW3yDC3y7CFyUG3WruFs8J34vq34YqFyYgFyrA3ykJw47
	Z3s8tw129F1UZF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi0D7fUUUUU=
X-CM-SenderInfo: xkdr5xpdqjszblsqjki6rwjhhfrp/xtbCxQvzYmoo1Gtq7AAA3k

davinci_i2c_probe() registers a cpufreq transition notifier before adding
the I2C adapter.  If i2c_add_numbered_adapter() fails, the probe error path
releases the device resources without unregistering the notifier.

Add a dedicated error path to unregister the cpufreq notifier after
i2c_add_numbered_adapter() fails.

Fixes: 82c0de11b734 ("i2c: davinci: Add cpufreq support")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
---
 drivers/i2c/busses/i2c-davinci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index a773ba082321..a24c3e8b87ff 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -818,12 +818,14 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 	adap->nr = pdev->id;
 	r = i2c_add_numbered_adapter(adap);
 	if (r)
-		goto err_unuse_clocks;
+		goto err_cpufreq;
 
 	pm_runtime_put_autosuspend(dev->dev);
 
 	return 0;
 
+err_cpufreq:
+	i2c_davinci_cpufreq_deregister(dev);
 err_unuse_clocks:
 	pm_runtime_dont_use_autosuspend(dev->dev);
 	pm_runtime_put_sync(dev->dev);
-- 
2.25.1

