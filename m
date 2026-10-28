Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163675;
	b=E+5QFky47HiZLawdT3mXp0U9tjbMTV5Pkj1nWLMWwYkU6l6yoIXjF9twOltcGnWZtRh/
	 DsDChBOSFDZhD0nYMbgd6ik5WdAR/nDl6uEQIAY5dMOPv1rCi4gPDeUSSMDpWjEabQQFj
	 PSq6dh5irYAvfGWhwm5dS7H2IdaFm6u8AWQKjg9HR1y91AAZ20p47GEZc5EFLECJkK5pQ
	 0R8UzbW1g8u5CBP2Q6c1ABQQP6G6qYrBSzlw2cUkw1GVIMmUzKm0hAT92zAjDEteA5/S3
	 xfeYHdgxdiAuW0j+2CYsbO4PJd/atU+bOzQYSs/ES4BvTMTchQkcdLMMizZhpr9xBeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163675;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=82gVcSSXM3hsqhEYpcnfhId+zvDl8pHYrLa0s7kwebQ=;
	b=EFmOv+cDu+L+e1yWLw9DonhNtZNkhqPKI8str6rwjTxZd4vDapokKs++FQUUF4Hpt1O7
	 UL4aJNBObTM3xywey+75YgmsVnnFt+w+z6wtoeIbdluTpGXs5N8TMYwNr81ngabDpyp1T
	 3lgmY5NYS3de2N6bNtHAGB+1taynBeM4rnVKYW4NPyvqwV6iQBYgzq9x19cffy1WSbTSr
	 N7S/eg05uEzs80uot+ZvqT4KQP4hDSoa92P1AfdFTKDTAgzdyhvqeglWzSZvm/nLdUEN2
	 ezEk4rixuMcabH6H906pVyzl3Pzlvn7k9LTyAC3hznSHKH+0LLPRBVnkTkQzwr4pzbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=X3iXyfEi;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514DE606A31D;
	Wed, 28 Oct 2026 05:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 514DE606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=X3iXyfEi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=82
	gVcSSXM3hsqhEYpcnfhId+zvDl8pHYrLa0s7kwebQ=; b=X3iXyfEiZQpyYhsbCg
	gSWkbgbV1f5mV5D0DwCDiBV21g+t/kcm/w0Byj0pwPQo6PqU039gQ/7HSCqCxEeW
	cgSAJOQBX5UB6xrnKPLy2s1aHOZ9di5C7dgXnBxFfSWkm5r8Uye6UrsPakDyTb0e
	D2kuaRuA2mtDAl5lN97EaYnwk=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD31_V5geFquXTKDA--.16748S5;
	Wed, 28 Oct 2026 13:00:45 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Jonathan Cameron <jic23@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 03/12] irqchip/gic-v5-irs: validate MADT IRS entries
Date: Wed, 28 Oct 2026 13:00:30 +0800
Message-Id: <20261028050039.121080-4-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD31_V5geFquXTKDA--.16748S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wr45CrWUKr4UXrWrAFy3twb_yoWfCrg_ur
	W0vFs7JFW0kr1rKw4xtw13ZrWjq3ykWFn5ur4UtFn3JrWIvwsxAF1avrWfAa1kAFs2yan3
	GrZ8Ar4Sqr12kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8MrW7UUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzh6SzGrhgX7RmAAA3z

The IRS parser uses configuration addresses and flags from a typed MADT
record without checking its size. Reject incomplete IRS records before
accessing those fields.

Fixes: 35866efa52fe ("irqchip/gic-v5: Add ACPI IRS probing")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/irqchip/irq-gic-v5-irs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-irs.c
index 4e60a1caaba5..0139f80934d7 100644
--- a/drivers/irqchip/irq-gic-v5-irs.c
+++ b/drivers/irqchip/irq-gic-v5-irs.c
@@ -955,6 +955,9 @@ static int __init gic_acpi_parse_madt_irs(union acpi_subtable_headers *header,
 	struct resource *r;
 	int ret;
 
+	if (BAD_MADT_ENTRY(irs, end))
+		return -EINVAL;
+
 	/* Per-IRS data structure */
 	irs_data = kzalloc_obj(*irs_data);
 	if (!irs_data)
-- 
2.34.1

