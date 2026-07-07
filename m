Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7293BE162
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 07:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783410576; cv=none; b=Jpz7jJ/aYVkNgnE43VfU2kGNRpYIvaSuA8CQBXYPEfqnHfZIcWtmLHHno/aoqWCNkMvAUG2DnBHDrw/5Pi7yXItppveZKoId/X2Lya9+YtxPtkEYP9B8dSatb7l9kSk8s4AB2//YOBB5VgABQto+5KW/nqH90Ca4YsOWecHmn2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783410576; c=relaxed/simple;
	bh=iKfTNxYnjS6abQQ8md24/nEgVzBAsjHRbhhBMnu5sIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+pIqom5g9idBupScTfWsU+PKiYW5M/8s+smTZyCX+5CMSzvp8lSepya0UuVriA1pld6q7e/+rmZLLVwIHSf/Ec6Mdn6YC4lScLa4PeqnUgcrvWOAjFBoBUWMGyl8CPizLnmCuemvLnbr19ZB1YCBfvhsAyUS+UofIJdeLwRE+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQ9E3DeH; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQ9E3DeH"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-37fc02e660bso3149005a91.0
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 00:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783410575; x=1784015375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TKaH37G0Ewqa53zWdK8uHBZRlRPd7/8BawFkzA4KWg4=;
        b=dQ9E3DeH0kh8Zafp9q7fH+hBU9U1oKTP24KHMdIuNb6G1l0P8CZ3BRnITagEZ3bdRp
         ujxm2tXkqomabAMVxA0AC0oamxPL71tAqzdx7f1cEAfFd0qwDUr4XE1C4BJf04xE8hX/
         g4tMH+gumgqIdvjDBpyGJD6VnR33uaLUEZj/GhaQF1aQEiJNASwNYcuY1tqvLmlxh6fF
         qRnw/dqTdUaNp1MPKR7wuU88Cqnp4aLItQNhg/6l7LjB/2Zb5AUKAhaRdF+oBHWXpBwo
         a6F3PLkcd3Myz/kuUBaAEbwLiJvP78uiWO8NRc8AsG+IYQy4vdIXD+Vq6cXuiPcrpfXk
         /7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783410575; x=1784015375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TKaH37G0Ewqa53zWdK8uHBZRlRPd7/8BawFkzA4KWg4=;
        b=C/XVyvbWXikgVe9Otf3iw8LX+S4+4TwFGOVinaS7xMGekRNdzOMbhdormWlbBn+7SY
         0IGrwRQwwHVOPAo2U+njSvegi6U/Y4VqVLc9aaXBxoNLu/SmWlYanEjp4HAJ28MmLycx
         bWLebP1dP8GoQDMY4hKKTTBoKT0eb1CJ4dC+8bvrj/IM41xwSs5qyGX0c6H5cxC+S4ne
         j5f2SBbkXkqSTWqV7tYNqM0s7XG10GacCl757DZyCNQrY4OQs/PdSWksZcehqY9kU+NF
         rTwfX1Ang+C5BUD42h5CyZ5nqDUlVdpe9irTySBtYkbYnkCkX1vD0utGYlBk9vyR+j7o
         pIRQ==
X-Forwarded-Encrypted: i=1; AHgh+RqgS0vtAnh+DKFzZvBL3OuI8GjbeLT6J9912boNlwPVGSMYGk8mcr5Qy3lggTEDrK5HvQq/lQc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg9UD3ZYi/IccxU+JGyPrgzGcV5KnhTx49X71m80t0AVa4MA7e
	pwjTNJbHdfH+QTcsriHBxhookGvOdI+ChuvuKMvsFHNYpKJ1ogYiOs0t
X-Gm-Gg: AfdE7cmmWj0rbBWZ5zIDLw/HffZ7h11j3CQ2wFTkhvF10vxo70qRSoDd8B7tHwoGsgS
	ErUh7+zeR1F40XR4bWcHbAVKWhUL2mZadliSVzILCBqZHc/UUd0VGMlB8D7eWPxvd3BbLWZfXb3
	b3pJD01f0gQ5YxXInu1zus3o0ShGTt8ApHe9Z/L6wR8xT7GB4DYjuyWWHABnl0GmlDv9HbNxEuA
	z4npOefw4wb9YGoGWEhSIhuAZrZqAC00iVE9yHJUSm4QJq8WDxBhpdmJolkzxxPlnZ+AgdAbqHy
	zgc0rILOAbT8iP6rwWxQC2jbjmnfGSjYpu4+VXNFe9EbX58Rs9Od486vwLc7byAWcrdlWQJqtU8
	ob8v28Ffo5+Xajps/rxrhaeZSWiFKCsnL/yE2LrsWgN6In+Q8fqt6z6+NxjW/4ARewOF4IzdiHv
	ue5Vw+dooIJ4N8R3A82WO9t5PPqyOAGpOmiMctIZ/PSL4F
X-Received: by 2002:a17:90b:2752:b0:36a:fcf5:64bd with SMTP id 98e67ed59e1d1-3875650bb6cmr3966713a91.2.1783410575001;
        Tue, 07 Jul 2026 00:49:35 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d20a361asm626710a91.15.2026.07.07.00.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 00:49:34 -0700 (PDT)
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
Subject: [PATCH v2 6/6] clk: mediatek: mt8192: fix memory leak on module removal
Date: Tue,  7 Jul 2026 16:48:35 +0900
Message-ID: <20260707074839.240676-7-akkun11.open@gmail.com>
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

clk_mt8192_apmixed_probe() in clk-mt8192-apmixedsys.c does not call
platform_set_drvdata(), but clk_mt8192_apmixed_remove() callback calls
platform_get_drvdata().
This results in platform_get_drvdata() returning NULL,
which leads to calling kfree(NULL) in mtk_free_clk_data(NULL).
This leaves clk_data unreleased, causing a memory leak.

Fix this by calling platform_set_drvdata() during probe.

Fixes: 124294ff468f ("clk: mediatek: mt8192: Move apmixedsys clock driver to its own file")
Cc: stable@vger.kernel.org
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
 drivers/clk/mediatek/clk-mt8192-apmixedsys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mt8192-apmixedsys.c b/drivers/clk/mediatek/clk-mt8192-apmixedsys.c
index b0563a285bd6..e6ac40e2f12d 100644
--- a/drivers/clk/mediatek/clk-mt8192-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8192-apmixedsys.c
@@ -176,6 +176,8 @@ static int clk_mt8192_apmixed_probe(struct platform_device *pdev)
 	if (r)
 		goto unregister_gates;
 
+	platform_set_drvdata(pdev, clk_data);
+
 	return r;
 
 unregister_gates:
-- 
2.54.0

