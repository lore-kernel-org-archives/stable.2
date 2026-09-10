Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CA445561B
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 11:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039104; cv=none; b=bjiYxw5ak/8xhBweW+KxvedS/9wylf5SGZPJhche/PLCq6QHBS97VY0GQWjjztDG7Z9wmOSqwjpve/QJuxGzSuhwIbqL2U9iGpGs3mP+ZCrKYMWYgO4Ohw6V25fHBr6IUicof7v18jNg1CWU6W/xpTbq3fffkNH62Carm3KszQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039104; c=relaxed/simple;
	bh=5W6lKG8DOqkQAE3M+he680DTMEeiJNd2UPgL/FFI1pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=moF9ozdBgLnZVVKIBsT/0snmSFFeZ5ddNLCgXIu2GHjDAdbbMkFBLgfYuEm7XiVFAZLvULS03wIPl5Vdc8k6+eyFrvniWaNiWIaeeDJk00aN9wnjt5+siuERItld6s5zPrP4hdftDPbQHz5F3wTfjkyewvqzSRp1ykb//JfKiPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jf04jGKj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jf04jGKj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE3921F00899;
	Thu, 10 Sep 2026 11:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789039103;
	bh=WzNEjMtL+CzDrX/Q4ETqGvcD46kuxJYbZWWPdbBjagU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jf04jGKj+SqxKtccR7GjN8xn3w1UP9gsR/QEB30yA8ZRGCJ3mXdelfRKHzI5L1rBX
	 4kKQq9sQmuz1mRyujllrliZp/p4iaEkgDN7o9n/SmlUiIGL4UGZegx8zsv45+b8VVM
	 w3OQseUvzxciFSfZk90U6w1sc2JXZSECTQnZ2r03KuV8bwUtoJGDGQKBkMQPPldCpN
	 GXABCqqahEG/qlIQbRzgL6hEdHidh1PSOJORkxP6jTisxIWJ6yZ/r/bs2C7U3tprFM
	 AywDWFs0vZ6pV3ho7gxlKFs3y1CnvSMBjMXkE3RQkIs/tO1qwJbcqWiCO45RTU24u1
	 8zrH4jRyK0zKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Can Peng <pengcan@kylinos.cn>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] spi: bcm63xx: disable clock on resume failure
Date: Thu, 10 Sep 2026 07:18:20 -0400
Message-ID: <20260910111820.6891-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910111820.6891-1-sashal@kernel.org>
References: <2026090843-repaint-untwist-90f3@gregkh>
 <20260910111820.6891-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-bcm63xx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 80a88d38ec00d..cf0456f41a379 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -669,7 +669,11 @@ static int bcm63xx_spi_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	spi_controller_resume(host);
+	ret = spi_controller_resume(host);
+	if (ret) {
+		clk_disable_unprepare(bs->clk);
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.53.0

