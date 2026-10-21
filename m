Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792593962;
	b=YNdwjMO3idJdsnC6bFiBTRhWuhrs9dAAyc+Y+CK/syDLrJkhp1cPHnGyRMTSTkJEA0BE
	 Y+O7/GVZrGVyEEErM1rgVbA67SBPZ+ak3Pij3YSB+CbSuwxfPSsHPRU5sljbyDK1ODBFb
	 8AO8ouanegT/5DeKt1ypNUCjOnltltxad7frbb9mD1uO5ZEQIPJ5eEsNY1Q8hfjzu7l/4
	 N+oGig8uQN+MtfYIBJ43ZGlwhxVA35WrWso+q6KsJlOk/jSVpCzQuYftPmW+Q2HqdVEHE
	 g1+x3BbKVg74Hz97BZWRDB+mGrht3AD0cRlKF0wvQTEZ41lRGOidKAmProfytz+bGQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593962;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=1D/9o8XUGJP3+Ci1uvpe48uz5CNg8HI6u80kWrL5PD4=;
	b=dV2t/SHKM6ubFdtZRBMSoCQ4CE1bmMHRLHKZrkfWUpunNMT0Ck0i62Qlhd4mzFVCTTwS
	 xWfsT209p746nxHRtg8D3BOrklv2n9vohwR4sa4SE1/APJqPv35wKeJFXipr4sQ6rMkk2
	 dvrPfDBbpg2SaArDS1r8kH6BJ/uR7P62TkP90qMdH2ROIZ8NXMDTNH5QbIINcLzpek0wE
	 dVl3IsNWqppneH5TJ0ugrJcQ8LYa7VUQoUfB4P0Tcj1uTnwyktwyYHv8a2KNTxaUExaLH
	 lETNeGtQUk0O/WgPCxG87LEUGzykatxYXOOchXVKBUNr/M0pzRx4+jcVRj8C/qTfhag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=QCP+DVdo;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6FA606A31A;
	Wed, 21 Oct 2026 14:46:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC6FA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=QCP+DVdo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1D
	/9o8XUGJP3+Ci1uvpe48uz5CNg8HI6u80kWrL5PD4=; b=QCP+DVdoKVoZ8g65tH
	378uFL8ze936CaDIhzH6X4PmRqlTtrwGr4runKbEU6YbL2QEBIhRM00KuaE+s4sa
	R8tXYWb46N8NKvxkC/5rwjex6FxTuZ9vvFDqs2yhKLRn3AjIP8jZXxgTbR89pBtv
	3np3XcpmjAO35wQhD5xFo2vUc=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3998G0NhqjItXBw--.10228S8;
	Wed, 21 Oct 2026 22:45:32 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Huacai Chen <chenhuacai@kernel.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Marc Zyngier <maz@kernel.org>,
	Jianmin Lv <lvjianmin@loongson.cn>,
	linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 6/6] irqchip/loongson-eiointc: validate MADT BIO-PIC entries
Date: Wed, 21 Oct 2026 22:45:24 +0800
Message-Id: <20261021144524.364143-7-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021144524.364143-1-yaojiale02@163.com>
References: <20261021144524.364143-1-yaojiale02@163.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3998G0NhqjItXBw--.10228S8
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ww18tF15KFWrZryDWF1kAFb_yoW8XF43pF
	W3Aa9Iyr4UG3y5Grn7K3WUZFyrZan5Aay7tFWxZayfZrnxXr1UuF1UAFn8Zry0y3yUGa42
	vr4FqFWUu3W5AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ul1v3UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8AwIQmrY0AzUXQAA3R

The BIO-PIC MADT callback reads the controller address before checking
that firmware supplied the complete fixed-size record. A truncated entry
can therefore cause an out-of-bounds read while selecting the parent
domain.

Validate the BIO-PIC record before accessing its address or passing it
to the initialization helper.

Fixes: dd281e1a1a93 ("irqchip: Add Loongson Extended I/O interrupt controller support")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/irqchip/irq-loongson-eiointc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loongson-eiointc.c
index a9e8b481d31d..f92e7702195a 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -454,8 +454,14 @@ static int __init pch_pic_parse_madt(union acpi_subtable_headers *header,
 					const unsigned long end)
 {
 	struct acpi_madt_bio_pic *pchpic_entry = (struct acpi_madt_bio_pic *)header;
-	unsigned int node = (pchpic_entry->address >> 44) & 0xf;
-	struct irq_domain *parent = acpi_get_vec_parent(node, pch_group);
+	struct irq_domain *parent;
+	unsigned int node;
+
+	if (BAD_MADT_ENTRY(pchpic_entry, end))
+		return -EINVAL;
+
+	node = (pchpic_entry->address >> 44) & 0xf;
+	parent = acpi_get_vec_parent(node, pch_group);
 
 	if (parent)
 		return pch_pic_acpi_init(parent, pchpic_entry);
-- 
2.34.1

