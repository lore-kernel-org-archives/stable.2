Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048823;
	b=JI9KSPacT5GNIxYOtWix39Eu+IeJLqnWzLV0w7vUwspYKZsPa2Pd0mBwuaM4CsN24PSa
	 hQdFo2n35/fLqKdOO63Ce2rry9LrnZAcGiPlzcPBNGzMX7doY4U6+fyEuPToIYbB8XkOW
	 kbkUgkCbfJtNJ3uhEwNMCR22ML/ONd3HAw11Wk04d+S/3AriGWyO/MSufaet8FdxLgdb7
	 ayQvXlZg1z0IABO20d/R5iwOmi0HacZyukftQcYfxXLpmWb//9JhZaixZjeGxQAiGabJT
	 Jxy1HN7RhNiTIqBQYDJTF9CPgIKNryEwvQTEY5dEFdZJQxXNhg6wq+ig1o/J9gEctnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048823;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Q/c8HUTmFmBcRNagmSp0SnYheO4jzuv49mw5F4rBgxo=;
	b=nULw5Pj6kZHTfS9ZxE0HwzB50ISJx9eo9V0J2P5Df1gcFRmRoi9vj96PNuO6oR7TUPvT
	 Th4wlvaQPuHbXI8K5RkGN6acootgwVQD83r1vAEJyh9QY3Swj0uePX5p1QhTDnqfUTtP+
	 9JkFN6PcAQS0NbrZ6ULRaJzjSSBA/kmdp55VJUvVUvjLnIjIPU1c+j1BbMSu2zg24rBHA
	 SgC1tTQ9eod6S5iaF139L3thgt5oRWPTj3nU1icy0e08//5pP6btXkhSDJP1RUp26YIaa
	 gd7pWIlNaEXrmltKPU67LukLZltin7Ta051qM06Nw2KSyVLKsN8oFSu+U9j96L9jd0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="X6lK/JjW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71B2606A336
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X6lK/JjW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4329C1F008A2;
	Sat,  7 Nov 2026 10:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048822;
	bh=Q/c8HUTmFmBcRNagmSp0SnYheO4jzuv49mw5F4rBgxo=;
	h=From:To:Cc:Subject:Date;
	b=X6lK/JjWGEbRgYIbvzwoh0QzX/rABaUiqaDw2c4GwR3WsNWmH9ji1LUlGgS1PWFYt
	 fjk9d2PBkhP/VFWcrnkfiUmQFBPiU78sfCZfBNdqz6gt2mgmWu4b1ePW2hqfRHFvt/
	 EvrBcyh7XbjW9lw5AEcm4dn1WpWk0WDjYzmho7/HIMKcWfhYS/x7k7HP6qOQknr4cd
	 fsQY0x+N2BMnspQs0yjpZQ2OyEvLfJx6bfkG++9OrmP7IXNwLhS3eBsIUm/PlCjWOh
	 pKAgZjD5ZOs+jdyTIqi7w/qYxbN8vt+R4cA25v7aABrMM+c8p7P7kKQwu+YLit17oT
	 8n8MO3vtszu3w==
From: Sasha Levin <sashal@kernel.org>
To: alexander.sverdlin@siemens.com,
	jarkko@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] tpm: tpm2_probe: propagate transport errors" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:53:41 -0500
Message-ID: <20261107055340-failed-6.1-7d4f1cbfe063@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 7d4f1cbfe063af5581dac66abe9e9c965e1031cc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055340-failed-6.1-7d4f1cbfe063@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




