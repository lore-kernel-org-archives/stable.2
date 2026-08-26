Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3B130F7EB;
	Thu, 27 Aug 2026 05:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787808811; cv=none; b=FWhmZmg13EWJKcHgA52OSMnTwvUXg/IR+LVK1FoAT9cVBfTgkWh2qIZKpYJeV3Gdngu5XLmdnlHqDKqoJjXF4cJD1gDca2ppUWPQLcxDu9/Jffw4wDOCbeEylWZjzuCmCz0RZFojpWr8DwkjqeLiBvI4JxNF1CjFnhzlLO0U/Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787808811; c=relaxed/simple;
	bh=9QFB4DUl9aZ2Pe1XNGXqmGG3h71UlbRZ6fml/A49EFw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=qY8JRAqU1rrUM2PuKdyq0royWN2s5TmKWre+Flub+UnOJgsIDLe8igy/cNt9QnnzOI+r5WwrAx1VYE4ZykI6Gb7q9QFl2UZrINlfWuG4/mPBhabpM+R3mF9NnakXxEqDhUU+dFU+LIzoxb6tpCe5tjuvCn2cSUO3K8UUsgxhFi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=vAgqfqzh; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="vAgqfqzh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787808796; bh=DEjWwAjp2asnbHmKeFBTjrJ/EfouG9qQ7hO1fKlT/nY=;
	h=From:To:Cc:Subject:Date;
	b=vAgqfqzhdeZUh0CkLp/zQCdM9vAUH9cll/RjV3qLkSGEKoBvgvo7JVa0Qk51ceuOb
	 EsZHaH0N78jB4gNyaMLsNSjkGT7+6mL3QRBhlHiZkbBAbTxzIqYPpg/qYtVg9uJDxo
	 fPjlcV4aZd9z4OxTr5b1RcezkZT0PdMXYCw6Z1Z8=
Received: from DESKTOP-5664AH9 ([14.153.63.166])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 84DB2498; Thu, 27 Aug 2026 13:33:13 +0800
X-QQ-mid: xmsmtpt1787808793t7e1gcgzd
Message-ID: <tencent_751A66BCB84E931ADBAB5073E0EB6FC8CF09@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GlVKqr2TxuygHu4H9YWSY5NdOvDOJJSShZEv8491m/ivsL60O4C
	 zxXDr3i2Rb0ElFdJf6qmjwSuKaud2ierp0RZLkY5rpKmtV81Flk4XKEA58QvNs2b944+55LD9ffE
	 opDXOlp7WEcI3lR3gKN2qSZqDNlmKtDrDrZltokIBV9uE6fO3r7S5w1BESxKivllGfLI3KKhIBvs
	 Ynw53UBRqx42LyKde40EnH4lZ4NhD2keCrndz/eRnBqyNR7UHkHfkI7L0ZKnACo5dMZsk2QEZFs2
	 kvs+rjEOlEKF540lvycwiYMmKEq1Qp7bXf1FynxazWtqByS0CkgApHMKH6MrmqXhM8djceB0ZEm3
	 ScKBWVwPg7DCqn62+2b9smYRL0P45hZtNCkpYxzdBR4OLcZaW628GM/vyVzv31whmi/1+s+3Da1D
	 I3cIRqTVKtWgRRrpHwMgVDTvbUpDys1oq8DT5Er4jPPwLpH6nui6BHk2HY6X+V2bUYw04pvSeWNE
	 KiQAr22WMLKZYvwJI7r20cUdbWT1QyeviaNk5HIdM5DhITxCMIBzZn1o2j1W1/xO+Axiij3u7CvW
	 4Tp0QdkhQRb9v2tBoPwypBACO8P69u+ixoIuqt2W34Wdi/F877v06gJgvVvr8vwCKdW/1QSUuPbg
	 3Vsx3MQahRtgWftkFZ54DI74DdeJNv6Yr/MXOx1jt8uxHOuq3TNfREXqm5CFvZJZZ1lt/QkMtawI
	 b/0JrzrzZBH+OI8gHk5j1PTGTttvVqIzj+iosY95ReKjdhWnlgGosW2+kY/AsEBCXsBz7hCHiFxZ
	 s8YD6GmyhDIzHoMDmmLebj7mSUELzQaVoMmo8HroW9no6oyAvNuCcA/Fn/P9Z4Ck70Z10+MZTe0R
	 6QN5Nc6yIclWm4qwfvhZbYUXa+qfQjficHcn/Q5ukP+X3hR8piTnM7MW21WWsWSlP+GzfJZgcjGV
	 VNEafZxvwh1dVaPit3Q2U+pQ0sdMlCkvckyi/sY5TVkJRokbDld+nZQZxOO/fIFYT0pXrnA7i6Y1
	 XnD8zwDoj64dPRYiDDOt4fsaP7rJ9HzBV9CN5fAO3tN//lE022JCgxC5tS5rmkKEzTsPbSTloE+H
	 fo1vR0
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Hackdale <445735441@qq.com>
To: linux-acpi@vger.kernel.org
Cc: hdegoede@redhat.com,
	rafael.j.wysocki@intel.com,
	stable@vger.kernel.org,
	Hackdale <445735441@qq.com>
Subject: [PATCH] ACPI: resource: Add MECHREVO GM5BG0E to irq1_edge_low_force_override[]
Date: Thu, 27 Aug 2026 05:33:14 +0800
X-OQ-MSGID: <20260826213314.1291-1-445735441@qq.com>
X-Mailer: git-send-email 2.55.0.windows.3
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
Signed-off-by: Hackdale <445735441@qq.com>
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

