Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794055988;
	b=Ibm32ye2W2jX6yyoRzkh3+UKHkJbVSLuyfEwmfqPW9jBRSA6HGXgcUUP1GNvbREJ6YXT
	 vf0VhUJATdm6axl8w4BO0LHZvIJI/z7+0dcL/R62nHWS6haI1id7iDtJkxmtOWVW4NXkm
	 1A0CU/M32tQn3pIiJHScDCt3ysI5I4nQwZEkQ2u7X30CFvFBJ558XCF3cJCYeeWRFJ6bz
	 2cwN97bSxPXom4audd5Lq17xSgXH4LW864Oxti7shw3b7siT6zepV9LK1368dTQJ8rbMN
	 appHHy7I8bpPkbHUz9ZktBZZjqFugJVtPS4KUWVRodRwqq2s+eSF2Lqo2Qa9P0yzsvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794055988;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MUfEtLiUW9DhGw36OlKm3YAzs0/n7nApDJKkTMlhLPs=;
	b=igP9pGkR/3tlZ6w/XrripsJk2Q0zrkB6EWmYo1STV0F2JvRocduKxpBHZN2fueC2cuLG
	 EP5wHqwCwDvMYs95jVYVSqTBgTUy12w86xPdNsw4VMOWP/pM8VfAoHp2sHUNYcRyBL2hq
	 ceZ5KpYiSjJX6PDyA4GIqAqobdQAlhM1SVQMZYAMdrxhLof9/hk5PWjw2AGLHHUEu+DNt
	 6XNCOoYAPQ6kzVkpwF6Ho9DTEE3rg9E6JagO7eWmP7OqjwlrFCimkLc6giyOZS6ErPP7L
	 uOxQsF9n/6fmy/umoeA5huNTIwgIPgR8aXR41ObJ5G2lToauqfGKXAO073SKHfpEx5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="WcF5xZQ/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29999606A32E;
	Sat,  7 Nov 2026 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WcF5xZQ/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDDE1F008A1;
	Sat,  7 Nov 2026 12:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794055987;
	bh=MUfEtLiUW9DhGw36OlKm3YAzs0/n7nApDJKkTMlhLPs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WcF5xZQ/dsy7NTFNufK6dq4ME5wjKHZpO3v1PczfMqD2eBOKu8Yq9Wx21FbjD95/X
	 Ur8ndzbxRS9sRSSgp96Q5Qgue+bTPHCebDkAg9BSV8es68utBOWJdkApLP32tIRX91
	 2DDFWC3WJzEyxpzxlIEGa/2aexspShXDyqDI5UyKvUcaJ3eks2Gd2B9xUnHK6ceSkx
	 mc1wXQ939o3WHhFp50FGgJ6E1Z/MxwjOGSLuTWIcciFcc/LlnzdvtbBHvuzjMYNBxc
	 i+QKtYl+O6R5n/Fn1tbwmeTVU+PcWUTgwuLyAcp/wAIFu18RM0YSdGOryF9Jb1y98g
	 zANbq2SHTZw8A==
Date: Sat, 7 Nov 2026 13:53:03 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Marco Ziliani <rylos78@gmail.com>
Cc: Kyrylo Biryuk <illofspeed@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ata: libata-pmp: disable the SEMB port on Marvell
 88SM9705
Message-ID: <au8fL13gKEtKwlQY@ryzen>
References: <20261107081335.3360920-1-illofspeed@gmail.com>
 <20261107105333.19934-1-rylos78@gmail.com>
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
In-Reply-To: <20261107105333.19934-1-rylos78@gmail.com>

On Sat, Nov 07, 2026 at 11:53:33AM +0100, Marco Ziliani wrote:
> Hi Kyrylo,
> 
> On Sat, Nov 07, 2026 at 09:13:35AM +0100, Kyrylo Biryuk wrote:
> >                                     softreset  reset failed,  last disk
> >                                     failed     giving up      attached
> >   7.4-rc1, no libata.force          60         12             197 s
> >   7.4-rc1, libata.force=N.05:norst   0          0              70 s
> >   7.4-rc1 + this patch, no force     0          0              11 s
> 
> Thanks a lot for testing, and on a second unit with a different setup.
> 
> The norst row shows that the commit message is too strong where it
> says libata.force cannot work around the problem: norst on port 5
> removes the retry loop, but the last disk still comes up about a
> minute later than with the patch. Niklas, Damien, I can send a v2
> that says so, or you can reword that sentence when applying, as you
> prefer.

Please send a v2.

You can pick up the Tested by tag.

Please also remove any references to Debian, we usually don't reference
downstream distros unless there is a very strong reason to do so.


Kind regards,
Niklas
