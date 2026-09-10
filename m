Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6507280325
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002139; cv=none; b=BBTxl9pCalDIVwo1AtE+xFL3W7jxHOF+A7C1a/M/hSuHmlkS45KQ51Qr63Cbpvfny9oYfPN5nTu9kjfoXsCeF0P+GddmL79TGgZ/I9OR9jR7F9sEMrgYEAWryBORd8fiEBIkCCpizJ0at6pYCVSRxRTkPkPFcAjB5XVZJ71rtCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002139; c=relaxed/simple;
	bh=WKJj64wVptHt4/WivKccVzlTgMmmNs/W4rVViCQMdpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoJPrlFnWEpV/1weVqGjpj/qCvyNA/KFHqbQUVG73Y/fHG6XYhGBTyMT5fYd/HSQCH3mMy6G5rPBJPhaVsVW6gIIvQluXb8q3qu5cYtOLlh8FTkjthaJqef6kpWbKezvFVS0cmeD6X24KDNx09NQhogKVKg9N4CEBKHonHsScyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7fHhthX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7fHhthX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8901F00893;
	Thu, 10 Sep 2026 01:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002138;
	bh=iFjAGjx4YQ53dt5XjW0S0/YSiCMavVQATTx/ZHNNRs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C7fHhthXJeG0I+rovL+htPKjWdSKO2197piECy4LxYzP7BpPFifp6woq28YTvn4kw
	 F1eoyWjiyowgHn31c1EmuZhxMhPZSMoaypmEdoWDYhZai7e+3pJAg7dlDVCv+XqJQq
	 /y3MgHpP/0P4c5kT2+ArJGZzWZFq5UZT470tIlPGoqaT3xWAeSgoLBEIVHmZLo42H1
	 bJVhTwJCy/9cmdiwKphZMpNEVpD2Khc2jONc0sfnZU45Q9b4P9vLfgo0w8q83RjHD8
	 AUP8syerkWzIa/zJEMUyx+H4UwWlA3mz32dAnGiGmjoe3Fk4ruJ4zcO0n4nxCueYAW
	 OmsSHYw3q5Wfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] i3c: master: Replace WARN_ON() with dev_err() in i3c_dev_free_ibi_locked()
Date: Wed,  9 Sep 2026 21:02:13 -0400
Message-ID: <20260910010215.3799061-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090420-phobia-unluckily-1be7@gregkh>
References: <2026090420-phobia-unluckily-1be7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 471895799c2f46688792e175ced936ffeb6cdf01 ]

IBI disable failures are not indicative of a software bug, so using
WARN_ON() is not appropriate.  Replace these warnings with dev_err().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260113072702.16268-5-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Stable-dep-of: 456f832e5fc2 ("i3c: master: Fix recursive locking during device registration")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 09d7b707c7b18..b805eb2204993 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2973,8 +2973,11 @@ void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev)
 	if (!dev->ibi)
 		return;
 
-	if (WARN_ON(dev->ibi->enabled))
-		WARN_ON(i3c_dev_disable_ibi_locked(dev));
+	if (dev->ibi->enabled) {
+		dev_err(&master->dev, "Freeing IBI that is still enabled\n");
+		if (i3c_dev_disable_ibi_locked(dev))
+			dev_err(&master->dev, "Failed to disable IBI before freeing\n");
+	}
 
 	master->ops->free_ibi(dev);
 	kfree(dev->ibi);
-- 
2.53.0

