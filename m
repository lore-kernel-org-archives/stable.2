Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6D1383994;
	Tue,  1 Sep 2026 20:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788296298; cv=none; b=N907j3oCOOgiifVnrtfo9jLM989fapsYm9iZrPMEOBKJwvM6y2xlBs6qtl7XSfMsG2zjoVYi9/CM2qG39IHaZPlYlzVD9U9XxFrcX02v4qPysnp89HDENdfXI0JTW5OKkuH7lRWbsuvxQbuBPFOWSzruCG7bbF/I7yb25yAujlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788296298; c=relaxed/simple;
	bh=XwRCKHVp10ID8xYE1dVM9CVX5ALnXbCrJAcU78wXc5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fdATYwCg4A6k+UecQtjWp5hj5BBwXpWWvxZcx8K86c5ryyo2Mqp74TdpArqej25yJfaLfsK2AkeNL/rHmFOEM09tRx95b3V+XFZrXsIDXLngJ9Eq69ek4htBllyCZnVLnnipMRZAFmdM4JZP5mKRZQRz6IN/QnhprDdla8Mncn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHQghr8h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHQghr8h"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A8B0E1F000E9;
	Tue,  1 Sep 2026 20:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788296296;
	bh=wlJPEe39WmavK2sNL398qv9Unw3EKaaOF3Vm6DfuKzY=;
	h=From:To:Cc:Subject:Date;
	b=aHQghr8hAhKm+FsutTE59BANpL9L04FsiuLncO3XHYw9TWEZF0KR6lJVEDxLHkdDY
	 ZY8zELS0XulYmxsYz9IVyAtXEODLzjj1RHaqbYXScjsxKgQutkWrBSH8a3ypresa0e
	 DYie0H8c5ZbhWnCt92TC+G17r8MkqJYeF21pjbZlQRPxwBGMxX8aHIB5CzJVyFFKGJ
	 JAnsHclXO2uVmHt/Pc0F+b636MEYA4TjQeVZHFnU2Ums13qHlewrSYfyB7Gl52yTXt
	 u975ryVkpNhKgg8+4xGGyKl3cI0r0nb+dYHslBbNCHn1OOQKgptBd2EO9eVcjaH5aZ
	 SlTLwIbZO9J2w==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	stable@vger.kernel.org,
	co+6a581c4284f721d4@bugs.sh,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan McDowell <noodles@meta.com>,
	Ross Philipson <ross.philipson@gmail.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Srish Srinivasan <ssrish@linux.ibm.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KEYS: trusted: Fix tpm2_load_cmd() boundary check
Date: Tue,  1 Sep 2026 23:58:06 +0300
Message-ID: <20260901205809.2028454-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm2_load_cmd() does boundary checks against the ASN.1 size i.e.,
payload->blob_len. Address this by passing the decoded blob size to
tpm2_load_cmd(), and use it for the boundary checks.

Cc: stable@vger.kernel.org # v5.13+
Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
Reported-by: co+6a581c4284f721d4@bugs.sh
Closes: https://bugs.sh/b/6a581c4284f721d4/
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/trusted-keys/trusted_tpm2.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 67225dd562a9..01f18bb37047 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -99,7 +99,7 @@ struct tpm2_key_context {
 
 static int tpm2_key_decode(struct trusted_key_payload *payload,
 			   struct trusted_key_options *options,
-			   u8 **buf)
+			   u8 **buf, unsigned int *blob_len)
 {
 	int ret;
 	struct tpm2_key_context ctx;
@@ -120,6 +120,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
 		return -ENOMEM;
 
 	*buf = blob;
+	*blob_len = ctx.priv_len + ctx.pub_len;
 	options->keyhandle = ctx.parent;
 
 	memcpy(blob, ctx.priv, ctx.priv_len);
@@ -384,10 +385,11 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	int rc;
 	u32 attrs;
 
-	rc = tpm2_key_decode(payload, options, &blob);
+	rc = tpm2_key_decode(payload, options, &blob, &blob_len);
 	if (rc) {
 		/* old form */
 		blob = payload->blob;
+		blob_len = payload->blob_len;
 		payload->old_format = 1;
 	} else {
 		/* Bind for cleanup: */
@@ -399,17 +401,17 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 		return -EINVAL;
 
 	/* must be big enough for at least the two be16 size counts */
-	if (payload->blob_len < 4)
+	if (blob_len < 4)
 		return -EINVAL;
 
 	private_len = get_unaligned_be16(blob);
 
 	/* must be big enough for following public_len */
-	if (private_len + 2 + 2 > (payload->blob_len))
+	if (private_len + 2 + 2 > blob_len)
 		return -E2BIG;
 
 	public_len = get_unaligned_be16(blob + 2 + private_len);
-	if (private_len + 2 + public_len + 2 > payload->blob_len)
+	if (private_len + 2 + public_len + 2 > blob_len)
 		return -E2BIG;
 
 	pub = blob + 2 + private_len + 2;
-- 
2.47.3

