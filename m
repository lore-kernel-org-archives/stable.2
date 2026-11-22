Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795365265;
	b=Ue4jgwPWM/5/ZGuUX/EL7LZwTM9IlEddNZuKAKG58Z4Us2ccSolQ0pebKaUCiJXxWrZz
	 9jbk1kq2G7BIhbIZ42qOjadkHj1nPsN5G93vRfdVuLrHYlHwpI8VU/XDm8ls/8c1G1v8F
	 eYIT5jfsUrrJ5iT2hHpT61H7vtF0AuweAD4PmtmT8Sje0pjiW9gCZAlofRAb7KryaeAnA
	 b3vdbZjgDe99DL8yDcRXNxzltOJp/j1aMCl3mN1i0zLuY8B6bx1XuS+SZGZfJpjqn6CPf
	 9DkkZCN1iYxZz2PZKoue7Hwi3inxNigdJ006/JzEDP8+mbwqZc+qdWP9QEBv9kPzecg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795365265;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PKYANT6ORuAjCyrXKjjCsaVWwop42JBUOal0NPl0OtU=;
	b=pc1xgS1k6L4oQWi4uP4xR9MTzAs0BBFtsV14de08feFCaPKJ46tRINGGnSdsZhq8arw7
	 qlUyPIhYek+qGtomo/dy49h+9daso1/yteiyiTKt/KqC4cpW5y/oXjHIcqk/n8tLGjxI3
	 fl4VQABcoRLUimNihE8B5n6s6qgMcYWWgjJD5H7YKNIDj6WvnC/ruVN+if5D8pyrqdxkT
	 U86yr4hge1sC2d/ItAwxSf6qOBKkxacmxmfZJJuCc9IsTapIWBRjatJw73gOi3zEg2GIP
	 gtuWkgfiF/qrksCeStjPY2uSyBUIwAvDSHJlvi9jTCRiQb7RH0JZ78R5jfNW457GXUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XLcVMaIM;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FF2606A330
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 16:34:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 20FF2606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XLcVMaIM
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a07078200fso1270293b3a.2
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 08:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795365264; x=1795970064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PKYANT6ORuAjCyrXKjjCsaVWwop42JBUOal0NPl0OtU=;
        b=XLcVMaIMsgTzBo78gyw0vfMzb+lmw2wx5kzg/3pL8r/aCHDsMdCSJ0pzbsQlZzb+Xf
         dhQDx4Q0rZ1G4ePNYuvKvoL9rGDscWLfNw7tITzVlen8a5dF8/x6Gx/hqznHcgNKrbBT
         Vo2QnkwPVBzWAOglMSGIOFAnVzgwod3D/Aw9MztVZm7IxUIWAP4xNC87er8o/S3CWiTt
         TsbcICCI4EYD1TQLhEkFusBItHqF683FwRzAltBXnWyky8PpnykVj4xrGm3GfzEzadT/
         XfnRxvRxv9mtmVmfqrgZsz/R6RpHvUMOPdw2ICZY6CZhK630lebjGsVV1++Q2JB54t2l
         UFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795365264; x=1795970064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PKYANT6ORuAjCyrXKjjCsaVWwop42JBUOal0NPl0OtU=;
        b=BYiM7SqY3T9clCF1eNjKtGPu8saSI4vnh+AksVHxGw8U5rYpxFUh9hEVtJtDiVyFl0
         IL3oWDU/+h3bBM/bxOBBhWV2hI7TfMU4BcK4P9ZlYgXPT3PeNZ4pR/Wqjg0UUSM2i29s
         B/VfYHNwJsmGwM04fbgOm6J/fbUYxCsTg+tqYHXnD7qM6MIe+IRvs0mWhVVUKSIjXk0/
         eu+zjItSRp31SCd7wStmxWvi7QFar+KLZRiwCyGPr2nr4RIedGBJERrtZny00tFBMahs
         96SwjbULJlaA+nvOHbP3Dxc50eM1I4Ht21+TBSGjYrGEFvs5xni6jsuk5wYMKbAWRnCu
         SHvQ==
X-Forwarded-Encrypted: i=1; AL+hErFmsCd5GCaL+2FLtNzGQPeLtkF2e3NFCTcq8NpQ/Y4wGSN22vvkycj8vuu4zg0xkWv2SoetxsY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xrXizSfLCNH43d6PpJnCloR5l6WYC34pxAV3lbLrbUpquc3ei
	mDsX2GDQboYTczkUB7FmlXyo9VuuJzd9IY9KBrFYn44osO+Iiv5skYYF
X-Gm-Gg: AZFdTZcs+mLSTkM9GCeHPSELXnToLnLFCrsvDUjdgeU1vInoFm3+ddgGoSssXT86TNb
	iE4RljcIiViuM6B2kaRrGTPMzE6sQvGiqMg7o5X4nyWjcFZi5ADngGHh+Xzp02XhKaqnOmk6Fzx
	CJL3hJc46qeSReTKZXmyNjVCrsDvscMazWN4kdJtuax3S/RDK/i6KreZkqHP5mexVc2eX0wEtd2
	HFGYAWVjMUeSeZj+HVVACvi46uv2ODLfDtgywYCXDKHr6nJJtGFyaJfUgSOxkBQhi0AlB5XZMfI
	0U7z+6Bbs8Hfam5uinC6kislgO+TFQDdncDc7YFckynAoBAi33CYf4XvMJ7qIN0qSsgUI7KB/uO
	M5yyRW07EwBFS2tNiMTJpH4aDGXd5RY+LDbNFmlvom7oAZxWWlc9u8nNtgsO14Ga96WDb36ywEm
	Pebbz7RprHXFZSz6GX5NVCXbsrtmeherVX2kOLmpqULcaJFrLC+rpFRkNA0QnIrCLKGChTXRTRy
	TQnS8z9aZeaBhNqRWNGFqrud1BxhrjEj6vOwMP8ntAGnzVk8KX25r5Z6pWWKQlbFVH5TFx5Gy3o
	9m++k0T2NjMEbvqzn+AzTFV1WUpu85gtM/H4zs66oeb53bAq6qV9Iv3MTPT1+dhHAfpA1MWLXRo
	ixbIVGypBFCoPolF1DthwvyUjNA4=
X-Received: by 2002:a05:6a00:4189:b0:899:55e9:880b with SMTP id d2e1a72fcca58-8c87bacb423mr7471731b3a.14.1795365264278;
        Sun, 22 Nov 2026 08:34:24 -0800 (PST)
Received: from acemagic-m1.lan ([2401:7400:c804:b668:a7dc:f03c:3f60:caaf])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c219sm4218560b3a.18.2026.11.22.08.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 08:34:23 -0800 (PST)
From: Ho Jie Feng <hjf3108@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: hauke@hauke-m.de,
	Ho Jie Feng <hjf3108@gmail.com>,
	stable@vger.kernel.org,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next] wifi: rt2x00: upload beacon before starting the beacon queue
Date: Mon, 23 Nov 2026 00:34:16 +0800
Message-ID: <20261122163416.14269-1-hjf3108@gmail.com>
X-Mailer: git-send-email 2.53.0
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

On PCI and SoC devices, rt2x00mac_bss_info_changed() starts the beacon
queue without uploading a beacon, and leaves that to the PRE_TBTT
interrupt. But the TSF is 0 when the queue starts, so the first TBTT is
due at once. With no beacon enabled, BCN_OFFSET0 is 0, and rt2800 sends
a beacon from shared memory 0x4000, the start of the pairwise key table.

On the RT3883 this wedges the baseband until the BBP is reset: the radio
neither receives nor transmits, so the AP never comes up.

Upload the beacon of the first beaconing interface before starting the
queue, as is done on USB devices. The (PRE)TBTT tasklets are not running
yet, so this cannot race with them.

Tested on an ASUS RT-N56U (RT3883).

Fixes: 1dae8d342e84 ("rt2x00: Limit beacon updates in bss_info_changed to USB devices")
Fixes: ba08910e04e0 ("rt2x00: change beaconing setup on RT2800")
Cc: stable@vger.kernel.org
Signed-off-by: Ho Jie Feng <hjf3108@gmail.com>
---
OpenWrt PR: https://github.com/openwrt/openwrt/pull/26850

 drivers/net/wireless/ralink/rt2x00/rt2x00mac.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
index 3bc0c1c906..48c875e198 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2x00mac.c
@@ -630,10 +630,12 @@ void rt2x00mac_bss_info_changed(struct ieee80211_hw *hw,
 			rt2x00dev->intf_beaconing++;
 			intf->enable_beacon = true;
 			/*
-			 * Upload beacon to the H/W. This is only required on
-			 * USB devices. PCI devices fetch beacons periodically.
+			 * Upload beacon to the H/W. This is required on USB
+			 * devices. PCI devices fetch beacons periodically, but
+			 * the first TBTT can come before the first fetch.
 			 */
-			if (rt2x00_is_usb(rt2x00dev))
+			if (rt2x00_is_usb(rt2x00dev) ||
+			    rt2x00dev->intf_beaconing == 1)
 				rt2x00queue_update_beacon(rt2x00dev, vif);
 
 			if (rt2x00dev->intf_beaconing == 1) {

base-commit: e1dd8486807c1acf9551250b7f81e116a21e6ad6
-- 
2.53.0

