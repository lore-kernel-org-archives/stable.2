Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163695;
	b=e3/bzP8AmH5yEjK1laCH3/HRS2xLKjV5I0djIo0xr3oYmdO1L7ZHFCKH+pOI4l7hnSez
	 NBYL9gd+IAEGCUofVQvvfXbm+qlPKVhkghlq2dM1wkLK5PAgGY75xynEzEz/BDiFJ67CX
	 AQQsTfoKUeB6kwezUshXksBdraEiIAMIgX/AeNXjWKn8zMQ5Tn/MlLW/5xfLg7UmcRe47
	 kpmUaHnZZBVysNMJJGf5atCWaCGhxyiJdnzpN6QNhT/JdKzG8qKXwFsxkamDkPACskri3
	 ko1awoSid+tiKl5nok0h6gk9DIKaDVhl3yiHRhz5lAzLsagpGiEfWBnr3xrmWf25eag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163695;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=4EvimmkLbEENi9mMSmhBHB4VvqJZ5Y7K64ru9liOtoY=;
	b=eVKWwW4wh5HCgCJKBlHdxJnFgm/RV8EAcpqIpT+eaE0qqMJRkd1WYfWsqDFMmhqy98yr
	 k0ddAszT/wTAQX3VZ2h8KiinJcGU5oMSt6vm4dbPWlMFYdGEHIHWMkmIixqsOhgT3hF/H
	 SjsGEvV3eIMo268YF/6NXccMezfwYM4X3HU67KJtmzeGOvTgGUgmY5nVkb0jiHGUiYCPx
	 5d5VVDH8+iBhfHuJ9GDisy9T+6gSKCbRmDHje2Uamcy0COZYJlL+3aJqskq02Lxn8BB6H
	 ydVQ8WwVVDsXS1OmHzPD3NfwKysIDBJfTxxixfz2S/MvVsnheqjY9BUTwKRtAhODroQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cF10Rn6w;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7C560A383E;
	Wed, 28 Oct 2026 05:01:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C7C560A383E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=cF10Rn6w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=4E
	vimmkLbEENi9mMSmhBHB4VvqJZ5Y7K64ru9liOtoY=; b=cF10Rn6wgQlrn8NFJT
	ewfwADxuAXDhWAIzNZlidzIC45KA4Oa3EHqty+O/gNjG9eiYtOpxxUW1xEkH5fs9
	Jqi3kV2xp3N9wKCkTTTICAHxXSMFrWoeeBC7vsuMSwAC/B1AnQ+Jt4tD+dyzPqbi
	ZF2P4equR3mm2X/+19jDTcQUY=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD31_V5geFquXTKDA--.16748S3;
	Wed, 28 Oct 2026 13:00:44 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Andrew Jones <andrew.jones@linux.dev>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 01/12] riscv: acpi: validate RINTC entries before use
Date: Wed, 28 Oct 2026 13:00:28 +0800
Message-Id: <20261028050039.121080-2-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD31_V5geFquXTKDA--.16748S3
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWxKF1xAryfCr1UGr1rZwb_yoWDCrg_C3
	Z7Z34rWr9akFW0qr18J34rurW5Kw1fAF95Cr1avrWUGFn5J34aqrZxAr95AryvkrnYgan3
	Awn0k39F9r42vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbfcTJUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRySzGrhgXyYzgAA3v

The RINTC callback reads flags and other fields from a typed MADT record
without checking that the complete record is present. A truncated
firmware entry can therefore cause out-of-bounds reads during CPU map
initialization.

Reject incomplete RINTC entries before accessing typed fields.

Fixes: f99561199470 ("RISC-V: ACPI: Cache and retrieve the RINTC structure")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 arch/riscv/kernel/acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/kernel/acpi.c b/arch/riscv/kernel/acpi.c
index efd52a5d05b5..9e0658c6a869 100644
--- a/arch/riscv/kernel/acpi.c
+++ b/arch/riscv/kernel/acpi.c
@@ -171,6 +171,9 @@ static int acpi_parse_madt_rintc(union acpi_subtable_headers *header, const unsi
 	struct acpi_madt_rintc *rintc = (struct acpi_madt_rintc *)header;
 	int cpuid;
 
+	if (BAD_MADT_ENTRY(rintc, end))
+		return -EINVAL;
+
 	if (!(rintc->flags & ACPI_MADT_ENABLED))
 		return 0;
 
-- 
2.34.1

