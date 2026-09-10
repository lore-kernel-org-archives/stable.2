Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4464C3769FF
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 02:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006271; cv=none; b=Nv0UdrycX3Me6vJYAKZNfvbkUv9QQKMoB9KPxw1CrDkKyV3+36FtwX1yuotJs65YpyfcNDTxPKVWOZPGsEqKycGgv08trKPBdv7OGFTKdBH7vJ6pbHF7iBSkdaWQQIPHmBzjS+B1LLQPbDJQruZAoO+IT4ftc36rEIvWvve29uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006271; c=relaxed/simple;
	bh=R41/eyz6juY0s/uLZUS6Z0wkAkdELttJiPK4zaK5ED8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ip0lcBiT4UxO4rcBFj5J7BDsi0sbTQBTU1cn75BB+dcJl1Mk3BDpy3bgFExKEAt/ahYyWUgOqA8TCdOp5mgoKatoPHfvJGz0OIggo9pjUNWcPFINKzuSxDQ/WqHGsMyY+Hj6jxmYdn3F3TKhBUQrzffOEQ8v/URgW7naZnOlm4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/p8zEo2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/p8zEo2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2691F00893;
	Thu, 10 Sep 2026 02:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789006269;
	bh=ZUZB8Sed7qkjwYcQ4ivxuoGp9zrePRiMukGx1kxQNGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O/p8zEo2Sv5Aj1yPj7gHhm040Q1RYe3119XOM2SHwG54y+KVbz278zq3/Ss6BA8rx
	 iRLi2qrjjlKURM+YSm4D5zPMWNtNFwTWkIH5JL7Uq+opra3DrDFW4vzYKNfFr2+qiH
	 MXuN5XtsLvGQS95OlJa7iq1AYqYx9SPH59QbeQ+lmLVZM/W/HINL7+KG2mBXfpv3Z4
	 eEGBwfUsJlnHL758D4hVlaFVeM0XKO8ixK7CENJFcWPtDbzSFxBPRWYSCf9cYUJzT7
	 OD63n30M5YWd0K/sXFvxgHim3cOa1rajFmaj4XnztjN8NxDAp2v54fmhWvOhqmgm/n
	 mtvYz2g5gmyRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] i3c: master: Replace WARN_ON() with dev_err() in i3c_dev_free_ibi_locked()
Date: Wed,  9 Sep 2026 22:11:05 -0400
Message-ID: <20260910021107.3989169-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090421-spilt-flock-92e8@gregkh>
References: <2026090421-spilt-flock-92e8@gregkh>
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
index 22a95b30d5aba..f5f05d66347b8 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2752,8 +2752,11 @@ void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev)
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

