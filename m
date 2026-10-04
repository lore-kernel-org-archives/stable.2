Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D7C223DFF
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 01:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791078064; cv=none; b=V4YxMiViV5/gVg28n+gwTGjY2iVhwyM2/ywsfWDJSKQuE4CoC7t/yBXUxLpiElkF5QQD8M22CJAKlTPsXKA4kjzhLwMq8TQSzO2nnxlONCVclApttEW5DglPqsmVBqRbFD5hPIbZqLHsFdNtaW6OnxI5j3bKtIVHy1J1EYerXhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791078064; c=relaxed/simple;
	bh=+9Px1pAZBKniWopEfaROWik0UyWIMfy285oz3w4fFc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGH3VHk4SFC6v2lI8AuxRqElWanqPjxnyygpJJD4WCvrwIm0Rvhd5gemztSSC+yFJUkITm/EssdsbArnPIoU3/n+NMBKZ7V4ELE/9BwbfdenPe6bTtI0tUpX176K1tIkMCmQMI9QDsaiiENhxZDUe858/pcsPSxbk85nGYSfbq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hrdj0H04; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hrdj0H04"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204411F0089C;
	Sun,  4 Oct 2026 01:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791078062;
	bh=R+oBWavD3nkcJh4FdQCU3LX5pwNasI963NbJIYg2ZMA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hrdj0H04157NJObbPyBOv7kNy4OzO200tmNUscgXcdud7UaH+KYrZtGYlwxZeC7+g
	 8PW/UtcA1yEoCXwUEFV0x5zJqlrTOMBTGewk7w1V/O0/waupo26z4OfB0fR7m9MPzA
	 hQ14KO7h2ksoLkCtyvudxYBGA1kNqP+EK3yqntBgC7KDoO7E5kqdXNqyvlY5pKsjOU
	 hMS+RgoSe6dJ5wKnOOnPeS+olsVa0lkn2n7d5hl8ZJU429Z6yEzmkebHLRU0nn9Roh
	 YbX3ZHc7T2nKve62bbfk7+B8O7pRAIl37yjRMARcCsVXNCgguxa09XzwswXEJf62sB
	 h2dgXRUHx3SFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Ross Philipson <ross.philipson@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 6/8] tpm-buf: Remove chip parameter from tpm_buf_append_handle()
Date: Sat,  3 Oct 2026 21:40:00 -0400
Message-ID: <20261004012400.1311672-6-sashal@kernel.org>
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

From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>

[ Upstream commit 065cfba1f4545e5948a2ddc5888a27c7641d5bfc ]

Remove the TPM driver chip parameter from the function
tpm_buf_append_handle(). The chip parameter is only for error logging
which can be done with other facilities like WARN().

Message-ID: <20260125192526.782202-11-jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
Stable-dep-of: 9b522400bf5c ("tpm: fix off-by-four bounds check in tpm2_get_random()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm-buf.c       | 9 ++++++---
 drivers/char/tpm/tpm2-cmd.c      | 2 +-
 drivers/char/tpm/tpm2-sessions.c | 2 +-
 include/linux/tpm.h              | 2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 61833b4d81f03..99811809a72a5 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -146,17 +146,20 @@ EXPORT_SYMBOL_GPL(tpm_buf_append_u32);
 
 /**
  * tpm_buf_append_handle() - Add a handle
- * @chip:	&tpm_chip instance
  * @buf:	&tpm_buf instance
  * @handle:	a TPM object handle
  *
  * Add a handle to the buffer, and increase the count tracking the number of
  * handles in the command buffer. Works only for command buffers.
  */
-void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u32 handle)
+void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle)
 {
+	if (buf->flags & TPM_BUF_INVALID)
+		return;
+
 	if (buf->flags & TPM_BUF_TPM2B) {
-		dev_err(&chip->dev, "Invalid buffer type (TPM2B)\n");
+		WARN(1, "tpm-buf: invalid type: TPM2B\n");
+		buf->flags |= TPM_BUF_INVALID;
 		return;
 	}
 
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 280f870e65170..c7952319384e2 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -198,7 +198,7 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 		}
 		tpm_buf_append_hmac_session(chip, &buf, 0, NULL, 0);
 	} else {
-		tpm_buf_append_handle(chip, &buf, pcr_idx);
+		tpm_buf_append_handle(&buf, pcr_idx);
 		tpm_buf_append_auth(chip, &buf, NULL, 0);
 	}
 
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 3e5404a54cd80..11efdf96ae631 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -260,7 +260,7 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 #endif
 
 	if (!tpm2_chip_auth(chip)) {
-		tpm_buf_append_handle(chip, buf, handle);
+		tpm_buf_append_handle(buf, handle);
 		return 0;
 	}
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 3c6a5bcc138a0..b357f8971d031 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -235,7 +235,7 @@ void tpm_buf_append_u32(struct tpm_buf *buf, const u32 value);
 u8 tpm_buf_read_u8(struct tpm_buf *buf, off_t *offset);
 u16 tpm_buf_read_u16(struct tpm_buf *buf, off_t *offset);
 u32 tpm_buf_read_u32(struct tpm_buf *buf, off_t *offset);
-void tpm_buf_append_handle(struct tpm_chip *chip, struct tpm_buf *buf, u32 handle);
+void tpm_buf_append_handle(struct tpm_buf *buf, u32 handle);
 
 /*
  * Check if TPM device is in the firmware upgrade mode.
-- 
2.53.0

