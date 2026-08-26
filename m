Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA54423645D;
	Thu, 27 Aug 2026 06:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787810451; cv=none; b=h/GYsoMKS69sbFrAlO2AoaV9LvPlSWjA8fZqkYebBtD3evrKpO5E5JvLUfSj9GxBaur5XvU7/FA/14l6qoQQP9rejQySNx199YmqWkhKL5Nc5Q5YzIGzOu1ZXqOw+g3bTy3RkdkwS7bXbZvAJT1xBaxlZG321HuGieJGYGPSv7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787810451; c=relaxed/simple;
	bh=0A+ZVSHmTZpBWDaeE60eIZ0qBxxkdFlAWVSwRqqWT9Q=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=JVb5fPc2euKYT8iLSoo/ElbtxiXa+PISnmXpc6d7lyrLc4JWz7jZgI3DTEIjl+c5GePcvutHaabevBEvSPNM4AVb83KnIh5ACU5c8mSbr+QmxExWZa+hN/1pP9HVxhbeO1zRdM9bNjPKTeMR+1uh8IAVvNqDR5uAkACjOEtcuu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=pjUW00sj; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pjUW00sj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787810440; bh=XRQFRVMDjVp4EOP0fZkF//N4HCPkekJ5nXepNdiemsk=;
	h=From:To:Cc:Subject:Date:Reply-To;
	b=pjUW00sjEsfsas1uTRfho3CI/SdERh3gtDdHlkXy23vn8jSNG1JMw3Dvsjua+SLbl
	 1T0WZ8JsWYe2n+3jCS/K6H2YqiKWfogSJrp3NbuEDuMjXX2PdiiH+wJgrY8iY2+a1y
	 5rKOTU98A0Sc7Eb7h3e+jfuoEoD/jwvNrCu8xJF8=
Received: from DESKTOP-5664AH9 ([14.153.63.166])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 25326CB; Thu, 27 Aug 2026 14:00:37 +0800
X-QQ-mid: xmsmtpt1787810437tqimq57ru
Message-ID: <tencent_4AF524857605546F78F39BBB33D2192B2E07@qq.com>
X-QQ-XMAILINFO: NP9KN8CSKc3GH6Ii3xUWB3lwVuITMftJuyh1IMlHOp+DLSoK2iVHNK2vhShzwc
	 2IUR4hEZ+P4yhJZ5lnkJwbCqEstfkhc0zksY4wN9h57P2T/fw7zxAEdbtodzZi1gXRGIK2YrE6mi
	 8WP7pNzYTaiSu94SktzGwfgSzNw1KrCGzPetR11ynjgx3vMXcP4cUPPdB70na39vIfZPeXZ17jgy
	 d1y7Z5AUvq51HbzPfoAQfqx20oJB2iaIEScHO6BJHyuzsC5sJlcuqLitZL+FULyBaiztNNXt5njE
	 BALZY9KK1r5NIDucOKVePK7JI4AL3fuPdfAOZOTZD6Bovz4CWFinlg9ejoh1QvGO2HRU47z18rWX
	 7OUkIdWvriE+K/FCbrD13f6/V6fjW7IK//mQiPa2uFPR67HA5FqJ2knLocUGZMEtRCryf9raidSp
	 CvmVuMr9LGNoWniNCj1i3INpRwelz+rC0+O3zP1XzCljT1FWwkYNIIOVBpiG3IdOo2lv8vaJ19UZ
	 WhGuvX+Pq3VDSmnPZTguiH0Vl0Qgf0EhzTuhJdVHY4CeZENA1ijeufTqU5JX+g168TBAF2+WG39q
	 O5TT0F+C2oNj3QteMT1i004KAxQXfP8NE/KcP6iX5nYefYU6iToA1tPczVjJzYlx5GErFXu4VXVx
	 4ztLnDk2llSVgxg9JQ/+sP3kEITYNTMVKav7Dw6Js09mFvL5bLvnQkwqmkbwawJ99cGLwo9jUHCI
	 xmafeMtbSuMHsmiAnYdI2vmEaUDlVB9fdaz45CRxLmhwRExB29nbxyjk4DzpE25LdDA3dPHMUY8X
	 2iiV3qjpbW2bwAyTQPT1F+mMg/+0g2LLBf8OHU7fO7pxh+dQv6V7oVT+LJrs209YoMJsZxay/csw
	 LjS2F5dt/1JQE+RquO7RkfCevRI5axBDA4rLG5SH5R1pBOv22PyLN2yyR3rE30GdIwxR1c3q+Use
	 L7NUIYUB/ZiLSUtrM7sPOtAHZY4+vuEvYjryCs0OrnpDo7apXfA4KfhXroxxSC3zjCnYIa4rV6vy
	 yKiZC327YaNzBc6uNmRfmpPiQDY7D3HyanIhwFrWuEzN1UzUUgZCWhkR5fjvy4kvftyaXX8jsCvv
	 76g4/A/qyfwK552jw76aHDlwVndHtEdtvyPdJTy/hLRPqTzTPKWTUI/+kGAtIvDf1jPzclcLkiaq
	 JmT4s=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Hackdale <445735441@qq.com>
To: greg@kroah.com
Cc: linux-acpi@vger.kernel.org,
	hdegoede@redhat.com,
	rafael.j.wysocki@intel.com,
	stable@vger.kernel.org,
	DUAN Xuejian <445735441@qq.com>
Subject: [PATCH] ACPI: resource: Add MECHREVO GM5BG0E to irq1_edge_low_force_override[]
Date: Thu, 27 Aug 2026 06:00:37 +0800
X-OQ-MSGID: <20260826220038.358-1-445735441@qq.com>
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

From: DUAN Xuejian (段雪健) <445735441@qq.com>

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

