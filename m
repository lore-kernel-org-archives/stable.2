Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F7A28690
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002026; cv=none; b=s/JBBG8M41Ps87wiEHnq+HDbsoX9299rJN6OjGIxKz0a8koNXuNP4PVncRMMAqrfSb1wBUrPKO7EOz8932xq/haCSjEFMRlOf8TQWUUrOcKcVuDF8uukvBmWEs0kQjBzekbNbBL7r56IdsXjsE93fHQqiqmmZEl+Gy1t0wZEYSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002026; c=relaxed/simple;
	bh=YjP/Tnu3ND0cDfpaUby909zuHw0cCGYZ3TWglog3wd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DZoxL3UBv2YXwwdeyV1qGrH+kBVYtQKjbRjilUGs23OguKOzsE8LP+aW2WH6QLxeE0X/UdY1zWvD4mwP6/jMxw2Kk0jLDmuO+ibrdpetPNXP5SdATQj+Rkftu4ddEUFcPM9elGQ/RGLfsLkQS1pE/1Pqcx88tC3RMLkviOj2c7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LmRsW2Et; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LmRsW2Et"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E9EE1F000FF;
	Thu, 10 Sep 2026 01:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002024;
	bh=6OLZ9UTXI7tRdQ771m6c6mEWAtgMFY2vlRDIjFrN0NI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LmRsW2EtbowvGSMymDkeWU2VDiYH61Huke29i3XqGwyEoIMG/0/zOMxPrJhkmXZQN
	 +cQuTlZJ8YBhZ/YYKiM5RCGjAQqj+NC0M4qalww3iV12fitGYyIZhfISxx1DKy5WnT
	 A6RP0V+dEW0vSTpetV72RV1DlZHdf7p/xl44pgZOy6MMdM0NVEn/ar6il3vZH7Vl7r
	 QyR0igfmVX48pxkZPi0hTTKGLQhQEZpR8WAXVU1pyIEytHMQZ09Bys3XBd0wsGJ2zQ
	 4evar6sQGqML1aSfbdAYThrohn+ifcnpJO4Uthtq8+MSrUXFouIleaNWkqlt27mBy4
	 OyktGYn2ffbwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] i3c: master: Replace WARN_ON() with dev_err() in i3c_dev_free_ibi_locked()
Date: Wed,  9 Sep 2026 21:00:20 -0400
Message-ID: <20260910010022.3788326-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090419-playoff-payable-3bac@gregkh>
References: <2026090419-playoff-payable-3bac@gregkh>
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
index c062e94ce2211..c4f31c8ff2ace 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2997,8 +2997,11 @@ void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev)
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

