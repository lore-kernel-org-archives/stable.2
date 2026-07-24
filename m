Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26FB471422;
	Fri, 24 Jul 2026 22:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784932454; cv=none; b=dLskzhZwJBxXZYK9t4j36sE/+ttU3/Hin5VY6PnIsk9PEx15yaIZs1lNJImumRVDCqEeT0SXjzb+u8sxCA7fD6IiO8zBrjyBM5U7SXJeyoi1iehVtRLE11u+o7ELHOiOduGtpBgKGtJiJUvkyRrKeqP+/ioVlNjeOekVvka2rtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784932454; c=relaxed/simple;
	bh=vKuujdECK4+xyXh5K4tZoG15T7hz01YmNGrRcYYT2os=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDXaPfqk3sHIuV1bYbHiUV7cwE3bfLBbnyZ6GoGoSdl77chDwyCDVt5WDVtQL3tclJAcOeP+eO5Tp0yoc+yL4dMateAu6QX70f0DKfAikO5ViqgTfn1Ay2CXbhGMglvnoPc4RtHWCBSABW1zxqQDBWYex/gr6Rd2zzUHMQ/9oFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJrxKwPz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJrxKwPz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C654F1F00A3A;
	Fri, 24 Jul 2026 22:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784932453;
	bh=NuwlWqlfln/6ADt6yt5wjRVNKYN8wGi3RAM9EoVYeBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jJrxKwPzSMgsYeVhsrBa06IAH73OpHPujAbffnv8LLo/j70SrDiobR7Ke8ndK8/yg
	 FmyU4xe5afkCmOHamVRqE2x7A9CFG3uRVIqIVfOqeAyNXvDPxZ3LQ2FQC/4PmTN+wj
	 0kMwktdq7DirIaF5wWv5cdNI9bnFl4yYLZN1Hmg010fbaoABU3pDnCFDFwLEsuQ2Xq
	 x+87LoXcpOd1l0QP1aV/MCXidAngqJ5DFFai5vjJd79EXPeac3Ayp1Tg4ocIC8QgaI
	 4BasSlF84OucM62TGVRSxcmmcdb7Nb8UNqfry3/ydQJcMlZpWT4SrsnDB4QtZqtRrL
	 y5582HJBe4wSQ==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Aelin Reidel <aelin@mainlining.org>,
	Clayton Craft <craftyguy@postmarketos.org>,
	Sven Peter <sven@kernel.org>,
	stable@vger.kernel.org,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 1/2] nvmem: apple-spmi-nvmem: wrap regmap calls to satisfy CFI
Date: Fri, 24 Jul 2026 23:34:03 +0100
Message-ID: <20260724223404.629248-2-srini@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724223404.629248-1-srini@kernel.org>
References: <20260724223404.629248-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aelin Reidel <aelin@mainlining.org>

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
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
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
-- 
2.53.0

