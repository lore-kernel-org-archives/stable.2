Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627920;
	b=dNlkl66CFtmYME3YeaPZbvC5Z5X6Ot6ji80AfswKpbcSY/ZSpFXdbNWnJ+xXyiDUh06Q
	 dE2Bs5o+IOtSwDuBK+LDDMaLzJIogKHxKDyk0nQa0vhgbLI5zrQVCXWJmXVqg8oBdDaqZ
	 I53hqrVzaxngkiaKkXxJKevihefe4bynnRGV9mG1YRXyfQqGYnP4jSqSb0xzsjjpehBbv
	 i45UeDbiPPo0ZTFT2Jtr39WfAbUV+bzIT4uap1X5ennIl6pL1OZxdWOclJXFv2cl74Lhx
	 ybvklIjBbuk+nSh9vU7+guPA2RPDUnfHvWVIN4S/a6Pd3MIPdhsGImz9YJ6KHQy+Smg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627920;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=UsABZ0lwLfggHeYm6LleXhMVDT34BdvM7eLvAqIcs1s=;
	b=hROiO7hfoTxbmLd8C4kGGvLQaAB9U6SUIkA2N9IKVu1A4o+eAlHpOI/ge7a7Soupt4Z0
	 ig7Qnoe1Yvt0ErhmWnj8o5v3ZjteMpFNit44STcm2ZT7O2AXIwu8VTaDE2Ou07PyiRqsh
	 XeZlBa4hKlnYq8NNYBuJfA2gK29aTlsPS1ZNnxsFRHg0b5xSU7zmrQrvDYzUuThaHkxEs
	 IM84/s5k3YFWzs0FykxLAV3Xg0tczoGJIDofqS1tn/d1nq/IJ6ECaZalvNI5FZ3GFEuJq
	 nVTT8s31SwT2IItZUANYQ6jPrSY7Gur0+c+SaaUMlt6T1Yw5fRorF1zIXmSL1aq42CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UixUaAxt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55B860A2607;
	Mon,  2 Nov 2026 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UixUaAxt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230AE1F00A17;
	Mon,  2 Nov 2026 13:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793627919;
	bh=UsABZ0lwLfggHeYm6LleXhMVDT34BdvM7eLvAqIcs1s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=UixUaAxty87lFuFytIWEIUzRYsaJcDzVgHw6J++nAujqPiznIGfndAP6SvC8gumRO
	 Qv0ONZx0X/W39T3e+iQwLSl7ca/UnU3vvNGEUlSooWAPEje9WHGZpF/V3kFf29Br5/
	 6+Kf+mObBUGzKDK7GX+Cv9//mCEyipvBFuZzOD3kjdRP6k/O6GEwjmNUrFk7jwkj4q
	 PKc0taGGg6dJFa/g6VkGEi5XNb850jqrLv6XpYPYiDRheV/Yq7wxB/xqlA0x3UK/Qk
	 JnJ+j6aIGzGXpA+rtUG6fIerNRmQoTD0U0H6CScikxnbxmo/YLIPgGZJOU+wf0KYr+
	 mAfmR8fDoFDjA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-mediatek@lists.infradead.org, 
 Valentin Haudiquet <valentin.haudiquet@canonical.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jian Hui Lee <jianhui.lee@canonical.com>, 
 stable@vger.kernel.org, Yong Wu <yong.wu@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulfh@kernel.org>
In-Reply-To: <20260926192417.1448813-1-valentin.haudiquet@canonical.com>
References: <20260926192417.1448813-1-valentin.haudiquet@canonical.com>
Subject: Re: [PATCH v2] memory: mtk-smi: fail larb runtime resume until
 component bind
Message-Id: <179362791566.178192.291057765845051785.b4-ty@b4>
Date: Mon, 02 Nov 2026 14:58:35 +0100
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
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Sat, 26 Sep 2026 21:24:17 +0200, Valentin Haudiquet wrote:
> With the mtk-smi and mtk-iommu drivers built as modules, a consumer
> device probe (e.g. mediatek-drm on MT8183) can race the iommu's
> component master bind.  The consumer's probe path runtime-resumes its
> smi-larb suppliers, and the larb's runtime resume then runs
> mtk_smi_larb_config_port_gen2_general(), which dereferences
> larb->mmu and larb->bank.  Those pointers are only populated by
> mtk_smi_larb_bind() when the component master completes, so a larb
> resumed inside the window dereferences NULL and oopses in the module
> loader's initcall context.  The module loader is then stuck and the
> rest of the boot dies.  On MT8183 (krane), mediatek-drm module init
> hits this:
> 
> [...]

Applied, thanks!

[1/1] memory: mtk-smi: fail larb runtime resume until component bind
      https://git.kernel.org/krzk/linux-mem-ctrl/c/dfadc8ba7d2d32fcf7f8f740aa8a0a60e3e731ec

Best regards,
-- 
Krzysztof Kozlowski <krzk@kernel.org>

