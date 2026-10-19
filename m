Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792432322;
	b=YmJ90vsd/nr3cVn1fuR41OvKPnPSMQ051ZOIHVI9Qg1gSXWa7ley+NYCoBa04t6j1JEH
	 7a+co1hTNeEfPSIZONLmYc1gJvrtGgFXQ/bTV/LpGe9hadiS6hdb2oUQEh8/7/j/Tjl2F
	 uShMRuCtt2IJiYlP8jywhrJOhJ48RvvJa1OlzR0d/SCyMYnnGeRp68m242PY6fwZ/mgeT
	 NzYqRwkHbN6WUGBoz3GctNnvtFBMF5r0hH/wdVYeGlHYTBq5IFGR+T42K2hlw2iSz/+gc
	 +yN7QixXA/V3rT+3LGQTxUopt+kefXvjI4Uj2kyfUIp9d3hQ1t7a6/fd2SkrOiZhzTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792432322;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=tIMFS9Evml7gxusVnbmoqtHNewlMfrZaUCwAp94NXiQ=;
	b=3YP/zkTI7oGjVeDqxYtd/1Dha7aD+CkcWqn9b7LN0cdOY1Q0KIXReXAhuMBFXNGjSrX7
	 Xb4y6lRSYou13seImv6E1UxYHzD+tdJNpea2BAQHlkdvL9MtKxtBXcweJeomCzrboflPv
	 PPLDdNDG4NL9l+2Qoy1DHuoRlJi4tOVOSJZgbkF7NVqY7/FCRX/sNgwOChR57bXYE1Pxh
	 mskZ67/+5naAd7qyJmYkSzbxduDa9ZW467/ZCMNM+VsETMFlR5iiSZ1luV1CCbGaj7c1G
	 HfqiP2/NNZRtzSYL7muikKLI54knPKo/+0PtIi3BW4qUzig+zHz/wD9gzq8O2FSf/hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="d5//Jip+";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D9C606A320
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 17:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d5//Jip+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249FB1F000C4;
	Mon, 19 Oct 2026 17:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792432321;
	bh=tIMFS9Evml7gxusVnbmoqtHNewlMfrZaUCwAp94NXiQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=d5//Jip+nneMljLnBsnQjJS1NSMay2jyygvYn3rfz2PAFm5ROuMED9tfD3cQXUD7P
	 W3fNxG7gvvJxxfQ5BWMW9/S9cxhQbLxBv49C9wJShpqwJ9/9qoF+Mvk5/dMbIKHfv8
	 RzuvJ2RST8YQJkpZ1TxSOJVAeP3CJ65X9IrinJpN7wRWB1KEAxSBxgasNPFc+YbTZK
	 +Df9hQHuvkRFtxEAJW+Sqa0QzbNe5kBhJ74qaWmK9RqPOqnrPCaf2gL8RQTyMQxkdr
	 tpi3nsZbv1LbA5LOVsTeNLWnxbXfjTzyZreXhxfThnATVKIZpLobyv5uT3zVZABezg
	 sW/tRW7jy1zcA==
Message-ID: <8146853b-69ad-4d49-979f-334a4bc83df2@kernel.org>
Date: Mon, 19 Oct 2026 19:51:59 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: stable: queue/* branches no longer updated
Content-Language: fr
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org
References: <e6ea1805-3e82-476c-86a8-096b80bde74a@kernel.org>
 <aImjNPvGPMqFu3RD@lappy> <9989cd82-d126-4dd3-96e5-37dad7f733fb@kernel.org>
 <c9ca13cc-a7ce-48ac-a7b2-a8bdc823aed3@kernel.org>
 <08bac413-ad6c-4e3d-a879-554ab0f195db@kernel.org> <anNf2xwwXDfinNQs@laps>
 <9b7ad8ef-a10a-4a94-9244-0ff983ad480b@kernel.org> <asS7KK444n7U01u0@laps>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <asS7KK444n7U01u0@laps>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Sasha,

On 06/10/2026 11:11, Sasha Levin wrote:
> One day I'll figure this out :) It should be back up.

It looks like these queue branches are outdated :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

