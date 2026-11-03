Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703342;
	b=ZSK8O4kKUsUhIMK5Bot/0bNzvBGZEQFcLCEegOcMc1xZqc057ue1K98ejFOMO0VYk/im
	 JCtMJ7NJJYFomSQcWffZ1srCWeSB2FUKv+b61O53PxvHLCwdK0iph7K5Qj5ou+ILUQ03k
	 l18e43g7b7/OqOoDvRVERYFfJf5uEpmoVye14GCi168Z+5jP78z6ENa9VHcpegXfapVZa
	 7nPySzauClgz1vhERgwXLUu8jYxfXABqMrsEY68sAN7cXUs1RcWv9iRekFtNaPdmrY4uQ
	 cglybi+sDsDEqRoMDxm2jfv630S9O77WrzkHXx9EEDLs8tELvD8eHzjXQIn2o6u7KjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703342;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=YO2JIkijyjOjzjl6B/QzJc3lApKcV6LLjiv5hE0GLMo=;
	b=lPGX+V4YonSztbORQmdRY5lSydahNd2tG1AVI1Y0aCYCMFoYlApFFrgkyj/MRLx9zW08
	 4oG7SIi2FXb0+cxMij1Dop1z2QlQ7C3ZnZcbWmlQoxeUKcnEGpGDLufpdSHN13JXsKM1R
	 29R8tgUqSPIZtxWpagGZ5AMNuNJMXHT7FfX+8eRwxV9ks0rkm8pvxrdTnYtROaQ4FSKbP
	 gS4JYcW3KhI6wwtbTpdtdQxgyQczk1MFqPp+p5oglyyCpC0cczPnBBoQSKWC2zXRFGSxF
	 7b9XqDtxNDlx20cirmsdEJocX3vyEBQD7wDPAC/kv+DpnigABWeH9EfIYOcoyEvP93A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BAE60775C4;
	Tue,  3 Nov 2026 10:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47BAE60775C4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACXaZqnvelqzOE7AA--.64965S2;
	Tue, 03 Nov 2026 18:55:36 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vadim Pasternak <vadimp@nvidia.com>
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] platform: mellanox: unregister the fan device on probe failure
Date: Tue,  3 Nov 2026 10:55:45 +0000
Message-Id: <20261103105545.1394576-1-vulab@iscas.ac.cn>
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
X-CM-TRANSID:rQCowACXaZqnvelqzOE7AA--.64965S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw1fZFW5Cr15tF17tr1fZwb_yoW8Jw18pw
	45u3ySyrWagr4j9w4UJa4UZFWjkFnIgrW8uryrA3y7A3s0grZ0k3s5Xa4xAFnrtr1xAa45
	trn5tr4DuFW5Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9mb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
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
	1j6rxdYxBIdaVFxhVjvjDU0xZFpf9x07UNTmhUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIAA2rpnICE9QAAs2

mlxplat_platdevs_init() registers the mlxreg-fan platform device before
the watchdog and DPU devices, but the error paths for those later
registrations never unregister it: the cleanup chain below
fail_platform_wd_register drops the watchdog, io, LED and hotplug
devices, but not the fan.

Unregister the fan device on those failure paths.

Fixes: 158cd8320776 ("platform: mellanox: Split logic in init and exit flow")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/platform/mellanox/mlx-platform.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/mellanox/mlx-platform.c b/drivers/platform/mellanox/mlx-platform.c
index efcba68d3aa5..303721604c96 100644
--- a/drivers/platform/mellanox/mlx-platform.c
+++ b/drivers/platform/mellanox/mlx-platform.c
@@ -8389,6 +8389,8 @@ static int mlxplat_platdevs_init(struct mlxplat_priv *priv)
 fail_platform_wd_register:
 	while (i--)
 		platform_device_unregister(priv->pdev_wd[i]);
+	if (mlxplat_fan)
+		platform_device_unregister(priv->pdev_fan);
 fail_platform_fan_register:
 	if (mlxplat_regs_io)
 		platform_device_unregister(priv->pdev_io_regs);
-- 
2.34.1

