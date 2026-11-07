Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049851;
	b=PlHpQDwaheMcshqyoucxkggVYzxluNK5/6eI0WnYmVhJTAXMNNZQHVUPLPWnkgKNJtpm
	 GlRr2zNdLML6Dsm031HMwDZuQc4AFlwXbtD0T2ukdNN/yxUp3Jtp3oGwC1hAiTkD4Rqme
	 ynuM9ENfk6o/LioWDnyVlcZkYFlD9gWKOfRnwRj/uMxvyA44V9LjtWUCmD0C4a2Id0TFi
	 bOfDA85fpTN2IZHLQ69o6Hqk2L4cNlP7ZktPIusqezQh7Dz6Ied3DsXLmX3KHbj1AcQGQ
	 tADZtuyMiA2O46SMDl3W1x1pwc9MmI/0M+T0H2FtOFJUcLTv7AYPwV4DDmCTPT7FMrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049851;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9mUD9QEAV3EQ7QfIHSx0J3IbaaIHloZdkRpys5JUtfo=;
	b=0a/BjVVCjs9tROIO/aOOStJ4nKDI7LEX7F8kUJwtQliSFeS7a+gH2BuW7hcD+TtETyJz
	 /5cIlBJ1BpwyWn5OAjNAN7rFGimghHaHDdI6pe/xfmg55EXe3gNyDZX9myudcNuwpYKwu
	 SI/zf8OtEPfrGQlFU1+Mlv789WUhQkNODis4QNyX4z6zYFhGT8Dpr8t1Dh/FZy3Otl3Yc
	 qa3HX3ojH5GJmPGogjmeylpu/t+mHWXnpWXEYY3DTyCKBmHzXLiI1IHqD6JBjxppqocns
	 HJ0CYaCzo8lF14WTWdjU/bFTgAp8jBdgakTnWfTjc4VAIaKp5TpaCf/LfPFZrbQKYeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TI/md936";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3883C606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TI/md936
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E391F008A1;
	Sat,  7 Nov 2026 11:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049851;
	bh=9mUD9QEAV3EQ7QfIHSx0J3IbaaIHloZdkRpys5JUtfo=;
	h=From:To:Cc:Subject:Date;
	b=TI/md936ThbguI6UtcD07ysu4APRewTeXyr6hkFAEQFi106dTTrQRO867+wgpKrM0
	 hZKdH5vllrIkss/lkud3yRcQpi8OGe82Iv9SGb+yEBTDB4anUo+Ib/8bgR+trSz6Tt
	 yTKBBTycnCMuqboGXbG+bTZyGL6WVFN+cDf0EOhnbhJpjjn2JWY/kyVuw2SLY0d4bI
	 StYXT8hPFtCH3HbeFGUhJjKSxpJQ3v0uuJ5d5usIIa953jahDETyVcUL/yn/Nf16Va
	 nFFI901vmFipdb8od8M61iFvKmDat0Pi73pSilYOdViSA+CUcSmua3pD0a8ukQvmz5
	 CSzHE2U0xInJQ==
From: Sasha Levin <sashal@kernel.org>
To: alexander.sverdlin@siemens.com,
	jarkko@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] tpm: tpm2_probe: propagate transport errors" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:10:49 -0500
Message-ID: <20261107061049-failed-5.15-7d4f1cbfe063@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 7d4f1cbfe063af5581dac66abe9e9c965e1031cc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061049-failed-5.15-7d4f1cbfe063@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7d4f1cbfe063af5581dac66abe9e9c965e1031cc Mon Sep 17 00:00:00 2001
From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
Date: Thu, 1 Oct 2026 08:01:11 +0200
Subject: [PATCH] tpm: tpm2_probe: propagate transport errors

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
---
 drivers/char/tpm/tpm2-cmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index ae22295df7981..119c73a603e65 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -483,8 +483,9 @@ int tpm2_probe(struct tpm_chip *chip)
 		out = (struct tpm_header *)buf->data;
 		if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
 			chip->flags |= TPM_CHIP_FLAG_TPM2;
+		return 0;
 	}
-	return 0;
+	return rc;
 }
 EXPORT_SYMBOL_GPL(tpm2_probe);
 
-- 
2.53.0




