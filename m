Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A70369225;
	Mon,  5 Oct 2026 07:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791186905; cv=none; b=P6xQgBWxwIkt3jP4xXhah2sgeSgrVooHAJk4jnbg7xMXZXDjZMA1vLrsZP+c1mgTa66foWgcboUX6eLMLSebhqzuS0w7RJ9nC8W2EFNTbvD+f0xXaLZ212sQ0SRfOtVYvWw9B4c2dfxb7/ALHBLrv7cwrgEFBP+534tYG50kUas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791186905; c=relaxed/simple;
	bh=Zcpz617fRR45Pw1ONLAOlzvIQ6R7uHtkL/v32Wg4GQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJx2mzD0xkLPlYMWZ8OoKvGLSwjVADvhRTkhOPrGQ9B8vf4MIHxoQ2u2C8lLciybPt8IQLB6ZDX24ip+xaTkoSWZaqsWDarxpPD37lxFysQhACht8SOdflRQYEXjjLSwpML2jBsXJnOGxOfhn0EmOqjw/AKfTYt73hEDQ9g/GhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuqwtPxK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuqwtPxK"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B5F651F000FF;
	Mon,  5 Oct 2026 07:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791186904;
	bh=1sBWQJGUsot5fKzQlaDt/ghl1Rfcop5XMF9XkBxEdMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AuqwtPxKNaTqJGSfYxVaH9M8YP1fLUoG1/rVr03rSsSyKRch+ux33L5JSQfmZj6Xs
	 Q1+zXbwcBiVmtuevzg+HEVOh41QTuL3mmWjqlyueZ2+fSqdQON6T9wzuhInMBUlwku
	 Y5cZMnqcsxRFjdNJb6e8hTBMPVJHemdDt94p/Vxy/HgOTqVkAUK/1Pk4HYgnjdbYMr
	 f6ORTu19dwusoKeiO0i0GASyUU1A+DTQsY7usaarHV9DOcSf1qNeQCFzN9kSmnHVZK
	 Ujr+1amo+utAom8Rv8xcfOS2x7bVEywY8ZFkd24JL4AavbhiIUA9qWp87sNK5/azhQ
	 jwsdPDhwORUSQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: stable@vger.kernel.org
Cc: Jiangshan Yi <yijiangshan@kylinos.cn>,
	Sashiko <sashiko-bot@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan McDowell <noodles@meta.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Justinien Bouron <jbouron@amazon.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	Baoli Zhang <baoli.zhang@linux.intel.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7.2.y] tpm: fix off-by-four bounds check in tpm2_get_random()
Date: Mon,  5 Oct 2026 10:54:45 +0300
Message-ID: <20261005075447.98992-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026100307-vacancy-udder-83a1@gregkh>
References: <2026100307-vacancy-udder-83a1@gregkh>
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
---
 drivers/char/tpm/tpm2-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 52ee350da867..e12e245faeb1 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -318,7 +318,7 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 		out = (struct tpm2_get_random_out *)&buf.data[offset];
 		recd = min_t(u32, be16_to_cpu(out->size), num_bytes);
 		if (tpm_buf_length(&buf) <
-		    TPM_HEADER_SIZE +
+		    offset +
 		    offsetof(struct tpm2_get_random_out, buffer) +
 		    recd) {
 			err = -EFAULT;
-- 
2.47.3

