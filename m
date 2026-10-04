Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9383F6C55
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 08:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791102249; cv=none; b=iQrnBtu+06MPp/ERz50+Oewn7CsRHOMsPQL081SwNg9gDZ+DHJgGP2WgENcLlp8LEXDYBL3w0TWyS29pO6PHlgN4cjfokWhE2au0kEAFkFBWPEy9temMn24g7VSSXN0bzDiz+y5EiwfK3UDYLDzcUNzQXYmSgoX7GORaBdzKiPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791102249; c=relaxed/simple;
	bh=Fc/XnuzrcLX+cgi2C/YLyaeFpy64Eac6R2G8B8PNwFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4ZNChtcpu6aUCIokVMdn61IXljFTtQ3K94kl/uVjVV0F9u14QptVU/882R523YZeJd/WZ1o8TCd/HcwmzWRSK73aeRCkT+TIopG99noaB8ZmoCvLEOaY/MWEehVe52UJ337e5ohiB75DOVbWfnn2boJlUGcrv37WaRxEWjaHl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKQLCbAN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKQLCbAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FEF01F00893;
	Sun,  4 Oct 2026 08:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791102248;
	bh=EY/W5+gGJdKVj4eQhGYUdOHYPfAC4Uw6EZDNsoobWEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QKQLCbAN5me4mIJBQPBpOdBE5GvYQHrKYtLBmS1FBVefVmpMBwF+aEX+hOOha5hON
	 YzyJURhu+sc/QdU1Srw+vqvoB2wUCD36hM0JFoC2578H4Q+7ePq6EHo/sYtsDX00lr
	 aFiwGqLnKf2v+PrvXYqOoG54nhZ4KFHHVsFfFvkbCbPegO/2C6t9Jgez7DqTy1Ev+8
	 9cgtMj00YREebjadC1UEfHb3yzaoQBMryW+gUBSmHwJRK9lZ/SL7nDSRXoz9dMQhBF
	 wvqDKUbfYCPEpVCW6vF1XZ+hsLDM67b4yAG5Lb3m3LfMiFx6oyPT2vYCpkgjUPmTUX
	 YJT4liSYJCJvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiangshan Yi <yijiangshan@kylinos.cn>,
	Sashiko <sashiko-bot@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] tpm: fix off-by-four bounds check in tpm2_get_random()
Date: Sun,  4 Oct 2026 04:24:04 -0400
Message-ID: <20261004082322.1389916-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
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
[ sashal: adapted buf pointer access to a local structure variable ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm2-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index c710128f49b11..63d26aebf55db 100644
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
2.53.0

