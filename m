Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE2D55295D;
	Thu, 17 Sep 2026 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653233; cv=none; b=Y2eIbqJdQLp1znqSAQefnyM3rdKQsk3U3Lk3/lsGPza+m2s0oE3lZQ6UHPj/Uslg3LfYDC0XoAtnBFEFL0wvIGewHFwA3xexLv9sErBd7NBaAhP31f7j/36rW3P5DyYyJ/u1qcacvneAeT5nJPe3Kr58CpWBkeNhgIh81RBlumE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653233; c=relaxed/simple;
	bh=V9ny8P/HqtKUeNovfq5bPXJz6/ExefhVObrKLjFdv3g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FysPZtKterbD1t0/nGvBS22WNMPV+QQeFzSN2E+tRp7CTvODtDCWBhSy0ABaO7336+qX2qX5m/GSdHGunUT2vqDAGZo3DUvJ1XbZD+tOK10vCXDhZ712Yef5HyiBfoQgfYwB7mjv5Oo986cewAplt+HitQki6qWae8RizG6t4LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAA3oDrg8Ktqw9yBCA--.3939S2;
	Thu, 17 Sep 2026 21:53:36 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: hansg@kernel.org
Cc: ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	michaelsh@nvidia.com,
	platform-driver-x86@vger.kernel.org,
	vadimp@nvidia.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] platform/mellanox: Fix i2c adapter reference leak in nvsw_sn2201_i2c_completion_notify()
Date: Thu, 17 Sep 2026 13:53:36 +0000
Message-Id: <20260917135336.2154016-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3oDrg8Ktqw9yBCA--.3939S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urW7Gry8uw1DJw45tw4ktFb_yoW8tr1xpr
	Zruayqvry7Gr4q9FW7Ary7ZF10k3yFgFWYya4Sywn3A3Z09a45Ar98tFyjyr4IqrykX3Z7
	Zwn7Xry5Jwn7Jw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBFb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7MxkF
	7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6x
	kF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07UNTmhUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAENA2qrrJrNkwAAsq

nvsw_sn2201_i2c_completion_notify() takes a reference to the main mux
adapter with i2c_get_adapter(), but when the following
nvsw_sn2201_create_static_devices() call fails the adapter field has
already been cleared by the callee, so the i2c_put_adapter() in the
nvsw_sn2201_create_static_devices_fail path is a no-op and the
reference is leaked.

Keep the adapter in a local variable and release it on that path.

Fixes: 662f24826f95 ("platform/mellanox: Add support for new SN2201 system")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/platform/mellanox/nvsw-sn2201.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/mellanox/nvsw-sn2201.c b/drivers/platform/mellanox/nvsw-sn2201.c
index 92b58ba8f97b..b9d8074a5167 100644
--- a/drivers/platform/mellanox/nvsw-sn2201.c
+++ b/drivers/platform/mellanox/nvsw-sn2201.c
@@ -1172,12 +1172,14 @@ static void nvsw_sn2201_config_exit(struct nvsw_sn2201 *nvsw_sn2201)
 static int nvsw_sn2201_i2c_completion_notify(void *handle, int id)
 {
 	struct nvsw_sn2201 *nvsw_sn2201 = handle;
+	struct i2c_adapter *adapter;
 	void *regmap;
 	int i, err;
 
 	/* Create main mux. */
-	nvsw_sn2201->main_mux_devs->adapter = i2c_get_adapter(nvsw_sn2201->main_mux_devs->nr);
-	if (!nvsw_sn2201->main_mux_devs->adapter) {
+	adapter = i2c_get_adapter(nvsw_sn2201->main_mux_devs->nr);
+	nvsw_sn2201->main_mux_devs->adapter = adapter;
+	if (!adapter) {
 		err = -ENODEV;
 		dev_err(nvsw_sn2201->dev, "Failed to get adapter for bus %d\n",
 			nvsw_sn2201->main_mux_devs->nr);
@@ -1189,6 +1191,12 @@ static int nvsw_sn2201_i2c_completion_notify(void *handle, int id)
 						nvsw_sn2201->main_mux_devs_num);
 	if (err) {
 		dev_err(nvsw_sn2201->dev, "Failed to create main mux devices\n");
+		/*
+		 * nvsw_sn2201_create_static_devices() clears ->adapter on
+		 * failure, so release the reference taken above here.
+		 */
+		i2c_put_adapter(adapter);
+		nvsw_sn2201->main_mux_devs->adapter = NULL;
 		goto nvsw_sn2201_create_static_devices_fail;
 	}
 
-- 
2.34.1

