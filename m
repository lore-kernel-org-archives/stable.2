Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4AA282F10
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 13:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791033623; cv=none; b=sdW5EWtW+6iR2hI/lmbTwa4m0Zm4HmrZOjnX6PdYtT+LaxtWpbcqHbJ9GRj/cCsrYZpmHzp1UV57UcNVQlqD4xl8W2Cp9xFMH+BzQBZb4XMBBmNxaWZvDUjh8x5k9pAceeAhNHsv92D/9yZu81CIDx53xqm9k1L5IMcTrmT/b68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791033623; c=relaxed/simple;
	bh=jwW2ff4a1EvbrGD4xHMJFx0VqJg5BcGY4GVBLUm/liI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=draLOp9lmYje5hV/vz1GLD4Zg+oPx8TyRzWX2Kq4QDnrpa+uSE0IuZHzlIFBcoJQcSV5BVc2Jyho8AH6zhIj12M8xRhk4zbCFU42Sbio1Cp5XemaHDC65+KdysybuPN/vx1bWFY6LmSw67snXJxDljJv0uIG8HDPamKpy5sPxXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KYzDuTFs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KYzDuTFs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5711D1F0089B;
	Sat,  3 Oct 2026 13:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791033621;
	bh=HAHd+8KLgqeomynOR3CUtXP3rDlH3WAQc3W+iBQZXII=;
	h=Subject:To:Cc:From:Date;
	b=KYzDuTFsF22SNazy105i+o9dkghvQnMykUbbX728LEO9k4NAfDPLNAGZCj1Zxk9lJ
	 JDJnRDQ6fzumyuTUoM8GTk5UuT1CvRx0gK1qRPsSPtOXJwMuqOe2tgkBCv/+FQRoBf
	 IATTm5Mz1sG87LKLfYFq8CM3ZBsnWz3qG8ay5Uk8=
Subject: FAILED: patch "[PATCH] tpm: fix off-by-four bounds check in tpm2_get_random()" failed to apply to 6.18-stable tree
To: yijiangshan@kylinos.cn,jarkko@kernel.org,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 03 Oct 2026 15:20:08 +0200
Message-ID: <2026100308-undertook-vividly-2e61@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 9b522400bf5c082feb9a0037a053ea822a2c7e4d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100308-undertook-vividly-2e61@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

