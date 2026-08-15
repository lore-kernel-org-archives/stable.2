Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C3042902F
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786817609; cv=none; b=PAfT/ZRFjkRuAZ0r6jTqWiiwF4imCX82eqoG7CjmodmZgFapu+2iRFkWr4Pfj8YXYG8thAe7Roaub9OhvpZzZ4mssrakzNjdhiPhMeN5ZW3MD1yxyzAEDzHfDbAmwgHvR3/xA7oVl2a59BaOJH2VS6Ia+CEdSx/wOq2ELvzmffE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786817609; c=relaxed/simple;
	bh=EiNqdaH18y3SuWINgOWAbB1gLMNQaalm9BnumdHTrvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQJSD5prquHsrTGM8EVKg/bd3GK/P81HrSIrdZ6dCzZu7i56wUyz2Bp5BctUJj34wk1ma70l4NrphV3NOtWIbTZm6ewQqiqv0vv+6g9gRHeXn8p+08bQOoSWNPrGH1Lryw/Lov/M2l9jIQehSPNfX1nAUUZMhENoRWXpCD6DovQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U956VqSC; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U956VqSC"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-ca80d708489so1110544a12.1
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 11:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786817607; x=1787422407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hOjD+7itBEHsMfKmr+ynGew/Kjw1CTU/4y0bM+1NDxI=;
        b=U956VqSCVddIPuvuS9ihnP5fYgKgUWzUx2e/4b16hOJYlhksMx0WmBxJhAGjZZXviq
         QjTgK3/Nxw7F7wpTrGXL1PToisBrFkCBV5XSFbpkaC3e/xdmqHTVaok8F9QBVQ0XlnE9
         EOjV3bSBlmWUb2byLb7dIIomDMua7yx0r9hoFHHA45DINEzyUKdHrXqwWYA3EGJslkxm
         FM9Tz3ceKPALHoIQpEdPi3tiWCPEpN0oV8q9vlcM1KvpR/b4GN7hfLMZc5yR9xoxztSd
         M8F7IUN979njEf7u6Buc1PtSNi/oiJrvEapevk/t7wPd79NdGNgJZYGHR1fUafvEbkVC
         IqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786817607; x=1787422407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hOjD+7itBEHsMfKmr+ynGew/Kjw1CTU/4y0bM+1NDxI=;
        b=m8NxFhnRNUQ5KZ5LDfcLrTi1dJbinMt32CI5iG1SXh2DftFYeqE8UFA1sd3f25oBrk
         x1TU44+2eAu186elfgVSE1w+vcZLPrdIHHNj4xWKGX84eLqlwtWjHQP+jGyR4nuxzBTL
         fh8S8Uf0qwdUIeD/qv5XEumIgKTY/WEdmEsrz1OA9iKIa1Hqcki+w9krLYENnMWr+NXQ
         eu3mtEHFspOj53RrLJWMr8Jkb1eaN2vOjiVNf8wh3pnL3dPx1Wc5m/OgkY+OT785asWg
         LXXSz/RmGOx9P8eKiPA2sLCuUJeIM8kfzMCiqKpyqanjUPMDObiE6tQNI2kAYqKeTib8
         q8WA==
X-Forwarded-Encrypted: i=1; AHgh+RrXJbXj8v6RFuEwKf8RffBVeZFJ6RaJvt5cQ2VNbYngRoT8CTKv9pj7U5BmKZxBgp7Fp1ppEMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuD7W9VsJozCIMAFN9HOFTxBdGwOGghG00cx6vIb4PtNoK2bu6
	LKF8qCRFqwQ7VwriBcAfWgIv+58R019ED+K7/oSZlK4ugLkj+4BRXUjW
X-Gm-Gg: AR+sD123jIxlxOlMsJvPOn5rqVEhnCGeV3X+i2+CrVopng25tsWJR+lvDApN9GFqRqa
	oMf6NL8gjVsmp8oyAv76ccm6vOZZgUnWMU3DTCGiqCffk6E1dtYpXxRl1xTxezq+Im2xh60onr0
	4Bp6A4cD23XD18PpE9/qBOY73u8xKVin2L/zC615pgl9O3bdTswyxpdat9MowZj2jAxDMrdHqh5
	ieaRzTB74m5J2CDhWFpWrfQRIR+GzXQcCdWMpcwoI4rd5Ow6Zxt7bTMwssTHVGZjit6OevV8W7T
	EUFJ1lT6xcFotl0iepiOyfnwjyBeqHeXUC0IqY6UlEkfxtfUmyQGgVauiNWd5e1TjziEMnqq/Gn
	8Juqhn6ArZhwjp7cXANdxRSbWUyE2XQlMmxZ1CXYilg3H/Z4OFLnX4yqkDHeHogQqO2Ml9GhmFZ
	8jtTT5lF8gVCFfCb3P+ABLw2QPfQXaAWl0zDTZ56s/GpbVRCQsgFRdAp35xVZysUzT9yVj60CX0
	uWl60LogrQ/FNn8eWOSiB3BqPo=
X-Received: by 2002:a17:90b:4ac6:b0:38f:1a29:7a82 with SMTP id 98e67ed59e1d1-3933afb387cmr9673131a91.6.1786817607293;
        Sat, 15 Aug 2026 11:13:27 -0700 (PDT)
Received: from localhost.localdomain ([240a:4280:4800:6ace:25e8:2607:e94d:caaf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394eb7539d3sm7304254a91.15.2026.08.15.11.13.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 15 Aug 2026 11:13:26 -0700 (PDT)
From: Liu Zhenlong <dragonliu2018@gmail.com>
To: andi.shyti@kernel.org,
	chris.packham@alliedtelesis.co.nz,
	jochen@scram.de,
	maddy@linux.ibm.com,
	vz@mleia.com,
	piotr.wojtaszczyk@timesys.com
Cc: mpe@ellerman.id.uk,
	npiggin@gmail.com,
	chleroy@kernel.org,
	grant.likely@secretlab.ca,
	neelegup@linux.vnet.ibm.com,
	benh@kernel.crashing.org,
	wsa@kernel.org,
	stigge@antcom.de,
	linux-i2c@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Liu Zhenlong <dragonliu2018@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 4/5] i2c: opal: fix device_node refcount leak in i2c_opal_probe/remove()
Date: Sun, 16 Aug 2026 02:12:03 +0800
Message-ID: <20260815181204.2321-5-dragonliu2018@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815181204.2321-1-dragonliu2018@gmail.com>
References: <20260815181204.2321-1-dragonliu2018@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i2c_opal_probe() calls of_node_get() to take an extra reference on the
platform device's of_node when assigning it to the adapter device, but
neither the probe error path nor i2c_opal_remove() drops it.

device_release() does not call of_node_put() and i2c_adapter_dev_release()
only completes a struct, so the extra reference is never released, leaking
the device_node on every probe failure and every adapter removal.

Add the matching of_node_put() to both paths.

In the probe error path, i2c_add_adapter() failure does not run
i2c_del_adapter(), so of_node_put(adapter->dev.of_node) is safe.

In i2c_opal_remove(), i2c_del_adapter() clears adap->dev with memset()
at the end (commit bd4bc3dbded9 ("i2c: Clear i2c_adapter.dev on adapter
removal")), which zeroes adap->dev.of_node before of_node_put() runs.
Cache the pointer before calling i2c_del_adapter(), the same approach
used in i2c-mux (i2c_mux_del_adapters) and mtd (commit 56570bdad5e3
("mtd: core: Fix refcount error in del_mtd_device()")).

Compile-tested with gcc-powerpc-linux-gnu on powernv defconfig; no
hardware available for runtime testing.

Fixes: 470834508f87 ("i2c: Driver to expose PowerNV platform i2c busses")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>
---
 drivers/i2c/busses/i2c-opal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-opal.c b/drivers/i2c/busses/i2c-opal.c
index c9b62892397a..43b3d17e933b 100644
--- a/drivers/i2c/busses/i2c-opal.c
+++ b/drivers/i2c/busses/i2c-opal.c
@@ -226,8 +226,10 @@ static int i2c_opal_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, adapter);
 	rc = i2c_add_adapter(adapter);
-	if (rc)
+	if (rc) {
 		dev_err(&pdev->dev, "Failed to register the i2c adapter\n");
+		of_node_put(adapter->dev.of_node);
+	}
 
 	return rc;
 }
@@ -235,8 +237,10 @@ static int i2c_opal_probe(struct platform_device *pdev)
 static void i2c_opal_remove(struct platform_device *pdev)
 {
 	struct i2c_adapter *adapter = platform_get_drvdata(pdev);
+	struct device_node *node = adapter->dev.of_node;
 
 	i2c_del_adapter(adapter);
+	of_node_put(node);
 }
 
 static const struct of_device_id i2c_opal_of_match[] = {
-- 
2.55.0

