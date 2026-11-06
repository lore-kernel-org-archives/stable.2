Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=121.254.168.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793943743;
	b=2ql/SZ0cEuXswYMxv0/MwV2OSRsfK+D3gMK8R8BFqBrLRh9+PPf/439nluil/LCXA5Hu
	 ujlPtnKWr6RqMO9fyGAYaaUSOUmKeCiBKAv0ApAYJx8i5TaRbzckoL1oEgL1ie+vkUfzg
	 y09tZcF9zhF18wc9nKqJes+Q23UYWz8HaUGWdOmxLjcXXPl8+yAno3KKS2htIfaTQFFUy
	 VbbC/FyJV4jzWmjU0cnhyLkIzCIy3xXz5EMmgJlLNT6hlm+Fl+kQYzeuOZHIDwOGqTGpQ
	 hioc3yohVdH8Ww+NifGUTWokY0JjqJ1OXCIpS3p4UoyzcVJNHDBvoN+x6NCJIOmSRtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943743;
	h=DMARC-Filter:Received:Received:Received:X-Authinfo:
	 X-Hiworks-Remote-IP:X-Hiworks-User:X-MailFrom-INFO:Received:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sCjK+eSjFwVT1Le/uIyIA/BxA96L8az923s+JnTYtYk=;
	b=2ltlYTEclZCj6o0TdN+tX9zGgm8OLHMJTtF/x2GQY3sHCwVGXumcAW4McvZ7UJZGXbNz
	 fj0K936GwfvXxsxJNqsJa1ohmsZHpAo1mMz5/VRJ4ApQKJWxCm3N2TGKEPIDu4NeiXftY
	 +SOjMWccfGBJKso+E32cRfvn2s2fsE5zORIQjM7LHVnWxbOYxPWlKADa+n4h1wSMhTloJ
	 sOXlO6ON3mB2fNtJiYHoHc3iDuvpb7n108iAoMIo/JqwjAf1YBWa6sKpnDyJa1Kf18ozN
	 zxq07dEDoro0hRfLypQ+C/i5Q6i3lGG4KkvA6pRnAUoJBIX9wl2z15UrQjLNfd0Uwsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=nirvanahyj.com;
	spf=pass smtp.mailfrom=nirvanahyj.com;
	arc=none smtp.remote-ip=121.254.168.205
Received: from smtp3.hiworks.co.kr (smtp3.hiworks.co.kr [121.254.168.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE9A606A333
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 05:42:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FE9A606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nirvanahyj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nirvanahyj.com
Received: from hi-smtp-node2 (unknown [172.18.0.2])
	by smtp3.hiworks.co.kr (Postfix) with ESMTPS id 4jLSjz0vN3zYmkF9
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:42:15 +0900 (KST)
Received: from hi-smtp-node2 (unknown [192.168.71.87])
	by hi-smtp-node2 (Postfix) with ESMTP id 4jLSjz0Rm2zQLN7K
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 14:42:15 +0900 (KST)
Received: from hi-total-node5 (amphora-3294b420-308a-4b9e-8a1d-bf25580dae1f.openstack.gabia.io)
 	by hi-smtp-node2 with ESMTP id vr5n2kknz427rm77;
 	Fri, 06 Nov 2026 14:42:15 +0900 (KST)
X-Authinfo: HIWORKS SMTP authenticated <nirvanah@nirvanahyj.com|114.203.237.180|nirvanah@nirvanahyj.com|261106144214_8061351674>
X-Hiworks-Remote-IP: 114.203.237.180
X-Hiworks-User: (SASL_USER) nirvanah@nirvanahyj.com
X-MailFrom-INFO: <country_code:KR|rbl_level:0>
Received: from localhost.localdomain (unknown [114.203.237.180])
	(Authenticated sender: nirvanah@nirvanahyj.com)
	by hi-total-node5 (Postfix) with ESMTPSA id 4jLSjx6ghZzSqYcR;
	Fri,  6 Nov 2026 14:42:13 +0900 (KST)
From: Young-Jun Hong <nirvanah@nirvanahyj.com>
To: 
Cc: stable@vger.kernel.org,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] iommu/io-pgtable-arm: use inner shareable for Mali LPAE on a non-coherent GPU
Date: Fri,  6 Nov 2026 14:41:48 +0900
Message-ID: <20261106054210.2893230-2-nirvanah@nirvanahyj.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106054210.2893230-1-nirvanah@nirvanahyj.com>
References: <20261106054210.2893230-1-nirvanah@nirvanahyj.com>
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

io-pgtable marks every ARM_MALI_LPAE PTE outer shareable (SH = 2). Outer
shareability is only meaningful when the GPU sits behind a coherent
interconnect, i.e. when the page-table walk is coherent (cfg.coherent_walk,
which panfrost sets from the dma-coherent DT property). The vendor kbase
driver on a non-coherent Exynos 5422 (COHERENCY_NONE) never uses outer
shareable: its PTEs are non-shareable or inner shareable.

On Exynos 5422 (Mali-T628 MP6, ARMv7 LPAE, not IO-coherent) the outer
shareable attribute hangs the whole SoC when a large GPU buffer is first
used under GPU bandwidth load and memory pressure: 0 of 22 runs survived
with SH = 2, 3 of 3 with inner shareable. Non-shareable also avoids the
hang but breaks global atomics between the two core groups, so use inner
shareable for a non-coherent Mali; coherent configurations are unchanged.
Sustained GPU copy bandwidth also rises from 6.3 to 7.7 GB/s.

Tested on Samsung ARTIK 10 (Exynos 5422) with panfrost and Mesa Rusticl:
hang reproducer clean, OpenCL accuracy suite 96/96, no GPU faults over
several days of use.

The analysis, the code and this changelog were produced with Claude
Code (Anthropic), a coding assistant.

Fixes: 7618e4790982 ("iommu/io-pgtable-arm: Improve attribute handling")
Cc: stable@vger.kernel.org
Signed-off-by: Young-Jun Hong <nirvanah@nirvanahyj.com>
---
 drivers/iommu/io-pgtable-arm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
index 476c0e25631a..0e7b2edd9ca1 100644
--- a/drivers/iommu/io-pgtable-arm.c
+++ b/drivers/iommu/io-pgtable-arm.c
@@ -565,6 +565,13 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
 	 */
 	if (prot & IOMMU_CACHE && data->iop.fmt != ARM_MALI_LPAE)
 		pte |= ARM_LPAE_PTE_SH_IS;
+	else if (data->iop.fmt == ARM_MALI_LPAE && !data->iop.cfg.coherent_walk)
+		/*
+		 * A non-coherent Mali must not mark its accesses outer
+		 * shareable; inner shareable keeps atomics consistent across
+		 * its core groups.
+		 */
+		pte |= ARM_LPAE_PTE_SH_IS;
 	else
 		pte |= ARM_LPAE_PTE_SH_OS;
 
-- 
2.47.3

