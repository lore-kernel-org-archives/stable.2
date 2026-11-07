Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046429;
	b=FgFyu7h9QoK+K80c6fNe2iHfdl5ZkQAisJVZngcGcc4mUoD6gGiFVQWe6vAWSRan08MW
	 F+nubNdJtPnx4g+kMfWAFXId8ObauvzE32DV1qznsSxqL7apqXgK/tX4PX/xYv1t02gYN
	 q/ksDODi8RujqbWz4/oB8Kz3BVeLRjB7/w5HJN1FGyl0CEYVfDzCn/lfOHFst9gmt6E3I
	 dFnXIwZmFedIfWUMhoJM3KkBV+F/oI3I1KFrvkhefp9T/6ZjNdc9/Vrof1EafgNnQDqos
	 lsyE+s+Yy0pFT9twp+sZe9HIIwkXREem7DkePyGzZHxU4rpF1xEimzUOzq5q6bhfW6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046429;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KK0AQpSdlAn3VJfQO1bsB01cjJ3rf0ZWn6Y8TpWObmg=;
	b=bfph8shbhSb2KeZeC+Ua8kB0UZ5sRpyuzalPMiCZyDlMFSBMvpO0X69iT9HDqfKsXzf0
	 eXRtCcjp3cJYAxwaB3YNzE4hYbi6T8a3hpnC+4CB1s/W4ltSw8SHQh0HEQX9NAt5xRN/t
	 aX4eT8/CtDfCVkay+OmiuGaV2zLb9y/rLXqbbQfhlL1NUUz92nQD1NWFavUL8PIaftBL2
	 2CoUeYBpl9cS6vvU29ATXHA8LbaSBoy/8qzJ7EGJGctuoNbMYn6/hbomm4KrLpj5biJ6N
	 lWzMwC4vtpd885qgwLHAANAzrIbF/DsD1OQddFjeqLR2A5XNcIauDtPzyKf+9fx8xJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KdbKUvRl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B22606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KdbKUvRl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FD91F0089F;
	Sat,  7 Nov 2026 10:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046429;
	bh=KK0AQpSdlAn3VJfQO1bsB01cjJ3rf0ZWn6Y8TpWObmg=;
	h=From:To:Cc:Subject:Date;
	b=KdbKUvRlBDiuHL2xZLl7lJm9Q86bUWexZ1JRmOecrjy5MrQhcW9fxlR6GSO5EsYlP
	 s8GufN/Jsz2Tmwi1YxTH8WxnMjVCga9ex8MV4QzW7loC6EMtVANtQWS8EcnyNvt/2i
	 glL1YS2i8A4Edi3ssTDvAquEC6JoZQT1Mns2qThLUtRLJEGB4CtnOXSAOqj6Uwj2wl
	 gk2JuD20FZJdjJnf1cMwE+ZkG0i827rYv/bFyXYE1BiX/54f1+bhd4bc1c3RhMcDai
	 KTfef5O+Zezla2U29m4XzWqqOIydxW5vIQ6G/l9TNneerRYYQ+p0gLd3Ju+S5nQIJ5
	 2UgzfnHYBeFlg==
From: Sasha Levin <sashal@kernel.org>
To: alexander.sverdlin@siemens.com,
	jarkko@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] tpm: tpm2_probe: propagate transport errors" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:13:48 -0500
Message-ID: <20261107051347-failed-6.18-7d4f1cbfe063@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 7d4f1cbfe063af5581dac66abe9e9c965e1031cc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051347-failed-6.18-7d4f1cbfe063@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




