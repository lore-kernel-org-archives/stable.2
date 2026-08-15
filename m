Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4A8427FA9
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786817624; cv=none; b=m4RN2mqKmYmUFSHjgy6iK5wkXj29ye38AG6hq4BqLQsAgLv7nESSNADWpapuSMVXkc4bflFibRXlvsKkljfD5aDn6NhNfJ7GVJjC+4LFbpEAnq5PwKFXB9tljshURQgXaeHBcm3zuzw2l2HmqERwG3XmOQEoe5Oj2auMw/VB+Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786817624; c=relaxed/simple;
	bh=96dNgm0w4p4mneCX3nrwNYF339ix1yCXiaxbeFg7LcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FIXU4OWqwEbAzr7Vq8/C4IhQxi68Vb0wq6yV+0RKkENasHXzwd06gpvxbeMthtxok2X5DUwmF23+8JWWcU61VPD9x+VBsYwW+zaQOFP2JlKRQrUlZIsa8P4rC0NMaPxuYELsSOW5wz34DVEcKrIqys0IqNd7bv7ex3zFa7tYEww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5Dm7D1n; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5Dm7D1n"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e041ea211so2191842a91.0
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 11:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786817618; x=1787422418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V91oZrI/zJYRrYjWs8UIHznDrCj9rfvAd4MAMUD9J1o=;
        b=E5Dm7D1nARdS9er69ZSJ4AAyLGbJn9O7qLI/uWJbMzmtQI65ZO4b9ZCZEt5QIxM3Yu
         pBlz7zT6eJQlthO7zulBqLLIS2YE6CAonHY3Q/VKHHjZXOfbhpYwJ0JjueAREWLhkayO
         jgIOFD6Uj49c2A3igYNX6lBIHruwCo8EdtcJD7zIKeioIp4Mv8UmRS1vW9zV5CROUOE0
         /hhjzN5SYqY7xgaTgx3qlZPFPVSSle2Up/JjBKd0nPbo+/8ruPsSUpmmsLMvr9fK1ZzX
         DFoeRrWQsZzKY4HOwvo11MH1igz5KCe3BnvoPMmPLykop1BFeLVbcIv62rfzULxVsLBi
         6wjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786817618; x=1787422418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=V91oZrI/zJYRrYjWs8UIHznDrCj9rfvAd4MAMUD9J1o=;
        b=nwouZh6bSR+kPhAQXJXUqoO9r/zaKj953Z+loJfaJXhsxAZdZ0WAIWxCJSlg64f/26
         eRjH4y2CTXGU4EmiNwbVe2I3s8MRek9VjOAlCAcCiaqZqcDtZeWbl+MrOplPFDXM9eXe
         aLYeu0vUZNuZxFVuqFuEFc4R/AfduuGHUt6u/vrQtlpwgBv1tZyLE6u6SJBAoD5gAKIt
         nrIpaHhPMmABPX79aq8gAo7FHLw5l1AfbCnVvergnrNYawwSC0qrdP0JKf35dB0FHUT0
         AP1k8ud8DuKYiZTaMIXY4YikQiSKGTk65XZszuiOTg2oEnnPX5m4354nIQkET4Qdgwoo
         wFag==
X-Forwarded-Encrypted: i=1; AHgh+Rr2E6ex55Qy7lH52fd7r3BNf57td7dJqIOaN6FytV2VPGfT5IeSj/VR8A4K0lp6loy8Wc4B3tk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQkJy8T2LCgQXKrPKu5QE6V++qOmzAkymst6u1Ac81TEWGpcr+
	vtBT+GpBA6A1IaLDqh4YBvxgtZEJVzP1o8NR7NgfVNGOlPjfPnbrv/jA
X-Gm-Gg: AR+sD13svuoVhUBJYt12d+nhmZ3S52kAAyThFD4aCvMr1Vz8BPrg99cq4ymHkJsta07
	Glm5XcTw9REHQQ48nG2NIZbHaulEz4PXCgzsBc1ya/8vbkAfc2IwOshMKe1dUNT86H1k3/Zk+I1
	XQ4sWSRHQezvN1UFwQj9/JhrCkel/LxNeE6/NrrOQ0sTv8CTUGVw5xM/KRzUWEIHhlQMa3JmNyQ
	tLFXCjkoGiAav4g1Vzm+nEFlzCyiwsWNS6uppoVl2NhdjsRrGc/npG/+C0ykcdkg3/VPMJGrt8M
	arvPVWyoADbkQPIkBo6g2u+do7mFKc/TcaryCaa7xtF1Uz/g4ynZhxI7X/Wa8GG+hrNa23D15WE
	CKEl2tSIdKCHkebYrnbM130+ctH/CS1FSVqZ32kGTKYA2obg1Bky/qUPob+WD7bmXEeDW9WHZ7U
	CswKvaIfvcSrmoXuI9Uy9RcL0jbViN4C+g/azWTOHALjsheNJS+6J57BKJ9xD0OoQtWa/sFgNZs
	ghN6akDHE7l+DIrWwTsVQfOk4c=
X-Received: by 2002:a17:90b:1b05:b0:380:873:49cb with SMTP id 98e67ed59e1d1-3933baa0d6amr14788639a91.21.1786817618461;
        Sat, 15 Aug 2026 11:13:38 -0700 (PDT)
Received: from localhost.localdomain ([240a:4280:4800:6ace:25e8:2607:e94d:caaf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394eb7539d3sm7304254a91.15.2026.08.15.11.13.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 15 Aug 2026 11:13:36 -0700 (PDT)
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
Subject: [PATCH 5/5] i2c: pnx: fix device_node refcount leak in i2c_pnx_probe()/i2c_pnx_remove()
Date: Sun, 16 Aug 2026 02:12:04 +0800
Message-ID: <20260815181204.2321-6-dragonliu2018@gmail.com>
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

i2c_pnx_probe() calls of_node_get() to take an extra reference on the
platform device's of_node when assigning it to the adapter device, but
none of the probe error paths nor i2c_pnx_remove() drops it.

device_release() does not call of_node_put() and i2c_adapter_dev_release()
only completes a struct, so the extra reference is never released, leaking
the device_node on every probe failure and every adapter removal.

Add the matching of_node_put() to all probe error paths (the three early
return paths before clk_prepare_enable(), and the out_clock label which
covers the wait_reset(), platform_get_irq(), devm_request_irq() and
i2c_add_numbered_adapter() failure paths; dev is devm_kzalloc'ed so
adapter.dev.of_node is NULL and of_node_put() is a no-op when CONFIG_OF
is not set) and to i2c_pnx_remove().

In i2c_pnx_remove(), i2c_del_adapter() clears adap->dev with memset()
at the end (commit bd4bc3dbded9 ("i2c: Clear i2c_adapter.dev on adapter
removal")), which zeroes adap->dev.of_node before of_node_put() runs.
Cache the pointer before calling i2c_del_adapter(), the same approach
used in i2c-mux (i2c_mux_del_adapters) and mtd (commit 56570bdad5e3
("mtd: core: Fix refcount error in del_mtd_device()")).

Compile-tested with gcc on arm64 defconfig using COMPILE_TEST; no
hardware available for runtime testing.

Fixes: b41a216dafe4 ("i2c: Add device tree support to i2c-pnx.c")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Liu Zhenlong <dragonliu2018@gmail.com>
---
 drivers/i2c/busses/i2c-pnx.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
index 8daa0008bd05..0b6c144d9a21 100644
--- a/drivers/i2c/busses/i2c-pnx.c
+++ b/drivers/i2c/busses/i2c-pnx.c
@@ -644,20 +644,26 @@ static int i2c_pnx_probe(struct platform_device *pdev)
 	}
 #endif
 	alg_data->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(alg_data->clk))
+	if (IS_ERR(alg_data->clk)) {
+		of_node_put(alg_data->adapter.dev.of_node);
 		return PTR_ERR(alg_data->clk);
+	}
 
 	snprintf(alg_data->adapter.name, sizeof(alg_data->adapter.name),
 		 "%s", pdev->name);
 
 	/* Register I/O resource */
 	alg_data->ioaddr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(alg_data->ioaddr))
+	if (IS_ERR(alg_data->ioaddr)) {
+		of_node_put(alg_data->adapter.dev.of_node);
 		return PTR_ERR(alg_data->ioaddr);
+	}
 
 	ret = clk_prepare_enable(alg_data->clk);
-	if (ret)
+	if (ret) {
+		of_node_put(alg_data->adapter.dev.of_node);
 		return ret;
+	}
 
 	freq = clk_get_rate(alg_data->clk);
 
@@ -707,14 +713,17 @@ static int i2c_pnx_probe(struct platform_device *pdev)
 
 out_clock:
 	clk_disable_unprepare(alg_data->clk);
+	of_node_put(alg_data->adapter.dev.of_node);
 	return ret;
 }
 
 static void i2c_pnx_remove(struct platform_device *pdev)
 {
 	struct i2c_pnx_algo_data *alg_data = platform_get_drvdata(pdev);
+	struct device_node *node = alg_data->adapter.dev.of_node;
 
 	i2c_del_adapter(&alg_data->adapter);
+	of_node_put(node);
 	clk_disable_unprepare(alg_data->clk);
 }
 
-- 
2.55.0

