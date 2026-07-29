Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6279C3845CF
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785360235; cv=none; b=ecrU1GCq0SJfy/IE2+54FBQ0Lax6VDARPvTwLCLuJaVG8RpQ6fRpqsKCoBdhQXVl9EFFrH6zot+630j/rZKZVT28yZDr/Lztn4V2N9DvOxvcbPn+v0i7Aa39Bk6Mb1kOLXip+VyqSqDtPFU7fJDAKjZIxRci6cxCh+pC+PYkQcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785360235; c=relaxed/simple;
	bh=7bO7QRtbkjkpILj0KnLwH81y45QbLwOjToP4flt5Vu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k28kbMZwftZGgpDehnMYp5NA/dA/HF41q+yDziJfmxxiDiCHk8lZq0cweQe9Dgay7XNxZ27gpQXldSuOF90dphQkCWam0QRNS02dAibmuQt1E2GyNNnS+cJMIBNrJycQy/5UbvofpV6Ehidy0RaSEJ7oszhNS9QJNCTadF+1TV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbbKXOf2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbbKXOf2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2D401F000E9;
	Wed, 29 Jul 2026 21:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785360233;
	bh=fLifX6uQ0uBopBOHm+98lVeSBvoSfq5SGIc7y2Dhn1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cbbKXOf2G8/oVcC03/Xjyhrgd6VMaHxDdyOLmwZ/nGbg5n+kRHlo/meq3ZArA4WoB
	 tU6hzWP3WPd9E/luMpl04dmRB4BKlm40+s4jrfqcR0WI8SjyDEvcWw2v8jZBmZrAlR
	 W5r+rxrc4Hm1oqDu5GuvKHV6W/OnD3odWjeHQgwbUq5ZcQvhJy9aGURZRiHeEZf3r5
	 1Q98GgipLwcgo/KB9YqiZXg4K4J6Smj0dyYjN8VZ7OsFQT8BU9DGfb9ytpYtn0Gs6+
	 UXmvWpfmNuW5M7yO2UJ2WADtZ9w95LLFT3R+ILnwwKgDWqLZK4HV7oqWXGqtI69HZO
	 Q/YALIGI0bEbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] i3c: mipi-i3c-hci: Fix Hot-Join NACK
Date: Wed, 29 Jul 2026 17:23:50 -0400
Message-ID: <20260729212351.1210709-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072102-gliding-bloated-dfaa@gregkh>
References: <2026072102-gliding-bloated-dfaa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit fa9586bd77ada1e3861c7bef65f6bb9dcf8d9481 ]

The MIPI I3C HCI host controller driver does not implement Hot-Join
handling, yet Hot-Join response control defaults to allowing devices to
Hot-Join the bus.  Configure HC_CONTROL_HOT_JOIN_CTRL to NACK all Hot-Join
attempts.

Fixes: 9ad9a52cce282 ("i3c/master: introduce the mipi-i3c-hci driver")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20260306072451.11131-3-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Stable-dep-of: c6396b835a5e ("i3c: mipi-i3c-hci: Fix handling of shared IRQs during early initialization")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master/mipi-i3c-hci/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/core.c b/drivers/i3c/master/mipi-i3c-hci/core.c
index 75e6610cfd8129..f2529315445f13 100644
--- a/drivers/i3c/master/mipi-i3c-hci/core.c
+++ b/drivers/i3c/master/mipi-i3c-hci/core.c
@@ -147,7 +147,8 @@ static int i3c_hci_bus_init(struct i3c_master_controller *m)
 	if (hci->quirks & HCI_QUIRK_RESP_BUF_THLD)
 		amd_set_resp_buf_thld(hci);
 
-	reg_set(HC_CONTROL, HC_CONTROL_BUS_ENABLE);
+	/* Enable bus with Hot-Join disabled */
+	reg_set(HC_CONTROL, HC_CONTROL_BUS_ENABLE | HC_CONTROL_HOT_JOIN_CTRL);
 	dev_dbg(&hci->master.dev, "HC_CONTROL = %#x", reg_read(HC_CONTROL));
 
 	return 0;
-- 
2.53.0

