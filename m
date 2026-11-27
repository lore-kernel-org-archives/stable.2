Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1795790480;
	b=hUfoNB9f0ffdIp/LE264kT4tfP9z+ZeT9hQfY2pXSmJvnQjr1rQsjnv8xz9wOMjsmyb6
	 fCchivYuzphNhnp4UP+dEedN+xBtL8mNpEZL4wJeLtBYMr5OM6UDQ3WNEBzZaVx6B8XDH
	 5sR3+jGtgqgzZzfDrPeleoXS8uT1JVqtn7I5xULWu+A61YLRGDpyZQ4t14zBWftvNSBXp
	 LihSPCLqLD6ay40kbd719q4OHHbz9wNiFFGVoq5fAuRpW1Ro6orfS8DbXvq6aM6a5SVUv
	 dXGpTWotAPLUJqxl41u0vpSH7RG0Mf4DejIaV2Y0jQ+JKAW7Ca5Monf5pmMGAPbX9PQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=1xAA2Goyp0+/R7QCDqIjCUY9e99g0trvUh4YZU4vu90=;
	b=xEAjf/AcbokxzMDnUDYA4E2JzZQKqpV2EAkDA+JNfxicKyCyfJi2alMLzJcU/NeZJPx5
	 B/lHMVdGD2xgY58kApXW04QjHNh/krs5e+NuKkCdY4styNHD/OSctz3dMGQOC3ekLCGTm
	 uLyIKMyh2kS2afyXCif7xr/xxzGsLOarmWrui0/IYdokBBKEK6atgwVu5YSh0KGnTx9ne
	 g7/MoGUZAC/MfUn4LhfFfd3SxPGki3NDy2+pVti84zqgJWK/4Q9sZK4ntZ/TK4izeNiIT
	 G2BEgG5IgBwZLri0b7wkEVF1oXkUr+gOQqhRMVVDKpZjYyhs0VSbby4ca4ShYVumuiQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=MT2oHMum;
	arc=fail smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4760C606A33B
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 14:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4760C606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=MT2oHMum
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c51bf011392so320328766b.3
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 06:41:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795790478; cv=none;
        d=google.com; s=arc-20260327;
        b=l77tNTMtS1rXeWHubSImuJVxj9H6Q17ZFjJbioeFy1mSrGEK4jE4WVXmXpNklnNyJI
         TnfOTGoVBMYqT7peDRB5vdfujKYvBlkL+kaSC/t7qrB8kvSIbscKFILG9MF0mlgNLKw7
         TOHHFNlSJNTIFH0aHJERYmJb5Q072BgQoiYBiKf42tVUM6mV7e5iNXxhXyLThMgIhhcd
         NEIUA9PzZZcmb4LxywpKAAGQbMnYE5a7Ef3RVX3t4rawGHaXJJrRiWySSh4BHOE1mZCD
         mPYMLC/PKjoMMK7oAcTfrqaIVc4LRkdY/h5DEZWCrvs0al+62S/kg9ZC17xVNohWJ2cf
         u/Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=1xAA2Goyp0+/R7QCDqIjCUY9e99g0trvUh4YZU4vu90=;
        fh=FhSz8yOv00wvqk3iufYSp3tpPHNDsEBcrU4t674NcEQ=;
        b=G+MH2TJ13vqZB4YwfN/pzTe70fWfbapaHtZ1M/h/AIi7XqxKIZOHEJFh5TNw1LMtlz
         AtnJi2IYJnMHhpvxtoCteChY4hWn4FkLWQf7gEdRu8l/et1H7UnxW+wh9oZiICIlMYZ5
         XvFowG4oluL6POpLBuNwfQ17eCmTikY0UinXIOna6hsi/5rr0WefcvPBE/3rQoyibnjn
         tfeuEk2qLoI/j8x5XGJktucFBkzdsCPLjJk4hrqkeLFNFdQP7gkfTNVb2bX2EAHQBRSt
         7N4BTVx5vTy+OYzi+2S+Q82zdp21YERbGyId772WMQslc76usq//21JDyavUaIcfdV82
         caIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1795790478; x=1796395278; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1xAA2Goyp0+/R7QCDqIjCUY9e99g0trvUh4YZU4vu90=;
        b=MT2oHMumUDYcT1kYlbQvosRHlNXx3xucpGVTGRPcLqH4jA0fgvtsQ/wf2Ps2Onzrwu
         oxz3MVdxxJinWMhO7BhAU6bP62OQnZE7FevaUCtiiPYGMWVJEyiD/ZoyE4eAdWCgy9X1
         QN+ULSdNYBbjlwiDwRZNFQa3AjBAzIdtUSZVOWr9aev3PtiAYRTo+GzVjQrJ6KzcjSRx
         F6kDPFTqq3q7XVG2lsqyo+GsgNCRvqV03JAl/M2fqtspCSgQr6XyZgr5RopoJwrjg1+q
         jwc97ZqwWBfgxWzCy27SlDP3CpAb+rgPAhWH0pz5SA3+kk2Aa3ou5rx8zLBqcSUM+Yna
         Rz/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795790478; x=1796395278;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1xAA2Goyp0+/R7QCDqIjCUY9e99g0trvUh4YZU4vu90=;
        b=VFws+RmfKG2GYPSltUU3iTayBkAQ14Rmm+U7ZYg0EjCcQa/QWuF8cM+H6SVkZgrcXb
         A7lrf8lyUgTrb/e101IxVGYiV1vCgQ1WtSZL1JwEgOaOZjF8x4i6FoZ/CjeYmANQhGrZ
         qqpTq0z6zlw06qBO1sVPzE6D36CPdeVrnWWcAD/bA+h950Ujw2sVQEJWgK2F5GzG5SJI
         NQZ1dJwmOHvqRbewbzoy0Av+1zhJvb7Jculj/f98kzmipf4HnkxSvZA7SEi9VBBeNlaC
         MbCddpyPWMaXOieK4lDDhyxpJ8u7P2OJvlPrjtEIpUF53oBDnS7YjjaFj7C/6CRyFgNo
         a9Ww==
X-Forwarded-Encrypted: i=1; AL+hErHMxAK8wG5v2uOT6T3tEsMv54a0AtFXx7VB6kxQijWmZ9dP+k+EGyDp2eOFTy87E9IivpgNFIs=@vger.kernel.org
X-Gm-Message-State: APuU4Z83io+yqUqbMP0jSmwAjl1mBtJzBCR7mdAvvCO9Yo9bUdnPuTcs
	Q1CX2cLFaOtwm3idNM072SYoAO+lju+7eCrcevdNwgss/0pXgH2uLJBCktNjPz12G70ofW+xqUy
	w66/O8g156WTpWPAogYseZZxminNCOFG8YERMAcQmKfU6+ciw0oQ0qeOAbw==
X-Gm-Gg: AZFdTZfS/XWQefF2jRWA0ghVT3Vu1V3B8oXresEVOL7EmpN1nIM398ebke9dMCqxPr9
	cMnHEl0JRqpZcCawb12TZ08IHfKENCuIih/BEuelmu3Ndok1AZruwo2lju/uL1ObowRqjLoP5G+
	wm8T1SdTYYOs0o5G9ZT3iDZWvP9FmJ5q8QQ9ZeD8HVxEMJgalId+vZmCwmlsGrd4pNpzJb3MObb
	fPEb6X6viGDEy7iXK8UTDt73Rk/qbwrqdJYksqmHseimyLcMiOqHYaJJw2DkMnTljmDRX6x9qoE
	zqIsjAyLukhY5qSwJRCl9JmiKFbkRR/2f292m3knrTkkKpIiAEjNJ6yg4V+wgi4DBlG91+AXI5Z
	ijO8SIN8sqkm4Yc2Pb9R9Pa/p6I9K6QUoe9s=
X-Received: by 2002:a17:907:1b0b:b0:c51:e06a:4744 with SMTP id
 a640c23a62f3a-c51e06a478emr187991766b.7.1795790478468; Fri, 27 Nov 2026
 06:41:18 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123104236.4179425-1-rmustafin@cloudlinux.com> <179551712630.3135.52212996809224784@kernel.org>
In-Reply-To: <179551712630.3135.52212996809224784@kernel.org>
From: Rustam Mustafin <rmustafin@cloudlinux.com>
Date: Fri, 27 Nov 2026 21:41:07 +0700
X-Gm-Features: Aa3M54ridbYcbm90XHp9x2LSe6zmQntTNNJ5b4vHfgqbclmUtnKlfUB5zVS6gIA
Message-ID: <CAG6=z5vW4aPe9f5S_8m73oKvEkxSZySc7tJJo_hbK7F-bL3ZJA@mail.gmail.com>
Subject: Re: [PATCH ipsec v2] xfrm: use the frame's own socket in the too big checks
To: netdev-bot+sashiko@kernel.org
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, netdev@vger.kernel.org, ipsec@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 24, 2026 at 5:45 PM <netdev-bot+sashiko@kernel.org> wrote:
> Does iptfs_is_too_big() in net/xfrm/xfrm_iptfs.c still have the same
> mismatch?

IP-TFS has its own output path, which this patch does not reach. It is
fixed in a separate patch:
https://lore.kernel.org/all/20261127142550.66326-1-rmustafin@cloudlinux.com/

> This isn't a bug introduced by this patch, but this branch leads into
> xfrm6_local_error(), which looks like it can leak kernel heap memory:

It is pre-existing and this patch does not change that path, so I have
left it for a separate fix.

Br,
Rustam
