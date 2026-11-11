Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363179;
	b=N1WXabVxuYdXwXC//Fa7BlGZssecnp4Z9o1CuLAdXWPf/s3axWQZpniPQww+1pFjfaB7
	 HUzSDRXhT2gHLCmkpOSzVq175EU1nvuN0iUog04qW6vtTuBJXjkk1TYa0jHprwjnsv852
	 FyVKKcC01o1tHGTbsTsIAOkZWlezMaLohhyZE4X0VHxrWe6SBglzoZmxxusKK7SZ41OtU
	 /Rgnb5UW5xPOxvbJojsk+p2wnjhokBF9Uv7AkCv4ezpywWFWFWjTJdeL5SXfdvFJvXn0d
	 /rVLYURjRdNboicNvbHdPmkl4x1fvKmmapMH5d1Zcstp8V8coyVc7pBrDviW/KIxPGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363179;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=anq5wxlAyr82UlOUlX+W5fPNoOB2VFDDLelO1SBpOhs=;
	b=ZGnXZpXnb9TjvU6v5rdaZlmdXRV7u+VwdXM9PyI4HK1AhbBVij18P3geRH5MpNdHIxOs
	 MfaRFglmCl+pigruwLj+KzhfhKpl1j8HbBNoUHd02NI4iE8rSuACOYXnyq8d53lQY0Qkv
	 YnNf+CAWCyyBOsWEj39ygSelPkKdUPbSe1dBycyPL5ufHsvf2DazF/7yjEKB7/CfL8Qqk
	 oB34WNcRKiztekMf99NFnIuTuedsUGKSK6Tk18fe4NV7JM33PvxoeGx/abiP/z9cHfZBI
	 B9Lgc2ljouzM9LOMobh4aD+6E58tstFcSL6JvRhpGBrRJ/WZOaeC7ViqUsChNFxAhyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I6qV2tDw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E44606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I6qV2tDw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB4C1F0089F;
	Wed, 11 Nov 2026 02:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794363178;
	bh=anq5wxlAyr82UlOUlX+W5fPNoOB2VFDDLelO1SBpOhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I6qV2tDwiwx0Adci6TPtK1f83uXRAMNrg712AG3DDgsE54cgmuRbJ2Y1VWFQjNvUI
	 8w1uYqw0G7hpgk6+Ly61XYGgQ7WVu+qu7/gBydL0ntqNtpc7BHL1hYAgZm9iO/wG4X
	 RBE3bCer7zDAe4jc7rh90kRC90JMWbGcPTEMtK1NYrc3er8Ls+nCtg2cOWjD8bsqfX
	 2w++T584lwk66oj0PhFdCrNunsyRZ4Sp4y9+ALU8X2v882u+88jIafXUwlfhWEUguO
	 MQ/xUW6cCTsDKl4Kf/G308HMIfXsfE/MMpGUTxYCMIiyyrcZwi3wAjLgZKDbJLGkq6
	 vqxdOeEpTaI8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] tpm: tpm2_probe: propagate transport errors
Date: Tue, 10 Nov 2026 21:12:57 -0500
Message-ID: <20261111021248.593244-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052530-failed-6.12-7d4f1cbfe063@kernel.org>
References: <20261107052530-failed-6.12-7d4f1cbfe063@kernel.org>
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
[ sashal: Replaced the early return with rc = 0 to preserve the existing tpm_buf_destroy() cleanup. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm2-cmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 63d26aebf55db..2e4652d43bca7 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -551,9 +551,10 @@ int tpm2_probe(struct tpm_chip *chip)
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

