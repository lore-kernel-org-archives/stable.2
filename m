Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300389;
	b=c0jCwT/1RiI2BkuOs2qVFfZJTIrUhdhqzpntR/NODj2Oh67E3m5b9y9GVmVBAxjru4xu
	 q2McSSeEaxTswTZUiINN9/8nrkOF5V/pe0snfYfHk6Yb39zUBJVgyMGLP65mHMnmDLxz8
	 bZf1+QV7nwxjVzERcK/r7x9+fVWS5bRFF3wNScqOQScMBC40nKGTRldsf0MqqgKR3YQDu
	 fKTT0vzWXwoWocl0IZW6S/y43CDaqshUVtr8TcMY+qIiE/knNbOc4MOQxxqSYqJZhZL8E
	 VAMnqHsxlcbsmdfGfWlfe9btqsv1kIWhCzoLp0QdDmB4x2ZZAre8AuEsAgCHmHu0n/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300389;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=yTxQRIKb91hGqSfuLGVfd4S0vAmf1MtK/tZCS/84+4c=;
	b=Rhvr2cag3G1hbD9J9d0jhpr8FtX8/7Lv/ypPRtT5qh76+bbEn2NCU+lrNgxSDmqDKcRT
	 ezejZFajpdZUEHe90/VimOSY0dS0fyuqdHxTCFIJmqhFkmPewEh33zqFCBXSsQeOqULcB
	 SCfaIQL1fcuGEkymGrA/gsFzcBKdBLWmDrnkSmMIKk/IoUVtNz/JNa5gnXePz4pqW3BCI
	 OU3u147Rnvnj1E5uvSH71pmNFHVB5sDJuxxoJP7u+vIB9XLV0k8udTgzWkZZ6ly34j45n
	 ZzES4WPrag+n6ZYch8fjOVUnu2F9oobsF0H+f2JPTZRPec/9OAuLRoxpoyIL3sWXAOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E1E606A31C;
	Tue, 10 Nov 2026 08:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85E1E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxntLi2fJqdB8eAA--.21158S3;
	Tue, 10 Nov 2026 16:46:26 +0800 (CST)
Received: from localhost.localdomain (unknown [127.0.0.1])
	by front1 (Coremail) with SMTP id qMiowJCxe87e2fJqWXMzAA--.22061S3;
	Tue, 10 Nov 2026 16:46:25 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	lixianglai@loongson.cn,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ACPI: LoongArch: Fix incorrect pointer argument in acpi_iovt_init()
Date: Tue, 10 Nov 2026 16:46:12 +0800
Message-Id: <20261110084613.2746641-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20261110084613.2746641-1-maobibo@loongson.cn>
References: <20261110084613.2746641-1-maobibo@loongson.cn>
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
X-CM-TRANSID:qMiowJCxe87e2fJqWXMzAA--.22061S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

In acpi_iovt_init(), hdr is of type struct acpi_table_iovt *. Passing
&hdr results in a pointer to the local variable rather than a pointer
to the IOVT table. Drop the address-of operator and pass hdr directly.

Fixes: a9b0c34507eb ("ACPI: LoongArch: Add acpi_arch_[late]_init()")
Cc: stable@vger.kernel.org
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 drivers/acpi/loongarch/iovt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iovt.c
index 87cee4f0fc80..6c5bcb4df7d8 100644
--- a/drivers/acpi/loongarch/iovt.c
+++ b/drivers/acpi/loongarch/iovt.c
@@ -184,7 +184,7 @@ void __init acpi_iovt_init(void)
 		return;
 	}
 
-	iovt = (struct acpi_table_iovt *)&hdr;
+	iovt = (struct acpi_table_iovt *)hdr;
 	iommu = ACPI_ADD_PTR(struct acpi_iovt_iommu, iovt, iovt->iommu_offset);
 	for (i = 0; i < iovt->iommu_count; i++) {
 		iovt_enable_acs(iommu);
-- 
2.39.3

