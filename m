Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794933575;
	b=wu/HxTVdDNBm2GLFq6Qupyw3MUUzUlEvrLn/aBP1s1NEy/7xbyvmsw9X6Vn3yTDygwwO
	 SmCICowwE4DtjMRSh8mZZXDmPr3hmdmHxT7y23MDFiaKIjevmXO+cYK0ILG0PVAMQIaIO
	 r1+Fjm/t0kRziqKEoIlgWkgU2P75RR1UARsj7zRytdeiLZncGTGwuAaioByihVyD51Th+
	 /AdosVLuO94Wr0jNRNbEs5ZZW+XbVrdrGFx4J3HdSsPL+O1ffWlBY5AJtYXZy+0hgeOzI
	 xjbhvlfET4HOIKIQFS+GP8l8C8BtvNO+H4vid72/FOOHg0Q39WV41WB/bpvzEI6ieWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794933575;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vLoVgA+veJqTpjMFRVugYtaxfUxaYoc9q6xhl97RMvU=;
	b=e9HcYZWuAtIHw195sJpnOrf/ZugDf5GyOXBepGZEOYJe6GGCWwJxGfib7Ed914Byu1ox
	 XUU2DOXuN0drBj04fkEw2AuhM0sX4JAUSc5lqoZyaTNev5c8uu5dmR08EegXw82Y7jUMm
	 RPjxsEStTD/aqmPh+wl+zcAxbSJPOT39RIIr5LIUW87CJcYKsaqqtUMdfovgpt45fkGBD
	 S9AWpODhxvMZ+ZQQvfMX/zkno4BX1VPqWvlR+dXX64ul4rcq18uh/0LhpdWOxBK+4zqhQ
	 kIQOP2B1O+NLBQT4ynwgHln6248AAX8aRnU9wE3zfozhXwrXYLGBCUz+BrkjqSaYZHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j6zCXuLX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FAE606A31C;
	Tue, 17 Nov 2026 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j6zCXuLX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76E31F000C7;
	Tue, 17 Nov 2026 16:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794933575;
	bh=vLoVgA+veJqTpjMFRVugYtaxfUxaYoc9q6xhl97RMvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j6zCXuLXskRg2UAfyCmySlRFsTiic2B2JM1s4vxoROJuyOTUNQiehpisUMjkagay4
	 pP1neCOoR1yuAuW3ZiHyxpYMFxFyUsUt+dG3R6k7FngPJdNY+9IgCn93qqmGKLj1ia
	 RS65UhonXKGcXJB1C12vLIFVBl0YEtUcEZz/fvNOHnA1TJ1kJV/7kMxmGrnvLelWpi
	 bVEGqveRYRVvsWOFBYcMSonH/stuG6GK5llJ0ahZoQW73Ci8iQ8peIcVphIMkSCZ5b
	 t61+jNibC73rhNSt3JZs40kkukOwDuq6cCfwJPqf6VcgCfZ0nkMa7S3/Fvm5LfWDHY
	 +rpKlkki/4k9Q==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 11/11] dmaengine: dmatest: Avoid unsigned underflow in min_odd()
Date: Tue, 17 Nov 2026 16:37:12 +0000
Message-ID: <20261117163809.622249-12-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.679.gc527c65306-goog
In-Reply-To: <20261117163809.622249-1-lee@kernel.org>
References: <20261117163809.622249-1-lee@kernel.org>
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

When either argument to min_odd() is zero (for example when a DMA device
reports max_xor or max_pq as 0), val evaluates to 0 and val - 1
underflows to UINT_MAX.  In dmatest_func(), this sets src->cnt to
UINT_MAX, which wraps around the (src->cnt + dst->cnt) >= 255 check and
causes dmatest_alloc_test_data() to pass 0 to kcalloc() and dereference
ZERO_SIZE_PTR.

Return 0 from min_odd() when the minimum value is 0, and abort
dmatest_func() if src->cnt is 0.

Fixes: 8be9e32b310c ("dmatest: adjust invalid module parameters for number of source buffers")
Closes: https://sashiko.dev/#/bug/linux-ca967586-4fc1-47a3-8616-4a9d21fe7455
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2: No changes

 drivers/dma/dmatest.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 2ae3469397f3..5f768bb9a29f 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -457,6 +457,9 @@ static unsigned int min_odd(unsigned int x, unsigned int y)
 {
 	unsigned int val = min(x, y);
 
+	if (!val)
+		return 0;
+
 	return val % 2 ? val : val - 1;
 }
 
@@ -650,6 +653,9 @@ static int dmatest_func(void *data)
 	} else
 		goto err_thread_type;
 
+	if (!src->cnt)
+		goto err_free_coefs;
+
 	/* Check if buffer count fits into map count variable (u8) */
 	if ((src->cnt + dst->cnt) >= 255) {
 		pr_err("too many buffers (%d of 255 supported)\n",
-- 
2.56.0.679.gc527c65306-goog

