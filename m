Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794177746;
	b=3hgzMaBAY81xSsQLIZDD33j33muzkMp6U2TWkrjMlWj+of1jCPIo+4a1tKmRAGhz1vFx
	 daVIikN++SmGyj994OdWwG8wtAQBaiskzbe50an1QoWIxKYNi5OeKBGCvRdzcnW+Zb1VI
	 jp5uGkOfj+4dhXmBy0If+NK3+xMrsYIkgtITP3UxX/6gkjBAg9KipPt89Hl27hbkeF+Dh
	 5y9mfgy7PKheMfReFEPZCk+vMGNxXYB1v5RU+ksSSCg+J3r1+NTE+Aav2HNQHtJbFaSwE
	 MbvrD/i1vWJXPFyM5zqDzygpihl7LWiRdGiASDEW4s2nS2ZnRTX0P78PpyeMuyhf+bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794177746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=BTsIQ3GHuwszTciCCDtrpxdJaKcQmTY5JV7uV9WKwZk=;
	b=n7oLSrlXPKuG8huJ8fCNj2upiYSyGwDUg08m29MFiz6QdPQ3DbUNxkn7sA8zrwAE67+e
	 hgxjbl9PF3Obok9vqiSmZF8nweZGX7sB8FGpQQ4C4lA41ZPpU87zGNDQfA+py5x5rn4M1
	 foX4wIJJilG7Mx7Slat1n22NLPTUHIp03ezWbfpE281SM5rC5kFpp5Pj0leUNNR1NR99C
	 1bssY75gtpAFo/WWqW9uKVUIsKMkmzU+sByjenS/YX34OmFWN7vIlMG9pujvISvNxafvj
	 UFcSGagDhNXr0riOurotZskzTb6M5sRL+acp2HvYudiQFRKXAcs/b1nkgG/ukkVXY2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dw2PLEPD;
	arc=none smtp.remote-ip=209.85.210.48
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183C9606D814
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 22:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 183C9606D814
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dw2PLEPD
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-8451a619da7so179981a34.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 14:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794177745; x=1794782545; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BTsIQ3GHuwszTciCCDtrpxdJaKcQmTY5JV7uV9WKwZk=;
        b=Dw2PLEPDbpFCfu4XxFCaCh1QZeg/ALs3U+6/YbXln+vntgLeOlEZOPaj4Ra/+X8JVR
         MBBFo86JEJihjptEFJITLAQ8K2XSOIV92ibo2YsFbJVaOZBpx28ymhupeCVGUh0HGjAf
         CC6uPRYK/gNcDIxETqrlPjijJyFsXKlWxxklIwtWb/ZQYFYAfrDA3V3NG33uz3ydY3Re
         R+Mhce0M2pX/mFH0kNJLKydmAWEJych1vXeWFVNUh8b0PAtL8R+qPiYVvDh/NQpIGrDb
         nXl4cg9+LvDNMUgf3fVrr+6siBsrfdffSSbidfxJb6bRMB+K3tl3ZMdFLb9rp217ptqE
         tLKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794177745; x=1794782545;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BTsIQ3GHuwszTciCCDtrpxdJaKcQmTY5JV7uV9WKwZk=;
        b=qd+Ynu9x5MDlsxTDwludm805uYxadgzWUAqSddtRGzWTHWJYCmsXNs1RKWbI+swmLY
         IDvCgh5fZB/+/JQ0kXC7JGd91JqHwjNwFvIzY1qNqkn2dp6/+irqLkew+UFd3lhP9ycq
         YW6M0CVdNXXUQvsCaELbKeUj9uMG272Aihw5tHxT0pR1PjCLW+HIkp6m+REhrsfnTy6D
         9LmRzTUJ3XpZtpZPieOnJse3IuZL+RkpEq1UOndqe+8oD0eah/j+shb0xH8Y5EC8hndE
         NAeaVRjbA0Jm5asD3TdLUT+DxkFV/SVB1asDXd3e3iGoOAXyuJ6d58SAxyvPWgNrXNOY
         8osw==
X-Forwarded-Encrypted: i=1; AL+hErEoR1kXa0S9gzYggO0CSVfAopOZ+Z02LlArLG7vGLabzUeCCZfldjZ0Rggx7S/doTWH9Q4nY9I=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SRszTJXFikOp+vQZRrNB5R9bNZsWipjkKFhUVY8iOUsopFvDV
	WvzWX7+BsPyF6IN6KXU33Qvb6IjVIrAMdwvMSl4YNtSrJ7LJjKL3asWl
X-Gm-Gg: AYBFou3ZMe069aqTGgsYorXG8DW/P1qibiPLpVZNok7wkBU37DtCu9vVgHocZX175Pw
	v3w5Gzgc1neTiAQNmKe59N/uheCnmX6wuZeWilQ8nhGc5z/6Iz8tWgVEtx5o3PAvGLy+JeeTvOx
	aIQhtx8Z3Tm9nRw6F4CqWMvXPEpjnIwBnJ8Q+tAPcKf7dnsosLNloZ6EbObMHtERjwLGnNLQ4DV
	y62uv9fpqPUoUEfDxuJGLY6jQI818KJIL9MQAEGmp3u5Z4N9ngYlF7RP6Gv1pZxJlOLMOmeK3r/
	ptg6iscGbTgWkEXl+fy9hsWJHoKQf0mQQKjlGNmiUd5Q3ShWgRkH1eqtZS2ZTTaxyr1+Y6BT88p
	pRRWjZhOCdvl1CsCI7Xb+DQXU2R7RkYHYishhIjOS9Px+3y8+zFZRRc4z+6CiHWy9Ec41LG4NPL
	p+eQPAuZORZaJxJjRWdW+SF6wP//xtrkNMuSj+Z5hSz7th6Ew3MQBEYmls5bBjmbd5QfBkxJaJ1
	5R/Y2lhNFIl7U2kmvtrYJeSQCSa2OY06s68vLWjVXY4CkQpUBXOwmH1jKsKtn083SfYBlwkE9QT
	IfS9ZFULT+AiJcKADHktmZtCMs3uDJpFJDDZvhFjfm2383W/bT8GjOtVWiHXDscaLWaAS+ZUbtb
	QPLJzeOgc7dCcRBxu1oz+0dsEhudun1kveMIqLErrzCKPmppu7TsXsaL76Q2uJ5Q5Kcjn+cphFb
	GLJRc3TlG6n2spL1cVn/XtagrJXd8SGrLIvHsxMymc/QanEtRrvsz3
X-Received: by 2002:a05:6808:191c:b0:4f6:3401:1c79 with SMTP id 5614622812f47-568143dc9bemr1634647b6e.49.1794177745010;
        Sun, 08 Nov 2026 14:42:25 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56813e54e39sm2859944b6e.15.2026.11.08.14.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 14:42:24 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 08 Nov 2026 15:42:10 -0700
Subject: [PATCH v2 3/4] mtd: rawnand: qcom: unwind registered chips on
 child probe failure
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
Message-Id: <20261108-submit-qcom-nand-child-probe-errors-v1-v2-3-4a8704cbf7b4@gmail.com>
References: <20261108-submit-qcom-nand-child-probe-errors-v1-v2-0-4a8704cbf7b4@gmail.com>
In-Reply-To: <20261108-submit-qcom-nand-child-probe-errors-v1-v2-0-4a8704cbf7b4@gmail.com>
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

