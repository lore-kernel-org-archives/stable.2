Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434113;
	b=3v/9d9tWnOhQ2L2whBXJxZIobFkcNkuQ6ha5K79V8P6jE+edd5D1lxX5Gr53y9itEPsl
	 HLyjqLz7Go3OSoqrZj90aXzjmy4HkUXK+ZEK7Kwbu9fN6udM5w7gDJJiFOb1XMyBwYWmX
	 fbbGt5d1lWrPcASKc3+EtPQwLrQ/XZealpHc5lQn6N8Efit3VbZ37zt/nG+SiODTC9RSj
	 doYHdFm3o+/iE3T5AKmKJZrakZOm90cFkq+C2gp/arwEPok0EqA8Q2KcvwOeIlk6/FTR8
	 Xf5VfTLJHcxx1BcA3U6XxR+sq7CqyUKiEgpTl8FjIdK5ZOFyK/l1c1NCERaNNCWHGCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434113;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=J3h7yhT76OoVl+YPlyQUkEfkSBobXxiSaZcngFPs/zs=;
	b=I/d7EYqKW1PvX35uD/Sk04j6Cbk9tFoR6VUxmXyclTDGAIzmcYVyfWqEelmeYGxyaXId
	 jiTd0LfVG3Vycx0Q6Ucfk4g+IcSg4ELbs3lrI5elrD54Yh8CMv7UySGJo1m+sq9hb4ksm
	 MBYmm/5pt/Z3amqo1N0ocfEHHCfhErYTGa3vMXgqqrbt2jBX0FdI+jd/Jt0HaOKAUanXA
	 x4pwwpq3E73XXak7I8t24rjB21GcbqIAsopRPtIGkHQILuOlemlbNr01QrhXXevpCyiw3
	 m9MWBhKZr5dKkdeiVrRYvBq0NSXdRXsuEkA0OivqJWcW5OFS+5V2zz0gjFyShWZuaLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dm+bsZy/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281BA60A6F4E;
	Wed, 11 Nov 2026 21:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dm+bsZy/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B785B1F00A09;
	Wed, 11 Nov 2026 21:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434113;
	bh=J3h7yhT76OoVl+YPlyQUkEfkSBobXxiSaZcngFPs/zs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dm+bsZy/KS+m3BxYZBwy/U9U1lnunO8RqkVnZo6T42XuBVpM/VhiG4LMKiPK00Hih
	 kFHmNNLnAidGu9rwgA5xPaIoLZV7fekzSDUZIVQO1115i4lvCJ3iRq+w7MasqQQp84
	 t8iKZWWU/ZGnSnPONOEGcZ5j2wJxjKQbwFMCSYP3vOeRE8S8JzcyiOAPOP/Xr0Jwgw
	 OD9gQzx/3b3PWsVdzSnm45JzwGXZC8t1KexM6boOjI4Pi38n8OH/onyj6PJynZ/eUH
	 0giCAmJs8Bl+9+3pbsj9F0Dt8ORttz6PSiLwxvIqr0A8Mi31vDs+syawPzto3bDhmV
	 Sk+vtDmnGq6Sg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Akinobu Mita <akinobu.mita@gmail.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 10/10] dmaengine: dmatest: Avoid unsigned underflow in min_odd()
Date: Wed, 11 Nov 2026 21:52:48 +0000
Message-ID: <20261111215349.1983909-11-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261111215349.1983909-1-lee@kernel.org>
References: <20261111215349.1983909-1-lee@kernel.org>
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
2.56.0.567.gdb80ae8cd5-goog

