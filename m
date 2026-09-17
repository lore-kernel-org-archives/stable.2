Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F30E5437E1;
	Thu, 17 Sep 2026 13:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652799; cv=none; b=qgy+EjN2cywBe3XHSAs0Aoy2lB2sL/HVzRapYnl0HjKcPwKjkTSxWO76AqFH+xn0jvaLvQVEWa9I+ovy30BNO9q5yrrEU3Ut3P2S4OLI5yJszRXUSiMHHERAFOqO8xZpfecUC4h4NVeWMXVfDjlynBMkDFncDv7o9MUu1FEnhL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652799; c=relaxed/simple;
	bh=EtliLkwSx0v6AfsHNx6DymF6ue055oDkMqBSjAKzOYs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=na0HrBxQKzMTSV4e8m01r+oN/246EWVMFsL0xG1P+QgMiFNVAYWZeYceqvzDpBI9LS2p1TvpfwTFBODctc4fcgzyNMGRWGQYiVSmRRpGj8PF6UPvrJRvmwITtHnl/TcthVAlngiPnmXIoQEiFEGUFIBWGGW6Hema4+IR1oTaGcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACH7zkz76tq6sCBCA--.4006S2;
	Thu, 17 Sep 2026 21:46:27 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: bivvy.bi@rock-chips.com
Cc: heiko@sntech.de,
	kishon@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	neil.armstrong@linaro.org,
	vkoul@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] phy: rockchip: inno-dsidphy: Fix runtime PM leak in inno_dsidphy_power_on()
Date: Thu, 17 Sep 2026 13:46:27 +0000
Message-Id: <20260917134627.2153845-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACH7zkz76tq6sCBCA--.4006S2
X-Coremail-Antispam: 1UD129KBjvdXoWrur18ZrykKw4kCr43Gry8Zrb_yoWkXFc_K3
	4fXwnrZa10vF4ruan8t3s3u34qyF1qgw4xWa1Iya43Aayqyw1FqFWfuwnxAFyDXF47Cr47
	Gw1qva47CrZxKjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbg8YjsxI4VWkKwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1lFIxG
	xcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42
	xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02
	F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GF
	ylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	W8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZEXa7I
	U5o5l5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwYNA2qrrRnFrgABsQ

inno_dsidphy_power_on() resumes the device with pm_runtime_get_sync(),
but the default case of the mode switch returns -EINVAL without
dropping that reference.  The matching pm_runtime_put() lives in
inno_dsidphy_power_off(), which the PHY core does not run when
power_on() fails.

Release the runtime PM reference before returning.

Fixes: b7535a3bc0ba ("phy/rockchip: Add support for Innosilicon MIPI/LVDS/TTL PHY")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c b/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
index 30d5e5ddff4a..5a7962af946b 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
@@ -672,6 +672,7 @@ static int inno_dsidphy_power_on(struct phy *phy)
 		inno_dsidphy_lvds_mode_enable(inno);
 		break;
 	default:
+		pm_runtime_put(inno->dev);
 		return -EINVAL;
 	}
 
-- 
2.34.1

