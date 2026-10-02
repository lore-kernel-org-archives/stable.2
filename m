Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B81A5172FF
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790972433; cv=none; b=azXQtKqkksgXZypXDj1HuXLJdSpHlHosZOChBqy7g3BkHBMPPSLSiau1O1Gtu0RPmoXFT06RCkhIy8ONygF2PeojnYtwSUY7Bd5v0mU95R75qcLeCa9+uHsdw4P3s6IRCaCGqUITO6DXuJNjfLVOy0mFzxicz37NRVR1KXdSvxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790972433; c=relaxed/simple;
	bh=tuvymnvqWK7QHKbCU6yufXj617WJPFKk/7YJcRL7A4I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LF3n2zSrOPjwwwWAT8vZwgjoS5Wb78WC54r/NI/bp7RN4Gq0eu3eb3HrxDHnUzOYHOZ3kKixNgk0pq6z8O1dTXJY/qG+HzMLP3MfS7CDk6w2CCldi6A+YvGO2ljoDk76NGGFYZ9poPqs25VooFx7M9ezwn5PDbpQGOv9xLX1t4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdGR0gam; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdGR0gam"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-93910ad20d4so889237585a.3
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 13:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790972431; x=1791577231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yX/9xC1BB29XKcsi1gHnIwdtNtc2m1SRNjsZRYQWmUk=;
        b=LdGR0gamH1sQUnnwYXEukQYfKTw8AfBhy7UwafVWN2llNSG6Z4WliznK9blf/pTwJg
         8cqHdDDoN4LHlqS0dOIc2VjSZ+w7gyIF6ijZgQY2FmRBlZrMMBF26lWco9kqxCGNIOCE
         qtRl9sr+ykRsAhWKpRyPv8huxsGx5kS/tmooyX5FuPsB+N6LGBoQn21iQ+pSc0X2XJMz
         JZ3JFc2yf38RVFtMuX1Ly+fp28Y147Soo7MNj9KPZPV8FgPIrmIJm3sGm4ZvchK38EtG
         ZJWw/uVUER/5lc053fJbua37SGug/PDHBd0rGEUiwakEH500KRYn+X1XzDABz7Q+Rdta
         Vwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790972431; x=1791577231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yX/9xC1BB29XKcsi1gHnIwdtNtc2m1SRNjsZRYQWmUk=;
        b=gSmt/Y6lO7higXM2TGIK7CkGUaW3tOyRC7qpETyiaserusMuQuw2RnZBKbQqM+wiFB
         TjscD6KaMmAFeHou+oT8lqbeO+uqpdx9ckOGyC8s/Yz1fS2qdyaVViAy19ebWC+qrKch
         NWE5/5winVwHO08PtZUqFY9NBER6y8WyOs+1tNBJ8GgxbAhVo3hemZTaq6aczZepZSDQ
         M7nRJ4jGYYgNgYDiKKmg88fp+i3IJN8a9fWfAoEflImLssU5fpJrku9CKVUxii8ZBZ0Y
         W3TX3h1nGuKsDQsqv5JRZYA3OnF+ujFL/erWtFljis5LHIuKCeeDt6u5xegzqamSLgF/
         zfjg==
X-Forwarded-Encrypted: i=1; AKwUvBzwv0RaC2ScTHlYtqbmLuuzXlyNlyc8B16mRcD6AHDcXYiIyTVdtM1rzXKYiE0qYt8LPSF2UBw=@vger.kernel.org
X-Gm-Message-State: AFuF++m8hyLE0Ek32gubgKDfpJ5X/batqxFUY7W6fPf5UXDPlRfQFjBX
	NN1pFm29Zia0O4AXeBX7YgpDd9a8lIUiDm6p4IfTQIsqE30i3ltVyY8=
X-Gm-Gg: AYBFou3dVEHPGP0G3XODTme1w3tcP9lqdWoBcjatsEVwtz1tkyIUEtzjJF8heWQEQC8
	BAFPrjpwICUXh8ffAHiX2D3SmnKTHXD0ThthnPCBQFZikYE8yqYgZfJkfWA4u3KseBFAElquZh8
	dcYU6OuQmT2vEb63u4DpSmXxV8g+vtXVuvNPtbqMEi5/RAniG0qkSSa3twPR+WyF036IjQLUZEj
	HI4jrlguWJmwtXG83xsHjUS7+Qd1PlN7f1B877GJCNHCbh30YesO9vOUCzb5LM5J5OloYr0w2zE
	Cm9xKKGYZmXEdjASoP4ibjxKN4EUifbIiH/8kqGXONFEPGMd3KLyoI6LpRZfFXxJUX6pOmkGMwM
	ziIZd1vWQAyGGwQk63E30n/glRaVfBFv/PG88i9d0d4BBT5wv6GokYjOoLVkxivB6Vv++AgyWyJ
	c7FE8jvC+I3TlIp3OwTKPsoZa9PcQk+Cpc9Im7UYg73GVYzL+buUUQs7EGYkIf6aT4dLCCc96rM
	UF4Od+9rt4lJwtjIVhsm2y4huSOoRRiFTzyCoWOj95XO3O7IDGhxtSOOa9xvlFb361F4AokoZ16
	Y5WF7LoVHwHoyLffSOp3jUNtWRDf
X-Received: by 2002:a05:620a:649a:b0:93c:c405:3215 with SMTP id af79cd13be357-93cf17580abmr702882185a.44.1790972430750;
        Fri, 02 Oct 2026 13:20:30 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cca1a63d8sm305025585a.12.2026.10.02.13.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 13:20:30 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH] soc: mediatek: mtk-devapc: release IRQ before unmapping registers
Date: Fri,  2 Oct 2026 16:20:28 -0400
Message-ID: <20261002202028.420575-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The managed IRQ remains registered until devres cleanup after remove
returns, but remove explicitly unmaps the registers used by its handler.

An interrupt handler already in flight when stop_devapc() is called can
continue accessing ctx->infra_base after iounmap().

Release and synchronize the IRQ before unmapping the register region.

This issue was identified during our ongoing static-analysis research
while reviewing kernel code.

Fixes: c9c0036c1990 ("soc: mediatek: mtk-devapc: Fix leaking IO map on driver remove")
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/soc/mediatek/mtk-devapc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
index f54c966138b5b8bda32c383d179a57c78172bf52..57ffe49c99eeb9b0989bd5eefa557a0a7dddbf18 100644
--- a/drivers/soc/mediatek/mtk-devapc.c
+++ b/drivers/soc/mediatek/mtk-devapc.c
@@ -54,6 +54,7 @@ struct mtk_devapc_context {
 	void __iomem *infra_base;
 	struct clk *infra_clk;
 	const struct mtk_devapc_data *data;
+	unsigned int irq;
 };
 
 static void clear_vio_status(struct mtk_devapc_context *ctx)
@@ -289,6 +290,7 @@ static int mtk_devapc_probe(struct platform_device *pdev)
 	if (ret)
 		goto err;
 
+	ctx->irq = devapc_irq;
 	platform_set_drvdata(pdev, ctx);
 
 	start_devapc(ctx);
@@ -305,6 +307,7 @@ static void mtk_devapc_remove(struct platform_device *pdev)
 	struct mtk_devapc_context *ctx = platform_get_drvdata(pdev);
 
 	stop_devapc(ctx);
+	devm_free_irq(&pdev->dev, ctx->irq, ctx);
 	iounmap(ctx->infra_base);
 }
 
