Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310103644BE;
	Thu, 27 Aug 2026 06:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787812961; cv=none; b=M2NjKfscgDqTBjMxPE3ha691owaDCnV+ME+ehU1fByjktIOHK/QawDuKq4i8k+1yvc1LsvmiP2KXOrLlT+XseSwNufJW6WSyeVNzEcT/jHbzV9FR8ttIsBSIZ6l8MmP7BFqwM94NAmFPdQOf3qqv9TmXrif3K40t3uUN+rYrsAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787812961; c=relaxed/simple;
	bh=YVZtFrajDbpPflOWP7G1rE6Ax3pnPOPv3Z9dYQLRObc=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=IRTn6XG9BAL9K09ITZ3Chl8xKT4dSNaiZ5+juxsQ3vE2Z7Z4DDYjU5ohkV+scZNwCYH6iD7e7fc20hZ77JOCZrGqNvizkR4DFH87032JLqQCU1o+t8AsFHJIP75zmUO/mYsXOdlNpvZWzNFGFASsK7FZypXjh4GgTkpUGp9iS2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=kOY5F4Zo; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="kOY5F4Zo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787812949; bh=JN9cwocoVSnc4dJa47FODR20clQofla8GnMhi3yDhV8=;
	h=From:To:Cc:Subject:Date:Reply-To;
	b=kOY5F4ZotXa0qDnYqIZ15Ts6E3vtH2XM3JAbOqAhMukEAneeLwdjFHHpc7mI+BIcB
	 BWlyFvvpz9UKC0zwzOi1I2xYzY4WVtf2i2D/ErIdOMZhKsP6LkY9JVkybndFeOdjoS
	 lm4D75hHEngq7wcyKP82ozvw5agrzRpT8NPpiqBI=
Received: from DESKTOP-5664AH9 ([2408:8459:3840:c746:b80c:e0bd:3b46:8260])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id A9A38C9F; Thu, 27 Aug 2026 14:42:26 +0800
X-QQ-mid: xmsmtpt1787812946t05jmb08z
Message-ID: <tencent_262C335D5C0549C6ED9EA88FF00437B26708@qq.com>
X-QQ-XMAILINFO: ObqHjTnQtDvTAcFSH+C+DJDy0FfoQfjZrD7wmIzsexCrOt/9BJ7V2jG0bHco6+
	 GvsF5sYMpJE4XNp9lp5q1gpgTeNymM9IwhkcG0vNTLNmrcUFPflvxp6Z25PTj2bdPNyevL0ZRDHg
	 D6ppZBxKuad4ND4OlTzvuQ6RlHxbabMu+GBLizJK9c/ugt5cipOvCacteJ0bYr+EXaJoSk9A6OPQ
	 3CahuzVEBzhRI5N58/D1LnBl5ULcE9g3F1aDAlhd6SQPJj668yvY0mbc3gpC56RFu2amjchD2l/H
	 mDUP29fYhTeqVXQkR7gerRhlw+kPzrgTsZg580xlH5h+Zqr5eJLUSPEdIIraTZ9RQhfN4KYY3mbD
	 dCxdQ8ARJkHzNhgtU1xv4zN47TUiP+oFnvd7Bgr+FoOuXchJSJGEFvsL7+XfrUfOYFX6UEbfYNnG
	 qcJW+yW6S02Kwn5qxoEu6SDLWys6BBeqoGghmWmIih/4/La9yiRqVPGSgaqZKexDinK2WIutb/dN
	 1vNl0JF0g/sQSU5wNRSyqsQ5ne+39oFv1AC1iGwFWDyd2VGNv6jSjC/yplqqJlzf9bShGlkeDNj0
	 q7dfN4Kb5bu2+qc64Rm6RjkaR9vLqWynoF/HhzeQBEKClIVUg/7f0+5p/Q00RkUqbHL3jlIrDIib
	 QHuOdE0dbLRgw4K2e6T+XuHeuPXdR/cg7UBsU+6EYPp5m81++WduC7scW4bYogEjEUcuF2z9kqOH
	 CmPhwlPCNvvFCcHu8EX2cn3mybbgkgeL74Ae/K0LoKRUw1QJa1QtyMWFdbXtynMmX+Tv3QYAha3r
	 rAsVeogBqjGCY/dxiJT3W3xTar5wRhquiEZdDjjeJ1uvVn4H65MpVQR22Sl4tz4s6gWL9sDpKlo9
	 gElDYP1M6xRDxJl/MUdLwaBAV4QCAiSCRm5WeJZ1GkGLKzyG71JUDlQCbXAWhuIIepCgSw1prs2j
	 w5is7tjC142yoQ63pgwCBL7su+rxsP19Zye0pE6bDJU0gqHiZhyn8tFryR+awdowOk2H3NmElx7F
	 Ac8SA7rdbSW+DgwOMhp5RuUZQ8sD5gRYkWYeyAJW6IN31OPP9qg/h6PNOq0MKV9SYy13SsPJqH6b
	 5I8AZ9IUZX9PI2j6MzPQ7ZOOyy6sztrjjyrf1zdtfbHJMUJ3rp8mu7z+5qp909ISLVCBen
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: =?UTF-8?q?DUAN=20Xuejian=20=28=E6=AE=B5=E9=9B=AA=E5=81=A5=29?= <445735441@qq.com>
To: greg@kroah.com
Cc: linux-acpi@vger.kernel.org,
	hansg@kernel.org,
	rafael.j.wysocki@intel.com,
	stable@vger.kernel.org,
	DUAN Xuejian <445735441@qq.com>
Subject: [PATCH v2] ACPI: resource: Add MECHREVO GM5BG0E to irq1_edge_low_force_override[]
Date: Thu, 27 Aug 2026 06:42:27 +0800
X-OQ-MSGID: <20260826224227.1489-1-445735441@qq.com>
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

Changes since v1:
- Use real name (DUAN Xuejian) instead of nickname (Hackdale)
- Add real Link to mailing list discussion
- Update maintainer email (hansg@kernel.org)

The MECHREVO Jiaolong 15K (GM5BG0E), an AMD Ryzen 7 7435H based laptop,
has a defective DSDT that declares the PS2K keyboard IRQ1 as ActiveLow,
whereas the hardware is actually ActiveHigh. Starting with Linux 6.0,
the kernel no longer auto-corrects this polarity mismatch on AMD Zen
platforms, causing the internal keyboard to become non-functional.

Add the GM5BG0E board to the irq1_edge_low_force_override[] DMI quirk
table so that the kernel forces the correct IRQ polarity for this model.

Link: https://lore.kernel.org/linux-acpi/tencent_7C3B122A153CDB0DEF19FA4C03D779D27806@qq.com/
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

