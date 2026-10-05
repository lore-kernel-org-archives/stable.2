Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A07037E310;
	Mon,  5 Oct 2026 07:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187184; cv=none; b=YNInJhEukv11rMilFbEp6BxnJQG0/Z8tjQc8gQFaHJOzuaj1Rr/0ouD+O9D92wKtAPcCCEK3g5Y2zanSt4ejQRrYIjjspLYH5RO1x+mYGg1+yUJzvm9uLKiTkhIQKHBbAtBj3LF9fYnSc04Gk0I+zcFCRDrPr9b47bf+Y7p64Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187184; c=relaxed/simple;
	bh=ghpjdFaumUgV1uTgCpq6U//8qDGQkD+6jzEjPmn7FcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iK3pho4c0Q3cBNDCG52a7RYh0/z8SkAkfWBkS+TB/eomPa+vhlLrTjWkfbFcxajTkDzVT5NCINSEGqlnDBLZYnDJjW1VJVRw8E2dN4GuuIJOpNpDSjItvn7nOdMjaDExkN1fFpYLuIIHw1UDOUN0jDAtHtgkIzpzXMVBzTwbdYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQUxspnw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQUxspnw"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3EA361F000FF;
	Mon,  5 Oct 2026 07:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791187182;
	bh=T3yn+2KEfwZmkc8KLWGLwEbpX8h5fKa8qM6khpZ50TY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lQUxspnw3LSUPmO/3q0zyU7v6RrVcXIvXhMCvEyMuRxntNC7Es0q3VqFUUsPpxM+A
	 MHq7u99fS5GVWF+XPQlpW738MEEmPhRH85ljqBna8LYOpAj63y0wE0q/3FpH7OUMtP
	 MJPM2h3vhFQAZBQ3A9Xqhh8GkIx94R92z3BBrYbd94Cmq3SdPkH2eXvknKurzlvfN/
	 fEgeJ9o62/9JFczPwa7wKj4MFvDPIStpSBXwR7CaKAiIMPocxj6zM718GKCgQc73Pa
	 lGPuMNuiZ6WeNY/AI+prNExS0+Epaf7WJnJLMH5j3T/pNPYeAm0l6TsLKCRupEqRox
	 ivJBoyF6s0Cjg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: stable@vger.kernel.org
Cc: Jiangshan Yi <yijiangshan@kylinos.cn>,
	Sashiko <sashiko-bot@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan McDowell <noodles@meta.com>,
	Justinien Bouron <jbouron@amazon.com>,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.12.y] tpm: fix off-by-four bounds check in tpm2_get_random()
Date: Mon,  5 Oct 2026 10:59:33 +0300
Message-ID: <20261005075934.151106-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026100308-drew-squeamish-a28c@gregkh>
References: <2026100308-drew-squeamish-a28c@gregkh>
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
index c710128f49b1..63d26aebf55d 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -361,7 +361,7 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
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

