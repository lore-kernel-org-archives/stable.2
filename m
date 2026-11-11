Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363774;
	b=fa4E0jbB8g+1OUsqiukHvJdTQpbsRiTbZnJgpjOF6LKrLO1pQygxAXGepEL79XG9tDCa
	 0xrwKExSEtJClaFjCdFkbHSP7u+rPb3c69Jcs555IhtIUv3ncNwroHUR1UhzvBf4HEIj3
	 PR8bKFglnEFYRSMIQN2xN3Lq/y8yoSxBDLGwCpuyAd9rdHtxunHZNUb0qvHzE2woNYTtW
	 GAd1yMc8AGX56vVuW9W9Ww/Vp5HZ07KZcicykw6q9aJdaqavE+Gpuo0vKd1aPwImUYAw1
	 ChHuyl1Bqad5jpOzi8w+V33MQTDPtUxE0mIrljrdfm1vu7ZNlI+iY0Ir22ThkyOvlfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363774;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3GVMrPOV8lY4HaUeelYdTzbUEQ8kYAqhyYDD9cEAV4o=;
	b=V/uuO/yAuQ0bOVItfqzAakkuI5h2exCV8JvovHA5YaP9rMfkOTff5FiNRhnjY4+L6MAR
	 JFGqWTZNjV5rcJ2NrCZzu6rj6mj+40qTS5rgOasUjaCPOgpWqKqy1EnJQWpgby24dwxx6
	 0MGlOp+FNloFe6UtNNk3l8vTFEdyT7RQ3+d5TFXFmvgQQ0Exc5dOsv02yeQLwvuS6rT0b
	 p5fhmy8FJY6K+lC/BBpk9kCcLrsXmt1IEsPwyTKbW9BvRJfoNqw3naKIHZ0lEb1dH14/W
	 u9LjmxJK8XP2PKRiDUjvCdRrPhUEC8vpf6FZcXjhjHuYU4lCwZz++hp5PH5bdVK5jYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aazMZ2pm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CB6606A32E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aazMZ2pm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64E91F00A06;
	Wed, 11 Nov 2026 02:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794363774;
	bh=3GVMrPOV8lY4HaUeelYdTzbUEQ8kYAqhyYDD9cEAV4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aazMZ2pmMzPQ9bhjwldHCrrja/jRB5IG42dABDwtiP8HsqygQRTApVdvfLl2xVKub
	 humV6jBuKOuHC7XwzszeMv5UrZkab7vL0aOxC80pGJO+nCk3gyT6+TaWuXcZdSMbfI
	 hTDvOYQ9+IwNuNezKRETHFWqcMLEqmJr86hPS1YwIdBAuXoXneevWr/ERPRDXzQajA
	 c88sS5HLHrCmX7ZnCUqJH7hkdJMYLd8GDpcYJzVkrYjkuggmIq1SkJdBVfwk3gOkml
	 02FqoX7GInWIxCPnXoeZjD7Y4KetGGJGgVoilAynC/MdE8rlRu741h0AAoJynQFLEA
	 AYyovEtUfV4yw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] tpm: tpm2_probe: propagate transport errors
Date: Tue, 10 Nov 2026 21:22:52 -0500
Message-ID: <20261111022124.676385-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055340-failed-6.1-7d4f1cbfe063@kernel.org>
References: <20261107055340-failed-6.1-7d4f1cbfe063@kernel.org>
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

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

[ Upstream commit 7d4f1cbfe063af5581dac66abe9e9c965e1031cc ]

tpm2_probe() reads the protocol version from the response tag and is
documented to return -errno on failure, but it always returns 0.  A
transport error (tpm_transmit_cmd() < 0) is thus swallowed together with
the intentionally ignored TPM response code, leaving TPM_CHIP_FLAG_TPM2
unset. A transient bus failure on the first command then misdetects a
TPM 2.0 as a 1.2 and the probe fails on the TPM 1.2 path:

  tpm_tis_i2c 0-002e: 1.2 TPM (device-id 0x1C, rev-id 22)
  tpm tpm0: A TPM error (-62) occurred attempting to determine the timeouts

Return the transport error instead; rc >= 0 still means a valid header was
received and the TPM's own response code is still ignored.

Fixes: 94e266ba1fa3 ("tpm: migrate tpm2_probe() to use struct tpm_buf")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/r/20261001060114.1582092-1-alexander.sverdlin@siemens.com
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
[ sashal: replaced the early return with rc = 0 to preserve tpm_buf_destroy() cleanup ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm2-cmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index ac8246153c242..1485224b98af5 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -507,9 +507,10 @@ int tpm2_probe(struct tpm_chip *chip)
 		out = (struct tpm_header *)buf.data;
 		if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
 			chip->flags |= TPM_CHIP_FLAG_TPM2;
+		rc = 0;
 	}
 	tpm_buf_destroy(&buf);
-	return 0;
+	return rc;
 }
 EXPORT_SYMBOL_GPL(tpm2_probe);
 
-- 
2.53.0

