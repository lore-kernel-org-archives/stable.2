Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793687005;
	b=AD9VI7R7UoO18jdg3QjNurEUuiat9FIUlq29KTSkteuv29cNcLk2hmq9qHoOFKSBzzQM
	 tB/L7AWlzGCqwd9VpmH0NxB3vtRp8X0rIvIiEBzftPBIsp6dHQK6RifctU4PI5uJMTmkV
	 a2H32rsLAcHIh04W5grLjn/WcVzpBsosZJxIzSCahvZv5BlKo5Ojg+X+51/K0HOXbotFO
	 L/itBbSZIM1J7aVvnQuHBYaiiu8L2YgWjAJuHatMgpMrTL4rQSrWMuv5jU9EjBBZxLCl7
	 qdoekwvsGnbumEz8Jwu1zJgnnP/19XdCU93Ep+c019xmjrzjtlO/YHzojou4fqTAdkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793687005;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=UAn8DdzhCl1JAce4KcX2Uzj4IwjBIypcCCNE2skiWC0=;
	b=dX0+KWVy8Cvm3imyQ7CyudEYQWSVnvEXUncrjiUbd8R9pF59Ntw/cYZmj5KgN8WFyvPo
	 89dF3LVGMVhSSehvSduBKzf+go1VS1EpXxkp36Gzo2Fec4c6COltnzrNizPG+z2wNceSn
	 wJtg9/9lhEetvUG3iAoL8Demx8nKxprlAEgb6lgd5+g1jaK6MZOj4HCeKB0FXVGhlUzqE
	 kSnWJgZCGQHrB5L9FDn2qmPa92x9tSwe2PocIpuahU2Yx4tHpRkbsnRzr8lzpDRs5qwnz
	 Z3xfBx/WiKk+78HyWowJHDddQ/OqvcZQUN51VHybse2dySuD/NhSieXWUhX+RdMFC1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0803C606A324;
	Tue,  3 Nov 2026 06:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0803C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACHk5TOfelqeks5AA--.3607S2;
	Tue, 03 Nov 2026 14:23:10 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: tomeu@tomeuvizoso.net
Cc: heiko@sntech.de,
	ogabbay@kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] accel/rocket: Unregister the platform device if driver registration fails
Date: Tue,  3 Nov 2026 06:23:19 +0000
Message-Id: <20261103062319.1013449-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowACHk5TOfelqeks5AA--.3607S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFWUKF47AFW3uw1DCF17Jrb_yoW8Xr1Dpa
	13G3yayr9Fga1j9w47Xa13Za45Ca1Iy3y09348Jw17uws3WryrGasYqFyUtF1xJFy8GF4a
	vr1qqF48uF4UZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUHpBfUUU
	UU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwcAA2rpWtlwKAAAsb

rocket_register() registers the facade platform device before registering
the platform driver. If platform_driver_register() fails, module
initialization returns an error without unregistering the device. The
module exit function is not called after a failed initialization, so the
platform device and its resources remain registered.

Unregister the platform device when driver registration fails.

Fixes: ed98261b4168 ("accel/rocket: Add a new driver for Rockchip's NPU")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/accel/rocket/rocket_drv.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index 5d7805c41dc3..4ea65d6eec81 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -285,11 +285,17 @@ static struct platform_driver rocket_driver = {
 
 static int __init rocket_register(void)
 {
+	int ret;
+
 	drm_dev = platform_device_register_simple("rknn", -1, NULL, 0);
 	if (IS_ERR(drm_dev))
 		return PTR_ERR(drm_dev);
 
-	return platform_driver_register(&rocket_driver);
+	ret = platform_driver_register(&rocket_driver);
+	if (ret)
+		platform_device_unregister(drm_dev);
+
+	return ret;
 }
 
 static void __exit rocket_unregister(void)
-- 
2.34.1

