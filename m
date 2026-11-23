Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795458768;
	b=BOaYf2iM1vY86yWyp2P/LM2TtcsBZj0TB/t6U9kaShZfbDUooYhNmKcxcFgjl6c4kGya
	 rmcqBkzRZ5Nro91xHf0DjWb0RYugA9DqbYT/qbrgmAoKsqBtUwCk2UI5YV6gnw0mXCc7R
	 deDm8ACdQAsdHdXIXwbQYkww4td6PyisRLgfcf2KZnqZTQQE1TZ7Z109uwIdgoWVwlsZm
	 j14HeMMkhiUo1smD1HUST3Kjp5V70nGiHWS13zoy5937TU9NZJw34bP605LEpwhddOdm/
	 XIZWgzJleU25rqX+3MyEtxqg2XgmRmY99RM6nEb+cXBGPLq4JQByMyonvRjPFOQGHeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795458768;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3ncvdCiD+I++psXwF99QZqk8+VbB3yg3sCWIKX61dB4=;
	b=ZwXrwbwqpfsVSiXHUZRtHH68VgFiOVSGdZ6HCMJ52kLidSDWUlGH5dXzaqVsoyOc6jKy
	 heK3/4j00yRVMqFPaZfnKTX3+gmZ7y2u3OwUm8T6O4ZtFiq2TMOOrHHxawavYLSUoNF00
	 liPwiqnqbsByIshxJTxz3twsvIPISvssaUlClewTiqcEaF/DUoV3sbQXidr/eBy4FRTQ7
	 R4xcYU036FtDTmqd6/CTereUg9vavuH5r+5x30il/n07UnoS6IE7YixYqKByzB39Wtt8U
	 z91BB7gUlX/ZX6L2FghWS4HkmDUx/0sTcz5GfRjSKvUCfDmM4KZ+SU8BzKp/3PMrnAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrbHt3Yg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45068606A32A;
	Mon, 23 Nov 2026 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JrbHt3Yg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B821F000CA;
	Mon, 23 Nov 2026 18:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795458768;
	bh=3ncvdCiD+I++psXwF99QZqk8+VbB3yg3sCWIKX61dB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JrbHt3YgkiFXdHbQbhoUtMmRC3ygFVXXkJa6hGAzLYU0bE25BLp3vA98Y5ou5yOGg
	 oW1Cp3uS0YpSO6Lae6X25eKn91VmG0RbiXaArp/1yFltT8USqqBQyfEpGxfV4EqbM+
	 cqPq8SepfOYcseRSo1bThZp1m6cp32gqFqX7zYbjiqhkaTWxHAglK92O42D2xHNQM7
	 RVQofOX6Jmwd1crBs1yaC9bDsMS2wjmItgvXYDBgqTgwRuD81CFVlwZoJdjY7DFh+Z
	 VrduTueN7J1KCxaUakkbzRkF1y9GhxC9F4gzcPb8JM3g4z1wCqTwjPB/ipxM4M2Pv2
	 xRsunEgQIZuYw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Andrew Duggan <aduggan@synaptics.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 06/10] Input: synaptics-rmi4 - check for NULL drvdata in rmi_set_attn_data()
Date: Mon, 23 Nov 2026 18:31:12 +0000
Message-ID: <20261123183200.3900004-7-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123183200.3900004-1-lee@kernel.org>
References: <20261123183200.3900004-1-lee@kernel.org>
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

Transport drivers such as hid-rmi remain registered and continue
delivering attention reports via rmi_set_attn_data() even if the
physical RMI driver failed to probe rmi_dev or was unbound via sysfs.

When rmi_dev is unbound, dev_get_drvdata(&rmi_dev->dev) returns NULL and
rmi_set_attn_data() dereferences drvdata->enabled in interrupt context.

Check that drvdata is non-NULL before accessing drvdata->enabled,
matching rmi_process_interrupt_requests(), rmi_driver_suspend(), and
rmi_driver_resume().

Fixes: b908d3cd812a ("Input: synaptics-rmi4 - allow to add attention data")
Closes: https://sashiko.dev/#/bug/linux-0165ea80-0dcb-4d48-96cf-e2c1532199a0
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/input/rmi4/rmi_driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 7bbe9e801c35..5053c1edad6f 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -172,7 +172,7 @@ void rmi_set_attn_data(struct rmi_device *rmi_dev, unsigned long irq_status,
 	struct rmi4_attn_data attn_data;
 	void *fifo_data;
 
-	if (!drvdata->enabled)
+	if (!drvdata || !drvdata->enabled)
 		return;
 
 	fifo_data = kmemdup(data, size, GFP_ATOMIC);
-- 
2.56.1.750.gf70dc682cf-goog

