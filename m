Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399B1259C82
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 01:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791078082; cv=none; b=pVo47aixB1vSFx62dNuKl8AuV94eNDyYmrh72vM6gt0t7nXW5zQx11PdVAfHKd+boJFvSpqhZmbUPf6mkigxWHU/81D3ifDnzNdXDF2VmQOcO0wY2f7QZiNp1X2fad9L8xOjZnEA4FznSaBYebt4QghFsUcPMR9LUSByxUkrXl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791078082; c=relaxed/simple;
	bh=s1igt7qDt0bA9hFRYeBGMkR2BZ+7wla5pPXNQErmMvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TE4eRmgo7w+1O85di/QyAAzLYGq0ocunIbBkD+q+6Tk1kZD4Mt4QVOm0aMO8QLTBcoYOfFuO/yv36EKoyIdikan9sGvHuvOOeP3YR1gK5OTK1VuzMQcTbnCm5ploXVZo7MNQJVKVPhE1FkB1f7we+6pIbHRcR+d15gnIyi481tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgorsBYA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgorsBYA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13061F0089C;
	Sun,  4 Oct 2026 01:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791078080;
	bh=4jb3yRJq9RDJ6eOlybjuC70HOU0tnaS4P1w+LwQpaYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GgorsBYAOp4Cb+Qg+3CkOcbruyWMsmNWGmQTJsLCGfMG162mruqgtwhmt6XUMBbVI
	 KdOXw/VbMgtakY9OOLv/15cNqLkfEaV59fs9JJ/M2BskdELXp13roJuOcLlsnA8Y11
	 WJcifWKiCwCOxaHd1pz5SsI+i4a/7CYSmjHN0VfzdBZ/aVxEV9LwglLFUm4cx6kb0U
	 Qksg/LMISNy/4yqh0ldtSk9WFUWETK16eMy9mXm2aTEmCVzUpIiqiKRbuuE3QSnaIu
	 ZXXai6JKmD2Gbh9wXjjSuoxlq6RCyo0BaRScqtlMfu5tJFHO4Wok/t/BDyjyLiyuxE
	 xUfijhDK2Dt2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiangshan Yi <yijiangshan@kylinos.cn>,
	Sashiko <sashiko-bot@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 8/8] tpm: fix off-by-four bounds check in tpm2_get_random()
Date: Sat,  3 Oct 2026 21:40:02 -0400
Message-ID: <20261004012400.1311672-8-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004012400.1311672-1-sashal@kernel.org>
References: <2026100307-vacancy-udder-83a1@gregkh>
 <20261004012400.1311672-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm2-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 48cec39995fe2..d74df7808a3fe 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -305,7 +305,7 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 		out = (struct tpm2_get_random_out *)&buf->data[offset];
 		recd = min_t(u32, be16_to_cpu(out->size), num_bytes);
 		if (tpm_buf_length(buf) <
-		    TPM_HEADER_SIZE +
+		    offset +
 		    offsetof(struct tpm2_get_random_out, buffer) +
 		    recd) {
 			tpm2_end_auth_session(chip);
-- 
2.53.0

