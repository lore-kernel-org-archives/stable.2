Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964743;
	b=DiLEKsLeMT7oSzf81oxrJi5E4tTVaUElbqMHQ8qZwVrAC8f6GCy4PfbSi68fr6lZ1nHR
	 kNuzIoQWvNbDRAXyu68sH21hsVSbxpGZtItpQRV7v+qa/6zasOB2nLXcp8aNvnJkb45Wf
	 BmW8xOSacPsJi4dq5WKov/9ys+xs1BwtlnNwETdFdbQD+hDEu9H18XtUpO1531pF4Ldmc
	 m0B+4xSyrZKw/sf6yCjQT+VL5kX51nEgNYUkM220pinR1k2anxnPoIVr1dnMsRfxyvgpI
	 cRmmT+JPTUaKKC730ecHuXulcuQk0MH6FiNHVAFPtkKAYRfQqMtjYn1GJo9qxCwR2YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964743;
	h=DMARC-Filter:Received:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Message-ID:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=sJ6uiboREptquS9XwNjuw9ro8IxA9ByoNmleMW/AMxc=;
	b=0XjZs+O+mkzoRWCgFaQNKCNafJOUemTGbmEnXYXamj/+a5mYumktyfFbbISlkvbcxi9S
	 bCsCPFHkLDn36+AsboiZim2w6bndT4W5zcV940k/3qR964dbzqRpD1ZTHYmSCvBAldIl4
	 DSr/mAEvyD75zfymdJFU5gxPyxvXcZN8unEsyY12YeSN3Q5iYadughGVIPo+55HekQzCL
	 +xgv3oyY3ToWKoRyvF8PSoMKMBrGglPi1WzW2AHw+NK23Cbpp4RDWucgL9oQzwHIKxiKq
	 wp+InT3xffLYA1AFe98P03Aw/ans6MvdBdyFdHmTC6c+7XBxJmy7VAXgaHFALv+wGMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D0C60A382E;
	Fri,  6 Nov 2026 11:32:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4D0C60A382E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAA3QpO2uu1qM9tsAA--.22758S2;
	Fri, 06 Nov 2026 19:32:06 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Frank.Li@nxp.com, alexandre.belloni@bootlin.com, arnd@arndb.de,
  bbrezillon@kernel.org, gregkh@linuxfoundation.org,
  linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] i3c: master: Fix of_node reference leak in
 of_i3c_master_add_i2c_boardinfo()
In-Reply-To: <aqr0fHT3EcOlExAj@lizhi-Precision-Tower-5810>
References: <20260916160654.2081795-1-vulab@iscas.ac.cn>
 <aqr0fHT3EcOlExAj@lizhi-Precision-Tower-5810>
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
Date: Fri, 06 Nov 2026 11:32:16 -0000
Message-ID: <179396473629.2291714.9103477288277081611@iscas.ac.cn>
X-CM-TRANSID:rQCowAA3QpO2uu1qM9tsAA--.22758S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYV7k0a2IF6w4kM7kC6x804xWl1xkIjI8I
	6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
	8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
	cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z2
	80aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAK
	zVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr1j6rxdMc
	vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCF04k20xvY0x0EwIxGrwCF04k20xvE
	74AGY7Cv6cx26r48ZrWUJr1UMxAqzxv26xkF7I0En4kS14v26r1q6r43MxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYx
	BIdaVFxhVjvjDU0xZFpf9x07bb8nOUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMDA2rtky+YaQAAsQ

Hi Frank,

Sorry for the delayed reply.

The original patch was based on an older kernel tree. I have now checked
current mainline and found that Akhil's earlier patch [1] already
addresses the same boardinfo reference leak in the fwnode-based code.
Please disregard my duplicate patch; I will not send a v2.

For transparency, we use static analysis tools to find candidates, then
DeepSeek and GPT-6.1 Sol to assist with auditing and preparing fixes.

Thank you for your review.

[1] https://lore.kernel.org/r/20260804101301.2975911-2-akhilrajeev@nvidia.com/

Best regards,
Wentao

