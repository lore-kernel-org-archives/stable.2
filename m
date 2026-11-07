Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794033564;
	b=NoZ/ElfVW1Nt8j1CBAWnLlQe4C48WZgQJO3ZDdftiEEkS/2PRL860n+9UEhfLhIJRC4b
	 mSid4RqaBbBSOCsitxmzEntKUVKPTtZjBBBxgNx8fQFEnDFaAZrnoOWW6cz1Ao+ehp3ln
	 p2B1ZAhEMaOcMbHRyBufFKh3b8t75AXHQqlXtTjibRNZAVtyT6bVa96JV05Wb61lFbFKR
	 ioZIIiMQYPj+wsrVGZ9IaDGVxo/xR+w3fhjSgqBRVKCWlRVHAY0zzyQ/+fkqMfR75aN+R
	 O/X1fUMDZ5KdLiQmk9F2yyUatlPVCC7Ava6oD+WCZhqepQ8TnMWK3P2aMPElFJLhuBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794033564;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=2W57r7YcujbrCZFzHR5EJ6NOsw7Wouekt8Bj3sjTC+k=;
	b=DJpXSdiQs2FA/r+h0YVH5dUwnMGhw0GZkeOosisdsjGAEJ6d8eu+4yRl3SN9SwdBwjIX
	 PdIoqawZCzjA3+zdBIrEdKiEkOman2Aiv/oW2wxj0SeutQAGcAoBQ2ns7TO3SL8SkY0VK
	 N2J4qFyputfF4IhGdBY8UnitWyDnNeC9ssMiOfRUMCYQsGQtlkNACt1SRS4fzqxPtx23u
	 TK7f0k0sOK6VEOkqG2F1sIOFswZOc1UuM8Vu+UYWI0Sgyi6HoAM8m/LSrA0TjVgddz2dw
	 m0BQcS2V6QPYyUq4ussJJeAovttsAx1PtT8vvEkYrrkFcy+q0So+EuK5OuQvU+iaF8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC79606A32C;
	Sat,  7 Nov 2026 06:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EC79606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowACHIbeQx+5qgxiAAA--.354S2;
	Sat, 07 Nov 2026 14:39:12 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: Sinan Kaya <okaya@kernel.org>,
 Vinod Koul <vkoul@kernel.org>,
 Frank Li <Frank.Li@kernel.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 linux-arm-msm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 vulab@iscas.ac.cn
Subject: Re: [PATCH v2] dmaengine: qcom_hidma: Fix runtime PM leak in
 hidma_issue_task()
Date: Sat, 07 Nov 2026 06:15:00 +0000
Message-ID: <20261107061500.314159-1-vulab@iscas.ac.cn>
In-Reply-To: <au4I5haNWglFazT3@SMW015318>
References: <179395457228.2120679.13809646473624751961@iscas.ac.cn>
 <au4I5haNWglFazT3@SMW015318>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowACHIbeQx+5qgxiAAA--.354S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYW7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJV
	W0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxa
	n2IY04v7MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4c8EcI
	0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AK
	xVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrx
	kI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8Jw
	CI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUr7KsUUUU
	U
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwIEA2rucYKNrgABsX

I am sorry for the late reply. I am a real person, not a bot. The silence
was because I had fallen behind on my review backlog.

I understand why it may look that way, but I would ask you to hold off on
marking these patches until I have cleared the backlog. I am going through
the pending review comments now and will reply to every open thread within
the next two days. I would be grateful for the chance to show that this
account is properly maintained.

Sorry again for the delay.

