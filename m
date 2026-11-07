Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046588;
	b=IL093ypJ+aWJQBjMAyGB7chT7Tpy4Fbcoa8lt3eEK57B2WCpEO9gqsu6g0SPT+w5hJQc
	 jtvGa78q7Bk+DjQZyQgekT7VgVUok8wg5QeqwxdWW4peVyS7aYo+xyw236epFP1pjgjpo
	 slIlVAy/2KQBlgOn986I4w7OX9TnpmaBC1kx4QMffCShOgH5GA6JiJGIbXKmvm7ySgDti
	 iInd4nhG7y5u1LBU8v09ThjZh9zIcmvf5e+HnEUgbxUGGss18/I9pSLN26XHzrXd/34Ck
	 8kIiyobDxMJmHglHpn5U8ZTeIbjL4xfIxTtvN7RhO62i17RjDS+uDsW3T7m84zSUaiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046588;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=/qFqvbFurN4PEJpXMJPKtOAq4hdCyVwSYAR6O028L8Y=;
	b=DfYk2MKOaTPJ+AfvQ3DKdzhcxKuyIFSjOmvt2PagRTf/fmmcClSCwLO89FeMQzPMheW0
	 0vsccaewwDbreJq3BZiVgLVqxox2xfEAUGoNnMINsmdT+0SI2gveFLll/MvLce7V4vlHi
	 EyXikRDb+m+L/Pl0biOSfvm37aOELQdl+zwNJHbYt3uCVJCoWF2/hk2UuXnFgytstcIqL
	 wzyAwFaYu2XtcU4niFU7U6/kmfCHxAZiy0z7l3BHtaHCVtUozBnE3HW+ghxx4/vyiDoAq
	 sm0PGTc/a+XcppGg05ysiftHsPRKg1Wp6fooXEP7vBDwGnS3H2cJTvSjMXxJIsyUKyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S5w+IW73;
	arc=none smtp.remote-ip=209.85.210.49
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C17606D823
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93C17606D823
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=S5w+IW73
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-8470d7d430fso687355a34.3
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 02:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794046587; x=1794651387; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/qFqvbFurN4PEJpXMJPKtOAq4hdCyVwSYAR6O028L8Y=;
        b=S5w+IW73HwNOdviSfxc3ToScB56IBx+6OXe8sIz3hOujOgzKextwtnP4S42U8vbMCR
         7epfL8sFsH5jwQO1O60m5OI5WdVUud6E+qn4Tk3aA4TLJMrhnHchBUFSULwEiTDqnnue
         b5DK7M/XRDH6X/YzGzl3jY3Qrwb2jmZa4dnA3oHkYQaMQaRzCeoeHL//imtOSbT56zXk
         cpfcnqoZBxNr5NRD36h+fk6GK5/Ez4NKZNg+7sM+27ituJGiPcfuX/qyy/ZEQn6OfFm2
         dT5eVrHSx7oTur1Tkb+nNh6LIs/Wk1U4ZncMEL8C7wd/L7tl1+anURIN5/gp1y9bPdBg
         Ll2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794046587; x=1794651387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/qFqvbFurN4PEJpXMJPKtOAq4hdCyVwSYAR6O028L8Y=;
        b=KOakgO2rneOQtEqAhwC4VOaylwSbhhcceBLEgY7e4GZlQPlb8MXt03bK6zHd/b4Hdw
         kM0gpHE+aFQX1p0h542OJQge0zRAoTc3JkjJVlI34MK8jNTleILncSs+nl7ZQO2YqoxD
         PQt7QbZl8e3M9RwSBwBKZ1LMOrlfmGJ45pAnQ44R9iiT0IOw/4127RLlIOfkqXDaeQl0
         m5vXmWIPf8z277vkDTiapR7jfZRhlE6mpAlfDLyO1/TYZREn6BhZ8T1tHVhLywsjBLya
         hKf+9yx0GfYUGEveNM94OHoT9ZcPHH+2MCNpa0UbwauAu3UW6stLN/QdB3XDfLXbs8Jw
         1XFQ==
X-Forwarded-Encrypted: i=1; AKwUvBx3eBsKpfQSbCmYE3xEAd8ZZhS7McTggipA0t1CS3veuFeilf6bEE/g/SJ5g2I2eU26S2WdbAI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9UU7BGIIKU/kfCCwPnjAZKeCNgrpEevKtk7Z1nbsDWqOR2jpTR
	u56/ovLWwWLUC2tQk4zBxYmkF0VDbE99AeJ0YFZV286EptLEH4BClxT1
X-Gm-Gg: AYBFou0KY40LgsA6j7gd4Vnsqa1Yqv1tLKKsaRpVoPp/A13XGRL3zDx8xkQjZmCdB8B
	ejjZ7TC0dhtZRXF8fqDzhjee01dflnKgt/1ffyJ7aCKLxIZX9MeYqnZzoIOChCJZrH3hTmVEgBs
	q01Ef7cG/Ih3vNR24yILj2DUb1tag9FtSclY4Lqw7l1diHN93yW2ViN0n8BzXemBzR6UPgbGtaO
	A/OtZF3UwSfjm1ZmOPgqAczhlhAU05a1HMX4U4GQ1U3Ub+xULVuRb3wYilxMpQhqkIkmJJael9m
	0kibXB3JJZhdTpX/XnMcfXhgDr7StVzmVZOUYXbTccLH3EB2u7ERm8aVlgObMIihUAY35I904J+
	ViONr4Yt9M1LUNn5f0mvylrt70hssoDaMGYgEUpFebuloNivI2dTPMR0VJzjfOxrhfklT6H26RL
	SSehJJRDNd/RZ1uxh8vw4nF84vtFw3x2r2WEDayAl8yewBmzBKhw+yHfEUWxQJ9QRrVKuFNjBih
	LLcfYgofpTwhKUCgh01BI2pTI0wLaGQBZ+k2ygh1K9ilzy/Jvc55kcB5VhDVGnSL4SpvTnc51OO
	HClw1LX2znb9hOHLta65vswuUHU78GWdmmyibWX8eUdBA0EXXbHVHx1tV48qGzuRvLUhyxV43sW
	JAFRTwUV9SqOOGzznMbCNTuTKi3baECcU1S3BqW/6uAXgYOon8pbvFzqdRPEX0r/5GMvfFrmbrB
	Ar69uxBoAovOzhvMRAfKfpeSxxErB8TkYiqhVAYEkrdnFVQcSFny9N
X-Received: by 2002:a05:6830:4101:b0:844:4959:e856 with SMTP id 46e09a7af769-85f1cf2dfcbmr4924112a34.11.1794046587358;
        Sat, 07 Nov 2026 02:16:27 -0800 (PST)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85f1dbef224sm3990269a34.12.2026.11.07.02.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 02:16:26 -0800 (PST)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sat, 07 Nov 2026 03:15:58 -0700
Subject: [PATCH 01/58] mtd: clear OTP provider pointers after unregistering
 them
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261107-submit-rawnand-retained-handle-lifetime-v1-v1-1-0181ef0cc4c8@gmail.com>
References: <20261107-submit-rawnand-retained-handle-lifetime-v1-v1-0-0181ef0cc4c8@gmail.com>
In-Reply-To: <20261107-submit-rawnand-retained-handle-lifetime-v1-v1-0-0181ef0cc4c8@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Brian Norris <computersforpeace@gmail.com>, 
 Boris Brezillon <bbrezillon@kernel.org>, 
 Arseniy Krasnov <AVKrasnov@sberdevices.ru>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Thomas Gleixner <tglx@kernel.org>, 
 Vitaly Wool <vitalywool@gmail.com>, David Woodhouse <dwmw2@infradead.org>, 
 Russell King <rmk+kernel@arm.linux.org.uk>, 
 David Woodhouse <David.Woodhouse@intel.com>, 
 Mike Rapoport <rppt@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Christophe Kerello <christophe.kerello@st.com>, 
 Jason Roberts <jason.e.roberts@intel.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Mason Yang <masonccyang@mxic.com.tw>, 
 Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>, 
 Stefan Agner <stefan@agner.ch>, Lucas Stach <dev@lynxeye.de>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>, 
 Heiko Stuebner <heiko@sntech.de>, Yifeng Zhao <yifeng.zhao@rock-chips.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Keguang Zhang <keguang.zhang@gmail.com>, Jacky Huang <ychuang3@nuvoton.com>, 
 Shan-Chun Hung <schung@nuvoton.com>, Frank Li <Frank.Li@nxp.com>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Han Xu <han.xu@nxp.com>, 
 Liang Yang <liang.yang@amlogic.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Kamal Dasu <kamal.dasu@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Vladimir Zapolskiy <vz@mleia.com>, 
 Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
 Paul Cercueil <paul@crapouillou.net>, 
 Harvey Hunt <harveyhuntnexus@gmail.com>, 
 Maxim Levitsky <maximlevitsky@gmail.com>, Michael Walle <michael@walle.cc>, 
 Srinivas Kandagatla <srini@kernel.org>
Cc: Tze Yee Ng <tze.yee.ng@altera.com>, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
 linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-mips@vger.kernel.org, imx@lists.linux.dev, 
 linux-renesas-soc@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-msm@vger.kernel.org, James Hilliard <james.hilliard1@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2

If factory OTP discovery or registration fails after user OTP was
registered, mtd_otp_nvmem_add() unregisters the user provider but leaves
its pointer set. mtd_device_parse_register() then unregisters it again
while unwinding the error, accessing a freed provider or dropping a
reference still owned by a consumer.

The same stale pointer survives when the factory OTP error is
-EOPNOTSUPP, which mtd_otp_nvmem_add() treats as success. In that case
mtd_device_unregister() can release the provider a second time later.

Centralize removal of the OTP providers and clear each pointer after
unregistering it so subsequent cleanup cannot repeat the put.

Fixes: e0489f6e221f ("mtd: core: fix error path for nvmem provider")
Cc: stable@vger.kernel.org
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/mtd/mtdcore.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 8efa2d88556e..558a605ba749 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1016,6 +1016,14 @@ static int mtd_nvmem_fact_otp_reg_read(void *priv, unsigned int offset,
 	return retlen == bytes ? 0 : -EIO;
 }
 
+static void mtd_otp_nvmem_remove(struct mtd_info *mtd)
+{
+	nvmem_unregister(mtd->otp_user_nvmem);
+	mtd->otp_user_nvmem = NULL;
+	nvmem_unregister(mtd->otp_factory_nvmem);
+	mtd->otp_factory_nvmem = NULL;
+}
+
 static int mtd_otp_nvmem_add(struct mtd_info *mtd)
 {
 	struct device *dev = mtd->dev.parent;
@@ -1082,7 +1090,7 @@ static int mtd_otp_nvmem_add(struct mtd_info *mtd)
 	return 0;
 
 err:
-	nvmem_unregister(mtd->otp_user_nvmem);
+	mtd_otp_nvmem_remove(mtd);
 	/* Don't report error if OTP is not supported. */
 	if (err == -EOPNOTSUPP)
 		return 0;
@@ -1180,10 +1188,8 @@ int mtd_device_parse_register(struct mtd_info *mtd, const char * const *types,
 	}
 
 out:
-	if (ret) {
-		nvmem_unregister(mtd->otp_user_nvmem);
-		nvmem_unregister(mtd->otp_factory_nvmem);
-	}
+	if (ret)
+		mtd_otp_nvmem_remove(mtd);
 
 	if (ret && device_is_registered(&mtd->dev)) {
 		err = del_mtd_device(mtd);
@@ -1210,8 +1216,7 @@ int mtd_device_unregister(struct mtd_info *master)
 		memset(&master->reboot_notifier, 0, sizeof(master->reboot_notifier));
 	}
 
-	nvmem_unregister(master->otp_user_nvmem);
-	nvmem_unregister(master->otp_factory_nvmem);
+	mtd_otp_nvmem_remove(master);
 
 	if (IS_REACHABLE(CONFIG_MTD_VIRT_CONCAT)) {
 		err = mtd_virt_concat_destroy(master);

-- 
2.53.0

