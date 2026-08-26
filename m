Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BEC3446CB;
	Thu, 27 Aug 2026 06:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787810468; cv=none; b=QslaJ7HOVPSd5q2I16UKkNsdM+YWEb+UyVwTdiDw/37939GqqWHXlFH8cDOEjX2Rzl6AK4X3alNceZSVRebu/iG58uAPqffTrv/c4LeDPnqlYhy1CJP2+IQcTvKaT1/ZKbCvCAaAdDOUkK8O5r7/lUmTLWjReHijQYU9eX84//k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787810468; c=relaxed/simple;
	bh=K3LE3CxFoRqAxi1u1JZaBoTnYvyPdZ8P+bMBjk/bQrw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=XALIeJS8PA8Wv1lo9BTU5fqWcwP6CZXgdTBk5TjWjaqVwqFsPR1NDk66Mh2EcqGlD++Vn4N791LMtG6SDcE8cucVgSCJrx+fLlIGwyaRFabVktyqKYjBZltp/p+rwFzTkSHANEPQm2FjzFDZPT25bkuQerMcUfIdpIBJc5t85+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=oyW0vK6p; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="oyW0vK6p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787810461; bh=egJjo69zPhQ3Ed7bLeyXQZn2udHcoJp/WnXH+5ieBO4=;
	h=From:To:Cc:Subject:Date:Reply-To;
	b=oyW0vK6pevnYULP8+j8FQ+3AW1X2MONIs7MDUPRBpBaayyLyqjPcCs/MNzPziEXux
	 6BpZxR12n8O+u3k1+LYxIylZ0f8FytG6bXhgzNEUefWgP0QjsRhH/l5Q2Pcyh+4iXI
	 qw2r1YvfdLLYOhh5MaEIpWNUF7x/M/B5v5R/pY+Q=
Received: from DESKTOP-5664AH9 ([14.153.63.166])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 3A98221; Thu, 27 Aug 2026 14:00:58 +0800
X-QQ-mid: xmsmtpt1787810458tqo50y1r6
Message-ID: <tencent_1CDBA55083E12B6E42CFC06618B826929809@qq.com>
X-QQ-XMAILINFO: MbZTZajbPtIOSxv3fXdIAArYI4l6SmrYkHRSyyRRfgvzyb+abZENVMBvmEXhYo
	 JdewAY3eugnx+WkZeV+ARkizj25RpHHttmCqpnfIAXNhjsgqrBnWdr2zo8Jn3joYMW/Mvr9ZuT6e
	 yRECFxgYF3U7Wxqed8qPGGhGZc9Q7XfO2XuNNbPiFVBcPPkqATt+iER5H651GNXK37i6z3p7drN6
	 TxXS8fYwJa7b6hTJFUbWCrF7VOxzXJot2GlyDafrQfZ5Q0S4e2vGuiF34+Ua9BUCi1EfsYE0IhJK
	 wPcfwYvOoJUvk+x58wCUSIk23uy7u4dyo/+TEPNFSGiXz4XM8+YTr5vh0hibAvZun5LfXSfXpIMM
	 kXURWTC+pGmqQjZfn94QTQJdOxKZAlIXi+5pMKfDNEeMrwfWGjZPweu5OJOXe1Ul/UyzUmNIlqyK
	 UOt8T7g87E+gO68OgVOjuVczQF7bOLjLwakDFtgPPvV1DA7pHPF90o9IwM1bnb5dkLC9alpTEaAu
	 +XJXWAGjm4k4TDsPHUhhm1UXNqsU61qDhVN8sNgq2loajna6nK9ggAQ238nD08I1JPl+ujqye1xC
	 qfwIpWGAUvElJpoFxwjXIT8FfAZKFSgEnX91MLaIBT1dinUj2u0kpBp32EynT9RJ9kqV9ijRPPDg
	 KkwVBNKPRo+qOFrpyHS9l39nPvyWWGgOxaXn49bmwhyWJKga1cioockE6dBi+fdIlUs1QZhHNbZT
	 B5x9qGjm+6R5yTkGkXNVCYQ4InotlOaTHUeJJPZHfCui+YUAwirISQhqXC9fv6FzDUb1DzdkHMrS
	 iGi0IM0OkSsy49CE2gen4JJcGEiLAj7JB2TWfVyki/grxARCnM4HNmZzvS0ZHnj95wfTZm+R6cNm
	 80/RWdkNACYB5ysdBjAUHN+CUgGLK/9NX31kcUWzgXL0EduSO6IxxzvEGsZKkjEvLzr9ERQh0H9T
	 vPk2hrTH51uO2ee+WeLZy3aWaB1n/lqEtPfonVtTuHRd1iZuTvhZVREHeiAlzFV6heTUm9Roamsr
	 5vcf39WKLywQKcXSTfUd4kRE0LJpXD82g69yYDlwrf4dqlm1aK47iix4oXWmzymBbZdJw38nyGXU
	 8xAgiBsEM2d5qpB5CY1PfmkGuPrSUrEr0aDoSj6Xc93VyQ8JS0RYIuS9Zn4BXQF5aS8tDKaoX6jy
	 2s/HSAdeXl5Uauog==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: =?UTF-8?q?DUAN=20Xuejian=20=28=E6=AE=B5=E9=9B=AA=E5=81=A5=29?= <445735441@qq.com>
To: greg@kroah.com
Cc: linux-acpi@vger.kernel.org,
	hansg@kernel.org,
	rafael.j.wysocki@intel.com,
	stable@vger.kernel.org,
	DUAN Xuejian <445735441@qq.com>
Subject: [PATCH] ACPI: resource: Add MECHREVO GM5BG0E to irq1_edge_low_force_override[]
Date: Thu, 27 Aug 2026 06:00:59 +0800
X-OQ-MSGID: <20260826220059.780-1-445735441@qq.com>
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

- **维护者**：Hans de Goede <hdegoede@redhat.com>
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

