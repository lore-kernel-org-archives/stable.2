Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793162940;
	b=ee619k8d22cFtlmDjdDreH0dROyXyq0vQBwOMpsVSCUZnCmExK+jDmeX9aoBrVCS/Opv
	 e8cleN9G+8AijocYnBzXcUcx2OkmAY9IRcvxh1LEsmaDErVIRHaygktPayn6yJbIZVhd+
	 +7g3R5eya1Hd1P3GRKKI4aInO2E2qXNAGwyHyiKuMotIY9DpirFmVifqNhRbsQeTwwo18
	 hVZybe9M/q3XULZ5y5Q8eAfTNAC7amRvPWKjY9QfLSaAsjJ0Fqgx6U86XQlMx8nz+9by5
	 4575Ar4UrL0iwCQ7td88FCli9s3BZIAsCj1Oq+6eh7OvOyPsPGz8nRyjI65N81ltbNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793162940;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=MZyXYqC08FyEIeH6sfGKQng3ElLfZ33+hGyzkDWHxXQ=;
	b=AO3LEEaCZ71f2ObY8E+wZu98OT+Hl04vRQxOniMd2JqaoLGhBHDaBYv119ZU34VdcY6R
	 cT1GDaEi0CvZnYrgeAYhvS/iJnhJBcmEvZcX90WTdBt9iERIFoP/Pobh68SgxieMEuHGE
	 xjdkPt+p0mRE8xcKQnMCh08vXcjlvwinba5QJFKOFxlkDCJxSVzlfomvxodyNqBmxumc5
	 loksBBWcK+eS4GQZ6lw6RlyR7Stc8qsULJNizSC21xCGDp9gI5bY4FP5Oa+LjXozUIQAF
	 lhOskrFx67PP5doIXWFa7snilxIqUNWy0rgGrPBxs15XIoSsyhCbpMiQyHojg/HndDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b="E+915/XJ";
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77EA606A320;
	Wed, 28 Oct 2026 04:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D77EA606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=E+915/XJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=MZ
	yXYqC08FyEIeH6sfGKQng3ElLfZ33+hGyzkDWHxXQ=; b=E+915/XJO8xbPQnTg9
	zsTVUmi02nzz3zO58MOGVBNluYeMMkk2RFDnxLB9YtTwqYB0VIVUC13vFwouPbiZ
	8srfWAqLSrW9TsABS197Gyfhjqo6Vbib+TsNOU67B8/EfvmV/HvnECxM4PE0hcP5
	FE1LQZ4qwutd2N8QtsTrDU9JA=
Received: from pc.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSgvCgDXXyGcfuFqI22BCQ--.35298S5;
	Wed, 28 Oct 2026 12:48:34 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 3/6] Drivers: hv: initialize partition table before device registration
Date: Wed, 28 Oct 2026 12:48:23 +0800
Message-Id: <20261028044828.96177-4-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028044828.96177-1-yaojiale02@163.com>
References: <20261028044828.96177-1-yaojiale02@163.com>
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
X-CM-TRANSID:PSgvCgDXXyGcfuFqI22BCQ--.35298S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFW5Ww4DKF47AFyfZr4ktFb_yoW8Jw4Upa
	18W345Ar4kta1I9a1DC3Z29F15tan7C3yjva4Uuw48Xwn7Ar1qva4jk34UuFyxtrZ7AF1j
	vF4vvry8Ca1UZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jD6pPUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQLaFWrhfqJVygAA3I

misc_register() exposes /dev/mshv before the partition hash table and
its lock are initialized. A partition ioctl racing module initialization
can therefore access the table through an uninitialized spinlock.

Initialize the partition table and lock before registering the misc
device.

Fixes: 621191d709b1 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hv/mshv_root_main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index cc2cfce2aefd..ce26320035b6 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2369,6 +2369,9 @@ static int __init mshv_parent_partition_init(void)
 	if (hv_get_hypervisor_version(&version_info))
 		return -ENODEV;
 
+	spin_lock_init(&mshv_root.pt_ht_lock);
+	hash_init(mshv_root.pt_htable);
+
 	ret = misc_register(&mshv_dev);
 	if (ret)
 		return ret;
@@ -2407,9 +2410,6 @@ static int __init mshv_parent_partition_init(void)
 	if (ret)
 		goto exit_debugfs;
 
-	spin_lock_init(&mshv_root.pt_ht_lock);
-	hash_init(mshv_root.pt_htable);
-
 	hv_setup_mshv_handler(mshv_isr);
 
 	return 0;
-- 
2.34.1

