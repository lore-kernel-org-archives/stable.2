Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363480;
	b=MaRucdTwYX9rU/zzlB/2J/z+Ch4pFOhAXSROqMX+SM8CIidtBGORx8UEJqocmvuoRojq
	 YYKi03F7/fMa2JVdlvbzKfEDKl0a8msJFQjqghErgFOEwCP/3s/eazx1j3f+/o3SXCKcT
	 KRn2p6qPkWEgzcYSPf3x+Z2zyCVxf6cBM8IwNc5QGgo8IjXdKYrvFezKP8eKCbUy8iJ+/
	 wS9TrPzSS0IG9AfKDLZimkDvBUB8wSlf1vaqk8l3hg7GKN+Y9c71ag3Dl1qEPwqdbE9C4
	 8H1je4cUwDY5Eci2QOOBdm9kkKfltmL+9je7UWI0alOr1VnElNZOj51SwVvHpjYeMvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363480;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/CpZgUNxLJdgVaBEy4xxU4BbnJnTlXyuCa06+xc/71k=;
	b=H7iJq+Li0aVo+s+oZPRfGPobJDiINbiM3i/hOUhh6N0Wb0WWVLrJrdBicW4w0m0nxWYn
	 kd30RNLqxtsV801DkdDy5vn9Mf9iwl+tC+mjbDhv2uY263UlIQY/qptSWSPe227yC1rFG
	 CyIR2TZJiOOToo+RJc6wvYFO3uiQQMthQCnfZ8/Gy4vV+nz5yPtLcNBCjT7U89yGT7Q5A
	 679a38KWKIkU3gVij9j3NMFGwNFHMDQY8UZCkhFc5OC91GogD02T4ZM4eEjKRkxE8ntXD
	 qF9NVXwK4ToUESd8mwSJ6Bi5k/QHMZgM9yBn5UXTyrHv1A2MnHCHIgjokeDpsWwubjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MwwD6fVa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA08606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MwwD6fVa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36C61F0089F;
	Wed, 11 Nov 2026 02:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794363480;
	bh=/CpZgUNxLJdgVaBEy4xxU4BbnJnTlXyuCa06+xc/71k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MwwD6fVabQBiQHPvOZUpT/MpisUlL2AxYFgOSUJow7l9vbWPhiMKYmH6pwZwZkcic
	 Uw+oX0xNjpiIsezsnne9SP8LEGIklAwwMhK211JSKfDmKa9mJst4EFqmVB9mWkdLcp
	 1WF2MWTCKKtKpnnEftWklo1xa2HPIAmyq+QruV6h1YGppJ4lUTUOcfgZeHED4uVWyF
	 WoUwC04oP/x86SjIRgH8GqVxYL+NCOXRrqRo4a5tcUYcgk3/wU+yM/6C6+tK+MC0RT
	 Czgx4OTufX4uHVPsyeQlXr5TXh9/QDCxm+ZhCBbVWhjQkC/YItA5YE6+xCeHWBXrZr
	 Yq0fhc8q7Sd1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] tpm: tpm2_probe: propagate transport errors
Date: Tue, 10 Nov 2026 21:17:58 -0500
Message-ID: <20261111021614.616044-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053821-failed-6.6-7d4f1cbfe063@kernel.org>
References: <20261107053821-failed-6.6-7d4f1cbfe063@kernel.org>
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
[ sashal: Replaced the early return with rc = 0 to preserve cleanup of the stack-allocated buffer. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm2-cmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 57bb3e34b770f..d01d90beab788 100644
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

