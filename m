Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F00389116
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.217
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786018182; cv=pass; b=jY86Ju1bloVxe0UzWFDXEUXeKDBc1DqcJOKZq7By3LErAoELSCp5Ed3PNHrsLlT/3SQxNQbVumoyrTiYVRNqZCd3X3N1PeB1oRVcXKig3t0a6B0DONl0cuQXD5rTSBYqZsysFdE1PNrx1/HXCQW8iDha31/56EEj+uVpuL+W5Y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786018182; c=relaxed/simple;
	bh=AnzLRx2zWUh944y8eP09ClNtLewWRVT66KYl4rJmoqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZICToxZU86P6EVrhJZxdMTJM0H1LTgi0wzO9dwY6R/QqjvvSFcYs7Tn6Cs0lMFBNnc7pho66ZyftkcAJlPdXYgUrVslVmmX1TZLpEx/euBAvM6NIT55mqAwAaxNWZi4mhM/dLrvhZWy8ApaPE3QeWRgwDFZ+JV2RQPuXU/p+gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=VdPG+WaP; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=eWdhDKNs; arc=pass smtp.client-ip=81.169.146.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="VdPG+WaP";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="eWdhDKNs"
ARC-Seal: i=1; a=rsa-sha256; t=1786018177; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fLg7jhfXQ3PkPktIBEy4pwaEwuJ/6+7OPqAM+TPXdqcs1tHUOGV6GzXJjLNbWqsyMr
    PUmyHUK7MRggQogs+BLa4pEZVUhb0Jjhgack9rWEEW05PC5RVdtXLJGIvGNoUhdx14zb
    PTQngLV3UTREgNUdmsyXUYEETWUMv1xWrDziZD7yLiOCdcQF0CbYVWPSmb+0hx7hfyUP
    jX+LhLtEx/Sx6Bg7cTIOXGMmjvD4OsC+wCY9Ugx+8zwO2yE6NRkA6q+INzRixTs5j7V8
    p7QnO+vxq/WcZGsLMur7pL5WtzoYYxnc583kQIAsA02VlXBC1BNeEVy+csdJT91AZUjc
    IsfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1786018177;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Ss4FTbgFW2NTTZevCzASNzo6IwJB35ztNlz9BNOmKI8=;
    b=GEuGfiTJOKfxVyc7rS4VcHGCcQGC4C5kW234X1RYVCsWRbt/cy6/4ExQGdyuccyGIq
    NgcG9GhjsocSrcthxMDRq9JxYT8N5fbfPF9hSiz9YM/5VYJaRKJ5gr1NSci3na4H9vqh
    uGaZGDzZzhxU1NN6U3Wr4cA+nPFSQRCJk6oNkdlHtncpDScgrWcP9rrw+S1rbrfMQDfh
    6daE94cDiyJSv4v2NZvBiJtImzfZJ8dihw7CrzbQlqSJKPpBklCQeH2UhcMS/kZEYYMb
    GRypsaJxT5YR/tmAOpSzCKYTolPPmvLkHhFYIOZAXP0fiy7u8T80o8rFt6hggPrTO1fa
    WKcg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1786018177;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Ss4FTbgFW2NTTZevCzASNzo6IwJB35ztNlz9BNOmKI8=;
    b=VdPG+WaPg70jD4I6h8rC9PYulc1mk9+rh55Pr0a3ksVJaVatu1Iz1mlKkgYOMZnzVi
    r16aOq7GZ12BMNhCrpTFy3lYGmNJuuuaSXs+/njBet7ZvHk5rqkwBa1PB5Fm9XGqQXGP
    3ypyy89Tpwnjd+x1HZNcvo6VE8yetThbWVNeWZsXfBq+F/9xtsTKKfriMexgym1TWDOD
    2OL1rgyOyevTPLb+Mrmzf40/RvKcIIJoGMqbesToD3LCQzT10KYatobbzHcZ3GYcbWEP
    UN5FXLroeV2wkQLqLeRDRRmPG9r3uuT27CMU4BgBbjPTOka5UGqRlzixcSwtpIYfsFAb
    vO9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1786018177;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Ss4FTbgFW2NTTZevCzASNzo6IwJB35ztNlz9BNOmKI8=;
    b=eWdhDKNsHWKs6rCB1m7OTFnYhJDyc1Im2OZ2vML2nISiCHdiYLkvQ+KVfB8Nn5SvUX
    m6V/0qSFkRQBL/q9IbCg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tRkI16oOSW1Ti/f4PoH8="
Received: from [192.168.20.231]
    by smtp.strato.de (RZmta 55.5.6 DYNA|AUTH)
    with ESMTPSA id K52819276C9bAT2
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 6 Aug 2026 14:09:37 +0200 (CEST)
Message-ID: <6596e764-a9d8-4557-99e5-585bd680c3ef@hartkopp.net>
Date: Thu, 6 Aug 2026 14:09:36 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18.y] can: isotp: fix timer drain order, wakeup handling
 and tx_gen ordering
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
References: <20260805125414.30592-1-socketcan@hartkopp.net>
 <20260806021809.0018-sashal@kernel.org>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260806021809.0018-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 06.08.26 13:36, Sasha Levin wrote:
> The skb->hash echo tag doesn't work here.  isotp_set_skb_uid() is only
> called from the TX paths, never from isotp_send_fc(), so FC loopback
> echoes arrive with skb->hash == 0 and alias the so->cfecho == 0 "nothing
> pending" sentinel.  Upstream is fine because d4fb6514ff8e stamps the UID
> in can_receive(), but that commit isn't on 6.18.
> 

Ouch! Thanks for catching this!!

I just focused on isotp.c - my bad.

What would be your suggestion to solve this issue?

1. create a 2-patch series which applies d4fb6514ff8e first?
2. turn it back to the original if (so->cfecho != *(u32 *)cf->data) code?

The latter was tagged by sashiko-bot to be not safe enough.

Many thanks,
Oliver


