Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795039530;
	b=bOX2rj6+sEORkB/CLfmNplPuh9rmEQBs6I41x+JBQSgNv+2IoCdKGqSfHw6lhqgvl5ZS
	 mPFBduhPZKWFKNOT83Zirt/5HLPh/X+Mecg7u7DBECj1F3LecrWctSSulUbqBH9+OzNxz
	 ez96JWjeUqgtVOUlTqnLamOh3BAS2e4rjKMFv22VxsQfyONaYtaTpSdt2tHSn6g+eFxx5
	 7u6+StD83QUaefcT1uQbqVj1IwyuUvV1wqdO4dMAcwhWcVfEG7J0jV6WBkZFSkK1Uvtx+
	 RgCZEWfgB4HMrD2wPucs10k9ssyhRxX9AXDrsvxb0nETf7Uxd1W+OjyzK0+nv6A3sQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795039530;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=lYSpAsZU1uhdZAAtBJFpsRRLLeq9hhkppud65AaR9cA=;
	b=e1iJS3kAcCqRxY+XLjBmDy6R0/Y7bFC7ZmksoLQCmeoqUClhhET/jz3bH3Zz69blpzKM
	 cWQRYduBmvHO4OwAPK3l1jFQAqC1FKk91g5QO1isbV8EUwKYiiLY87NvRFBoBCnB7MY/+
	 V+Grn5/9zhMsbJpkCiMg2VD9wB3h+FFJzx+W2cZzGQx8Xx6vmw8lIamfiHSqdlc81Dtfi
	 Vc6HT0mw8kPlgqm9sDTEbJLaoL5RUZl13bvGJEs7zbguTug/eY9cHLWFb+/bxaqGDl0+Q
	 azqeECMJEzsOY+00GDntrAl8avQoUG3F+n7uuu1B/io+SPlUUmrwDf2V3T28qbkwKuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ti0DHdro;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D806606A320;
	Wed, 18 Nov 2026 22:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ti0DHdro
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351A91F000C8;
	Wed, 18 Nov 2026 22:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795039530;
	bh=lYSpAsZU1uhdZAAtBJFpsRRLLeq9hhkppud65AaR9cA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ti0DHdronxSKKfnKPOs+U0PtffzU+gmTxJbs3wxwFbIjJrwjwcHCqXF99pXofjfE6
	 NYGNMlbskNthkbtM5az7pE25aM2thEyocvyRXxKbDevIJIZ9TUpNMGsfwh3lsWqTOR
	 PO7c63/GXOZgDDAs6ZyoRe4diByuyVRWnF495nI4mb3zNFSpNPMVzdfhYg38/60F/1
	 QkkRZeriW+wOTlY+JqbirteuzamKyAxJ9I/epGii1erQHIEm1Hg7FEE4Usf/rq7Fx2
	 kJVqBMdvtFe2YJX3ypysB9Nr5WzRKNClQ4Icgrx0KW+q4zVoN+mNBndUuq2Iz163v6
	 zh5gn+5Nm1Klg==
Message-ID: <869ba3ad-381e-41b1-adfe-2ef86fef5ad7@kernel.org>
Date: Wed, 18 Nov 2026 23:05:24 +0100
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
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Geliang Tang <geliang@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>,
 Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Quanye Yang <quanyeyang@proton.me>, Petar Sakic <petar.sakic@ink.fish>,
 T S Rameshkumar <rameshkumar.t@phytecembedded.in>,
 Chris Mason <mason@kernel.org>, Mat Martineau <martineau@kernel.org>,
 netdev@vger.kernel.org
References: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-0-bf7656de653e@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-0-bf7656de653e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jakub, Paolo,

On 16/11/2026 23:06, Matthieu Baerts (NGI0) wrote:
> Here are some unrelated fixes:
> 
> - Patch 1: do not send data beyond the window announced by the peer. A
>   fix for v5.11.
> 
> - Patch 2: push pending data after a sendmsg copy fault. A fix for v6.1.
> 
> - Patches 3-6: with TFO, send the data written by a server before the
>   third ACK as soon as this ACK arrives, also in case of fallback to
>   TCP, even if the connection was shut down. Fixes for v6.2 and v5.19.
> 
> - Patch 7: after a fallback, fix the dummy mapping of overlapping
>   segments. A fix for v6.19.

TL;DR regarding the AI reviews: they are not blocking (to me): all "Low"
except on patch 6, but that's pre-existing and not a regression.

Note that patch 2 should have another Fixes tag (sent in my reply to
Clashiko). Sorry for that, Sashiko/Clashiko didn't notice that before.
If changing it when applying the patches is causing troubles, could you
please drop this patch 2/7 and apply the rest?

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

