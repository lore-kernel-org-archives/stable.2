Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164665;
	b=XM8ALkfwiWtqjTLtixJZvuqPp+ZmuVZdtIxxkf4aoEItO8EYzGKlBrHh9eCH/iRcHvu5
	 LUbi5+cWcHI6JJ/DNJGdnkOboNzBnx7nYXkLUNOD9nP3wPbF+E6TUolSyFS8YXLHOaJ4j
	 R0X4CLtIS6y30HjtWYAbLzHMuib3AdXuNwg5rP+qlw8uu/G0MEF1jWM/bNKptSfR6EKLn
	 rdhfxQxkf0tjTDPBFm5EMQqqzyhzF82DHEz9sPS4R20HCoSN6RsmK5fmbeyXNjdTvJCeT
	 xy2rh7CzNIdVtFfxjLgZbuwhEQ8fD28P9XlDTILjivS9kcFFAcOeMUBGCqRxWp//Pug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164665;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=eZjiPYXsdIk0XjYVMMUMowmH9ppV/RJOAmOMmXIiqzo=;
	b=1MQEvUGqZ36WHNk1Y4o7blNsHfc4rpVEBqAPhPfTR7Ynnsr6b8omeYfEm+V/kfPDenY5
	 9dzQV0tvl5wBUBpqOijUvYPgGqPOnmWuaH5sQgMe8unTwvQBYMsJqnV7xFDcR6JNNPARP
	 DUiqhxHQ4HEjzvgiurG4bC21yRJFWxZDo2I7m34MZ8PbQbQ6Sj1QDrgmMKX5CxSUuBuz6
	 A4TagDwht4vYxkxrfbEwN8QUS8ArhBv5FydQH8e6tjp2TpLvGtOJdOPVvhzEe5nZcW4ap
	 jFy+d8iajGEyqD1VKr1LxevOWfQ5Pdznfkih1+amuS85oAgHJrfK+wyP/UcJ7r0NShA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDiO7VQV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576C6606A334;
	Fri, 20 Nov 2026 08:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jDiO7VQV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BFD1F000C4;
	Fri, 20 Nov 2026 08:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795164665;
	bh=eZjiPYXsdIk0XjYVMMUMowmH9ppV/RJOAmOMmXIiqzo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jDiO7VQVp0aY4QTeLzj5j+ee1hYMM3NMd+fxtfhUur9nsGmn/icaYT+66I5v4/dsR
	 BZl2NJSygKGzknd67VSQdQ0FBZcqu2oKsdXQFVrNrtJ/iZi3eUW+ofTNwTeRstiTpC
	 ByUe28OE2UNWBEO58TWJCzJlflbwgZDsrAPb60SR2YAXUxEHHCpxn55R4j9M2BkC/O
	 WoTLFNm/yZH0sk9ZzwSZ4aQkpYiZfu6610ax6YiJCoMMxcwALoA0bpdCmoXZUjnQWe
	 vKZrPqMmHQux4t9DXxTNvq12BTGLxZtu8k/4G5DQTJwXuKcSG8eZpsxasrNkXnfFYW
	 ODJAGhzEjrEIw==
Message-ID: <7be30913-ab2c-4aef-b7e8-5a250b4eedf0@kernel.org>
Date: Fri, 20 Nov 2026 09:50:57 +0100
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
Subject: Re: [PATCH net 0/7] mptcp: misc fixes for v7.4-rc4
Content-Language: fr
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
 Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Quanye Yang <quanyeyang@proton.me>, Petar Sakic <petar.sakic@ink.fish>,
 T S Rameshkumar <rameshkumar.t@phytecembedded.in>,
 Chris Mason <mason@kernel.org>, Mat Martineau <martineau@kernel.org>,
 netdev@vger.kernel.org
References: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-0-bf7656de653e@kernel.org>
 <869ba3ad-381e-41b1-adfe-2ef86fef5ad7@kernel.org>
 <20261119183200.27386123@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261119183200.27386123@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub,

On 20/11/2026 03:32, Jakub Kicinski wrote:
> On Wed, 18 Nov 2026 23:05:24 +0100 Matthieu Baerts wrote:
>> Note that patch 2 should have another Fixes tag (sent in my reply to
>> Clashiko). Sorry for that, Sashiko/Clashiko didn't notice that before.
>> If changing it when applying the patches is causing troubles, could you
>> please drop this patch 2/7 and apply the rest?
> 
> Updated the tag when applying. Sorry for missing the PR.

Thank you for having updated the tag and applied the series. No problem,
I saw how long the queue was on Suie yesterday!

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

