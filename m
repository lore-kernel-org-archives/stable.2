Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93C83ACA60
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 12:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044795; cv=none; b=DLwRMKPCbWZs49zF9u9rMjld3HooaVr2QD0le09W3SWY+yDPObz6G5d0/dzi5SNLjvVbW/HQZAmqA2oDd356Pwd75SPu9UBlzlb8psAXcAYjqQzlxGpAuvsxOZkrrKvxvD7BjWZuSf4fluybD2Bs+nwlUQKRnhiw+QWTPOLD1/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044795; c=relaxed/simple;
	bh=JOVfX3XzxzebAnKH9muvyOVn1KxKcE4Ml8YTq6x1Rc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqEXjU85pTtdl1RHIyKMLy9Lmiv/VvfX38hezJXPw6n5gcbGP0ye2w2W7tG2ztDheTE3+zBfEia6hWE5OuIgXavz/G3OhgrT7xrZteIO3qiDJ6SmUTTiY03Mjk/8nwXkPrj9rKkJ+hZOrxSVg2tSEkmNKYd9QhaqEOHFivg6Zqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVXJW7dv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVXJW7dv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D78E41F000FF;
	Thu, 10 Sep 2026 12:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789044793;
	bh=keTcAtF1zqvK5IJzXtcYVn5xGz7jRGOsGQXtmw1h9t0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PVXJW7dvaVI4l61WnnOvn6fhHfIl4mAOhEi1IQHr6aWKSDGv8ufigxghzMGPYso5Z
	 QqZbEaBAXD5l9LnQl617Bt9WQMTUtxQI+/PTpfdPP2t577u/c/2axadDmZdOYLgpuf
	 ArYfOa71y7gZuLJQvG6QbQzmNvFxsSXnZzK5M32CvXABu5aDCvP3GYlzUfpPI4awWS
	 VEC9UYCHos7ZLI3g3iQuk/XE3tfcelBBIj23/ogG7GsZ1o4qUJ9vxQ/ODUa604wLIj
	 J0DuomlEMdImBIfbgkicZcfPVKpPkzSLOuvfcC1GF+tBjcxVqY/5dzoTr32ZNt4qsc
	 38baaTHSAisAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Can Peng <pengcan@kylinos.cn>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] spi: bcm63xx: disable clock on resume failure
Date: Thu, 10 Sep 2026 08:53:10 -0400
Message-ID: <20260910125310.185570-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090843-affiliate-underfed-18c3@gregkh>
References: <2026090843-affiliate-underfed-18c3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Can Peng <pengcan@kylinos.cn>

[ Upstream commit 2b62c2c134fa32d9d3a9e7323c8ac74518eeb4ac ]

bcm63xx_spi_resume() enables the controller clock before restarting the
SPI controller queue.

If spi_controller_resume() fails, the function currently reports success
and leaves the clock enabled. Propagate the error and disable the clock
before returning.

Fixes: b42dfed83d95 ("spi: add Broadcom BCM63xx SPI controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Can Peng <pengcan@kylinos.cn>
Link: https://patch.msgid.link/20260804071831.860784-1-pengcan@kylinos.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
[ changed spi_controller_resume(host) to spi_master_resume(master) to match the older API and variable name. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-bcm63xx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index e57e1f75cd9f9..1dc579d9e3c4c 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -669,7 +669,11 @@ static int bcm63xx_spi_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	spi_master_resume(master);
+	ret = spi_master_resume(master);
+	if (ret) {
+		clk_disable_unprepare(bs->clk);
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.53.0

