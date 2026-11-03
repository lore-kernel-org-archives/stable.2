Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706061;
	b=Rwit5QV1/kGUpiGIngnWS6bWmAtzEV6CTiQn739xnF4hcAhLqv2DxvOWsId9SLmYfb3k
	 /IYcOryuFCVrDZl7AQ2DS9F3DNgrkp+FsyK/t0HDfE8jtZLcws6VOOOPg7zsT4n7c9fU3
	 zO3nGB5J05DJuqTOu/LOl8lP6z+Fpl83UQkVW9L9DjbmRxsNssEcKKNlLpCIkdRTpGzhz
	 nCUBacRPoJGice0zm1cQPr/wySxMXjD0p25nXmQh0EtL1zz8CYbvmcnAMz1PfwbPiIU/z
	 rNso+9rf/L3IvsMuUkJkBBblLTju9lDMN/YuaSwOcMdaP6dBlrxg+hzZP5CvWzIZiYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706061;
	h=DMARC-Filter:Received:DKIM-Signature:Received:MIME-Version:Date:From:
	 To:Cc:Subject:In-Reply-To:References:Message-ID:Content-Type:
	 Content-Transfer-Encoding;
	bh=bONyyJpUFgPkylO2P2hlNIFwAOFn1eJYoMX8uFPSfJY=;
	b=O2fbPebuOfGunZdO8VmFhvOslz5Rhvnzf3AnhHNBpXpWtaAKue2PnVzbLWneUTzgutME
	 EZfO6Ta873SGAFzxrU32gWag0EfagKuXLLXFzhzSY9C3erYesGcP1hPTC0ZjfvtIE/AxG
	 mq8jWKYbTPVLPZUQfmZ5HAc1ulYp3TNcAzGJSQh41kA4squB0iKvh4JYQVYFad38wPnib
	 gb+JDFczKl6L3wdX6O5IV2Uqu8iggd3YDLf8/oifHs78Dk0JKqu6iE/0TgiCao1+vt8UU
	 1Gq+2/7CAqHqTykKkf7U1/XgsVzYo7ykNGGw0VgNmt5pR4kEzRuY2hN8FgNCbvvxC4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.net;
	spf=pass smtp.mailfrom=posteo.net;
	dkim=pass header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b=F8tPpaJS;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AEA6606A327
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 11:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AEA6606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b=F8tPpaJS
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id DEA07240109
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 12:40:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.8680eb; t=1793706058;
	bh=bONyyJpUFgPkylO2P2hlNIFwAOFn1eJYoMX8uFPSfJY=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=F8tPpaJS4TIjDIm/1jgb2/3l0fXCVTUv0pEjmumjtHsfgTktbO2bMYo7o8sLZDrJL
	 47dbZqnPLFKkWC8bw2EteT1SHnkVnPF/BIVtviwQ3YZVdZHrBKWK+KloqS7yOk9kX3
	 B6ttjBysSbKNwWznwbD9VvkRG8MpMnpe3Ti+G+9FCq7pD7Kg7yI+1l2968Zw7TmOtF
	 lkbOnmHUwpPN6ePvPJunhq+SlEdxIvlUgic+F5swtoDO6oykjXgx/P+U2RB/0Et1P1
	 1P9/1v6aAtIEoPAuLqOXLGdqaiHKrwOKcmBYbpyzOvVc3BdRegzWK+wumzpDrsxzmK
	 OHwqZtB9Grgiw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jJmqF4Rj7z9rxB;
	Tue,  3 Nov 2026 12:40:57 +0100 (CET)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 03 Nov 2026 11:40:58 +0000
From: mateusz.nowicki@posteo.net
To: Christophe KERELLO <christophe.kerello@foss.st.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org, Russell King
 <linux@armlinux.org.uk>, Linus Walleij <linusw@kernel.org>, Yann Gautier
 <yann.gautier@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 3/3] mmc: mmci: stm32: lock the STM32MP25 delay block
 again before tuning
In-Reply-To: <6d138e10-343f-4fa4-8886-0480e95fe96b@foss.st.com>
References: <20261031120700.42576-1-mateusz.nowicki@posteo.net>
 <20261031120700.42576-4-mateusz.nowicki@posteo.net>
 <6d138e10-343f-4fa4-8886-0480e95fe96b@foss.st.com>
Message-ID: <21a6bcb074c46fbad82d9d913150bdf1@posteo.net>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hello Christophe,

> This patch is similar with the one that we have on ST downstream.
> mmc: mmci: stm32: release the delay block before enabling it (Commit 
> 01d3cac)
> 
> If it is the case and if you are going to upstream ST downstream source 
> code,
> do not forget to keep ST signed-off author, please.

You're right, it's the same fix, I just hadn't seen your commit. v2 will
use yours instead of mine, with your authorship and Signed-off-by kept.
I only added a Fixes tag and Cc stable.

Regards,
Mateusz
