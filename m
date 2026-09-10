Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491CF36729A
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005562; cv=none; b=K7dISE5c84rJjOeL/KoQuyNabr9lHnyyj8IeynVI/y+b6AQI1kgL43W2T5c1leDyDxh8yKKLfXNgE2TXI4oWH2FgrfyokDuuz5woHUBwqaIaUURp8j/XhCbQK1HXfn7XjzVn9Rtmhmkh64S95VmW90ficGCnX01ddkIuUyr3c9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005562; c=relaxed/simple;
	bh=exkfzkGaM7gYBNIe8Ttl2+58/HGUTssOg2CKxMWDYh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f/Xyz0KAeDt0hmovkK7RRUNh9WYFzboHq7eNadxyEsNZrUT8RX7crB1g2u+KigW52qo2bMHLR1HS7r4PWxcsHe2IEk6E8t6MTbWpGiAblkz2fhUaFieo6Hc39Q/DpT+VmcB6uBhquOxSBaahsS623t8qWcJl6ca+OIPRVHYUbxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qz61O4KP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qz61O4KP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604751F000FF;
	Thu, 10 Sep 2026 01:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789005561;
	bh=nqeKjajy5FREs3byswZJm6wloK+s4NxytwYVssl4jXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qz61O4KPygjxJ+NC5zKvx7A8qYclV3YE6ydGD+C05C+R3ZxuHVTgn3u4m2lIvoAlA
	 BbtRXcPE0ERyDVpypRFiPxBNHgEGIZH265r6ovH90jxNFugmZWHz6rc28hyM2YxIsp
	 stISmSQI6monrq44tR2sUKO2iYJbZF/k4IAqoi9jrFwTjikGWGDF27rytFgkHYVHwO
	 +GGt1fveAqbqatCtRSXmrrG27FOKinKPkGzOvUYkozPTY44pIelBz6u7tUSJjUmj1w
	 C5To14dL4zdv5M8sDSuvDHAsXo7pQoLV6ObNRphKohiQT9xfz253cs6GiyGDeNwSEb
	 ATNJTsfhOEUug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] i3c: master: Replace WARN_ON() with dev_err() in i3c_dev_free_ibi_locked()
Date: Wed,  9 Sep 2026 21:59:16 -0400
Message-ID: <20260910015918.3949701-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090420-duplicate-unframed-a6f4@gregkh>
References: <2026090420-duplicate-unframed-a6f4@gregkh>
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
index add78b03c5338..b4426fa660898 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2710,8 +2710,11 @@ void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev)
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

