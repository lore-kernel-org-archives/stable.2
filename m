Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B574BFE85
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 00:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788999500; cv=none; b=Hjkoy/oe8f1GRu7Hn+Pg70NSwIMgRSAwzA116htuBFV8F5szlKkEB2yrc5ywcMAcSw25YD4VuZRO33U6BuGQKlwzVx/3GI4ocIinksS9GDp2nDxwtAuQr/Z6jLT7bGTgc1fWXsdFKM25UAyEVIfDdySOfRnZZoXQcKST9N+5Nro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788999500; c=relaxed/simple;
	bh=aqg/SwP880lidw6FtTwzZtunMcOx0dMFBfTIemHzm8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LpR0VXuVV++gpqtNDpE4jye9M3r1Vv17XwLw27MN1YpvrKy8lU4b5HPjPiZ5tQJ2tyr6FeXQkpEz2ctcef+gO+xBNYKzrSpxMYLpQ0LKi/4/No1NLq9vkAuxv3xaDpCbHpFUj/ovbViDL4MVL2CnXahxWswRgxgemDJVWs2qwQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X9zC1jYS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X9zC1jYS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F931F000FF;
	Thu, 10 Sep 2026 00:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788999499;
	bh=cTDZcYL6oNE3+5iWLAp42+N5DWbDeoffgHWzUv+NzC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X9zC1jYSxcekiiBGtHC8wPPXXx9RwTi42GM826UfIEapgMsBbynxWHedqDSukUwa5
	 wdR4s6QS5Oy7JxrRvHlmG2feg4KVpA3N9QPH1/bS97Z1FiLU6JYCit/ctIIsOzvIfD
	 n5PRs+cP7jAQmlmJb5cXc3SCvciQ4PgOC/TNXs5sjWSlBX3ApaQfuKflW7tHqWee38
	 /YUS+YH8yUPAvaFDLZJybT4SSfsdAycRh4DZOKWHOqGHehfgnGpScnI9CGXfr2OY0I
	 Vdy9bWQrznz27rr75jtzfDsM5hFHYl97UbYUI3NTWqXXpdCW/4Ybm592o/xPTQxnJU
	 KeZ666DaysrUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] i3c: master: Do not treat master device as a duplicate target
Date: Wed,  9 Sep 2026 20:18:16 -0400
Message-ID: <20260910001816.3750997-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090410-overcast-tightrope-31f2@gregkh>
References: <2026090410-overcast-tightrope-31f2@gregkh>
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
index b51b159fadeed..edffa9720e5b3 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2321,7 +2321,8 @@ i3c_master_search_i3c_dev_duplicate(struct i3c_dev_desc *refdev)
 	struct i3c_dev_desc *i3cdev;
 
 	i3c_bus_for_each_i3cdev(&master->bus, i3cdev) {
-		if (i3cdev != refdev && i3cdev->info.pid == refdev->info.pid)
+		if (i3cdev != refdev && i3cdev->info.pid == refdev->info.pid &&
+		    i3cdev != master->this)
 			return i3cdev;
 	}
 
-- 
2.53.0

