Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F434396D1A;
	Thu,  8 Oct 2026 16:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476805; cv=none; b=o+skhJl3V4Gx7yfGxXle0iXAqLEgb1gqWC/rQJVJS49HPjW//dpx4VBsWnlKj3s8Ed//UG3ltJkc6tMNDEp1wn2EDWV5OHeC85LoSS4cY6jZ8POYrON7PuBdffkBC0GD2O48qmqB5nuucI/A2pOyF2bPXCW/fzVwgH95YwFPnU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476805; c=relaxed/simple;
	bh=yf7aL/4lvkJZpEmzxHngwDFA5owXaDyrVr/z8qpn7kA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=HgYmFiHd7fpwpkG2m0uvUV8Rx/ajVnuiQf8heuS+gTkhbmQlBNvrb5yIoTUohtMRPtlxXQKt4C0OljozWNCODbtVbXEXZJFXTfPok7cqw/WW00uFcwU7jUs/mmSzo0+eJkUYFh8ZBq8TP3Lh0OQp1702CtX7z9gH3vgedUzpkNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=cjOt5jQG; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="cjOt5jQG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=iavQoIHlWsREU4nJw55w+0cA3N6o8b1GBh7368gJd9g=; b=cjOt5jQGxPhq1u6ZSqfF+JsMnL
	yzqwmNsDKjrgv5uEn/jvIMGJViHvQvO5JfuwwtnQWKGhc4oftpuqeX7Nsziz21F2xHVwjLY+mbUbv
	RXktCpf/B6ZcE71mneZNjPKAreYBpSOL6e/9/42bre4Wund1/8kRx4PuuTSKoZTL/VOqT6MGAEZSA
	mxZI8JihNnxvLL+vV3SZ2pFSOLypP13CIxXCCOuKlrDIY4vFfRUbUPiR+Bps79B7WxXe8BHyr8nNG
	lCitaKP839fZPltVFWHDPxCByJE0xXEtwRl3E7Rl9JsWYYuTOzZDT68tOWnRVlTYLVfryXqlSawp1
	ZYYPhvBA==;
Received: from [::1] (port=54688 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xEqx7-0000000E5so-0Hv1;
	Thu, 08 Oct 2026 18:26:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 08 Oct 2026 18:26:40 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: netdev-bot+sinfo@kernel.org, rafael@kernel.org, lenb@kernel.org,
 pavel@kernel.org, willemdebruijn.kernel@gmail.com, kuba@kernel.org,
 pabeni@redhat.com, linux-pm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] udp_tunnel: drop packets when hibernating
In-Reply-To: <CAHmME9rypRmL0tA-20vJumRBckpbzEaBXdE+xhMqi5M5OKPFhg@mail.gmail.com>
References: <20261008124106.665014-1-Jason@zx2c4.com>
 <179146356621.2527009.11001901701574636880@kernel.org>
 <CAHmME9rypRmL0tA-20vJumRBckpbzEaBXdE+xhMqi5M5OKPFhg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <e443f48537e6ac61a8863e1a678736f9@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-10-08 14:47, Jason A. Donenfeld wrote:
> On Thu, Oct 8, 2026 at 2:46 PM <netdev-bot+sinfo@kernel.org> wrote:
>> This is an automated message. This series looks like a fix, but its
>> commit messages seem to be missing some information:
>> 
>>  - Whether the issue was actually triggered, or is only theoretical
>>    (e.g. found by code inspection). If it was triggered please include
>>    the symptoms, like the stack trace or error messages.
> 
> Yea, I really have no idea. That's for Jérémy to elucidate.
> 
> Jason

Yes, the bug was actually triggered.
It was found by code inspection with help from a LLM.

Jérémy
