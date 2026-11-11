Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366776;
	b=FP6LFKxQ8khHJcYgD5nHwfnzgKT68dCTd3sUL0YDiY5eFzJeOvGuSZJ1OZyrohQect5G
	 0nz005VtVgB2YsN3rW3rojhqO+0tbL36/bvy3nSD73NVrzHmHah1aIhEYh+SRZ7T75KZT
	 QaGy++DxG+bYcPdNoXYX1AfTT/g8PBidJVMECehBFIYaD6ZmU4p/C2AAxHoWXbQbvDyu8
	 J8OCzHplqGLcIe1poKoWq3ctr4I4+H7HOjVPHUUXkUEY/w0Pp6/KH9DvLRRtcCMitmMo9
	 IHG/gx2bXL7MVE2SluNYIK4DLfo98Yyu3zFpTfakb96ZGV+tgYdRkQNjDJi9lRx7xzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366776;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=eSdnhTohQLo5rbiCtFZN71KmpfO1smlJZwWBGFUh3bE=;
	b=VG9iLFGBKyZaJHTK/nLWpiMN26K6vIRyqD3j/s9GxJBsPVolysCir84dLb4zTNhUgPaJ
	 3wHOTavTgZ3pcIU/txsaRG4wgP+faL92G3fmSwcxpBgEBAp8L77PVADc+lI7IocxYE1Uf
	 8Jwe4OZYVfWGukRNcKEgGsAExkzMSziKYusRTUljEV9ZpIpibdE69uJfOIvBbpbxlcYun
	 x5nmGcaBxqP6fxVXTZg9apVZ62blNKjfQ+nsN5DV76zsedyaeoNrWZkEnqfXEm8ZDpKCB
	 aZdhNgQhLaZRCLKFK6wE6Fym2Dbvjr2sxCIEbtz0WmHfrFvB2KVJ5zzvCVFQB9gCfVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bV1svciU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C7606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bV1svciU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BD81F0089F;
	Wed, 11 Nov 2026 03:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794366775;
	bh=eSdnhTohQLo5rbiCtFZN71KmpfO1smlJZwWBGFUh3bE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bV1svciUyQQfFCYOWQjJxudjscpL3Kmcmnjlrwg5PV8sOtf3AK91ZezcjBor4Nfhp
	 XD1MZIESsRNkFNO0dYOmUTd6J3gq/XOBlU7mj7UsX6+lPWkY9vTcjSLMlj1MbnkeDZ
	 pQ7115d/iRD0bOixazc4UkfDGqyr4cW6iqP9svcKiboYfYgDVmdvGJYnRcskaU7TIA
	 +YVkiPWvB27M4s2SDpaT4MElNVxaBRXfkoKyLPMFq1svoXgt70Wm8NLLH++zES77um
	 6dF1eWfnPYmtT1gousXB2LIye0iwUfCVWbcdQhlyltd1i4Fbr0TextGKo7YIq+VyAO
	 haA7JB9WbZbfA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] tpm: tpm2_probe: propagate transport errors
Date: Tue, 10 Nov 2026 22:12:53 -0500
Message-ID: <20261111031201.700755-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061049-failed-5.15-7d4f1cbfe063@kernel.org>
References: <20261107061049-failed-5.15-7d4f1cbfe063@kernel.org>
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
[ sashal: replaced the early return with rc = 0 to preserve tpm_buf_destroy() cleanup of the stack-allocated buffer ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm2-cmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 440b703e29e5f..662642c59f6d3 100644
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

