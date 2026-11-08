Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794172606;
	b=4kyZayiTtXKJ3UQKm5+9HTcdguh/0qXlFOQYM1tMpnijy9eSvyPXJh+SudXGAVt0FMtl
	 GUuYDw7lLV0IS6Uh0eb6UkkHqgNOXVRnxRsZRB5KyCk+pceXtc2F76oyohKEmPFM5BBqB
	 3Ibya6EqIpOfAfZg536xGFyECeiSPFlN+CuHhzZNpbLtuYKJk7a4MbPe2MwqU6qdVpWzC
	 3l7bXH8JGJ4cnI+hHCL5/cQk8KC/6Hgsxkhnmd8V9nYq2gd2XV2+huGMNngVZV1vukhcJ
	 h6RY2ZuARcPrbc2M1tCWfS1sX45A7Fn7DYm/8mYEGXBNnbUju4kGtbYfj6yJzvdg/zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794172606;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=BTsIQ3GHuwszTciCCDtrpxdJaKcQmTY5JV7uV9WKwZk=;
	b=VvV+lBI3THK+KYQs8sC1e7o9kbT0ucb+R0BcKRNHd+wyRG7q0utqPhYVE+71R2MT9LV8
	 B+YueAfaYiDqFeByk0PTnQ0LlH9aQQzGfcGD9soNIXdx6qjJuGxE7xevDgPxD1y3vWI9U
	 sGRN5Chy8bhsH6Ic8isw0Q49VXJQUywk4lSH9uqo90WeNfAmT0AmVVjyg+uSqWQFl2QBf
	 1nnFbrpur14nqzpmx+IM0eoLG1J8advmib+4aCaKXGHjrf+wqJecwcnGoV0xh0jK2MH8N
	 F9jRYaQkLeLFvfcefWeIqXK4IQuDzXDjr4SnQOc754/4Yf/IUJIhBbu5p43oMijbefA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kLiYNlLH;
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92DD606D819
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 21:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D92DD606D819
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kLiYNlLH
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-717034b331dso154920eaf.2
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 13:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794172605; x=1794777405; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BTsIQ3GHuwszTciCCDtrpxdJaKcQmTY5JV7uV9WKwZk=;
        b=kLiYNlLHYt2Q5LxFaYwrrKJ3TOZo7V6oaW5kxjrB2UxRLknCa8gtM9BVVf3r/p+Til
         VEuBYQ5s7n7pxoEAWKPv0VNJfTbpItxnzGL2LcAFJIKpSOPj6d0HB0r68z6WwTshAB8n
         tJ8L74Y/gDRhwln5xuRtshSZvie0zmiVDgBnboHQM0wThaM0JYyvkZjFLKjEdNtzsP9y
         birS3YC3rTMeVnqUqAmoIhEhuchBBxFZ1cpneXcJzeOGV0OVbpqN2aI2YSZsi1AhAFy8
         7VURTjRGDkU/Wq3rJ8yvvwIMpK45GWZdsXrkO1zTnWTmwJV7NPQwhNyeMd/H0PWRFbCK
         hGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794172605; x=1794777405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BTsIQ3GHuwszTciCCDtrpxdJaKcQmTY5JV7uV9WKwZk=;
        b=m6/ZFZ1XZwWcoteAFIHOgvBorbXmsI4fQeA0JAuEQij8VqG8juAVmIC5UK+mHpTc7I
         MBhmeD+Ixvt26+OQ0S1hCn8YZP6JA67l5AA1Fe+GMjY0u91WpOL5oO/eFRkKCLGN7IUQ
         pAXPH8LTlT+wwEd0uVJyDlZuDvPQScwnS7AMdZenxgZNbpnb2zW1tumbZ4bMMPEijNmt
         iWjITFuS+nu57ykSlDESyGdNMr/XddqhbVMGy545bnbyxlatbKEN/YAdg8O5vJxuo7Iy
         L9udxAj1x05dJoh+1Lbxs6mBm22LOOOcW6tMCzlUh+qawRufjAV9U9f8NXreSxB15dN0
         a7/w==
X-Forwarded-Encrypted: i=1; AL+hErH8VSfzZULaPicpWmbLMgGmkHeBOY53CW0nSLATgVlw8Z/xqr8GesIorMpNt+N2ji04K8gT2XU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9qBLIyGU8bSZNNd9ica0nEtKlSN1ZPymK00Ge0uK7I23VmtJB6
	WRr+nHSV3MZgHmOL7Y2jNW365nTKHWiE0ZEKQFIAwtxl4J33nKf7ltYO
X-Gm-Gg: AYBFou0dJBnfH+AkrIzb9oU7gPHeQUM00/g/JXn6dY0lrg0yU7uYyR+Taf7aZ6uXAW1
	+A3co4KCt47a8S0KxIb8wjbgEOQTGbck9HiWLJ2QDsjfK/YAG8aMjlImv9JFLtK1iVbtewae51l
	Ehl28wBKvENbHJ5il1wzmuL+95TComqDK/ZDKAhZm3l1b7XVAH8H8h1lmW2Oh+TniMcFREdCnu1
	HP0skLbcM2NWS1QIbidoknbe40BQWNRHAgT+KVLz9JYoWBiGx34MT8KZVsbx3kmBsBCDXgAo0Oc
	HItLTlL7Ak/soyzg+oskGOOOXjIHmkU4D9lIlLlVeTnk5BbyRWmv2lKDtrxPogUV6Gjd1cuwPTr
	rM7RTwZ1SzZ9t+M9Ic1KQsFt+fFBvxZRNEnDt7cRigEGCmwlKuXmrVuv7x7+DiTh60mNRbm5xX2
	BIUZBHM6Y8kcpiT+2I/efn6l0NHX/KyPajyhzpWv2anq85LCHzBs09Ja28VKCcOZdKGwoJ67nrJ
	0gmitCwuS3GPq1oH7bgIHVdKVybW6+SSTKvXaRaVojsuF750enDff63RHOxDDnHtQBPy94Iub1a
	AK8UMQPfDYu81+MAS0k7Rh1cTMvLfbFk/lSQB30INo5MItDA2UWwEi2w6sXzaQMRY6Ch9qePoc5
	94AY7Meujq7SEB/nOvKz455y0xsGFsXbXAI6UW9xVZbmTgFbGmQ7LBcxueoVWNary+DEYqahOUJ
	C0RApzFjk6kN8iyH1wmBRWo960Uc8xpvo5eJEWfgBnFUpfpxtNfOsr
X-Received: by 2002:a05:6820:858a:20b0:716:e3d0:c671 with SMTP id 006d021491bc7-7170f25b9e5mr902761eaf.14.1794172604868;
        Sun, 08 Nov 2026 13:16:44 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-7170f8fbc55sm1896378eaf.12.2026.11.08.13.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 13:16:44 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 14:16:37 -0700
Subject: [PATCH 3/3] mtd: rawnand: qcom: unwind registered chips on child
 probe failure
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-submit-qcom-nand-child-probe-errors-v1-v1-3-509f30a9e14d@gmail.com>
References: <20261108-submit-qcom-nand-child-probe-errors-v1-v1-0-509f30a9e14d@gmail.com>
In-Reply-To: <20261108-submit-qcom-nand-child-probe-errors-v1-v1-0-509f30a9e14d@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Sricharan R <quic_srichara@quicinc.com>, 
 Md Sadre Alam <quic_mdalam@quicinc.com>, 
 Boris Brezillon <bbrezillon@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2

qcom_probe_nand_devices() continues after a child initialization error,
allowing a later successful child to hide failures such as -ENOMEM or
-EPROBE_DEFER. If the last child fails, or allocating a subsequent host
fails, probe releases controller resources without unregistering chips
that were already published.

Fail probe on the first error from an enabled NAND child and propagate
that error. Share chip cleanup with removal and run it before releasing
DMA resources or disabling the controller clocks.

Fixes: 89f5127c4b0d ("mtd: nand: qcom: reorganize nand devices probing")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/nand/raw/qcom_nandc.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
index 062fba9eaecc..14bb7f3d6c36 100644
--- a/drivers/mtd/nand/raw/qcom_nandc.c
+++ b/drivers/mtd/nand/raw/qcom_nandc.c
@@ -2085,7 +2085,7 @@ static int qcom_probe_nand_devices(struct qcom_nand_controller *nandc)
 		ret = qcom_nand_host_init_and_register(nandc, host, child);
 		if (ret) {
 			devm_kfree(dev, host);
-			continue;
+			return ret;
 		}
 
 		list_add_tail(&host->node, &nandc->host_list);
@@ -2094,6 +2094,19 @@ static int qcom_probe_nand_devices(struct qcom_nand_controller *nandc)
 	return ret;
 }
 
+static void qcom_nandc_cleanup_chips(struct qcom_nand_controller *nandc)
+{
+	struct qcom_nand_host *host, *tmp;
+	int ret;
+
+	list_for_each_entry_safe(host, tmp, &nandc->host_list, node) {
+		ret = mtd_device_unregister(nand_to_mtd(&host->chip));
+		WARN_ON(ret);
+		nand_cleanup(&host->chip);
+		list_del(&host->node);
+	}
+}
+
 /* parse custom DT properties here */
 static int qcom_nandc_parse_dt(struct platform_device *pdev)
 {
@@ -2184,10 +2197,12 @@ static int qcom_nandc_probe(struct platform_device *pdev)
 
 	ret = qcom_probe_nand_devices(nandc);
 	if (ret)
-		goto err_setup;
+		goto err_cleanup_chips;
 
 	return 0;
 
+err_cleanup_chips:
+	qcom_nandc_cleanup_chips(nandc);
 err_setup:
 	qcom_nandc_unalloc(nandc);
 err_nandc_alloc:
@@ -2204,16 +2219,8 @@ static void qcom_nandc_remove(struct platform_device *pdev)
 {
 	struct qcom_nand_controller *nandc = platform_get_drvdata(pdev);
 	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	struct qcom_nand_host *host;
-	struct nand_chip *chip;
-	int ret;
 
-	list_for_each_entry(host, &nandc->host_list, node) {
-		chip = &host->chip;
-		ret = mtd_device_unregister(nand_to_mtd(chip));
-		WARN_ON(ret);
-		nand_cleanup(chip);
-	}
+	qcom_nandc_cleanup_chips(nandc);
 
 	qcom_nandc_unalloc(nandc);
 

-- 
2.53.0

