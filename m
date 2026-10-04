Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2726E394499
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 14:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791125141; cv=none; b=Lq2zpeYpvhMMIUj/gcCX4dCDoH+KJ5gc/tOEjnHk7as3uUXdEf1tF88z9mkUDLXhC8RkDBFTlNFAx2gUFOs0D5Xx6oidPw/wOj/HJO0S8k5eMMD2TSlt1ZSy0lVO5ZbubCUvAo7B5G4afTqb7Jswrbb1utJN5SL1MKYOtvk97pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791125141; c=relaxed/simple;
	bh=nknuNnEAxHvHKNnkMy5LoBq1XFHvy4iJ7nU+10qXxzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DahUeBZi4rJ2uHXSqLsmceVYO8h2x/iM4zHPePvw21ug2r4oLryY/Qw1SJE6lodeVSvzbo2y2IXJpATYF4zr7Deeg6kXgUU8E5owf4fMFD6T74522/1iizM/pygQSBnaAwLWW5fmrWvttTVZfNozzwEmGKK2VayH1Gbn91zOUZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEr9dGxp; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEr9dGxp"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48c4649b35bso980061f8f.3
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 07:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791125137; x=1791729937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LpdK/spNmgN6+9nx+ZFn2n/Lj/yxaVrVG3OMjpGohSg=;
        b=eEr9dGxpATN7UfiYX8iTGjeTwyKd7ljvYbyB3EOQ5LNEB+9f3OXSJ22sSOXFkHCjq0
         EY6uju5gqSG/bar4wUAPBbVxigjoy4/8ZxhpkMsmOj9723r3q8igMYPcnZsgsG6GwMkr
         d9cNSObLTzs8/ZZcnZQuUvLqx4frtPXi5MfdbjGBKmB9TyfjR6p+IF+8kLAc/Xju0qT8
         k+A0eNATozyfA4JX+H0bHt/SJ1pENtkgaVMXdwk4nzL57buZvkq6JyaOqcBEjPvAo0uQ
         GJ4bn8dWwo4sGEka/pnOZE0ZMlEowZA2H8UT8/FaAPg/vqmLV7qgnlLQVhTDs4mzoU1o
         Tp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791125137; x=1791729937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LpdK/spNmgN6+9nx+ZFn2n/Lj/yxaVrVG3OMjpGohSg=;
        b=0DHW4iqIDigBk5JJ5ARjjwnx8ul0IdjXgfKRHHNgsagQS8GZVuNcKHifb2XWFac5hf
         NkeNt5ctgCEDayQu64h5eKYlxOTx+pBJUa/nwU0DJwVEeUaL1xeR7JSSakiUWbpOP3E+
         bI/SZ1w/kY4Bb+RdTVvimvdTZdo/xh/zX0EZyTV5FPP+HlNF4ooDZkbgLZ2PHmHKU7bb
         4HBabYvujq9aZtYPfXUNVjjYLblPZXgMn1yZ253iML5N6IfNIrfz1GDR4R2dz19Bd0EQ
         c86UV8AdTSmwAIfHfEQbGutm46wSfeYX2P6Io8q4Bw9aFG/ozhVtQuHwmnsxdU0GKnKQ
         AdiA==
X-Gm-Message-State: AFq9FYLW891fXOModwslnYrO/g+pwFfwIQEjOI7B69eKtfnCBtSUoKA4
	mSkGyjcMI6Nh6t/raIOn7qXZBdJaLbg3RHeue67/5tjkADR1OQTGJ0fwzybCrMk6
X-Gm-Gg: AYBFou3+je8cYMQreNT9ucVPYvtzV5yqh++QgXRE+t071YyX8TW+U0ZnztiA/hXQVdX
	P4z6vEJXe4cTcm1KETABD/4P4MpmgmTjxAtePWyE7tYyeQoYFYd7d/4275DYvDqffa7DxHLjUCX
	OMS86CJ8mWix2danHrmQqDSBAI25LjhaJ647GmeCXGDN439sFe2t8lU+iBHSAFW9nbBpJ7ev1XS
	EiHMJCHoREKMGT5gXgNjymABYa9FDT6U5rpNJYaT2aGxE08mAKjr/vtfZkVmKS8GX6d2ZVPd8Pe
	C7XC88rU/WZijDVkgfJRvkPoe4c5Z6yJp/GvCzR3+jgzr/tc4/7rAN4p1IJ1PkQB9eWm10RTCJK
	0a68fBR2JWiSwQ4ZRnBSqDtk+QcEMcYt7jAsGBJNZ2p/2bKW8WJBIx9ksdvqX+DBjxwRE3D5Rri
	+rWUO5oPboKEqDgG5FhSjs+fXdkyHYCNtWN96OtEUESJFPKtvBbmvO/Mb7Isa4HQLbzd+XyjZKr
	HiGiu+uE8GmhYZxMAQ32FlR+aqtnQ1Mpmh51pHJzCzGGhy+amBj9IQmpV5MqvnNS8FwCuRZ49ky
	HXdwnx7CutBrwsRNCrEr4/Hef+8L5PwU/YBiMHr6IKpVgQXEWAmUMbj8wqTNxBDre94KpkPo7MV
	7W8JXlruyrkGjBNpiAN7osg==
X-Received: by 2002:a5d:64e9:0:b0:48a:fdb2:f2f4 with SMTP id ffacd0b85a97d-48c4801be23mr9176768f8f.57.1791125137116;
        Sun, 04 Oct 2026 07:45:37 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a00-1028-c000-0ddf-f41d-5ef7-f7c3-c578.ipv6.o2.cz. [2a00:1028:c000:ddf:f41d:5ef7:f7c3:c578])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b382f9ad6sm19836819f8f.40.2026.10.04.07.45.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 04 Oct 2026 07:45:35 -0700 (PDT)
From: Josef Schlehofer <pepe.schlehofer@gmail.com>
To: stable@vger.kernel.org
Cc: John Pavlick <jspavlick@posteo.net>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Marcin Nita <marcin.nita@leolabs.pl>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.6.y] net: sfp: add quirks for Hisense and HSGQ GPON ONT SFP modules
Date: Sun,  4 Oct 2026 16:45:28 +0200
Message-ID: <20261004144528.54801-1-pepe.schlehofer@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Pavlick <jspavlick@posteo.net>

commit 95aca8602ef70ffd3d971675751c81826e124f90 upstream.

Several GPON ONT SFP sticks based on Realtek RTL960x report
1000BASE-LX at 1300MBd in their EEPROM but can operate at 2500base-X.
On hosts capable of 2500base-X (e.g. Banana Pi R3 / MT7986), the
kernel negotiates only 1G because it trusts the incorrect EEPROM data.

Add quirks for:
- Hisense-Leox LXT-010S-H
- Hisense ZNID-GPON-2311NA
- HSGQ HSGQ-XPON-Stick

Each quirk advertises 2500base-X and ignores TX_FAULT during the
module's ~40s Linux boot time.

Tested on Banana Pi R3 (MT7986) with OpenWrt 25.12.1, confirmed
2.5Gbps link and full throughput with flow offloading.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Suggested-by: Marcin Nita <marcin.nita@leolabs.pl>
Signed-off-by: John Pavlick <jspavlick@posteo.net>
Link: https://patch.msgid.link/20260406132321.72563-1-jspavlick@posteo.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>
---
Backport note: in 6.6 the quirk after Huawei MA5671A is FS SFP-2.5G-T,
not the Lantech 8330-262D-E/8330-265D one, so the upstream patch does
not apply cleanly. The entries are added at the same place, right after
MA5671A. No other changes.

The same change is proposed for OpenWrt 24.10 (6.6.157). Its CI built
it on mvebu and realtek, both with CONFIG_SFP=y:
https://github.com/openwrt/openwrt/pull/25592

 drivers/net/phy/sfp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index e352ceb2f7cb..38ab35e57127 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -514,6 +514,22 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK("HUAWEI", "MA5671A", sfp_quirk_2500basex,
 		  sfp_fixup_ignore_tx_fault_and_los),
 
+	// Hisense LXT-010S-H is a GPON ONT SFP (sold as LEOX LXT-010S-H) that
+	// can operate at 2500base-X, but reports 1000BASE-LX / 1300MBd in its
+	// EEPROM
+	SFP_QUIRK("Hisense-Leox", "LXT-010S-H", sfp_quirk_2500basex,
+		  sfp_fixup_ignore_tx_fault),
+
+	// Hisense ZNID-GPON-2311NA can operate at 2500base-X, but reports
+	// 1000BASE-LX / 1300MBd in its EEPROM
+	SFP_QUIRK("Hisense", "ZNID-GPON-2311NA", sfp_quirk_2500basex,
+		  sfp_fixup_ignore_tx_fault),
+
+	// HSGQ HSGQ-XPON-Stick can operate at 2500base-X, but reports
+	// 1000BASE-LX / 1300MBd in its EEPROM
+	SFP_QUIRK("HSGQ", "HSGQ-XPON-Stick", sfp_quirk_2500basex,
+		  sfp_fixup_ignore_tx_fault),
+
 	// FS 2.5G Base-T
 	SFP_QUIRK_M("FS", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
 
-- 
2.54.0 (Apple Git-157)

