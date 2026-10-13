Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C874367F2F
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 15:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791904730; cv=none; b=F1iqTkIj+LuPp432UOohwVqBAyoCAJn5Kbymr/idd8w/BYw9i/j9HpAHH20CILxnhUoQkiK27bfgbIF5j+gt/UbScNeEZ3csKdVNMIVtZSr+aQv5Pio12g0LUgwJ2TLhLOpszGI2J7yyYPbpNKrZ+EXI3mgaPDZjm0EVN27TyJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791904730; c=relaxed/simple;
	bh=AMCODax57KqUMy5UTX/GawCV8PmBS5pugefjN97Hi2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p9HckplPSH3+hLTRJ0K5LFgpRL1KD6wMn+xMyV2KaafGgWqNzW7PGvOtJQ3x+/CgGHrRGOubpc4PJOY2QiMza0ViJDqJmsxguzVi7DrRFs4TzvAxuTOrX4KHd2zB35SjhsYECQ+pyVroNdfKv6+A9gNscERvds14XhdFtfBYixI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W757CHfA; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W757CHfA"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc1c9879395so1064214a12.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 08:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791904729; x=1792509529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FrpJ3R8Qy/E0WIUg4/pXUKmtopn00SRG/AnQSF67mz4=;
        b=W757CHfAlBFqZamzOwiW/GwwVGauALoJ1eX2fw0nKysVtWL0FFg2BFA0oPKPra1wkb
         49zY88OLy8KejN/gazko/cRZ91E8OVzkbq3EG9CK5QcNNtd1bLWpEsQtpCe/VGm4MXmO
         6sKp5bQrhuLhXwSflVN7/Fd12loPNJHxP81waWBJXfSK7s8AB5qctmPlKphB3CWbKr+d
         ZkVX7YnD8MRKNKQmiTZribsOtwbhmCQer+VmP6ef46a8iXSGO69+m06Zm9tY0b4kXidH
         jGJxBkhdtVFm+++9TRt10xBX1i7vBkuG6XLIWClJ6cboG/2da+Ei2aJt4i5Jmkz2PkAl
         xWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791904729; x=1792509529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FrpJ3R8Qy/E0WIUg4/pXUKmtopn00SRG/AnQSF67mz4=;
        b=vSzzSQV4BjY4GVsd7sBT+qx3kyw/Qt5UuBV8+wZpPcvYy72SSgURhz2tfIuctOn0pc
         pbsoHzGsYloVGubg+LyMetQr55llRqNgFn6hfAkJAOqw3CtH5qq5Q2A8UAjiFDQlwa0g
         vi1yuiFaXNTq7XZ++yws3hqTRXKhXyjQtMiO8gM5qDABVl2uFGO9NRqXlWQZOZMxGXQ6
         PRewesZoEjZC0HWU50Y1UwR4At0rkoilBNs5jJu8bBWQXaXBZd9twwF1q6xY3YF5Y/tp
         VqQiASjYZ1aKuA/LNNiRx1V8Jw2JjrtrL3YFocWq649T4jB/yMEsXikddXj0tJnD/AaE
         KiNQ==
X-Forwarded-Encrypted: i=1; AKwUvBzhEtXOCjGiYraQIepHRfX7DKq+IGWLcLbedYbS+guSaWxpr8jXz7D15oiz6ad/V9cUnEiV3SY=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7uIdt8hCS+2IzqaYYZhYis1hSucTGf5b0WhEzIwwtF+wh6Ogd
	fCWOyzdEXP8ydc2zIAA8X24mjiDB851luI7EWc26jth00kt3+qksk0Mc
X-Gm-Gg: AYBFou0SKgbFh7mnZ9NbzmdjMny9fnXuj8i7CPbmxJk8kqar4UROgGSQvh4M4Bk5QCn
	FoSK+nI1hkYELZeJJpcgQ612dluVC6Lu9q8hmNuQNXF2AKTyxqR7sTUSqr92PFFXZQzhwcpYwbO
	SCp2adXcV+IaOlbBRWz9i1OkMOIcqadyAAmsS24vkBJM05YepL3l7RUtFM/Hq8leZFXapMxLF4x
	QAJn1fxQECAALtdb1DoXmkUQuVbFoIKSpE6/0Nm2JiRmWdGGOqmz2de+x7Wjg3vBbAFsqr63uKG
	9eKYyVPxghu0apd8OFxI65yQN6IN+lev04vY9buWjrr6m0fhntGNkGcl9ajm1+HRKA8GSRDkGeI
	/2Gln6tiYUR/H2sSyJTpfeWwApSYGHV4MGjaQxBbxbxaOvngUU5R+bkjnrJid+iKjDPX2x4T3e9
	jeL4v7z7bad6YhGQ4O+lm9fQgeWgnjueDUIeaXTt/HMRZXQvwYpyc2XaQAJfHfvLvV7dSzKRcJH
	hkRjnFBopc/K+qA3Hr0vZ3F76cx
X-Received: by 2002:a17:90a:5184:b0:3ac:17c:6e82 with SMTP id 98e67ed59e1d1-3ac15d46137mr2707843a91.45.1791904728712;
        Tue, 13 Oct 2026 08:18:48 -0700 (PDT)
Received: from buffalo-ssd.taila54753.ts.net ([240b:253:4760:f400:1ebf:ceff:fe7f:5e0b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3da04596dsm5759888a12.29.2026.10.13.08.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 08:18:48 -0700 (PDT)
From: Akari Tsuyukusa <akkun11.open@gmail.com>
To: Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Yassine Oudjana <y.oudjana@protonmail.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Haotian Zhang <vulab@iscas.ac.cn>,
	Miles Chen <miles.chen@mediatek.com>,
	Sam Shih <sam.shih@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Chun-Jie Chen <chun-jie.chen@mediatek.com>,
	Laura Nao <laura.nao@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	linux-clk@vger.kernel.org (open list:COMMON CLK FRAMEWORK),
	linux-kernel@vger.kernel.org (open list),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC support),
	Akari Tsuyukusa <akkun11.open@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 09/35] clk: mediatek: Fix index in composite clock unwind path
Date: Wed, 14 Oct 2026 00:17:08 +0900
Message-ID: <20261013151734.3177690-10-akkun11.open@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261013151734.3177690-1-akkun11.open@gmail.com>
References: <20261013151734.3177690-1-akkun11.open@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When mtk_clk_register_composites() fails to register a clock, it
unwinds previously processed entries. The unwind guard incorrectly
checks clk_data->hws[mcs->id], which refers to the first descriptor,
instead of the current descriptor.

This can cause the unwind to skip entries that need unregistering
or pass an invalid pointer to mtk_clk_unregister_composite().

Check clk_data->hws[mc->id] instead.

Fixes: 3c3ba2ab0226 ("clk: mediatek: mtk: Implement error handling in register APIs")
Assisted-by: LLM
Cc: stable@vger.kernel.org
Signed-off-by: Akari Tsuyukusa <akkun11.open@gmail.com>
---
Newly introduced in v2.
---
 drivers/clk/mediatek/clk-mtk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
index 3dfdd3a422f8..0b10a4b14a6e 100644
--- a/drivers/clk/mediatek/clk-mtk.c
+++ b/drivers/clk/mediatek/clk-mtk.c
@@ -363,7 +363,7 @@ int mtk_clk_register_composites(struct device *dev,
 	while (--i >= 0) {
 		const struct mtk_composite *mc = &mcs[i];
 
-		if (IS_ERR_OR_NULL(clk_data->hws[mcs->id]))
+		if (IS_ERR_OR_NULL(clk_data->hws[mc->id]))
 			continue;
 
 		mtk_clk_unregister_composite(clk_data->hws[mc->id]);
-- 
2.56.0

