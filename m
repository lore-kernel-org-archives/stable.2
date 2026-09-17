Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FBE2561A2
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789660639; cv=none; b=ksD1t4IA0O98vS+ltSeXqKlkv25kQJ9mNx7+i0jMHYscu1APbDnTBAo5zs2BeT+cvZkw5+BFNb1fk8OntuiEmZJswso4lyuvP0GG9vCwYPvVDG0AfuSKtb023EIa42jaG3SyTleI6GE8ZINE0fM/uQ0qk6vOAik2FUqMQn9eCu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789660639; c=relaxed/simple;
	bh=3KmAjvg1/hWZ+RG2HDHxrZoYH3ofhurQj02rtKQ4h7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOb/KaEPspe9qgKd9g/5PqadEmmxIxBNZ3wCMfCudXJdfIyYLDfmt+Zy1wP5X45wKhZPFJIRQ6uTu/8hm/vY4J9oTXHUwcdssUXWbvlWAy23xNS4GT7b//YVXZYafbeUBL9b7ufj8j07LE8GtV8UNbBK07s9tK/rp7nTHOc86oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=paun6XS5; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="paun6XS5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 2399A1A0936;
	Thu, 17 Sep 2026 15:57:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E8E9460580;
	Thu, 17 Sep 2026 15:57:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 93FC111C7B064;
	Thu, 17 Sep 2026 17:57:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789660630; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ZTDf8OaqeURgLMZ5E+W4mtiF63QZY3UkbGUJHnDdviI=;
	b=paun6XS5Aa9eJQnGmxIRzXfeJlkaE4A483QIplkcNV7R5hp21OPfaI3+6zrq34NqxcAkvi
	3TqBGWME9WLNnUXeCcrIw2eriPYueyAfq4FW6RFAhZjAI/PFy4YApsteu87IVD/UqxU25i
	ckLkWvN1n+Yu5Otscq8IgYw2CjqLShDM216p4aQ9ghNblLehpYoUERkcX+LE+ylXvF/MFE
	bf9CSw0gIESSUIV7kSixB1WezuN7ZKvx49STCl+LzJJ3g5B2Do28l/7XujP4BTJ0SW8HRi
	DZ1Chg2OuOvJ2Hm9mDFAqznKw1+c5gULQUsBo7kIlgpRmWjt8zXBQoYTYxB8NA==
Message-ID: <b521308c-34b8-40dc-831a-757a163902d6@bootlin.com>
Date: Thu, 17 Sep 2026 17:57:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: stmmac: fix the invalid VID programmed by VLAN
 perfect filtering
To: Linkui Xiao <xiaolinkui@126.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Cc: netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
References: <20260917122245.1338365-1-xiaolinkui@126.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260917122245.1338365-1-xiaolinkui@126.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

+Ovidiu

On 9/17/26 14:22, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> for_each_set_bit() leaves its iterator equal to the bitmap size once the
> loop terminates, so the 'vid' read after the loop in stmmac_vlan_update()
> is always VLAN_N_VID (4096) and never the last VLAN ID that was found.
> 
> Cores that do not support VLAN hash filtering (dma_cap.vlhash == 0) fall
> back to the single VID perfect match filter and hand that value straight
> to the MAC. vlan_update_hash() therefore programs MAC_VLAN_Tag with
> VID 4096, a value that can never match an incoming 802.1Q tag, so the
> perfect filter ends up discarding all VLAN tagged traffic. Both
> stmmac_test_vlanfilt_perfect() and stmmac_test_dvlanfilt_perfect() walk
> this path and fail as a result.
> 
> Remember the VID while iterating so that the last active VLAN ID is the
> one passed to the perfect match filter. When hash filtering is available
> 'hash' is non-zero as soon as at least one VID is active, so
> vlan_update_hash() keeps ignoring 'pmatch' and nothing changes there.
> 
> Fixes: c7ab0b8088d7 ("net: stmmac: Fallback to VLAN Perfect filtering if HASH is not available")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>

Thank you for proposing this fix, however this code is currently being removed :

https://lore.kernel.org/r/20260908164309.59282-1-ovidiu.panait.rb@renesas.com

So no need for this patch :)

Maxime

