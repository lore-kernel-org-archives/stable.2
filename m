Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321159;
	b=uC58SkwsH7F4xCCYTylfX9xWkoy32UsSeiXfbJE49yQCKQwDsVaJH1DzxDTadFcNZGhf
	 8g6JVbXQsm/+gcSBrdZvKnJVCsjMesHpBJ1fc9iV+FtqBH2x5uqxbpWERoDuRMEaaIuAn
	 IaUBDyYoZh3lBe9OpjPRzKu/suVMZvojUHy1BAdCS/3oNWa+vogMPEQDR2uaVZcv0wVGd
	 AKN8iwN8FfKxHjrPBFfRvxjIn3STm7YegZZ4WaPs3T7bAHvl7TxkF+2sZu6IbjynAoXIn
	 xA1zD+kWBW6Fq2puODVU015kA2S7eOSh2S6qNZvNfjnJeZBmp0YV5wbYEwS4mXx3GDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321159;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=LGVJZGIzBqq23FRuwiA17JN76P7yNaAe68+qJxIW3Fc=;
	b=UiPZfmZ+edVDpos5eW7p8P62acxSCfnpBZaP03IS69CqKmh0FfOIQk9vJ0gQoVWlKyvW
	 810vw44WV6+5ckdFQfEI7uNAqEcKM33IYakd5t4rLC/VZdZzdSYPHDrfvZx0bmDwzOaUP
	 BirR1ikEavJUtH+6qPgqDQfRbruG/TJ69iTBm4llfbA34PoB8g3jpybQf7B0z998D3c7B
	 uYnDIQ+oYvhroPZcZYrJTyJHk1hZtosX0fxJhYFEUgy/pNXtadnhe7I6BW/qXh82/s0nE
	 1EWyobdng9Z/XE/n73vr8O6XOP0/jYtHa8yo6K75hpr/DR5H/CtMpIT/MuZHWQTVb7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=MWk+1hke;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE6660A260C;
	Tue, 10 Nov 2026 14:32:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBE6660A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=MWk+1hke
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 542cd9c45;
	Tue, 10 Nov 2026 22:32:26 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] phy: rockchip: inno-hdmi: Fix potential stale clock provider
Date: Tue, 10 Nov 2026 22:32:25 +0800
Message-ID: <20261110-9f141e6bc8-phy-rockchip@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1c5dfe33a03a1kunmc234772916cdd1
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTE1KVkJCH05NTkJJTEsdQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=MWk+1hkeivr0+ehsU/vkIeW+yDKau72EylflaaUK3n/vIRt3Sb22ZK3MlhztmYNAr2fXEcGc+P8+4i3gk6Q5SGW0nRfhG3Sf2VG5fWU/g9VtPx8yLWjjzS27bGUB/bvwGGpR5RDsVqzzePCKikUrUGWBISLhEp5R3q1UKm9ztQs=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=LGVJZGIzBqq23FRuwiA17JN76P7yNaAe68+qJxIW3Fc=;
	h=date:mime-version:subject:message-id:from;

The clock provider remains registered if PHY provider registration fails.
Device-managed cleanup then frees the clock hardware and PHY private
data still referenced by the provider.

Use a device-managed clock provider so both probe failure and removal
unregister it before the clock hardware is released.

This issue was found by our static analysis tool under development.

Fixes: 53706a116863 ("phy: add Rockchip Innosilicon hdmi phy")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/phy/rockchip/phy-rockchip-inno-hdmi.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
index d2c2b17df5f3..09608f204798 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-hdmi.c
@@ -1068,7 +1068,7 @@ static int inno_hdmi_phy_clk_register(struct inno_hdmi_phy *inno)
 		return ret;
 	}
 
-	ret = of_clk_add_provider(np, of_clk_src_simple_get, inno->phyclk);
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, &inno->hw);
 	if (ret) {
 		dev_err(dev, "failed to register clock provider: %d\n", ret);
 		return ret;
@@ -1454,11 +1454,6 @@ static int inno_hdmi_phy_probe(struct platform_device *pdev)
 	return PTR_ERR_OR_ZERO(phy_provider);
 }
 
-static void inno_hdmi_phy_remove(struct platform_device *pdev)
-{
-	of_clk_del_provider(pdev->dev.of_node);
-}
-
 static const struct of_device_id inno_hdmi_phy_of_match[] = {
 	{
 		.compatible = "rockchip,rk3228-hdmi-phy",
@@ -1472,7 +1467,6 @@ MODULE_DEVICE_TABLE(of, inno_hdmi_phy_of_match);
 
 static struct platform_driver inno_hdmi_phy_driver = {
 	.probe = inno_hdmi_phy_probe,
-	.remove = inno_hdmi_phy_remove,
 	.driver = {
 		.name = "inno-hdmi-phy",
 		.of_match_table = inno_hdmi_phy_of_match,

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
