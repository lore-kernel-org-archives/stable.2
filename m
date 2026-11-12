Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794491652;
	b=0OIH16fi8013iue1f1B09V4kmoCyzkFwAl5ou1oolFAxPvdqFIrnaO2nV4+nhgOTtsNh
	 wIs0DPGWO+Wrn+X2avwIbZYrU+fkNQ//yRC1CJtcMIi5AckwDwYwHrKmKZQQaNlVyjMBF
	 8yC6q8Cw7jAtACAXKYa57OfZ8KtNcZJ5V1F1seMlmw5BHek1pqmyrL4KVXVc7uxR1J/8+
	 /G9E8YAmOYPge683vD96Q+hy+zaxO0SRqD8L86NOkPcF68at8BO5vgjnK66T2cGY/x5UF
	 rv53iO1DlA6Cd7W4LP+PkMrzlOHp+X19GMldmavx41eViurWfkJd9BXdawyIX/qkmDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794491652;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MBO38vnlAQ0tkNY12VxqO1riCqLLGif/aZ8s3OaXq+s=;
	b=aVRZessa5bOQfqM8eNDCYCoPSErYg8PaF8cSbScA/nlQBQoOuZyVdpLaUdK36ZbkKudr
	 WT0mpgbWxxCpXWt3G0Li3/xPkzZO88urOUwLTn8eCC4MwlFtSiBpPDDZizOmXjG+h2zDf
	 Y08j39zgDvYs36ryh4VAwpXCIub+JJ4SfanVJmKcDQE2wn8UalgSrn1Y8+tfsCYv0bfrn
	 aeO/UCOTe4xWKlakjtgdusj9mbhq/2ygbBVNvnkdL5uq7i++WF1RTzpcEPuQzpXXP2Z4d
	 mNfAoEzRLdd7THws/I5zxl6dqU2zVNTWpUNPnYDU6THUuDPjGV2uGDV5aCG1dwxNbyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=POO4uN3G;
	arc=none smtp.remote-ip=115.124.30.112
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2725606A321;
	Thu, 12 Nov 2026 13:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2725606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=POO4uN3G
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794491649; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=MBO38vnlAQ0tkNY12VxqO1riCqLLGif/aZ8s3OaXq+s=;
	b=POO4uN3GdPixp/brpGUrQxb+QgSQLJ2Uab4lA9t9uMaCdAGt+j15deu57IsJzq1j2OqnOwV5yFc62dUzBgYPkf4t/Gf3rPI1kV8DeL/Qju8f79Eg7Ckfs6jBXVAi+xFTO7o68t5RhhNF5eJjR05nFpzEUWkLgQVGGX3ikMCwkU0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0XEcATOG_1794491647;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0XEcATOG_1794491647 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Nov 2026 21:54:08 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	yeoreum.yun@arm.com,
	suzuki.poulose@arm.com,
	leo.yan@arm.com,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xueshuai@linux.alibaba.com
Subject: [PATCH] coresight/etm4: fix missing disable active config
Date: Thu, 12 Nov 2026 21:54:06 +0800
Message-Id: <20261112135406.71749-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

From: Yeoreum Yun <yeoreum.yun@arm.com>

commit 895b12b7d7b8c651f73f57a1ea040d35aa7048cb upstream.

When etm4 device is disabled via sysfs, it should disable its active
count.

Fixes: 7ebd0ec6cf94 ("coresight: configfs: Allow configfs to activate configuration")
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
[ shuai: kept spin_lock()/spin_unlock() in etm4_disable_sysfs(); 6.6.y does not have the raw spinlock conversion ]
Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
---
Note for stable maintainers: this is patch 1/3 of LKML series
20250514161951.3427590. Its siblings are already in 6.6.y: 2/3
(53b9e2659719) as 1cd09aaf47a5 and 3/3 (408c97c4a5e0) as
b3b4efa2e623, but this one was only ever picked into 6.15.y
(c7f2b00d5e17e) because it does not apply cleanly to 6.6.y without the
raw spinlock conversion. Without it, each sysfs enable/disable cycle
leaks one config_desc->active_cnt reference and the module reference
taken on the config load owner, so the configuration module can never
be unloaded.
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 593dcfe4c9457..55b20d23b505d 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1078,6 +1078,9 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
 	smp_call_function_single(drvdata->cpu, etm4_disable_hw, drvdata, 1);
 
 	spin_unlock(&drvdata->spinlock);
+
+	cscfg_csdev_disable_active_config(csdev);
+
 	cpus_read_unlock();
 
 	/*
-- 
2.39.3

