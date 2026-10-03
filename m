Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D9F282F10
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791033620; cv=none; b=N3/AqiiiUsS1r9Levl897G1Y06R2D02gCuaMAAL8MKXltiSjt+VtinWL8km0kt7FeGJnMwwCKTRk1NUBUwVcDMf6Zx/iBHAFitN865czlmMM4AuxCZmygA2zyu9z+8zVJCXtHCElW3DVzm9yJ4TPXFjIto2p6Mmd6EPCL11B/5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791033620; c=relaxed/simple;
	bh=3E1khZD1Z+h2JETQwkk+HpiV/MZGIu/Eg3sktRPgomo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FkMgdsVOC0pOOV6GBoLPxix9vZmx52P9HlYNhOom3oKi85op554cmMcv+0QA/tpglB7yld+id/XA4cG80M80sAqaoLz02sgsF88oXZP3qHSJtuZSI17rnskMzgw1eA9tSDSdxhNsZpPcd3sFA/N95cXLCauBzUWcieOCBXZlTzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g7B71j6J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g7B71j6J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703101F0089B;
	Sat,  3 Oct 2026 13:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791033619;
	bh=mbiIJtGk6eOw7l4kXl/G8qN4+JQyzm7oB7PCj5NUFxw=;
	h=Subject:To:Cc:From:Date;
	b=g7B71j6JBv0e5nwzvS2XsF+nwgtxdbv8kL4UKb8pI2GEakDGyvnjxcKDDzo/VKBf8
	 BfMk2H760KXQREykLZbkUi1iqBsAe/a2I7FmcsFwgZFihdFgAvwNl5lV9TWs6+jmAb
	 hNaYJJ34dA0EgSCdZWAoYwX+ch2C++jG/jUGVZmw=
Subject: FAILED: patch "[PATCH] tpm: fix off-by-four bounds check in tpm2_get_random()" failed to apply to 6.12-stable tree
To: yijiangshan@kylinos.cn,jarkko@kernel.org,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 03 Oct 2026 15:20:08 +0200
Message-ID: <2026100308-drew-squeamish-a28c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9b522400bf5c082feb9a0037a053ea822a2c7e4d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100308-drew-squeamish-a28c@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9b522400bf5c082feb9a0037a053ea822a2c7e4d Mon Sep 17 00:00:00 2001
From: Jiangshan Yi <yijiangshan@kylinos.cn>
Date: Thu, 3 Sep 2026 11:58:37 +0800
Subject: [PATCH] tpm: fix off-by-four bounds check in tpm2_get_random()

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

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 96e0e06bbbf0..ae22295df798 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -307,7 +307,7 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 		out = (struct tpm2_get_random_out *)&buf->data[offset];
 		recd = min_t(u32, be16_to_cpu(out->size), num_bytes);
 		if (tpm_buf_length(buf) <
-		    TPM_HEADER_SIZE +
+		    offset +
 		    offsetof(struct tpm2_get_random_out, buffer) +
 		    recd) {
 			tpm2_end_auth_session(chip);

