Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793936685;
	b=fYGVTW6y+EvsP1aZ6rDwhv7vkd2d3P5Bgx4AloDmEymJHr8NWBZFm2ynhAXHKEf/rm4i
	 08ZBJzQoMBPciJ7xUbe72Ttx1/71JtZx0445X07zIzWqzgiLgNXE43d4ACBiaUS78fdWX
	 H0Wa1VmuYoAxC42BSh5F2Qizpg8wa+sbN/X85Ace0w4V1tjFBg2tZwrFrIKe6YyTbbIn4
	 Ry5V9FBeID3N4rFANOdaX6kQkoh4AnE8anyRNKoAk92Okt1YQjK7JvEJdLVGSZoRn7K5P
	 OqB5hK47lNSjEiV4nHH8lRZep359BqUletHw/oOmVfZjqN8Vbd+sebnPkHyQxsgQztw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793936685;
	h=DMARC-Filter:Received:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=rxbs7nzBrtfmIOGiCSnCdjgFX+TagOLny6/gYQ3BikQ=;
	b=GHJAuAPZOhyWPwB8oSQOpzy4BSqTWfd94zhyfI776rOGVVyF3ABYbQov6ImK1KOdefU4
	 dPiyyo6QOp47XOCLalLDhk0LmSmzj35Sh58X+EkdmG/bSHZ5IYKLQh30tz8sqQzEYCS/8
	 rO+z2fmHWN0BUKi8I7bxW0tWqmgkWZ9C++4oJiHPesZ+aGUk9IejV2DDQwayz/4XTzfUJ
	 XX+w2pXPrl5UWUDcowSFPll6ePRJFwtx4itLAMM08NxKvP4LNDswrVbIACy6UCkWx9Zmd
	 HWC9Z/KQN36eigBWoBHuomonwpjvqTBo0gwcMB10f3BMp+RMT2S2iv44Ogg1gu3RAjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5858606A31B;
	Fri,  6 Nov 2026 03:44:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5858606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowAC33_kjTe1qAOReAA--.15432S2;
	Fri, 06 Nov 2026 11:44:35 +0800 (CST)
Subject: Re: [PATCH] soc: microchip: mpfs: Fix flash leak in
 mpfs_sys_controller_probe()
From: Wentao Liang <vulab@iscas.ac.cn>
To: Conor Dooley <conor@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: conor.dooley@microchip.com, daire.mcnamara@microchip.com,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 stable@vger.kernel.org, vulab@iscas.ac.cn
In-Reply-To: <20261008-47741881fb032091ea3d7f0c@squawk>
References: <20260917153550.2160672-1-vulab@iscas.ac.cn>
 <20261002-garnish-president-6e8abfdacf4c@spud>
 <20261008-47741881fb032091ea3d7f0c@squawk>
Date: Fri, 06 Nov 2026 03:44:44 -0000
Message-ID: <179393668487.2060453.14381920142402581273@iscas.ac.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:qwCowAC33_kjTe1qAOReAA--.15432S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF47KryxZF4ktF48AFyrZwb_yoWkJrX_Wa
	yktFW3u348AFyxJF4FqFy7ZrsrK3y09ryrA3y8Wr45Jry5Ar4IkFZakwnxZr1SvFW0vF1D
	ur9xJ3y2krnFvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbs8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280
	aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWle2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_
	WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0E
	wIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
	ZEXa7VUbkhL5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAADA2rtCZf4iQAAsk

Hi Krzysztof, Conor,

Thank you both for the detailed review.

Sorry for the late reply, and for the mess it caused.

This is a v2 of the earlier patch, but I sent it without the v2 prefix,
without a changelog, and without referring back to Conor's review from
8 October:

  https://lore.kernel.org/all/20261008-47741881fb032091ea3d7f0c@squawk/

You are also right that the patches were sent in bulk across unrelated
subsystems, without being grouped into patchsets, without running checkpatch
on them, and without documenting what was and was not tested. I am sorry for
the extra work this has caused you.

In particular, thank you for pointing me to the kernel documentation on
subsystem identification, patchset organization and testing, and for the
guidance on how this work should be submitted. This is an important lesson
for me, and from now on I will go through all the remaining feedback
manually, one by one, and reply in a timely manner.

Going forward, I will also not send patches in large batches, so that I do
not exceed my own capacity to respond.

Best regards,
Wentao Liang

