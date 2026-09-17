Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1788E2E06E6;
	Thu, 17 Sep 2026 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648983; cv=none; b=mV5Z4JFyHKWGR14vUTSruIl51znJnvp4++XXT7eIDM3G0v98idO/neFpS+bPwWjyWe8hlxLgXvd6ZG/nB+weMKGEtpKA+qQFGHKPnR+xmHBcodw8z1jOU/6O69OEM3ebS7o8xI7PGU5x2Z4XYaWmpFJ0Bp2AvxwFdD5X3LGWhog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648983; c=relaxed/simple;
	bh=A/DzU/aoqNE1SjpM64MsQUbfLr9jiu9kcjGp2wel53A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rFIEiF0XWOGHEeRV0AnIG9PiueoSO0rFztjXT2GuBTLDXK5US98ISK7QkLpdS/A48uiM2ecDMHY7+BhbvuJaeawODFffTZ039LWmw8L8z+I/hV5gWBFBl/csghWxBb8dpR7OQvDNpWUtAL02DJi1MOl4rJJlIY/o+etleGwJiXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACH8z1H4KtqBr+ACA--.2959S2;
	Thu, 17 Sep 2026 20:42:47 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Julia.Lawall@lip6.fr
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	robh@kernel.org,
	saravanak@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] of/irq: Fix remaining refcount leaks in of_irq_init()
Date: Thu, 17 Sep 2026 12:42:47 +0000
Message-Id: <20260917124247.2151674-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACH8z1H4KtqBr+ACA--.2959S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZw4UWrWkWr1fXFy5tw47Jwb_yoWDGFbEkF
	1kZFyxGr1UGrs5KF42yr1rZr92kr1UurWfZws2vF43Ga4avrn0qFy7ZrWrX34UurWxWFyk
	Cr1qvw4F9ryrWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbS8YjsxI4VWkCwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7MxkF
	7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6x
	kF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07je0PfUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMNA2qrq02oUAAAsL

Successfully initialized controllers are moved to intc_parent_list,
but the final cleanup only frees the descriptors. The device node
references taken with of_node_get() and the interrupt parent
references are therefore leaked on the normal return path. Drop both
before kfree(), as the intc_desc_list cleanup already does.

Fixes: 8363ccb917c6 ("of/irq: add missing of_node_put")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/of/irq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index 6367c67732d2..f50fec3afa2e 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -752,6 +752,8 @@ void __init of_irq_init(const struct of_device_id *matches)
 
 	list_for_each_entry_safe(desc, temp_desc, &intc_parent_list, list) {
 		list_del(&desc->list);
+		of_node_put(desc->interrupt_parent);
+		of_node_put(desc->dev);
 		kfree(desc);
 	}
 err:
-- 
2.34.1

