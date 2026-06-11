Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69273215075;
	Thu, 11 Jun 2026 03:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.75.144.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781149693; cv=none; b=rDJG1QCy1mmTPd2qX7cUfyU1+MUZNhhWfo3APwmwHV4Sv9ZDO120QeQEFzMOba4kJagdCD6AxTjIXoRlLYeHEQAUVYDCX1la/76o2iX7vnb21w5ffjrr4xUSp6Z1WAMpGi5EecipUXOibtHV2TXnF0EJvfbAYS02/As/+OU061U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781149693; c=relaxed/simple;
	bh=0uGCT1Kc2NxDdy8bTsOui18h4pRTL4+6YYZ70jx2g3w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=c3Ql10kR7vJxFd90bjKwXNhyA7R0toc997J2ALWD2Qj5jXPK41zvbTWQidwvyNia31vqft4fpPmSLyfUrd9ztrVNwKlLGvyGHK/1EvS71VUPoJp0k74GRnOhzKuC7ABA+Vd5svmN96SlIgn063+unZvaDkX4QJ2dhbY6a6I1aDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org; spf=pass smtp.mailfrom=mainlining.org; dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=FAud0Rfb; dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b=LUPx9Kfn; arc=none smtp.client-ip=5.75.144.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mainlining.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mainlining.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="FAud0Rfb";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="LUPx9Kfn"
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1781149627; bh=Z4pxYkTJFG5ZwHLzZDKYz0g
	IuL/SlRTVttv6cDMB0rk=; b=FAud0RfbPy8KAWfNAh03l1eAQ+Y3tjy31zYTkmYLSPtRmX12kA
	ZPA7xuy2EfYZW1H6O+doSYTD2N6q1g7Zpf87ROCXQEA4d3n4ywGclFc1ZzQL8946IK+fMjHmMt+
	HNLeybiUZD4FVDOB5tYXeXnuKv3NHOdLRO3gWfs34Bh6n5NQEiD0JBR5mGXPvbrbkOKWfZHlplL
	v7CFI2hwU/39q3hv753lUU+uNR9wMFULX3txywkP18KsoiIUQCpzcNLzTgberNZBfI8/TQDM8rf
	5HnSI8kut5Br3qiL48V61G908Ff7k6hq3Tik76rBpiSgIQnd5pwsmlaX649a83dh6Fg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org; c=relaxed/relaxed;
	h=To:Message-Id:Subject:Date:From; t=1781149627; bh=Z4pxYkTJFG5ZwHLzZDKYz0g
	IuL/SlRTVttv6cDMB0rk=; b=LUPx9KfnvGjLyeWsrXc4y9NPKk3T1yj8fkEyfN/Rqh6BhqZaaT
	Wh/uIfJXELI8fESoIkKertjqDx0nU4dE00DQ==;
From: Aelin Reidel <aelin@mainlining.org>
Date: Thu, 11 Jun 2026 05:46:48 +0200
Subject: [PATCH RESEND] nvmem: apple-spmi-nvmem: wrap regmap calls to
 satisfy CFI
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-apple-spmi-nvmem-cfi-v1-1-9dd90938ef4a@mainlining.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM0ND3cSCgpxU3eKC3EzdvLLc1Fzd5LRMXTNz4xRToJI081QTJaDWgqL
 UtMwKsLHRSkGuwa5+LkqxEPHi0qSs1OQSkJlKtbUAmvjB0oAAAAA=
X-Change-ID: 20260611-apple-spmi-nvmem-cfi-673d5202f7e4
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, Srinivas Kandagatla <srini@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Finkelstein <k@chaosmail.tech>, Hector Martin <marcan@marcan.st>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Aelin Reidel <aelin@mainlining.org>, 
 Clayton Craft <craftyguy@postmarketos.org>, stable@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781149627; l=2799;
 i=aelin@mainlining.org; s=20260503; h=from:subject:message-id;
 bh=0uGCT1Kc2NxDdy8bTsOui18h4pRTL4+6YYZ70jx2g3w=;
 b=1gdAEe0bFpeBdIolOAe2ZPjRNOrjlsjGo8imSin1FxB5ARqUSIFeTVKpEpJSNFuTL01etdWCh
 rXrtod7tIFHDmeR6O9yu49zLOMQkiA9hi+ms5O3P+WS3SZsK085bCOK
X-Developer-Key: i=aelin@mainlining.org; a=ed25519;
 pk=JdivYHq/vT1Z1DpBeadmJbY/Fi5Ab9P/C35KYCOezfA=

The Apple SPMI NVMEM driver previously cast regmap_bulk_read/write to
void * when assigning them to nvmem_config's reg_read/reg_write
function pointers.

This cast breaks the expected function signature of nvmem_reg_read_t
and nvmem_reg_write_t. With CFI enabled, indirect calls through
these pointers fail:

  CFI failure at nvmem_reg_write+0x194/0x1e4 (target: regmap_bulk_write+0x0/0x2c8; expected type: 0x83a189c3)
  ...
  Call trace:
   nvmem_reg_write+0x194/0x1e4 (P)
   __nvmem_cell_entry_write+0x298/0x2e8
   nvmem_cell_write+0x24/0x34
   macsmc_reboot_probe+0x1dc/0x454 [macsmc_reboot]
  ...

Introduce thin wrapper functions with the correct nvmem function
pointer types to satisfy the CFI checks.

Fixes: fe91c24a551c ("nvmem: Add apple-spmi-nvmem driver")
Signed-off-by: Aelin Reidel <aelin@mainlining.org>
Reported-by: Clayton Craft <craftyguy@postmarketos.org>
Tested-by: Clayton Craft <craftyguy@postmarketos.org>
Reviewed-by: Sven Peter <sven@kernel.org>
Cc: stable@vger.kernel.org
---
Difference vs the original patch:
- Updated my name and email
- Picked up Sven's R-b
- Link to original: https://lore.kernel.org/all/20251118-apple-spmi-nvmem-cfi-v1-1-75b9ced0a2c2@mainlining.org/

It's been half a year, so I figured I'd gently poke for this to be
applied.
---
 drivers/nvmem/apple-spmi-nvmem.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/apple-spmi-nvmem.c b/drivers/nvmem/apple-spmi-nvmem.c
index 88614005d5ce..7acb0c07d6ab 100644
--- a/drivers/nvmem/apple-spmi-nvmem.c
+++ b/drivers/nvmem/apple-spmi-nvmem.c
@@ -18,6 +18,22 @@ static const struct regmap_config apple_spmi_regmap_config = {
 	.max_register	= 0xffff,
 };
 
+static int apple_spmi_nvmem_read(void *priv, unsigned int offset, void *val,
+				 size_t bytes)
+{
+	struct regmap *map = priv;
+
+	return regmap_bulk_read(map, offset, val, bytes);
+}
+
+static int apple_spmi_nvmem_write(void *priv, unsigned int offset, void *val,
+				  size_t bytes)
+{
+	struct regmap *map = priv;
+
+	return regmap_bulk_write(map, offset, val, bytes);
+}
+
 static int apple_spmi_nvmem_probe(struct spmi_device *sdev)
 {
 	struct regmap *regmap;
@@ -28,8 +44,8 @@ static int apple_spmi_nvmem_probe(struct spmi_device *sdev)
 		.word_size = 1,
 		.stride = 1,
 		.size = 0xffff,
-		.reg_read = (void *)regmap_bulk_read,
-		.reg_write = (void *)regmap_bulk_write,
+		.reg_read = apple_spmi_nvmem_read,
+		.reg_write = apple_spmi_nvmem_write,
 	};
 
 	regmap = devm_regmap_init_spmi_ext(sdev, &apple_spmi_regmap_config);

---
base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
change-id: 20260611-apple-spmi-nvmem-cfi-673d5202f7e4

Best regards,
--  
Aelin Reidel <aelin@mainlining.org>

