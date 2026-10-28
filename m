Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163690;
	b=pP5XnZoJGebHhFmvg92s83Jm598k1KiRcj3czJnv4lP3sYKWQF2PZyh5NQZses6Zmd7V
	 9OUzrrc5gdzw9gAveRAnOAha1twZx79kpbTA5un1vLQA1ZZU06+U93JK0Iih0NBaxiCip
	 IteMmovmExQGASLT8EOA9EESPZoqtso06lDsNOTqqrQf0CrHk52twf47tJ4ZxJbSeargH
	 eZucQZbiFgfZ43IWEdL3RJL/KZYZFe1UjiKsdGt5e+8xyZmTt30wQJ3y5gw0zU7ctGtjI
	 /CMplsPjnmFO2AyH9WB9kNq89jgyWyKzFWAU1Jx/3rcciiwsS0UHLDlaDMnYcNBxc/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163690;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=xccUtcyyESJ3WLR2ftYh3c2qwYLTAfF2p1hWnzXcSII=;
	b=PebAl+57ycsJVHyRDIThTP14xAeE+Y05CKJw590sxHSb6799e3wG9qKtVyQJH+DMhZaK
	 7d3tSBC5zv2/NLLVOod/zCvcK6f2bTvs1OSGx/OuvOO9KxWSnkVnOgdmDAAWVFsViwrRu
	 ong+C5Vkxnyam50andIVQ1QHLQb8yoy9vOmjC7KvkHNy0DPLVzkfRjbzjysBrXD/aTgHh
	 eEqapA0hbdEk8uYI1su6aCtg7LLKeGcrGwZGL4L22YmzyzfBG5ruxweAHZebXgFw2yvo7
	 HmkgSJYcnkDGYS9JPLgdEODts8c2LGxhgLNA6cKYoTnbfuVERU2ivhUPTOMv+ZHbY0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=d3Bm2zoE;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7075360A263C;
	Wed, 28 Oct 2026 05:01:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7075360A263C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=d3Bm2zoE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=xc
	cUtcyyESJ3WLR2ftYh3c2qwYLTAfF2p1hWnzXcSII=; b=d3Bm2zoEGwx9s/TgRU
	K5StLLE+YGC9M+4bX1bLhtAMe83hliqJpYjhCAWdzKdnemPviqAu0zCfRk0MjQwI
	T/l7tVYDjIE+xtkcBsaUVCIzq+UhSWtlI4cZr7zpz6l++F/GmwoMumZxeE5Simv8
	dY3l319wvlJUy6JqMFzXyckx4=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD31_V5geFquXTKDA--.16748S7;
	Wed, 28 Oct 2026 13:00:47 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Jason Cooper <jason@lakedaemon.net>,
	Will Deacon <will@kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 05/12] irqchip/gic: validate MADT distributor records
Date: Wed, 28 Oct 2026 13:00:32 +0800
Message-Id: <20261028050039.121080-6-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028050039.121080-1-yaojiale02@163.com>
References: <20261028050039.121080-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD31_V5geFquXTKDA--.16748S7
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF4kGrWUAw45Xw1fJF45trb_yoW8JF43pF
	WDJrya9r43Ww48Gw17Aw4UZFW5G3yftFW2qayrG34a9r1UGFyDZFy2vFyFgF4xtFn5Ka12
	9F40vFy5CF4kAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UmjgxUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzh+SzGrhgX-R0gAA35

The ACPI probe validator reads the version from a typed distributor
record without first establishing its size. The accepted record is then
passed to the initialization callback, which reads its base address.

Reject incomplete distributor records in the validator before either
callback accesses typed fields.

Fixes: d60fc3892c4de ("irqchip: Add GICv2 specific ACPI boot support")
Fixes: f26527b1428f ("irqchip / GIC: Convert the GIC driver to ACPI probing")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/irqchip/irq-gic.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index a5ca04e9be64..21fcbfdc2093 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -1583,6 +1583,9 @@ static bool __init gic_validate_dist(struct acpi_subtable_header *header,
 	struct acpi_madt_generic_distributor *dist;
 	dist = (struct acpi_madt_generic_distributor *)header;
 
+	if (BAD_MADT_ENTRY(dist, (unsigned long)header + header->length))
+		return false;
+
 	return (dist->version == ape->driver_data &&
 		(dist->version != ACPI_MADT_GIC_VERSION_NONE ||
 		 !acpi_gic_redist_is_present()));
-- 
2.34.1

