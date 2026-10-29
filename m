Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793266388;
	b=oys/QRJPb/dbQmkh2CX+s8jp7I7NHvixsb5Lm/ODjpNQQLGgyVJmDrQ/wZlE9n6io9jR
	 NbIpJFA6MoxvmC4ognPV7esVKlQl9aNxsLWd4GvLXo5tm7/fL5z6XM+e1mAzp0nYQneO7
	 wQ1qvB7puS7L1uKJ8z7BRwvMeN1TQEPmTRRpw1ugSPMu4u9AshMy7UdaXIe1+9L2USAUz
	 Xi/6bYeOGsgxDiOnbk89rrgSHoubpGJcrZxhyjqCCuonGiOicZMn6zmHeALDzCozEZmMe
	 0GMD2IdO3tL2Z2ixL//WHYYjGUVKaOMGdFOWq3H7cWMx7tGd4tqm3JfBwl0H4MEfWsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266388;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=h0OxlhasgGGkCfFaBPePOXxcOimZvav0prXhM0QPRK0=;
	b=UA6V0+eVAw9sY1zgxsOF7cRfNAzOO9gHyce0iCj+SZA06KjBHWhirykAnKpl3UA5oCFr
	 mMZIJlIqqzcTogAiwGGi6QlpZw7JNGP8mDspDzg/GLGuLoqxapIBRgqi0ot8ZQ7wXDbRa
	 733ob8FampY27RJs4xs4Ir88JJltNV874Kwh29sdVVe4kzeo7npZUyEdv+H/HA6H+CRIB
	 8014CbH7CniysCogzABDeqhMPvfih1onZQ4kdUwpNM5vJvwmBFzAmNEXi3IhgjGZlmlN6
	 y+Kuz8YazkW41pZpgChphoK3JlOLIWCDoGMJ76MUS5fDuehJi0vq1zbGUO1FVO0Y9LQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fy+nlZpE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C20606A31D;
	Thu, 29 Oct 2026 09:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fy+nlZpE
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793266387;
	b=Rz91A9f1kFL1uNJXaGIR5fPAXum3YX6/sCr7FHqjCZulQO0UjoqBIF9m5aIy8ZDZV2/G
	 qOEL/dxDwkMDKXKV6MqkaMO3L06bwsyWbcgL1VmPNDjrHkBQK53jTs7clfyl7Ud5rJlTj
	 Mm3JAXuYywzNR3ZK/XuaTqZTpciHfPoEE+//vaFrKGpzlDnL3iV3Wc68iwF16ILwflp5P
	 Eb+TpdPf4LFLiwaY3BcPxDTFpCOUXypeYYls7DFHESRvt2s8Z388Q0lkxsWcfBGNt0weN
	 ffJqpMYoZuzN0M1m+7d78oLkvuFOl9aKEeVOD2qrAX/q/T3FMAVvbyK0mtlgDmNcsbA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793266387;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=h0OxlhasgGGkCfFaBPePOXxcOimZvav0prXhM0QPRK0=;
	b=JZyJvdZiOO4xW0uqmIxLtOM3gU+eqRpQ/NFyJiwmn/N5sE42S2ClzUz8A98w09HNOGF9
	 UEC64nly1IC1nsYPYF58CX+mF7j0fp7gTXtHjmJVPJg+cIRdMOgn2sv+jH2cdDz96/772
	 k9Iav2SAMPLEvyic6Tctdjr3vCA09cQrv0ZZ7xYVHh/sIWDmMBGIcgqEqDODKlBCXtwLk
	 NnwwEbuQCP0MQnwErN7vBNq5KUqOWeIwzq6ccoX3SaGAZ4lD7rGSRd7ad6YdiAhUQKFem
	 yyutUCTnZgVoIUPQMcHQCGvu2edlz1AkxZMLHvsn9hYm4aVA6QitRaxSXJgriGnfhIg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 851471F031E4;
	Thu, 29 Oct 2026 09:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793266387;
	bh=h0OxlhasgGGkCfFaBPePOXxcOimZvav0prXhM0QPRK0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Fy+nlZpExu5TDQ6/YvBzE/9jCbFM//CZdch+OMOpmXnZdk0RmYbD1xTmEHu/cS+3D
	 mklJq2TXuAGS0z0vho5ppfWFGqp4uxgbedD/iBsscD1XmclLHsu6h/PXG57hOfPvKN
	 0v2I0Svc/oKT7mb5Ya3ItvEN4smFjhEmFLqNaQ+fqOP8DzJh9rvufsXF2n80aWYuxS
	 0JjfURjDm8bOUTpWKvtU1BSB7o9HjPlSMXA9xvWxA4XA58TdLevkGxTiUmCmHHiaQG
	 qOcA5nTXHuduywjGLBl/C9hkQ43sZpg75ymjJa7wSNV1h+lZIUk1F8rWGaZX9/SMiO
	 rzmItTLLivWSA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 04B19457CC;
	Thu, 29 Oct 2026 09:33:06 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Date: Thu, 29 Oct 2026 10:32:59 +0100
Subject: [PATCH 1/3] soc/tegra: fuse: Fix Tegra114 speedo fuse offsets
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261029-upstream-speedo-t114-v1-1-81457cc9d94c@tsv-stahl-riesa.de>
References: <20261029-upstream-speedo-t114-v1-0-81457cc9d94c@tsv-stahl-riesa.de>
In-Reply-To: <20261029-upstream-speedo-t114-v1-0-81457cc9d94c@tsv-stahl-riesa.de>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Prashant Gaikwad <pgaikwad@nvidia.com>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, linux-clk@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Patrick Fischer <admin@tsv-stahl-riesa.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793266385; l=2745;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=4FiENUbMBaJsOEfAoSxwyoXv1XTgnVLUka3Tp+CNcmo=;
 b=1WDlGcfOvl96hHV72Uyr/1zpplR+EIC9+zmE0u9BsU6eLijGhWHzehlsSz5o1X9ncU1SbP6en
 EVSuILFkuQhBNXy5oI9Nlo+Pch3KOYUOtUbnULFYtNoogZWf0SEzFNI
X-Developer-Key: i=admin@tsv-stahl-riesa.de; a=ed25519;
 pk=D+v6EloYcEY9PIUHFyTM5sqcGIU/fIXzLUdkR8vjAtk=
X-Endpoint-Received: by B4 Relay for admin@tsv-stahl-riesa.de/20261020 with
 auth_id=1251
X-Original-From: Patrick Fischer <admin@tsv-stahl-riesa.de>
Reply-To: admin@tsv-stahl-riesa.de
Content-Transfer-Encoding: 7bit

From: Patrick Fischer <admin@tsv-stahl-riesa.de>

tegra_fuse_read_early() takes offsets relative to the start of the fuse
words at FUSE_BEGIN (0x100). When the fuse driver moved out of
mach-tegra, the Tegra30 speedo code was converted to such offsets
(FUSE_SPEEDO_CALIB_0 0x114 became 0x14), and the Tegra124 code uses
them as well. The Tegra114 code kept the absolute offsets from the
vendor kernel, so since then it reads the CPU and SoC speedo values and
the A01 CPU2/3 fuses 0x100 bytes too far.

On a Tegra Note 7 (Tegra114 A02, SKU 5) the fuses at the correct
offsets 0x2c and 0x34 read 718 and 1156. That gives CPU speedo 1742 and
SoC speedo 1156, which is exactly what the vendor kernel prints for this
device. The current code reads 172094 and 0, and so reports SoC process
0 instead of 1.

Today only the reported process IDs depend on these values, since the
Tegra114 core OPPs are selected by the SoC speedo ID and the CPU DVFS
tables apply to all process IDs. The CPU speedo value is needed,
however, to compute correct CPU DFLL voltages, which the next patch
fixes.

Fixes: 783c8f4c8445 ("soc/tegra: Add efuse driver for Tegra")
Cc: stable@vger.kernel.org
Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
---
 drivers/soc/tegra/fuse/speedo-tegra114.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/tegra/fuse/speedo-tegra114.c b/drivers/soc/tegra/fuse/speedo-tegra114.c
index 6695702bdb4c..1e6c2b5be759 100644
--- a/drivers/soc/tegra/fuse/speedo-tegra114.c
+++ b/drivers/soc/tegra/fuse/speedo-tegra114.c
@@ -14,6 +14,11 @@
 #define SOC_PROCESS_CORNERS	2
 #define CPU_PROCESS_CORNERS	2
 
+#define FUSE_CPU_SPEEDO_1	0x2c
+#define FUSE_SOC_SPEEDO_0	0x34
+#define FUSE_OPT_CPU23_DISABLE	0x16c
+#define FUSE_OPT_CPU23_REENABLE	0x170
+
 enum {
 	THRESHOLD_INDEX_0,
 	THRESHOLD_INDEX_1,
@@ -63,8 +68,8 @@ static void __init rev_sku_to_speedo_ids(struct tegra_sku_info *sku_info,
 	}
 
 	if (rev == TEGRA_REVISION_A01) {
-		tmp = tegra_fuse_read_early(0x270) << 1;
-		tmp |= tegra_fuse_read_early(0x26c);
+		tmp = tegra_fuse_read_early(FUSE_OPT_CPU23_REENABLE) << 1;
+		tmp |= tegra_fuse_read_early(FUSE_OPT_CPU23_DISABLE);
 		if (!tmp)
 			sku_info->cpu_speedo_id = 0;
 	}
@@ -84,8 +89,8 @@ void __init tegra114_init_speedo_data(struct tegra_sku_info *sku_info)
 
 	rev_sku_to_speedo_ids(sku_info, &threshold);
 
-	cpu_speedo_val = tegra_fuse_read_early(0x12c) + 1024;
-	soc_speedo_val = tegra_fuse_read_early(0x134);
+	cpu_speedo_val = tegra_fuse_read_early(FUSE_CPU_SPEEDO_1) + 1024;
+	soc_speedo_val = tegra_fuse_read_early(FUSE_SOC_SPEEDO_0);
 
 	for (i = 0; i < CPU_PROCESS_CORNERS; i++)
 		if (cpu_speedo_val < cpu_process_speedos[threshold][i])

-- 
2.56.0


