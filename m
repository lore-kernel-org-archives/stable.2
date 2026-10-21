Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792593950;
	b=RIxAqDFURH32gg/63p4ESuBj2zttVCWg7tjrx0VZLBdpyur6EcWDhefNK0+YqShfJDE9
	 V/y/hMOagVOycM4uBp1+m7G9oY+q1FWH9jhYw6M08ciFhchkLiqwp/wqbbKgJahQ18B+L
	 FZLAH0pwdH/lj9gMawoLYoHgWafeLz/CqOr2cSd60Fs/Qh9jDk25USyE7TYJODEvzEgf4
	 iDjFma1fbPmRJ4LXgEIDlBPWVcv7OMncS287IV7IHXGT5S+5+hEdQn/oFxwkaZ63YIwXG
	 As9e+r62qJ/ej3WXfpwwZSTL6G3wmaWaQP6GcAPJMJ2cv4fCMTCKkkbZmH6PWSD3JVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593950;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=pjQBhetWdkLgZ9JH0IyThLtdwZICfhglt7BeWjKIKZQ=;
	b=ufPTLCW/L+490oS/yMlM0B0CbINwSYlwbaHBArTcAfBo4593kOQm9HfhEgU2zGkAOU8Y
	 DtvvwZU/mr4UWD+8nA2RVweISISHG4kB2kjyHdLbGJdVWfs00HiYTPwKKPFTETJe7nJGf
	 ILL0NqkQPgNRbTmVp9Moi7/u1uW/hBPt0f193Xde6Rav6QA8Pc/jDIrdVuEAzsJVlc+YD
	 jnKm3pCQsifukdqXwihcFZ5Hzi02Z+vKNAndc02g0tBEq4LOJjkWRNpNKVdtl8+EJ56r2
	 s1welmhbfyMyymqxvagUfSyJcFjvvYzWMa2mHqvmYL7ptL7Wr6dkTUF42pg8U7ksiHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=HimG6IbY;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7DE606A324;
	Wed, 21 Oct 2026 14:45:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A7DE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=HimG6IbY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=pj
	QBhetWdkLgZ9JH0IyThLtdwZICfhglt7BeWjKIKZQ=; b=HimG6IbYRr+3b4I3Oq
	b8hCO75D9G5eUKleX2zkOcgRT9ZhoiOtvooZdi99OYm/mJ1Dvfxf96kErkqgs8tN
	OVwNca01lRmUdZVpV5WGBtmFaCYht7iqkztjivD24HP2Rle3GQOsN5r00Ed4lvt3
	DdXkgXGR5QbLad/FA3g453Q6s=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3998G0NhqjItXBw--.10228S3;
	Wed, 21 Oct 2026 22:45:28 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Marc Zyngier <Marc.Zyngier@arm.com>,
	Hanjun Guo <guohanjun@huawei.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 1/6] ACPI: irqchip: validate MADT entry bounds before probing
Date: Wed, 21 Oct 2026 22:45:19 +0800
Message-Id: <20261021144524.364143-2-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3998G0NhqjItXBw--.10228S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Aw13uFW3uF13GFW7GF1kGrg_yoW8Jw1rpF
	909Fy5tr45trWagw1Ivr4UuFZ5W393Ga42gFyxG34Sg3Z8GF1Y9ayfC3y7tr1UJrWrWF4a
	vr9rtrZ8CFW8J37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYzuAUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQgHQWrY0Agi4QAA3q

IRQ chip probing invokes validation and probe callbacks after the common
table walker has only established that a generic subtable header is
readable. A malformed length can leave callback field accesses outside
the MADT.

Validate the generic header length and ensure the complete declared
entry is contained in the table before invoking IRQ chip callbacks.

Fixes: e647b532275b ("ACPI: Add early device probing infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/acpi/scan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 163a3cccf197..ef8e8441b6ef 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2889,6 +2889,13 @@ static DEFINE_MUTEX(acpi_probe_mutex);
 static int __init acpi_match_madt(union acpi_subtable_headers *header,
 				  const unsigned long end)
 {
+	unsigned long start = (unsigned long)header;
+
+	if (start >= end || end - start < sizeof(header->common) ||
+	    header->common.length < sizeof(header->common) ||
+	    header->common.length > end - start)
+		return -EINVAL;
+
 	if (!ape->subtable_valid || ape->subtable_valid(&header->common, ape))
 		if (!ape->probe_subtbl(header, end))
 			acpi_probe_count++;
-- 
2.34.1

