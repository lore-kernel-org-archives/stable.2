Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121317;
	b=jo82gK4EhxFJvtQhlYIM8WPv/cc9Gi0Gv1efBvLey1WHneHn59ILaUUGUCsjN/Iem6qG
	 VmZLt5s6DICTDWsITK1PS6LWazql5k+sj/E2Woe7oWtmE7JFRKmMVWYg8BdanNWiZPOQ0
	 z3TmEn+YQiN4nTYhFKmRZjoCHES7Gcs6x0FD5RUi2WB/mez2hKGVj9RD+69/JVJVUGJ3h
	 uFjlkhlDeOVciCWmc0fLxixDgBZogwCHmolrz6Gdmfq2Hc71YXQCZEoljLmpJZ5SccWL/
	 4qyaE5RozAQ7fR+cTt5yh7jTNPjI078ZLBzODkSqXvzeV4W6q296w8bvxD6qhjfAf+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121317;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HzCI/OC/wj0bvnUWN/Wm9v2nEQ4J42ID8/rtjwSGIro=;
	b=0J9uBAaw4mZegpPXH4nhP6xJJHFpvj9WCg1chwjADl97uNMGq+8mIEccuUDX3Q5E11de
	 7cFyEnG65gLNyf6w3ZqgOF57HmI5LO20ZVC74wucqfHvI2UxYrrudpQ4UZxHaHohHYQ5s
	 i+EFSWY5BOAGZhEjgi6dySMaq7i0pbMaMC9gFxyf0GAdYPnXbZci82R3BR3MSctp4aHsM
	 oKEGJMysF6MDGBBC2xAsGR8oO8tT6f9cQ0I31wc0GV089QBWzuqjY9ODzLOvNdNkxIE5J
	 JkTU4lvFObJNnRH2CNwEhptBTV1aVNERooyKbaqf9vpeuoqAp5Rw4YWnBgqHP5TcGhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nZm63OKl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE49606D6C4;
	Thu, 19 Nov 2026 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nZm63OKl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486951F000D2;
	Thu, 19 Nov 2026 20:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121317;
	bh=HzCI/OC/wj0bvnUWN/Wm9v2nEQ4J42ID8/rtjwSGIro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nZm63OKl0ATBt4ksUjXeM7b59QCzmgtjwsvRMyaLIELZpwv7wRC91DyAzy4u9hmnY
	 6ZdcREdyWGgCV7UAYOEyCC4/87guhOUYT30P+X8o7tXufj/g9ELAWs8PvvD9gyfzTH
	 bhn2SvpLk/MFeCcxeW6jJsKWYsDxYoNVFjAZQ9Wa4BRg4tf7qFIxKeJ5Rl3YK/nXgu
	 Jfc9gXo7JWGq3owhPv2MMH8mYtycD29OuNn5y3OJMtQzUDcWo8zThRPe82WqhEZ+bB
	 /6hLiXgzTZ0mSDMdqdR+toz1dEDxV7qLCJmZ+w+qeuGit6JGDdobHKvmnUOBx1/wvA
	 Q+8TY6rOQ0Lzg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Sean Wang <sean.wang@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Ryder.Lee" <ryder.lee@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 6/6] pinctrl: mediatek: Prevent divide-by-zero for pins with fixed drive strength
Date: Thu, 19 Nov 2026 20:47:21 +0000
Message-ID: <20261119204748.2558209-7-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261119204748.2558209-1-lee@kernel.org>
References: <20261119204748.2558209-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mtk_drive[] only defines entries for DRV_GRP0 (1) through DRV_GRP4 (5),
leaving mtk_drive[DRV_FIXED] (0) zero-initialised with min = 0, max = 0,
step = 0, and scal = 0.  If mtk_pinconf_drive_set() or
mtk_pinconf_drive_set_rev1() is called with arg = 0 on a pin with
drv_n == DRV_FIXED, the range check (0 >= 0 && 0 <= 0) succeeds and
!(arg % tb->step) divides by zero.  Similarly, mtk_pinconf_drive_get()
and mtk_pinconf_drive_get_rev1() divide by tb->scal (0) if the pin has
drive register fields defined.

Return -ENOTSUPP immediately when desc->drv_n == DRV_FIXED.

Fixes: c28321979ba8 ("pinctrl: mediatek: add driving strength related support to pinctrl-mtk-common-v2.c")
Closes: https://sashiko.dev/#/bug/linux-d3852d37-6806-4c41-a493-f249dd59d0c6
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2: No changes

 drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
index 95d0455f7d53..d0c2292a1bbf 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
@@ -1040,6 +1040,9 @@ int mtk_pinconf_drive_set(struct mtk_pinctrl *hw,
 	const struct mtk_drive_desc *tb;
 	int err = -ENOTSUPP;
 
+	if (desc->drv_n == DRV_FIXED)
+		return -ENOTSUPP;
+
 	tb = &mtk_drive[desc->drv_n];
 	/* 4mA when (e8, e4) = (0, 0)
 	 * 8mA when (e8, e4) = (0, 1)
@@ -1069,6 +1072,9 @@ int mtk_pinconf_drive_get(struct mtk_pinctrl *hw,
 	const struct mtk_drive_desc *tb;
 	int err, val1, val2;
 
+	if (desc->drv_n == DRV_FIXED)
+		return -ENOTSUPP;
+
 	tb = &mtk_drive[desc->drv_n];
 
 	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_E4, &val1);
@@ -1095,6 +1101,9 @@ int mtk_pinconf_drive_set_rev1(struct mtk_pinctrl *hw,
 	const struct mtk_drive_desc *tb;
 	int err = -ENOTSUPP;
 
+	if (desc->drv_n == DRV_FIXED)
+		return -ENOTSUPP;
+
 	tb = &mtk_drive[desc->drv_n];
 
 	if ((arg >= tb->min && arg <= tb->max) && !(arg % tb->step)) {
@@ -1116,6 +1125,9 @@ int mtk_pinconf_drive_get_rev1(struct mtk_pinctrl *hw,
 	const struct mtk_drive_desc *tb;
 	int err, val1;
 
+	if (desc->drv_n == DRV_FIXED)
+		return -ENOTSUPP;
+
 	tb = &mtk_drive[desc->drv_n];
 
 	err = mtk_hw_get_value(hw, desc, PINCTRL_PIN_REG_DRV, &val1);
-- 
2.56.1.750.gf70dc682cf-goog

