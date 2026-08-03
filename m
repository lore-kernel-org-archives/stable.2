Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C7840F8ED
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766662; cv=none; b=ulmgKaFEab3GQvfEJuhgyzhdDuO1fQtVNN7f+Tz/d4s1c2oBTqkoHBJXKdEnPb4V3OFxrD3WtWUbYGRMwvs1qLHwQDxkx7o8Q0GNtP2CW0I3MDLZWQV4/fe1/21YnpARZu5MLWxWZPioi/uGgo2Neowa8uwbPeOHBZBnJxs5Qsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766662; c=relaxed/simple;
	bh=J3vrVWoQoo9SDz7Fu3bUlFwKeGghiPaMM54JY4Dk4aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S3LvZHiYnfPOWMVMl/rsDoRB2f1xbfp5jUsHZXHDh7P6qfaSALNOd0IpBimlhXiL+GxZlA+Faz232o/GtHq+LzX+9nez6IbhfrUaUhftSnHF9ku6wGzIXl1CKfjGCeUhkteRRjFQoYHPemDvBehvtNs/yMiCELGgX+tkno9mrZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rAGQs+em; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAGQs+em"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cfff5f88dbso38736755ad.3
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766660; x=1786371460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EQTegJW8Vwp7QjW3gCxx6DQBByocZqrqYYXa3MGI9cg=;
        b=rAGQs+em83p6rtehKwfH3GNyiBRVLVTpezTVT6oGWud3x1dQTM42uj0shafNr3cHNX
         VraHzXeVroxeTY+J4QctFngWoGJL2qkHhNsIy7osIXAU+yX8kAJdQPHyT+T9pVZ2H9iy
         ex+aadc/8kmf9Rlf3NDFWCBcM9IEklwJF39BObM4u4GcZbYwIVsTyTaLNUH8TPwyG2EO
         EjuPL3GuB8zhmHwK48D0p4+f/gqe2cq8NJaZo7Uq2WNCNq9LYJ0dSFUiu6EDGPB8IZI3
         WqRHE01SZkuHdjfVbzf+k48LbNF+5eNRMAn6Hf2Pl1+dvsE9vEPx7H5ELwvSO3i2q4MG
         /sOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766660; x=1786371460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EQTegJW8Vwp7QjW3gCxx6DQBByocZqrqYYXa3MGI9cg=;
        b=WJSJp0lGmKY/DcEwmSsmm83iQ92+6284o5druhM2GLEx6oAJjvd1iOD79eOBHIg3uF
         /Un3xn15zwG/ct6LQqlZHB6aIvfqepWPRrG0OKjJryxOGTkpieexDSOlyUmbUUQPxRfS
         /iEF3cn9yAvJ/JMBnjePL54QGsQGP38brlk2RAbgTxaPc93qRdOJ6/Cr3oeooBXczhD7
         EpBZfZL8b9iqCBQdWuhntllHhReQf5llLnQQWdkOc7SVMR+ZAvoJIwAvXK4IcXDSI+7a
         JL2dxAF8weNf0Gni9ZGv/j992dn2WL0TyHfTosZwKbcRNtKQAWwUCgOknyUGnPpwjDTq
         UHgg==
X-Forwarded-Encrypted: i=1; AHgh+Rqz/RNjK7Y8h0DlOYNdV3tqPEc8o6iiScsk4Or2aP1p21tib30/kWPgDDhmZSzQ6pn7BS2eT1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS7HnrB2oQXDpr6P4K2s/uV3M9369+hJG6GzrKTVyMTdtwXK8P
	4iDi6TlfhZFi+LSxHuP/Lv0v2McA+SIwYnXIo8sDTsJzpnMQ0I48+U/S
X-Gm-Gg: AR+sD10jt9rZAaMnZQpebmstuwcNJIqOj8hDaoSfYYlc1eA7dYcQA0ZbFG3S5GvrX0M
	NFmppi4Rnz2zLcBd21fB65T8A8E9OgRxl1tiTj0MbCX90DOW1gvCTk4tE1HtSfsD1PdQou2XJrB
	lS3YrQDTPaIdq0rIpck9gdkiRlzmfCR1zCmxKcTmFizYz1GEquRiIwU8PCaevMcgVclQ6aLWWll
	EHkZ5P1Ov+fR/vPoB2jNUy/AIAwr+qbzi1PooLx3rBGDhzq0egsi232u1WwqUUDJBGshkWEIeAJ
	WlJPXc51uWfkDTZ+inO+0Yz6DXnC+LamIF24C78Pahau/o1A1AKGLxJjygWKm4iDxRECv4fDybQ
	2Q5w3KWBLX3DUVMk6RpNIdGc43ZYQtR+a49+x7v2knwlfZl7f0umo3W7pV2JQnsm/slRRUo3pb7
	uMYVd3kEtySsb9wkLOzUEtEsPcJFG7zkBnN+ACke+t/JekhHnjssXikSQQgaEYN5k4SpArCSrGe
	e1hNHa9tBPSe1P8V/Gc
X-Received: by 2002:a17:90b:51c3:b0:38e:4114:d8c7 with SMTP id 98e67ed59e1d1-38fbc0b4881mr9861203a91.0.1785766660245;
        Mon, 03 Aug 2026 07:17:40 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:17:39 -0700 (PDT)
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Laura Nao <laura.nao@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Kees Cook <kees@kernel.org>,
	Miles Chen <miles.chen@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Sam Shih <sam.shih@mediatek.com>,
	linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	netdev@vger.kernel.org (open list:PTP HARDWARE CLOCK SUPPORT:Keyword:(?:\b|_)ptp(?:\b|_)),
	stable@vger.kernel.org
Subject: [PATCH 03/32] clk: mediatek: mt7622: fix memory leak on module removal
Date: Mon,  3 Aug 2026 23:16:30 +0900
Message-ID: <20260803141659.559129-4-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803141659.559129-1-akkun11.open@gmail.com>
References: <20260803141659.559129-1-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clk-mt7622-apmixedsys.c and clk-mt7622-infracfg.c do not call
platform_set_drvdata() during their driver probe callback,
but their remove callback calls platform_get_drvdata().
This results in platform_get_drvdata() returning NULL,
which leads to calling kfree(NULL) in mtk_free_clk_data(NULL).
This leaves clk_data unreleased, causing a memory leak.

Fix this by calling platform_set_drvdata() during probe.

Fixes: c50e2ea6507b ("clk: mediatek: mt7622-apmixedsys: Add .remove() callback for module build")
Fixes: 838b86331c5e ("clk: mediatek: mt7622: Move infracfg to clk-mt7622-infracfg.c")
Cc: stable@vger.kernel.org
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
Reviewed-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/mediatek/clk-mt7622-apmixedsys.c | 2 ++
 drivers/clk/mediatek/clk-mt7622-infracfg.c   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt7622-apmixedsys.c b/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
index 8a29eaab0cfc..fae8abda14b3 100644
--- a/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt7622-apmixedsys.c
@@ -109,6 +109,8 @@ static int clk_mt7622_apmixed_probe(struct platform_device *pdev)
 	if (ret)
 		goto unregister_gates;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return 0;
 
 unregister_gates:
diff --git a/drivers/clk/mediatek/clk-mt7622-infracfg.c b/drivers/clk/mediatek/clk-mt7622-infracfg.c
index cfdf3b07c3e0..cec19447d637 100644
--- a/drivers/clk/mediatek/clk-mt7622-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7622-infracfg.c
@@ -90,6 +90,8 @@ static int clk_mt7622_infracfg_probe(struct platform_device *pdev)
 	if (ret)
 		goto unregister_cpumuxes;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return 0;
 
 unregister_cpumuxes:
-- 
2.55.0

