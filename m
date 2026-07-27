Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BD641379B;
	Mon, 27 Jul 2026 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785158364; cv=none; b=smYkNOnASZ0NKGCfAEq2O/mlHQ3vEeEnvbX3T/aGsgEtOo9rUi0NoTU2EMkrth9abEVozWPI+jJhPH5BlGqpvzMJQRE0t2uUqBWyHyrV/lXXmKDofMPVs3jSYb5TUoLa8878l1ZhP8gFBTMRP0+Yag88FVRadK2rb2VNwgiu1sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785158364; c=relaxed/simple;
	bh=DtSRpaDqclNo6U2QeRpHGIfjJQ060yIsBqj5BnAVUds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMYcyhvnyd1MFItdADd9VoCcefVXvXmTIwl4EahaCIAsA0cjs5QIgL6bGl1UTDBHql5swjfMwhGmJKak67i0tKYbfZ3lLUZEUs7wM+UiNiN9+5vsK4w11cgC2Tv250mmllmH9sMQ+eDneBDM3vqUZKE2IKGImwKWPrqhUqwuXRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=fmyG7pFH; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=qBIHIgae; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="fmyG7pFH";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="qBIHIgae"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158356; bh=DtSRpaDqclNo6U2QeRpHGIfjJQ060yIsBqj5BnAVUds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fmyG7pFHhNWwUTYe7XPIy9OnZkMCbCq9s7K16WknqRK9Lqk4H/EMtbEtvKQI775gV
	 U63H+zMFC0f0xWe2eQNuugFDeueRJzET9ahS2wXZ9yqmnHmM7FViG3wcZ6HdmzLpCK
	 p2vjkrtGaROYZl4JrFbqLNnFx+2goH5TFrEb9QLQZ5f8dy3x2DDr/kS0tgL18fTbEh
	 B0ID1Sb5Zx3NDDfF9p5hd2Tp4ZHYz70rX2R8D2EuBFsno9/9542YC87dQwRylqQJJp
	 UgEpnj6WYYGENWGOGtIAP3Kg07F/GtcV4IfnG7qdTMfGHJIsFJ0sJI9hOIIKrQd6bd
	 fcN6GMxziPuuA==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id D7F9D42558; Mon, 27 Jul 2026 14:19:16 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785158355; bh=DtSRpaDqclNo6U2QeRpHGIfjJQ060yIsBqj5BnAVUds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qBIHIgae7zOcEVNnXq+W0qj9ogxm0UhiOT/B8rHpD2aWDLrfRdT6XfCR66JQTF3vA
	 RhCJ//EP9h4EwKx+hqBZxznaQ4MpHJhYZdwQJujAalOhWsTuumK6z7PJCsKV2JRZFv
	 8nA3tkJnUxdnS8W7e7M3xKhpaNGADMFrAmy+R+edVy7/ICsHFiHi9+GV4gl1M/8ewq
	 mUBd6cs1OSgxCvO/KWYudA7iJHt7FguPijdBm/zKra8HEKHfhdBAldCoGJKdIW6Akq
	 AbTI9TYp47km2Mjx2O4MbSFUvQE5UFtWe8R/iqMK+2GtwzhPC3fEzMpjctWJuDTbSH
	 6lvA84poWDqow==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 71AED4253E;
	Mon, 27 Jul 2026 14:19:15 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Cc: stable@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 07/15] media: meson-ir-tx: Ensure clock is disabled on unbind
Date: Mon, 27 Jul 2026 14:18:50 +0100
Message-ID: <ea91c3a9dcfbc146f676e2cc3b5f769b2ab8c088.1785158244.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785158244.git.sean@mess.org>
References: <cover.1785158244.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clk_prepare_enable() needs a call to clk_disable_unprepare() on
driver unbind. Make it devm managed.

Fixes: 49be1c78d575 ("media: rc: introduce Meson IR TX driver")
Signed-off-by: Sean Young <sean@mess.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/meson-ir-tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/meson-ir-tx.c b/drivers/media/rc/meson-ir-tx.c
index fded2c256f2a..e7bb107e6a84 100644
--- a/drivers/media/rc/meson-ir-tx.c
+++ b/drivers/media/rc/meson-ir-tx.c
@@ -288,8 +288,8 @@ static int meson_irtx_mod_clock_probe(struct meson_irtx *ir,
 	if (!np)
 		return -ENODEV;
 
-	clock = devm_clk_get(ir->dev, "xtal");
-	if (IS_ERR(clock) || clk_prepare_enable(clock))
+	clock = devm_clk_get_enabled(ir->dev, "xtal");
+	if (IS_ERR(clock))
 		return -ENODEV;
 
 	*clk_nr = IRB_MOD_XTAL3_CLK;
-- 
2.55.0

