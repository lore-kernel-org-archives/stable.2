Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121296;
	b=5Tjb8cACHQlNu241R/oOoCYq9mIMjIlTGvOStzMOVABwK/GK4I4H4z+X92ud3lHAC9H8
	 SBRzEFEcRFwBQPtXgDhTDKBh7QPr88BnzVelmb1TeNSAth69Xk3LQTSyBp6JGopHRk76P
	 ZFDCVzeRCWwNXhPt4TJfuIYVdFKhLjtCRgcpO3j+wm/Jyiz02bsBwEgVbuBDwit9malt+
	 Kg6T9IGXxrHyQctdyQXb5fqdXu3obJNDjM0qNk8k6KUYvcZsWoBWGeTouLQGM/vY5nCsR
	 CQHrd1zOWMYasT747RSvM43SndjI2bbsm8MtdPAqIbd/RYhu/FTvBXlMUF1sr1rM7jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121296;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wlYjz4H7PCBDiZQa8+1jdG4sriSVI/tDAKiU2tNjwaA=;
	b=4uFaH3AGRmrbslJjrh7RknDRQ2ydP7kApDwLoYbYB+T14nmYMuWDAOnD0CdUnNBTBwk6
	 YNh8DbYqLOHIstjU+aeJuevKKJHUDdiOEmaW40D8Hljy06YlSuhSdHAwMEOS93qpbCVIw
	 m6XwGtzgOhKvu2GETtX50RVYwfrHa9koJXRe3SUjM136uMyZ4vsL7eVygcvLAPhGhGuob
	 cLaBnxgpKjAm5w8QQ8nSfqxc1v2Ep2p4MHm3CYNZtiDd1Wdf07OODadAdTsHVDBFRxCyR
	 NvPNhtKXCONRwBOnEQmGpufVH//Ig0G5j979wmrrAMJ8YZJDyLOP7jNa7HcrZKTOQrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V4nEQinT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94778606CC7F;
	Thu, 19 Nov 2026 20:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V4nEQinT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E1A91F000C0;
	Thu, 19 Nov 2026 20:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121296;
	bh=wlYjz4H7PCBDiZQa8+1jdG4sriSVI/tDAKiU2tNjwaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V4nEQinTN3jJh5hGW7AZFmTrf/urY2z6q3EAakxo7y0sapSfJocohchQGbmkT8RYs
	 YycrpfvSwqBeWFJtWKnYY41PUuazCpXCNzgkd7+QlmtXobWyLcnUlqCMKjauUF1eEh
	 FYYwLQqOSFNv6jXSy/33mI+14EfbARiFfkW+l6XCiEfhOw1RwPiANBYmEXZrMk25Nn
	 3EJzXOJ4JjcPy5RBjBuIr26Ywh5I7e6KMOF57PRb4JPvT966ELmyOv6wvO3ssckNIy
	 uaCcCe2g5wzqdv8VqJ4kuQroVEFCp3hiMgaEPel7iHB5shw3ul0Rlhx/OIEPiZoCtG
	 QQBhWx/DJS6XA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Sean Wang <sean.wang@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sam Shih <sam.shih@mediatek.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Rob Herring <robh@kernel.org>,
	linux-mediatek@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 3/6] pinctrl: mediatek: mt7981: Add missing entries to mt7981_ant_sel_funcs
Date: Thu, 19 Nov 2026 20:47:18 +0000
Message-ID: <20261119204748.2558209-4-lee@kernel.org>
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

mt7981_ant_sel_pins[] defines 14 pins (pins 14..25, 34, and 35), all of
which select ANT_SEL at function mux mode 6, but mt7981_ant_sel_funcs[]
only contains 12 entries.  When mtk_pinmux_set_mux() iterates over
grp->grp.npins (14), it reads two int elements past the end of
mt7981_ant_sel_funcs[].

Add the two missing mode 6 entries to mt7981_ant_sel_funcs[] so its
length matches mt7981_ant_sel_pins[].

Fixes: 6c83b2d94fcc ("pinctrl: add mt7981 pinctrl driver")
Closes: https://sashiko.dev/#/bug/linux-6233f285-1487-4d2d-afe3-d4ce3c445054
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2: No changes

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
2.56.1.750.gf70dc682cf-goog

