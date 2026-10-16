Received: from smtp9.goneo.de (smtp9.goneo.de [85.220.189.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E6E3839B9;
	Fri, 16 Oct 2026 11:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.220.189.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792148531; cv=none; b=PdXS2eshNX2d3MynR8gzu8UAj4U0eB2gcZzvSJ31MZlJOqPz2eXTn8q3tbrfEFYGFrghr7hJUVe6BSSHkUUCJMIFriI5oiRsYDjB4hfaUJlFo1EFLMNcePp2ukOcqqEXINhHNUODZDafJGztEeu8QPJOGjUfH1dDIE7CT6WxOHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792148531; c=relaxed/simple;
	bh=OAjaeubeUAUHPhGY8HoI6VjDEw4sf82UHdDveAXI7yg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ockvzfor8LFbE2ySTBZICdWehlvFF3JRf7i5eKXVhTeorxP0hlZSnxTR63oyr1fCITdmRngbjlPjBS/Km60HJ6YmDWYQVNHe8thUQhss8Cuif97ysoZ+oxLaXV7vePu2UXi5fihP65hntuaQAmXtpmTeOFgMC4l1+rOATi7/HlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de; spf=pass smtp.mailfrom=tk154.de; dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b=gSfeBhSK; arc=none smtp.client-ip=85.220.189.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tk154.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tk154.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tk154.de header.i=@tk154.de header.b="gSfeBhSK"
Received: from hub1.goneo.de (hub1.goneo.de [IPv6:2001:1640:5::8:52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by smtp9.goneo.de (Postfix) with ESMTPS id 41B27240107;
	Fri, 16 Oct 2026 12:53:41 +0200 (CEST)
Received: from hub1.goneo.de (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPS id CF0A8240420;
	Fri, 16 Oct 2026 12:53:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tk154.de; s=DKIM001;
	t=1792148018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KyVzT5xYH9NgbmAWX7BSNshyzc+gh18tHUHGZSLLP8Q=;
	b=gSfeBhSK+uB/U7rPkXlmmqZ2rmEsW5FCSF1frfwbJGeYdPASakR37TPGgr64HjQuLRgrXn
	Fa/cV+0D61dwAoSOzufA/oYVoelC5vmD8xl0LuPyLm389HglEC1Dhc0EpKt+WY2QZ8rd9x
	e8tG8+EgC39iuOJ8yohYKTQJYKp0peml0SHrxq0DTwvUFWLqvJMmbpU0NLaSNm5juiytnC
	4Mv9wNq5VqZCKLEJLqb2w3NHxGnJdycqn4S3s66HItQ3Eezk7MRE64kZgkFUAD97gIhzKu
	TSSw8QGF0PikVIKY/dqD5OK2JUDZcTmjmlq32feC+wxcnxuyGKUO2uAY3pAZDg==
Received: from [IPV6:2003:c5:ff08:ee00::d0f] (p200300c5ff08ee000000000000000d0f.dip0.t-ipconnect.de [IPv6:2003:c5:ff08:ee00::d0f])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hub1.goneo.de (Postfix) with ESMTPSA id B1D112407E1;
	Fri, 16 Oct 2026 12:53:35 +0200 (CEST)
Message-ID: <d1735e38-fc90-4c2e-8b0f-25e6fe70c15b@tk154.de>
Date: Fri, 16 Oct 2026 12:53:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] mlxsw: Initialize register query payloads
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Vadim Pasternak <vadimp@mellanox.com>,
 linux-kernel@vger.kernel.org
References: <20261014173117.26305-1-mail@tk154.de>
 <20261015160007.GB1836432@shredder>
Content-Language: en-US, de-DE
From: Til Kaiser <mail@tk154.de>
In-Reply-To: <20261015160007.GB1836432@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-UID: 4a9e5c
X-Rspamd-UID: df1129

On 10/15/26 6:00 PM, Ido Schimmel wrote:
> 
> I assume that you don't have CONFIG_INIT_STACK_ALL_ZERO enabled?
> 

Correct, CONFIG_INIT_STACK_ALL_ZERO is not enabled by default in
OpenWrt's x86 builds.

> 
> Can you share the firmware versions?
> 

I tested with firmware 2020.1148 and with 2016.3900 from
linux-firmware.

Til
