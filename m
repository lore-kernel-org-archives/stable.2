Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F8937AA65;
	Sat,  1 Aug 2026 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785576616; cv=none; b=YWet4ierboSDOmEe1GwY1vtSOCIOiriyTeDdBmnvlvhFPXWf/3N4cm70zPrmWm/RkWgq1iFuO7ds85BPDTdleZ5c/wtBWBL6pqkM6NM/BAjOECl0CcEISuH1+hFnqoR+LSx3GUeEYsD4aa/04ec/ekkbAHE2clKUPy6FXRyVYO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785576616; c=relaxed/simple;
	bh=J4yC24on10cDRpsAy1JbPYPUsQYn1f2VwJSyQMkDp98=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=deanL2FOKP0qeJWkLew3mWDU2aorl/CLNIpL2nrs0uHDo8asDghxPAqIOdZc0cJszPBKDgMCOrlt5n1PbRnBeD0FNxKj8VAXKHp4XGKQkzB2pYoQMglqIYxKoPbV63MjcZr8e4W+zSDjwGYqqLuzdt3fd69dEC43WjiKSE2KZQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=PdBcwLnq; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="PdBcwLnq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785576601; bh=TbGfSwebogD7DXmDfZFwD+sk5+sDsiSiRWALm4OL3r8=;
	h=From:Date:Subject:To:Cc;
	b=PdBcwLnq2vfvCXcHCIR9wg5cwSnnBeuLzXuZEj915VwklYGR4GuJP6E0prEQlKVGf
	 CbU9CwRavUaEZHkckIdHTX3rsrv0YYbX8kxiYvDWwtCmQehQiTEinvyueYlcCd/pGY
	 c1edyNqpmDN381/MP5wlgLW/xGsDD3baOOn0NmRA=
Received: from ubuntu2204.localdomain ([2409:8d20:22b:54c:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 77AA6887; Sat, 01 Aug 2026 17:29:58 +0800
X-QQ-mid: xmsmtpt1785576598trzloxu3r
Message-ID: <tencent_2E3C237AFB193409D300C97027F88CB8070A@qq.com>
X-QQ-XMAILINFO: M3cUO7vMX4chkkHkXF8UrIL1BwQ/9ufWSjOK1qlQjmNEcWCTMWA6fZMfqPaiSo
	 Rtn3rzdDXYSlF5eO+HlgeYxd+44aVGXL+OCtITzFtYWRq8y4/Lnqj1KqjKetPzkAVBSgILvHlAjQ
	 T3U2X3yT1C6fC/UhRoEX2mnmUKAOc9wZO4Zh4h61QhljH4sXI1PrP3lkRRXLAZv2RdVTvDv8mXUi
	 lFDWHa3/iepVGwih6kZNV79lo+rg09vtwOhdzOFQFqFrRwTAQngURs6R0uAMNHnhrRcE4pFBfn/b
	 jUQwK+ZAiOoe3hA1P+2W268/9jGEbhUtZaRw+gr8GG7IwizuPMdgwQeABXHHEjNdbiKyFwpAqxZb
	 EFWRGVY+C1/aY+C+JdnWwEUcogwQN+R6lpI/EMKnc+V6H/GZGtIU7lDWNwOUwfAbHZuUFa81jiLg
	 +xroDrbj51VL42BRs9gZ01I+CS6ZR2UJLqzTo8GTAUUd3FX6IzZ241HRPn/yT3o9t9e+rMNbzrVO
	 EEbViamUKVha3HKgh7BZqKXE8HivH7vqAp1nqX+f/kI5z+P6sdHL30D5aEpPc315vIdweGPA2dmm
	 zpT2tDf91fq89N+gmH8u/rouZ9uZ7Dk+ogREKExLVIRTX46r2SvSHVzqEkuqZs2o95hhfms3nGMv
	 gaqhhagdo+n0IRtUGKTcW5mULRFl2tdFPFKrj36YoBiHH4uUAn8bZHrKcMamL++nexU9OQNNJD6m
	 0GBf+zwdymPd0HDSlVX5/MVDAjd4stN+NZJhQ1KfbDPdto+iATlWxzWlrmgNLZ9DEHC0lcv+y9ez
	 5rH0zTw4ATP5NlHZ4KvXvk5Wtb7LVOQdfjiaJO0mHPwOhzgEHBVydTjc1pwUB5sVwGvFB50DN+FG
	 JwT6jElHqzUR1ql8UhgREpLUhbYCUySZU4DT1r54qdgY+EFNcY5zuEL46cXGoeRPkKHAyH/QjY9m
	 CjP7RAMzX9HmBwg7s0+Xg6g0uwsawSpSpGRnYDTXUZVMcQ37q8YeisJgTeq5yfFaVFupch0DnekR
	 6LlP6708+W5mzEnQofQdqPQTZPbxxKSWCJEN0wos0hezRzvvVc+PqHaeimJiFRC3Nflej2XXjMMC
	 iepxZp
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Cunhao Lu <1579567540@qq.com>
Date: Sat, 01 Aug 2026 17:29:56 +0800
Subject: [PATCH] can: dev: drop CAN XL skbs when CAN XL mode is disabled
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20260801-master-v1-1-64c3330c5d0d@qq.com>
X-B4-Tracking: v=1; b=H4sIAJO8bWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCwND3dzE4pLUIt2kZKNUQ9MUMzOLNFMloOKCotS0zAqwQdGxEH5xaVJ
 WanIJSLdSbS0A1Va1TGoAAAA=
X-Change-ID: 20260801-master-bc2e15d668f5
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org, 
 Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2

Valid CAN XL skbs can be injected through AF_PACKET. Although
can_dropped_invalid_skb() verifies the CAN XL frame layout, it does not
check whether CAN XL is enabled on the target device.

can_dev_dropped_skb() already rejects CAN FD skbs when CAN FD is
disabled, but lacks the equivalent CAN XL check. Consequently, drivers
without CAN XL support may interpret a CAN XL skb as struct canfd_frame
or struct can_frame.

For example, rockchip_canfd interprets the mandatory CANXL_XLF flag at
offset 4 as struct canfd_frame.len. The resulting value is at least 128,
so the driver reads beyond the skb frame data and writes beyond the
controller TX data register window.

Reject CAN XL skbs in the common transmit validation helper unless
CAN_CTRLMODE_XL is enabled.

Fixes: fb08cba12b52 ("can: canxl: update CAN infrastructure for CAN XL frames")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-can/20260731105402.B7A451F000E9@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 include/linux/can/dev.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 6d0710d6f571..13fa607474b7 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -167,6 +167,11 @@ static inline bool can_dev_dropped_skb(struct net_device *dev, struct sk_buff *s
 		goto invalid_skb;
 	}
 
+	if (!(priv->ctrlmode & CAN_CTRLMODE_XL) && can_is_canxl_skb(skb)) {
+		netdev_info_once(dev, "CAN XL is disabled, dropping skb\n");
+		goto invalid_skb;
+	}
+
 	if (can_dev_in_xl_only_mode(priv) && !can_is_canxl_skb(skb)) {
 		netdev_info_once(dev,
 				 "Error signaling is disabled, dropping skb\n");

---
base-commit: 02dc699f83d04069fdabc996fc22d47cda47a4a9
change-id: 20260801-master-bc2e15d668f5

Best regards,
--  
Cunhao Lu <1579567540@qq.com>

