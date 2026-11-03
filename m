Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.36.163.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744090;
	b=TT0LWyk2Ndhk9Bh3imQUM4yiZu2Zz2iIyv13xZroLy6Cvez9dCxDt6Z7Yj/6BTeft1lw
	 byo/XXAXgUsJs7qLzh7nnd+Hg37WU9ANuQkXMcM69tj727+2/IQhAjAL6GLoG7/KK44gx
	 8DmWOmC0n6Q6j9KH8Fc/uU9yayZqf9ULZ9g16MFuubE23zsdfXkpQPmyiXJbNvHXXxZ9z
	 nUX+DrawcGD6v+w/usQR1IokZiqM73m6OTGE8APJ+o9Afa/vO76R8i1eCTXpAtswYPwtD
	 amCEb2npFOc+43FeNxe+2qM+iNXU5nSoCY+2Cw8OtGazmvF77MYyyZF8hfRW1qSJpeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744090;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-SEG-SpamProfiler-Analysis:
	 X-SEG-SpamProfiler-Score:x-atlnz-ls;
	bh=tr2XYt+rQawaJdTAFA7Un12tgCTvUH+cv9g9vRpJbIw=;
	b=Espu81KmpNohHMDmnA2qB9AO4987Y033RHpuKzPYA4Ep/JA4GUAqm9S4SMb2bPjCM+4R
	 QxcW6CTy1iS4hRMUqJSOgpWSwRZYum6VKcUFZ9Q6QNKLJIRJnAzhQv7noknkyzNyxd81s
	 FLCo6oHn1RB8plquY7zKxWfERAEHahkCXBsZ+lajkZzXrPVLkFCLrASkH230G2V72Ku8a
	 yvEtY36fdhSSu4zdBjTbGHZgyQ16ppEjVKeNuSCt8PVZWYm2fjNmzpeXU266PCRo3MSj1
	 T1mNcMDExiZ8fC49tG/Oh++VwDcRpGk/CL8UE3/6//5vG+w+K732Bf6rbZhYnR1o66w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alliedtelesis.co.nz;
	spf=pass smtp.mailfrom=alliedtelesis.co.nz;
	dkim=pass header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.a=rsa-sha256 header.s=mail181024 header.b=pRsrycO4;
	arc=none smtp.remote-ip=202.36.163.20
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBFA606A32D
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 22:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CBFA606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.a=rsa-sha256 header.s=mail181024 header.b=pRsrycO4
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id DFFC52C04EA;
	Wed,  4 Nov 2026 11:14:46 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1793744086;
	bh=tr2XYt+rQawaJdTAFA7Un12tgCTvUH+cv9g9vRpJbIw=;
	h=From:To:Cc:Subject:Date:From;
	b=pRsrycO42lAxtTkFSDZtNuMG1mbcDj7RTa0TYmAvNwLOYWBgibUTwV1aO7DjB8jdy
	 uYkkaMbO3K0UOc4Ldax+lYtdG9VscE18ums6t+tWW5fgMfIeWsmuK8AJ2c3SGX+S5R
	 JRl+tNRDjge3Q260ddRMHxyg+Trr8szWYMx6CDFoTqN8uNpoIxDPMvdWUwwIduzkf3
	 OV17w+/rX/Px2mS9TapIQuwjR1FtZDQrIHtMXRAIiEkCiZxD2LNZj+zADNG9VyW3XZ
	 p7MTRA09VF68m9JS0YqRUtGsABnX2Xsf2E/ty5jhDvK5lT9sN0CB9X2nc+x9ys7eCI
	 AC1KPM+SoGArg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6aea5cd60000>; Wed, 04 Nov 2026 11:14:46 +1300
Received: from joshuas-dl.ws.atlnz.lc (joshuas-dl.ws.atlnz.lc [10.33.25.18])
	by pat.atlnz.lc (Postfix) with ESMTP id 8B1D513EDEC;
	Wed,  4 Nov 2026 11:14:46 +1300 (NZDT)
Received: by joshuas-dl.ws.atlnz.lc (Postfix, from userid 1634)
	id 855495AEECE; Wed,  4 Nov 2026 11:14:46 +1300 (NZDT)
From: Joshua Scott <joshua.scott@alliedtelesis.co.nz>
To: Vinod Koul <vkoul@kernel.org>,
	linux-phy@lists.infradead.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Stanley Chang <stanley_chang@realtek.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Joshua Scott <joshua.scott@alliedtelesis.co.nz>,
	stable@vger.kernel.org
Subject: [PATCH] phy: realtek: usb: fix the USB 2.0 PHY's port range check
Date: Wed,  4 Nov 2026 11:14:41 +1300
Message-ID: <20261103221441.1550058-1-joshua.scott@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=H8t4wPYi c=1 sm=1 tr=0 ts=6aea5cd6 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=zJRp6_cAMcgA:10 a=VwQbUJbxAAAA:8 a=yqH7g-pp0JMGHG9r5zMA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

rtk_phy_toggle() checks the port number before using it to index the
phy_parameter array, which has num_phy entries. Ports are numbered from
zero, so the check should reject port =3D=3D num_phy, but it only rejects
ports greater than num_phy. Fix the off-by-one.

Found by code inspection.

Fixes: eeda494542e5 ("phy: realtek: usb: add new driver for the Realtek R=
TD SoC USB 2.0 PHY")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Scott <joshua.scott@alliedtelesis.co.nz>
---
Prepared with the help of Claude Code (claude-opus-5-5), which drafted
the change and changelog. I reviewed it and tested it on an RTL9311B
board, where USB devices still connect and disconnect normally.

 drivers/phy/realtek/phy-rtk-usb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/realtek/phy-rtk-usb2.c b/drivers/phy/realtek/phy=
-rtk-usb2.c
index 1f08b151d90a..e43ad5fa6d64 100644
--- a/drivers/phy/realtek/phy-rtk-usb2.c
+++ b/drivers/phy/realtek/phy-rtk-usb2.c
@@ -670,7 +670,7 @@ static void rtk_phy_toggle(struct rtk_phy *rtk_phy, b=
ool connect, int port)
 {
 	int index =3D port;
=20
-	if (index > rtk_phy->num_phy) {
+	if (index >=3D rtk_phy->num_phy) {
 		dev_err(rtk_phy->dev, "%s: The port=3D%d is not in usb phy (num_phy=3D=
%d)\n",
 			__func__, index, rtk_phy->num_phy);
 		return;

base-commit: cbbddb6b08cc9900a87cccaa9b22bbe06aa4f50a
--=20
2.53.0

