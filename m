Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1370935E1BC
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003034; cv=none; b=qN8ipJeMHCpXadzerZm1+jr/UtEONB1JkSkLEBi7grjVdK0BMmoE+VWKBekM5zJ8/r0wH0H9pCo5gB3ce5rV+dnoajSBsMpbeU/WKr/eyUXCDKFVtS9b8XTBOHr5q7zRlrOfAG0iIs+IAL8ngL92riR6lYTMkxPRATd3j+jzdNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003034; c=relaxed/simple;
	bh=RbywjcStM2SZ6qdxU+JhA5u7SLdH2Wi9WscF5VgRmZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j4HKcn27NtsL+pjIVptU/XcEzfwBdvO+CLI7Yfclj7IycjXqdEDJPvCIQHha05DUEkzjMZbXIWtQC1lP2Q7M50bsrCEGCzQzOUSr7Qq9GBRihV9GtINSHAWF7/tPcxP/VccBZSjyVgWI+UnRXyKhZi1dalx9/0C/JavbJNuZnyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YttiGsyD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YttiGsyD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74501F00898;
	Thu, 10 Sep 2026 01:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003028;
	bh=7aPaCy2tV4WTaGADE8iiXhCNN5BngexYqguDLyVBvII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YttiGsyDbADT2tlkXPp0NuBDj+iZOVF5o//GK2LYBi7yili9v4rHlzfTZoBKAZVKt
	 oHZ0NZTqxdhD9UuH5McSl/q1isGDkdoO2bI1TP477iwoeH6W+H3ieOu4/jeKVRYuzu
	 3m8+I6SYb3KNJJ3XAFDPQKO//2fuw/AfiidA3aDtWMj8/X5b+Rj1SQ3hMK3WqR58AA
	 0Jb2hs2D8xG01eOhY5HFiLWvA1jniBMmotOGW3fwHXCB2Ynd3L6aGXaWGMfDPQLmSg
	 6wj48zkBc7ErUBYXuGyQ+EfNHQFnVrocF4O4g2VRuqc9eGDMnwdT+/i4y+DbdbzO/U
	 rZmWHpKe73Nbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] i3c: master: Do not treat master device as a duplicate target
Date: Wed,  9 Sep 2026 21:17:06 -0400
Message-ID: <20260910011706.3831507-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090411-sublet-unblessed-7a77@gregkh>
References: <2026090411-sublet-unblessed-7a77@gregkh>
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
index c062e94ce2211..e6f8e1daa5a19 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1981,7 +1981,8 @@ i3c_master_search_i3c_dev_duplicate(struct i3c_dev_desc *refdev)
 	struct i3c_dev_desc *i3cdev;
 
 	i3c_bus_for_each_i3cdev(&master->bus, i3cdev) {
-		if (i3cdev != refdev && i3cdev->info.pid == refdev->info.pid)
+		if (i3cdev != refdev && i3cdev->info.pid == refdev->info.pid &&
+		    i3cdev != master->this)
 			return i3cdev;
 	}
 
-- 
2.53.0

