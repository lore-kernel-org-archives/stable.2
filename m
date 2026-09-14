Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E545847ACE7
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 13:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789394256; cv=none; b=p8Dn5s0Y+gGvrRSdghdkxJeBKJgN2Z9O8kdcCwsD/63j2b2kVTar5sGI1ZL20FSbrFaYGgeR+WWdZQEW/jmarWXCjHLRESm5aKW5IRRrbiqMRR5QPVVcQHtSTThAzR7FbIUqVzwSjGp9SlVGUN2f1s2b0Nn+nek/WBv3yL3miSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789394256; c=relaxed/simple;
	bh=4C8oUlW/K8pKlkOLxMwWsCa9VAC3cTK/vHmn35fjaPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nrdjMOwrjEBGbuxZdbk1Hoh7Ga23I6mZUCFxoSAs+PEU8B6Vft94g0+ssiW3kNSvbFDCOZywBOq+l6Y4Mio+zElBz9+kvNWz7dqFZeAvGjOl7wnlerq2vSn4dDjYxr7oWBl8fRbkkFoNFlNomm7D3uLr0WU4186wgoQLJ2MHQBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2utLZvu; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2utLZvu"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2dd68a16955so8682205ad.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 06:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789394253; x=1789999053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qaak+sKiArxa7mKTlQvl1SbE11tdZGIRrd8OTw4JELM=;
        b=c2utLZvuS2Yyt/JHyr6bc9kW4ekQE2B3ViaOdP9gR100gAoCMVwd5152py2B+EKSjn
         lBYF29FRcg0kDNeQ+yCkmRMHF4N0HWfKxxAtH3TkM/w6dbuMmTFy9oS6c5qRzxQ+POMi
         ooBmxomaXFopx2xMv9v8lzvPTpPiRw8e/AGe2pNV2B/QFuymR+EbasQaF2NV2AddS4du
         SvPepfxWQjqgEBi/oL5myebi/d62aOcP96D6BC2xwsQXiLFYRR4+kC/pw0hvJbitOjoD
         pxGkLg7svnrUFJsTd6k+4MkKDdAh5LggEBR3TcTulFSg0PVWhTosbpgDwKz5SiZ2yrCu
         zfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789394253; x=1789999053;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qaak+sKiArxa7mKTlQvl1SbE11tdZGIRrd8OTw4JELM=;
        b=DK+NEXmfAeUVRrih/KJr/4B7POH1pJ+vCDvGzK+TZY0pI9SsOzE41LdhvXUzcy9B/g
         utijcis+ndjeieo/Hk9AkoIM6j4UGfbgzGD/t6VdmkNByz+NKYloM0pm0UuYZD2tC+/T
         jhTyXHCqDFG0sUR5ugg3nkehcGUcQx+IKi7xSWF3xIN5EImcffLC3xk7HOnE/C/F/KcU
         w4RG6hRiIuC1cEzW5oSMD0/iX5zs3zWKW+E/ekw6YkptLxVN0lRYziZ5Y6tlmXwqVc3Y
         HaTxQiIdmD2XiAG5u7RYw1hezRWInTbovy2HPuoajJGzWRBY7tvM6xTAveU3sqW2RUXr
         P2QQ==
X-Gm-Message-State: AFuF++li6hSjnSZLCvBCmIKkDPPzzE4bmJ98s8wcU2GijOsN5aDXNy7h
	I1G2LAHlidmdh/u1vOpv+uWBqQXMbTrFnruQzqqZ00aHUTihNCW+MM4/
X-Gm-Gg: AYBFou1+BjwDAtSFKpDe+AiO/E+Kq36smibbvrg5UHU0NBfDvXootWD18lHdgDiKHPt
	0+1YMN7QBdTmc1/ZM4oDfPx/kp0L7qg7zkLaRjx5D0IlTvU0tbJ3OKvmJVpQaM1qfkxXUqcRbUi
	2wUIuJ/RJkY47zccUNzkHyVQ86wv9zg1C/dvWr9TWzz0b9OjYxeduyJ1QTvyWkgYFk2+b0pS70t
	mmnRdcdMtXcQzXcJodlY83MQFE4+CiVXaCsUMy//KFWnJzGhyHtOjI2Hs2Dieu4+M9i+70IDq8U
	FKTWXpIROHJ29VHLrtcqPbe16Ub9up0QQ5qMJos00uc6Mo/TwpAJKnhK9D/tOLpbCOIhuNjD+AW
	zJpeJ4rdUppGOcmSckRaJ9a2YVFs/IyI8J33qjodzW9wQ2DCYBwgWMJWIKdpUk/R+ipKj1x7AUv
	3sSCGHziOlftq0j5V/sTfwoJauZK+zuAMoJFDL/esefsc0mk7NJ2dz8A==
X-Received: by 2002:a17:902:8d8e:b0:2dd:6a63:4476 with SMTP id d9443c01a7336-2dd6a6344c1mr28308675ad.10.1789394253055;
        Mon, 14 Sep 2026 06:57:33 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cff297esm49156425ad.73.2026.09.14.06.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:57:32 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Luca Weiss <luca@lucaweiss.eu>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] leds: flash: sgm3140: fix child node reference leak
Date: Mon, 14 Sep 2026 21:57:23 +0800
Message-ID: <20260914135723.1741327-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sgm3140_probe() obtains a reference to the LED child node with
device_get_next_child_node(). The probe error path correctly drops this
reference with fwnode_handle_put(), but the successful probe path
returns without releasing it.

v4l2_flash_init() takes its own reference to the supplied fwnode and
v4l2_flash_release() drops that reference during device removal.
Therefore, the reference acquired by sgm3140_probe() is only needed
during probe and can be released once initialization has completed.

Drop the child node reference before returning successfully from probe.

This issue was found by manual code inspection.

Fixes: cef8ec8cbd21 ("leds: add sgm3140 driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/leds/flash/leds-sgm3140.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/flash/leds-sgm3140.c b/drivers/leds/flash/leds-sgm3140.c
index dc6840357370..51e31fdb78e5 100644
--- a/drivers/leds/flash/leds-sgm3140.c
+++ b/drivers/leds/flash/leds-sgm3140.c
@@ -273,7 +273,9 @@ static int sgm3140_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	return ret;
+	fwnode_handle_put(child_node);
+
+	return 0;
 
 err:
 	fwnode_handle_put(child_node);
-- 
2.43.0

