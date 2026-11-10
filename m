Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794310084;
	b=k2/+eil2vdWZ8PWXUFGeTind3fdCbrBhyNDmXcVff3ILoJN5cogwjrVkKzBFI0yRNIHz
	 71QksPDDNhrkl5Q+QH4ozQC7eRwmCAx0IApXWJZofdeATRz6cc0GsG5+n32ZTplzPPD/q
	 dBVeS/PAdrwz31FEv1o6ou43eJzkjGzW15wAuM/98tRh/3wgKOvNk5YY9rO668GyozhqN
	 jsA1HaNgBq/da3P4tXLtZx9hB7FihEtx3pczlga+i1Rp4jXWExNxvaURiYJMHiF1BpwG7
	 05KGkdZsNVEvnKmo+fEy0XAZ9NiuBrE2ZgB9dhdqNV+teCnIqTn6KLFxbw27F31HQMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794310084;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=+8SmpKfanibtqfQvPi11fKmx/q2tro7mfSWNxssCkTI=;
	b=bvr0rW6HG1k7SGy0BO+g9xYkcbR5B8F0EkQn7hubJn+RRD6nqZtVTN8gkXMsS93FZaL4
	 eVqT0lz4VfnRKnWL/UMv+Tt7GDkOiFosELWxTTcG29oB2EVCmggA1YM8Y8Z+KZCysmpa0
	 CJHjFqkXLD2pmw/UrtaBJSIDDO4wJ5uBva+2GzJCMNTph3JEUR/ttVTx4P6z3Ta7QopIR
	 2sNZ4+VfGjRbrezeWHAgQPAvEjrpo65z4PsUuYw+eHNeHATYmvBjp1I4wAVe4kHeYD3oL
	 0cYJxbZBn7oDw+pn+L0MiB3/+rgYnBHynK7TIDrMErd3ixloyo586uyoAw2TqXbHtrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9202C606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9202C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a5177d78c7so15447515e9.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:28:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794310083; x=1794914883;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+8SmpKfanibtqfQvPi11fKmx/q2tro7mfSWNxssCkTI=;
        b=GXgu/xawOx1ZY5ozMJDoA97tVIh7v4iRmRc/EvN2BolWDAhGc1KCPXI7hH5VZZ1eX4
         3JbFiKwJrbn1VShNi547cpnOnJAw+NGpMwwItl5aGmYcCY01ZWzxfp5WUslqWMGTLkt0
         0tKm+oL6GU3J9rBtjL7YApOBIjgaC/E5ZK30QVQn0brudq0tUnf0MM1bxTIOgsMQE6BR
         RuPcn9IeeGbssPdb/k5sQAAVSfIo3mPHBxGNPIPBQWXiwS7JjpAAXRpNpHvBNJIUAt+x
         Sg8BGmYkzk6zV+o96vcodd9H1AZrqQgPoEDl4qY/Wg0eR2cSBpkjdB+lx5Znl9Gfx3/w
         aGIQ==
X-Forwarded-Encrypted: i=1; AL+hErEo+7ebgH+PwuexgS3WrZvC+Lf1MJcA9AIfgGsRYhxKH3Iz2lVc8l3FJKpFY25bGt08NPSH7b4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EqIfi10Tb7VLPvLGca09HnMvNsAEgDgeaC4xKCImHCDrNe191
	c0mIXztjFEJ97omnzBFTb3IkmIeTU3LmdegnFF7XUY04ndEUJ8pGUOnH
X-Gm-Gg: AYBFou28+PS1Oy/PhdADK7iTO1QPMOaAqTtNehXXyX01z8UdQdNT/upS+JjvGS06roG
	77kDHwOh27Jmw0LG358TX5BCm1cZf1e4f1/7PCPcwbEauZNnNGLRpANrToqd+mIjYXeD2yOHTR5
	0EYvYLZrgdKMbL8sFlbBVixxHxE/Sj45P2RLY/yz4RPUzVig7QnsD3QcBZJOyrthWuzXb83AWD0
	erH42EJ7baq/lGwQp4vmYvopgUFmHNzPMpvViqeOM08/umin95rP7babDpPJ3Dt4ahWgilTzeWF
	c6CqM49Df+IMuhZWkc3h3r6uLHyDkxiD+FZdH0ZFsKsqATPR+AnwUshHXzHwoiw7awY3CfUbeDE
	yXXucxOhCHbQbxclMxYvDyug9la0ARG4/P4jrUIYSQiTTTBjuQVjStTvTukw64Ke48wIlBqTBQY
	TScQ4ITuyXUdC0k99pN8OZMAyQGShA1P1KtWmeVAnd/gpbJ+naFGhfguIVWEItG0wxc685NsKhm
	rFIx+x7EbvGDV+Uha6BSATQEAlnJL9X00ROajZu7eeTRVlXRj2wqvlTY7jDM9fuTgwxEOG86VxU
	D4jbyKw7RRaPodC6MpdUh2lve0Vmd1OJxRI7l2AiMkSIzOHyXWgi6GBv31RVxKME3L5uGNiH
X-Received: by 2002:a05:600c:3b98:b0:4a7:462c:6b9e with SMTP id 5b1f17b1804b1-4ba02351506mr44181675e9.32.1794310082728;
        Tue, 10 Nov 2026 03:28:02 -0800 (PST)
Received: from smtpclient.apple ([194.64.145.190])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0234a5dcsm58644735e9.2.2026.11.10.03.28.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Nov 2026 03:28:02 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH 3/3] media: verisilicon: leave room for the JPEG header
 and one stream burst
From: Sergei X. <shomenkow@gmail.com>
In-Reply-To: <d8ba9d67a9452bc44be219d5327aa9d7ad83275f.camel@collabora.com>
Date: Tue, 10 Nov 2026 13:27:50 +0200
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Heiko Stuebner <heiko@sntech.de>,
 Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
 Chen-Yu Tsai <wenst@chromium.org>,
 Hugues Fruchet <hugues.fruchet@foss.st.com>,
 linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <46F3E2B2-AE47-46D9-BD41-6970B58763F3@gmail.com>
References: <20261109-hantro-buflimit-v1-0-f0b86ce61e66@gmail.com>
 <20261109-hantro-buflimit-v1-3-f0b86ce61e66@gmail.com>
 <d8ba9d67a9452bc44be219d5327aa9d7ad83275f.camel@collabora.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)

> +                     max_t(u32, pix_mp->plane_fmt[0].sizeimage,
> +                           fmt->header_size + 64);
>
> Did you mean to align to 64 instead ?

No, the max() is meant as a floor: the 624-byte header plus one 64-byte
stream burst. Patch 2 already rounds the stream limit down to whole
64-byte bursts. ALIGN(sizeimage, 64) would neither keep that floor nor
align the stream part, which starts at offset 624.

