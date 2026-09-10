Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767382C0296
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002018; cv=none; b=Cw86BhtPwWwRstPDbAZlXi1hhDgQk5nEHklRDbtmgtIZgow9rY8hKOxWM999xwzH/CzZ0gCMT2J1F2fLQ43GknuI3j0kQn4aGUf2Atj6ieSGG9TKnpzjep7NktG2CzEbqHQahLJUnv5zmdtVGtHeTmvafrz8qOuTGuQe8qRFWiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002018; c=relaxed/simple;
	bh=c38Tr1joAMyE+TOFjOfpyzNVQy1RZaX3gsQvokxm1zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFeNMq1DDjLp9E4etNaKlicck/8/PgyVTg7AXyPQ4ioJwm5qLTzpnBH1oinDhY2sBcE5LQwS5KZFiBQDzpz2NT27ckKBgzPrb3GJzAkR8XLvHNqr7vReQAvnWAiCcz3tV8U3VnPYU8TAq44mB+0RAhBZHyxB5JKtyst+OrRhNR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JTICBGKf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTICBGKf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42C51F00893;
	Thu, 10 Sep 2026 01:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002017;
	bh=XHY6dbXfFyd6Cu2ya113tRprtFxdqWJ6EP0VJ1tm31s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JTICBGKfLCEIC2D9dhRCApctLWr33XbKcUxOPk94b1SP9ECWf7GQHY474hQravNLn
	 0OJaokzuUdvZm2x0fGE6QW+Wtku46nvyWmBE6NCF7PzVBe9xO4MV0iaduQPb78khUP
	 MqRZtGSPFWuelp8AyJ0HKR0W7dwK3joCa7oxk7jWu6/oc9CSll+oJ3BOcRWJBg7Hi1
	 sZ+Yj38vLnaFK+rLP4JmrE651gQDaOy/ceask9wtWWHAE2KU2A/is8aEmxEaKMnONI
	 LCbutfWaKLjX8voDxOJQgM2xxIYLPWOXpBnyhXVTw+U/8qx+z+yVGYW54V1MUGTvf+
	 FcKOY2DHaRkOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Frank Li <Frank.Li@nxp.com>,
	Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] i3c: master: Do not treat master device as a duplicate target
Date: Wed,  9 Sep 2026 21:00:14 -0400
Message-ID: <20260910010014.3788076-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090410-unnoticed-twerp-c8c4@gregkh>
References: <2026090410-unnoticed-twerp-c8c4@gregkh>
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
index 41452a27262d6..1867a9206dc47 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2272,7 +2272,8 @@ i3c_master_search_i3c_dev_duplicate(struct i3c_dev_desc *refdev)
 	struct i3c_dev_desc *i3cdev;
 
 	i3c_bus_for_each_i3cdev(&master->bus, i3cdev) {
-		if (i3cdev != refdev && i3cdev->info.pid == refdev->info.pid)
+		if (i3cdev != refdev && i3cdev->info.pid == refdev->info.pid &&
+		    i3cdev != master->this)
 			return i3cdev;
 	}
 
-- 
2.53.0

