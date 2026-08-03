Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706A9411FAF
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766666; cv=none; b=gwOrd4hpITMJJPF6KKULdqZrsqPgXKWSz3mcDdKgdN0jalBzemU2KYf+UooFLF2b6mtHBDa8l1EmbclYO7uZmjp20keYinefgplCY5be3wJ0AB+9YGHbcnL1ud7jhb7LsdP4Wc36/ej1bFfDmiZzg7doFGCQVVYK7W5XQgTAYcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766666; c=relaxed/simple;
	bh=PU2WLxTCykVfv59jdFKxJyVwUaIMow5rckLVbB9Wydk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgFiU93/D/2rv+gnPiB2t2Lc/K+YumDvg1EUdruuqgW0yB/Wjd+DUHxQjSHvE51qU87PyuXagf7Zioj2JMuktdBXqi8JmeO6jfwPYH9G/6RJZZVw8NeDiLn9Yw6QZ1aPn0h2nkd96c2gaRrVqN9JCJwhMR1QFcMYbjXgvfVI1j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AyyC1YIm; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AyyC1YIm"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso2376367a91.1
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766665; x=1786371465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=13/m9BHJpTOrbyiXp3UlB7/KUp3A1MVFY837aXZLXF8=;
        b=AyyC1YImsRsLna/FCB8mGB1hdUoZGaaldEh9POag7q3AdyiZJAbudh4KQwgllQ/R79
         TdPxY+3HqXH6jzyBzhtHEJhcBxXjlrhWJushMn0I+SqdNVkuAWkA+w5hqT8GfTUSVzTk
         1ZceJi/0IjJvMcm5L+lMxOlIU6CnseejzoUgCAwOIrwD0pKgAaflm1TzzTlOcK8RUJMe
         iIsRwKHJ5LUAci/reLfjuR4QqqcyqS6+f+1P2DyRFRmG48dXnjm2Sao1zpdsBtlF3h7v
         yRKSNqykXy3Sz3nq4MwawChGBuN4CRE600tXQ7y1ihxMuZZC9s0qmSSQPR/pUjq2mH4z
         79jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766665; x=1786371465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=13/m9BHJpTOrbyiXp3UlB7/KUp3A1MVFY837aXZLXF8=;
        b=j7LKYUnDQGUnPk9pURUGIQ1ZgLAJTiMvvpOKevBOg5QX2FVA+LERvbeGbHNFkyDIlP
         sgCbBT4syAIv51C9EmoPs1cdxfgaCoQvWXJsi97TVeK+xWq9sRAR0FMhZ3ih8o9HUc1H
         l2VJHpgVWrshhfrVLGv0MFBiLoCr6rGTJGVRzqBCzbJrv/Lkxuv7jTB9xj9eCYsjdFJk
         OEG/U1JYhLjhnu6Gxn3lX4Jw2Pft6IO/AnkJe1RlTfpwyQwlqpj2cwtvmk+GbR2BlB+h
         sedoDe+TTwG9V81JOGg22zdx8r+d4Lb1LPuHS9NLyqr9yRH/xl6WgqUB3nXxziMobkC2
         Q8RQ==
X-Forwarded-Encrypted: i=1; AHgh+RrY5+B3dW1k1ImBWukbydnmPUrvZRMZnmzXh81TzmQpLjMea4VWxoAWj2JBA/udTMy0DfW++tE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMw9LSFk2+R2qdXm3YLBkfc5o/EmCuUSeskXnD1gQz5tchW8Hp
	kdzEzHFEq6Qfrru24uhnEitEdta8eUBLM/1jGo6Di/xCtptrumBhuGst
X-Gm-Gg: AR+sD11fOJHbqaXbkSisCVQq+2i4iUorgqTK0rZuc5u6u17Nkl7Xs+Wqls+cCB27G4F
	YICJAqiIhSb43jhna/y7XRwvbsBmqgBw++4cuycLYNT4ciL3AfweBX0hfsvZ/4Utm+RfLljmXqB
	JZGMP3laXJYwZYrP3V+gpQf3bhLQf80sEe1+5eI7dl6vwD6Pe7TWGwpEZcN5rTacwnWC1q9IePP
	DeN/LufNDQpfMxJRha5HX+zXNyhD2WseczTyJ6LrnpREjUmZpQ6e0w5JjzwzOHLI6WkIY4R6mT8
	mbx6p9haVw0OacHM0QGyq5MHnLwjgIl1adxk97ByCxbLk3WNToYuiO8/rojloNiJ0Q5Oacuj6iI
	CNwZQ3+4Ga4S/vWPZlHw4aj6HYCttTi5jRo2jJ50DwmKmEnwmkKNo5ohfByFy6mE3zhqQiWhuO3
	3mLezRL1YEMQOSyrs54LfYe8Psk5iq0kmIJ2GCl06CM9By1iJ+mdMvzuduuiYJw55kckLuf55sv
	qlWtge3PGXfzLTAoheE
X-Received: by 2002:a17:90b:544b:b0:37f:be6c:f3f2 with SMTP id 98e67ed59e1d1-38fbc3fe415mr9386869a91.2.1785766664794;
        Mon, 03 Aug 2026 07:17:44 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:17:44 -0700 (PDT)
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
Subject: [PATCH 04/32] clk: mediatek: mt8135: fix memory leak on module removal
Date: Mon,  3 Aug 2026 23:16:31 +0900
Message-ID: <20260803141659.559129-5-akkun11.open@gmail.com>
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

clk_mt8135_apmixed_probe() in clk-mt8135-apmixedsys.c does not call
platform_set_drvdata(), but clk_mt8135_apmixed_remove() callback calls
platform_get_drvdata().
This results in platform_get_drvdata() returning NULL,
which leads to calling kfree(NULL) in mtk_free_clk_data(NULL).
This leaves clk_data unreleased, causing a memory leak.

Fix this by calling platform_set_drvdata() during probe.

Fixes: 54b7026f011e ("clk: mediatek: mt8135-apmixedsys: Convert to platform_driver and module")
Cc: stable@vger.kernel.org
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
Reviewed-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/mediatek/clk-mt8135-apmixedsys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8135-apmixedsys.c b/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
index 19e4ee489ec3..e3b7dc13b458 100644
--- a/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8135-apmixedsys.c
@@ -66,6 +66,8 @@ static int clk_mt8135_apmixed_probe(struct platform_device *pdev)
 	if (ret)
 		goto unregister_plls;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return 0;
 
 unregister_plls:
-- 
2.55.0

