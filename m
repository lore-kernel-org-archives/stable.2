Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0764C8462;
	Mon, 19 Oct 2026 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420982; cv=none; b=JRvBP5hiRi10ilKrDSsKZEzc5EkgSxpetUcfInLdPCYpOP/QbE7s99yc2x6Zdze6cj9YDiGz5tU0B3FVEOXb4NE5mP2qfZpnDuMjDX/9a2wQJ4O7F3k55x9DztQ31roH4VFVfdh3wdfBadiM5NoQ9bSilGQ2rMaj/YiqS3NEMRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420982; c=relaxed/simple;
	bh=58S/2JIhVZunI1dsTVqmM37bm+QHd9c4ssYIh4YKCDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LKScvTLIJ/4Ci2upBdCNbaqoGV0QZKGlM/M6/Aiy2tmpC1P3ggu7K4M0847GbYL8rNpM5mk6ggXTMbMGgsRneR+l4T2hal3BV7qTl5PFrrTG6FLhcmcQ1PB8QO2PLKsLAVm54eLirHJhL8rWMX4fxXqDXQ+HyQq4NfJ6c9w5dm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.109])
	by gateway (Coremail) with SMTP id _____8AxntJyLNZqmVMXAA--.2201S3;
	Mon, 19 Oct 2026 22:42:58 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.109])
	by front1 (Coremail) with SMTP id qMiowJDxBc1pLNZqqxouAA--.3545S2;
	Mon, 19 Oct 2026 22:42:55 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] soc: loongson: loongson2_pm: Fix build warnings for 32BIT
Date: Mon, 19 Oct 2026 22:42:40 +0800
Message-ID: <20261019144240.4035274-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxBc1pLNZqqxouAA--.3545S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uw4DJry3KFWktw4kGw1xZwc_yoW8Xw43pa
	93A3y8Gr4jqr1xZwn5tryUu3WYyay3Wa9rKFZrXw1UuwnrA3WUZr1UCFW2vF42kryUGF9F
	vrykGrWrGF1UCFbCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0b6pPUUUUU==

Since loongson_sysconf.suspend_addr is unsigned long, use "unsigned
long" instead of "u64" for casting, so as to avoid build warnings for
32BIT:

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
 drivers/soc/loongson/loongson2_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/loongson/loongson2_pm.c b/drivers/soc/loongson/loongson2_pm.c
index b8e5e1e3528a..1e2c897d055b 100644
--- a/drivers/soc/loongson/loongson2_pm.c
+++ b/drivers/soc/loongson/loongson2_pm.c
@@ -175,7 +175,7 @@ static int loongson2_pm_probe(struct platform_device *pdev)
 		return irq;
 
 	if (!device_property_read_u64(dev, "loongson,suspend-address", &suspend_addr))
-		loongson_sysconf.suspend_addr = (u64)phys_to_virt(suspend_addr);
+		loongson_sysconf.suspend_addr = (unsigned long)phys_to_virt(suspend_addr);
 	else
 		dev_err(dev, "No loongson,suspend-address, could not support S3!\n");
 
-- 
2.52.0

