Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429DE4973AE
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789996184; cv=none; b=JxQnCtrAl44qgVu8Rs6JxUf8R/ozG9t5aroHknD6Ci3yfJz+4ahhuicp6h6TUEMCkZYkiM04IoazDrpCFWgs3prhWOQ1wmk9GYBLXVlBX/JgozIkB5ELWVLsnccSQd3u2EzFKxMOWJGkoxbubov8PiaVopw4nuhAKvkCe3HxjpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789996184; c=relaxed/simple;
	bh=eiuWmlpWIrVmvRukmtMzZVNhvzYKEvXfj3/9QCPxu5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OCRk4IWGSPR2WnbDQ/Ng4BxJFdsYAs1f2bZYyK/Dy7aNrKd9rsv+nqLw4GOBCp9abz1Jjs7y9sZZO9zlOyY8Ck5pa4oXaX3e40KMJk2DXhjnf80bySf3TsyLqetIDYqms1fjUCobqDw9oDBvuF3Xgncm7yNG2pW6/kQ/QKKlYxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gbH46PJU; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gbH46PJU"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-398beb616f5so1249021a91.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 06:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789996182; x=1790600982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=snQf0hJkQsH7Jj4aS5id74hgw0NIowrU4G8FGq6/9fI=;
        b=gbH46PJURVM7ZTREuV2r1oNue8DRiPFq/kT5g7aJL3XK4lYzByd8eOkTSgiiB7jnpj
         yQDsXEZXreurjXy/ZoNr1+ONL802AjHj7Gy5kEiP1t8/hJAnRp63CCQWzhaGFo5L6sv8
         CTEzWr1vfh9Dx/HSYjTHUhHbIz6gXR3CB2eaPug6/0RyHeXHCvVNby/EouSqxEpocaUd
         dYmz5PBMW9SooxNapP4pl7MriU+wEGI49pN/wxKRVNVBBzq5pLs9SggDkDplycfIrC27
         F63d7oFB61q0NFezBPL0d3YYRcNdC6TLu0wIVcQ5+AUbTzUJu56hMrMNPZJ1A7bNs8rj
         icHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789996182; x=1790600982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=snQf0hJkQsH7Jj4aS5id74hgw0NIowrU4G8FGq6/9fI=;
        b=iWUd78G+H61pE3HQMXNDNKJ7jFhaSeDtE3jrCPwhG+uuOGr2NPBd7ddj9BMYdGpc8Z
         lem+5fHIbojka5Lxg1YeQQ6Gdr+1xBKSQjo3sNlxmQz7ZoDtkGSKqCiVsxnTsQpe+ntS
         PHhrVV2xWaCtFvA/b6ZCSSL7nwFoJz5RMB6mtupN4H8PHS0j6unmodV8QK2eJIC13tee
         bVuIpRoUGCaYi/0enYrk+uUYIqxz7iu6u64ksOUMD+Jl32K2s3FRQ4ezdbRLamuUy4bv
         HfSjNt8yO2CegyDr6JSQsmAIzXAitwJn9CrNbp25k5OjS4rr6tILjbu1tzj5mlzxtlMf
         6PNg==
X-Forwarded-Encrypted: i=1; AKwUvByeP804rphlah8d/v06YQRP8ou1yt0YB+APASEjB5CL21jObzk7CKweGTCinP1KyHIWyD15MmA=@vger.kernel.org
X-Gm-Message-State: AFuF++mX+RcLBguOgR6rmTfDW/0n3KbwZDNlWmJnZH95xNmity0HI6h7
	dZzZEX7vM38GLObN8vR1KA8DEWW/jti0BVVBEjJUn+Q/sp5+bEjHP11q
X-Gm-Gg: AYBFou18XYWfC6ztTPWcUtsKob7/4sFmXLjsARF0hUe9mDk8E813Haq2+heyxfA7ZwC
	dLtwp9D3gQ66V/et5SrQ6ta2Zmj+8n+dGkyCvExFjOllnq+Z5prwlWEJ7ll+44d0QawqJDr4GSy
	dbEB6XMeRm9rrbGfacp8XedhQlkcLyZkVQEkVqU7bHqOm9Jq11bccT6hyO/GnpCR/c9Rfv98rHE
	VZPmM+TlkhufphSn6+W+7sTjbfQI8vgxo+GJAABCtC1gWNdR1n4cYzOvJqIGxCzFr8mSw+04i5e
	4zLSEgLS0oLZmzyidXGQ/jz+JpPf9ElgOboem2yESqnk9hz69/lk1PpZJHItKGhvY4/Q21VMTkx
	EsutRhsge2sbi6P8O0nl7WyXeBvWJGlJ+wGTCczqetAgBfxuhpW90Paj4LMoWtaHLCIIsi/7nvK
	b/Qi42ceS/jHAtsZ6I8An4KgZHFNroJNHMWTrQOOJbaeg5r4rdtV0UHg==
X-Received: by 2002:a17:90b:2890:b0:39e:3dad:684f with SMTP id 98e67ed59e1d1-39e5546c89dmr10847172a91.4.1789996182395;
        Mon, 21 Sep 2026 06:09:42 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a023e44854sm5275079a91.4.2026.09.21.06.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 06:09:41 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] net: bcmasp: fix MDIO child device leaks
Date: Mon, 21 Sep 2026 21:09:29 +0800
Message-ID: <20260921130929.403129-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bcmasp_probe() populates MDIO child platform devices using
of_platform_populate(). If initialization later fails, the probe error
paths clean up interfaces and clock state without depopulating those
child devices.

The normal remove path has the same issue and leaves the populated
MDIO devices registered after the ASP driver is unbound.

Add a separate error path for failures that occur after the MDIO
devices have been populated, and call of_platform_depopulate() there.
Also depopulate the child devices during normal driver removal.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp.c b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
index 972474893a6b..c4087408a822 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp.c
@@ -1309,14 +1309,14 @@ static int bcmasp_probe(struct platform_device *pdev)
 					 sizeof(*priv->mda_filters), GFP_KERNEL);
 	if (!priv->mda_filters) {
 		ret = -ENOMEM;
-		goto err_clock_disable;
+		goto err_depopulate;
 	}
 
 	priv->net_filters = devm_kcalloc(dev, priv->num_net_filters,
 					 sizeof(*priv->net_filters), GFP_KERNEL);
 	if (!priv->net_filters) {
 		ret = -ENOMEM;
-		goto err_clock_disable;
+		goto err_depopulate;
 	}
 
 	bcmasp_core_init_filters(priv);
@@ -1327,7 +1327,7 @@ static int bcmasp_probe(struct platform_device *pdev)
 	if (!ports_node) {
 		dev_warn(dev, "No ports found\n");
 		ret = -EINVAL;
-		goto err_clock_disable;
+		goto err_depopulate;
 	}
 
 	i = 0;
@@ -1369,6 +1369,8 @@ static int bcmasp_probe(struct platform_device *pdev)
 
 err_cleanup:
 	bcmasp_remove_intfs(priv);
+err_depopulate:
+	of_platform_depopulate(dev);
 err_clock_disable:
 	clk_disable_unprepare(priv->clk);
 
@@ -1383,6 +1385,7 @@ static void bcmasp_remove(struct platform_device *pdev)
 		return;
 
 	bcmasp_remove_intfs(priv);
+	of_platform_depopulate(&pdev->dev);
 }
 
 static void bcmasp_shutdown(struct platform_device *pdev)
-- 
2.43.0

