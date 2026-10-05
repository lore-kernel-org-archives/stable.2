Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D532137C936;
	Mon,  5 Oct 2026 07:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187060; cv=none; b=j4Hzp9SwBZKOkweO4mq9KXnVkTsiWdHFKWD//UJHbKMj+uDC7vll0PHL8KvKdsHaWk0HTXtnjHmM2AumAxkBXtoz681xLOPi4IW3pt33xQNCTZH/o2hVuTMtd7HwcN8DBZcDU1WNVwrSiHZbSCgTyVpy40g7plqFb+O8qG6UOJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187060; c=relaxed/simple;
	bh=RVCSNcrJGL/bizGutYQ8HT7sf+E2lGeoUzCF/NOvyP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bg2Xo0QoWYlEF9s414c3fvyOEdIR+5PMJvLenmpnc6is7ApVmJht350dYLPun5rLytQhru5/N3vXs8gHLQEIorkfAkidWGjuoOIYuFlAF6VkgdOudvDdO7FxTdfhYMjR8bSCRRpu1Q+Vfb4zqaA0BEK7mNUcC1QDlm/6RkbVpec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsMWvlC0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsMWvlC0"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D3BC41F000FF;
	Mon,  5 Oct 2026 07:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791187056;
	bh=slmbwfy5IfGI7Oq6JJxTikw0Zbl7iHw8bAJtDZftGzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BsMWvlC0RXZ+STEWLT5QpqQ8ZiXqLyOc+EfDF1ziKubdyWTE6uutpzvyBGWg4glA4
	 vtlmfe895h+MAWVZ1wvDbT93kaVQuf/jFEL/Snb4K+fa/nSfyk7Zs4iZlySMtSQHSc
	 YaqJWMXlpFPP43V2QiyzlmilSIT6EOQTtvnurXp6mq3p6w4aCoRQe1Jr5xGFhLFxem
	 9Evh3I//xOO532aj8qEZlRG1P80lwAN+hmE66vuEzwSjLw1K0ZwAkiQbW/fgKrlqyZ
	 9F+u8uT3fBKAyMcJzl1R8jH9mb3yVyNCDkLR6KxK24pT4gGiSKOJpDnxSF7MF4Vo9n
	 OXmVFEPgRN8cA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: stable@vger.kernel.org
Cc: Jiangshan Yi <yijiangshan@kylinos.cn>,
	Sashiko <sashiko-bot@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan McDowell <noodles@meta.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Baoli Zhang <baoli.zhang@linux.intel.com>,
	Gunnar Kudrjavets <gunnarku@amazon.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.18.y] tpm: fix off-by-four bounds check in tpm2_get_random()
Date: Mon,  5 Oct 2026 10:57:28 +0300
Message-ID: <20261005075730.134611-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
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
---
 drivers/char/tpm/tpm2-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 2f506cdb5f45..c5465834396a 100644
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
2.47.3

