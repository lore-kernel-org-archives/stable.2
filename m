Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E7A223DFF
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 01:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791078057; cv=none; b=geld+kKkouIBL9GbmfRCAesZekYl2PfdQs9RSPtiDWtxxhN2Qrxvy0bTo37L8q5M0VVSYqjLz+InmtH/GGB26QOm6O5xZlHsJ6xKkucbKRQzotfSH5fRYGtmxxn40rqOg1pekqV4G/zwRHBWkz6eUDcy8XwG5s+tjIOgTqMRq08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791078057; c=relaxed/simple;
	bh=2lCTA2R70bvejbLEPUspotcC1enyL90FTunnQDyp/CA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fhimcIx06/exkmnVabPpF/iFO+BruY5IsjPoXR/Z9EkSFEcdlLkSyR79mhO3dcK1c/Oc/a0pzZpClbVW53pP01ImP61SfyYBJ52xUdv4dcB+TdqtYtOdztzoVhgblLs2Orf7yzPBJUtOiDxSdEMn9tmMufmKGb85Yg+NTLDGcQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgGP6Xfd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgGP6Xfd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F0291F0089C;
	Sun,  4 Oct 2026 01:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791078056;
	bh=yW+jEEgw5W8NVPogMKQtcpoS7MkvFnEtpeHCJz2T6hc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WgGP6Xfd7X0MhiwBl9dFuYxtp6n63P690DL36LlhZGs+qtCg1zM0HqdIrRwv8w0e0
	 iwgdthrbLcxaT5y8K+sdC8p/vAfzB1hq2m6N8fGEZIGRZZz2pKxGTGuhH2qvUv0TaZ
	 0p3Bb3T9Lzf+pRMbUhEpVGK+BmPEb6S79gmWFtxWZcdJiODAMZc8lIJMYLMMe6tnfK
	 zp+OfZK4GtpqjkM+o0W+yL6Za6cjXwGzzWZKfjhohPbDyPAs/aWSGpez9IA1smI0tl
	 LNe6GzCKRCPyT8TzVkqzAO0FJpDZcEJHVLIdWoxV2IcZFlc1W0bSUhUGqqP/vmzQ+T
	 RYaXj4jhZIepA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Jonathan McDowell <noodles@meta.com>,
	Ross Philipson <ross.philipson@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 5/8] tpm-buf: Merge TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW
Date: Sat,  3 Oct 2026 21:39:59 -0400
Message-ID: <20261004012400.1311672-5-sashal@kernel.org>
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

[ Upstream commit 0b9551c189518544b65000a234277298e931c8f3 ]

Merge TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW flags into
the TPM_BUF_INVALID flag, as their behavior is identical (the only
difference being the associated log messages).

Message-ID: <20260125192526.782202-11-jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
Reviewed-by: Jonathan McDowell <noodles@meta.com>
Signed-off-by: Ross Philipson <ross.philipson@gmail.com>
Stable-dep-of: 9b522400bf5c ("tpm: fix off-by-four bounds check in tpm2_get_random()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/char/tpm/tpm-buf.c                | 10 ++++------
 include/linux/tpm.h                       |  8 +++-----
 security/keys/trusted-keys/trusted_tpm2.c |  6 +++---
 3 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/char/tpm/tpm-buf.c b/drivers/char/tpm/tpm-buf.c
index 4c4f450630dfe..61833b4d81f03 100644
--- a/drivers/char/tpm/tpm-buf.c
+++ b/drivers/char/tpm/tpm-buf.c
@@ -103,13 +103,12 @@ EXPORT_SYMBOL_GPL(tpm_buf_length);
  */
 void tpm_buf_append(struct tpm_buf *buf, const u8 *new_data, u16 new_length)
 {
-	/* Return silently if overflow has already happened. */
-	if (buf->flags & TPM_BUF_OVERFLOW)
+	if (buf->flags & TPM_BUF_INVALID)
 		return;
 
 	if ((buf->length + new_length) > PAGE_SIZE) {
 		WARN(1, "tpm_buf: write overflow\n");
-		buf->flags |= TPM_BUF_OVERFLOW;
+		buf->flags |= TPM_BUF_INVALID;
 		return;
 	}
 
@@ -176,14 +175,13 @@ static void tpm_buf_read(struct tpm_buf *buf, off_t *offset, size_t count, void
 {
 	off_t next_offset;
 
-	/* Return silently if overflow has already happened. */
-	if (buf->flags & TPM_BUF_BOUNDARY_ERROR)
+	if (buf->flags & TPM_BUF_INVALID)
 		return;
 
 	next_offset = *offset + count;
 	if (next_offset > buf->length) {
 		WARN(1, "tpm_buf: read out of boundary\n");
-		buf->flags |= TPM_BUF_BOUNDARY_ERROR;
+		buf->flags |= TPM_BUF_INVALID;
 		return;
 	}
 
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 3630b2ea6aefa..3c6a5bcc138a0 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -201,12 +201,10 @@ enum tpm_chip_flags {
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
 
 enum tpm_buf_flags {
-	/* the capacity exceeded: */
-	TPM_BUF_OVERFLOW	= BIT(0),
 	/* TPM2B format: */
-	TPM_BUF_TPM2B		= BIT(1),
-	/* read out of boundary: */
-	TPM_BUF_BOUNDARY_ERROR	= BIT(2),
+	TPM_BUF_TPM2B		= BIT(0),
+	/* The buffer is in invalid and unusable state: */
+	TPM_BUF_INVALID		= BIT(1),
 };
 
 /*
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 70913da617631..ec8dc00f84e29 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -313,7 +313,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	/* creation PCR */
 	tpm_buf_append_u32(&buf, 0);
 
-	if (buf.flags & TPM_BUF_OVERFLOW) {
+	if (buf.flags & TPM_BUF_INVALID) {
 		rc = -E2BIG;
 		tpm2_end_auth_session(chip);
 		goto out;
@@ -329,7 +329,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out;
 
 	blob_len = tpm_buf_read_u32(&buf, &offset);
-	if (blob_len > MAX_BLOB_SIZE || buf.flags & TPM_BUF_BOUNDARY_ERROR) {
+	if (blob_len > MAX_BLOB_SIZE || buf.flags & TPM_BUF_INVALID) {
 		rc = -E2BIG;
 		goto out;
 	}
@@ -443,7 +443,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 
 	tpm_buf_append(&buf, blob, blob_len);
 
-	if (buf.flags & TPM_BUF_OVERFLOW) {
+	if (buf.flags & TPM_BUF_INVALID) {
 		rc = -E2BIG;
 		tpm2_end_auth_session(chip);
 		goto out;
-- 
2.53.0

