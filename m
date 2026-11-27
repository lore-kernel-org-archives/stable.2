Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795774419;
	b=e+vNfKbPWBeOWLZEFra5B4KZBMQFEG8ne3STXffICFXhQcXlL5lRKxu/6Ft9jphjnz5T
	 tyDtKE1622PjyAyh7Dhby5GzHWTHMVCpTFML0cn4Xa2pAAfQdT6AqNWFkfIHgOUPOkY8z
	 jIRRRDFY8EZyi1N/QdUv5yjIqTqNNvDc7MR/H5YglZBXVhjhFll2Ma86lXgk4C89Pp9A5
	 HtU6rNQhpJ4FtgsQ8sn5TRr4K+hvAWmapnj0YXvc/z6HHBpuDmnY54wmipxRigolK6sOL
	 8uci6SZ/Y0zh9h5m4Cfj6lE02nWAU3iIG7JAoovETz3VcHcQgVnfKxPkE0xdyh0NBjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795774419;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Sg2B25w2A9gqNOobPy0gY9riAv1YrthUMRv2K9cH/Rg=;
	b=GU4sLfMtlWv35pa1UmwjWU2IcuuKURnerqkRkp+lHEfPXEWqSh+XzS05BAnH3vMCApcC
	 nFw75YptF1ohS6dYiijFHgLhF5vDcT9i4JUFf+w4acCMv+nXKiFY+AMYr4bXrWaCzihL7
	 Bn8QbN6/KgFUh2MGXPUXeDKZjF7puxbBD+iHD0Mp5C7zmL6BtOgWOo645shhLyb02QUL/
	 ToEKzeZ1GQhQ1sgHhM7+apQSQuGIlRB7W0h1caBoadAzGRuIni36KReLwvBm7qq/N+oSp
	 HzlwoGA+1hOe4Lcgfe6iKvkEc0Li4svfaz3CiuAyQbLiSbX68QwGSc3Gs1rLqOUPMbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HGiv9SeW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D696606A6B7;
	Fri, 27 Nov 2026 10:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HGiv9SeW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302BF1F00923;
	Fri, 27 Nov 2026 10:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795774418;
	bh=Sg2B25w2A9gqNOobPy0gY9riAv1YrthUMRv2K9cH/Rg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HGiv9SeWvGB4FaTAK9Q+5bgT5ZORzC54Mv+Dai5kcFholPEUugzfj7eJyxO1l5hYH
	 ltsDwKmje13mBeIYV/3miAcyuGdTKScCfpa5h7vKwGGNxjO4+//n4SSVprlEOeKmPZ
	 JO33YjmKtsJaPeDiiMDofST9iQp9xBz/dAKfP42sx8P0a4VcwdM6/INbtNej2S/n+p
	 uz8Yom+b1OfMGf8VGiVXVt3UqSm1NmpSfJ/FQOPkAHKwP4OuYp+9SMbH0MWyITrz5c
	 6ENmwhwOwFnEW6D+K664hTgHGwf1dLqhFuJhaB1uTjs6gU0Wu4XwxVqUseua5oN4BM
	 uZ2aMto1ysm2w==
Subject: Re: [PATCH net v3 07/10] rxrpc: Fix limit on packets to be
 transmitted in one go
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 jaltman@auristor.com, stable@vger.kernel.org
Date: Fri, 27 Nov 2026 10:13:37 +0000
Message-ID: <179577441777.3135.5399617853281173175@kernel.org>
In-Reply-To: <20261124161302.4044422-8-dhowells@redhat.com>
References: <20261124161302.4044422-8-dhowells@redhat.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message for "rxrpc: Fix limit on packets to be
  transmitted in one go" describes the mechanism correctly: the inner…

--

rxrpc: Fix limit on packets to be transmitted in one go

This commit makes rxrpc_transmit_fresh_data() honour its limit parameter.
A local variable of the same name, used for the jumbo packet limit, had
been shadowing it. The local is renamed to jlimit and clamped to limit.
The remaining limit is then decremented after each send, and the loop
breaks out once it reaches zero.

> rxrpc: Fix limit on packets to be transmitted in one go
>
> Fix rxrpc_transmit_fresh_data() to honour the limit set on the number of
> packets it can transmit in one go.  The 'limit' variable is accidentally
> shadowed by another variable calculating the limit dynamically.

[Severity: Low]
This isn't a bug, but could the commit message also say what went wrong
because of the shadowing? The patch is Cc'd to stable, so the user-visible
impact would help backporters.

There are two callers of rxrpc_transmit_some_data().
rxrpc_input_call_event() passes UINT_MAX, so it was never affected. The
other caller is rxrpc_tlp_send_probe() in net/rxrpc/input_rack.c, which
asks for a single new-data loss probe:

net/rxrpc/input_rack.c:rxrpc_tlp_send_probe() {
    ...
			/* Transmit the lowest-sequence unsent DATA */
			call->tx_last_serial = 0;
			rxrpc_transmit_some_data(call, 1, rxrpc_txdata_tlp_new_data);
			call->tlp_serial = call->tx_last_serial;
			call->tlp_seq = call->tx_transmitted;
    ...
}

Since the limit of 1 was ignored, a TLP new-data probe could send every
unsent packet that fit in rxrpc_tx_window_space(). It sent them in jumbo
groups of up to pmtud_jumbo, over several loop iterations.

rxrpc_prepare_data_packet() sets the serial of the last packet sent:

	call->tx_last_serial = serial + req->n - 1;

As a result, tlp_serial and tlp_seq ended up pointing at the last packet
of the burst rather than at a single probe packet.

Would it be worth adding a sentence along the lines of "the TLP new-data
probe could send a burst of up to the whole Tx window instead of a single
packet"?

The code change itself looks correct. With limit == 1, jlimit becomes 1,
req.n becomes 1, limit drops to 0 and the loop breaks.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124161302.4044422-1-dhowells%40redhat.com
