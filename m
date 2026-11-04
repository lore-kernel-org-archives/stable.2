Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793831828;
	b=L6NgAMgk1skD3ETOrq4rjx8urHCmCTvRPBXW0KXx6CqJ8GjrKk/2Np3PRbhRGkl3+4Ju
	 9zzsDDZJ3HbLKOHlGNzMRydu7kfyHGITgthOX0T2EtoPXDgPt+hP1ji0btyuZp+rVP4DS
	 skldWHb/iLDK1cD3xYwVKFutRg+M/7LV8qHafY7+uiMh8Cq+O59GZlDJ3u0xW1w+y+imy
	 kpCxJi+tR0W3/35EqMWqTAuD5jKYffxw61V3/Llbuu3gPwubZlATykOjQMip6aMeeBddJ
	 QkfBiozNY68ZwQTD35E3H2ePyAi4EYaoIn/0wbIJoCNHPREXN+FBQ/rp60mCv9S1tOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793831828;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=H3JaIieos+KyR6zzBZXfF2wHbDwa3oT6SC6JNt66htw=;
	b=E0hTOSiU6uR7qcNruuVWASDTAYO1qT8MxaV2zp+Hk50i713Unw1Hh0n7z7yF1vQyy4/c
	 WhsfanX1rEqedytcjSe8CJKsKiTy/6eAFeWAXtm4lZ+bsuTZ5pvIJcvYhvuXWJjbpC8pe
	 w1iFIcwgbOhcf+SkPDj4DQ6Ys+2qje1YrkBsbtE5MOQJN+9iqxTnkqyvZ3IWaU+Eha+GH
	 dwWg8Ji9sIK9eROqF7mTEsRNVu7tzxJZ5qYMYjgjqRh5S0kLDTd4lZiC104Zk5Whv+M1L
	 oSn5wlyDHU8t9RLyI4ih0HsH45XY0CjF+YOLVm8/5wf/bvaPVBI211sPXbFKmV8yyKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AE8r3Vsh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BB1606A878
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 22:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AE8r3Vsh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7031F00919;
	Wed,  4 Nov 2026 22:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793831827;
	bh=H3JaIieos+KyR6zzBZXfF2wHbDwa3oT6SC6JNt66htw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AE8r3VshZscfIidFRO9uFFFvyY7zoc91oljSKaDCbUzFGuHWuzOb8lvznC/ej7155
	 tWq3YWZuQeUTnsCNiE4SDy/t7x7GDAgIl4xWawPOzt1+rn4K5eFDvkLQgFFY21Zlp0
	 vSCxHVwP6YBFv64tDtT3MdHe8MqIMo3NK/VLk3vXwDeW9BZsJvEG+vCTpOFU2Q4j+9
	 9gkP7Pezl/h788iZyQ1mtFRxGzcQm2BKylhSyM0RCJqtiOEPL6xgBdn06y8Up0o5xs
	 4l0wtqgGxna0qZdj7pFuRdRcbDmM8919OrjEGjJtSq/bwOkOsc0ODMxTK3iHwFwiGE
	 +aK6n9Aj/3wyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fan Wu <fanwu01@zju.edu.cn>,
	Song Li <songl@zju.edu.cn>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ASoC: amd: ps: fix snd_acp63_remove() teardown ordering
Date: Wed,  4 Nov 2026 17:37:05 -0500
Message-ID: <20261104223315.540991-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110455-remark-unbuckled-2216@gregkh>
References: <2026110455-remark-unbuckled-2216@gregkh>
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

From: Fan Wu <fanwu01@zju.edu.cn>

[ Upstream commit c53791d673ed4da6759d276078627ec4d0c6536b ]

The ACP IRQ handlers dereference the SoundWire, SoundWire DMA, and PDM
child platform devices, but snd_acp63_remove() unregisters them while
the interrupt is still held by devres, which frees it only after remove
returns. An interrupt in this window is a use-after-free.

Mask the ACP interrupt sources and call devm_free_irq() before the
first child device is unregistered. The masking goes through the new
acp_hw_ops->disable_interrupts callback, keeping the remove path
platform-agnostic. The interrupt line is shared, and acp_hw_deinit()
clears the sources only after the children are gone, which would
leave the line raised with no handler left to ack it. The window
predates the tagged refactor, which only reshaped the dereferences.

devm_free_irq() waits for in-flight handlers, but not for work the
hardirq has already queued: acp63_irq_handler() schedules
amd_sdw_irq_thread on the SoundWire manager. Draining that work in
the manager's remove path is a soundwire-side change and follows
separately.

This issue was found by an in-house static analysis tool.

Fixes: eaf825037d6d ("ASoC: amd: ps: refactor acp child platform device creation code")
Cc: stable@vger.kernel.org
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Link: https://patch.msgid.link/20260929061349.3879-1-fanwu01@zju.edu.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
[ sashal: Replaced acp_hw_disable_interrupts() with the existing acp63_disable_interrupts() helper because the hardware operations framework is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/ps/pci-ps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index eb4b552c94241..8875989d63651 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -724,6 +724,8 @@ static void snd_acp63_remove(struct pci_dev *pci)
 	int ret;
 
 	adata = pci_get_drvdata(pci);
+	acp63_disable_interrupts(adata->acp63_base);
+	devm_free_irq(&pci->dev, pci->irq, adata);
 	if (adata->sdw) {
 		amd_sdw_exit(adata);
 		platform_device_unregister(adata->sdw_dma_dev);
-- 
2.53.0

