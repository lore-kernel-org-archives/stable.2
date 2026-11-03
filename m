Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741439;
	b=cdN4kxsmnYhhDqra8n9/eFqHRURNb6zFW6qJ4h1QI83T/7OHfmZBM6ccr1ctWUfiUOmD
	 mvnrvPgYeMb9BaiIKL+Gv+plevo0qF44nPKhKxA9xa1BMpX/MPHO97mZR0e7nz+pkXc+x
	 cOlGodzAQsUPR1TPNpJXZkGAXZE78VxVMp2vJC1HwHgR0f18P5EqIGBFTuzS0QY0qTGHP
	 cmWbjLv8SQLNkbnOdbWPJyqw61UajZk6GzosvavUIJ9uM6vgYylBQoMX84mgDBCf7tfQZ
	 bf1hYl8jqpV9JFY0l5P6X4NICPP/jS6xDFg2x9CmBLZHbZwIdUsKuxGqxnZCj5sxKUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741439;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jz7Ae56TC7O0hDxxX+ampC/iunsONsLTXzxuwvv2ZZc=;
	b=GIVkC4z2Acf5h+H9zy+P5zyD0+RCDozpTeKlN4DvNIYMXLgP493WLXCs6qNIYlUgNE2n
	 4v7r/yZILOBHxlbglePXxaUDrsAiX3kf46scjJLErecp1RuUFqDdBpq0IgPiEKXKGaKiH
	 Avj1jb1LELZ4d3UwEkhzR9NBUCfCvnRW9PFjTFQRKHlTONToO+rqZaFnolkmBdtsQTFvc
	 0bJWwYCWOIQ3IWF5W3R7l4DaOAe/8RHHdCnCGjJwYktRqCONUQOIZqxliAz4TLhKFjok1
	 J6/U5pAwkJqIMcFewFWCAEBvaMrNRtpY5/r1/OkBISnTwrR+Tx7ZanY0di2hkJ8+vow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JxkmBzb6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428B5606A326;
	Tue,  3 Nov 2026 21:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JxkmBzb6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9EB1F0093A;
	Tue,  3 Nov 2026 21:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741438;
	bh=jz7Ae56TC7O0hDxxX+ampC/iunsONsLTXzxuwvv2ZZc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JxkmBzb6YZosy4vS1BthRew/1CFSfcQ+hhz3H9mg4GPRq2RMxeVIst4zwIq+RwoVO
	 S7gndZ38aDVeZKoIbR+TkGGE4Wv3Td2uE+AOIiCsBY/FWK+bCYeODYnMDRUDgbW6A4
	 hUpm73aGcy5y6WgtdoFrl53cFt8dRkXawdr64VXkM/WKuKWtWy40v6Ffa8WkBo0OMA
	 mSMjeoMejWOjor0ZFkl5qCRfGFaL79x2eb8YSGW0pJBwzGfY7dBLCleCO/Wf8dXjeI
	 /6n/h2Eoim4jIdXivTt6kPXjZQ4B/0g1whw+17bEU/a2tP2ef/9GQUJLPrnRHCZS7e
	 zxAkMt063jlHg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Sean Wang <sean.wang@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sam Shih <sam.shih@mediatek.com>,
	Rob Herring <robh@kernel.org>,
	Daniel Golle <daniel@makrotopia.org>,
	linux-mediatek@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH 04/10] pinctrl: mediatek: mt7981: Add missing entries to mt7981_ant_sel_funcs
Date: Tue,  3 Nov 2026 21:29:09 +0000
Message-ID: <20261103213002.1673560-5-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261103213002.1673560-1-lee@kernel.org>
References: <20261103213002.1673560-1-lee@kernel.org>
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

mt7981_ant_sel_pins[] defines 14 pins (pins 14..25, 34, and 35), all of
which select ANT_SEL at function mux mode 6, but mt7981_ant_sel_funcs[]
only contains 12 entries.  When mtk_pinmux_set_mux() iterates over
grp->num_pins (14), it reads two int elements past the end of
mt7981_ant_sel_funcs[].

Add the two missing mode 6 entries to mt7981_ant_sel_funcs[] so its
length matches mt7981_ant_sel_pins[].

Fixes: 6c83b2d94fcc ("pinctrl: add mt7981 pinctrl driver")
Closes: https://sashiko.dev/#/bug/linux-6233f285-1487-4d2d-afe3-d4ce3c445054
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/pinctrl/mediatek/pinctrl-mt7981.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt7981.c b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
index 2325cc8b9345..62fec909408b 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt7981.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt7981.c
@@ -800,7 +800,7 @@ static int mt7981_mt7531_int_funcs[] = { 1, };
 
 /* ANT_SEL */
 static int mt7981_ant_sel_pins[] = { 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 34, 35 };
-static int mt7981_ant_sel_funcs[] = { 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6 };
+static int mt7981_ant_sel_funcs[] = { 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6, 6 };
 
 static const struct group_desc mt7981_groups[] = {
 	/* @GPIO(0,1): WA_AICE(2) */
-- 
2.56.0.385.gac671c819a-goog

