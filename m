Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703342;
	b=tFBLJo1HNRLYrh8UPA6kVJZvsxfPa2hskbueyqrV1ybWrUuL+qS3WHdftKdtYFNIosuM
	 mOJiJJjLUJbq6mxsUC2k0kNPwMrGZcA06gSM71osuryx1L1nEkYEhalI9dr2ARCM7vNoF
	 L3FiCLTF7v7gbu0AOSOkLDEmIThAkmQtw7L/DLgWHsCey8o8GKMnoePSOxTKcJkGne2hs
	 M4axlMe3AWk1TEZ33m2vETBHcjN/qOPScUWjSZi0c/FcCjkRUE3+G/zyFtZJHXRcxaWam
	 LvNfno/j4OYv0R0Yc1wt3BRWZQu2RSoYEko/W2YEpLoYv/+/XIJnECbxRHQRIFJY+oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703342;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=mnoDxV0TS+dAwrz56FWEJywclJkrP2q/9c2vRRsEmWU=;
	b=ymYxp+RVUNCzTush58H29fH0IOTkV26aUXeNQS+zzIg2mCVCqPVgAWxAt9ABh3PQy5dz
	 uvabz4R+aSOGJkCVCLn9ZAkiiZDErl4+XzAijVefQKl0MpWG4iICCbq3RptDuLIBQ8hoh
	 kSAsI/iPwNT12+ZddQvRtesUmxtbmWv1LG5vS7PYiXkESRqj6/ybgLPIZ6b8b+12y+8w/
	 YoQkmHM7wq63rjUDcO7ahzps5KvcUFnMvTeVhTOWbK8xUOL/UZlWnRM45G2cM93E/qEma
	 YiCewDsRlRgrOWCH8rqG5z84qmu1KjXxZKOhB0A9YnC1WHYbourdO/jiHXGs8bip4bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02471606EE99;
	Tue,  3 Nov 2026 10:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02471606EE99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAA3Q5Snvelqx+E7AA--.5664S2;
	Tue, 03 Nov 2026 18:55:35 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86: x86-android-tablets: fix codec teardown if poweroff handler setup fails
Date: Tue,  3 Nov 2026 10:55:44 +0000
Message-Id: <20261103105544.1394559-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:rQCowAA3Q5Snvelqx+E7AA--.5664S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCrW3Aw4DXFWkKFyfXr13Arb_yoWrJryfpr
	n5KF4Utr98KayDtF4kJF1vvFZ3A3Z7AFWDX3y0krZ8twsxXr95Grn5Zay8tr1kKw4xuF15
	Jr1UArZxuFnI9FDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9mb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
	C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6r
	xdMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2
	zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07bn-erUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIAA2rpnICE7gABss

lenovo_yoga_tab2_830_1050_init_codec() stores the codec device reference,
the pinctrl handle and the pin mappings in globals on success; they are
only released by lenovo_yoga_tab2_830_1050_exit(). If the
register_sys_off_handler() call which follows it fails, the init callback
returns an error before the exit callback has been registered with the
framework, so the codec device reference and the other resources are
never released.

Factor the codec teardown out into a helper and call it from the error
path of both init callbacks.

Fixes: 4ce8f4c2027d ("platform/x86: x86-android-tablets: Fix Lenovo Yoga Tablet 2 830/1050 poweroff again")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 .../platform/x86/x86-android-tablets/lenovo.c | 27 +++++++++++++------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/x86-android-tablets/lenovo.c b/drivers/platform/x86/x86-android-tablets/lenovo.c
index 52d96ae89078..294986f84ce8 100644
--- a/drivers/platform/x86/x86-android-tablets/lenovo.c
+++ b/drivers/platform/x86/x86-android-tablets/lenovo.c
@@ -548,6 +548,14 @@ static int __init lenovo_yoga_tab2_830_1050_init_codec(void)
 	return ret;
 }
 
+static void lenovo_yoga_tab2_830_1050_exit_codec(void)
+{
+	device_remove_software_node(lenovo_yoga_tab2_830_1050_codec_dev);
+	pinctrl_put(lenovo_yoga_tab2_830_1050_codec_pinctrl);
+	pinctrl_unregister_mappings(&lenovo_yoga_tab2_830_1050_codec_pinctrl_map);
+	put_device(lenovo_yoga_tab2_830_1050_codec_dev);
+}
+
 /*
  * These tablet's DSDT does not set acpi_gbl_reduced_hardware, so acpi_power_off()
  * gets used as pm_power_off handler. This causes "poweroff" on these tablets
@@ -578,8 +586,11 @@ static int __init lenovo_yoga_tab2_830_1050_init(struct device *dev)
 	lenovo_yoga_tab2_830_1050_sys_off_handler =
 		register_sys_off_handler(SYS_OFF_MODE_POWER_OFF, SYS_OFF_PRIO_FIRMWARE + 1,
 					 lenovo_yoga_tab2_830_1050_power_off, NULL);
-	if (IS_ERR(lenovo_yoga_tab2_830_1050_sys_off_handler))
-		return PTR_ERR(lenovo_yoga_tab2_830_1050_sys_off_handler);
+	if (IS_ERR(lenovo_yoga_tab2_830_1050_sys_off_handler)) {
+		ret = PTR_ERR(lenovo_yoga_tab2_830_1050_sys_off_handler);
+		lenovo_yoga_tab2_830_1050_exit_codec();
+		return ret;
+	}
 
 	return 0;
 }
@@ -588,10 +599,7 @@ static void lenovo_yoga_tab2_830_1050_exit(void)
 {
 	unregister_sys_off_handler(lenovo_yoga_tab2_830_1050_sys_off_handler);
 
-	device_remove_software_node(lenovo_yoga_tab2_830_1050_codec_dev);
-	pinctrl_put(lenovo_yoga_tab2_830_1050_codec_pinctrl);
-	pinctrl_unregister_mappings(&lenovo_yoga_tab2_830_1050_codec_pinctrl_map);
-	put_device(lenovo_yoga_tab2_830_1050_codec_dev);
+	lenovo_yoga_tab2_830_1050_exit_codec();
 }
 
 /*
@@ -776,8 +784,11 @@ static int __init lenovo_yoga_tab2_1380_init(struct device *dev)
 	lenovo_yoga_tab2_830_1050_sys_off_handler =
 		register_sys_off_handler(SYS_OFF_MODE_POWER_OFF, SYS_OFF_PRIO_FIRMWARE + 1,
 					 lenovo_yoga_tab2_830_1050_power_off, NULL);
-	if (IS_ERR(lenovo_yoga_tab2_830_1050_sys_off_handler))
-		return PTR_ERR(lenovo_yoga_tab2_830_1050_sys_off_handler);
+	if (IS_ERR(lenovo_yoga_tab2_830_1050_sys_off_handler)) {
+		ret = PTR_ERR(lenovo_yoga_tab2_830_1050_sys_off_handler);
+		lenovo_yoga_tab2_830_1050_exit_codec();
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.34.1

