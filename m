Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452539;
	b=3Su0a4nwedp2GvDhnTsc3dyrgTA7Ud47pvLP61Yo9gguC++30lZmpMj1PiYSiBU4h7Zf
	 wjKGs6WE1XY1EgwlBf0EBGEGaq5p2cESdpbk235j7vu8yEuA8kt/EBycFQy1Q5BHFD8tY
	 7eCu09rwY3qywbG59EyG43p0KDfwM02v5Y/qRF39fEO2iW4i+ZANXBm/5KxgpAuxOv+Ji
	 nTWEo/eyLMVH+WN8ur9z9rjAdW7KbPyBtNkSMYqNctzAtfoF1zMvHp6BoT0HsKxeYrhe4
	 4YIZepAcnQlj09gcOf5CwED6lZ+kEl72VnKo9Y+P40h6BdodwnP8tZ9ARGToHRT+vwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452539;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4Ip4SXJxDEMUBPY2/7TQsYLJ7OFQGOHcIrSFeGEgDdk=;
	b=Q+RpY3/u5ObNXaGnJSDnmg4q8N5YLlKVlTjVWNOu0zsYt5OMAe6OwACOHdSC2dtDbP7n
	 DInOjQ4gZGzsLYfTu5ppNufeOM3hdCB1jTpS/QxxivwCnXsuFrmhYc9HcKR0s1qIrwXsP
	 279T6jmM9NM458DEPNcih88nAEHzSMHwDjJ9pf+LCbPf6HwdnqzCaP8844XhGNtkd0b72
	 7hiqoS7p35b3YVUjcYogtzG4LE3VvFv1JMtg4fzlSl7jiVPMZlCRHIpZwhxjMjVWpO+Ir
	 3iLbwE8Dl0nDxdo831UTZo5op19oKvq49lGfCpunnht0SO0oguUR2UA+T5wy2thSgqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CTLE9AUS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC85606A68D;
	Mon, 23 Nov 2026 16:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CTLE9AUS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1CA1F01566;
	Mon, 23 Nov 2026 16:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795452539;
	bh=4Ip4SXJxDEMUBPY2/7TQsYLJ7OFQGOHcIrSFeGEgDdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CTLE9AUSs/LHxrvk6CIsJ9GACvA2PTye1NIAEWwymWadlQYhlkDpK4CM8KOSJ6Agt
	 6wjcP46gJQ0+yvdY3or0+cIifWEwihQ7Mzk2UAObiOskI9S2lw2We4TD5oLfRFF69/
	 DFDEPoIamcMx/7h3gHMQ33fvhJ/f361DuTmOPH+mCS4OGHUf1d5EYtQz2a+STglpkM
	 BMsbfN4ujTj1C9FggbxN/x4eviXo9Pn5Sb7Ayc0iRcVReznwsX/fmwo5gCkLRDOZM3
	 bMkSNgYilwegIe9cF0MmkjN5dvQRjPAlERA2DPDht/LqPg4XgCJoriJSdXoruUFT00
	 WM5TrmE62Qh8g==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Liam Beguin <lvb@xiphos.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 02/10] clk: lmk04832: Validate child reg index in lmk04832_probe()
Date: Mon, 23 Nov 2026 16:47:35 +0000
Message-ID: <20261123164834.3330320-3-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261123164834.3330320-1-lee@kernel.org>
References: <20261123164834.3330320-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

lmk04832_probe() allocates lmk->clkout with info->num_channels (14)
elements, then iterates over child Device Tree nodes and reads each
child's "reg" property into a signed integer without bounds validation.
It immediately indexes lmk->clkout[reg] to populate .format and .sysref,
causing a heap out-of-bounds write if "reg" is greater than or equal to
info->num_channels (or negative when interpreted as a signed int).

Read "reg" as u32 and reject values greater than or equal to
info->num_channels before indexing lmk->clkout.

Fixes: 3bc61cfd6f4a ("clk: add support for the lmk04832")
Closes: https://sashiko.dev/#/bug/linux-75db6ed8-b83a-4866-b3f7-d486d223d97f
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/clk-lmk04832.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-lmk04832.c b/drivers/clk/clk-lmk04832.c
index e6e771e8eb14..757b0eba739f 100644
--- a/drivers/clk/clk-lmk04832.c
+++ b/drivers/clk/clk-lmk04832.c
@@ -1453,7 +1453,7 @@ static int lmk04832_probe(struct spi_device *spi)
 				 &lmk->sysref_pulse_cnt);
 
 	for_each_child_of_node_scoped(lmk->dev->of_node, child) {
-		int reg;
+		u32 reg;
 
 		ret = of_property_read_u32(child, "reg", &reg);
 		if (ret) {
@@ -1462,12 +1462,18 @@ static int lmk04832_probe(struct spi_device *spi)
 			return ret;
 		}
 
+		if (reg >= info->num_channels) {
+			dev_err(lmk->dev, "invalid reg %u in child: %s\n",
+				reg, child->full_name);
+			return -EINVAL;
+		}
+
 		of_property_read_u32(child, "ti,clkout-fmt",
 				     &lmk->clkout[reg].format);
 
 		if (lmk->clkout[reg].format >= 0x0a && reg % 2 == 0
 		    && reg != 8 && reg != 10)
-			dev_err(lmk->dev, "invalid format for clkout%02d\n",
+			dev_err(lmk->dev, "invalid format for clkout%02u\n",
 				reg);
 
 		lmk->clkout[reg].sysref =
-- 
2.56.1.750.gf70dc682cf-goog

