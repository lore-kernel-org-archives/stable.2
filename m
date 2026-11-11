Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370429;
	b=TLBsvZarrTUKrCrPB8fezMtA0aX0O803/0JJ33bEenMFwHMGFCHLoApe7zEhKGId2Dkd
	 NsfQlvW4aLe+TwBr2kZfvg3dIH5saAFG69quxRKen72pj3GyJytGlLUsXd3f8KgVZ2BJg
	 jvY71kuSsOJ16IXWMyyvDg9l4LiniYOFSQ6Gz95sn668uljsqh/6U6HIL6aaAVTCZF3wi
	 pOofadpewLZVSIEoYwevp+Pk4+t+qaaBPd7EH45hcOl1tepBnnTXBKpaIV9id6wCLsD/w
	 d9gns23KVbzJjqF05zY1n25dVxUiyWmdx5k+VsmolrhPr/ouXRwHmoF4OImoxAqmrZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370429;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=m1cy9XY0gkZjCnrTsP/f5wDbQYC1/Bc2o9Zw0WFvK+4=;
	b=qP+lutQUY58+myz+/rySXnvspxfU74vQ2EdwaEH7Q9S0J7pTTyXKHJ7bU5rZUtR32lZP
	 Bgqd/oWrsn5CJ6dEPvAoZH+JDv8AeasEcMzY9HO7ialDqyUXESyEgHwMAXgwXtnb52hhN
	 wMc1MzXHf8jBkcf/fPeXQEaOFYzeMzomu6jLBRdH1r9UtQDDEctIxhxF/mdiCkBsknRQz
	 rJquFpflYv7iW6K3dQUnOiXPsMiiJ2fj8QN1wjQ2FpGt300r/NSzRvDFEtYu8E1aZp33Y
	 v/CIUq0BW8h6diKrTG/UFbIJ3clNnbv66lJHPs+n9aLMWJIG98HKC5v55k4J9wMJxxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2SPLnhm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C693606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l2SPLnhm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A11C1F0089F;
	Wed, 11 Nov 2026 04:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794370429;
	bh=m1cy9XY0gkZjCnrTsP/f5wDbQYC1/Bc2o9Zw0WFvK+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l2SPLnhmte5xJ2kgVNVUUXroXcMFrEyuOpuzd4SK409qnnuRKzJ6EU7jTaL1liKYE
	 6FMe5YZWw6RQo7aqLH82xiaoS0JprM4fItzHQ+eo4n1MUQq8cR7R53xUtalSylhNCY
	 Tok+NDcC3dOEId8ymc/UzGzm/vFSmWgmYhJtAwLh5N2b9voDYEmfWmG0nmohjU89XO
	 jSVwKEtPMT94m+z1+SKd+JFcQcLn/lgKcWvVpLxTtPTjZNhu6QWvVgdVC9XuJ8IBJV
	 34P6GNK0SubbCDskbLPOHn+u5y4UEbxeasilot5tq7VYmchWOgxwkErAyZAERY4DnD
	 G0PsIRPylEujQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] tpm: tpm2_probe: propagate transport errors
Date: Tue, 10 Nov 2026 23:13:47 -0500
Message-ID: <20261111041247.878982-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062752-failed-5.10-7d4f1cbfe063@kernel.org>
References: <20261107062752-failed-5.10-7d4f1cbfe063@kernel.org>
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
[ sashal: adapted to a stack-allocated buffer, setting rc = 0 instead of returning early to preserve tpm_buf_destroy() cleanup ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm2-cmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 0b683d991bedf..5f453b9b2fb5a 100644
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

