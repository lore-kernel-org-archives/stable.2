Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA7727F728
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 11:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783251402; cv=none; b=CS0XiXXBpJSz04ncZOb2T/Z3J8BThFM6ElD+BCoTjHYxxOkLmssiIqMV2Z9X0C1kEmQEX5tleO1wLphu0bhtevq6viNgK1qOSPghiLx9sx23CVagpwo/dJeJxqLRaoEo2s+cmgTlqWo1IVfWHB7pX8MhbHciLu4pYz3RzV3TOYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783251402; c=relaxed/simple;
	bh=bue3ZQS+aizj088Dq7mN65FaV07jnc8viFfDXWJsK+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ELjGh75DB2kRHXBgS2K8R0B3+346MK50x736Q11oM4zmRIUgEdnlWbL3truR0R40WWUjv5EqXOqsBWxwVNYGFX9UBx2l7XGLPQ1whC25KzzJy5vG8QdsFEwlwQbzFxl8MLE1oX+Mv8RzHyZaEaheRmCzb0zA2pZ8QzSJz1JlGsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ct0Y3cFT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ct0Y3cFT"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cac59f8b64so23698965ad.0
        for <stable@vger.kernel.org>; Sun, 05 Jul 2026 04:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783251398; x=1783856198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s8VIdU9IBO7hgfq4VBSOw6X3+441BJc4uvQfo52qhLE=;
        b=ct0Y3cFTcE1umFD6lW3qtil1AVDWfPiyFhnSUVy5DxVVKmU+sYqCWtWlgOq06ZXZ5C
         YxqhNBaLXQFsrDAY0CiRoRIOUgJNKWEm7UD6puPN2Bdf+QV5IZRbFnCWlLy0j94TJaO0
         YOug7xHMEiEqbPqeGjyNgcFH6Es+DLXkfgyH+gdWvRfKhZ0dA6uijXVoI2XSsji1kFxK
         Pp9vpKQy1FwVKAA8QxRCfrPgn12QatGVZqYE2VBRClDk6T1ufrFYXGU5WacaxH0a+lkb
         Q6dWxLwyHVsvxDy3W+w8T6kJ5zJzpnMAzWIqdN8O+Qrq1NgpyR2dWHGAviiKCJDrcc9r
         Tj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783251398; x=1783856198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8VIdU9IBO7hgfq4VBSOw6X3+441BJc4uvQfo52qhLE=;
        b=K42bIp2NaWjgFfJCcrLBRLZSn5Vjtg0Gxo3/KnGcXPdR79DA/q+PYk8DGJ/cQyuFi1
         /mlW99+hgAURnddm+1JBLT46sHRJMJpv0+1+2m/PoUDU9eJVgt6WJqPx+hgk6UmcGbr+
         SXPLYexBd/wD2SGWvjBOSDIP/JJsom3NjxQ4GVOlaozyPhZBmeWbdP3woAtIDcz915+w
         k1K5ydL8CYfdI7cQLsriC2ZWhO3R+T86QDScxeBPz9BxjiUFoVnTEOPqBWI8GwkOgITz
         PtOeLzG9tbnwkFW3VmJgdP1RmGd53ymz78MCYDgMluc1G2Fi+kCi5rpN1e0InVBk14cW
         riAA==
X-Forwarded-Encrypted: i=1; AHgh+Rq1bYcGSuGA2Ffi29NBpdtVClFPvRpAGpXkhStNCNo11q49hHJ8kzIFNRgFzsyLwb8U6uSS+v4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWjZwK4jdiVS8jJlnZJjK4+Tk5dezY9yXgnYyfH/t/Ibhy6EBb
	ZncSxXuhKowsQ7Yic9bOGmQ2Rz6UwXRsrGi8x8h5UuIo+l4ryPyp5aEd
X-Gm-Gg: AfdE7ckZE0JDb7+X8xfNz6BUgTsRKJTXJwj7ZgW4WekKR30fKf27efFH3Xj0mKd2ho0
	lJ4LIf1HPl9YDIXIimWXBx/mV0pDluQNTjbrsKFMWnPlWbGOz0uqwSLmH80M75r+8YNr+KZ6joN
	2TXQjzd7YVHCDJj/OJclcG+7c+Q5thLXeydwtqbYeuBZUTQuzor4XwiRuTjZcE88NrP3J6ra5IE
	F5xWjOK0WAGCv/GvfAto0KC+BR/9FYk7NWFSYx+vl+J/Ui9tPshjzENfxaDWjIrpeOFyK4HPwYV
	w+gMFjH3NJEfnTcE0QL5teeTH6o771ghuA5FDOFqBhXaAYcnmOiTS72RCaXX8PnIxCTUQL8HG/W
	ehLeWgqTCi2DWP5AB0fYkzXhTAxBIdP9NTTCJmcAzSHlrvscW/Ji0X6Qh3J3KnTV9ejrnqeqaUJ
	Wl7YE6YMspcPfrTiy2cOKAGAcMwbxAW4qXvYXW2g==
X-Received: by 2002:a17:902:dacf:b0:2c9:97a8:afe5 with SMTP id d9443c01a7336-2cbb9edf365mr59496035ad.40.1783251398363;
        Sun, 05 Jul 2026 04:36:38 -0700 (PDT)
Received: from JRT-PC.. (bb116-15-8-251.singnet.com.sg. [116.15.8.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad789e7ebsm32921335ad.81.2026.07.05.04.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 04:36:37 -0700 (PDT)
From: James Raphael Tiovalen <jamestiotio@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org
Cc: James Raphael Tiovalen <jamestiotio@gmail.com>,
	stable@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Antoine Tenart <atenart@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] macsec: fix promiscuity refcount leak in macsec_dev_open()
Date: Sun,  5 Jul 2026 19:36:29 +0800
Message-ID: <20260705113629.187490-1-jamestiotio@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a MACsec interface with IFF_PROMISC set is brought up on top of a
device that has hardware offload enabled, macsec_dev_open() first calls
dev_set_promiscuity(real_dev, 1) and then propagates the open to the
offload device. If that propagation fails, the error path jumps to the
clear_allmulti label, which only reverts allmulti and the unicast
address. The promiscuity taken on the lower device is never dropped, so
real_dev is left permanently stuck in promiscuous mode. Its promiscuity
count can no longer be balanced from software.

Add a clear_promisc label that drops the promiscuity reference and
route the two offload failure paths to it. The dev_set_promiscuity()
failure itself still jumps to clear_allmulti, since on that failure the
count was not incremented.

Fixes: 3cf3227a21d1 ("net: macsec: hardware offloading infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: James Raphael Tiovalen <jamestiotio@gmail.com>
---
 drivers/net/macsec.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index fb009120a924..71e4676b1dd9 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -3615,19 +3615,22 @@ static int macsec_dev_open(struct net_device *dev)
 		ops = macsec_get_ops(netdev_priv(dev), &ctx);
 		if (!ops) {
 			err = -EOPNOTSUPP;
-			goto clear_allmulti;
+			goto clear_promisc;
 		}
 
 		ctx.secy = &macsec->secy;
 		err = macsec_offload(ops->mdo_dev_open, &ctx);
 		if (err)
-			goto clear_allmulti;
+			goto clear_promisc;
 	}
 
 	if (netif_carrier_ok(real_dev))
 		netif_carrier_on(dev);
 
 	return 0;
+clear_promisc:
+	if (dev->flags & IFF_PROMISC)
+		dev_set_promiscuity(real_dev, -1);
 clear_allmulti:
 	if (dev->flags & IFF_ALLMULTI)
 		dev_set_allmulti(real_dev, -1);
-- 
2.43.0

