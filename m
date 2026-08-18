Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227951B4F09;
	Tue, 18 Aug 2026 01:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787015697; cv=none; b=miFzn0qpvh3KOMP1JQp7qLOZcBB1oUJea/97+4DWndT2YmUnPpBZti97Zpdi9D3C43UqK7/Pb/8L5frqF/ugJgaDR7JMHrjL4j6lsLP44GssTX0sVOzIbpJvZJqLGcmXaTZut2R2E0ETxRgazWsmoYb9o2FV1UB7rCdlxI6PBpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787015697; c=relaxed/simple;
	bh=F8DbildL8qjjrpbryd03XIktrDGSgjv8VvdnXSKigNQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=iw8WgnY8YL4JJ7tCxAqjLrC7c8nEd8aTeAnuSkeRxwFqmZjtapLHehawvJ9EWAuILwRYSzWjORvvvz4CxFzDls5xwXpsbBdbJeWt1X3m2Qfak1rPhXSiLUoDt4r2lvgUe3AkTnX/NmF3kw4vWcB1tYcn1bWyt/a+a2yxbp2u43w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=KtUEzGcV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RhVoCf6K; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="KtUEzGcV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RhVoCf6K"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 37E2CEC0415;
	Mon, 17 Aug 2026 21:14:55 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Mon, 17 Aug 2026 21:14:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1787015695;
	 x=1787102095; bh=eznehJjrdF55MLHXy9wiFN6iN9jnSDpY37FgDMGO9iY=; b=
	KtUEzGcVKtkdDL2wpncwP0E/qe8AEo8poDnN1T5SqAgWqk++/i6IsyQ0ey+qC05c
	w3m8KHKX2OEHcBjkPnOiORM4ftRW+cP8rMZUTuNq0uAI9fnkzlrtoeei1Tx7e91h
	vp/qukDc68y2ukdamCd2hyvGGmVh/cUKrjterEjfE+cTT3gusUa1FwJN45xu+9Om
	aXbHhQ21G/yhyz1wJNyIoEgKrmBv8K7uMKN43GB2sqOob83vyPRcFaqBdqGEYWXC
	HVXCqDk214p41KHiNByuMqgoHfwZnM1PnQ3iGFkcQGYmagiBVQZQj0CYIGo8Za6X
	XntEHWSwfbG3LaxvLzBNlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1787015695; x=
	1787102095; bh=eznehJjrdF55MLHXy9wiFN6iN9jnSDpY37FgDMGO9iY=; b=R
	hVoCf6K/L+eZfB4a/I/mYq9pmO3kYckRmehuctDSnT6msGiBuxYUHwKGgQ1AkP1M
	k1Rv0l1uwswMfcw8BIUGXtyYg6NoMX2XjFHToJmPp9sQBZHEIfrtr/JWbFyWAyat
	bewBVmulmzhyS/py3pzWeugrJxzzQs0AKV10ny8zzOK1oYFYrAmiQcQmRbw1pjaF
	Ty0XvUPjM16jVVk4EITeY4wH1ALmT24MXZP6ndGhToYx30g1/a428H0JIQZUlU6R
	ASruvMgsr23nSJglykCTHJFMWCkMPAO8DyB7eq3rfFihN0cSN4rQL73QIpQDnE2W
	9McYUmUHbeuOOeGMYQcBg==
X-ME-Sender: <xms:DrKDahjn4Fl3UGdi89RARmU33ykr9fcqulSYqQvMhLG3xEQo7aAl0A>
    <xme:DrKDag3JEAo8fvVDe-WJ2EzoXtviqPyU2gsvtLSqEkc4Jd6phCf34aqRMibOlCALT
    hyzoYxxAC_Io6fUorDxFSLnOwKkChkqEM1AekVxao_vj6LCcQEIXQM>
X-ME-Proxy-Cause: dmFkZTE+zgtGOdzREWcXbD1vRAvLlzhydEXNIPMJjy/FgSy0Tq0RVIjFpBrhdVpgssf49n
    X2mxUXJzerGjGe6m9YgFkqaWaNySyCPGGueeY9m4aVgv/5A1sf48BcaUkcvmcvaumYumus
    q6D05rw49p5RT12cPZ+//iv+iKjCBzWjBGoRzCqC3W8+ze0eIHYiHRkAW4HdRvYGbfyZxF
    gFJeRfPupwhZAleA8oNYaMvNNQMm3q8I6tyQtw1+tN3vL3aApGwoulQ9FmCVBcBLAKyTln
    jyvsUzP7VqmnUzvfdX4XeYaCT9hS3K7vHfUKJgklIpqhTdRFacegegMO6HdgXGenpVgONt
    3LR21+098QkuY8FU5/IyDWPUHAw9vtFiBWVsFuhvwvG20FKO6kObrOvuiNn908nk4zRxV4
    7FVVdqm8m2CGoCjTrv5HY7ro2WVf2JcJppmJDZoqEw29oaHR0AT4vCI5yy8LZDyaC9zN1N
    cqGeIH1HKQfRsEuNi0/REribIPkdeq9rIGfsfxlgk0nZoj7NRse1Yy4XXB3/wRLxNfjI6T
    04VjcKADnmqhva4thj4UTEVLIEc4/qhqqvQB980KVs5X9iuAZ/EQqOnSk0ugFxSpLpDCsC
    FPfji1TW2n0yU/Bw8bzBhKcxJk9DIHf8rsqjugOb/m9uKmFPVEB/vLzJGnGA
X-ME-Proxy: <xmx:DrKDaqsUypOCl-ait8dLeOIexLNBVG6FNE2-yD5KK-WmxMyetJKgHw>
    <xmx:DrKDatv0uDVYaoF24sEkxOp1o5xZT5n-3DCvFyTLNytb3JYj3G-0lA>
    <xmx:DrKDavFG76YY1n1x-BE1T2RyRwH4K3dsTYBT6Uw4MWAvULpA0Alykw>
    <xmx:DrKDaoONrmiJDcOtEZ-QMFcGSkGkM_mhVri7aNitGJuqOJgvlt7ffQ>
    <xmx:D7KDarUfVl7yB6Sy_whdi6MJmZQJAdIxZhk69gGIjI0rypf4RlJErKeb>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 04F70216008A; Mon, 17 Aug 2026 21:14:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AYHc8g5YNXdV
Date: Mon, 17 Aug 2026 21:13:30 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Steffen Klassert" <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org, "Herbert Xu" <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>,
 "Siwei Zhang" <fourdizhang@tencent.com>, stable@vger.kernel.org
Message-Id: <d31399e1-2558-4af0-a5f9-73f4996e9fab@app.fastmail.com>
In-Reply-To: <aoLGokLlBCkXd6uT@secunet.com>
References: <20260730114028.1077499-1-oss@fourdim.xyz>
 <20260730114028.1077499-2-oss@fourdim.xyz> <aoLGokLlBCkXd6uT@secunet.com>
Subject: Re: [PATCH net v2 1/1] xfrm: use hlist_del_init_rcu for state_cache and
 state_cache_input
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026, at 4:30 AM, Steffen Klassert wrote:
> On Thu, Jul 30, 2026 at 07:40:08PM +0800, Siwei Zhang wrote:
>> From: Siwei Zhang <fourdizhang@tencent.com>
>>=20
>> Commit 14acf9652e56 ("xfrm: defensively unhash xfrm_state lists in
>> __xfrm_state_delete") converted bydst/bysrc/byseq/byspi from
>> hlist_del_rcu() to hlist_del_init_rcu() so that a second
>> __xfrm_state_delete() on the same object becomes a no-op rather than a
>> write through LIST_POISON pprev. It missed state_cache and
>> state_cache_input, which kept hlist_del_rcu():
>>=20
>> - hlist_del_rcu() leaves pprev =3D LIST_POISON2 (non-NULL), so
>>   hlist_unhashed() returns false.
>> - hlist_del_init_rcu() leaves pprev =3D NULL, so hlist_unhashed()
>>   returns true.
>>=20
>> A second __xfrm_state_delete() therefore enters __hlist_del() on the
>> already-deleted state_cache/state_cache_input nodes and does
>> WRITE_ONCE(*pprev, next) through LIST_POISON2 =E2=80=94 a write use-a=
fter-free
>> once the slab is reused. The corruption can in turn cause a subsequent
>> hlist_for_each_entry_rcu traversal to follow a dangling next pointer,
>> producing the read use-after-free reported in xfrm_input_state_lookup=
().
>>=20
>> Switch state_cache and state_cache_input to hlist_del_init_rcu() to
>> match the other four lists, closing the write use-after-free and, with
>> it, the read use-after-free it spawns.
>>=20
>> Assisted-by: CodeBuddy:GLM-5.2
>> Fixes: 0045e3d80613 ("xfrm: Cache used outbound xfrm states at the po=
licy.")
>> Fixes: 81a331a0e72d ("xfrm: Add an inbound percpu state cache.")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Siwei Zhang <fourdizhang@tencent.com>
>> ---
>>  net/xfrm/xfrm_state.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
>> index 36a4f6793ede..f494c1ac57a4 100644
>> --- a/net/xfrm/xfrm_state.c
>> +++ b/net/xfrm/xfrm_state.c
>> @@ -823,9 +823,9 @@ int __xfrm_state_delete(struct xfrm_state *x)
>>  		if (!hlist_unhashed(&x->byseq))
>>  			hlist_del_init_rcu(&x->byseq);
>>  		if (!hlist_unhashed(&x->state_cache))
>> -			hlist_del_rcu(&x->state_cache);
>> +			hlist_del_init_rcu(&x->state_cache);
>>  		if (!hlist_unhashed(&x->state_cache_input))
>> -			hlist_del_rcu(&x->state_cache_input);
>> +			hlist_del_init_rcu(&x->state_cache_input);
>> =20
>>  		if (!hlist_unhashed(&x->byspi))
>>  			hlist_del_init_rcu(&x->byspi);
>
> What is the difference between v1 and v2 of your patch?
> Both look identical to me.

I forgot the net subject prefix in the email subject.

Best,
Siwei
