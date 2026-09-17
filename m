Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59DD58F070;
	Thu, 17 Sep 2026 14:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789654761; cv=none; b=bSQdbYgMZzyIoVGtGN9qeR+f9t5x/ymAbNdMzdzW1M0kRyx8kRasplKyyB/8nOhdwZjy5Iwn4yd464WjJ7tZCjlVkYjVKl50atKrGEPyA2aepMH/sdftucGyqQy+9XISzrLtkQqSLEydemxKQCPYK+5/YhbS44fLlIoOZddXMCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789654761; c=relaxed/simple;
	bh=eFWknGnJynLWlo8q/9erZE+UVp85mIa1OjF467VhGCY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BvXEihoFYgtUsN86h8KXDRY8P2ls8HzMiOB8PxDpt8eGNjRDBTJvGbS7BMqs/w7NML1UNKsuhwvbweA/i2iWMtiqkYE1UWf0WGAZJlt21p8d2XEQGh57osBM9x/nM5cZHT0w0zJc74UATf5CpaKXvB1ZydV2m9aSPJMtESWfskc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAA3oDrg9qtq9UiCCA--.4388S2;
	Thu, 17 Sep 2026 22:19:12 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org,
	philipp@uvos.xyz,
	sre@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] power: supply: cpcap-battery: Fix nvmem device leak in cpcap_battery_detect_battery_type()
Date: Thu, 17 Sep 2026 14:19:12 +0000
Message-Id: <20260917141912.2156487-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3oDrg9qtq9UiCCA--.4388S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF1DCF1DJrWDXrWDAF48Xrb_yoWkWFcE93
	WS9r97Jry8CF1UtF1Utr13Zr1vgFyvqFW8ZF4ktwn3XF13Wr1DXrn3Z3WUWF1kXr47CrZ8
	uFWDtF4rtFyj9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfxYjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26F4UJVW0owAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0E0s8F02x267IIx4CEVc8vx2IErcIFxwCY1x02
	62kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr
	1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6xkF7I
	0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07UuWlkUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwENA2qrrRneLQABsP

cpcap_battery_detect_battery_type() takes a reference on the nvmem
device with nvmem_device_find(), but never releases it, so the
reference leaks on every call. Drop it once the battery ID has been
read.

Fixes: fd46821e85de ("power: supply: cpcap-battery: Add battery type auto detection for mapphone devices")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/power/supply/cpcap-battery.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
index 7b7bdce3162f..b7ed4f2d3826 100644
--- a/drivers/power/supply/cpcap-battery.c
+++ b/drivers/power/supply/cpcap-battery.c
@@ -445,6 +445,9 @@ static void cpcap_battery_detect_battery_type(struct cpcap_battery_ddata *ddata)
 		dev_warn(ddata->dev, "Can not read battery nvmem device. Assuming generic lipo battery\n");
 	}
 
+	if (!IS_ERR_OR_NULL(nvmem))
+		nvmem_device_put(nvmem);
+
 	switch (battery_id) {
 	case CPCAP_BATTERY_EB41_HW4X_ID:
 		ddata->config = cpcap_battery_eb41_data;
-- 
2.34.1

