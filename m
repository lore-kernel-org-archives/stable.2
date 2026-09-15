Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580CF3CEB99
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 02:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437739; cv=none; b=uzqYaRZWNkIAJb5i14EcVZTdEnIc9YSgMdagtkxON+maD4I9FQO1LElgRclazM0WWffbkubNnWxIMstyk+lhJCu8hdgNJPg1eqNLIpLuCVAVWj5U/Hjlw2Xt21ysplUrpEEGIUKKeuolLu0eRbLWPGOC9hxU1VydbfuxTiw3/Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437739; c=relaxed/simple;
	bh=9kGKsaAo2kA1qFBiYQUe0iHybsQYYEdGYH5qAdbCdxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HCwXIWtdMvSFoWxq1SRjhjSveZ935cKPm8FburX7u9HwTs+wxxuPw6XbFU7C7BQheYZ8leyCIFt+tp8HQ8klcN6Q8Qdtase2T6BLINJN2SPGxkGb0S+z0Oxj6B3YArCvzbFJuYT2ssvZSBp1kKzY+L28Nb2Bee4PjXGRgXNL/Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pVKxxEDT; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVKxxEDT"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfc9b6e3so37216696d6.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 19:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789437737; x=1790042537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iceODlE59LZgcWKBaJw9C8XVX53Oy1oOaAJoPg+TsVs=;
        b=pVKxxEDT/b2b8VTGOkzZnu6t1PfGX83EvQusnDbL30mJfWFC9U22UgTMgT5rEiDst9
         5cNyPWBqKSRfB7icV7W+UW5xiFAapkKyVtvMv6kX92YiC9eZPklWrYoWhG785oi5e/fH
         f0+UUOyWqQqEMf9iw0p/TNThRhmXrjKakNoPigUQkQWZd/OinaDJriUaI09hmLqjK5L3
         pS/GspvjvmQLp53EP3oKKOOCqxM9H2idZB5tNVlEYhFsXN9FiTw3/FazQSrl9AvDPdbq
         QqWK8+kTMYVqGBbB78zl33nFxlTOtUuVaUX/kjC6jhIxni1Xc0QDqyBlRE0VRP9t5jhO
         qzQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789437737; x=1790042537;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iceODlE59LZgcWKBaJw9C8XVX53Oy1oOaAJoPg+TsVs=;
        b=IyslWjjkHBcjAPol7TyiqjWRd1IusGbI1x0dbo5Tb0BT9meSVzIEIzYvHPNMi3DrFF
         Q7Uo8phfK62ckWM/ko7ak/NiuVEjkPp4boEuSyoyGuC03Y3R9HRUtAFlI/KOrSLJbzL8
         lDDIWFRrT9MI4T4cDyS+72B/GRNpnm1nnMH/0Z3Ga67dGEy30BKNlygDyNzwyIhzkt1J
         o9DiZt9NpU4S+pBvOkUOVhbxNqtavRNuGomFZowcUaWQUTMuV5w1SdAOPiM2HgR+nr2A
         cTCri+yifLbAWlfJPHZJQkSbHztR/TUtwzsSGA83T62rLRIM4dwMnICqnwGML04xJp6f
         flZw==
X-Forwarded-Encrypted: i=1; AKwUvBy9G69QtwBU+WrlU7SxmuKzHNGJPV/37W7jdghkdLb2RdRo3SE2/iNsQRXoHkudiHVKvH07xFc=@vger.kernel.org
X-Gm-Message-State: AFuF++nHrtpO6ViZ348Hr8Jr/LoH772ufgUgxXYQ4jjSnyaJ9T2eWelM
	l7PAJrNpde0FJwaTtsqnkrhTI+QIn7aVpiLFKPLIilQ6o+OPfWuLugA=
X-Gm-Gg: AYBFou0Ohzj/mRl8ptzWVq4sp+xMRmr6Arv5HSO9fscKJLUiKd9pN8A0oFt/ICQp4WH
	PVo2HXG7krDSJttRrVPdvgM2uMRi691F9JtYS1qfFaccwYTJtQzhTILR91OliWYELHX7rNahQeP
	FvRHT0t6SnJSmfYWa+C5hhcwb+Ax8bFK3z4ClgEYC4TMONO+LQqOtmj4wWYF+foefW5Q/hk+nHG
	WF3oB1gFpGt4xcGJ3+m/St69my/4h0qdBoMjwPVpKIb9oM3wJbvTezGQQeQZFe/fh1AF8e8jWzQ
	aqnrKuZEL4fisdalRW96xRzchDohlGBmszya3HrlAft5ilsMSJcu7TW2BRHpfEuSR1Xez0RnrJ7
	HdVaFB3Da3xic5wqjIDxBdSDudNPU+PgJ1dbWY8YyVnCNpJEPlPU3bndeyCjnVEdAVNX1qYYUBm
	zjSB3FqyT14uDGci33BsJO/f/qsZ8HLLHR26McQQXUp3OzQSWXUMJii7l4XUhK3QQB/z8c/b1QC
	PMqAQFQW1EkcW3E+xJg/yWtnN2awC5Kkgaicnh+Us6WNxeombSaFMBMl6q0z32b+iMEdKoVVjOd
	GGTvpDX659KngMPUU4L1zJVredi76l7suUCsbISxe676g1PvIRXG88YlOzxmADh7/qgPkCuJtNs
	X8nNS
X-Received: by 2002:a05:620a:4620:b0:93a:1101:a21c with SMTP id af79cd13be357-93a299f084bmr785854485a.25.1789437732441;
        Mon, 14 Sep 2026 19:02:12 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939f19f94a1sm1022872285a.42.2026.09.14.19.02.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 19:02:10 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Ion Badulescu <ionut@badula.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net: starfire: Disable PCI device on probe failures
Date: Mon, 14 Sep 2026 22:01:50 -0400
Message-ID: <20260915020150.87982-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

starfire_init_one() enables the PCI device but leaves it enabled on
subsequent probe failures. Route all failures after successful enablement
through pci_disable_device(), preserving the existing error codes and
resource unwind order.

This issue is already present in the initial Git import; its pre-Git
introduction is unknown.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/net/ethernet/adaptec/starfire.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/adaptec/starfire.c b/drivers/net/ethernet/adaptec/starfire.c
index f1109d9..f7bd765 100644
--- a/drivers/net/ethernet/adaptec/starfire.c
+++ b/drivers/net/ethernet/adaptec/starfire.c
@@ -638,6 +638,7 @@ static int starfire_init_one(struct pci_dev *pdev,
 	void __iomem *base;
 	int drv_flags, io_size;
 	int boguscnt;
+	int err = -ENODEV;
 
 	if (pci_enable_device (pdev))
 		return -EIO;
@@ -646,12 +647,14 @@ static int starfire_init_one(struct pci_dev *pdev,
 	io_size = pci_resource_len(pdev, 0);
 	if (!ioaddr || ((pci_resource_flags(pdev, 0) & IORESOURCE_MEM) == 0)) {
 		dev_err(d, "no PCI MEM resources, aborting\n");
-		return -ENODEV;
+		goto err_out_disable;
 	}
 
 	dev = alloc_etherdev(sizeof(*np));
-	if (!dev)
-		return -ENOMEM;
+	if (!dev) {
+		err = -ENOMEM;
+		goto err_out_disable;
+	}
 
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
@@ -818,7 +821,9 @@ err_out_free_res:
 	pci_release_regions (pdev);
 err_out_free_netdev:
 	free_netdev(dev);
-	return -ENODEV;
+err_out_disable:
+	pci_disable_device(pdev);
+	return err;
 }
 
 
