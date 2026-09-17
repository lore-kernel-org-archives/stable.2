Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A504E4333;
	Thu, 17 Sep 2026 12:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789647951; cv=none; b=XXeQmat3akt6tyJcTms4UKBtncL4VQMpBDjTBRP6vYitp36yd7ZxyiurCNJwX5f7AHEY0jiDgmakqHoYA/OUgqmkcWyl3JJxnc12ufpNlm2UpMSWbeFvH9hIcCOnczOORDE2Rf8fFpb46xkfk4imZhiZAmyDNLIC2K3OhnuLQgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789647951; c=relaxed/simple;
	bh=6AhwryHkCtCla0U2D/jO3hscbmh+77fa9n2niFCK6w8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V0KljAmO68iqgtX7XJ7VLlsm82alNYwsVIGAS2Zpqbs9FzwtAIs/TZV5JiZr+06k/rsjzjZ4K0Ozwa0oXpfp7zmImxobAQKcxVmQxlEZzaJ5URvHHj+ypoWPSmey25wI55XfPgEVhLpDmDbkeE1QziegQUWhVqWLthWGURmKcF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABXwz083Ktq5XaACA--.43697S2;
	Thu, 17 Sep 2026 20:25:33 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: david+nfc@ixit.cz
Cc: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	mgreer@animalcreek.com,
	oe-linux-nfc@lists.linux.dev,
	sameo@linux.intel.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] NFC: trf7970a: Fix runtime PM leak in trf7970a_switch_rf_on()
Date: Thu, 17 Sep 2026 12:25:32 +0000
Message-Id: <20260917122532.2150988-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXwz083Ktq5XaACA--.43697S2
X-Coremail-Antispam: 1UD129KBjvJXoWrZry8JryxuFyUCw1rCr1xKrg_yoW8JF45pa
	n2qrW5CFy5ArW7t34UAF4vqa4F93s8trW5C34F9a4Iva1rJFy3ta45JF129F10yr95Zw13
	tFyIyr47WasYvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBFb7Iv0xC_tr1lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0E0s8F02x267IIx4CEVc8vx2IErcIFxwCY
	1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48Zr
	WUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6x
	kF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07j0wZcUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRINA2qrq02ZIQABsL

pm_runtime_get_sync() unconditionally increments the runtime PM usage
counter, so the reference taken at the top of trf7970a_switch_rf_on()
has to be dropped on every exit path. The two error paths return
without doing so, and since the chip is left in TRF7970A_ST_RF_OFF they
are not balanced by trf7970a_switch_rf_off() either.

Release the reference the same way trf7970a_switch_rf_off() does.

Fixes: e6403b7c756f9 ("NFC: trf7970a: Add pm_runtime support")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/nfc/trf7970a.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index 08c27bb438b5..07bc336c6505 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -1155,12 +1155,14 @@ static int trf7970a_switch_rf_on(struct trf7970a *trf)
 	if (trf->state != TRF7970A_ST_RF_OFF) {	/* Power on, RF off */
 		dev_err(trf->dev, "%s - Incorrect state: %d\n", __func__,
 			trf->state);
+		pm_runtime_put_autosuspend(trf->dev);
 		return -EINVAL;
 	}
 
 	ret = trf7970a_init(trf);
 	if (ret) {
 		dev_err(trf->dev, "%s - Can't initialize: %d\n", __func__, ret);
+		pm_runtime_put_autosuspend(trf->dev);
 		return ret;
 	}
 
-- 
2.34.1

