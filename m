Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794210437;
	b=271ugOGs9+UgCrJDThjZd+MElpOU5b3B8GfkK0RwPUbS6jmOHOXjBYQcmP0wJ6yUX59Q
	 EqYe/1QLigbEB8UK7k7m2YGfyNiITn0U9my1FhN1xni4Y8poFKgYJkMmFEPjPNeFORBI9
	 sjoQBWvc3FupDxZgGGjOxLmv5ICRohS/5aV0SHw+bNf0ssKkUjBn6z99hNRapd1HI5jha
	 W5aiXggplLacDXtNO47hZdo/qlvwgFN/QcER1Hw5XBDYSTEqDNbMhGE3KRID58V7YGOzR
	 2v9Cq9lHDlj4Gc2haSobANMYRL1QbBrkz6zoAOHeZa3FdBKPGJL/+I+rVEtojxgC0lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794210437;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wcNJBL8r3eqZLGdixuue/E66/q3aPXI9Ib5nZZGKldU=;
	b=fiSFXJgCHWcjOKz9ExHw5yQEqis7rUdnnXxYvCH7VxpSLAhaV/eSX2jI0NMgbFe/yIEL
	 +NUJfqtibIqBlnwE2PrIlkqeubrfzvv0vSIFW98lTPkBTroBWoow/418Wht/1HuNNXQWR
	 Kr/zuP55I8kE+Ew+tCuYH3FOi4oc7q0vTGxPzCrR9sh9puhP7Via2S1F77nudywk2KRdi
	 7/clOjR+JBgNofWQUmmvwebT5Drqf7b9+aOIKB1c79BQNXHJiWuS7YX8OnLleSPzIR/uV
	 HGDDvxa+cBNuwiBsemcy2B6iO/6SmJOCwAiUFNYGWB5bAfgS6LHNo92h+eQJP/Fgp0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Las7e4Vg;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2183606A321;
	Mon,  9 Nov 2026 07:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2183606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=Las7e4Vg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=Las7e4Vgly68Tt4yJqjL339PowSdWRW3Byu/eHeiNLsdjTahV0B7oWUaVHD/BKoEYuurQhxIIuYdz
	 XYjc2m1tl0PAtXSUxlGlxAqvAA2abg99eaaNc8k0vS8NG21+ccHGy4Dp7RiczOFSTPFxynBJ21Ga7W
	 24D2QC+6psXQbef8=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee76af17a81ddf-c362b;
	Mon, 09 Nov 2026 15:47:14 +0800 (CST)
X-RM-TRANSID:2ee76af17a81ddf-c362b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181456177947 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26af17a8063c-87106;
	Mon, 09 Nov 2026 15:47:14 +0800 (CST)
X-RM-TRANSID:2ee26af17a8063c-87106
From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
To: Vinod Koul <vkoul@kernel.org>,
	linux-phy@lists.infradead.org,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-tegra@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	stable@vger.kernel.org
Subject: [PATCH] phy: tegra: xusb: fix OF node leak on lane probe failure
Date: Mon,  9 Nov 2026 15:47:11 +0800
Message-ID: <20261109074711.1751-1-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
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

tegra_xusb_pad_register() obtains a reference to each lane node via
tegra_xusb_pad_find_phy_node().  On success the reference is
transferred into the lane (lane->np), and the disabled-lane and
phy_create() failure paths drop it, but the pad->ops->probe()
failure path (e.g. tegra_xusb_lane_parse_dt() rejecting the
"nvidia,function" property) jumps to remove without dropping it,
leaking one node reference per failed lane.

Drop the reference on that path, mirroring the phy_create() failure
path right above.

Fixes: 53d2a715c240 ("phy: Add Tegra XUSB pad controller support")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
---
Verified against current upstream master.  Not runtime-tested (no
Tegra hardware).

 drivers/phy/tegra/xusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
--- a/drivers/phy/tegra/xusb.c
+++ b/drivers/phy/tegra/xusb.c
@@ -234,6 +234,7 @@ int tegra_xusb_pad_register(struct tegra_xusb_pad *pad,
 
 		lane = pad->ops->probe(pad, np, i);
 		if (IS_ERR(lane)) {
 			phy_destroy(pad->lanes[i]);
+			of_node_put(np);
 			err = PTR_ERR(lane);
 			goto remove;
-- 
2.39.2



