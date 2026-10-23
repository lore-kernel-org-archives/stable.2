Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759840;
	b=TC6NTxt2f9WTk8K7a/MG4MV7TURewCZlT/MkWWHL3iu581dClXbwqNctg2lYUR7lEBdD
	 NGzEwU9TRdIzXtEjkD4BAUL0HM70DN5A3GLaK/ku//YHmhLcZ9rdJaMTO3QYFZIOy8F6a
	 2DN7PekgzVxiXit2JOV4YjEfZZiTnjeD2dVa3QYvgaSV2xG9jBi1Yos2ywlQdkvF22la/
	 j59Gq/8C/ZkELU3aR5KAtdC+Yv9aGF2+lk0GmOu4ijwsurPzxhlxnG6Fth572w9SAxKnY
	 AaWjSRth16QGdM+kUfbI0BAX1lqgKrVUhb7Vq7IwMKFYHFnBlO0XN8yoAfKFoUeNjZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759840;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Mg+WfWQxC3P6qmiOqOVEseCpuAHnl8nyDeZIWySuY74=;
	b=jX/5AU10OGrNjVSsv2WgQZj27U+v7mSOBGZiHeEt4zRD48HLAj8wORa3sreDwGWBzDGe
	 wyp6SX+zMJnwISPQJWfr6RJLZKD1Or78At5/M8/w+dn2umgmU7YtwL3J0CSorYmO+QdeE
	 jeOWxOfi+sghhXWmK9XnZFdUS8IsPek/Cwr0+9K2MV02hx6rf6Y0jnKpJ1R1cYubkCTgf
	 GoUI0oQwmENd6/PssHlyWk4KzjN58kmi+en0/fYJwcC9jQ+6LqyUiNawzot/TNI9L+2RN
	 1ArqT7c56Heu6lwIcNqpRSAHn+mCQ+jAg+n8+8eI0TysKZUzRFgvexlbfxYzehzpGlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kroah.com;
	spf=pass smtp.mailfrom=kroah.com;
	dkim=pass header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm2 header.b=dkjDrj5n;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wFBoZAla;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA775606A323
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 12:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA775606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm2 header.b=dkjDrj5n;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wFBoZAla
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 22CF81D00120
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:50:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 23 Oct 2026 08:50:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792759838; x=1792846238; bh=Mg+WfWQxC3
	P6qmiOqOVEseCpuAHnl8nyDeZIWySuY74=; b=dkjDrj5nqXFh6E7pw9/ora8fSh
	DqhN5eF9qveCyBa0hNsU/5TS73cD50Jnokpe0RLjKNtrxQZFDuii0bWKhxQ2RZwu
	r9pU/SLT/r9FITfVJ/le3D6KtAwvoHgo4nh0CYxJkNBCbBbqNmjTIzC4OGdRkKDL
	zYYqu+GSzXDS1zuboIVSSpyYYNzvpfxJfYqkIBaoBueVXNZ9C+KkAoeaNMQvGz0M
	Gj1zhiw7B3V0Q3j1NRUdK+qy7FLLMRpFqyRsW/SNKdMBWPC/Tp8C1OvEYBCs/7FP
	4TioXwWQc7YIS9S0RvROy8rdzvRXoLs0E4gefCIej4rOhIoCtYnIkxnHe6VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792759838; x=1792846238; bh=Mg+WfWQxC3P6qmiOqOVEseCpuAHnl8nyDeZ
	IWySuY74=; b=wFBoZAlaaToNk+twrlvepttujUKeNPxOyqsoAYvFImdY6HPLySz
	hjEGhKeIMyAFlbI6AtmbDe6htH2seCS4ASu9d+7OJ56PrkPNtO9EJz3YJEgab8cB
	18wd6Vw02TX0pINc4FQQXCNAb17pJMotzSdIyo/DzbHiRQ7gZTpR9CLRGtX3BqXh
	ognpCXe+HOSG8SFc5EloOdzTBarvQKDlhX93LI2d4ojr4DhwnkKwywbngU4R+cHr
	ML9CcAI+wfrJG7BuyeZrT4FEEkj52/bdXHboA5SWgqFZ6UVqf4DoKrncDwEYu40T
	d9mmwInK1vbhjcuMGn1k9HE4pXIOx0gVN/Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792759838; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lXeNUE5WCoZAzL7wt5vwTVRzaafP7OfaJBlG3X3OKpYPHVm
	Yw/QBWvrz8hsE3evS46LV4807sB4eS/aYOG2fG0Yfh5CZ406eIYu0lKgwO+r8iSw
	KCF+/hQsUhu8blwLN/UKNyGvW+m3Op10U/sT1SApuxQITfjYEThDyP6g1A2lqGtn
	CxpX7dBm36oH9txwDqXNRm1fkZWSAR9Z96QrZin0oMf42X3O7MA+A3kBZSR+T1ay
	nZnLEi845g+5Imqew0em7NOGNiamr9c6ln4U9oKU//sm++KaQ+IB6+wIpUuUDnO2
	R+MiS7Jx0Risso4zBfGcB/IszY6vl8tkZgIzAaA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:N3Nk+7FQd+lBJg++i1EpNdmiDJRJy4qcTwjxDPN1J+A=:ipwzzHjBT5M/myEZnD8qNFj0WOxSydDev/u6sVP8buc=;
X-ME-Sender: <xms:Hljbapo4fYkAxbi7o1zF2IMtIcMTS7RjHdTiNQH0E2OG_KIYiv5OgA>
    <xme:HljbaoXBzdLX_UbUvPScJX_uBd8e0faQVIziXX3HHjYv6A3Dh1cIi4fNQwC4HoIH7
    9XUo765Wp5CChmuaVo63vB4VfvOf8Pwrh_CfCT2YqseMXkaPhw>
X-ME-Received: <xmr:HljbaqHGAtQlovp7FyqeFve5cfGMZQV5DVhlkwz2mzwAQMkCSfguIhA1pAaugQ>
X-ME-Proxy-Cause: dmFkZTGHCgoe/65dzJcn9v7kUqHotx0TXzvWX3NyhFo3t9TokUCxgTUa/4pyfSWI8vGfzn
    f4RWdTUE5ZjmRO4fisu5GDFroie350rJJDuGZtQKgqcTZpRl6ZtMgfXaEwa/KMwVeYnOGQ
    L45m0uVzbPvHXKoC48T5pdS8RGQ/oh7ru28XXYDJud76DV438EY2pEU4EaMyA8dim5Jyih
    5ac9LEI+fTuVIY8OIjO4m5KtiP3Cc1Pyd4Lmy+ozNnzyo5rfrBJb+jGwcW/I4xo6hFMe3l
    iLM/gTRr/u3MYPKp1W4BLiuY3RK3EhaEeXFK6Kvd6amTXJ1tN6h0QrXnbWGDWJIy16E8rl
    XTf/ck40bKdPD7FDNSAqsd9xcxGKM+l3i4nZdcQhissAMnAn75WfdP8iXGrV21WIe8Y4kI
    NTtyNrCG+KEWPLKVJE1t13rxicYmcxjSXV2VkCRajv5r7WzvQ4G8ZImoTU4CoTVd272NDL
    iVHAWICiFZFO6K5FIV00PancdeUizeVdhvwMgr6PVhXbydfHw3zNkxT05w2GpvSolqvIwF
    pTKyBTUklKmRHuU6Hb+8dwHau7JnoYD5kGmQw4gxgvjCZBr47G3xydosf4h0lIxCHLvnGo
    frs3MsDj10JzVMxuXXFfkxi6Snac81v+L7/Y5qOus5BJJKg4BbBeuB1lRsnA
X-ME-Proxy: <xmx:HljbavAr1Rs84CBNU9gtpakz4ggO3hrlvasMMz_pvKR2d6eK4zMDWQ>
    <xmx:Hljbasyi9Mf3bqX3Kc3jHirqra0V9SmNPBnm7LdZVilxFWc2-28u1g>
    <xmx:Hljbalfg_BndeT6Fz68mdszrx8nM_F08vSstIyHJ-mdSSlt4aRU-YA>
    <xmx:Hljbahs32KObaG3KU-5F3tOY7JsuaYF3bulZgWQfTKjLXsXyxPen6Q>
    <xmx:HljbaiZwdLTSvapq5O2wmNUKYBsKeSrLAFG9R5JUi63fMne4f2AFiwbT>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 08:50:37 -0400 (EDT)
Date: Fri, 23 Oct 2026 14:49:51 +0200
From: Greg KH <greg@kroah.com>
To: Connor Stevens <ooglie05@gmail.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
	rf@opensource.cirrus.com, broonie@kernel.org, sashal@kernel.org
Subject: Re: [REGRESSION 7.2.11] ASoC: sdw_utils: cs35l56-ot25 DAI not
 registered, no sound card
Message-ID: <2026102339-control-obsolete-df82@gregkh>
References: <CAF50T1myMs2LSPUsTAPKyJutxzqQihyxbY3=iVGpxenRbnXxKQ@mail.gmail.com>
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
In-Reply-To: <CAF50T1myMs2LSPUsTAPKyJutxzqQihyxbY3=iVGpxenRbnXxKQ@mail.gmail.com>

On Sun, Oct 18, 2026 at 11:41:55PM +0100, Connor Stevens wrote:
> Hi,
> 
> Since 7.2.11 the sound card is missing on a Dell XPS 14 DA14260 (Panther
> Lake, subsystem 1028:0db9, CS35L57 amps on SoundWire):
> 
>   sof_sdw sof_sdw: ASoC: CODEC DAI cs35l56-ot25 not registered
> 
> Fedora 7.2.9-200.fc44 works. 7.2.11-200.fc44 is broken. I did not test
> 7.2.10.
> 
> 7.2.11 has bf7a3ce1d563 ("ASoC: sdw_utils: Switch CS35L56/57/62/63 to use
> OT25 DAI"), but not the upstream commit before it, 86c8360c97f6
> ("ASoC: cs35l56: Add DAI for SDCA OT25 stream"), which adds that DAI.

Should now be fixed in 7.2.12, right?

thanks,

greg k-h
