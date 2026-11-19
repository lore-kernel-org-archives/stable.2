Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795102400;
	b=mZsCCpYu3/4+uOBGoviwhdiGtM/tKNdrYIEWZj7zpBob6fUpJrvsUCkj27mb5Q9iByBJ
	 tvO9kHk2Z7XNwXgy3FsjDbsyJTAojdpqD/oH21X6iXjsFJ4AuxWCm+VxR4qUDBN6BDOKH
	 Lojjdq2OBVwrBHlFY7dEEH2s5YdPQQ1x/RIeyeMnpPUR4vN48pBtiqO//Eq7XQb/aJ7uS
	 6uZaO0OCKRXNvtQect+sGwekXtzAWZChcNfgRirnFNQxKoYHCRF9S6btWqgzNmPCIkR8j
	 naK8i+J7SUZamsi9v0RuHO3Vca3XL4EOEMF6OSY+pPaLpJ1hoHYQd+NU+3TWNHnn4FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102400;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+BiVMK/leC6+pU7QrtKzOxxWWFu9b9fSyKelLy8O9So=;
	b=zNH9gibMBtSG8OY1yJ6N/vqF1gKsjIF2oaDga82yvdE8PLsYjl2H42DLk2DQqJSHWmPv
	 bbuk3C6EYbkUL4IiLpz6iFmpYUdhSKvIXmBWrcjMpDmJf9wNfjew17W2L+NeGGfDI0dGW
	 TF4wjsowUVNnZ5Ul2YMbWaJ8p+pMczlEvR7/USUgyUHYK+oibt0KrPbd/vEEtkYPk+SAC
	 0LPJIfOibMMncbCyWI935nBLGH7sfdP2FlVy9wDL0bpgQsG6IChsa+yoDaowqCIBB5P2D
	 3kV+fFqk0Xnx6xbK7G1utu+A+6C3rPAVmnZOrTbwIg1asG0S1A0d1MTe1iefkYsIhxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KcytfhsQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14C6606A33E;
	Thu, 19 Nov 2026 15:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KcytfhsQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01DC71F000C4;
	Thu, 19 Nov 2026 15:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795102399;
	bh=+BiVMK/leC6+pU7QrtKzOxxWWFu9b9fSyKelLy8O9So=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KcytfhsQ0bXsko9UprrpyhM/ly9bBuDMnFLuqXT72O5z93TWx2ONTOkkc/G9Vj8hs
	 hN6vZP0g6KJLJy5xvtmQciEz5Gu7+i/38s8WnQnWqcRf8t9L2aTlzKwH20rLHzAhtE
	 mlIa0PkyV+o97dCDKCUNZjh4AzsqHk0ORkPpYO13rkzu/EQKCC7LvfNcyc4WbdrTEp
	 18n9riwbgk5i12U8r+rrshZxhGOMbL5bHrgL6w5Hfw3GTgo7UpDoxmXYeko56kFL69
	 2SrHcEJ2uHmqLwrNR1YhUZl/Qrdj4LkTMBwfxTeWa3HRM7r7pmJ6deJZ7UTbQ+d5FZ
	 dWueLK98tKxvA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mathieu Othacehe <othacehe@gnu.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 09/10] iio: proximity: isl29501: Fix division by zero and overflow in isl29501_set_freq()
Date: Thu, 19 Nov 2026 15:30:42 +0000
Message-ID: <20261119153151.1397003-10-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
In-Reply-To: <20261119153151.1397003-1-lee@kernel.org>
References: <20261119153151.1397003-1-lee@kernel.org>
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

isl29501_set_freq() computes freq = val * 1000000 + val2 % 1000000 in a
signed 32-bit int and passes it directly to do_div() without checking
for zero or negative inputs.  Writing 0 to the sampling_frequency
attribute triggers a division by zero in the kernel, while valid
frequencies above 2147 Hz up to the sensor's 2222 Hz limit overflow
signed int.

Validate that val and val2 are non-negative, compute freq as an unsigned
int within [1, 2222000000], and return -ERANGE otherwise.

Fixes: 1c28799257bc ("iio: light: isl29501: Add support for the ISL29501 ToF sensor.")
Closes: https://sashiko.dev/#/bug/linux-e4bc1c30-bbf1-458a-99f9-a36e949af67c
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/iio/proximity/isl29501.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
index b337ee530972..09575d890104 100644
--- a/drivers/iio/proximity/isl29501.c
+++ b/drivers/iio/proximity/isl29501.c
@@ -863,11 +863,17 @@ static int isl29501_set_calibbias(struct isl29501_private *isl29501,
 static int isl29501_set_freq(struct isl29501_private *isl29501,
 			     int val, int val2)
 {
-	int freq;
+	unsigned int freq;
 	unsigned long long sample_time;
 
+	if (val < 0 || val2 < 0 || val > 2222)
+		return -ERANGE;
+
 	/* sample_freq = 1 / (0.000450 * (sample_time + 1) * 10^-6) */
-	freq = val * 1000000 + val2 % 1000000;
+	freq = val * 1000000U + val2 % 1000000U;
+	if (!freq || freq > 2222000000U)
+		return -ERANGE;
+
 	sample_time = 2222ULL * 1000000ULL;
 	do_div(sample_time, freq);
 
-- 
2.56.1.708.g77570a6a1d-goog

