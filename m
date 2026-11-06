Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.81
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793957686;
	b=Sa5B0eeHmpRImv8AhM91wBQk8Yq3UsTgmrmgwV2r6ewlUlZVWPk6znkHDhdFG72h6s0V
	 tP3roHbdN5shlpLMY9A29o4O8msvsKgvEnEa9iT59ZVpZWMF9gMYYmqdvB48RACQkDHfx
	 Wp6Tvm/RvxCx7zdZD0cYb4LzNBZJlXzgJhVjpcI2NNGvS66muPdlbI0H4Em46FtaeWN94
	 4hpZfKtbwh01c8wSN4RUGT+SGdo0+GS5TE2sq0yUtjD/aNCEEiDnqDw8wTA/1AvQVLvc6
	 cyjDY5+Bb5K8lpyesrYvK1xblFFK+MKxHCwYOYXBLfJ5TrvLz3VHfsvU0ZkQWHpIRAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793957686;
	h=DMARC-Filter:Received:Subject:From:To:Cc:Date:Message-ID:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=xsG8abRujiFyWBg81NBDxlAHRqMenxQF3ucpAS0lOag=;
	b=Hv2fIslAXG9IX8mnfB1PaE7TKnMh5nhz4wixerGrjEr/keM62s1EzLwkHjJYwbmk4ZGJ
	 Lm+Aue6Lq1jUExdgDvubxbidzTxTOdB8B2QRGWxTv2ic80tDo7q1QwXtNAyCDrB+4UUBp
	 j+8Zeeos/uMMgtLJSZ/s0g4yPyG5hNgQ68bEoNnA9QOYFs0sQPEZ4Qj2QTbd3W4U8dqn+
	 c3R5jyjajEC7zg/JktVrDTGyF47gW3+BGfLvktxQMSuZpfqSpSks82ydsRXn+U9QJP+wu
	 96VMDyE6AlcI0NnkqgA10k2DJlfygDlz7ElrkwS8JOAY+eRy7L9sdPS4Ykg0L8v/8+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.81
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0AC606A335;
	Fri,  6 Nov 2026 09:34:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE0AC606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAD3+4wnn+1qQHZrAA--.5284S2;
	Fri, 06 Nov 2026 17:34:31 +0800 (CST)
Subject: Re: [PATCH] drm/tidss: Fix serial clock reference leak in tidss_oldi_init()
From: Wentao Liang <vulab@iscas.ac.cn>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Aradhya Bhatia <a-bhatia1@ti.com>, Jyri Sarha <jyri.sarha@iki.fi>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Date: Fri, 06 Nov 2026 09:34:41 -0000
Message-ID: <179395768117.2284846.12976462915703779115@iscas.ac.cn>
In-Reply-To: <59a88d56-264f-4540-90e3-b9f609681486@ideasonboard.com>
References: <20260916182950.2092071-1-vulab@iscas.ac.cn> <59a88d56-264f-4540-90e3-b9f609681486@ideasonboard.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:rQCowAD3+4wnn+1qQHZrAA--.5284S2
X-Coremail-Antispam: 1UD129KBjvdXoW7JFW7KrykGFWUKw4xKrW7urg_yoWfXrg_u3
	y8ua45uw48Z397KF17KF4UJr4IkFZrZryDu3yIkayfJFyrZF1fWF4qvr1fCw1xurZ5Jrn7
	Cr4jywn8Gw17WjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-8YjsxI4VWkKwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr
	1UYxBIdaVFxhVjvjDU0xZFpf9x07bbXocUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUDA2rtky8t7wAAsl

Hi Tomi,

Sorry for the very late reply.

You are right.  The clk_put() I added to tidss_oldi_deinit() only covers
the unbind path.  When tidss_oldi_init() fails for a second OLDI
transmitter, tidss_probe() returns the error directly and
tidss_oldi_deinit() is never called, so the reference taken for the
first transmitter is leaked as well.

I have switched to devm_get_clk_from_child(), which is
of_clk_get_by_name() with a device managed reference.  The reference is
then dropped both when the driver is unbound and when probe fails, and
no explicit clk_put() is needed any more.  The updated patch follows in
a separate mail.

For transparency about how this patch was produced: the candidate issue
was found with static analysis tools, and DeepSeek-V4.1-Flash and
GPT-6.1 Sol were used to help audit the error paths and to prepare the
patch.

Thanks,
Wentao

