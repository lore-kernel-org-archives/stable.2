Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D959942A788
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 18:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786817590; cv=none; b=Cldz1tyb1/SbfYwsEg3iGK8Xs6yU6wvmSa/cbDtT28x23NKFIQYejsvQzhTdZM7o04jGRi8FP+WtRHE+EUHDaTpk87Su1uXWgIeoBh6onbVpxxL/l5Giu/PbQIu1PRsV2XuoJAYP8GW1SR5iJ0UXS851n/di5MyJxqbe/5BGpdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786817590; c=relaxed/simple;
	bh=t3t7eK6kze1JhppxfIkpcARg5SYY1S80ibdnXdinBHg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTLCPe22htq1qRasEw/aRHwWHoDOwGS7FeIlR0M7Z/y2mtsCLUBZNDYPbo9XNpFBPewOLvX/HZBfpB1TbWePP+bdIfAV+B2cYYpiJ14ngNMAUMpwKERZr3UStUJaT+cR9XkKYACmeBwA/JClPVelsHUpbGtKBjKcD5cm4gD/Tq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ha73oWMX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ha73oWMX"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-381b831d535so3224642a91.0
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 11:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786817582; x=1787422382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i7/QgzN5wyVgDaVsVdjpFdimGVN0rJBMi0oSVa7MqkE=;
        b=Ha73oWMXcWU8QZFT0AT5zV4KcfoCPUdgWcozoJ7227IyIEcMOfy31xDO4GIG9/fHvk
         XOQrSpvi7EAdo3e5f0XI7VAbbyliI5+VdCp5Q2n/ZYp5lgdK554l3rWSuHjA9PXnsdRJ
         d2Wpzn0w17Kh37BYlLAiMNNvTnjOd7lImPYE2su7mzPs8YJTn/NEzoiK+haGiKCeqTfv
         mkOFXzrBudRr5RgZmAfn3LJHcpOZ/B1kHXdXUSdvuzq6lsQFwkOBB+dodLbxpjSDXoaY
         BvQ6bmeXUY5bMe3dzUZffdzfbueXlhVAwlLeo0cjgx273vHwisLi0Edi3eAwe8+YQ9vt
         AMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786817582; x=1787422382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i7/QgzN5wyVgDaVsVdjpFdimGVN0rJBMi0oSVa7MqkE=;
        b=P99JzTTv0DWZIFWcUdzoM1iE3pKO2pLtxdg2RHRGDBmNm+fu/WPECiI3eae8+tvzRb
         I5ld89K0BfASGlBpvs4bOc9KRAruM31CMVKfmr3wTqwxwJ3SzsjVK2S1bN0qLdm5vJ/i
         wSLLVbIBI46iiRNhphIf7sGWbDG7aCp2ndaselGn7vTJQDVxcwvF4Nyp5fhGhK33+83H
         M1cB55s0ePALP4WzesvGx2z3Yj4VN4WIDw6pdQ7s6EKM0N/Zpob9TgBMNd1neKIY954w
         cFGTVjxFas5E02fCMqpRSRRwKUXIyW0Rg8hRdLEX9dbXvEo9p2dyEuCooJfIj3U/i6h1
         OMUQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr5Qv2YPVSf4LIB0inXPmrzeIjudCXPdqnyQuKo/US+A/pxWF2DES/3BKkECzFUbx50/0b9GoY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHuHUYlF0GLHoINdti+z6JORzk1LAx9IwdhbWjh4vNj81fn1Hv
	NlPn+RX6kEyMzGy/C+Wuh+yE4bGV5vozrEfw7t/pzkHzjBkmiC3SFzWg
X-Gm-Gg: AR+sD12HWcZm0nfIF/j2PD0KW/qqobDfCJfORyKCxpYbKh83n017iJsZezZwIcADSCh
	0XP0DMFOH3OKrh9m4p3E68fZUdPq0pTa91cxSIldd1oKYLJazyzNxwpthjCT3qSL3s0VDV8Lv0i
	HsZVKd8xbH1yJzPYk0M/dURCBwKNIA8YOtcbeNBNGU3LokVD199Q74K2KI3SdVe6JptOqE1oWwe
	XfNLvKgvAaW2jKB9qxN1xOYDL0ybrgpYiiYG4SQr+Wera8JWnpiH1I/1571wSF9JDm/rYP7VPSQ
	qc0LNSxOcVZj/cmBpxHy9LChDzgPrCc3I7WRsJuwm6gJMAGO1ehICfn41CvTgN4ahTW/Wv9KVqH
	8+VKtuEnN2+kDgzgkrZiTJXVkSvHScihOd7MKrQYM/jxUebcOfnVj0T1AcRcsfglNWxy8V6EjN5
	NnPzXLE2MJpYWr46UaaFZ4AGIWI5MorgCtcWPagIX7WOxGIq5yH0tVKooofVNbWCkBCBIN2qvKR
	2hc55P7TlraTo93JZ5ZbWTaBP4=
X-Received: by 2002:a17:90b:2747:b0:38e:2f21:3bb5 with SMTP id 98e67ed59e1d1-3933baa0da9mr17205808a91.21.1786817581938;
        Sat, 15 Aug 2026 11:13:01 -0700 (PDT)
Received: from localhost.localdomain ([240a:4280:4800:6ace:25e8:2607:e94d:caaf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394eb7539d3sm7304254a91.15.2026.08.15.11.12.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 15 Aug 2026 11:13:01 -0700 (PDT)
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
Subject: [PATCH 2/5] i2c: cpm: fix device_node refcount leak in cpm_i2c_probe()/cpm_i2c_remove()
Date: Sun, 16 Aug 2026 02:12:01 +0800
Message-ID: <20260815181204.2321-3-dragonliu2018@gmail.com>
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

cpm_i2c_probe() calls of_node_get() to take an extra reference on the
platform device's of_node when assigning it to the adapter device, but
neither the probe error paths nor cpm_i2c_remove() drops it.

device_release() does not call of_node_put() and i2c_adapter_dev_release()
only completes a struct, so the extra reference is never released, leaking
the device_node on every probe failure and every adapter removal.

Add the matching of_node_put() to the probe error cleanup (out_free, which
covers both the cpm_i2c_setup() and i2c_add_numbered_adapter() failure
paths, neither of which runs i2c_del_adapter()) and to cpm_i2c_remove().

In cpm_i2c_remove(), i2c_del_adapter() clears adap->dev with memset() at
the end (commit bd4bc3dbded9 ("i2c: Clear i2c_adapter.dev on adapter
removal")), which zeroes adap->dev.of_node before of_node_put() runs.
Cache the pointer before calling i2c_del_adapter(), the same approach
used in i2c-mux (i2c_mux_del_adapters) and mtd (commit 56570bdad5e3
("mtd: core: Fix refcount error in del_mtd_device()")).

Compile-tested with gcc-powerpc-linux-gnu on tqm8xx defconfig; no
hardware available for runtime testing.

Fixes: 9fd049927ccb ("of/i2c: Generalize OF support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>
---
 drivers/i2c/busses/i2c-cpm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index 2cb6a233d313..08e33db32f14 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -671,6 +671,7 @@ static int cpm_i2c_probe(struct platform_device *ofdev)
 out_shut:
 	cpm_i2c_shutdown(cpm);
 out_free:
+	of_node_put(cpm->adap.dev.of_node);
 	kfree(cpm);
 
 	return result;
@@ -679,9 +680,11 @@ static int cpm_i2c_probe(struct platform_device *ofdev)
 static void cpm_i2c_remove(struct platform_device *ofdev)
 {
 	struct cpm_i2c *cpm = platform_get_drvdata(ofdev);
+	struct device_node *node = cpm->adap.dev.of_node;
 
 	i2c_del_adapter(&cpm->adap);
 
+	of_node_put(node);
 	cpm_i2c_shutdown(cpm);
 
 	kfree(cpm);
-- 
2.55.0

