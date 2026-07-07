Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD8E231827
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783410557; cv=none; b=cFO61FuBlOwMS7sMIc246XZA76kUNtgWin4+C/7MbXRK2602IOnLu/gSIQBmFsKS63KT8V/CO20BqvdrEkeR9na40uzvsimJ09v99IkmeOUlm7K1o7I0fqnaKidj3sHTv9N5j5nfiekkmQEnzcEh3JWmKH4BPXmqL6kvI0G2Jqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783410557; c=relaxed/simple;
	bh=Ll69jwTycTVdStJZVNDDkPg2Y7noF1LtSQhw0u/t8tY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eK2WA52zTHOnTUxsnlDBl2DJShexmNoARk8st8Map4FOPqP8dt8YBZJdymuIQtAOXB9oSLv8nThMp2Icajzv0wBeS9pOOJvyJTW6s0lUqV5xO2k7m3yOVVXZYORxkX3nB072zqU/6K36lCTjwsJDGTqvv73/ssodM10WVvngOFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NF81gmrE; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NF81gmrE"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37cab825ec9so3894970a91.1
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 00:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783410555; x=1784015355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=47qH9DhdGsXSvcnn2TMzn7MFl2kXpbMH9aBDXUUfcBo=;
        b=NF81gmrExriPwHcYQxKufEChkycKDwPfgnoPb4kOq76khlCZIbGRS750MmLLj+B15N
         1hxEEU7pN0gVLk5fIJ1xBTY1I1bqDgjKKX/vO79nHrVaE0nVhYJ7HfUYUOM6pQKseMmf
         0lXUIIEFZ7QKU5e7hvDW/wvBGGzMA2S/lHK/9EK8z9+7+WJQoVJL7RFhPmLM2vGw1P1Q
         14ErFbrZiBg3N+COpbjduLz20wtLX19w+hUSKGZll4kMYcObwyYezgtXeR4RpCydcS0Y
         sMBWEqR0qL5gbsI53NoODoXBGo4cQah0osjGYVCHqRaBW6ZraRJ81x1oeTDLse6Rr2wr
         +9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783410555; x=1784015355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=47qH9DhdGsXSvcnn2TMzn7MFl2kXpbMH9aBDXUUfcBo=;
        b=KkvtciMVBE6uadDdX0d04R3YPm8SbQIrE5ovPwvPsuItIpf/4Yt5F06GChxH2TK3JG
         PIBYQmHFjVKzUDvgQMbPxStH3mRyNK9c++AyippGc43nKiTY0uAkZ0CN08ermE9KKkrR
         z/Zg7Ek485AEUWMtJu45k54QdfRKnUaUMNAzA8Oa9vIEEWjqq+44RCvmIwjSZfrBKx0l
         3ECn6JVMSfOq9rT2O5aX4d73Ols4fIWgkXKg4lzyxn71VU0Nr14f+Q74k0YvHlCx5b1c
         JWzInZ9rXFTAhlmjI0S3x/feMK44JKlgaB4kLcPswpyjMZD/USpvYt0HrqPNnI3tfvh1
         DBxA==
X-Forwarded-Encrypted: i=1; AHgh+Rou5tlcHP+g1MdJeisMvpolzM7b/tzpU/rbmH5UgttoKWdexBik6u27CUkuUt/FRzPq5LOPgfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyywSnyQ1M/VxKc1gXrAVPA4YMcg5wu3k89QpXJ/k7N8MDf3KeG
	4F1cXdB/OdOP5pOl4hADHUsFrEPyGz9nrq7a23OlgCFfynRosbwoOoBF
X-Gm-Gg: AfdE7ck4kvZ4/oLQpcSW6zhUXjdoPPnblY8dd0Us7V4OmSGls2NmFPQGBVix6zwJtmk
	UIkeMA0wND1uCpCVvzhpWpjt25AD+8CnTmtpoOY738sgmCvbJAETcH4lCSQO5OJo75dJEQciMgX
	HQFHdFYFH0pcjralhcrY0SzVNtlXSkmnmisYA7AZ9s6cuROe54mI/W6qRGckeKJdiMjj4CV6L26
	DadrEb2q0CLTF8nsgMbmDOdBQQpNtddo/88L+YdJWEOR+08mx50SnDKQN4gE9Uc/lco/XO72E52
	Grq9uar6xtx+YrO4PoU9V6yhxpzADDu+aBktVF31TOeKmFpJqp5kdEH834olbyUJeD3RCTlupnx
	ftYj6u1DoNzzgorih0w3qwPpR7zfRCMbyXwLHuG0rmTDshBk7fbt4FRZ6yV3xLjy9dWacryfAwL
	p/MUYVs5plqje14HVR/wGLMiO59DpdINLkCjRXI6A52qIi
X-Received: by 2002:a17:90a:da86:b0:381:28e0:624d with SMTP id 98e67ed59e1d1-387597e83dcmr4179386a91.28.1783410555332;
        Tue, 07 Jul 2026 00:49:15 -0700 (PDT)
Received: from buffalo-ssd (M014013071096.v4.enabler.ne.jp. [14.13.71.96])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-387d20a361asm626710a91.15.2026.07.07.00.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 00:49:14 -0700 (PDT)
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
Subject: [PATCH v2 0/6] clk: mediatek: fix memory leak on module removal
Date: Tue,  7 Jul 2026 16:48:29 +0900
Message-ID: <20260707074839.240676-1-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some MediaTek clock drivers do not call platform_set_drvdata()
during probe,
but their remove callback calls platform_get_drvdata().
This results in platform_get_drvdata() returning NULL,
which leads to calling kfree(NULL) in mtk_free_clk_data(NULL).
This leaves clk_data unreleased, causing a memory leak.

Fix this by calling platform_set_drvdata() during probe.

Changes in v2:
- Add a newline between platform_set_drvdata() and return
  (suggested by Brian Masney)
- Split the patch per SoC, (also suggested by Brian Masney)
- Add "Cc: stable@vger.kernel.org"

Link to v1: https://lore.kernel.org/linux-mediatek/20260629142348.273766-1-akkun11.open@gmail.com/T/#u

Akari Tsuyukusa (6):
  clk: mediatek: mt2712: fix memory leak on module removal
  clk: mediatek: mt6795: fix memory leak on module removal
  clk: mediatek: mt7622: fix memory leak on module removal
  clk: mediatek: mt8135: fix memory leak on module removal
  clk: mediatek: mt8173: fix memory leak on module removal
  clk: mediatek: mt8192: fix memory leak on module removal

 drivers/clk/mediatek/clk-mt2712-apmixedsys.c | 2 ++
 drivers/clk/mediatek/clk-mt6795-apmixedsys.c | 2 ++
 drivers/clk/mediatek/clk-mt6795-infracfg.c   | 2 ++
 drivers/clk/mediatek/clk-mt6795-pericfg.c    | 2 ++
 drivers/clk/mediatek/clk-mt7622-apmixedsys.c | 2 ++
 drivers/clk/mediatek/clk-mt7622-infracfg.c   | 2 ++
 drivers/clk/mediatek/clk-mt8135-apmixedsys.c | 2 ++
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c | 2 ++
 drivers/clk/mediatek/clk-mt8173-infracfg.c   | 2 ++
 drivers/clk/mediatek/clk-mt8192-apmixedsys.c | 2 ++
 10 files changed, 20 insertions(+)

-- 
2.54.0

