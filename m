Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452597;
	b=34ZR6XCsNz+b4NqcvVAWXfy6Xk7gBOVaw1yQ9ebg9McDiOROPFYfNh4HP4pA9a0kCqI8
	 9lyW3etfYutDVmi+4sN/WALkw1mNU4Fe7r03Mh1tqVZ3wcHNwX239lUkK2WudnpxyghHq
	 vwbdNEjwuHZf355U1bsidtvZ06NHkcLyqPBPQq41Zv5CycwVJ07KSQxicrBgwMQpTFGSl
	 Cd8f1qEz0e0fHORgkLuLx4QOX/3gJa2sTaFNw2JDAETWR8D4KGfqbhZ0d4Ur0J/mPiyd1
	 rStMVgKwYjTRE21St8YcKUAXZc+xmbou1cpW8/RnzhSo0Mxj5zvZVmKwC7SQZeWGdRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452597;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Yiuz3nKQQdprhCmGaRKEJvFMwJkVpQ19Oh5cjxYdZdk=;
	b=HgaQ1mukiKkhvaNnmvTc7yCv+zNv1fuon+XfmquFkmeHmqXMRPr3+XdweQ6JIdVkQYMw
	 wosUL7DxZrJ8JQro+bPxHOKOCK0rK30GbDOodxc//BYmAF23tFJHOcBik3k/lrwCZ5lqT
	 SA6o1Lqq5DUee+iItpqHDDSYQnUhYfkCEtyA7nrcATIrvqiLFldJKNEKXgtVI3K4Zi1oo
	 NIVMRdePofFt7//lvZo73qeE44Ve4L8vNa9Sjf/nJXIn9Dyg1LmC/Ci81WEtwuJgeMFI6
	 NAzqRGVxGOtB8ra23vOJxBDMc8ja7Bo61N0/VhwRyaRlkqz1wkc6gLdKWQmt1YQL4kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G8sfh2he;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D81606A690;
	Mon, 23 Nov 2026 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G8sfh2he
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE851F000C4;
	Mon, 23 Nov 2026 16:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795452596;
	bh=Yiuz3nKQQdprhCmGaRKEJvFMwJkVpQ19Oh5cjxYdZdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G8sfh2heXpRab2+he9tSVnFh9I06GNblCEf6EBKsV9FcDMGdtJ29lhk3sOXfXkt1e
	 W59LSgMXqTFxbkHtIH9sU2qJSeZuNm4DCy//c6bTAZFJHrWNli+gLRpxrXNlTA7zDN
	 lI7eyb61VpVUwhEmX8uEKcUbDtmkjebVqTb/4+GZWqvu4wlAEafyGxRAiFe/ktGWyP
	 YkUa6px22h4n2FAKKmcUuNTyzy59GBXMNhwgtZ5pRl1mm027v6Y0gsNYkeH0lgMGa/
	 6mRAJzbWfDRVtkV4IgqEc78HDMRwqFAuK8PrGkTU0NOHQHQ8IHpwCjjKIgSV4GMUSU
	 9YKDGEEeQHIHw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Michael Turquette <mturquette@linaro.org>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 09/10] clk: cdce925: Use devm_of_clk_add_hw_provider() to avoid UAF on unbind
Date: Mon, 23 Nov 2026 16:47:42 +0000
Message-ID: <20261123164834.3330320-10-lee@kernel.org>
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

cdce925_probe() allocates its clk_cdce925_chip state and registers its
clocks using devres, but registers its OF clock provider with the
unmanaged of_clk_add_hw_provider() and provides no remove callback.
When the I2C device is unbound or the module is unloaded, data is freed
while the provider remains on the global OF clock provider list, causing
of_clk_cdce925_get() to dereference freed memory on subsequent lookups.

Register the provider with devm_of_clk_add_hw_provider() so it is
automatically removed before the clocks and driver state are released.

Fixes: 19fbbbbcd3a3 ("Add TI CDCE925 I2C controlled clock synthesizer driver")
Closes: https://sashiko.dev/#/bug/linux-30a4148f-b048-49b1-a21a-4665f03e4cf8
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/clk-cdce925.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-cdce925.c b/drivers/clk/clk-cdce925.c
index 52d350f91496..6dfba3158d8e 100644
--- a/drivers/clk/clk-cdce925.c
+++ b/drivers/clk/clk-cdce925.c
@@ -795,8 +795,8 @@ static int cdce925_probe(struct i2c_client *client)
 	}
 
 	/* Register the output clocks */
-	err = of_clk_add_hw_provider(client->dev.of_node, of_clk_cdce925_get,
-				  data);
+	err = devm_of_clk_add_hw_provider(&client->dev, of_clk_cdce925_get,
+					  data);
 	if (err)
 		dev_err(&client->dev, "unable to add OF clock provider\n");
 
-- 
2.56.1.750.gf70dc682cf-goog

