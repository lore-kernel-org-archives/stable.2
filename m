Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795113328;
	b=VibWfMg3NgYdmNIRmKx6gCLkK09rGmVf1S2atEUp7sHFJzg2YhGLP876et4tj7hDBrEj
	 Q5RCOTOgAtvH5Y9EAIv86HJgegE/FzIf+ClmAfeTizvq/MjDVj88YsjhET/wu76dEibtf
	 tVutEMsl4HfaE7q5qqMxMLA/FRKEwZG3bt1tpan8w966q3h8fsssyKLEhXwYIa5k33l+L
	 SNZ1ElJE0b+ZY6j3EVvozfAmCxdvFe6Zq+lkHSEHl+Vt+Y2/d7JEPKjZO8WZc4y9Fahwx
	 p26dlKQcFt0SM1FuzMC2bwLIdJG8ueqmQYR35hlqrGo9CCHSsSzXcyWJfCuVZIMr0PQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795113328;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QnZ+p1swNdzA0fWsdaVxUGvKn+58FxkU5Hx8GSDOHNs=;
	b=hVjgjGgmEsgUcLqVrO0JBh3euHWpBtPa5lwsbZxapYqa6DaadThpGjVqHgvubxDOLMUq
	 7EGf4f4yJ2N17h1tDZDJXQD/MndXiSViv9VFzORa/nEZnw9l7zq1wzQMVgYETzGA1YfAh
	 FdaH/Q5xgBmFlqajSM/QUZsRfxBXuiwgD3EbhGRgRpJ75GXmXyMT6bVVGAOl8cfERi7Yx
	 QjAvKmziaPDy+87vkMHUABfAqgYkI54Ia8zV5ckEEeQxjpjbEo/B01/ZrsCzRdoqXzNgV
	 ckkobIjwIiccLdIPvhh7KVBhFtmkzEXpMJMqVsIaujGxx9AA35no/hZKhrq6Rxe+8eA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=boKp0Iqn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C995860A2609;
	Thu, 19 Nov 2026 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=boKp0Iqn
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795113328;
	b=ea0+dlfXeQ0XMn6+FnTAWYry4aPn64OhFC9zGw84Aj24ufPgDXHzNa4wB9tGhEm2dD8n
	 uGjxuW//rQNA3rOmuesrEsN5o4wd092+6EDWjQUjCbB06FIeq+ATRC3h6jkyACj6p3a6k
	 npuGXtIeeO21uZ/Rf8TPv/c+EesbVq0y3DhQ2Rzv8Z2cyrBElB46wRNkkQ0DqKUe6TZ0b
	 sI659w7FPKLOkLYTQ3qG+88LApgds4KTh5qg9tMSzK79rMNthAILag5UYL/EIoyuZ194M
	 xqGj1fp1tlFxCgEXTUO9ql3THlhRBwmcglVTKoWLn1NgWU0TwUJxmhZn/3a/eMimqfw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795113328;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QnZ+p1swNdzA0fWsdaVxUGvKn+58FxkU5Hx8GSDOHNs=;
	b=urP1k2o/Av2Au1c98yfZHTgHoo5N7BrOGjn+h+8g3DSHkc0TDyf0NXy4SeoK55cEruAN
	 3P+bMka2cI0WLh964B69cXt+ZAYb5Giir3Ub33dRet93JSVikSys+vd/iwdshs2S82vds
	 aUKuOUdUpziXGg1SQXumEwbQkoKxOh6tJXqEwRhvmGaOjKbhdNaJB/m7vl+Za/hk2KpQF
	 7H7iSFLcSvDlcGZbtTtotnHD8UA1edeefkDkq4Jhw+WZ7pv11KiOy8DX9jEbcNYJuUW4h
	 0Q/CgZTkTlTuXZSyTgTryjkw6E7AMfhMj31dbfO+FUuymJLLZgmN76RdRU9YRXmPo9g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 05E4A1F000CA;
	Thu, 19 Nov 2026 18:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795113328;
	bh=QnZ+p1swNdzA0fWsdaVxUGvKn+58FxkU5Hx8GSDOHNs=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=boKp0Iqn3RGduRp53tcuwF4nYGfLsk6qrKFMIowbGpdmd6DyDESMNziWR0snn8IUJ
	 wsbBb3uj/rJxYRB7ANpe3LbnfRAIAS6y/Wh+JFk6/QQOg1Q9qertBKVjE8W6m7sB3e
	 aa4N4bU2FTExEAPPrs+Bm7dlQlGsnOQZERuq9CZeURXjr8kWih0IVin4NnGJs1ZykN
	 FrBWiQnrduAo2ZXnV0EtbbZFy52Awzoe8K/sHkCMJKDcqcqqJVOHYywUEAV6aMxwOh
	 Bk9ZiMlESSS4muA70wVpXGkbfib5HPQLAAoj+u5KN1t/l/KMx6Djv16zPKUPj8rxGI
	 sQ6Zm8UC9JE5w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8C88C4B3C0;
	Thu, 19 Nov 2026 18:35:27 +0000 (UTC)
From: Ahmed Abdelfattah via B4 Relay <devnull+me.ahmedabdelfattah.dev@kernel.org>
Date: Thu, 19 Nov 2026 20:35:25 +0200
Subject: [PATCH] ACPI: APEI: Don't disable HEST for a disabled IA-32 CMC
 structure
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261119-acpi-hest-cmc-disabled-v1-1-87644a1bf0ca@ahmedabdelfattah.dev>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDtgIlXrVYqLZDLWKa1KRkUQ7
 95ol2/x/w7KUVihyXaIvIrKOCSYWwbUu+HFKCEZbG5LY8wDHU2CPeuM9CUMos5/OGAgV1Tlvau
 tryHFU+ROtmv8bP/Wxb+Z5vMGx/ED4XwbL3oAAAA=
X-Change-ID: 20261119-acpi-hest-cmc-disabled-dca3765f82b8
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, 
 Hanjun Guo <guohanjun@huawei.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Shuai Xue <xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, 
 Will Deacon <will@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ahmed Abdelfattah <me@ahmedabdelfattah.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795113327; l=2913;
 i=me@ahmedabdelfattah.dev; s=20261106; h=from:subject:message-id;
 bh=tT5kjIxpoyje3RI718C4NeyvvkC2yB2rkjIZMzaQ/gs=;
 b=DU7PcSDgrwAM011pR5s8vkBX9zEaLMl9JFtCT393FbK3ZkuiuosNuZnn4fhM6SckqGcdVHoJd
 YqjzT/HskosDNPbD9y7pts1YxsN5tG16XFKJsVcqDBgkL3PFbUUEqYn
X-Developer-Key: i=me@ahmedabdelfattah.dev; a=ed25519;
 pk=DHEHKU4PddrkJ/iYMZpwyyXsFyIQ6ySjTttKLrt9YqI=
X-Endpoint-Received: by B4 Relay for me@ahmedabdelfattah.dev/20261106 with
 auth_id=1438
X-Original-From: Ahmed Abdelfattah <me@ahmedabdelfattah.dev>
Reply-To: me@ahmedabdelfattah.dev
Content-Transfer-Encoding: 7bit

From: Ahmed Abdelfattah <me@ahmedabdelfattah.dev>

On x86, a HEST whose IA-32 Architecture Corrected Machine Check
structure has Enabled = 0 makes acpi_hest_init() give up on the whole
table. hest_disable is set to HEST_DISABLED, no GHES device is
registered, and every other error source in the table is ignored. The
only trace of it is "GHES: HEST is not enabled!".

arch_apei_enable_cmcff() returns 0 for a disabled structure and 1
otherwise. hest_parse_cmc() returns the negation, so a disabled
structure stops apei_hest_parse() with 1, which acpi_hest_init() takes
as an error. Enabled = 0 is a valid value: ACPI 6.5, Table 18.5, says
that the error source is then not to be enabled. It does not make the
table invalid.

Before commit 9f9a35a7b654 ("ACPI / APEI / ARM64: APEI initial support
for ARM64"), the result of this walk was ignored. That commit inverted
the callback's return value and started checking the result.

There is nothing to report from hest_parse_cmc(), and the spec allows
only one structure of this type, so ignore the return value of
arch_apei_enable_cmcff() and let the walk go on.

Fixes: 9f9a35a7b654 ("ACPI / APEI / ARM64: APEI initial support for ARM64")
Cc: stable@vger.kernel.org
Signed-off-by: Ahmed Abdelfattah <me@ahmedabdelfattah.dev>
---
I hit this with a hand-built HEST in a QEMU guest: clearing Enabled in
its IA-32 Corrected Machine Check structure also took away the generic
error source next to it.

Tested on v7.4-rc3+ (4405c18c95d2) with a HEST loaded through
-acpitable that holds two error sources, an IA-32 CMC structure
(FIRMWARE_FIRST, bank 8) and a polled GHESv2:

  CMC structure   without the patch               with it
  Enabled = 1     HEST initialized, "Enabling     the same
                  Firmware First mode for
                  corrected errors", GHES.1 bound
  Enabled = 0     "GHES: HEST is not enabled!",   HEST initialized,
                  no GHES device                  GHES.1 bound
  Enabled = 0,    HEST initialized, GHES.1        the same
  acpi=nocmcff    bound

Every boot also prints "GHES: Failed to enable APEI firmware first
mode", because the guest's firmware has no APEI _OSC; that is the same
with and without the patch.
---
 drivers/acpi/apei/hest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/hest.c b/drivers/acpi/apei/hest.c
index 20d757687e3d..881dd0b25939 100644
--- a/drivers/acpi/apei/hest.c
+++ b/drivers/acpi/apei/hest.c
@@ -185,7 +185,7 @@ static int __init hest_parse_cmc(struct acpi_hest_header *hest_hdr, void *data)
 		return 0;
 
 	if (!acpi_disable_cmcff)
-		return !arch_apei_enable_cmcff(hest_hdr, data);
+		arch_apei_enable_cmcff(hest_hdr, data);
 
 	return 0;
 }

---
base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
change-id: 20261119-acpi-hest-cmc-disabled-dca3765f82b8

Best regards,
--  
Ahmed Abdelfattah <me@ahmedabdelfattah.dev>


