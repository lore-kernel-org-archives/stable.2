Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1321331EA0
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 06:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789540290; cv=none; b=gn28BjGQZQAk7WNoP2GbaHrA2K7Ow6mn1UXYhlG2uVuGXs1loNxcKPWtsBLThIweux7axok7qjeKhtVa2T0j+J3+ly3fu8CEVR81FbgAAoRbf92MTcGrRTXUp7snsIxV2TzxCf/kBrHj1eUvlS8KABES3nzTZp2siuX5stNBnHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789540290; c=relaxed/simple;
	bh=Ni7Nb/tkSb8xMBveKfixGMHJTCUSsBx41uEaih62Pk4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUUE8ihTclVhCU4RtNB2p+CER8iDhCQ1AYKjjfWnEsRS8ZoR4mpAjF9pQNqjZMJQGNhZd/Cj2g38+HaT75+f6KNlmMUAcz0h40uRL0oCliHZzGTz6C7nQStRtIBBr+/vqNpBmKj0hCbcy2tgMmvdFX/nBHbK6aFuaLjldPLYUMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pL6mji5z; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pL6mji5z"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccd4f99cso597917a91.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 23:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789540287; x=1790145087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WouBy8LrBhobloOGcs5+4K8UnnGyA8XojKOtb+0NfU4=;
        b=pL6mji5zB5KPC6uoVGtIQKoGi95xo69J3dQwnXgpRGvKy43PT6QS+Prp6zshRB21WX
         zxDeNFc+GHOasZiROXri90d1Lb25pVhOLM3ksQXd19AZRYVlHU3dgJFtOuQj58+uTRND
         NFG5na3ozBv2FpuJm6BWdx8ZN1/Jhwgza4s3umrbzcS1CmyG7qNYQzWUzMrEylBOppQk
         r4Nn8UTteh70kodW7JJu4F7ev+6rHasqQDqUNDeqgahMHLpH93GRb4mv+JklXGvtMplR
         HEE1Gw5fcm+G/D17Ex5iz3Wx15cSaiQ94n8k8LUkyUlktzmQG1y28x0Solfvi0hjlaia
         dFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789540287; x=1790145087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WouBy8LrBhobloOGcs5+4K8UnnGyA8XojKOtb+0NfU4=;
        b=GrfK47JZVXPW4eg5FpJ/1Vl9C2IrkuaKmhMID8hXHrBWcpovzKpVPn/qExawSTKzFZ
         z2iLugNdyGqbcD7CNHub/zqbrsIjw7oi+m8QHVh7oV6ZeS+CLH5ziigj0yP8Ae4Y1yDg
         eLbW9LVIXb2ELQQf+qKrj4lGlDfd1H/zTuAzWqZmTStZpjHRh3q0uO4ztEZACi2wrSDO
         NnC9WoWS0L+uYIXqGsiZDyqALtQZ9YXg7mYSDgRjAR9MKjh/Q6Bhnp8CCZoM2uRGQYTS
         NgrRI0xTozqBeumkWDp0HbLTk0HoU0TLC18lbHfUjyt6Udmsmp8rUqVCHJ7V+ysGGd47
         by5A==
X-Forwarded-Encrypted: i=1; AKwUvBw0GOSL/QIgMMcUjfj0EzW2dgp9Za+IrM4ra0Hv+DdbAwhBbhMfyiK01Q8ARfxLo4mVHo/tiLQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kp79aaXqig2YSMNoGm2zmdhYFkjsfPvMHVxz/2zYn/ig4ZEhv4
	yrOjbiG6/pMCZpH0hWNJo0GNdRSpJXljUurRRMHeCgTrTwjsZ9TF+0wt
X-Gm-Gg: AYBFou0b5MW+N8ansEnuYt/uUhppgBjhOtSpbY6R4BPmL5AruIUYMsh8EzW8LxP2t7i
	SYnfd67Cjd0duo2f81UAHmOLXIfMbmStVkXQbQaXoGIx8KOiSkUkHZDI0NF2Awu2Y+nVpUxMy+6
	F0Ip/Y5wU3Fc+0Ua8F8M65Vt+8u4B2W8P+82WpYGyeOf7HfCD19A/JynSzgPWiYUruFOl8XqNpO
	n8GJZkwSt3aRMmzKSS+OEKfIDyzwSQpW1B80cX1/T3ZZM1pIivFWuPRLk+x+ccv9O82z7P+VAbQ
	Bm9p2R3lxCpLh5c7Dco7NfngwgxuzUcW26IEqBnYN/KWGRxI0+8w2R1jCpTUf63gr+EduzxZqf2
	+qvelHiYx4qZznSVpCr/UhQlkXdeF6oYvZJ6G83pqxHODEj2jGLF27sFcTtyqUo84hGXY1BTYd/
	iMLNfPENLrqQSPYtlArD27mbAdSn0jSyJP/ugKuep5+KlXQhb+ulhuPomD1fns8DAL
X-Received: by 2002:a17:90b:582b:b0:39e:f1:b2de with SMTP id 98e67ed59e1d1-39e1e4c54fcmr3564649a91.20.1789540287232;
        Tue, 15 Sep 2026 23:31:27 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1b712ea3sm2906637a91.9.2026.09.15.23.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 23:31:26 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Kevin Curtis <kevin.curtis@farsite.co.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: wan: farsync: disable PCI device on removal
Date: Wed, 16 Sep 2026 14:31:18 +0800
Message-ID: <20260916063118.2924049-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fst_add_one() calls pci_enable_device() to enable the PCI device. The
probe failure paths call pci_disable_device() to release the matching
enable reference, but fst_remove_one() does not disable the device
after a successful probe.

As a result, the PCI device enable reference remains unbalanced after
the driver is removed.

Call pci_disable_device() after the existing interrupt, tasklet,
mapping, DMA and PCI region cleanup to release the enable reference.

This issue was found by manual code inspection.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/wan/farsync.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wan/farsync.c b/drivers/net/wan/farsync.c
index 6508c53bdc24..0ea637270ad7 100644
--- a/drivers/net/wan/farsync.c
+++ b/drivers/net/wan/farsync.c
@@ -2561,6 +2561,7 @@ fst_remove_one(struct pci_dev *pdev)
 				  card->tx_dma_handle_card);
 	}
 	fst_card_array[card->card_no] = NULL;
+	pci_disable_device(pdev);
 	kfree(card);
 }
 
-- 
2.43.0

