Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794931919;
	b=H5HoCYTwE8ISFk3ABpYMMKfpmx4ahJkA6tpe1tMFBWJonvIazFFsyfhZDccK2u4p8phx
	 rumqvlfmIv8xAhgp77vS+x4Z0JbsqI4FxLWV3X7gSXXaoWaAXxNYhp4aAfZ2e03sO4Pfw
	 LyZDgesPBrYQnO+T76xoyHi2DQTGb4mJPbjS1zFizNAgz7P2yQA/v+BQ8P+IV7Dzndj3P
	 2fGBLoy49tHj97DNiHqGcrhkwBhHLac9fooHi6PA5dUUcZMaM/DgsvE31lTmH5vou3pMc
	 LRWbtIqtjIAwmyIqsu2Xo8zFKez1JYsb5Hdkf91vHIxfERntbDaCT+oogy1Y2pKMPfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931919;
	h=DMARC-Filter:Received:DKIM-Signature:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-MBO-RS-ID:X-MBO-RS-META;
	bh=C+/AUdfsu88FZdOzB3Ceivm92YN7hPUaaH2hshhL5s4=;
	b=fIhKH0Mqenas2TYDqBBFFOGzgvwXYo8aVgEROCBnbZ/7dDyt62QggiKtdMAvuXzQARV/
	 TB3Th/NOHId1phWlQkX6mtZzTszOn+BU9yvPxU2IXOP4/ZgOPk3VHlx0Npq9kVX5IqT4X
	 m8am/PV6KTo8ymfODpwhdw8WqBNDJUvf75zQID4rs46hDjPePdPo2GXhVg5xeJ4zuEP8F
	 I8ug4atORmppYrrjU/bum6FAze2raF7Cegn+LvHmeAPGaR9Srz71S5kNrczf8eO+693Jk
	 +JOj0Nr1vHCbL4X9jhmg6M+VIKAWFxRP2pcl5P9ScRVUgMAJI++CGfQx2SjP4H0qTng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=FVyhBiuk;
	arc=none smtp.remote-ip=80.241.56.152
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718D4606A31C;
	Tue, 17 Nov 2026 16:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 718D4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=FVyhBiuk
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jTV9Q3wlnzKsYR;
	Tue, 17 Nov 2026 17:11:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1794931914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C+/AUdfsu88FZdOzB3Ceivm92YN7hPUaaH2hshhL5s4=;
	b=FVyhBiukjGN0IChfrbeKrW5gFydhU7beNSxvrLN+l68O489LClCTJg27UQvBIEdYrcv5wK
	W2LT38F7gf54a2gObCMokR5eC+Cxwb6oivgWZAbsPDYV/tnbz3i+OF04A8e0urKL8zy49u
	MVHteKBOiOoSjpzngWzJvqj97oAwZsTncouJqcFfuZ7HdGoa+5OvJF3Aq9Ofz6QnLT8WCs
	3E65iZpipOWiF3kNnaGPKKNGdx8GIoPwUbOGrVcmY3kTwdZKDyVptT8P76TXQk11Yxjaem
	0CjL5j+1FB6NVSUVMZ+pxJuMijyilEidzX6SplpTKeNaiKv7wU5Wco1/2gQQmQ==
Date: Tue, 17 Nov 2026 17:11:47 +0100
From: Lukas Beckmann <lbckmnn@mailbox.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Thomas Renninger <trenn@suse.com>, Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] cpupower: fix use-after-free and stale limits in
 frequency-set
Message-ID: <avx8wwQBBu5n8z9f@lukas-arch>
References: <20261115-cpupower-freq-set-use-after-free-v2-1-6b91f1630165@mailbox.org>
 <94e8f3c9-5162-4717-8063-f5c2b4828456@linuxfoundation.org>
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
In-Reply-To: <94e8f3c9-5162-4717-8063-f5c2b4828456@linuxfoundation.org>
X-MBO-RS-ID: d93b12a79ef357f0894
X-MBO-RS-META: 4pfju86zrmigpnp5oohjoqxi7srbiozz

On Mon, Nov 16, 2026 at 04:30:10PM -0700, Shuah Khan wrote:
> On 11/15/26 03:03, Lukas Beckmann wrote:
> > @@ -141,9 +141,10 @@ static unsigned long string_to_frequency(const char *str)
> >   	}
> >   }
> > -static int do_new_policy(unsigned int cpu, struct cpufreq_policy *new_pol)
> > +static int do_new_policy(unsigned int cpu, const struct cpufreq_policy *new_pol)
> >   {
> >   	struct cpufreq_policy *cur_pol = cpufreq_get_policy(cpu);
> > +	struct cpufreq_policy temp_pol;
> >   	int ret;
> >   	if (!cur_pol) {
> > @@ -151,16 +152,22 @@ static int do_new_policy(unsigned int cpu, struct cpufreq_policy *new_pol)
> >   		return -EINVAL;
> >   	}
> > -	if (!new_pol->min)
> > -		new_pol->min = cur_pol->min;
> 
> Why can't you leave this logic as is and set temp_pol fieds,
>  if (!new_pol->min)
> 	temp_pol = cur_pol->min;
>  else
> 	temp_pol.min = new_pol->min;
[...]
> 
> Same for all of the above. Make just the minimum changes
> to fix the problem instead of changing the logic
> 

I did it this way because I found it easier to read. I will keep the
original conditions in V3 to keep the diff smaller.

Thanks,
Lukas
