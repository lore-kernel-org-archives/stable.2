Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9719D372B45;
	Mon, 19 Oct 2026 03:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792379699; cv=none; b=Uo1IuKBE8zjWPqyERG6BSxsr0vs0O5d9uPeS9WwGxdSWXJ0ep7r5qRzRhBPM9oqTVn/QhUnb8D2TZguxKgY3JO1zNt9RNwb/4ZfEMqMVSxyKwmgi7LcPMCeATVlS/T+VAQscXIGOZ50lkxGNq55X7D/ItY7xLnPGcKMlzNl8Hq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792379699; c=relaxed/simple;
	bh=lx5no8xRSUwjQ9mXkI+e7sRArirdLD1Ab0RRIlqZ3ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ir34MDOh2GBnf4uKnJlF5kT4T52JQIDhi60vDY3QwIujZkr8XLeDqPD5yzK2XctNWctqesZabT+dFpBtJCAmF0k+IP0yBcGREqKoYxlLEJ/WLSq4sTI5Lx5aHiaq9M5qM4w3xMgsgI5xAy12XZA7CbJtc+AOVZo2jvIKvQOmUFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.109])
	by gateway (Coremail) with SMTP id _____8Bx69Eri9VqzCkXAA--.1576S3;
	Mon, 19 Oct 2026 11:14:51 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.109])
	by front1 (Coremail) with SMTP id qMiowJDxBc0li9VqQ94tAA--.2975S2;
	Mon, 19 Oct 2026 11:14:48 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] soc: loongson: Make Loongson-2 drivers depend on MACH_LOONGSON64
Date: Mon, 19 Oct 2026 11:14:36 +0800
Message-ID: <20261019031436.3523632-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxBc0li9VqQ94tAA--.2975S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw4rGFyUuw4xXF4UuryfAFc_yoW8WF4kpa
	n3Z3yxCF4UtF4Yyw45JryxCFy5Z393GF9ruanrJw1Uur9rAa48Zry7AFWSvF47ArWUXFy2
	vr95uayUG3ZxGFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcpBTUUUUU

Loongson-2 is 64bit CPU series, their SoC drviers are not supposed to be
used with 32bit. So make Loongson-2 drivers depend on MACH_LOONGSON64 to
avoid build warnings:

   drivers/soc/loongson/loongson2_pm.c: In function 'loongson2_pm_probe':
>> drivers/soc/loongson/loongson2_pm.c:178:49: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     178 |                 loongson_sysconf.suspend_addr = (u64)phys_to_virt(suspend_addr);
         |

Cc: stable@vger.kernel.org
Fixes: 3d9aba6618d1 ("LoongArch: Adjust build infrastructure for 32BIT/64BIT")
Closes: https://lore.kernel.org/oe-kbuild-all/202610190549.WM2PO3vO-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 drivers/soc/loongson/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/loongson/Kconfig b/drivers/soc/loongson/Kconfig
index 368344943a93..84fac84909c4 100644
--- a/drivers/soc/loongson/Kconfig
+++ b/drivers/soc/loongson/Kconfig
@@ -6,6 +6,7 @@
 config LOONGSON2_GUTS
 	tristate "Loongson-2 SoC Global UtiliTieS (GUTS) register block"
 	depends on LOONGARCH || COMPILE_TEST
+	depends on MACH_LOONGSON64
 	select SOC_BUS
 	help
 	 The global utilities block controls PCIE device enabling, alternate
@@ -20,6 +21,7 @@ config LOONGSON2_GUTS
 config LOONGSON2_PM
 	bool "Loongson-2 SoC Power Management Controller Driver"
 	depends on LOONGARCH && OF
+	depends on MACH_LOONGSON64
 	depends on INPUT=y
 	help
 	  The Loongson-2's power management controller was ACPI, supports ACPI
-- 
2.52.0

