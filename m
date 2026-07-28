Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC6642FCBE
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785240684; cv=none; b=vFRojKhE4VFW8+M+FgPaniLjBV2Zzxcd05cwHh6GfLOt1TLwIC5JZNQ1Ph4mwJeMZPofcELBTwQcD7XSj4yQq8PRSxooQoMIggyHON2rKQqhWg+Sb/znbF0TWecISwD59/jwZskIPd+x39TxRLtgKB4WuEFjZAo2k/KEiy1kFgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785240684; c=relaxed/simple;
	bh=YhuX6Q9DLvrk+e9L7qv1ADccI0BMH3Uf9U0Tj178oio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pKmVMrIQmH/ZKGgmDd3HArYoivnygzn4aZkUZ/r3hOi9qlvt/x81MqBvmV9xG97Hfo2++7ZuRxEHiVg1xO1qABM1oz5AEz+DQQnxBlLPrffZFg1gKKwc71Y7GlluKTqMATNVanNHbcww7np6asaoix1NNQVumd13maKo+jd+D/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XezmZq9t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XezmZq9t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4BA1F000E9;
	Tue, 28 Jul 2026 12:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785240682;
	bh=g9qrym0H2V22RlcsYW11jzFTN2bK7sluRo9EMqyYc4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XezmZq9tK/rFrJqqtg8lbLj98t83jSmSR17fOVM8p8wOGuLT2x3NI+ItKstUujbtt
	 GKx+yJXMZ9NqVmdIo8AK6gbz0VwM4JKHtE0woG9AkOV3VXYLhW4ADIzHJFgABKypSB
	 mFkQ+UpIZtR8JB7b2GGBXQiST/8VwFPRFly+ECw8FGth9OEuEn7//ACu5xfSrhYLKR
	 9f92jXhKvJA2KyOWLJBn2Y77NUnrXsM0e/OBLdoJ2oRu2OBQoXB1bjLzYbFX9/gcnM
	 Unrk1xlD4dyrdocw5Z6Jhe+Sy4NT0GSyWQbn7J7Zoa+goCeN3NIqh50GRc6ZLl4mpQ
	 eNVJ/4SY5wzjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Haoxiang Li <haoxiang_li2024@163.com>,
	Linus Walleij <linusw@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] net: ixp4xx_hss: fix duplicate HDLC netdev allocation
Date: Tue, 28 Jul 2026 08:11:20 -0400
Message-ID: <20260728121120.3703458-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072005-audition-moonshine-c2fe@gregkh>
References: <2026072005-audition-moonshine-c2fe@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haoxiang Li <haoxiang_li2024@163.com>

[ Upstream commit db818b0e8af7bac16860116a19c341a63d6677b4 ]

ixp4xx_hss_probe() allocates two HDLC netdevs. The first one is stored
in ndev, initialized, and registered with register_hdlc_device(). The
second one is stored in port->netdev and later used by the remove path
for unregister_hdlc_device() and free_netdev().

This means that the registered netdev is not the same object that is
unregistered and freed on remove. It also leaks the first allocation if
the second alloc_hdlcdev() call fails, and the first allocation is not
checked before ndev is used.

Older code allocated the HDLC netdev only once and stored the same object
in both the local variable and port->netdev. The buggy conversion split
this into two alloc_hdlcdev() calls. A later rename changed the local
variable name to ndev, but the underlying mismatch remained.

Fix this by allocating the HDLC netdev only once and assigning the same
object to port->netdev.

Fixes: 99ebe65eb9c0 ("net: ixp4xx_hss: move out assignment in if condition")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Link: https://patch.msgid.link/20260622043015.643637-1-haoxiang_li2024@163.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wan/ixp4xx_hss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wan/ixp4xx_hss.c b/drivers/net/wan/ixp4xx_hss.c
index 88a36a06931120..019446ee7d3808 100644
--- a/drivers/net/wan/ixp4xx_hss.c
+++ b/drivers/net/wan/ixp4xx_hss.c
@@ -1353,11 +1353,11 @@ static int hss_init_one(struct platform_device *pdev)
 	}
 
 	dev = alloc_hdlcdev(port);
-	port->netdev = alloc_hdlcdev(port);
-	if (!port->netdev) {
+	if (!dev) {
 		err = -ENOMEM;
 		goto err_plat;
 	}
+	port->netdev = dev;
 
 	SET_NETDEV_DEV(dev, &pdev->dev);
 	hdlc = dev_to_hdlc(dev);
-- 
2.53.0

