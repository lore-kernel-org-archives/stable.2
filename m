Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794154783;
	b=BML2vqOxhB6HxhaUEwgtUIKA3hv+GKjdE7QVav4iZXT2MP2Ejxt+iMoEby6v9X4DQSoL
	 r6VNSSBXnouObF8kkDrJ3hbuv22VAXS2zaCSeLDQtK7FK7zp5DcWUG9l4JHrrCB/fk10O
	 EWMErSLxiDgU6WmULRNIz3KyJIRCYbUNHXLmwZckSFvmTdRXDAvZgOWQwNaj0Ixwg4kvZ
	 +9fNoNt06FG7dCfVz+u/j/ZiPk1cXsZZBdMZQeZgbF94/u+Ub2wYE629oODiO+VnbMOu2
	 wURT3HcfSDBoEOasIVxIw1Or1RtZxYo8Bl634N1yzBSbTVhBeDsov/j2KJsiaBSISbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794154783;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MGdNPKADyW1UTxoQXV4ep/Cx3VnbRSDgd/3NjYhbL4c=;
	b=O1gZjSQGGWYUNRz5vfO2RwA+HOuhxewARSV9Y7sWJ3TDRan5LT881AyXUTo62HEmcyIF
	 sdG8cd50nAUW/5EXqXqVk+wJE3hDJ+nkMWFsXnIo+XPd6NS5J2YUrB1wxEosCer3lVtfM
	 5IbjpBPm7kX0yOXmpvCHc1WZPL0DinomTFoOd7bjAkQr79i7Y6HmlypTxJ5i0Lu9me/yP
	 OYPS0s1r5808De32oBIqfVPe1pE0XbA708br8N9S6bIdLQB7GB7Y9sWRNPKX0rB6MBoWj
	 JkORbjB0nMPWYfKI3O56L7nbNTzYMPQR6tye1xxXrHvdQ1oxyxjbPXcfsY1xO95fodg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=grische.xyz;
	spf=pass smtp.mailfrom=grische.xyz;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5408B606A322
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 16:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5408B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grische.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grische.xyz
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a215e64962so1295665e9.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 08:19:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794154782; x=1794759582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MGdNPKADyW1UTxoQXV4ep/Cx3VnbRSDgd/3NjYhbL4c=;
        b=vWZtNDFTyGOiXQBjgsCESgadVYzjx6DMB28oVmfZGmOCCqwtIVfJicAASAM/tmyCrT
         Ae7PrAlnto23XX5eQieQgURxIeSu9QvIHduAW0omNPqPnTCxAOIHz+Cct78cUDrrd0m/
         RkcY+ERijV22eEod/NE95ATtWJzQS1k5p95T2KhiUoaVQHpf0omWQG3EsKEa3yW9uCZO
         vPiwPed0wDZ5eAAaU6e10Q62v6JVuUftTOtit41B1L8mNm5Aa49Cj5zuWUn0X0gKbtVc
         6i81+eUTB7+JBmRv9mO+aJbWVPI6T54bggyVAvkTkgUN8b6JPKBcxQSL76pOEBifUlFd
         /s9w==
X-Gm-Message-State: APuU4Z9k3GsJmE1Ay3zj9hSbSHCHTZHZPyTopM6Hiq/o3+NblUGVA7p+
	Z47UYNk9ia+4pp0gr8NCcdHwqiCJYDG724R/aMoUGHHFbHpHs1kQybpYAgpOeOb6DABdZaf9Bzd
	4unYPUCRWbA==
X-Gm-Gg: AYBFou0N6DGs+xetI+YNTOPioTMGItCnwH4eXlETkPGOfJR8IyoCk4W9Akb2KG3FPXk
	2TPmTzYsjomqERYJgtqYWmr+nXhPh4l6mAjGZiDpkq/Sgzvyljnl9K8TzqtjzMMK0v5tRv3eh/o
	mXZMFp7sLssVftBGQQ6X7BGjP4jBG+RBg03oiquR6UGNor9XzoN0m33rmzxADogpYNNfpvQeEOp
	p1ZkZ48qyapRYeQBwoosQKmN92fAs2BI9j0ybmku9DzAH4vdchfowN8pwo6pwywdcZ/aggp2TcI
	1xxU0urInw2to7qkOqiPAEGAe9uFSnysmaaYcKl+HtAurWhOYnG53NfxZDZhHQiuQE5b7RRNUqR
	o1HhAcMwXmxlwCkMQvYoby242lIqJFlD9BRi6LTesN8g30wLYQG9UhzowAGBoH9F3TLdodBkxUP
	T1I+/C2Te8JMnsGVvKLtlYV2hZ0DNAX5EMCmoGMCbb0e1vnuZdgWBUIxmMlxbdqabGs3POvMMt1
	CnnwlE5wY6gvYy3RbCwZR0C+CdCeOov0RUAHAvRCbGiQO71Kr1yekzFLKf4W/2O3Pj+m1z4OZwU
	rUjoge8Q5+hoB26AmAJVEmnb
X-Received: by 2002:a05:600c:4f89:b0:4a1:ac66:6ac6 with SMTP id 5b1f17b1804b1-4b963c97d7cmr39677795e9.26.1794154781696;
        Sun, 08 Nov 2026 08:19:41 -0800 (PST)
Received: from lake ([2a02:810d:d09:1b65:e93f:179f:cb30:5c5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b76cb772e1sm189535415e9.0.2026.11.08.08.19.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 08:19:41 -0800 (PST)
From: Christian Schmidbauer <opensource@grische.xyz>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Christian Schmidbauer <opensource@grische.xyz>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Breno Leitao <leitao@debian.org>,
	Jeremy Kerr <jk@codeconstruct.com.au>,
	Guillaume Nault <gnault@redhat.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Subbaraya Sundeep <sbhatta@marvell.com>
Subject: [PATCH 6.6.y 3/3] vxlan: Remove generic .ndo_get_stats64
Date: Sun,  8 Nov 2026 17:19:37 +0100
Message-ID: <344e054b740166540e0bdb8642efb117b0e2f7b9.1794153876.git.opensource@grische.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1794153876.git.opensource@grische.xyz>
References: <20260812091127.1349673-4-sashal@kernel.org> <20260925180809.603571-1-opensource@grische.xyz> <2026-09-26-daily-reply-0002-re-vxlan-dstats-6-6-reader-and-tx-side@kernel.org> <cover.1794153876.git.opensource@grische.xyz>
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

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 195f88c57737f16217b5dece054a4cfd74c33550 ]

Commit 3e2f544dd8a33 ("net: get stats64 if device if driver is
configured") moved the callback to dev_get_tstats64() to net core, so,
unless the driver is doing some custom stats collection, it does not
need to set .ndo_get_stats64.

Since this driver is now relying in NETDEV_PCPU_STAT_TSTATS, then, it
doesn't need to set the dev_get_tstats64() generic .ndo_get_stats64
function pointer.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>
Link: https://lore.kernel.org/r/20240311112437.3813987-2-leitao@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Christian Schmidbauer <opensource@grische.xyz>
---
 drivers/net/vxlan/vxlan_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 355337d428e5..c3e2d78d2dd1 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3195,7 +3195,6 @@ static const struct net_device_ops vxlan_netdev_ether_ops = {
 	.ndo_open		= vxlan_open,
 	.ndo_stop		= vxlan_stop,
 	.ndo_start_xmit		= vxlan_xmit,
-	.ndo_get_stats64	= dev_get_tstats64,
 	.ndo_set_rx_mode	= vxlan_set_multicast_list,
 	.ndo_change_mtu		= vxlan_change_mtu,
 	.ndo_validate_addr	= eth_validate_addr,
@@ -3218,7 +3217,6 @@ static const struct net_device_ops vxlan_netdev_raw_ops = {
 	.ndo_open		= vxlan_open,
 	.ndo_stop		= vxlan_stop,
 	.ndo_start_xmit		= vxlan_xmit,
-	.ndo_get_stats64	= dev_get_tstats64,
 	.ndo_change_mtu		= vxlan_change_mtu,
 	.ndo_fill_metadata_dst	= vxlan_fill_metadata_dst,
 };
-- 
2.54.0

