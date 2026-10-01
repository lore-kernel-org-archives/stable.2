Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A343F1AD5;
	Thu,  1 Oct 2026 11:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790855342; cv=none; b=X4Inr7TbdWZ/9mRVQ9Mv6txvCg+oJAgnDkaYM+542fYAzOYAmUM8+HBZ7uUl3Mhr1ie81um0n1i1r+xIL3FkRnhU3zamWssTzoBb2rmATKFVP55QkpfPbrK7i5ggiR+yeteMHITAcRDYTY2C6ZRiLOUJgHSaXz46LYT2f+iWiJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790855342; c=relaxed/simple;
	bh=UylmzUQGEvArnSFwtRmwcnvgZ4nhVSm5y5o+XJr9YRE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=E22YvlR9KFnUYi5FaGDs5gl4PNmSfp710bc/64EvVluyeDvZ78lWTKcZEa84OuD5OSI3xRYmL4Hpc9M0wFT73sf9F62s6EbhVGZXDwWobfzHYfT5CzJYsYCiEQyKg28k3H3M6hOtPXOANuZRVQWO4j+Uel4xGgEX6Uqvt8FXEUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=Ghc03kGa; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="Ghc03kGa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=aT9YUfg2DMWZxrRjOl+juSwohUp0W3fpSP96rBnYKPg=; b=Ghc03kGauDYkA5Cy/LjZrxTaZx
	2W0pjXUbdqVu+AfFtb5MZxFELFaGYIdtJ62Df0Jnjpm5e6Ju27+lR076M0jjSBWvAw2Bli8Z8BWUr
	RVVJy0OJLi9M3KP/+T2xydnh1eYaxl/G94Lc7ca9VUyeAsbj41cYoOdInD/ugUsAewMbMq9YY9agq
	HAsgbd4WpnLp5AMfiUc+QKbH3j4LkCKhnAxJZCU33rEkxwpRF5xznGD3tFATkaV06prOt3TS4A1gW
	mdrXKSfxmPz0vD5bGziYUFt3qRx3jjBpkdzlkItTmV5AYEcVDCOZGYKJcs/jDa66krSd1mPgTbixt
	1/3ZRGdw==;
Received: from [::1] (port=41106 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xCFHV-00000009o0n-42No;
	Thu, 01 Oct 2026 13:48:54 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 01 Oct 2026 13:48:54 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, "David S . Miller" <davem@davemloft.net>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Boris Pismenny
 <borisp@nvidia.com>, netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH ipsec 7/7] xfrm: leave the sequence counter unchanged on
 ESN overflow
In-Reply-To: <ar5H87hRaIpERAZ4@krikkit>
References: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <20260930144523.435271-9-Jeremy.Jean@oss.cyber.gouv.fr>
 <ar5C8DDMwWn-30iV@krikkit>
 <69f80ed58e34f787305f85b12eb3ecdb@oss.cyber.gouv.fr>
 <ar5H87hRaIpERAZ4@krikkit>
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <86612356acc73d5b26ed34d5941cb692@oss.cyber.gouv.fr>
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

On 2026-10-01 13:45, Sabrina Dubroca wrote:
> 2026-10-01, 13:37:54 +0200, Jérémy Jean wrote:
>> Hello Sabrina,
>> 
>> On 2026-10-01 13:24, Sabrina Dubroca wrote:
>> > 2026-09-30, 14:45:24 +0000, Jérémy Jean wrote:
>> > > When the 64-bit ESN counter overflows,
>> > > xfrm_replay_overflow_offload_esn()
>> > > rejects the packet and rolls back the stored counter. It decrements
>> > > replay_esn->oseq even though only the local oseq has advanced, which
>> > > can later induce a reuse of the last sequence number and the
>> > > corresponding AES-GCM nonce. Both IPv4 and IPv6 are affected, yet,
>> > > processing about 2^64 packets under a single key is required to
>> > > trigger this bug, which is highly unlikely in regular use cases.
>> > >
>> > > Leave the stored low word unchanged on overflow. The high word still
>> > > needs to be restored because it was already incremented.
>> >
>> > nit: using "low word" and "high word" instead of the actual variable
>> > names doesn't help the readability of your commit messages
>> 
>> Right, I could specify that. How do you suggest I do that? Should I 
>> send
>> a v2 for this single 7/7 patch, resend a v2 for the full 7-patch 
>> series
>> (possibly in a couple of days in case there are some other public
>> comments), or another option? Thanks.
> 
> Unless there are other reasons to send a v2 (ie some more important
> issues in a patch/in the series), or if someone requests it, then no,
> it's not necessary. That's just a preference in wording (and possibly
> just mine, maybe it doesn't bother anyone else).

Okay, I'm not doing anything just yet then.

> In general, do not resend a single patch, always the full series.

Noted, thanks for the advice.

Cheers,
Jérémy
