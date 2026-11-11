Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362979;
	b=0FywZPyz32GWB4o7yK9urzk+e7tT8APaTnMlCQJXs0YkKyzaPV5Qv9KVM0OMQwKoYMcR
	 IK+e4N4doq3k5XYqeSuK7qE/WLLAyhD+J6EP5Ar8bLywM47PlZMtaWl3CRcnponrGR6vm
	 B7Ux8U28Dk/4QWRPcAAtpsY+lXx+wnaUoPVHo9hX59GWX+pZGtn7OFlO38I3hbfm/tYYE
	 0zLiUcFgh3dTt0v8E47LUWNMQ4L9pPRcGbJK5GqW4ySXBygaZHJ+8p1lVMoHS+XdtHpAF
	 oDeOBYE8Mn4OfFbDy2WJ+2skTohu1d7m++I2+aewFpDB0hjU7G2CG7tZkG5MXBbm6Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362979;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lPnj9uvNGuh2YSqrHQuH71RwYJm5QbClhYB7bMVKge4=;
	b=2ceeMcPRcLZvGkzYnNr5R9H9f494RAN/q/XgBHI+8S9nQ/i6upQwdyItUiPZM2rg1ZQC
	 glF7A/m8xckDDs5+G8X8gU9veiK9GTeaKRXvv5csPd4AXeKj6mgkoIO6UeewO/UX3YmcI
	 hMwPl7YCSeuWPis7Bb+CVzulnNwHQi67tiOFBZt1FU+SgR/27OKURFFpXuAc+gcROSBTV
	 Tj8SNfBXBE64dpLIU/j9itqFelnaXwADxzxLq8lHUqIWd/QaNlIeBxFMQp8L6wESeGA7f
	 2uCQ5HMqFY3iYZaNR5NgDCeiDLVuMid8J3626Augc+fo4Ufu+Od5tC89iB1EVgKQB6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BHL1qVcu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3143F606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BHL1qVcu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448981F0089F;
	Wed, 11 Nov 2026 02:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362978;
	bh=lPnj9uvNGuh2YSqrHQuH71RwYJm5QbClhYB7bMVKge4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BHL1qVcuxhUIwWtnuPv773l570bgiFyipm08lYY5MXmA0mZXZSmqPi1bmnwoiHt5W
	 En2EFak7JxDSnmuYl3/Q7PpI67ARJ4IC5JphqN4rw3FESheGWNCLB9DH8ZI0SiSK3T
	 hc7X/D/BXQCF0RmllWfH6QPvvjySYA1fqNcImDNvisBebmeIc/KkAliElBKG4xcw6u
	 D9hlHLoCiz5qpgOy0kluVxHah9nXIXS7Lgujz6pRj9tmoCfvdMC5SL21qha3ubORsr
	 cwT+ZFiDj3D8dJhdxd0LgZDBV1J4TRPN8k+2ojmOsklT/LOYuYQ7UB4CCL9VE5T9Wg
	 zDSewN4+5z1BQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] tpm: tpm2_probe: propagate transport errors
Date: Tue, 10 Nov 2026 21:09:36 -0500
Message-ID: <20261111020927.560871-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051347-failed-6.18-7d4f1cbfe063@kernel.org>
References: <20261107051347-failed-6.18-7d4f1cbfe063@kernel.org>
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
[ sashal: Replaced the early return with rc = 0 so explicit tpm_buf_destroy() cleanup still runs. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm2-cmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index c5465834396af..85496fc5306b3 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -487,9 +487,10 @@ int tpm2_probe(struct tpm_chip *chip)
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

