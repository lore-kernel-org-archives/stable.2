Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.130.202.132
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794979765;
	b=DJA36zfgSXWp5+2D+INZe/5D1ue77bATpnxMNhyKaFF0gSYTL49MO+iacVWz8CLxpZlj
	 XYEm00/61jz9Ig5sBIQkc3H6GoKuRFwM7IzdO1bWtdRqwerbV7EwTZi/duU7qbhh8R0Ta
	 p87lpG7LRFNEE2wbA7w0K1UDj4f1lHw/mx9ZkOrW5rlQHqTovf2pZad7JDMoAvSWc8lCy
	 nS4EcsPwZy4YmhNBWF1cdebX+ZGh5YpsCXroi7vAlgtXWGSRPs7n+z7U5qJObemYI7FcS
	 kym53SUXC5AMyCr1OTRya32L17FsOD8NLYydkz4o3mqmsWuZId8mPK/5wEI8J4+Nemg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794979765;
	h=DMARC-Filter:DKIM-Signature:Received:X-Iguazu-Qid:X-Iguazu-QSIG:
	 Received:From:To:Cc:Subject:Date:X-TSB-HOP2:Message-Id:X-Mailer;
	bh=M7Cx+kBquOVROVcGNo7En6/0TcsVigFHITD0OGoDcwQ=;
	b=feK1iC3zsCWImsbLrmvHxqNciQYuEteBJCP38VT6D347pFKQFI4viuJ/6x+/3WJHQge1
	 Q0hEeDlBKBEuaHlXWhNlfzIYWcEGekQpgtsmPO37kDdcLQ/yQXfNuOFozUc0+ArulTu/R
	 c4IkvQdIQy0r8MuI+JQtBWUHLIBnwJbVkFrrlkgCgCjm2U56VRayXs8U2XOmtSDA6nB4+
	 5eyvyL8gk+KQBT8O0BBXyuPCXPdLylg43KeaO0cEi8gHCMUHgXJtpEZ6xDNC2KLFVL+HP
	 OTfkTxL2QjSxbJEbaeagmfy+TJyhn5hoJFDB1KKaSxUHlYnn8Qf2MNFrGa00mEl+F3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.toshiba;
	spf=pass smtp.mailfrom=mail.toshiba;
	dkim=pass header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.a=rsa-sha256 header.s=key2.smx header.b=A0gs7Rsk;
	arc=none smtp.remote-ip=210.130.202.132
Received: from mo-csw.securemx.jp (mo-csw1121.securemx.jp [210.130.202.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DA9606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 05:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72DA9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.a=rsa-sha256 header.s=key2.smx header.b=A0gs7Rsk
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=
	1794979735;x=1796189335;bh=n0OCWVrQKpe225CvUIeuAmOaL6LicCeLkBPN6W1ABig=;b=A0g
	s7RskyYPGPepCKEpP2yyoKhtwvQFwXQjjM4Mki9fdvwjlwsQaFYz/ne9nF8DP4ckER2F/MAqXRnDg
	wo/lVWoPTSYzk70hKlEqE0Z6/SXmq3c0KaMsCJBsU2T6lqIYkeS8ng/Se8ntbX7QlMd37wDM76b/O
	rue5sWh1vF5bq5PPO+KO+9SmWZ52enmJVoeWCap1QCOzxq8Br/rs+Iwcc2+FHcVKZnI9iXuzlcPb4
	YFsZfLUWaE6ZJUv4fdUgf5jLv2GRNsdCdtsOvobapmKjPEVSiHUphWK+0GlaM7l04tOaN67wD6t22
	kEl+gNZeY+gue0qF8thNquNlEEHobVw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 6AI5SsMp078014; Wed, 18 Nov 2026 14:28:54 +0900
X-Iguazu-Qid: 2rWh7O15AwvbxnaQ1G
X-Iguazu-QSIG: v=2; s=1; t=1794979734; q=2rWh7O15AwvbxnaQ1G; m=DxWOaqs25JjmDb8wuMB6RYH8kvoxeXMVLf0jk7qoCsw=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jTqs22C8Fz1xng; Wed, 18 Nov 2026 14:28:54 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, Liang He <windhl@126.com>,
        Tony Lindgren <tony@atomide.com>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH 5.10.y, 5.15.y] ARM: OMAP2+: omap4-common: Fix refcount leak bug
Date: Wed, 18 Nov 2026 14:28:50 +0900
X-TSB-HOP2: ON
Message-Id: <1794979730-13985-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

From: Liang He <windhl@126.com>

commit 7c32919a378782c95c72bc028b5c30dfe8c11f82 upstream.

In omap4_sram_init(), of_find_compatible_node() will return a node
pointer with refcount incremented. We should use of_node_put() when
it is not used anymore.

Signed-off-by: Liang He <windhl@126.com>
Message-Id: <20220628112939.160737-1-windhl@126.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 arch/arm/mach-omap2/omap4-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 0b80f8bcd304..1553d70546c1 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -140,6 +140,7 @@ static int __init omap4_sram_init(void)
 			__func__);
 	else
 		sram_sync = (void *)gen_pool_alloc(sram_pool, PAGE_SIZE);
+	of_node_put(np);
 
 	return 0;
 }
-- 
2.55.0


