Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3F010F2;
	Thu, 27 Aug 2026 06:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787811593; cv=none; b=s7TmnjoqjRT48nGo0AeVGKmYaS1SxRiPcpnvnTrTSfn1avxJ5KbhmZYmuBgZ4gPCnQUIPNLj9zKI1Xjvj2BiJrg6WPdiExG8ySAj6O4h9A3oOevNiUNR7Jn368SskDwMqexE7iKtpndUQt/gFM52GpMtKOOiiyshDJXm/grr120=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787811593; c=relaxed/simple;
	bh=tqdSVh4tu+sKz//fnE52AFmGPHLUgoLrEkCNCDhMouU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=imeUR9wc6nbsS0B9bRUBQOxhbMUrt5k1nCfjv6zNri/YBNeiX22Q/jCMjdXcwoS9fr1eUjkORNBNktqUrcYXV+2CKjzoSho78RxBjSEowjGk2QusXiImtXOuK8xRLVxSSOQ9BlRla0sVeh6YUt9mPnZQ3kgZSKCxOQtqeSnchpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=iUMQVvvP; arc=none smtp.client-ip=162.62.57.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="iUMQVvvP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787811586; bh=ol9NWem2Kbehyx9Cpgz703s0E0cEuzeYR/vj23Pm2yA=;
	h=From:To:Cc:Subject:Date:Reply-To;
	b=iUMQVvvPDwhzsQVEbbV4CM7BKHCmZFKZfacilwNY6ryb6RJNdqdUIqxeyXvwV7Imq
	 AfOlkQ2TWLPQ2jeRR/fj3GVJ7sRNsSRBVbNfTmSFRX0xcAj6YtUTVqJ5e+0j5yS+9m
	 f+UDzrJFie1nI1OL9IoypfyX+/I52+qe7PpXD5qI=
Received: from DESKTOP-5664AH9 ([14.153.63.166])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 4EC36EB3; Thu, 27 Aug 2026 14:19:44 +0800
X-QQ-mid: xmsmtpt1787811584tas27j7c7
Message-ID: <tencent_7C3B122A153CDB0DEF19FA4C03D779D27806@qq.com>
X-QQ-XMAILINFO: NuBH63TBO+hCKmpKlYto7mny4Qs4fI/CZ58+P0XpukQyw7lrCB01B2cPJuCqh7
	 NW/gf29k6+iKNIaW131oNH4AVTEnEyQH4d/Wr15aRVImlG97AQpFR6TFp1hkMMZ+0BZ+pVXWFBCg
	 32t+en+YP5vjVu0uwx+WwypLAFV7dwq8htyriUEbgZWmhbP6ZefmhjXH9L0kqgmh/7jTobtOK17H
	 JT3/qwKfuZjz7SMVSrfMCdLiUYSbh//6mOmlMea7MYK41HfKM0c8XKmIh2GTBVDrZeML5l/Icwro
	 9mA2yDlQiEhVvl/uykAvUY+odWZ/XAy4sqKZekULjlCmbVGzKCxMhR6AFt6LeOgbK647KV+h0u7S
	 WTS1wOgvh2/jQ7aW9ZjntV3ptE1pcnaMYOvlL18/IqY+cxnqyiS7mcNTxxSzJlhU4/sRuXuci5N3
	 RU2NAn/VU8UF9e2XgKIM/BfUopOM77Q7AbxPVgbz2bXxmPPCsRURLanTS+6UM9rX4ACjGhicYFxN
	 O5br+sKsZOuIsyLnuCe/F2UpQpzRe1AO/q0iQjwZkmRowZ6dBfFdQUL9QY6JcvG3LALfsGIolv5P
	 X3NoWP9f37lQbREMZeXQOplxnLIclPxEW/6O/FN3BSWslktiZamifpMI2/MuOCdBD1ZO7FX9hy7p
	 q48ulicPp8pYkjhMcaRBcCn/qC9e72UbSas8D0vchGrf60X1FLK0xedgpAxVFHpQRHx0PioeGGFE
	 G90tEp1vfv24Xz2aSV8HHyPd8eZDxhpYOCYEH8J4PCADxLkRdy44ZRSRjqlfjHb7O+O1/6xZbpB2
	 ddsvrFf5LgAaQ7ReV8ToB0w9JLRvvlA58rwRP6hz9IC8SwPNYRvQW+Vef4MU3chFQJF9GF3stL5W
	 rw0cmXCDijx9oCEIIAxpJTGTA0NVieZRom2L/ReUEHa/cmgFb2ywTJK7Bj+7KVWJ2ab/Ovjp2MQU
	 79gU7t7InSGJY5WNsdMdiU3G6jPS9O3Ay7x+tK56ZUmCHVTRtKfgdgP+w5kbsMed7l0t7Azb+/bD
	 lpu+Al5Lz0/0EmdWiP10zW9vZBKQauYZwtEgtzO9F3/OMqIXJpThm4IrjLSKPipQg/0DcKejS2GD
	 lVzvz4z3vl/Kivv1K7U5sCTUdEqC6fr9FkSwfwiq3/fZu2dHv1dFEs9M6nMuAYpkpN5Vt9E618YJ
	 fTTW2KD+tfg/DExEEB3Lvco5bZDxTOV8cRvxcscaJfimweD4EID06an6/b
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: =?UTF-8?q?DUAN=20Xuejian=20=28=E6=AE=B5=E9=9B=AA=E5=81=A5=29?= <445735441@qq.com>
To: greg@kroah.com
Cc: linux-acpi@vger.kernel.org,
	hansg@kernel.org,
	rafael.j.wysocki@intel.com,
	stable@vger.kernel.org,
	DUAN Xuejian <445735441@qq.com>
Subject: [PATCH] ACPI: resource: Add MECHREVO GM5BG0E to irq1_edge_low_force_override[]
Date: Thu, 27 Aug 2026 06:19:45 +0800
X-OQ-MSGID: <20260826221945.1338-1-445735441@qq.com>
X-Mailer: git-send-email 2.55.0.windows.3
Reply-To: greg@kroah.com
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The MECHREVO Jiaolong 15K (GM5BG0E), an AMD Ryzen 7 7435H based laptop,
has a defective DSDT that declares the PS2K keyboard IRQ1 as ActiveLow,
whereas the hardware is actually ActiveHigh. Starting with Linux 6.0,
the kernel no longer auto-corrects this polarity mismatch on AMD Zen
platforms, causing the internal keyboard to become non-functional.

Add the GM5BG0E board to the irq1_edge_low_force_override[] DMI quirk
table so that the kernel forces the correct IRQ polarity for this model.

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=XXXXXX
Link: https://lore.kernel.org/linux-acpi/XXXXXX@XXXXXX
Cc: All applicable <stable@vger.kernel.org>
Signed-off-by: DUAN Xuejian (段雪健) <445735441@qq.com>
---
 drivers/acpi/resource.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.49.0

diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index xxxxxxx..xxxxxxx 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -xxx,x +xxx,x @@ static const struct dmi_system_id irq1_edge_low_force_override[] = {
 		},
 	},
+	{
+		/* MECHREVO Jiaolong 15K GM5BG0E */
+		.matches = {
+			DMI_MATCH(DMI_BOARD_NAME, "GM5BG0E"),
+		},
+	},
 	{ }
 };
 
-- 
2.49.0

---

# 中文版补丁说明

## 问题描述

MECHREVO 蛟龙15K (GM5BG0E) 搭载 AMD Ryzen 7 7435H 处理器，其 BIOS DSDT 表中存在错误：
键盘 IRQ1 被声明为 ActiveLow（低电平触发），但硬件实际为 ActiveHigh（高电平触发）。

从 Linux 6.0 内核开始，AMD Zen 平台不再自动修正此极性不匹配问题，导致内置键盘无法使用。

## 修复方案

将 GM5BG0E 主板添加到内核 `irq1_edge_low_force_override[]` DMI 兼容表中，
使内核为该型号强制使用正确的 IRQ 极性。

## 提交信息

- **维护者**：Hans de Goede <hansg@kernel.org>
- **邮件列表**：linux-acpi@vger.kernel.org
- **抄送**：stable@vger.kernel.org（用于稳定版回溯）

---

# English Version - Patch Description

## Problem Description

The MECHREVO Jiaolong 15K (GM5BG0E), equipped with AMD Ryzen 7 7435H processor,
contains a defective BIOS DSDT table. The PS2K keyboard interrupt (IRQ1) is
declared as ActiveLow in the ACPI table, but the hardware is actually wired
for ActiveHigh operation.

Starting with Linux 6.0, the kernel no longer automatically corrects this
polarity mismatch on AMD Zen platforms (commit 2d331a6ac481), causing the
internal keyboard to become non-functional.

## Solution

Add the GM5BG0E board name to the irq1_edge_low_force_override[] DMI quirk
table in drivers/acpi/resource.c. This forces the kernel to apply the correct
IRQ polarity override for this specific hardware model.

## Technical Details

- **File modified**: drivers/acpi/resource.c
- **Function affected**: acpi_dev_irq_override()
- **Quirk table**: irq1_edge_low_force_override[]
- **DMI match**: DMI_BOARD_NAME = "GM5BG0E"

## Testing

Verified on MECHREVO Jiaolong 15K with:
- AMD Ryzen 7 7435H
- BIOS N.1.23MRO20
- Linux kernel 6.x

After applying this patch, the internal keyboard functions correctly.

## References

- Similar fixes: GM6BGEQ, GM6BG5Q, GM6BG0Q (TongFang barebones)
- upstream commit: 2d331a6ac481 ("ACPI: resource: Fix IRQ override quirk")

