Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78FE3BB12D
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 03:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789528466; cv=none; b=I4qurtORqqZ5Vi1FCeF27wgt+qPPKuBWb0lpBoEVSZaacTpWPgHANBmUgvsTySMbgnhZiMVysRNr/Ia1rfOXT3MqwBE13Q+DmY0WYLtaphMxTgk8wkg0g/ZnmvzI22GS05j5aSVCPA+sWunofjj4tbEKGxXWI5QBdlDc3Jn89Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789528466; c=relaxed/simple;
	bh=XnUgFgPOsUuayrUBKTDQiULxihp3Q0iXhDWve90xbhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uvxGnfcBAfoJQWmCphG7oJNb5xMTyfIu6LNDsu6t7w6kh8PhYFUIb/dQhZYrotU76jrNJqrYsvf/26k327AWLYr+4sy/6Ox/RM0IigCZFpTU/scJZyWQIiHKolpBHVj9RhRUNIrWnnU45nYUlj590CW+/SEYX7vBHwqQnC3z9Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k3YMtH5k; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k3YMtH5k"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebad4afso418630a12.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 20:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789528465; x=1790133265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3x+NS1tTRcfYVoPTJUjaHanPBgcWXbJYc21sQ0pJf9U=;
        b=k3YMtH5ka6h60UdPOgL0B+L9EDd1PODojlOtZXj4uOyer2EB/G2HxZkKPlc/YmAaMf
         vlSd1wfwFKuZ0zTSuJNc0FhyqYuyo7jnzoGIzKtDWqSNKkDf9bnKLjgAY2aMvYBBW/V3
         Dq/l76gH5UTfknGS+phmfIXvDABJVnbZoOUoysto6AIpVNncPDRqXPvtqaJoD3hdEcPx
         P30OiC9kV8uIOqcoAE9OwZhjJgcaWXB/qcp9fNGCrH79J14HS59371qmEqAcu+rSif9+
         UUdktKsiWJxJdTetGHFwGU6XMORuseKk3mtnbiq/mkbTsPiSq2BERWgqS13GgsuXKyv4
         mtRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789528465; x=1790133265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3x+NS1tTRcfYVoPTJUjaHanPBgcWXbJYc21sQ0pJf9U=;
        b=myHCliec/kglJJ/Em8IgkhlcUVSTQGRyOLY3OQBZCecq6k52/OozEGBFgWb8U5Y2z8
         GImnzGnp+Df/o67agTPw+zBvDyRdlvZcYnd4WBhwNQx57kvNwgaPPGy9fLLrRTn7PGq1
         x+Ggmq1ScZrB9GwUj8Ti8WGrZhhzJhc+LUkK69V3NIOn+nula3sVN5hfBDFyO2WU1i8n
         65V9QTetLSNyqW0b+iQijh7lfXYd8+egv8xjvDb+P/rCoEnbrEKyKbKN9SN4Z3j2B8Lg
         nBAHQOtnKSQEKWaIkDV2aETSSWCMayYEfaGdE00paB6IDaVMMS3wLltH9y2Lxc5bmDGU
         9VJA==
X-Forwarded-Encrypted: i=1; AKwUvBz4Pr3vqBrEVqZyyR/BTyxuQR7gKJKbQku5zoIsXmXzux0RIV6py4uW1q/RCreib7v5UJdc0zQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kwasjKjFcM/SHy1HAVhvLF3zzDVvUDmG6eJm8SCp4fUIzOq1bg
	LVkR0c0XZB7CfmoY00uGZcwsbdbgY0j1+JefmyQrOPOSvLnUI9qi8SRu
X-Gm-Gg: AYBFou1FkU0Gq9cMit1wUlyCMpfD8ECAS66i0PKRZr0ZJXIPM7kYf/RLking1BUQWkR
	cMc9kM0AX3+CN5+uzf6k9U+yjuurDP/O2JU5rncKWObwvcil4d+d5P5ElQP4QhQ8S9w1nFm1sM0
	FUcz19oGlT8X9cK1iBxaxaVLft+DGCPmY06I2+syQFrX7UloGcejXHV1X4Z4vllFZMGPl0I3Pxb
	Nnn899rad6t+R95h7OFKKAVzIdy7oRs0yhRYVwGDefoLUsddsE9GzhjAjwVDjul0mW7zW6AZFIG
	cpY9snOVMShW+DpvxVqnkO2mO3ljSPH2dBlElGQcfphtPCXEWMTfQWRL5eEyqQQxwMuE06wipWw
	Ekv2XnJJ6Ltrms5j9OtmZVENNkbkdmuf7b1VncIDDHulDc+pE1/BdYTW1v7XvOFOfRx3KGDdBkQ
	mxBr2FXPlvmGcXF2+7i2e5EluYeWGf88QITrNmWe0zvmyV0VkuJvzCqw==
X-Received: by 2002:a17:90b:3bc8:b0:398:dcfe:968e with SMTP id 98e67ed59e1d1-39e1e504f3fmr2661898a91.20.1789528464931;
        Tue, 15 Sep 2026 20:14:24 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1ae99ca6sm1886986a91.0.2026.09.15.20.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 20:14:24 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Jeff Garzik <jeff@garzik.org>,
	Scott Wood <scottwood@freescale.com>,
	linuxppc-dev@lists.ozlabs.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: fs_enet: fix platform info memory leak on remove
Date: Wed, 16 Sep 2026 11:14:14 +0800
Message-ID: <20260916031414.2875022-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fs_enet_probe() allocates the platform information structure with
kzalloc_obj() and stores it in fep->fpi.

The probe failure paths release this allocation with kfree(). However,
after a successful probe, fs_enet_remove() tears down the network
device without freeing fep->fpi, leaving the platform information
structure allocated after driver removal.

Free fep->fpi before releasing the network device.

This issue was found by manual code inspection.

Fixes: 976de6a8c304 ("fs_enet: Be an of_platform device when CONFIG_PPC_CPM_NEW_BINDING is set.")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
index d3c772ed5fc9..071e3f3de78c 100644
--- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
+++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
@@ -1007,6 +1007,7 @@ static void fs_enet_remove(struct platform_device *ofdev)
 	fep->ops->cleanup_data(ndev);
 	dev_set_drvdata(fep->dev, NULL);
 	phylink_destroy(fep->phylink);
+	kfree(fep->fpi);
 	free_netdev(ndev);
 }
 
-- 
2.43.0

