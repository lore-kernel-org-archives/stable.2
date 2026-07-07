Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459E42F8E99
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783410560; cv=none; b=pd2wuomx3J35bCWZOR57CAo6r0ddKGnjyEkTN8Of1ov680mplA07J+6mZM4iDqhwcXuuNWPQbIL81hqTwaC2du6waGLFJy+wxP7KNo4C2uNZAGjJS9PyYiPO3lcQOngJxKvnhXqagzWEP8yPa+0sXAkPB18/kakercz5aGA+d9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783410560; c=relaxed/simple;
	bh=AQFEwCYz3sBnBHq96AnYA2nhIyZeOMXIcdTpdmUobzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C0NbLWydszRqc/Wj8I6RMpcdZDqsMxD2a7cqFT77u3lJvzGrWhx++CFIDxV+xhu/NIevMq75Anw0Uk+wy8rcHeGCfdUoezMlL+Q6WbGAXwp/jx7m2/9F++Bgg/MDLDc/8nqjxUeVMsWhzAjl5LZin4sCGbkfOq1GqahZWlJ/K54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bY4UowhU; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bY4UowhU"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-380cda7f00cso3326261a91.0
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 00:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783410559; x=1784015359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZgeIwqrRwEWwVAYs7V5QSF1WwroM+m3Iz8O4TkBApNo=;
        b=bY4UowhUwDHD1/ifDLtHjlpcMTv4U/JAmG4iwmV/wICM4Aor2g1BVNoPjNleVKEizU
         kyUoqZxVRPlDhk993n+CPFfuQ9/sLGBLkCBhetMakoQTDMavJ421yFFwE5hNspHBrtZK
         ykyiM748LrNC7yKhYWC4l7TOD9iiHU6k9ovxGZaiTqGtw57rGuuKhGMQiFljfgWMzYv8
         lLQkQZuK63J1xb0pst9MSxBrRZt2Nv8B2XrRsGMzJqRumonPKvUX2JmHqaj9qIW67Cl5
         rqfkxvm9w9vGG5L/1oAuUQgITqYSKd6KjREnv+p3Rn1KtAhCpm6tuxtlfjjBTwPIexEs
         SyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783410559; x=1784015359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZgeIwqrRwEWwVAYs7V5QSF1WwroM+m3Iz8O4TkBApNo=;
        b=UefNI+BckD0xdbP6iY+EY2zeaFqApw+6DFCa0zMJk9Nldvfj7kOI2BRJocJNJd3NS9
         cNYnBNdZ+ma5JYeUQLGzBxpiO5lyIv7fkGnSFRvMn5JdVVAxr4bRAR197G/roREmiIUq
         QwM1kx6J6115b92vLyNUeDj4JMieAzkXYqXlJx9iXZNBwCAy7j7JY0vmRwPbPjU8f1tb
         pL5wlA1j/aAVvKzB3N39bf4GBmQj2O74qqRGITT+giMrjnB3rotffvjSiKzo1naQQsiD
         mwvKtvBMjAuvnL62EBjGdtr8mJi0D93nCy0z1+MzGrLiG0KAcDuHfP18KI7stbeDHQcV
         5l2g==
X-Forwarded-Encrypted: i=1; AHgh+Rpb8gHbk2J4iWc/AqJCBueUwneIUmfEhWnTBVfVGR153pr4bguh3sNWJDXp4T33ry8cQS8E1s4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeXrVuUzsllOA8dfW1z7S4x94CchjtrLHaf5XhKGQIVmVpa4Sh
	1GYBBnIzf+gVccRrPszwypEJlP7g6nXGvilhT198pOyon2IBF1PfzLhH
X-Gm-Gg: AfdE7ckl5M7ADo4etCzd+8ZkFMnufPT1pdqduZcq7gcRmNnhJCpRw23puis+7UaVFuh
	8VE/NUcyQo9CRm/19FP/TdwL9eqEKWBfSYlJJGBBWz4ve2UMmMu+zaFcYPecRO/SFYiQ31FZ+KC
	6jVNGsZRLGXejrlk6D+TYuPlYlcKzbAhw3AYZLmTGtOF8DsqPMzJV4ydCWrLk0dPc8J208jw8Qt
	VCXzcsgnaZwZP/aYWFrlIOk4Rd1N2/AIxHrVd3Ub73SyBmAcFTzjLNiPvZf6UoAuhNXl+bV3D7R
	/5mr9JK+Fx+D96guaflVEfUcZjCg9TeEwsjo0oblartvaXlWB0IEtarrf0yNGQp9Uq8bV1YgmVS
	o9fU8vmxFB1MbewQRc862zt5Ft2ZmG7akl/oXMPzv96+ZPtn2diUE3bB2GVY3iy0ABQguQkcGzY
	LN+Bng5Krl75S+eAIW3P+zplGGVQ46yZIpehlrsyTjeHL1
X-Received: by 2002:a17:90b:55cd:b0:381:e93b:f740 with SMTP id 98e67ed59e1d1-3875595f2c7mr4256887a91.15.1783410558557;
        Tue, 07 Jul 2026 00:49:18 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d20a361asm626710a91.15.2026.07.07.00.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 00:49:18 -0700 (PDT)
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	linux-kernel@vger.kernel.org (open list:ARM/Mediatek SoC support),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	stable@vger.kernel.org,
	Chen-Yu Tsai <wenst@chromium.org>,
	Miles Chen <miles.chen@mediatek.com>,
	Akari Tsuyukusa <akkun11.open@gmail.com>
Subject: [PATCH v2 1/6] clk: mediatek: mt2712: fix memory leak on module removal
Date: Tue,  7 Jul 2026 16:48:30 +0900
Message-ID: <20260707074839.240676-2-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707074839.240676-1-akkun11.open@gmail.com>
References: <20260707074839.240676-1-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clk_mt2712_apmixed_probe() in clk-mt2712-apmixedsys.c does not call
platform_set_drvdata(), but clk_mt2712_apmixed_remove() callback calls
platform_get_drvdata().
This results in platform_get_drvdata() returning NULL, which leads to
calling kfree(NULL) in mtk_free_clk_data(NULL).
This leaves clk_data unreleased, causing a memory leak.

Fix this by calling platform_set_drvdata() during probe.

Fixes: c6368ce86435 ("clk: mediatek: mt2712-apmixedsys: Add .remove() callback for module build")
Cc: stable@vger.kernel.org
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mt2712-apmixedsys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt2712-apmixedsys.c b/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
index 54b18e9f83f8..087cf574bcdc 100644
--- a/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
@@ -129,6 +129,8 @@ static int clk_mt2712_apmixed_probe(struct platform_device *pdev)
 		goto unregister_plls;
 	}
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return 0;
 
 unregister_plls:
-- 
2.54.0

