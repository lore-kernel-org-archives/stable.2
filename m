Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8752DA749
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 17:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973207; cv=none; b=PjmyvP2PNSjnWuWAUVJrnbJeZthgjloznaB1MctftFLbFBj0VKKsqd3MetJVCLROhiIMvqVy60kZPmGDHxZKu7g6fmBHOprypHI8jQcOpD3phXo0tcbbURiQTYPyRa/fVgFMBhIZy8LIutTIhDWyv4C2lajDYok5M6/DJU/eYcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973207; c=relaxed/simple;
	bh=aaN8Zhs+i4skmOqKBj+e4psZjZl8nwOofkOnA6Q/8p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eegp205zdqzzkZw4ZYLxbtiFjcptFUPE+dlTeODTerlZUHS1jcnWtW5rJS95YeUnUvCzGON+hSwgFzvI4DQ8UuvBOJE6IxwDnOq3op8G8/xeXCfI0IiyvNI5dzgSbII4zwLehWy/PuXH96Y/BJClhUs2iYK1+SOKvea+xXzl2D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XwIKsYEx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XwIKsYEx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243911F00898;
	Wed,  9 Sep 2026 17:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973205;
	bh=3vRrpw05cTfLBJ+7Hm6blYZAbUdZYcjYLelbF4C4ph0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XwIKsYExVYmqtJl9Pcb580T3/sAYKX3mt9EsQ7JIEiE3krsJ1lvb6S0n4CDs6U8/I
	 Qp2GsG6D04bpeFq5drndxP0ZhU0ZBJqe0s6Yl6lFnQJgcVYkDgfk9ss16VYhLSmLN3
	 3cbU6KVJQLIYjUUTLtNoLqA4J0Sno/oxt1CdXirXJuNgNV5RtzaTLrpkkeYcJFy/Rq
	 39IxaRw4pRpr9IaDD2T3k+w97jk6dtLE4o9Af9h8uy/z3KVujXnHQBkWMsih0udkg4
	 wBDEFqyBqFvE3tI1LXef/gxkKt3cIBov4le+9UNX63dmbreHxlMEDOAJKppnTNBMh8
	 7ADN+neyllo5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maoyi Xie <maoyixie.tju@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] power: supply: twl4030_charger: cancel workers via devm
Date: Wed,  9 Sep 2026 13:00:01 -0400
Message-ID: <20260909170001.3156731-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909170001.3156731-1-sashal@kernel.org>
References: <2026090356-iphone-deviate-2dac@gregkh>
 <20260909170001.3156731-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maoyi Xie <maoyixie.tju@gmail.com>

[ Upstream commit 6eba34732524067da2aad5ddfdfbc641ded10e9e ]

bci is devm-allocated. Two workers (bci->work and bci->current_worker)
dereference it. twl4030_bci_remove() disables charging and masks
interrupts. It cancels neither worker. A worker pending at remove() can
run after devm frees bci.

The USB transceiver comes from devm_usb_get_phy_by_node(). devm
unregisters its notifier only after remove() returns. A cancel_work_sync()
in remove() can then race a notifier reschedule. devm_work_autocancel()
and devm_delayed_work_autocancel() avoid that. They cancel the workers
during devm release, before bci is freed.

The current_worker is registered first, since devm will cancel in
reverse order and bci->work can reschedule current_worker.

Suggested-by: Sebastian Reichel <sre@kernel.org>
Fixes: d6ccc442b1210 ("twl4030_charger: Make the driver atomic notifier safe")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20260702172128.2001753-1-maoyixie.tju@gmail.com
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
Link: https://patch.msgid.link/20260725072540.3092504-1-maoyixie.tju@gmail.com
[Move comment about order into the commit message]
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/twl4030_charger.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 1bc49b2e12e8d..2c60a10ae5877 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>
+#include <linux/devm-helpers.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/twl.h>
 #include <linux/power_supply.h>
@@ -1004,8 +1005,15 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, bci);
 
-	INIT_WORK(&bci->work, twl4030_bci_usb_work);
-	INIT_DELAYED_WORK(&bci->current_worker, twl4030_current_worker);
+	ret = devm_delayed_work_autocancel(&pdev->dev, &bci->current_worker,
+					   twl4030_current_worker);
+	if (ret)
+		return ret;
+
+	ret = devm_work_autocancel(&pdev->dev, &bci->work,
+				   twl4030_bci_usb_work);
+	if (ret)
+		return ret;
 
 	bci->channel_vac = devm_iio_channel_get(&pdev->dev, "vac");
 	if (IS_ERR(bci->channel_vac)) {
-- 
2.53.0

