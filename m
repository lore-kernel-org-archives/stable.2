Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848413911D3
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 02:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789524594; cv=none; b=PafZ2VOHvrg2HOmM/O3PHOwtraWSdUeqiBHOARLJ9RJM9aejLVe986XdpJJ8GN0pGNBV1+NdilVpGnyjX9XNzMiZ2boHrFWgRt9X33f83YdVpVUD1En1j4cHt6K//ZumNU+o3Y6Fq92CgMxu+SxWzee0KZMca0S0vl9bmz6GIww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789524594; c=relaxed/simple;
	bh=YG4COEKulNp769D/BH1fCYynnVil3u1ZWIifJ+zRmkU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JefDX8WHy5ObIQ24dCkvPpOlBXWh7sZhrSCCQxlDeWsqoVNNlQtQidz+dnMx7ar70ABT86loeNtvQnV9+UI8lkNypBpmfKLr3WUr3Kv9z4lraX4W/uXYWFKZMVG3eVccy3zsO1qMA5WCBb7ldEuBM0hTiLvPcCheNL4rAKb2uO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcPv8o/x; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcPv8o/x"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469f20513so319755b3a.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 19:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789524580; x=1790129380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wm31bZPNQbk147CGwUHP23ZCay3Kn8INjT2oDuzYLtc=;
        b=FcPv8o/xNEeDJ15f/ck+7wOxyuQ2vkXb07FBv5bMzvikGrllRPat9zjKwyIOLs+PI8
         eDahLH9sOQfC0PRkZ/FshyIVzJA9coonZkbh80KwlFcAWMoy04H//EiyOFIvoHgTBarc
         llqXpc46GUK9EuP8zXQuwe9K1HAdGa59XW1BibI0XAGjs11vgCIuW3Ws4w73m7MVjO+S
         bLy9kJY6uM6ZaClAuaI7+Vc+AGFVb1hhS2uV6VOEHAYcasKHlLuqSLV3cvh4IqEyGCxx
         KOv+sSDHpFdYFZHU8ZqCu8YFqcF3BfPPDBDtX4oqxW8zpgDVaWB/sH7YRjfFXRswjBpB
         IwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789524580; x=1790129380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wm31bZPNQbk147CGwUHP23ZCay3Kn8INjT2oDuzYLtc=;
        b=C5KCMX0n2ncNfK+MyZdXZa7jPn2T7jtVvyHjs027M7giQF9vTHVXJcGclh9jRnijRa
         tDsGdmQGBYg8k5BkPnxqTybQbIsKttsopdBriBkYS4p3TAnxZ+k71zohDlRVBOgLQIbv
         kh8DuBCoT4BqOvCCjWfueePpj0edeULsSJDIZAvHvDAUs6v4XXvBk2OwHeUjq51+Sbot
         iM+Ot7HTc8GA7AEt0mhdwzEXhYe6NgChqziRqakrga1s7SGtxuzLTj+T0HZskY2p8aji
         Ez/Vl1+WAQW6zo16MwFxrxqO2ZO06FANTzz56/pZfeJG26p7627izpvZTdqnbU84n6uO
         +v9g==
X-Gm-Message-State: AFuF++nDjB0saCupZjsXJgRdcp+woOMjZ9vK2aCmbUmOl7RNKVNsZliS
	pI5GM9C+F9N6Ts8KpIFdi+/RQUSDw59HWFDIIIU8E55+3ufuWrYC0dFz
X-Gm-Gg: AYBFou1jOprub8V1CZYyvZS6UVUpF68a4pgGWdDrwHwR60JL/faCNoSpY+cm2Jj9SrR
	o0390xVmXfkk9ip+uTzneDVYq3jaGSSXb1qG8DjeZwA4Iu8zVijDY4tlqNJVqKmyzWO77DkUPUY
	YW+nyeiWpD6DlmX8gToZHIZGsrun5+N7hN5856g6BGGfkLzFZzoTA1m1wlWpc/PE8IJLfsZVEzz
	61/ArNJXnlX8uhwdQ+mPcZFHrQrgFTnn5ZMedQy8ogssjh6SayKCAeEgfhX1KoVc8hq/g5Cdv0L
	wv+YJQ4F37sdNs3fTNctOXcxxiiY0ojp5Y96b1Cqv+emTEHGOt2hjmeM5XQ4T4LfbCG4mYREfg/
	yKbqDDaDXyKAOjpin5Ck2EB1m0d+NMm0vYwcY+qujWD8ZF5kHBFkMwDAMHJd2rTP1CoaTbUJWRR
	LyQ6YnR/ksFOfGDAsYimpqw4dtxYpBYE34x/v36q6XP2mrqD0vFVx1Xw==
X-Received: by 2002:a17:90b:1845:b0:39d:f259:3363 with SMTP id 98e67ed59e1d1-39e1e491d27mr2086478a91.12.1789524580108;
        Tue, 15 Sep 2026 19:09:40 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1bbfdd49sm1508988a91.11.2026.09.15.19.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 19:09:39 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	John Crispin <john@phrozen.org>,
	Ralph Hempel <ralph.hempel@lantiq.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] net: lantiq: fix netdev leak on remove
Date: Wed, 16 Sep 2026 10:09:30 +0800
Message-ID: <20260916020930.2606675-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ltq_etop_probe() allocates the network device with alloc_etherdev_mq(),
but the remove path does not call the matching free_netdev() after
unregistering the device.

The probe failure path releases the allocated network device with
free_netdev(). However, after a successful probe, ltq_etop_remove()
only unregisters the network device and leaves the allocation alive.

Call free_netdev() after unregister_netdev() to release the network
device during driver removal.

This issue was found by manual code inspection.

Fixes: 504d4721ee8e ("MIPS: Lantiq: Add ethernet driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/lantiq_etop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/lantiq_etop.c b/drivers/net/ethernet/lantiq_etop.c
index 83ce3bfefa5c..ecf2f3cbf4d9 100644
--- a/drivers/net/ethernet/lantiq_etop.c
+++ b/drivers/net/ethernet/lantiq_etop.c
@@ -711,6 +711,7 @@ static void ltq_etop_remove(struct platform_device *pdev)
 		ltq_etop_hw_exit(dev);
 		ltq_etop_mdio_cleanup(dev);
 		unregister_netdev(dev);
+		free_netdev(dev);
 	}
 }
 
-- 
2.43.0

