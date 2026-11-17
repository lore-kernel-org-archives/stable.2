Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794927494;
	b=EdNh9l9PKb4kWeY/YIORMb/Z/5+Q6jR0L42vFaKuUp7fHOoGuiKPwn14PoIZoxzucn5i
	 f1zdKHmIZ9o9rhy8MYy2FHVqHJHpibRxRkyU/SPYeMd/6pAv1tW58Y6Z4U//wvTPcQLZJ
	 Y3NPqbUPD5dVwNRmBA7WxJyZub9Uwl8IfzLgogNqRG+TOYNd01wWQLRZbtDI3MITa5tpe
	 0mCrLluUO1lfQTOtJc+HfZTkyh1ax02kjG3Dxro37yxH05yiESZi0K2nigDvTfivbAir0
	 kltaJhR0gtFY7avR5IlHqTYTbuXYoWabiRPVNm+uyy/QWaQZbBdEDDK5IvL7JH4H3lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794927494;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=A5dpDNhKfcFR3dAeXSkWJDaG6QMB3ddxqUaR/wnhQYA=;
	b=BjL7KtaN572CWxqQ4tvmWjM/4jdtbm0qHbL2h0xRb/nKtaaOWTtYscPvuIjVv/8d44at
	 lD+uzbCejstRreEhFMxB21sZioeLVmzeOksUBL1BlibmAO3VWYliyhhOGI8dGuF7WX+Se
	 FU/ly2tPxYpEePnpxTkNjXhzylbMcQV98RH4P9gdX3OuiaAI4kgOaiWPgpsmK+InPnhDP
	 6JscPqupr7c22n6KXJCy7DjUQmg6PhcDgPygZE0Up4HrH5Hx3cVLA/WKET5u3cM1t8WRk
	 si9NVDj+XbU8v6o1ubb4B1hYL21cx27/3rJjZyP7yxHvTvDmjM58u0qeVXqaQW99v7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WrsME+Ti;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E915606A337;
	Tue, 17 Nov 2026 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WrsME+Ti
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D6811F000C5;
	Tue, 17 Nov 2026 14:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794927494;
	bh=A5dpDNhKfcFR3dAeXSkWJDaG6QMB3ddxqUaR/wnhQYA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WrsME+Ti30OxO9d1ncobzgvePZVCcUY3wu5KHkx2tB2tiVajRdUe8lECvliM9EQPj
	 vjb5ZYffNuixNXr94NS0x8v0jj/pCRvFjJ2fExlkBBc8hK+nEJQf7BEXbyBHBi7PA9
	 PnNyvLTlcQ+YMFzx61YZoJ6SrQVUnq+45bsD4OXVSCurFX8aHHRLYTbWJfwdT2PEK6
	 Kn7Es+ndRZsTpxS92WW5lwxUCg5FCrsaqZg/yeuffc1LHHe3nfEk3YP6IyXCqMfir3
	 BP5HPfFlK7oiLoQTbfPxd1kjQB1qNbpY/tvY12SFMhCwMNxKOCKT/2+Eg6w956/zMy
	 vTrQ8rYQEMssg==
Message-ID: <51570131-ef39-4571-8ef0-22cf94ee5ca6@kernel.org>
Date: Tue, 17 Nov 2026 15:58:10 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] w1: ds2490: bound the search results to the found_ids
 array
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Christian Vogel <vogelchr@vogel.cx>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261117145534.755665-1-maoyixie.tju@gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261117145534.755665-1-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/11/2026 15:55, Maoyi Xie wrote:
> ds9490r_search() queues the ids from the DS2490 in found_ids, which has
> max_slave_count entries. max_slave_count is also the search limit. With
> more devices than that on the bus, the DS2490 sends that many ids and
> then a discrepancy value, as the comment in the function says.
> 
> The break at the limit leaves the loop over the current bulk read, but
> the outer loop keeps reading until the device is idle. A discrepancy
> value in a later bulk read is then stored in found_ids[max_slave_count],
> one past the end, and the callback loop reads it back as an id. If the
> device sends more values, they are written past the array too.
> 
> Store an id only if it fits and pass at most max_slave_count ids to the
> callback. found can still reach max_slave_count + 1, so the check after
> the loop sees that more devices remain. Use one local copy of
> max_slave_count for the allocation and the bound.
> 
> I found this with a static analysis tool that we are developing. A

LLM is not static analysis.

Just say you use Claude or other LLM in changelog, not commit msg.


> userspace harness runs an unmodified copy of ds9490r_search() from
> v7.4-rc3 against a fake DS2490. With the default max_slave_count of 64,

You need to test linux-next. There were several fixes for w1 recently.

Best regards,
Krzysztof
