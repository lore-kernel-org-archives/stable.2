Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.142.180.65
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795129345;
	b=GrjvT0p31lL0uNwihQQt7lNDk5psWG/N4F30vx+DADojA3rtg68Xmg3CPxrnALvHdro8
	 P396ej9m07lAvAf4MmZqaEGJ+YCklPQ60pJcbfFRdHg2jtFbBb+TptRzHPfwMbNqvHeo8
	 qtSNH0WG0mawlSoLhT6ao1TPqzz0cdP0rzQbPCJH/K7MIFGNiV80OULio12sxhhaqPJai
	 adcoPK7tpsL1gpfn7VtKjg6qOpQ90NzkF2y6teA1LJc73PK4vE846DD1gw0CJcoyCgyvX
	 LS9pJMeeHMp9YmzGWKK1Ifx90qIbcAhOCOVduEzrHn5BY2L6Sojy3QsonLHc5uVwabA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795129345;
	h=DMARC-Filter:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BHZ87I4xB4zS2G/9KYOvToulTtpf2LsoVgn3bT5ySVs=;
	b=bsPShNQmPdwd8IrmZcIo9GdOto0PpibvJxPa9Q7n6yOvWK4f2IYoxR2gjv6YLrBwmfzV
	 HZrezH4BKvTLUzPcE/GM8etQBEYhdWhIN+ncbGRtc843iMVk0hPSrHg2mJ/s4jZLNRdar
	 DC90BwuxaMOuB73TVAqPNJqw5pG1XFA97fSfVkhktvWquUQaDjCASVvt6ReB+0GSPqSVr
	 q2AD4MQ/dMsldkqBY+pNYU6w44GQwYK6w1gesSMkrek08g81VCEEPvLJsmTc1xBR8WMcW
	 MnW3onLtHPUP8C3RuzrmpCnXvPYvLB8lL7760oIB3/x9nYQLL+f6SHlUqPV1YntCmYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=makrotopia.org;
	spf=pass smtp.mailfrom=makrotopia.org;
	arc=none smtp.remote-ip=185.142.180.65
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96776606A330;
	Thu, 19 Nov 2026 23:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96776606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768)
	 (Exim 4.100.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1xUB91-000000001j1-38dY;
	Thu, 19 Nov 2026 23:02:19 +0000
Date: Thu, 19 Nov 2026 23:01:59 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Lee Jones <lee@kernel.org>
Cc: Sean Wang <sean.wang@kernel.org>, Linus Walleij <linusw@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sam Shih <sam.shih@mediatek.com>, Rob Herring <robh@kernel.org>,
	linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 3/6] pinctrl: mediatek: mt7981: Add missing entries to
 mt7981_ant_sel_funcs
Message-ID: <av9_55iwEZUZH91m@makrotopia.org>
References: <20261119204748.2558209-1-lee@kernel.org>
 <20261119204748.2558209-4-lee@kernel.org>
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
Content-Disposition: inline
In-Reply-To: <20261119204748.2558209-4-lee@kernel.org>

On Thu, Nov 19, 2026 at 08:47:18PM +0000, Lee Jones wrote:
> mt7981_ant_sel_pins[] defines 14 pins (pins 14..25, 34, and 35), all of
> which select ANT_SEL at function mux mode 6, but mt7981_ant_sel_funcs[]
> only contains 12 entries.  When mtk_pinmux_set_mux() iterates over
> grp->grp.npins (14), it reads two int elements past the end of
> mt7981_ant_sel_funcs[].
> 
> Add the two missing mode 6 entries to mt7981_ant_sel_funcs[] so its
> length matches mt7981_ant_sel_pins[].
> 
> Fixes: 6c83b2d94fcc ("pinctrl: add mt7981 pinctrl driver")
> Closes: https://sashiko.dev/#/bug/linux-6233f285-1487-4d2d-afe3-d4ce3c445054
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Reviewed-by: Daniel Golle <daniel@makrotopia.org>
