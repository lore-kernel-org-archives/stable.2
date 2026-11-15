Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.222.135.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794778896;
	b=zVWfkFMp3QzZiS9JfkTTmiNDo8HWRxtJmWrEzqjMSmGUb61yUgnTRkonZKbxrLZ7OEQj
	 K8hkIZGr+Fzz9e6CAy1EZKiDswUxpBYbCDNXOywdc7FWUzDAOae1hpLQZvAQ3Kwe/EV1J
	 l9xFPWtEG7hLYaG1iZBZaq5RwuGf1HLq6LEZ5BZI8vaMNofsQlaNFVzJc3+IOXE20G3f7
	 UDawenAflEbSylyKeNZ+RQrCO6qSGbYBsZ+AzCCpXhXXQjzhaZoPm/9IGLJjMrOsyEuY7
	 iLG6onF7VdUSgf2SSF5vDdJLugUV95VXNhQly5MTPmsw25SHqO77h6nGAEHtrklJQ5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794778896;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-WP-MailID:X-WP-AV:X-WP-SPAM;
	bh=EX/WMz4K9+MmwON2KxDxCyPiS2fPCwq6MkZjWtu8Bxs=;
	b=c0BM3vDWFpNtTWVUNQgQgzKUkVlmf3Mo39zpqmrhPm90ZP0UftI20qFwlhlT5nm3dnjX
	 urae5+powkd1LrWcgBbbcWXbLC2tH8HSyyBK0wwlg/NzU1HQabITkWj2rFo/+ZKxI6U56
	 xBk44eJb/tf7UVP+nE3IMN33jopEIhckHHJXT4jw+HNFrl+IwZQei7GHq24vZ9Q+Veo0E
	 WBug8xMv7qsEizG6pWXBo6U5rINKOBkpwUkzCegFlVUkkSoyA1ruNGaftZEbzv7bS8vhy
	 AX0Kr9VjrkUFYWisOsftQPSH4u5pAPfFk5YTxXixKeaBynbhLR5DvRuff3Qz2p4Ta3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=o2.pl;
	spf=pass smtp.mailfrom=o2.pl;
	dkim=pass header.d=o2.pl header.i=@o2.pl header.a=rsa-sha256 header.s=s20261001 header.b=F+aVCR5W;
	arc=none smtp.remote-ip=193.222.135.145
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C161D606A329
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 21:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C161D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=o2.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=o2.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=o2.pl header.i=@o2.pl header.a=rsa-sha256 header.s=s20261001 header.b=F+aVCR5W
Received: (wp-smtpd smtp.tlen.pl 8488 invoked from network); 15 Nov 2026 22:41:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=s20261001;
          t=1794778886; bh=EX/WMz4K9+MmwON2KxDxCyPiS2fPCwq6MkZjWtu8Bxs=;
          h=From:To:Cc:Subject;
          b=F+aVCR5WEgfGfW4Hx/2FONXc0DcjhxOXc497DRK+dEVu2KBhQMvx7dlduIpCdFR2y
           01soBL3a6l78QIt5h+GfHEWbB+u5+5YxbHltabdzRCL3OJRzJsQCowr+Y5xzed4j05
           +XuMNgoIznjaAfVobDjSdOYVhfReS2rNKLz9H3vugz8LiK/1cgcDkiOM32GzvcbjfO
           2lQkNYSfaF1eABupwQq+f33k1v/cxB+nSHmV4eM+Zo+eByPnweSr7z3uGUQvgct2WO
           4HWBT16OS/LKe48NMqkmagh7a7TJc23gJVfESz/WKXhEUE4ZV/VI8oKtSsfE6EJCpV
           uRZoty0rIv1QA==
Received: from localhost.localdomain (apn-78-30-67-84.dynamic.gprs.plus.pl [78.30.67.84])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with SMTP
          for <andrew@lunn.ch>; 15 Nov 2026 22:41:26 +0100
From: =?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
To: Andrew Lunn <andrew@lunn.ch>,
	Javen Xu <javen_xu@realsil.com.cn>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jakub Kicinski <kuba@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Mateusz=20Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
	stable@vger.kernel.org
Subject: [PATCH] net: phy: realtek: fix listing of sysfs directory tree
Date: Sun, 15 Nov 2026 22:40:45 +0100
Message-ID: <20261115214045.3704-1-mat.jonczyk@o2.pl>
X-Mailer: git-send-email 2.47.3
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
X-WP-MailID: df77d61d8830132bd5de278ca3bd0916
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 000000B [ATMk]                               

On git master, listing the contents of sysfs produces an error:

	root@mateusz-debian:/sys# LANG=C find -iname foobar
	find: './module/realtek/drivers': Input/output error
	root@mateusz-debian:/sys# LANG=C ls -1 ./module/realtek/drivers
	ls: reading directory './module/realtek/drivers': Input/output error
	'mdio_bus:Generic FE-GE Realtek PHY'
	'mdio_bus:RTL8201CP Ethernet'
	'mdio_bus:RTL8201F Fast Ethernet'
	'mdio_bus:RTL8208 Fast Ethernet'
	'mdio_bus:RTL8211B Gigabit Ethernet'
	[...]

Investigation shows that the forward slash in the driver name is the
culprit. Fix it.

Cc: stable@vger.kernel.org
Fixes: f0667918d5fc ("net: phy: realtek: add support for RTL8261D")
Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
---
 drivers/net/phy/realtek/realtek_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index ca2d515b77b3..a39ad18382f2 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -3483,7 +3483,7 @@ static struct phy_driver realtek_drvs[] = {
 		.write_mmd	= genphy_write_mmd_unsupported,
 	}, {
 		PHY_ID_MATCH_EXACT(RTL_8261C_CG),
-		.name			= "Realtek RTL8261C/D 10Gbps PHY",
+		.name			= "Realtek RTL8261C_RTL8261D 10Gbps PHY",
 		.probe			= rtl8261x_probe,
 		.config_init		= rtl8261x_config_init,
 		.get_features		= rtl8261x_get_features,
-- 
2.47.3

