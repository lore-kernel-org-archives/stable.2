Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793246039;
	b=YUQVwbn8jsiymDWHk/C0Go/wL+D91GD6RJ0AoHt/b8rLtTTZd00IXaFFHM0uq+rDSje4
	 hY84HTGR8tGltPTGUI9ZBIGS7nhLqhECPWN5NY9EKWauGCMb7Tm6LTxUhEgxBHkDKIxDS
	 ZBYxPJX5L/UFUN4cOxqVjTTRv05QbinkpQCqF81Wj/ewO9rhaAbKguOTuauPIgbYJmDYb
	 X0NG7ycKqBcEoR+ccsuAn7uS1TSdCmOU4fcgz32vf+9qy35szOLAAkYV8Vlc0rgxbLmZt
	 CfPJxbkBZatn1zIaE8aOg4HDvF/2+OwXut20k+dJ8fIObUjsBPUMHJgAHAykG7vCbrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793246039;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=otVPgR69rapmEguUIGNpGUBHey5Mb7pxmVbkoiOMICE=;
	b=rfQfz+W18alUF5d158St/EfylAkISwIu9RfXF8mCHir6BwkyYnS3KouLc2y8IzaGGl5z
	 cvXq7g0cU41odfuaU1VIIx7rrfcG33x/1mEWJWFkkbywpnWHyajx0J0fIigFaHbVk1RJY
	 TY4dvlq49qvXORvHE4+SkPj//O3rExRDuMGxpSRLO8p4/0CComVPBcz0gXP7WjE4+EGZd
	 10+H89lPE1sJvfhmevvw71rBs71xxA7f+r2HQ0nVGGItUQcXZNnla/Z3yRlRRTO2eW5jb
	 ERg79OPmBfiVYb3iw8cVU6xkx6S0xlITC4PJRsgFUzqkoDZ9f3dlQNToCYx71c+cTHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=aMZcUyuG;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E67606A31D;
	Thu, 29 Oct 2026 03:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5E67606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=aMZcUyuG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ot
	VPgR69rapmEguUIGNpGUBHey5Mb7pxmVbkoiOMICE=; b=aMZcUyuG4d6BwZBsb7
	Aq41lFcTAGiw//e96sgwFF9tfftGb1CH77SJ7aNoJbJdFDzhPW/pZVQYYUm7Tnep
	PslkNujfz8JEceDdYqViwuU3+sSKreECE1fjYsLAXRCGV3w4RMVM1YoQpLIdRku4
	x21M5frhsj5BrLe8F8cWWc7zE=
Received: from pc.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgCnsSkVw+JqTWv_Cg--.16381S9;
	Thu, 29 Oct 2026 11:53:04 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Jones <andrew.jones@linux.dev>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sunil V L <sunilvl@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 07/20] riscv: validate RINTC entries before use
Date: Thu, 29 Oct 2026 11:52:38 +0800
Message-Id: <20261029035253.2333852-8-yaojiale02@163.com>
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
X-CM-TRANSID:PigvCgCnsSkVw+JqTWv_Cg--.16381S9
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr43Zr4fWFWfZry3ZF1kZrb_yoW8XrykpF
	4DKr98Wrs5GanFg347tr4kuay5ArsrGa1aqrWjka4UtF47Gr1UXasa93WY9F98tF10gay0
	9F1Yv3W0va4UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UPWrAUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQBMhmriwyDjuAAA33

The RINTC parser reads the flags field before checking that the MADT
entry contains a complete RINTC structure. A truncated firmware record
can therefore trigger an out-of-bounds read during early CPU discovery.

Move the existing BAD_MADT_ENTRY() check ahead of the first typed field
access.

Fixes: ce92546cd637 ("RISC-V: smpboot: Add ACPI support in setup_smp()")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 arch/riscv/kernel/smpboot.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index a9de2dae804c..9c341398058c 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -76,6 +76,9 @@ static int __init acpi_parse_rintc(union acpi_subtable_headers *header, const un
 	static bool found_boot_cpu;
 	struct acpi_madt_rintc *processor = (struct acpi_madt_rintc *)header;
 
+	if (BAD_MADT_ENTRY(processor, end))
+		return -EINVAL;
+
 	/*
 	 * Each RINTC structure in MADT will have a flag. If ACPI_MADT_ENABLED
 	 * bit in the flag is not enabled, it means OS should not try to enable
@@ -84,9 +87,6 @@ static int __init acpi_parse_rintc(union acpi_subtable_headers *header, const un
 	if (!(processor->flags & ACPI_MADT_ENABLED))
 		return 0;
 
-	if (BAD_MADT_ENTRY(processor, end))
-		return -EINVAL;
-
 	acpi_table_print_madt_entry(&header->common);
 
 	hart = processor->hart_id;
-- 
2.34.1

