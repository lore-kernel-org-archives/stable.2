Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BF33EF0AA
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 07:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791100120; cv=none; b=R+p/pH113w/IkvSz26Skdoa2lzwvZ3aWfX0qfDkF98I3DqXMNSnNWErqe/ifkVc+a1HsTuismBFhioqUYPI2xDyHn+lh2jN6f/MOEtEriAggtx7tMyTBZC2hXCw5SJETGIXATrpDKSsVn53lX5DXUpLwtYxtykEuS2xPN7+Qr/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791100120; c=relaxed/simple;
	bh=qgZXVQIrH+5OgXxVvNN7z4HlJvI1yiHOFPOBwol4SVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MPypI+14epbI+5511P+pS1NBtPK+67Ep+HVGIILNpppaujajJQ+p7O4K12zRt4F1dTrQ7FlcJ6aK1b16d3lcDyPE/yG5M/GbVOu42pir36n4oG2H+f91QxEa2yW8OuIIJvVoP01XVQJVF3mc5w7EtTlXRF0Ozer2VdhKQvxjXWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMo5ruuP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMo5ruuP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF9C1F000FF;
	Sun,  4 Oct 2026 07:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791100118;
	bh=Os8EFbcqIpT7dfzkwWq4qo3i3U7NT6cDfrw3F7KMrMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fMo5ruuPu9GuOdH6ohkqrkwCjvd1z5orGY5l80WrWw+BEfL+YODn/Whrk4oOTqgrO
	 fHSe158pi1s9eiruvRAaKc9+8gazenlioFxfHYIpJrrm5rE3AEptS5/bjS2YTfPxf1
	 nK35UuU7LsiQBt9yuLzXulmAilb+wbynI+Oza3Mrh/kS1pRzGpU3yhixHo5QwnRC1w
	 cFPkGBuauQw0MYmySlaOnqRaNjDr1K6O2oG+EgQyk3Kv+UdYfC/FmeaURCjy9pvnvK
	 h0zY/38c++rn6KTtVqpEF7ogOByhi0i3eG2dxTZDMAUuF5h8TGH2ZJfqRaGbRp3nGE
	 IL0AgDX6hYetA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiangshan Yi <yijiangshan@kylinos.cn>,
	Sashiko <sashiko-bot@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] tpm: fix off-by-four bounds check in tpm2_get_random()
Date: Sun,  4 Oct 2026 03:48:35 -0400
Message-ID: <20261004074826.1382544-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100308-undertook-vividly-2e61@gregkh>
References: <2026100308-undertook-vividly-2e61@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiangshan Yi <yijiangshan@kylinos.cn>

[ Upstream commit 9b522400bf5c082feb9a0037a053ea822a2c7e4d ]

When the response carries the TPM2_ST_SESSIONS tag, tpm2_get_random()
skips the 4-byte parameter size field before locating the random data,
but the bounds check still validates the response length against
TPM_HEADER_SIZE.  A truncated response can pass the check and make
memcpy() read up to 4 bytes past the response end, so stale buffer
contents end up in the caller's random bytes.

Fix this by checking the response length against 'offset', which
already includes the skipped parameter size field.

Cc: stable@vger.kernel.org #  v6.12+
Fixes: 1b6d7f9eb150 ("tpm: add session encryption protection to tpm2_get_random()")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260902074839.417419-1-yijiangshan%40kylinos.cn
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/r/20260903035837.219284-1-yijiangshan@kylinos.cn
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
[ sashal: Adapted pointer-based buffer access to the existing local buf structure. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm2-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 2f506cdb5f458..c5465834396af 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -298,7 +298,7 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 		out = (struct tpm2_get_random_out *)&buf.data[offset];
 		recd = min_t(u32, be16_to_cpu(out->size), num_bytes);
 		if (tpm_buf_length(&buf) <
-		    TPM_HEADER_SIZE +
+		    offset +
 		    offsetof(struct tpm2_get_random_out, buffer) +
 		    recd) {
 			err = -EFAULT;
-- 
2.53.0

