Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A74240DB4F
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766657; cv=none; b=Ll3fydnK/S03zbjWBz0Xg8MwjWkeuLwQPXpDwdMtgfrPvuHIaKrBj8yQ60v1NPPogKb9nwAPpUyk0nq+NyxvIHPR32WoBUSLEloJ+Kh/uNiKhgt5LWeIgMVadoULItfN4GIuKPRwp8iM1DZb9w1bx7D8ixo1P0r1//ldJZHzsws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766657; c=relaxed/simple;
	bh=jXMNEPGSmgzb4Ni0tFwqVaC5hDYyBsmFzVyIZbl8eok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSFnbuhjHcMzraC/+Yprm8pEqVdSOdBjA0xdsnNCjTesjzqF9bRzcWCvD3clToTb7WFtTB70xqClJA+HV+Yh6znBztEKwxNE0IIyAjpx1cn5YVItqW961ykt0BFVONbGwpf/azxZ2Ly1w5hld0MC+1OFHj/LxP+jygL6XFgz4Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrEGY7NH; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrEGY7NH"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cacf197759so49754795ad.2
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 07:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785766656; x=1786371456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YIV+HU50AEtRbtVbE/kWRl5gYNOX4lr3tpB0iIeyarg=;
        b=LrEGY7NHH8ULc+ge2eBS13hi56QQRdd/tb+/Z6J++ZCphX5LcEnmEC6zlygG4F7v5I
         8Gsj3rkPOaXrdWt710nYv8yzfMcqQ17zQgmjix10HOPNRcYVZDlwniYGTWtZqH48D76O
         utxhy11jJo1Xlrf3UKIPgXtULASeI1er9So6bfFk+ovguHBHQU3CADigYdSqquMNJJlF
         VU11fBHTmcfKOJ2F3s+0oozGHGGVzqf2Gtpo2LnbyhUlx19zMK7rGruEIfVatp7kBRFg
         UcMZAC8dZyU3jgMTrq9XatJTZ84jrfRNfeF54mPFsGpUJWEuj3CJwyFzU9qRLCs722hz
         aKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785766656; x=1786371456;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YIV+HU50AEtRbtVbE/kWRl5gYNOX4lr3tpB0iIeyarg=;
        b=l6yTbvwsuukJaEiu1tnRFmODUPhEHGmBEN+Qns20+gEwet7NZkxxdpHGadqVoiCjV6
         FoElGFC/c1ZegKdscsy9NTCley/4FChH8KWzDh9tnKE+mBqQvV1hahjwj5wyZDssMEAI
         LtIGmqPmnoncvyeGb/riCk+H3VfQmmyus3oQbu9hiMfDXiSLhSZZkthdOZ3uKh0qEUtJ
         HOwVyhqVTJeOzqJ2/xsDqgg0fvgLWB+4Ro8uToSetdWBwOlraAK7nN1mQL77cL/ezLPr
         WbWtB8CEn7lS9b9s9zr+9OX0a4VDdtSi9L1nFK4WN4Fiv+pnT7iXpl/n9H7Y2PKOwi6w
         NfaA==
X-Forwarded-Encrypted: i=1; AHgh+RqWhZInmiAdBs/AU9f3wn/PZlnN3HlWO5dw8KtxDrCqGlBQP9rWDmq5f3nhe0XmE7staIvlQKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuXgwNDuqtlHwWvmXrIY0RcvJb+xVZvqmo9wY9+nYviC+LlXpV
	cwBQlvSXmXz/1yaescXAt4A3rZW4yoqnTs8NL5GQkq6jX2qilR3bMMXu
X-Gm-Gg: AR+sD11QPsyYNzwAXycB6u2D9D+5MX9LZTcFZxwnMGr6gom8yKZ6qhMtijf47jub+sm
	uPxovq30CmwViZ2ZH3zwwmHaytj9w2UPNsQCn4/1HxZRXB7Z8GQWxhBt/9xTvadptYxHOUwqB3F
	endea+aRpqgik9SsROsvPJoxrw9APWv4f6PUiBZfD342n8jhAwaQjyyoA2jDxa4AxFwfL84yL7g
	pzc4hDw7aJHVPRAu3qix8NOmS3UP61WJJnttr+aU+5H2c6zxurji3+mFCLXy5sNW8eXsepSywti
	tbjlgGdZsDScMwqbTkzuKzRmQs59R8Lrx39Jd5L/+il2kx3Dia9OrhBS61/U9RG0JKzYMgXJeDp
	6WcAaGpC1+1IDmYCenvhSu13DnAUg+qnVIP/4O5SlVyhjiaYDOwngIs8iQztt7ZRxfZDCktHSKa
	mDkK0wFmF4/epUOD4EdYA+iqb5leZT8WgRLQrCjJL2kcJ2d4TI8v09QCGjHDL2xnv4z9fHTQclT
	ZGywSSFwy9SmsttJ2MP
X-Received: by 2002:a17:90b:5690:b0:38d:a8be:a597 with SMTP id 98e67ed59e1d1-38fbc56732bmr9286831a91.37.1785766655662;
        Mon, 03 Aug 2026 07:17:35 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fb30dff2esm4078462a91.13.2026.08.03.07.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 07:17:35 -0700 (PDT)
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
Subject: [PATCH 02/32] clk: mediatek: mt6795: fix memory leak on module removal
Date: Mon,  3 Aug 2026 23:16:29 +0900
Message-ID: <20260803141659.559129-3-akkun11.open@gmail.com>
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

clk-mt6795-apmixedsys.c, clk-mt6795-infracfg.c and clk-mt6795-pericfg.c
do not call platform_set_drvdata() during their driver probe callback,
but their remove callback calls platform_get_drvdata().
This results in platform_get_drvdata() returning NULL, which leads to
calling kfree(NULL) in mtk_free_clk_data(NULL).
This leaves clk_data unreleased, causing a memory leak.

Fix this by calling platform_set_drvdata() during probe.

Fixes: 0d363282bb0c ("clk: mediatek: Add MediaTek Helio X10 MT6795 clock drivers")
Cc: stable@vger.kernel.org
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
Reviewed-by: Brian Masney <bmasney@redhat.com>
---
 drivers/clk/mediatek/clk-mt6795-apmixedsys.c | 2 ++
 drivers/clk/mediatek/clk-mt6795-infracfg.c   | 2 ++
 drivers/clk/mediatek/clk-mt6795-pericfg.c    | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt6795-apmixedsys.c b/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
index 123d5d7fea85..239a3f5e1760 100644
--- a/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt6795-apmixedsys.c
@@ -175,6 +175,8 @@ static int clk_mt6795_apmixed_probe(struct platform_device *pdev)
 	dev_dbg(dev, "Performing initial setup for MD1\n");
 	clk_mt6795_apmixed_setup_md1(base);
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return 0;
 
 unregister_ref2usb:
diff --git a/drivers/clk/mediatek/clk-mt6795-infracfg.c b/drivers/clk/mediatek/clk-mt6795-infracfg.c
index e4559569f5b0..914bb069aa85 100644
--- a/drivers/clk/mediatek/clk-mt6795-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-infracfg.c
@@ -116,6 +116,8 @@ static int clk_mt6795_infracfg_probe(struct platform_device *pdev)
 	if (ret)
 		goto unregister_cpumuxes;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return 0;
 
 unregister_cpumuxes:
diff --git a/drivers/clk/mediatek/clk-mt6795-pericfg.c b/drivers/clk/mediatek/clk-mt6795-pericfg.c
index d48240eb2a67..27d0ef7d7b2f 100644
--- a/drivers/clk/mediatek/clk-mt6795-pericfg.c
+++ b/drivers/clk/mediatek/clk-mt6795-pericfg.c
@@ -125,6 +125,8 @@ static int clk_mt6795_pericfg_probe(struct platform_device *pdev)
 	if (ret)
 		goto unregister_composites;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return 0;
 
 unregister_composites:
-- 
2.55.0

