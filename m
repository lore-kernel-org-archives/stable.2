Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097502;
	b=t2msWmCXA61HbFLEdtvVMeKWC2ufV2NRZWsmALO/rCXtIbaFCd9OKklQLOcRcxqv6oa6
	 1Aip6qJxlA/djcdXPDaanZf5jgCrtm4EPMMlHV+J0m/UM2ZlW2JylxQUi+aA4qVAP2BUe
	 nmODRv84xZKem21AN9ydN03l+1MSExgjKbroRPvsChjYs9mvRHvDfxHXsJoNiD1ushXDA
	 fASU/lMLeH9Yt4qmHhF7GFboxgJAj5YBXgB6ogwabhCvMx/270cbG4P9L2S89h3qYl+w+
	 D4P6dilNaAj7B4h5Utb5rZAKqIJs0cTD8lxeSiYT75H55pra0occi9xrOCWVlSCwpyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097502;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EhPXelCABLWuSjrEc8aU2EyQqZo8N/hPtG5bDKHLnWw=;
	b=eEQ4NNu9GWC9oSgL+KQdQy5EpW4QQPb5AlkWKsXRbQYssk1DN7vBQnfcLTGTLkr1Hu9c
	 Pqs5qd9+puclqj3FN9G58L3I3YI+gCRW7npBGvMVKGERyvO8+7ZrZtdzBpMlIuUfD+hML
	 k48uTZDw54ss7qZM7EWzX9zq2PoLNc612aSbhGHzBfF6bheyDoytbgd2MzOVBYa9qEBtM
	 2l9cy/77TkzbUF/ky+Yv0084IFMF8UA6k+QKkObecnZpdTTZnEftTccppxNn5OEXWKIgp
	 1RYZUqdkUxWOVHfeU+Zr8zTtiiN6vitYsyl86+lk0TH/Q+yfCQs1kDSx1d/8g3jp2cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4XeIGIP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813C9606A31A;
	Tue, 27 Oct 2026 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4XeIGIP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06CB41F01828;
	Tue, 27 Oct 2026 10:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793097502;
	bh=EhPXelCABLWuSjrEc8aU2EyQqZo8N/hPtG5bDKHLnWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G4XeIGIPvE+xYgVHpDHqXMtEF0v553A8vM1XSFfYh384TgrWfqwXzR2+Pa9nabpcE
	 loLXPqZ0UItj8rbU9nV9Ry6thYMHGe1Nnjc9HBWjAPIJg86MypzuaeWKd72uIBZH6I
	 i+9jPsriG1qmLkzrbWCEONILNwucHtUh9CV/lLb1MGpkhljCKDi0f6KLW5Fw2Ko1yX
	 57PtbTRHimNS+qO6riC03hkVbR850TJUpCLm0UZDrHWgQAVaTugrjHHBaK2PXILAOR
	 DYLQJk/Jsi0uXa7P/kYf4Y9dnR1A26gUiP4Qu/gbylqJDfJrn7Rc3rFCyW8TowY7Bu
	 6qZAWdYPxYbkQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Linus Walleij <linusw@kernel.org>,
	Mattias Wallin <mattias.wallin@stericsson.com>,
	Samuel Ortiz <sameo@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 21/27] mfd: abx500-core: Unregister device ops on devm release
Date: Tue, 27 Oct 2026 09:30:50 +0000
Message-ID: <20261027093306.2812695-22-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261027093306.2812695-1-lee@kernel.org>
References: <20261027093306.2812695-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

abx500_register_ops() allocates struct abx500_device_entry via
devm_kzalloc() and links it into the global abx500_list without
registering a devres cleanup action.  If a caller's probe function
subsequently fails, devres frees the entry while it remains linked in
abx500_list, causing use-after-free and list corruption on later
traversals.

Register a devm_add_action_or_reset() callback in abx500_register_ops()
to remove the entry from abx500_list before devres frees it.

Fixes: c211b6b9c014 ("mfd: abx500-core: Convert to managed resources for allocating memory")
Closes: https://sashiko.dev/#/bug/linux-6a9c6b8b-8f89-4af5-8cb1-102822e44e6e
Cc: stable@vger.kernel.org
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/abx500-core.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/abx500-core.c b/drivers/mfd/abx500-core.c
index e896531d0354..5873e335c395 100644
--- a/drivers/mfd/abx500-core.c
+++ b/drivers/mfd/abx500-core.c
@@ -5,6 +5,7 @@
  * Author: Mattias Wallin <mattias.wallin@stericsson.com>
  */
 
+#include <linux/device.h>
 #include <linux/list.h>
 #include <linux/slab.h>
 #include <linux/err.h>
@@ -33,6 +34,21 @@ static void lookup_ops(struct device *dev, struct abx500_ops **ops)
 	}
 }
 
+void abx500_remove_ops(struct device *dev)
+{
+	struct abx500_device_entry *dev_entry, *tmp;
+
+	list_for_each_entry_safe(dev_entry, tmp, &abx500_list, list)
+		if (dev_entry->dev == dev)
+			list_del(&dev_entry->list);
+}
+EXPORT_SYMBOL(abx500_remove_ops);
+
+static void abx500_unregister_ops(void *data)
+{
+	abx500_remove_ops(data);
+}
+
 int abx500_register_ops(struct device *dev, struct abx500_ops *ops)
 {
 	struct abx500_device_entry *dev_entry;
@@ -45,20 +61,11 @@ int abx500_register_ops(struct device *dev, struct abx500_ops *ops)
 	memcpy(&dev_entry->ops, ops, sizeof(*ops));
 
 	list_add_tail(&dev_entry->list, &abx500_list);
-	return 0;
+
+	return devm_add_action_or_reset(dev, abx500_unregister_ops, dev);
 }
 EXPORT_SYMBOL(abx500_register_ops);
 
-void abx500_remove_ops(struct device *dev)
-{
-	struct abx500_device_entry *dev_entry, *tmp;
-
-	list_for_each_entry_safe(dev_entry, tmp, &abx500_list, list)
-		if (dev_entry->dev == dev)
-			list_del(&dev_entry->list);
-}
-EXPORT_SYMBOL(abx500_remove_ops);
-
 int abx500_set_register_interruptible(struct device *dev, u8 bank, u8 reg,
 	u8 value)
 {
-- 
2.56.0.307.g5fe7bd680c-goog

