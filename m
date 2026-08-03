Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BAB37FF75
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 13:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763867; cv=none; b=HvHNrvNkK1TccbanA49ykq/b+oZus2H8A5pp0pnqMI1jNaEX/7581CRdSdBiAdlALBN25xQ5gP7nWsosyT+mZFTVJg0ox6Kmrd7wcyv9o/bQiWROmOnRlBHbtwipSDLFOJYO8yImiinJioDhQKd4w1hIj3crYhwRj0SKu4/i14U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763867; c=relaxed/simple;
	bh=s7sVT5nQKfhO1MYQ+cpOMkikgu6fjfHMzycska5FUMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oOE/mihHpKf28DMoSZb8sEKysA4Bx3EsFn0J6rKlCuuixlecRA+JC3Yky3RcEtQbyFGo8XPBgo8mMoCXVEbiLKupjy2qolB0eEOTNBAxrmc21pHXyJwC5X84Xqp1B+4N3T3p8XyrM4Iv78OzTxry9uETFnVn79OJG1HrDpOe8MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZLcmUBA; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZLcmUBA"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so2245761a91.2
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 06:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785763861; x=1786368661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NaH5rfBTvvJEbq+DmDZKDP4NbrrXRvHP/DgwMEdPwTA=;
        b=eZLcmUBAWfCzhIdeH6fNswwvhJSuwlsTVOX3tAzn+2tvQdbqDH5+SXplD09H6kd2Wg
         YdOVkLjdSzzqIHV2mlf3d95lLLmfvzqkk5rxjfwiboeF3FlrKtgKo+h3+bPRi1HkkIg0
         QJVIFQwGq+NYQh7qvAL5HwCpEOKkli1kosPW5ihIdqFgeHDsltcCIpObfVSmB6XytIHB
         0FfaQM9CyHpAaJgW5qIC4iOH4EvjSHiSXAWOF47ZRuw000cJnAIXX1OLt52Jsp8bfL6v
         /hK6K60QYJb+zSeB6IsytGKCU7CVFKqRYwxxBczU7X0do2m82AWnZ+nsYp0Nottz3Nkm
         gPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785763861; x=1786368661;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NaH5rfBTvvJEbq+DmDZKDP4NbrrXRvHP/DgwMEdPwTA=;
        b=EraQaKZBfPjZ0Aj3V4PEKSke3VNl43vj134ZsAEWzJ9xxCZHR+4lsmLlHGaRutll7d
         fzpnXeYVssqTDFzuT8PrckynBycP199ModpI4Re855RJXVxkarOaXh2vm4HSbciH9b2F
         59rNMPZ0BER2JEi2LK07BMfE1LRU+EsCe4G/TjmzJ0gWayXo3FV0gItjsBXmu0pZLP42
         6Ht8+jSDOtsul7XvwRqK/52g0RitqBU2UIdhI7/Qkm+M6FzFvUvVcGwbjyo2DIQKXlmA
         5qs/fbIQkpsMwNSiuXk74/bhHM18aKYdjx6fqW/gF+2Ylp7XPBHySPEMw+p6n/zTS/A7
         WavQ==
X-Forwarded-Encrypted: i=1; AHgh+RoHiVsH1HEJaRaoQ/xItQTaYP3dSdnL75AzDWgumfauSOZe3jBDw/XOEnPUFpod8dMINIRZnBo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkMb+FOIpyTpu4oSxdOysF/JLnY/NBIm/nOpLmdw26VSQ+/KIP
	eTm40uvKlV6IOvsL4atlSiVm2g1JwHCl7Q4sZFAK8JxqTxb0lK0ffac=
X-Gm-Gg: AR+sD12F6XQ4AOHN6qqxabG6ki9YUjL03B+2vNy/zmVvZ8EJpxVkFDkKPirzZ3uQvhq
	ZtPknj2HLkFLc8SuXdcuEZ3C6aHRo5h0HbGGrB31ocmBrxauDwNAhJEd39dMZiaR8g/Zr6qtCzK
	8b6pcNRb7nJ7dW8TZ4Co4kY8Z+6VGaErIffUGT3R6sxcyTWDt610Cd3cjb6b+VrwNR0Tn6Z01E8
	kc9J98pstBIRJo4eyWDHBNBK26kceJqOLWNeMjWF1B8LKdvLSl8dujCoSo8DAWYfqwh7UK9cvsd
	Lhi72xfYvOnPD9KrHjbx6diaaJnezJKNinTkFywXs3krpnJGo8hY4ytnSfuBnFd8XGeKZxTcNkk
	WZ2FZ2eLVlX9nlO1l86TXtYYHfQrJwc9JaIYYChIRwdNx/uTbFrwVApscKSI1YevCJmzX/VvdNe
	WYgYAFJkkS26vx9U/A3WdBEh1qvDQ2bwdJcLpyFHCraI2Q1BvYZVYdpLorJWc2Bh2Hur2eNwdts
	bXC7p7NODMbDCFowXAaiqCP6H0lClAAFUvfriVmLeremj1B7kkRx5lswdgjRoPd7aF4p9Q6f1zs
	1znsosT+b4cDd5trB6NdKzmLGpn2Ad/ajw==
X-Received: by 2002:a17:90b:3947:b0:366:10f1:3d91 with SMTP id 98e67ed59e1d1-38fbc3f246fmr8665430a91.1.1785763860528;
        Mon, 03 Aug 2026 06:31:00 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb259000bsm2531459a91.0.2026.08.03.06.30.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 03 Aug 2026 06:30:59 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Zhao Qiang <qiang.zhao@nxp.com>
Cc: Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Halasa <khc@pm.waw.pl>,
	netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH net v2] net: wan: fsl_ucc_hdlc: release HDLC device on remove
Date: Mon,  3 Aug 2026 22:30:48 +0900
Message-ID: <20260803133048.42650-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ucc_hdlc_probe() registers an HDLC netdev whose private pointer refers to
the separately allocated ucc_hdlc_private object. The remove path frees
that private object without unregistering or freeing the netdev, leaving
a registered device with a dangling private pointer.

Unregister and free the HDLC device before releasing its private object.
An active device must be closed before detach_hdlc_protocol(), because
the detach path resets dev->flags and clears IFF_UP. Otherwise the later
unregister_netdevice() skips ndo_stop, leaving NAPI, the UCC and its IRQ
active while their backing resources are freed.

Close the device inside unregister_hdlc_device() while RTNL is held and
the HDLC protocol is still attached. This lets uhdlc_close() disable NAPI,
stop the UCC and free the IRQ before the remove path releases the DMA and
private resources.

Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Close an active HDLC device before detaching its protocol so ndo_stop
  performs the NAPI, UCC and IRQ teardown noted by Simon Horman's review.
- Link to v1: https://lore.kernel.org/netdev/20260728171545.49247-1-mhun512@gmail.com/

 drivers/net/wan/fsl_ucc_hdlc.c | 3 +++
 drivers/net/wan/hdlc.c         | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 809f21fb93..4c843c94cf 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1255,6 +1255,8 @@ static void ucc_hdlc_remove(struct platform_device *pdev)
 {
 	struct ucc_hdlc_private *priv = dev_get_drvdata(&pdev->dev);
 
+	unregister_hdlc_device(priv->ndev);
+
 	uhdlc_memclean(priv);
 
 	if (priv->utdm && priv->utdm->si_regs) {
@@ -1266,6 +1268,7 @@ static void ucc_hdlc_remove(struct platform_device *pdev)
 		iounmap(priv->utdm->siram);
 		priv->utdm->siram = NULL;
 	}
+	free_netdev(priv->ndev);
 	kfree(priv);
 
 	dev_info(&pdev->dev, "UCC based hdlc module removed\n");
diff --git a/drivers/net/wan/hdlc.c b/drivers/net/wan/hdlc.c
index cbed10b1d8..a38f90d300 100644
--- a/drivers/net/wan/hdlc.c
+++ b/drivers/net/wan/hdlc.c
@@ -263,6 +263,7 @@ EXPORT_SYMBOL(alloc_hdlcdev);
 void unregister_hdlc_device(struct net_device *dev)
 {
 	rtnl_lock();
+	dev_close(dev);
 	detach_hdlc_protocol(dev);
 	unregister_netdevice(dev);
 	rtnl_unlock();
-- 
2.47.1
