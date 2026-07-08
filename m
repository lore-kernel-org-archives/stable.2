Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382BC44D021
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783514261; cv=none; b=ZrsNIREOeX5baayFwMI5zDXKs5VAE2iVfedSJcBwtHD+G9KfEZx4+8itXYz2afu3RL8+/iC39UWRm5n7NoAcLMRUOjcIA4T1XX2+XMZbv4vbJzU2h0XIp792A0Mw+4S9Apgd3yhrHlmdcAZ8NJd9ldTo1iMJz0FDzrFL3xg49tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783514261; c=relaxed/simple;
	bh=TY4aCopFbN3dYhQmkdEiXOewerjmzHG8UUy9gUxqM/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJcyoZH1NGe6ike8JxnGkh3rhc6nVdArJYykgsxGZSTM3ZlvTADUr9uhlPRbmt7ZhTM+FxFeRp0k3mUN6m6uRhIB0SC9gQlv7KN+VRKSJfL/j0uSU5xC1nObeXSEiAfnn1WttnD9WRbcg4tWanKgencZkJJQNZG7EaA0QALiZ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfnJ9r26; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfnJ9r26"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c9d1fc053e0so448401a12.1
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 05:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783514258; x=1784119058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m2NCGWcB63pGFQ2fmc+yu9xWhLG7x52oZf2ocF8l0Sg=;
        b=HfnJ9r26VJ8gaIMhf7uOQ8PK+JrPFA+v8ZCEYRbT6d/oj1DRfadhl8puYbayvibIC7
         d5AvgUmlRFq+F+eXkChdXwTnt3SnkTZeNCEJkUzz/dUiJ5tzWPKzA/z3AoBB/oSfV+4o
         Frpqroa5+70UACQmamXVd0YYA6AxdyHf9HNUvM/sIQdiCJ6a11wDLtAuVs4CaEssZiZ3
         bsh4/tQY88/981ilxcHjIQiJfgjFasa5l0UZ3Tvcugw9+yOyhMqYVMrlec5Xq2q2h3XI
         HG4r281GZZmCmfyG2HTKBR9GUCj/cbMR0ii4ARJtTzmAH+Dy6lZv/mTIrB3H4ncU0s2j
         GN2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783514258; x=1784119058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m2NCGWcB63pGFQ2fmc+yu9xWhLG7x52oZf2ocF8l0Sg=;
        b=dWZ4cSxER9xrTJQ+aiqQl7boDB5iaZCl0oP9cXnQ2m6wv4eVTy3KbHrzddq9dbnwJd
         vPtD+bycftnr+FCzeK+315MZsDk6N4NrvAFSFXpWJD7/x6wMp8mRYrQKOSsBkQ3H7lbE
         +6+qII7kT+KCdRrWJKmJoocQ4PZlOAhgDQII0NxBMD4HFz5yBGQxMdOT1ai+TjUPpUeh
         fMD6tD5tM8XdcmjsSXK8pJDSK5Xs0sw3FqewHaDr5wZEO4PpKkVnOCUw1wI6jbf6GnIW
         FNna5pHrF9DzYUWTmyduKcht2sK5dve59sSV91O9KbU7RYpPPkSrDHy9Y+/UrBQvr0G6
         Ud+w==
X-Forwarded-Encrypted: i=1; AHgh+RqYD4M0Zatg4GIgw2WjBSvZdRdBM2yI2TMQ7INYDbLPxQOw7GjZauHHc29LdO8d8jLZWKpn6mE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxmu5uo7RgR28H+6Ac3KaCZceaZmhF5cu4UB+UYa02ilLppyze
	ui/8n82NyBgmEwssfLJFryPmmosfX9iY5gQB0XFlDiDcWY9SGBgfOOfYewK1XD0l
X-Gm-Gg: AfdE7clqV/0f8QMmIaPTiQQnRX4NnhLloH1ssHruGBTYSYsjab9q/FfNQZlVOIPPHyZ
	CYjLC7dvLHwLA281O8Kgk2wYkbEE9GZqvEzwiqW30TXMHh5feKp7xj1K9ajGHQJ3mx5M5Gya3vz
	2swb1aHn7VaG9emBDzmHfYfWOP7grLrPYDynthfCPEQE+vl9hIo2obOjk2nUPmsa3U7uPm1tbvS
	NuFWTeyHN9FJu98wwSeeuPOJEQ+sCm69xd/Ki5RNYTO9xg5bxT5nMwwdSO/NZf0JXshpF32SqVW
	ulVXGIpV8lyBi77lvqFw0O7+0sIY7PTP1vA+Fid4TG1fkl/nBBUs22ILfN0NKURy7SWtgoH3sJi
	PUUxu2ckb/se53WEBcUjshZZ1R0HSuBfl0wa6J1FNgpyvggtc6ovK5DdEMwPZEC4uYlMXJIxnJH
	HmWtN5LXQ/WteX7oHRjCNt/Bsz1lGtzUFhe7gWUnKDuQk=
X-Received: by 2002:a05:6a20:2d06:b0:3bf:6c08:2844 with SMTP id adf61e73a8af0-3c0bd252e38mr3247489637.51.1783514258356;
        Wed, 08 Jul 2026 05:37:38 -0700 (PDT)
Received: from localhost.localdomain ([49.207.223.101])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174a92eccsm18701979eec.23.2026.07.08.05.37.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Jul 2026 05:37:37 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: laurent.pinchart@ideasonboard.com,
	sakari.ailus@linux.intel.com,
	mchehab@kernel.org,
	hverkuil@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Biren Pandya <birenpandya@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] media: i2c: mt9p031: fix endpoint parsing use-after-free
Date: Wed,  8 Jul 2026 18:07:25 +0530
Message-ID: <20260708123724.26707-2-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260613084849.57897-1-birenpandya@gmail.com>
References: <20260613084849.57897-1-birenpandya@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mt9p031_parse_properties() function calls fwnode_handle_put(np)
immediately after parsing the endpoint. However, it subsequently reads
the 'input-clock-frequency' and 'pixel-clock-frequency' properties
using the same 'np' handle, leading to a use-after-free.

Fix the use-after-free by reordering the property reads to occur before
the endpoint is parsed and freed. Additionally, utilize the
__free(fwnode_handle) scoped guard to automate the endpoint's lifecycle
management, preventing future leaks and simplifying the error paths.

Fixes: 8f2da25e85c1 ("media: i2c: mt9p031: Switch from OF to fwnode API")
Cc: stable@vger.kernel.org
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
---
 v2: reworded as the UAF fix it is; added Fixes/Cc stable; moved property reads before parse (Sakari); adopted __free (Laurent).
---
 drivers/media/i2c/mt9p031.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/media/i2c/mt9p031.c b/drivers/media/i2c/mt9p031.c
index d21510caf45a8..4dcb6c973ef1c 100644
--- a/drivers/media/i2c/mt9p031.c
+++ b/drivers/media/i2c/mt9p031.c
@@ -9,6 +9,7 @@
  * Based on the MT9V032 driver and Bastian Hecht's code.
  */
 
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -1067,23 +1068,22 @@ static int mt9p031_parse_properties(struct mt9p031 *mt9p031, struct device *dev)
 	struct v4l2_fwnode_endpoint endpoint = {
 		.bus_type = V4L2_MBUS_PARALLEL
 	};
-	struct fwnode_handle *np;
 	int ret;
 
-	np = fwnode_graph_get_next_endpoint(dev_fwnode(dev), NULL);
+	struct fwnode_handle *np __free(fwnode_handle) =
+		fwnode_graph_get_next_endpoint(dev_fwnode(dev), NULL);
 	if (!np)
 		return dev_err_probe(dev, -EINVAL, "endpoint node not found\n");
 
-	ret = v4l2_fwnode_endpoint_parse(np, &endpoint);
-	fwnode_handle_put(np);
-	if (ret)
-		return dev_err_probe(dev, -EINVAL, "could not parse endpoint\n");
-
 	fwnode_property_read_u32(np, "input-clock-frequency",
 				 &mt9p031->ext_freq);
 	fwnode_property_read_u32(np, "pixel-clock-frequency",
 				 &mt9p031->target_freq);
 
+	ret = v4l2_fwnode_endpoint_parse(np, &endpoint);
+	if (ret)
+		return dev_err_probe(dev, -EINVAL, "could not parse endpoint\n");
+
 	mt9p031->pixclk_pol = !!(endpoint.bus.parallel.flags &
 				 V4L2_MBUS_PCLK_SAMPLE_RISING);
 
-- 
2.50.1 (Apple Git-155)

