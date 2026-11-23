Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464068;
	b=LdjJT5IhCJuRYAJMX3XjHGY69c7sdfL1yqQwsnsXvMLArkaiaD7R5LaxKC6gCRJtXqQd
	 kCgZ+JJKQEdeRvUuRiGOZLcbexdt+nZ0OTtyAUM/5YD0CQylmSt2OVJrVjOL3RqtUqd/6
	 zRVl5G39nzLTDcyUw3L0ntqbndO9HonUXifV2yzLLphQA1wmtY3QgaZt2g+8AlghZrRSn
	 fUGxp7ge6wvEbKm5FDNSIpK4TLQdrtxB5Ap75tAvaB5tnSqwKltNYjnRV4859qG5mBfag
	 6e0sYbuzKb2q3Be+jYCKm8/jqut+N907zS/zMeG5u3iTb+XfAoyWZXPiBjOQmper1BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464068;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=VBddtnZ6NplTqsAQrt2rNvqi2go0i1Jy9vkkQ/D7OwQ=;
	b=tvCXqbTjxszV3zUfiQW9EeQHud8wqtiO854Q0pMs72airPY/T31T2FCSSnt5+W6HpWOD
	 4vbHmDhJR8+tYh00npMTRpY3PrBT327liZrLmkAHmCq8BXfTbLaV3de9+k0yYr38TwLb0
	 Wlv5DW4WFLeuMF4GolyGkxC+edBdrfsLWWQe9oya7+hbMA8bbGb6e9JP8PUPcpqMe+i6s
	 DROKaaXpoqaY7HzTAC541O5rHPaQmE4Uee4Y1/+OPulfZUfgEPARaymQZ7Fhqdz4cSdJ7
	 SvqesaBYNeQjFs3sYCajJjC34Ex/0rkrrEMcGQKmlH0JfYD4uUkVzbv6KGhqxufwH9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U0QeouhH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C54F606A32A;
	Mon, 23 Nov 2026 20:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U0QeouhH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 195DA1F000D0;
	Mon, 23 Nov 2026 20:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795464067;
	bh=VBddtnZ6NplTqsAQrt2rNvqi2go0i1Jy9vkkQ/D7OwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U0QeouhHPw6RwqtmUwFLMFeLJszFZAzpXoM0K1PKvgU2FytdyhDUmGfioCGmuZ7Jd
	 rP43eGqmPibJoPx8wBQnbJUziI2HqSo85sp2w6Hv5fgYjPaTaUyvFIgUYFr1Gu9FKU
	 lMsGeqlY79mU/9SYKQ99BLwiSNFbMSRgR6ULOceXqlIESEerF+IcnzpMUysm7ERWW2
	 9eObdajXWPL2kb+zuI5e30bZf6VKAf3v6QHakfncsCqWwgPw7ca4E4+y2YFJrcqHat
	 vYiUSwaFat6d2EJzV+sS7TCZRBnND4t1+YJ3vfDoYXdrjgNIqKN7GIoQf4ukzosxei
	 nOMxEeOPfWzRw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Eric Liu <liuer@nvidia.com>,
	Medad CChien <ctcchien@nuvoton.com>,
	Mia Lin <mimi05633@gmail.com>,
	openbmc@lists.ozlabs.org,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 06/10] rtc: nct3018y: fix clock provider use-after-free and leak on unbind
Date: Mon, 23 Nov 2026 19:59:17 +0000
Message-ID: <20261123200012.502284-7-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123200012.502284-1-lee@kernel.org>
References: <20261123200012.502284-1-lee@kernel.org>
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

nct3018y_clkout_register_clk() registers the CLKOUT clock via
devm_clk_register() but adds the OF clock provider with unmanaged
of_clk_add_provider() and never removes it.  When the driver unbinds or
devm_rtc_register_device() fails, devres unregisters and frees struct
clk and nct3018y state while leaving a dangling pointer on the global
of_clk_providers list, leaking the provider entry and OF node reference
and causing a use-after-free on subsequent clock lookups.

Use devm_of_clk_add_hw_provider() so the OF clock provider is removed
automatically before the clock and driver state are released.

Fixes: 5adbaed16cc6 ("rtc: Add NCT3018Y real time clock driver")
Closes: https://sashiko.dev/#/bug/linux-9509654b-12c7-4bd1-b189-f52692af9457
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/rtc/rtc-nct3018y.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-nct3018y.c b/drivers/rtc/rtc-nct3018y.c
index c770450e48b4..8349ddd1a9d6 100644
--- a/drivers/rtc/rtc-nct3018y.c
+++ b/drivers/rtc/rtc-nct3018y.c
@@ -479,7 +479,8 @@ static struct clk *nct3018y_clkout_register_clk(struct nct3018y *nct3018y)
 	clk = devm_clk_register(&client->dev, &nct3018y->clkout_hw);
 
 	if (!IS_ERR(clk))
-		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		devm_of_clk_add_hw_provider(&client->dev, of_clk_hw_simple_get,
+					    &nct3018y->clkout_hw);
 
 	return clk;
 }
-- 
2.56.1.750.gf70dc682cf-goog

