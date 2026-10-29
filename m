Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793246016;
	b=GRt+joa7j+h/Xcfv12Js6KQmnnl/2o7B3KR1HUtND+PQ6TbqvpbWDox7JVxijIhaVb/t
	 SjFT9b/oh8Rtfc/LJLLl3NefFZ7m41jkRPUYCAE9ROpJitaM83jThrXFlVvee+I1KQUDr
	 22jAaDECRxb7K1hDLJU2irAqHSPnXsBQLEwRjwwHh3rz49r7HTCUyRtwOuGown7byuAnz
	 7r9vc0aQ6FofYg+6bO747HiphUi079VgvcUIlAkAe9Yf/XaEvC4+VQvhVkDdfPXvAxCSF
	 Y8OlzEBIMfHnT3XXvQ2wUC5iudiz7MLGw+4TuH08ucEsrn2PilVbywytn/SpzYXMceQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793246016;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=dmI12ASRBID7pbG7Kj3YA2ZrzgqrOIsSp9SPF5rc8VU=;
	b=vwzTxGLzzwXl4BA9xAutu4Jwdc2kbDu1ZAiFMCzgD2yp+47b0KwRaNeu+GcYIaZE75Ee
	 JL8XVgmnhPiZ+hJfzx/gXq9U8Ub6sQYO64il1MhS1VSALsHd0DlDzQNZU0GIWqTVMxSLF
	 1wnPnR3eh4GH1d0r3euaNgAQGONWQqzTSnW28+Vo1oeYfCy6bzsa73F53zQtyUFqvE123
	 Ta2P9s4b1SSLGpSuyZf/fke49Mba/4wyjOXiZcYlZNuEr6sBlhH2+qRCwzL2D0die4ceq
	 AVdzntVqrezFd79f+VDWopgX85JlHMzRTbbsnWgL8ZA0EKhJkhuS9HZBmlaenNWAA8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=FC7NItCV;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE66F606A32A;
	Thu, 29 Oct 2026 03:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE66F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=FC7NItCV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dm
	I12ASRBID7pbG7Kj3YA2ZrzgqrOIsSp9SPF5rc8VU=; b=FC7NItCVPYVa4JEEn3
	SkUqOTg+S5B03uMq1PK0zs0q/DKL/46ot0ENT64VfAldZA+a+V0aKrSlXeR5njPh
	aVkm3gPIuA7Lsj7o7F9TnReqruT0Rh5HPHOreUt199APsgb+FT9ZBr8bGrsUehRj
	17+sJGJEtoH5qpNAgc5L70ks4=
Received: from pc.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCnsSkVw+JqTWv_Cg--.16381S6;
	Thu, 29 Oct 2026 11:53:02 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 04/20] irqchip/gic-v5-its: validate MADT translate frames
Date: Thu, 29 Oct 2026 11:52:35 +0800
Message-Id: <20261029035253.2333852-5-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029035253.2333852-1-yaojiale02@163.com>
References: <20261029035253.2333852-1-yaojiale02@163.com>
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
X-CM-TRANSID:PigvCgCnsSkVw+JqTWv_Cg--.16381S6
X-Coremail-Antispam: 1Uf129KBjvdXoWrZF18Gw45AFyfCw4xKr18AFb_yoWkGFX_Cw
	1kWFn3JF4xKr47tw1xJr45ZrW2vw1v9Fn5uFZ0qa95Gr48Zw13XFnrX395XF4DGFnYyFn3
	Gws8CF1fKr129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbg_-PUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7x5LhWriwx5aLAAA3c

The GICv5 ITS translate-frame callback accesses IDs and the base address
without checking that the MADT entry contains the complete fixed-size
record. A truncated firmware entry can therefore cause out-of-bounds
reads.

Reject incomplete translate-frame entries before using their fields.

Fixes: a97efa5ba594 ("irqchip/gic-v5: Add ACPI ITS probing")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/irqchip/irq-gic-v5-its.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-its.c
index 28e39b065de0..dad3b95ba150 100644
--- a/drivers/irqchip/irq-gic-v5-its.c
+++ b/drivers/irqchip/irq-gic-v5-its.c
@@ -1233,6 +1233,9 @@ static int __init gic_acpi_parse_madt_its_translate(union acpi_subtable_headers
 	int err;
 
 	its_frame = (struct acpi_madt_gicv5_translate_frame *)header;
+	if (BAD_MADT_ENTRY(its_frame, end))
+		return -EINVAL;
+
 	if (its_frame->linked_translator_id != current_its_entry->translator_id)
 		return 0;
 
-- 
2.34.1

