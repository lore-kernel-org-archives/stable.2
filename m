Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452603;
	b=LoFlfoElwjUEvNjTt3WIKmNS4v7UTsKBmwkhC6OaFCNm24ActXDqYz/86Cy10Hrlmyr7
	 aQWYGer227pMTyZY7103ib+zhGpHg/ixKiJ4I9bsmnA49gTvuniAUvw2a7eqcAnEPxPTw
	 /Qf1pTSGtiIPF0EGVCXnTTNOKyKYtmrFOZsSyeb/df4W/bGT0oOA+ixoshzOAuQjG8Ek7
	 vOwFr7Xxdkddjz+y1rM6M+FDQ74lzncF35nnjXTtrWgnJtVpkby2Zh5TJxhCB3KXgOvEp
	 pF8olMXpncB0h+t/aA/iRNzoVnU0Y89vtGrMyXn+bcGnbY/p+u4IUOB9o8LC6OtjrOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452603;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=j2EuaIxk4oysf6OviyRPJrkK5hc9SHiGg82we225gU8=;
	b=QKRnp2kIG52YMSZn781/jZ8KCSEX9vDcVcIdd1EiZAEoAaqdgZ/5wcC8oel3dKGOhBVK
	 g1icT06XGEBYLMRoeIuyKM9c7JKGI+IDH9AB+x88h0KM+kfjpvzH7EzMHhaUjKxnK/W/l
	 jl7OwqhOiFRXOtoYM8rfcE1uj/+yBHc8njkQ+8Qzb4WIT+fk4zVgXIHcb1/4fLY3j5GsV
	 KsJNUV8QSwaY9PJdRUEjoq2Y+GxCuUmDK1ZqhOIJpqE1VoeZxkCHtLvMnwCkTSxvaRaYa
	 2COaqKJIHfJuc5zdoAwWiJ9okMaw/8tq4aLPiToWZlQxfi2JBpWxPVAauJe4AqcBEHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EqRdB0Ww;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59F7606A336;
	Mon, 23 Nov 2026 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EqRdB0Ww
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD0B1F000C0;
	Mon, 23 Nov 2026 16:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795452603;
	bh=j2EuaIxk4oysf6OviyRPJrkK5hc9SHiGg82we225gU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EqRdB0WwNM7TrYVHS+B0zOzXCJp1yXvy7gn3VxXIiEIrfoKWHvouJgRTMb+SI/UEB
	 ZBoNW5xSP+8LpNqenhFvQkQSsU28EZKRqA4hbZTFjQSL3UsV0P/mVv0s37v2ey73Oq
	 LXbAr7teh69H3hZ58BD1TgQ3f8eOOQQiywIGQVeLsLuQpD/5/nOqxV2b5r+Okk29pl
	 CXA+azaCyUKX8OMzUiMT2yat0pLArk6LRAzdkwRVgytqQO3TD9AeHiNp2At1Y79Eju
	 qkAKNGxsoza5eSJMSmr574uolEfqJAcK2o8GNKsVnCvAT81Te8L8JJCMBk7OXJoe9Y
	 5c7Uu+6AwMI4A==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Lubomir Rintel <lkundrak@v3.sk>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 10/10] clk: mmp: audio: Use devm_of_clk_add_hw_provider() to prevent UAF
Date: Mon, 23 Nov 2026 16:47:43 +0000
Message-ID: <20261123164834.3330320-11-lee@kernel.org>
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

mmp2_audio_clk_probe() allocates priv via devres and registers all
clocks with devm_clk_hw_register(), but register_clocks() registers the
OF clock provider using the unmanaged of_clk_add_hw_provider() while
mmp2_audio_clk_remove() never deletes the provider.  Unbinding the
driver frees priv while leaving a dangling clk_data pointer on the
global OF clock provider list.

Use devm_of_clk_add_hw_provider() so the provider is automatically
removed on teardown before the clocks and private data are freed.

Fixes: 725262d29139 ("clk: mmp2: Add audio clock controller driver")
Closes: https://sashiko.dev/#/bug/linux-c4f4539f-43f7-43ff-938f-01a855925960
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/mmp/clk-audio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mmp/clk-audio.c b/drivers/clk/mmp/clk-audio.c
index 19233684fbf9..9ef5cca1e1f3 100644
--- a/drivers/clk/mmp/clk-audio.c
+++ b/drivers/clk/mmp/clk-audio.c
@@ -342,8 +342,8 @@ static int register_clocks(struct mmp2_audio_clk *priv, struct device *dev)
 	priv->clk_data.hws[MMP2_CLK_AUDIO_SSPA1] = &priv->sspa1_gate.hw;
 	priv->clk_data.num = CLK_AUDIO_NR_CLKS;
 
-	return of_clk_add_hw_provider(dev->of_node, of_clk_hw_onecell_get,
-				      &priv->clk_data);
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					   &priv->clk_data);
 }
 
 static int mmp2_audio_clk_probe(struct platform_device *pdev)
-- 
2.56.1.750.gf70dc682cf-goog

