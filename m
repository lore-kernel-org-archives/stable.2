Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387596;
	b=B/TwMa3yDt1JfJ27nnSngZsLfLwVOAAccSxfpIk/1ZaBMN9x6wXCxX9Pu+QTYoR/IgR8
	 uxhFPeWYODH+aiw0IK5JYTWNnr3vyuxarWoCGPp5F2KkK2bEtwZ4nu6vr7HTlezazF1Ep
	 u3aDtzIZhGjwcgZ9sY68Q8C/iALl4JJkuWYnXYFdzKdr5wTCter2AaAeBHpLX51giR5IN
	 ZNm8OaGWeDIPehAdYU0SH2hDTLqANbEZc+w6auQSyrEPJ9kaX510Agcex1TKgn6NICwEp
	 jXY4ZZVPLqGNJxZm8NSk5UBz60UYkHMFYCBLDenUes54stwA+ImQURcPBrjS3qQCtRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387596;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oAKaluIQ6DHfSI6BiTgUyos806Y3I95pzPEAjUuVIiE=;
	b=1PT6Bj32aLZKryheYgKqT2RYJM+vnMKMoGl+ZdB+kYB++futjkcWXFbeMj+IVnAv0X1x
	 mCg+9NPlrhZkcVNrldLvbbaeNIwo4356DKSb1wBVD6kg6CPwQjMpiQR8JEKM3g1AMl6I1
	 RKVpJZOH1wcycz1Mp7A5wd16WyJ7xm+GN3fRChwIOODteESOzf/uubIAnCGtpcgpV5+HR
	 rQlDmLXPRqIOsVnzkow9mTLdG7ZLwGj1ZfKD87i5ZpJ5shCQYQJJ76J4kvaKe0DTTxvf9
	 DfXRodUXijo+LEwnXtLgQrUBhH28mt3f6lExhwbRLT9ANeuhLL6QFn9ptZNGQbNMnqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=C6qg7oav;
	arc=none smtp.remote-ip=111.22.67.139
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B83D606A326;
	Wed, 11 Nov 2026 08:59:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B83D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=C6qg7oav
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=C6qg7oavpRnI7fJQKUapD8oifWY22JPLzkECfhGsZEw1iP2KUXr+52eANWHb4K6fwfEIJqY2S9DH4
	 mEiQ3TBuqVwp9tlYsx7wi13FMAZq7ppwPE4oOQXzKlYEL0mePjd0m030VTIvu50d8MGsAS5hwBPF2h
	 PMbGAfLRgsLYIS5k=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56af42e89414-d4a7d;
	Wed, 11 Nov 2026 16:59:54 +0800 (CST)
X-RM-TRANSID:2ee56af42e89414-d4a7d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee56af42e88fd9-d644c;
	Wed, 11 Nov 2026 16:59:54 +0800 (CST)
X-RM-TRANSID:2ee56af42e88fd9-d644c
From: Xia Yan <yanxia@cmss.chinamobile.com>
To: Vinod Koul <vkoul@kernel.org>,
	linux-phy@lists.infradead.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Pengcheng Li <lpc.li@hisilicon.com>,
	Jiancheng Xue <xuejiancheng@hisilicon.com>,
	Shawn Guo <shawn.guo@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	yana06070@163.com
Subject: [PATCH] phy: hisilicon: fix UTMI reset leaks in INNO USB2 PHY
Date: Wed, 11 Nov 2026 16:59:42 +0800
Message-ID: <20261111085942.159625-1-yanxia@cmss.chinamobile.com>
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
Content-Transfer-Encoding: 8bit

hisi_inno_phy_probe() acquires an exclusive UTMI reset control for each
child node but never releases it on probe failure or driver detach.
The leaked controls remain acquired, so a later probe can fail with
-EBUSY when requesting the same resets.

Register a devres action after each successful lookup to release the
control on probe failure and detach.

Found during source review of reset-control lifetimes.

Build-tested the driver object on x86_64 with W=1 and reset support
enabled. No hardware testing.

Fixes: ba8b0ee81fbb ("phy: add inno-usb2-phy driver for hi3798cv200 SoC")
Cc: stable@vger.kernel.org # needs of_node_put(child) on <= 6.6
Signed-off-by: Xia Yan <yanxia@cmss.chinamobile.com>
---
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
index c843923252aa..9bf207e3e692 100644
--- a/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
+++ b/drivers/phy/hisilicon/phy-hisi-inno-usb2.c
@@ -132,6 +132,11 @@ static const struct phy_ops hisi_inno_phy_ops = {
 	.owner = THIS_MODULE,
 };
 
+static void hisi_inno_phy_reset_put(void *data)
+{
+	reset_control_put(data);
+}
+
 static int hisi_inno_phy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -169,6 +174,10 @@ static int hisi_inno_phy_probe(struct platform_device *pdev)
 		if (IS_ERR(rst))
 			return PTR_ERR(rst);
 
+		ret = devm_add_action_or_reset(dev, hisi_inno_phy_reset_put, rst);
+		if (ret)
+			return ret;
+
 		priv->ports[i].utmi_rst = rst;
 		priv->ports[i].priv = priv;
 

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4


