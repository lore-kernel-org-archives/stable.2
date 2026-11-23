Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464060;
	b=pvgzvPpsCUBqGfeKWpR5hEDRmjQYBwaL3atN/0pbAU0hFdDIWk/9F6gI3heeF2T7eIQT
	 7479MH3q9aYK8+jNCkfqMuVgvcLGnp/wjtL4FdyctENzH76j420iVyV6LYfhkMEAXmlx8
	 K0RgSe9Mw+8aZ5tdj8GNkWwD6xppgwppopERwnMQJbPg8AnTGEJTH/Nq5t657scOpSvLN
	 soa9N/Wqtc0ynE2G0rS6/g6XoymLjcV6pZiudfYBkZI6PY4oEdRtVXlOIpHFDiDSkvgfL
	 tyIAs8L+jQTsTrsWtjt3+xDQXEatEkr0vJkRQsr0eVqx3KL7fUQFC1W3ZbfT3aoygFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464060;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=psLqdpDfEvsJKexanH3ZA0Pv43lOzKXaAeQKuctfq1A=;
	b=zZSUtI+LSzg2UmCzCdyqqZFlZ4jEW7DWiACZ+GvxRPwoU7GTEYjSAEj86GmsIykh8aPY
	 wJC4tdCDt/lgjw6DPvUwIZJuE2BZp5bcWEwzvNNQc7EXx0AZunDCnx9BDIqyBgPX0gIvo
	 iTQ5bsXiwDFJcaucAahtK0aXfwnxqhgFFaWDIx+HnFeY+NLIotn+OcJhgrd9BAtZrrVNR
	 cgYDIdgQBn4AYInaSoIoYWpafKz1lk2AweSirb4RScrDSvEr1ByZuoO0EqBqgwc2yyFCm
	 mgT5hojW2JQxLABY9NYBRjC0EUHN2WFplbjMyShoxTBBAecC7lGpJ6YpcVIyiHfi6lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iVsHfpO2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CA6606A327;
	Mon, 23 Nov 2026 20:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iVsHfpO2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFB91F000D3;
	Mon, 23 Nov 2026 20:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795464059;
	bh=psLqdpDfEvsJKexanH3ZA0Pv43lOzKXaAeQKuctfq1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iVsHfpO21gmyOU/8DAZ5+Zf/CBr+w7/SXpmmFNZMR/p+5o/gSu97rd+DTE1pshckk
	 TPDrhGWGL+Lj4zwyd/4e8JHRSLbOXISCI4S/r05fVrVjyJaVBVRyS+9//saKNotYlo
	 MHyDBanlosLCUYcvdYyO0hocl2uf5PA4ArfV0sQ9IKZ5u6WurirxBPrnS9vyUad45l
	 BFvG6wDvWxCu77Vav/+hrMgyZquDSEoehnc6OglwMBIgfQM2xkCwQ8GwhHKs7H+6oZ
	 YKRRAlWImj82vIQP7nONU2jKREI/ERUza0NQlD6+x1DIOFjusd2VNbxDDiuqHw0B1A
	 bx2o65G4iUbMQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Alexander Bigga <ab@mycable.de>,
	"Mark A. Greer" <mgreer@mvista.com>,
	Gary Bisson <gary.bisson@boundarydevices.com>,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 05/10] rtc: m41t80: use devm helpers for square-wave clock registration
Date: Mon, 23 Nov 2026 19:59:16 +0000
Message-ID: <20261123200012.502284-6-lee@kernel.org>
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

m41t80_sqw_register_clk() registers m41t80->sqw and its OF clock
provider using unmanaged clk_register() and of_clk_add_provider(), and
neither probe failure nor driver unbind unregisters them.  Because
m41t80->sqw is embedded inside the devm-allocated m41t80_data
structure, unbinding the device or failing devm_rtc_register_device()
frees m41t80_data while leaving the clock and OF provider registered,
causing a resource leak and a use-after-free when clock callbacks or
debugfs clk_summary access sqw_to_m41t80_data().

Use devm_clk_register() and devm_of_clk_add_hw_provider() tied to the
I2C client device so both the provider and clock are automatically
unregistered before m41t80_data is freed.

Fixes: 1373e77b4f10 ("rtc: m41t80: add clock provider support")
Closes: https://sashiko.dev/#/bug/linux-4d3dfb5c-0f65-4bb5-94e8-653bc0543df5
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/rtc/rtc-m41t80.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
index cfab27aaa518..5f8d6dcdeb5b 100644
--- a/drivers/rtc/rtc-m41t80.c
+++ b/drivers/rtc/rtc-m41t80.c
@@ -604,9 +604,10 @@ static struct clk *m41t80_sqw_register_clk(struct m41t80_data *m41t80)
 	of_property_read_string(node, "clock-output-names", &init.name);
 
 	/* register the clock */
-	clk = clk_register(&client->dev, &m41t80->sqw);
+	clk = devm_clk_register(&client->dev, &m41t80->sqw);
 	if (!IS_ERR(clk))
-		of_clk_add_provider(node, of_clk_src_simple_get, clk);
+		devm_of_clk_add_hw_provider(&client->dev, of_clk_hw_simple_get,
+					    &m41t80->sqw);
 
 	return clk;
 }
-- 
2.56.1.750.gf70dc682cf-goog

