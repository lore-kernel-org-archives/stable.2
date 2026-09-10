Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E4632E151
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003262; cv=none; b=QRdXHSPgLxOTRbxmMjaksTBZcTQmI+hRVCSCLL4lVyi30BxUeyWD0ly2G+wgPOWBu7P53m5/oTfLyBM3CNxAr4PUIyZmkjJqOCqJgJOFTtuvcIJk0aBr+4Bb0ID+fLVzvLswL+4VgEhiXBmCAdOKIsMVvh9q50H/xM9bfjKeJBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003262; c=relaxed/simple;
	bh=9rERr2e1TlCeWssk+7xwHPN8xLBWze9V0jnIPOMhNUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ej9mmlpGY1mZmCmclfwmXwzES0i1nZT2AfrFoSvd/Y5FkgourOADaQnRGxQJ3+VsH7mxY7ZrDxSPT96iZEjSvJWbcg5FpJ0qltG+dDf5Ctk4NWiSmRbdEjj31lZf1kO9QuI83PebSfTj74XPIYEDrRoX+r/LO/W2jOI2zVYxCNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jAbcwHKz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jAbcwHKz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723491F00893;
	Thu, 10 Sep 2026 01:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003261;
	bh=lene88BXYo/IuiBWGh7egAu98kH49emuOpgGJf/gYCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jAbcwHKz8ls1MFnFtpxuw+XSawH7AGjvGKVRZinjlWROODFOyo9WGtOzrYJsZZcv7
	 +L6RBRCCYTN2EQI3U1PvA0/oaizlvpSJhSaH0ilquxWRnqT44RPjElsc+t4S21LBFH
	 uOW/2UHHiKx2kO/w+XCp7GPxLFNFRAHyxZuvKtKQSruequdk6G3W6JA2IXZ4TZnWRe
	 lE0OwcgQefdJWWSn79g0kI5Jx7bZS1Ta64yQXg4n1uJoWWf5Ahw/i/lKG3VxqOca6w
	 d2VOvfdz7eXl37ro5+G1ruQiBeg4GZn57GwpKUQlH8DWi8kfiLKQzwsJS6+a9SRHCp
	 6zt6dSlYd+tMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] i3c: master: Do not treat master device as a duplicate target
Date: Wed,  9 Sep 2026 21:20:58 -0400
Message-ID: <20260910012058.3847485-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090412-bruising-crispy-d9d5@gregkh>
References: <2026090412-bruising-crispy-d9d5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit 4dc1b3eeba7991905a5b5b8129ebea51be7d87b7 ]

i3c_master_search_i3c_dev_duplicate() searches the bus for another I3C
device with the same PID as the reference device.  The search can match
master->this, causing the controller itself to be returned as a
duplicate.

Since the controller is not a target device, it cannot be a duplicate of
one.  Exclude master->this from matching so that the function only
returns real duplicate target devices.

Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Link: https://patch.msgid.link/20260807145638.168865-4-adrian.hunter@intel.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
[ adjusted the duplicate-device comparison to match the older branch’s PID handling without nonzero-PID checks. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i3c/master.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 09d7b707c7b18..2fb403a34cf39 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1976,7 +1976,8 @@ i3c_master_search_i3c_dev_duplicate(struct i3c_dev_desc *refdev)
 	struct i3c_dev_desc *i3cdev;
 
 	i3c_bus_for_each_i3cdev(&master->bus, i3cdev) {
-		if (i3cdev != refdev && i3cdev->info.pid == refdev->info.pid)
+		if (i3cdev != refdev && i3cdev->info.pid == refdev->info.pid &&
+		    i3cdev != master->this)
 			return i3cdev;
 	}
 
-- 
2.53.0

