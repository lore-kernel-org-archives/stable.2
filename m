Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F00412C0C
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766671; cv=none; b=pxTfB4YfVEzSm4PrmBz+I4iTGEzsGJcEr1gPOXxDgN3FXvQaPv8mXn1ma9gSLRzTmeZz31fV/b3WdDZa8+RiGjpJG6f3Q9cBfjyf/S+fyL3925EshfFJpuX0je9vIRIu0xVhcWLHzqZzHaZEDzdbrWtt1fyfRbiAX8tOBsY8Rug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766671; c=relaxed/simple;
	bh=q1Uz+Gm71OPt/zJsTxyArW2pEOjZRyhgf2I4biF/dNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GYFgk+VjU+rNc5EMHW5zFUeal/w0Q/bAiffDoLuXuRRORReyPjqdn857M0rcj2N6/liAuee1sJbPpTbxtnVl9cwXgfJASpp6kKflg4mq0dIHfRvplzMKOzKcRXPGpzsTgEB1wo07WH7EXRTT6pfaSl9ghI1uNuJuoPjnu5oPLUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mGG62n+g; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGG62n+g"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3810c5d691bso2831180a91.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766669; x=1786371469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iWp6MzQC1qDygJL4OCtM1qnllOHL0djYegVbWv/i/KI=;
        b=mGG62n+gxE57o+8qRAEcvglTLaHHxWqsRO2gbcsY3lopfDIO7ynotl6PvKeHun06CS
         xC8fGyYSlpPAceQ7AL3qvtDlAGz1dBj5JVgSfaXpyIvFAvakseHsxtYS+2LUHGmmwpLd
         dl1iqbYxwpPkLt665JTbDu76QziLMQy+HR7I9lBNPTAeiwboxCdKISVzC80kGgP8Qj5h
         bf81nGvYBRIjyWlACQwsHrbmmAes2Cyo2vFOD9OhiSvfFmDI3l75M0iFy4DJjAB49Sdp
         o2AY/ke65dcrhEBFzsupDdSYh9m4NOfnpAqeoy3yvCqi39HNu/11DsOTaFzRQ9MNiB2b
         pn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766669; x=1786371469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iWp6MzQC1qDygJL4OCtM1qnllOHL0djYegVbWv/i/KI=;
        b=sMhxWqhlge+VIocCjBy6ID+p+saTJxylHXyyacYPjIr/YDc6XUP646TKeoktKH7PfD
         Q6cvTd07eMgEiuc154mTNOTaEj6ysB7vtBGvc4e38l9YjyB/Sshv4varH8KwZWqSw+Pk
         bX9RzFmBLIlowQdz+ak9BuX8cf9q8oISULF+gwosVjSjUqIrD5amOMBHBApvCEW3bvkl
         T/kSBMJW4INSBXvps+R7diiE4Oy7+bLoAmC25ola8F/OD6igL5tUi2xTmfOpy5JJWkFu
         xThxzdNKUt3HhR9zC6GXe3E4OR58Ak+XwDjiubwrObZMzM3W7u30Tb80z1n9TmS/q9L+
         QdIA==
X-Forwarded-Encrypted: i=1; AHgh+Rr7Nc0xUfeAD6ZjrcljbSDUSHkI1065U83xjc/3WzZoU2PFhP8qotr+6bP44qkRMEp4urNrgco=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9FWKuZr0izylJu7eEphWBYKj27GMcMx0zdBFzyprOqrEm8DQ2
	b/mpjqVwCi65mHkt4MWLSaSt2ua/dm5bXyqdnb0PqPjQ9o5dJvaYN/jX
X-Gm-Gg: AR+sD12XOIRGgvnbC7oxxvSM4jDBSfwqEWiUUlS3euuI//cdFr/SQXvlHYfrQXprcpP
	KLw5AuJI3XgmfD5CSP+0Qi+zn1FwUbcbpOxtu1hKI4s0EzVs6PxWLENkx6HcyfobSucwuY3kR51
	kRr1yE102Z5vGln1MuIWQj+HTN2nUUpZJpqANHPcWgxCa/nnqhtO1hm052FyJaqD+7vxu6z+5qZ
	PDFEN4ZOpLGHw58Ift4k4P7JaR6rLGSCqCGH+f+R5p4h49D9zhK1j4Vt+pbEgpZnBr9afYtuVAc
	wmyOZDJtyI8JCXd7Incz6SZJW+UcHh2B+rZNjk3rwvSagT06H5q4TG57pyZ14gW88sjQ/7RpJ8z
	kD5pJuEYpQHckzqX9ABlcMOPgsBydQLfP69ebE385Y2pj8+62kXYs0Zt4L+gTssQZoEaS3ICsJe
	hyY6rZyatH87wAm6qa0PZoq8ODBIBzrvrkvxtnQeMMiToAtW/UCdLHj1JGId4bHwmuyF6EhZ/wI
	OJDtQZafsYHwbK1r6IG
X-Received: by 2002:a17:90b:528c:b0:37f:9ce1:7364 with SMTP id 98e67ed59e1d1-38fbc4d5e09mr9059524a91.26.1785766669331;
        Mon, 03 Aug 2026 07:17:49 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:17:49 -0700 (PDT)
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
Subject: [PATCH 05/32] clk: mediatek: mt8173: fix memory leak on module removal
Date: Mon,  3 Aug 2026 23:16:32 +0900
Message-ID: <20260803141659.559129-6-akkun11.open@gmail.com>
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

clk-mt8173-apmixedsys.c and clk-mt8173-infracfg.c do not call
platform_set_drvdata() during their driver probe callback,
but their remove callback calls platform_get_drvdata().
This results in platform_get_drvdata() returning NULL,
which leads to calling kfree(NULL) in mtk_free_clk_data(NULL).
This leaves clk_data unreleased, causing a memory leak.

Fix this by calling platform_set_drvdata() during probe.

Fixes: 4c02c9af3cb9 ("clk: mediatek: mt8173: Break down clock drivers and allow module build")
Cc: stable@vger.kernel.org
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c | 2 ++
 drivers/clk/mediatek/clk-mt8173-infracfg.c   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
index d7d416172ab3..65dc4489a09c 100644
--- a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
@@ -179,6 +179,8 @@ static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_ref2usb;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return 0;
 
 unregister_ref2usb:
diff --git a/drivers/clk/mediatek/clk-mt8173-infracfg.c b/drivers/clk/mediatek/clk-mt8173-infracfg.c
index fa2d1d557e04..9b8c35897789 100644
--- a/drivers/clk/mediatek/clk-mt8173-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt8173-infracfg.c
@@ -128,6 +128,8 @@ static int clk_mt8173_infracfg_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_clk_hw;
 
+	platform_set_drvdata(pdev, infra_clk_data);
+
 	return 0;
 
 unregister_clk_hw:
-- 
2.55.0

