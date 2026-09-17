Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F564E2F2C;
	Thu, 17 Sep 2026 12:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646836; cv=none; b=Zgw+MKYOtlDxDL8qIWCQQmnQ1Y0oCMUzPJk3dFPKgX8+yZABIKBtGQ2FVYoPGue2Kk6nYb85d2pd/L+ZTluGyKSKcgnmy/BdbmHBN/RM+hNh/MU4UvE89ntslIsobKCEHJ4XhzXFH2ZA+1p/SP5v0rHlPsXdMMfkpSTVKAe38l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646836; c=relaxed/simple;
	bh=f7srqLu1h83HdEaD88Sx+Rqz7zm2SSg0NGUw51yfPOs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gMIPkIuDz4fWWNxAVH+PdVRpvh51ps8NoAXTadTydj5EEh3RDr5txM8We3SBNojPz/bcNWkGmPDWBPTxzUacowVA9+muZJxNTOaFUHfzy8zOkdxlTs33yJlBfMfu6IjK+C1FXmHY/1kP9F2fL3WesCpf4QgGg7DleWGjEXCvcc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAC36ELq16tqwyyACA--.2391S2;
	Thu, 17 Sep 2026 20:07:06 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andersson@kernel.org
Cc: kvalo@qca.qualcomm.com,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	loic.poulain@oss.qualcomm.com,
	wcn36xx@lists.infradead.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: wcn36xx: Fix tx-enable state leak in platform_get_resources()
Date: Thu, 17 Sep 2026 12:07:05 +0000
Message-Id: <20260917120705.2150455-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC36ELq16tqwyyACA--.2391S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWktryrGw4rtw15KFy8Krg_yoW8Aw1xpr
	WxG3yFkr10yrWxJrs7Kr4Uu3yfWa1qkrWqgrZ2yws3ZFn8AF95tr1DXFyDZr1jyFy8X3W7
	AF4jyF47WasxAwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0E0s8F02x267IIx4CEVc8vx2IErcIFxwCY
	1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48Zr
	WUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWxJr1lIxAIcVC2z280aV
	CY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuYvjxUgoanUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRQNA2qrq02OaAAAsS

wcn36xx_platform_get_resources() gets the "tx-enable" smem state, which
holds a reference, but only the wcn36xx_remove() path releases it. The
reference is leaked when the tx-rings-empty state cannot be acquired and
on every error path after that. Release it there, and route the missing
"qcom,mmio" property to the common cleanup label so all error paths drop
it.

Fixes: f303a9311065 ("wcn36xx: Transition driver to SMD client")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index c3f0860873de..f34d64464f64 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1502,13 +1502,15 @@ static int wcn36xx_platform_get_resources(struct wcn36xx *wcn,
 			"tx-rings-empty", &wcn->tx_rings_empty_state_bit);
 	if (IS_ERR(wcn->tx_rings_empty_state)) {
 		wcn36xx_err("failed to get tx-rings-empty state\n");
+		qcom_smem_state_put(wcn->tx_enable_state);
 		return PTR_ERR(wcn->tx_rings_empty_state);
 	}
 
 	mmio_node = of_parse_phandle(pdev->dev.parent->of_node, "qcom,mmio", 0);
 	if (!mmio_node) {
 		wcn36xx_err("failed to acquire qcom,mmio reference\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto put_mmio_node;
 	}
 
 	wcn->is_pronto = !!of_device_is_compatible(mmio_node, "qcom,pronto");
@@ -1552,6 +1554,7 @@ static int wcn36xx_platform_get_resources(struct wcn36xx *wcn,
 	iounmap(wcn->ccu_base);
 put_mmio_node:
 	of_node_put(mmio_node);
+	qcom_smem_state_put(wcn->tx_enable_state);
 	return ret;
 }
 
-- 
2.34.1

