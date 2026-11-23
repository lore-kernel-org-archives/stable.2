Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420353;
	b=lK0P1+PlFbfjFJfQ0rYLWJHFVmtRYzMzNagomkw3xOK63cSoPxSlkqwv7BXJOmu4Znma
	 qdz5ra4AFiNcam5up19v5DN5dLdyRhTTW20A8iD/OiNttgJVnHJdqUrvb6LzH3e7c3ZNO
	 /Muls8ZOtlQsIojUKfQRJVMHr22TfbMwscWp72twQfmwX1B+Q0kisSB3PZ4xqSYWUixMh
	 PSKEw8z4J3FmqtORCzxMP7JR81cYkLnLnrqQqqgVx03YwOV0lngdh303tSgsgkoJ8A1Si
	 /rC4Ioacb7NUEsk2ONru5EtvD8JOytwBiDzEVzMW+maG1EUV0tpPRrU4mLuhwwLtVdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420353;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JVswLX8KECFVMNl+lWiOH76IWuKZyq8o+lWmxaPSi7Q=;
	b=oOQ/iCQN87QmGvdeJmSWd9bOdYQz5iDQXr6FuSizTYDRmm8sXgE0KphJ0pJ5lg5gd3YW
	 28rnzSYnRK0saSei4juwwQN0dwT57ieSjtclfmMqiaEQPHcxkM7/D6YdeZ/N+P58uRD5K
	 eXakcgxZhehrAF3Y/C1u5DkRs/ZhDEYSnfwQYHG8+ZmGHbjerSNy8E+vALNCWUFL2mPvl
	 BkbddckwzJZyIM5cTc2EJatjT1l+aDLzbafveNU7QUPgRRgOPGtvQFYoAvsz0gYr6KyuG
	 ntl4kgeteNobFzrHvyRXTsJ5lqsdnhoHkw2grAODT6aHQpCubv+lJpzUMOQmlEIAqIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bWPHT2/D";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76612606A6AA;
	Mon, 23 Nov 2026 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bWPHT2/D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867251F000D0;
	Mon, 23 Nov 2026 07:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795420353;
	bh=JVswLX8KECFVMNl+lWiOH76IWuKZyq8o+lWmxaPSi7Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bWPHT2/D7y+b0FV1aPHKqFL0zvg2hTUszzW3wN2RVKtXEaBZTjBc12QXnBo8tHN8K
	 gc83Z9apRrDYd3ofKoQDOCQqmtA8qR4lB72CPKX5OSPvfel/VSfeL1zImfOR2HqcwW
	 QgCB764Rum3iQaQ1lZYnD0taNYMCTSdzAHbj1VcubWbYbNsGpzYKF+Z04ppw4PLsST
	 pMNJvnxkOCQOQ4/nEmvEpB5dhpN0fSo1iJZTufAZEqv/BRcgIDL+HkXkuOYGc4NIN8
	 r8TfttjblaNNKp/Tt/MiRqmwqUtmPtF+RjcbocK8P6OITn+5JOQGg9Hj0GhGw1JD2I
	 I0f/iNGQJpL4w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mathieu Othacehe <othacehe@gnu.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 7/7] iio: proximity: isl29501: Fix division by zero and overflow in isl29501_set_freq()
Date: Mon, 23 Nov 2026 07:50:33 +0000
Message-ID: <20261123075122.373060-8-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261123075122.373060-1-lee@kernel.org>
References: <20261123075122.373060-1-lee@kernel.org>
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

Validate that val and val2 are non-negative, compute freq using
HZ_PER_MHZ as an unsigned int within [1, 2222 * HZ_PER_MHZ], and return
-ERANGE otherwise.

Fixes: 1c28799257bc ("iio: light: isl29501: Add support for the ISL29501 ToF sensor.")
Closes: https://sashiko.dev/#/bug/linux-e4bc1c30-bbf1-458a-99f9-a36e949af67c
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2:
 - Order local variables in reverse Christmas tree style (Andy)
 - Group range checks by variable (Andy)
 - Use HZ_PER_MHZ from <linux/units.h> (Andy)

 drivers/iio/proximity/isl29501.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
index a98a9975323c..43be78b82e50 100644
--- a/drivers/iio/proximity/isl29501.c
+++ b/drivers/iio/proximity/isl29501.c
@@ -18,6 +18,7 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/triggered_buffer.h>
+#include <linux/units.h>
 
 /* Control, setting and status registers */
 #define ISL29501_DEVICE_ID			0x00
@@ -863,12 +864,18 @@ static int isl29501_set_calibbias(struct isl29501_private *isl29501,
 static int isl29501_set_freq(struct isl29501_private *isl29501,
 			     int val, int val2)
 {
-	int freq;
 	unsigned long long sample_time;
+	unsigned int freq;
+
+	if (val < 0 || val > 2222 || val2 < 0)
+		return -ERANGE;
 
 	/* sample_freq = 1 / (0.000450 * (sample_time + 1) * 10^-6) */
-	freq = val * 1000000 + val2 % 1000000;
-	sample_time = 2222ULL * 1000000ULL;
+	freq = val * HZ_PER_MHZ + val2 % HZ_PER_MHZ;
+	if (!freq || freq > 2222U * HZ_PER_MHZ)
+		return -ERANGE;
+
+	sample_time = 2222ULL * HZ_PER_MHZ;
 	do_div(sample_time, freq);
 
 	sample_time -= 1;
-- 
2.56.1.750.gf70dc682cf-goog

