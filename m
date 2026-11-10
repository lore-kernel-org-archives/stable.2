Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794321155;
	b=IvKBBhmer5FeVFRAeVovhyKIsL/IeFH3I/cy02tE7uuhb5wl4hHDP/C/6xCBDvh6e0q/
	 8RnZmsakGz4wvcA2YBiTQEi3OKETSa3aemOxRCOlgtCm0752taNKpaEjjGSmeG4RqWsMF
	 TR5XaxnkQdJQ5QUsoIMqGq3ybhwermFraey8cgZptHO4rKovkTUEqjzbnDmuL9dNnZ1oJ
	 ubnrJ6qEZu1qQ+RifWFLMQFpt3owo61Urr/xY9inFqQFi4AAGeqjdnOIpLYRRt30nUn5d
	 fMM4qM0wwLnE1BHY58nIUa2ac1AORAMGfhwh9KIMYCMhzIKzk0d8TJ9cLluANYnisiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794321155;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-HM-Tid:
	 X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=aYnbcdyjjmhfhHw9RgqFVwWZO6AUzV0OwufGiz0A55M=;
	b=XMA0Fkj6GaVn1lst+xI5sGxQdGFlsFAyyk7WfjAbt3Beicdhzkn9ha8jjvC66Txq6HmF
	 Y4xgF5SfMV1+Veza5UXBclHOt/fyO1NKkr7J8w8VgK+GaTQYtSW7051XjQzqhbRWJGD09
	 jEYnHGFdcHfum7VT+JdTAIU2c358LFAsREkjqyhmPPVbHq8iRAdP+Evxf9NeGMxMX8u1A
	 Ns5huqFGTB+1Ht0UcaW0WNro3EEFp9oRzMe7yDYUTMfm/xVcQT1DI38CK4PcwbXv7Sks7
	 3ZxvZXGAzXT/M//6czETZpQceyUHT3H2/pcTBxBaEsv1+8QQM1xj78sKr+hi+CNpeuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b="cwbdCh/h";
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28F6606A321;
	Tue, 10 Nov 2026 14:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A28F6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=cwbdCh/h
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 542cd9c47;
	Tue, 10 Nov 2026 22:32:28 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] rtc: hym8563: Fix potential stale clock after device removal
Date: Tue, 10 Nov 2026 22:32:28 +0800
Message-ID: <20261110-9f141e6bc8-rtc-hym8563@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
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
X-HM-Tid: 0aa1c5dfebde03a1kunm5d7c3b6f16cddf
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCTk0YVk5PHRhJGEhKSRkeSFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	NMVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=cwbdCh/h8PteV1W6oM6DTFzRi59RfGZs8CHFjJusvB4NTI80lbHQJNVZhszH/QI8Jd2Eo4ThEvUxqlRhi70dy6Q9fRhJp2z/hU90YH2lAixPRSAU617QoOFQxWilqX5Q+mDJ4KuQU7VY/7XGOwFYjA8zqGf29sjCdvXwOY/DxJY=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=aYnbcdyjjmhfhHw9RgqFVwWZO6AUzV0OwufGiz0A55M=;
	h=date:mime-version:subject:message-id:from;

The CLKOUT clock and its provider are registered without a matching
unregister operation. Removal or a later probe failure releases the
HYM8563 private data containing the clock hardware while the clock is
still registered.

Manage both registrations with the device so the provider is removed
before the clock, and both are removed before their backing storage.

This issue was found by our static analysis tool under development.

Fixes: dcaf03849352 ("rtc: add hym8563 rtc-driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
 drivers/rtc/rtc-hym8563.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-hym8563.c b/drivers/rtc/rtc-hym8563.c
index e3d7ca477e75..8a4ba4e6fcb4 100644
--- a/drivers/rtc/rtc-hym8563.c
+++ b/drivers/rtc/rtc-hym8563.c
@@ -396,10 +396,11 @@ static struct clk *hym8563_clkout_register_clk(struct hym8563 *hym8563)
 	of_property_read_string(node, "clock-output-names", &init.name);
 
 	/* register the clock */
-	clk = clk_register(&client->dev, &hym8563->clkout_hw);
+	clk = devm_clk_register(&client->dev, &hym8563->clkout_hw);
 
 	if (!IS_ERR(clk))
-		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		devm_of_clk_add_hw_provider(&client->dev, of_clk_hw_simple_get,
+					    &hym8563->clkout_hw);
 
 	return clk;
 }

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
