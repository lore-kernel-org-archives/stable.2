Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794743278;
	b=h5mtYhLkKdoljRiCD3fhyxsjkgzdNRHLtoSSYP5BgcJJsU5c4OICrqBKbKb4vmswABrr
	 2Lm7H8qdji38e7mjWSqgS7+n/E1PKXcK5sqtyIpu9a7TLd2jdh0rlPH0b7vM1W8f+jk97
	 Ywe/QWqSv5MZfHNW2Q1RKN2CYpJmOldmSMkotl4mLJKYClVUumHv62utISUJlQwnfMSp/
	 R6rdsTIejkh04jAvsFV4v4ayc4hlTsyE5RZ2UqKAPaPAmOxgmVxmOj/otq/E8YfTA/saw
	 QjichJx171OVzIqidFCLiYnyoDi5fTMtbkCuBRWJYZL7cQN8o8BeR2zJ0s4kuoCxP2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794743278;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=RU/JFtl3t2fQyM9MGmpqoQqoNW5efmsBFP2qUPrWTuI=;
	b=qq4+4yr0s6t85ANhjTw6wC6AdXsSp1988cMXEd5uRWtU9HnbsROH0RY4Aog1lDFYmWcW
	 unr41UX2xVUrziKYLV7GbJm4i2K2s8e1ENdObm0vsEiOCkqO76z9xvk3qHRTyOdcVGL0F
	 0696KsyqPK0FNFT9W5r97GJJHEnHJzy8Z7FMRU1EpQuhOgpSHxS/qHJdEZ5UHgdsSCWEC
	 fT6QLoGGjupVLG/dvdzaV+LWuq6WCTLHNkRvVTIEgJOo3sGTi7N1AX+Xc127qD+AFRRnR
	 KB+3sP8xfhKIt4z9/j+aIFCz28blsv1pqd9I3aOp5xz6l2gSC+AE8yC8x+/I98pO9Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=kAxxGKMw;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5673D606A88C;
	Sun, 15 Nov 2026 11:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5673D606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=kAxxGKMw
Received: from [192.168.17.1] (unknown [124.79.98.159])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54b7e04da;
	Sun, 15 Nov 2026 19:47:47 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Ilpo =?utf-8?b?SumQqeeeqHZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
 Hans de Goede <hansg@kernel.org>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Derek J. Clark <derekjohn.clark@gmail.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>, Rong Zhang <i@rong.moe>,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject:
 [PATCH v2 2/2] platform/x86: lenovo: cancel fastcharger work on detach
Date: Sun, 15 Nov 2026 19:47:44 +0800
Message-ID: <179474326460.103840.3845211906644469212@seu.edu.cn>
In-Reply-To: <179474326098.103840.15531040789536968458@seu.edu.cn>
References: <179474326098.103840.15531040789536968458@seu.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa1df08ef6503a1kunmbac61c98bf774
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCS0tMVk8ZGEkYT0NOHR1CSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VTEJVQkNVSk5CWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	JKVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=kAxxGKMwu40CGR48f1pV5d/EnzMC5gTA5G65i+Zby2KGDHV8i7QumPaVxH3cYzKJbTBSxyndr/cXysgMJ6Q0mCC/hdKWaOO9T2OxaDPUryGCAyijnapp6i374EXB0cZVE9SuueOhqpcedltSe6Qh90gLFxjPi2vsI9QD5RKTdDc=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=RU/JFtl3t2fQyM9MGmpqoQqoNW5efmsBFP2qUPrWTuI=;
	h=date:mime-version:subject:message-id:from;

The extcon callback schedules a worker which uses managed serdev,
pinctrl and GPIO resources. Releasing those resources while the
worker remains pending or running can access invalid state.

Install managed work cancellation after the UART is opened and
before registering the managed notifier. Reverse devres order
then unregisters and waits for notifier callbacks, drains the
worker and only afterwards closes the UART and frees its pin
resources. This depends on the preceding all-connector notifier
synchronization patch; resource order alone is insufficient.

The actual lc824206xa supplier notifies from work context, and
this consumer callback only schedules work. The callback must not
outlive synchronized unregister or republish after cancellation.

Found by the author's in-house static analysis tool.

Fixes: b2ed33e8d486 ("platform/x86: Add lenovo-yoga-tab2-pro-1380-fastcharger driver")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260806060526.1189-1-getshell@seu.edu.cn/
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
Signed-off-by: Zehao Gao <gaozehao@iie.ac.cn>
---

Discovery: found by the author's in-house static analysis tool.

 .../platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c    | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
index 9e2ac80..51ff383 100644
--- a/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
+++ b/drivers/platform/x86/lenovo/yoga-tab2-pro-1380-fastcharger.c
@@ -8,6 +8,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/delay.h>
+#include <linux/devm-helpers.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/extcon.h>
@@ -160,7 +161,6 @@ static int yt2_1380_fc_serdev_probe(struct serdev_device *serdev)
 
 	fc->dev = dev;
 	fc->nb.notifier_call = yt2_1380_fc_extcon_evt;
-	INIT_WORK(&fc->work, yt2_1380_fc_worker);
 
 	/*
 	 * Do this first since it may return -EPROBE_DEFER.
@@ -209,6 +209,10 @@ static int yt2_1380_fc_serdev_probe(struct serdev_device *serdev)
 	serdev_device_set_baudrate(serdev, 600);
 	serdev_device_set_flow_control(serdev, false);
 
+	ret = devm_work_autocancel(dev, &fc->work, yt2_1380_fc_worker);
+	if (ret)
+		return ret;
+
 	ret = devm_extcon_register_notifier_all(dev, fc->extcon, &fc->nb);
 	if (ret)
 		return dev_err_probe(dev, ret, "registering extcon notifier\n");
-- 
2.50.1.windows.1
