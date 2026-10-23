Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792742931;
	b=cD+vVEPvVPylPsrsSYEMCSvTiL+GQBqqTzE94qxfJiFCmREPmIceGpal1GXDk6gybhmr
	 fbsZ04MXYLt4WuGxCOv4+j3oJOjOuql9bsNZU/DMbciPrTHGddYYRD11d9qU3pNr3yc0X
	 vVmqUYSReHMplNbxqfgar2vADEh2SMjUIsD8M+X2XdRFDW3pHGBxWElxr4CqdEcnUI/KL
	 HnU9bgCUzXJgtzqPOKCRroiVhaDu0Z/mxdept3lqexIaT6udmWRrq+4r0Hi+8XOjDc7RH
	 4iHcdM2aSAXpimLEY9H6/qMOJHI9MwDHiDKZJ3lnnRp06hcICFAlNOIAvJT9yuAtAMg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792742931;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OUxHrAdIJmtAYV0D6DcRF/F/6snaNqW+gmN/qYltlb0=;
	b=sj9tzUPCuBfvonLMlNCcsAkEsO5/yGOwzF2Sf2J+hTc9536T/tbtKUnGxYZ507aQ5TCM
	 hZg+QnmOjluv1JB9fKOpkXa/GKmf5dZm4qQijZZtkNrBV6u3+pvCrSRydOfzQDD2Hpb8c
	 wBplv811aeskPoZSF5rWGCR2RyhhlntNao7W1nb84J6RmpH2jv8u+L9h5UaiKF7VL2ZQE
	 pY+WXvJULoyGZXbiG5e0hWHXwCopmQE4eacO+BwRVTJO5/SFeG/juq/H6ziEJ4cqWnWBM
	 2JM9yuJUemJFpDSSPoYX5tG/y/1s2u/JcosNp1znnADZaLgWGdtL+6IykCTZ8JE6Wqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wfi6VG+G;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFA9606A323;
	Fri, 23 Oct 2026 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wfi6VG+G
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792742930;
	b=lHeo68DnlkMyKpju0/I6ULa+5SMJlj4aANZXRnsWxWBA6u4VAaNUceIOhEyZ27DRoPG+
	 5NwMGPnbSa4VsxiNB653SxY5Oetv7BE8y8VeVdy5bcSX6BE6LPByIzDNcWBoCs0ZtIsFH
	 afpRzDX7vAVWj1E1/UsDHYc3xs2hsUuidiFEu/GUWkrS/3a+UqY8Va7Uruyh8BLTMulmB
	 DVPalh9x6UF9GtF3DnYURWb8OAAERKTR2qrJi/9OjCyl9DDGiv+JmPcyHQJCRcRL021lP
	 euryRsNtsaM2OG5QCqBED+x6PqmbtvW/aSynngkWx+GUE+aMdQHIatda+mPt2hfG4BQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792742930;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=OUxHrAdIJmtAYV0D6DcRF/F/6snaNqW+gmN/qYltlb0=;
	b=Qy1t17Gpc6z3w/dsIGlTJRcTWKNL+TomdRVQ2+FhBtwmJt4Bw6z02A1jzasjTIAqqrPR
	 Uqrxn68CfMgNeiz66C8ugS2C1H6QQGm4i5CA2V7uYomfLxwkF/MkSa1FsknuhibTatiYY
	 Tg3Bm9UeD5VQ9e53svF4rmv0Qldjj6OX6NySwATRyhED9Lpa+rFPvuSjyLQ9soavC7n5f
	 JHHCJsHKxOscIQzradAdpCC9rM6z2+BBKIjfHdhYGC5G2GIbahew6OUHFoROeu18CbkSR
	 8JB+4gwy2O3AjBFqCZH/JAfJ3rf1oDg6qP3nieqTYpYpsa0owB2pL3+pTHvTk0cbs8g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id DAC7F1F01829;
	Fri, 23 Oct 2026 08:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792742930;
	bh=OUxHrAdIJmtAYV0D6DcRF/F/6snaNqW+gmN/qYltlb0=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=Wfi6VG+GiD+Y0/b21YtjpBWBJ9VhvLxG/3VATcxtJ2RvFpUYRCqiM5VRL5mDIIDk1
	 eJERdO6JHeIkjLbbfOWXtD23+zj0my5lLi/dENU7Nk34WcB2WQrH6FGlgr0z7BO+RA
	 SFVk4+1T6eq6AhiHfcX3jDHZur8kqvjIgxqcf5xTutq7jhT96oSTxcvrW3BzaNKyP3
	 dqiJ6lj0zQV94NR4DN2RwOlmcyftL/FTa2cBOnzXVkp1kkpCigWKlv28fC2CIrV9Ni
	 PPzv6SwActE6Iav0PFtIFvx8ep3u4MagCsvYucSazOoz6og11FzU3QlOYdgC2FtgUB
	 ZX09iooA6gHsQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 55599443FE;
	Fri, 23 Oct 2026 08:08:49 +0000 (UTC)
From: Awal Awal via B4 Relay <devnull+awal.nova.gmail.com@kernel.org>
Date: Fri, 23 Oct 2026 10:08:45 +0200
Subject: [PATCH] platform/x86/amd/pmf: Fix memory leak in NPU metrics query
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
Message-Id: <20261023-amd-pmf-npu-leak-v1-1-798e7161bfba@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBA0auQWTPJ0BKiXsWwqGWKo1KblhoSw
 t2psHyL/1dIHIUT3KoVIv8kydcXNHUF9mn8yChDMShSXUNKo5kGDJNDHzJ+2LzRte3V6IslTQQ
 lC5GdLMfy3p9O+fFiO/8/sG07ppGRFXQAAAA=
X-Change-ID: 20261023-amd-pmf-npu-leak-f449a38c0300
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Lizhi Hou <lizhi.hou@amd.com>, Mario Limonciello <superm1@kernel.org>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Awal Awal <awal.nova@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792742928; l=2529;
 i=awal.nova@gmail.com; s=20261023; h=from:subject:message-id;
 bh=1bjGttJlIKK90PokbdtL9brjGLD+8hVegScmsmTQyH8=;
 b=qI5h+6XD1sXXYtGPyE9ijcPejx4iL2AwYuBs1zP7tlGEssCU9Ln+c3edzB+QHoiwKS44YIxC3
 cMv68bxQ6R7DxsHLeL29Xy4Kity9Z2S948WZaQK2CQFQ86L5ZZ8lBvu
X-Developer-Key: i=awal.nova@gmail.com; a=ed25519;
 pk=wrV+x9VJEgMwdldj38seKq88Gn1n1guE6xG6rtmR6Fs=
X-Endpoint-Received: by B4 Relay for awal.nova@gmail.com/20261023 with
 auth_id=1286
X-Original-From: Awal Awal <awal.nova@gmail.com>
Reply-To: awal.nova@gmail.com
Content-Transfer-Encoding: 7bit

From: Awal Awal <awal.nova@gmail.com>

amd_pmf_get_smu_metrics() calls amd_pmf_set_dram_addr() with
alloc_buffer set to true on every NPU metrics request. Each call
devm_kzalloc()s a new metrics table buffer and overwrites dev->buf with
it. The previous buffer stays on the devres list and is only released
when the device is unbound, so every request leaks one buffer.

amdxdna calls amd_pmf_get_npu_data() for its sensor query, so any
userspace monitor that polls NPU utilisation through
DRM_IOCTL_AMDXDNA_GET_INFO leaks memory for as long as it runs. On a
Ryzen AI 9 365 (family 1Ah model 20h) laptop with a system monitor
polling about 1.4 times per second, the kmalloc-512 cache grew to 5.8
million objects (2.8 GiB) over 38 days of uptime.

The buffer size depends only on the CPU ID, and the buffer is usually
already allocated by amd_pmf_init_metrics_table() or
amd_pmf_init_smart_pc(). Allocate it only if it does not exist yet and
keep reprogramming its address on every request as before.

Fixes: 118222e20d16 ("platform/x86/amd/pmf: Introduce new interface to export NPU metrics")
Cc: stable@vger.kernel.org
Signed-off-by: Awal Awal <awal.nova@gmail.com>
---
Tested on a Lenovo Yoga Pro 7 14ASP10 (Ryzen AI 9 365) with the
equivalent change applied to core.c of a 7.0.14 based kernel. With the
Resources app polling, the unpatched driver made 84 devm_kmalloc() calls
for 84 NPU metrics queries in 60 s. The patched driver served 106
queries in 60 s, all returning 0, with no devm_kmalloc() calls and a
flat kmalloc-512 cache.

Up to v7.2 this code lives in drivers/platform/x86/amd/pmf/core.c
(it moved to metrics.c in v7.3); the same one-line change applies to
amd_pmf_get_smu_metrics() there.
---
 drivers/platform/x86/amd/pmf/metrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmf/metrics.c b/drivers/platform/x86/amd/pmf/metrics.c
index 5c0e368ec..6bad7a409 100644
--- a/drivers/platform/x86/amd/pmf/metrics.c
+++ b/drivers/platform/x86/amd/pmf/metrics.c
@@ -261,7 +261,7 @@ static int amd_pmf_get_smu_metrics(struct amd_pmf_dev *dev, struct amd_pmf_npu_m
 	switch (dev->cpu_id) {
 	case PCI_DEVICE_ID_AMD_1AH_M20H_ROOT:
 	case PCI_DEVICE_ID_AMD_1AH_M60H_ROOT:
-		ret = amd_pmf_set_dram_addr(dev, true);
+		ret = amd_pmf_set_dram_addr(dev, !dev->buf);
 		if (ret)
 			return ret;
 

---
base-commit: 893018d51f27ec0449155b0afe371aaf65380630
change-id: 20261023-amd-pmf-npu-leak-f449a38c0300

Best regards,
--  
Awal Awal <awal.nova@gmail.com>


