Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA2D4AEBCB;
	Tue, 15 Sep 2026 15:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487242; cv=none; b=ivP2tsiTJXK0kykduvQOs0V4LHFuPqMZNIohfrvvOypxzT9yyB2x1+lV4hAA3xyLywyra99gDr1hFmID7dCn4PW77HQ8GaXbbcXfV4i0R0StLNXQ+t1Km2Bzun6QjxgBi1+R2TFhme72pgw88Z8rP01WfiI/Fkggixsa9EnQPFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487242; c=relaxed/simple;
	bh=zY4CZInE9nLBGNkxeghMCLlB9OdPxGnlo1CTH0VAYCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qvw5ia5rT3UkHRte6Y3zrNyslOkVHSRz2Z2ASGP82fCtzm8eKwRSSWy9QgcSdb4yrUtvOdHOGITTH4VLkBT2uv2GQgTLuYfxD8aelUAvnz2e50J9rOWgWYCG0dRkD9Zhi9MO7jBDZ6zmXoS0YFUBnk1Bge1mjAHPj0vRyULXu1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y79Px71l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y79Px71l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D5531F00893;
	Tue, 15 Sep 2026 15:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789487237;
	bh=cJVzqwsaXl7vbHKq/ephxVNEzhNEsZjIGYsDCEghqJc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Y79Px71lo3t8omhG8TiAqRvEkdxZFuVL99AWyBrTJdDBbp92DJK/Eu3RxjcalLb1l
	 CpgfENCvqxgvfJw/eZ3UtLHRpOSsSExou6kn1paL+Lq0UMxrH2314kHkkqOj7touSQ
	 2+qRH4iwWt4LHORD0Hf6FphARDN83B9+9+OKsjEvjLnQdaNfHYVSwnYR7gtynMYh7d
	 vHbOO3Gnt13lJOJ19UO+s1LWArIK6tsXImnydiAxbzjqpLG0Y/ILsLEi54oeRnXadI
	 bgSy1jB9BPWlMXmoZ8reqA73bRBiXgWqMQyMOXDFv20Kv57JNdBMzOea2Cua9C9WEz
	 2VVbHVX+km+/A==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Tue, 15 Sep 2026 17:46:57 +0200
Subject: [PATCH 1/2] HID: bpf: cast size to ssize_t when checking
 hid_bpf_hw_request
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-wip-bpf-signed_size-v1-1-6bc8f3d09f5b@kernel.org>
References: <20260915-wip-bpf-signed_size-v1-0-6bc8f3d09f5b@kernel.org>
In-Reply-To: <20260915-wip-bpf-signed_size-v1-0-6bc8f3d09f5b@kernel.org>
To: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789487234; l=1438;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=zY4CZInE9nLBGNkxeghMCLlB9OdPxGnlo1CTH0VAYCk=;
 b=pAJRBdsTq3rYaU9G3i6YPDYntJCSwF8MujODJ6FvlWbaYWHycuQNReb4yWoY9LqzrtiQ2t/4H
 8qdufqfnPFiBpfcOn7PIER7zMrf7OXf3muwMROzq7y5tqLB6n5mX21g
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

As reported by Sashiko:
If a transport driver encounters a hardware error and returns a negative
error code such as -EPIPE, ret is implicitly promoted to size_t when
compared against size. This causes the negative error code to evaluate
as a large positive number, making the (ret > size) condition true.

This silently converts the hardware error into a success return value
and copies the unmodified buffer back, which could leave BPF programs
operating on uninitialized or stale data.

Fix this by casting size into ssize_t to return the actual negative
error code.

Link: https://lore.kernel.org/all/20260904130354.A79471F00A3D@smtp.kernel.org/
Fixes: 2b658c1c442e ("HID: bpf: prevent buffer overflow in hid_hw_request")
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/hid_bpf_dispatch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/bpf/hid_bpf_dispatch.c b/drivers/hid/bpf/hid_bpf_dispatch.c
index b1de1dd0f21d..ece2c7c45ea6 100644
--- a/drivers/hid/bpf/hid_bpf_dispatch.c
+++ b/drivers/hid/bpf/hid_bpf_dispatch.c
@@ -453,7 +453,7 @@ hid_bpf_hw_request(struct hid_bpf_ctx *ctx, __u8 *buf, size_t buf__sz,
 					      (u64)(long)ctx,
 					      true); /* prevent infinite recursions */
 
-	if (ret > size)
+	if (ret > (ssize_t)size)
 		ret = size;
 	if (ret > 0)
 		memcpy(buf, dma_data, ret);

-- 
2.55.0

