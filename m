Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606241;
	b=eIDql3EuciBIgIUKMhAqfEWpmBm0ion7pAGhSkDSumncnEoAPWcp1Di1fpz8I87K9ijn
	 ElJUBWy2bhDijkvL7b0YTUFvwEtaJC+6zq6N5NlJNjq0XbLb8MIlFS8eDLVZHSe4iKwWz
	 8mhGABpb2QQ83cT0uqj/+q93WjN/tcoOOfyn2xTbECroWDO8f1fCcN5JSReUSmaY3Qa3I
	 oqMY5I9gVsDjWmN8V1D8+x2qGGVl4I6ZtsvYZSYJxK/WSCzRbfKWyu0de+ljddyubygLa
	 qJOlqqfQodlXwsf7MBIRLb9w9exeFc3V1O/gpf67uWDHdBViWlw937Q5INlQKVgABog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606241;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5c8E46H9D8n1iz1NiuFP9wVSIjo8xwMshDoKle/plSc=;
	b=FRwPxoTf7hn53rTLL8V194eYyhyvZIhoxIYXp0L7qtTHjYJak35G7LEgnlKHFqA0Yqn+
	 w9YIYPU2oOP448pW487bLPiplQSK2bJfXW2rme8x3xkeXY3Zto4o+ty8HDoVtECk46McG
	 PnEfB2FUQ8uAd5KRO2Jzi3ughYZMgvLfwgAXrysd5MP2yjZ1Fu8wn+0QM/EX0ZCEoUefV
	 eg4fPUBXu9VO04/pEoF6XyEVgVYM+laNY+gHr/VQJFW5NWY9q7NawiDI4cgguprXew3qK
	 BH/Ljk3RnBfz5O7QsvCw/P0ijWUEV52nya5PCzYkxUqrUHNtvq3M0qk4sR9CwL7lI8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PDdzpWtG;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568C9606A32D
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 07:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 568C9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PDdzpWtG
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ac6794fe45so1947560a91.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 23:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793606241; x=1794211041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5c8E46H9D8n1iz1NiuFP9wVSIjo8xwMshDoKle/plSc=;
        b=PDdzpWtGMOwoOLfrPO8sDsEm8c1q5TKZxZsfhrFyo/wZpemg/P6zlhmZzFUPk79JHV
         3oBL1ytEl1/IWa8+Bn8VeSqcZxIVkdHNCFAMI/ucugnIZucZrmBBuaJuTpXHcc9a8hKo
         WSmfZu8PFRQeafdtChAIr9j0wOBnqCS2dIjTEt7sS5ZKdGpCyIivbLWgq+h+FGZ5v8cY
         YSs79YBlKK2gglW313UAlFcNmovMailRncuC7HQVR2C5Y0beO1LvMO5Ho1MrP1kcyx4P
         tOTtulTapMN97YlVnz5cKUawd1meRglO964+tIlZHUdHA71Ny8JjhkZM3B6n0jbZcpuk
         dZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793606241; x=1794211041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5c8E46H9D8n1iz1NiuFP9wVSIjo8xwMshDoKle/plSc=;
        b=f48bbkcY5koqPr9Dkzj/ZT/qQbNVoTPWvqpov7iZg1/QaEoxL73swL3Yzaa2/rMbYy
         NjYPRGz4ghOz/mF/cFgkETUxsIgJB5tZtSn8BLVFNNjaECRpqFnHQ4gE0/iK8J3pEy/o
         4c0mT3cVC6MHBD4ELZQoJQYqclFUu6um5SG5IXoJrHP+nDGRlptMwGqGX93WgnYsTlbQ
         10xwxMsKm4U0uymIhAN7b9RDhWv7PyyvsGiYburJGXTHrVGxX/VSiR/F6jyxgtfm9GtO
         8Vi0hLkiYbZPm2CWjDTsEGl2151ZcRtcreziytuZLpl8KRfSvDGelAi+34cz/kH8K06D
         6vzg==
X-Forwarded-Encrypted: i=1; AKwUvBx9OsNT2NV6mpHCvlY/OAZNocRQb/8t7qfcx+7Ju+0iP1kGIJHsNhT89Wm/FRL+QBgaVBnJMCQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+FuWjs2iybiuW8J4UUOMY3HWzXbnDEXb4CKlJamOiuMZqjoNve
	/E8gumZx5/ystXOPbvfzH61LKBJs3zu1opQZFzh7fIatDB3BZorV0gMh
X-Gm-Gg: AYBFou0fhVxXTmm5TanbqtyEvtSMdKt7M3+hJDnrIQqXlMT8iIP/Hyd5IE/z8qGEevq
	wZl98ZWHrs/zbVCG1UIYSxBap0cvRRbq4+MaFSBHfDu/cHHnIINBLMjA1Tz5ZW5BFXqLciY1Lc0
	lGbgmVLOf/fkQA3ZuiAAHMarEIhddSLgZ4MlMFCZMDVYXIbP+PYyd5K1NDo9gox3hQTVtd4mmko
	kWrFqZfjr6VFEzOlj61kYO5pSofN7Ps16dWieCq00Q9B1le35I6lU2uXzc1agll68/8AZ9WJPq0
	rNUfH3NPDTn4PRscLRjPzhPo/snJYBZKlWBmktu/3voGe2woPgjtoQ4zJ+aHMzwiD3rJsJU1RUn
	3IdIO102m/G/ehYUWQRBeL7vaESxZLx4/DZit0xj1wCJiua+zAy8+jdL/A2ZB3RV2blSBo13QIn
	h+aTLg0ivt9oX5jkWt7RISFPulapldZuwAz3nZf8m/j/YC0u0lsAcyoSmUgfKrvf1+HEvu6nIv3
	HhXbelpvJe4VDvKG4f3xYZ3dFIkFX+Vqa9RHyHjaL8U7A697XFzBjcTB62s0Wwdz2mK98dJgwN+
	Lit/2c+8m0c6wJJz6mpvImpFktrzDuwXAHAxgccOHLUT8f81LQU43NpzBM74mB6/NhrhRNlNfdT
	Lk4uPUJsBIqNI4Lnk0rr1PALQ3ORTnoMaqin5y9QBBTRxOeqTMSjfy/AWaNHG/Jpn4LLD6ZEbj9
	gtbSY=
X-Received: by 2002:a17:90b:4b90:b0:3a4:7730:33dd with SMTP id 98e67ed59e1d1-3ae8984b662mr7868096a91.58.1793606240670;
        Sun, 01 Nov 2026 23:57:20 -0800 (PST)
Received: from EAIT-H54D9Q2FJQ.eait.uq.edu.au ([130.102.10.191])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9583c1sm18649416a91.10.2026.11.01.23.57.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 01 Nov 2026 23:57:20 -0800 (PST)
From: Yu Zhang <yuz08559@gmail.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] gpio: virtuser: remove the debugfs files before freeing the line data
Date: Mon,  2 Nov 2026 17:57:07 +1000
Message-ID: <20261102075707.41742-1-yuz08559@gmail.com>
X-Mailer: git-send-email 2.55.0
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

gpio_virtuser_probe() registers the devm action that removes the debugfs
directory before it allocates the per-line and per-array data that the
debugfs files point to. devres releases resources in reverse order, so
on unbind the line data is freed, the consumer_lock mutex is destroyed
and the GPIO descriptors are put first, and the debugfs files are only
removed afterwards.

A read or write of any of the per-line debugfs files (value, direction,
consumer, interrupts, ...) that runs in that window dereferences the
freed data. debugfs_remove_recursive() waits for in-flight file
operations, but by then the data has already been freed.

Running eight threads that read the per-line debugfs files while
another task writes 1 and 0 to the configfs "live" attribute triggers
this within a second on a KASAN kernel, with gpio-sim as the provider:

  BUG: KASAN: slab-use-after-free in gpio_virtuser_value_get+0x19/0x60
  Read of size 8 at addr ffff888005109e38 by task vu_race/3479
  Call Trace:
   gpio_virtuser_value_get+0x19/0x60
   simple_attr_read+0x109/0x290
   debugfs_attr_read+0x5e/0x80
   full_proxy_read+0xae/0xe0
   vfs_read+0x1bc/0x7a0
  Allocated by task 1:
   devm_kmalloc+0x89/0x1d0
   gpio_virtuser_probe+0x56f/0x910
  Freed by task 1:
   kfree+0x196/0x430
   release_nodes+0x77/0xa0
   devres_release_all+0xf3/0x150
   device_unbind_cleanup+0x18/0x130
   ...
   platform_device_unregister+0x3c/0x50
   gpio_virtuser_device_deactivate+0x3c/0xc0

The same run also reports use-after-free on the freed consumer_lock
from the consumer attribute.

Register the debugfs removal action after the line data has been set
up, so that it runs first on unbind, and remove the directory by hand
on the probe error paths before that point.

Fixes: 91581c4b3f29 ("gpio: virtuser: new virtual testing driver for the GPIO API")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhang <yuz08559@gmail.com>
---
 drivers/gpio/gpio-virtuser.c | 46 +++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpio-virtuser.c b/drivers/gpio/gpio-virtuser.c
index 70ddccc..03fa951 100644
--- a/drivers/gpio/gpio-virtuser.c
+++ b/drivers/gpio/gpio-virtuser.c
@@ -927,38 +927,50 @@ static int gpio_virtuser_probe(struct platform_device *pdev)
 				     "Failed to get the IDs of GPIOs to request\n");
 
 	dbgfs_entry = debugfs_create_dir(dev_name(dev), gpio_virtuser_dbg_root);
-	ret = devm_add_action_or_reset(dev, gpio_virtuser_debugfs_remove,
-				       dbgfs_entry);
-	if (ret)
-		return ret;
 
 	for (i = 0; i < num_ids; i++) {
 		descs = devm_gpiod_get_array(dev, ids[i], GPIOD_ASIS);
-		if (IS_ERR(descs))
-			return dev_err_probe(dev, PTR_ERR(descs),
-					     "Failed to request the '%s' GPIOs\n",
-					     ids[i]);
+		if (IS_ERR(descs)) {
+			ret = dev_err_probe(dev, PTR_ERR(descs),
+					    "Failed to request the '%s' GPIOs\n",
+					    ids[i]);
+			goto err_remove_debugfs;
+		}
 
 		ret = gpio_virtuser_dbgfs_init_line_array_attrs(dev, descs,
 								ids[i],
 								dbgfs_entry);
-		if (ret)
-			return dev_err_probe(dev, ret,
-					     "Failed to setup the debugfs array interface for the '%s' GPIOs\n",
-					     ids[i]);
+		if (ret) {
+			dev_err_probe(dev, ret,
+				      "Failed to setup the debugfs array interface for the '%s' GPIOs\n",
+				      ids[i]);
+			goto err_remove_debugfs;
+		}
 
 		for (j = 0; j < descs->ndescs; j++) {
 			ret = gpio_virtuser_dbgfs_init_line_attrs(dev,
 							descs->desc[j], ids[i],
 							j, dbgfs_entry);
-			if (ret)
-				return dev_err_probe(dev, ret,
-						     "Failed to setup the debugfs line interface for the '%s' GPIOs\n",
-						     ids[i]);
+			if (ret) {
+				dev_err_probe(dev, ret,
+					      "Failed to setup the debugfs line interface for the '%s' GPIOs\n",
+					      ids[i]);
+				goto err_remove_debugfs;
+			}
 		}
 	}
 
-	return 0;
+	/*
+	 * The debugfs files point to the devres-managed line data allocated
+	 * above. Register the removal last so that it runs first on unbind,
+	 * before any of that data is released.
+	 */
+	return devm_add_action_or_reset(dev, gpio_virtuser_debugfs_remove,
+					dbgfs_entry);
+
+err_remove_debugfs:
+	debugfs_remove_recursive(dbgfs_entry);
+	return ret;
 }
 
 static const struct of_device_id gpio_virtuser_of_match[] = {
-- 
2.43.0

