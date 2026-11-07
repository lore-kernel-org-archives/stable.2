Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050874;
	b=Q+AhZzDjLeyVgY6LHMQ8bW1ppZB7W/efyMn+QClUl5+OyMk7WsxFVGAKZPDGdtwXt7kw
	 dKwD1hkQjJ5EQ3tsc34WNlDVgsxx8XJFeEb4TSrOTgG9qeYHz6jBU6XZsoqtQ1EfYugXZ
	 qABsbmNGYhzwYA0f7v2nrzhjzxY9xXrS+Yk+MTZ+OywqhkLickvIA0vx6NwAjz9eadDy5
	 S/2zFx9G4LhwlQUDv0EH4dZAnL5/4JAskEJ5DwSCsFy2V8yQKhJa1oFOD8vHC9kza4YqD
	 8e/UtToIkP1YLhC7Zhcty43wY98CaMnLGQdYLyPedLZ7G+si7cXR+DkaHZpX+Mk0Tew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050874;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3uWIUHf2GcvFRE4k1U7aobWs0/r5OiOlV5HRMJ4fJMo=;
	b=TWVIilE2KhH5jz14y107gMsl7sYOw79vGmwpKSjqb8QTh5CXlwcLDawZ6ni9q3AlhE7A
	 Mgsb3I08CHp07d2RBPyxGEiM8/c6glR7Ptj3H0lzvsXHaHK8zmPhaKqW7tfuxox3rT5Wl
	 mPGMMHY6AkZLpbUd/FQ52V0uO5AuAH4ynvEb4fiUvNMAcpmmJI68G8Se58TtnHjtCwR5j
	 sfpZRXjBauMaHlmPBh09uK+I7RrY+V77klQOEsDsNcN2R82lVle0u3W8xOl4DVlgMs3Wy
	 YZnybIaUIqJOPWR22M/o0hc6CQr0+VtTmtkkamxnxfoEDRSJGBR7VK3NXG0VjP0fY6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g18GIWNi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307AF606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g18GIWNi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AEB1F0089F;
	Sat,  7 Nov 2026 11:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050874;
	bh=3uWIUHf2GcvFRE4k1U7aobWs0/r5OiOlV5HRMJ4fJMo=;
	h=From:To:Cc:Subject:Date;
	b=g18GIWNiqkjg2iGjZmBMpWaOju4ctxWrq6PQf/7uG1/9zrS94SkVbgpdttBljjdbB
	 gAfSITAP+L6qzvy9HKUjyP0iBrfsRV/UaEWCFesmmwY75cUWAL7+y+lzV7fpsphryn
	 e5mdb+6T6icNMoaoCu+u1c2McbY4mUD3e02MstmIt4X8V4k9Y6hJq+VeAw0RNOYfWr
	 P9X/h0CBXIgbhMNW4COqXi5fe4dQ30nQqKW6viPNeP2U2NVilNXJiEbCXbfzXJD2q1
	 XiJkotuT2oj5N5hO/1ggk74iKEKOX/oiayIuoKxz32EuKW97Hadc27GvGpqTvcZEKs
	 RcO7oVdp13MYA==
From: Sasha Levin <sashal@kernel.org>
To: alexander.sverdlin@siemens.com,
	jarkko@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] tpm: tpm2_probe: propagate transport errors" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:27:52 -0500
Message-ID: <20261107062752-failed-5.10-7d4f1cbfe063@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7d4f1cbfe063af5581dac66abe9e9c965e1031cc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062752-failed-5.10-7d4f1cbfe063@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




