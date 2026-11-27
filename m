Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795755222;
	b=vr74HqTnUL7fBcm8vQZb2V62DutQfoxQ7RT9SFn/BPlQhPAghOKDmG0WmBwkZe6EJpc+
	 LUM1t3GyHomUgHMoOXJGD3g2/6lBhWV6KqsKEo1fJxkk+Gdy9HmupD7fW6HRy57v+Zvel
	 tOz45ktzIPUqR1arM8+IzxpbgUeJlc9itQwKVlo7R8eiz7P9B9vv6Me77V4s9pvUlQ0WN
	 IQ1lBI8ghSxqEx71teTGY+xuYIOxw1bXG2VMBCAFDshbsJXmDIhFtVdbS0JnQoAw2zUgR
	 e8MpgNMuCTL0hh3DQQPe0KJ1ALOBMYtnWLzybZNiJ5Q29f3cEKlT1sX3l8fsE3EH21A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795755222;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=bpP6apICunsjQiC2NYipCrZAuI/2x2XzovroCNJcJHo=;
	b=2B7ayytp8D9MZJ4F2f7vfmiTIhs7biopF3kkCeBrDHFLvX+gxgMTTVUAlcZH02d1tse+
	 NgRlWHj9QuwVLmd8avQhGFyn4EdvvOiw7nKRM495nPZhhZhZORHa8mwxcWNbIEAitmnAz
	 EORvnQ/sOcuRb6TYUQWTqyGODLGar/sjLCsbHF5yhGxsgV4Dc6Sc9WxVk61TQJRSIFY62
	 M7zqGgQ/IlGAnHEUT1KRh9ERFBHUvb7Jh+piN22rVECGo9BNDarVpN6Pp7eqI1YqIy1dy
	 /oNm7yIp0Nnv5l3SrGi5EfVvhfF1k+11qATUV/JnjQxtoFVG7NWGbtmcyJDiGeV4JWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W+3MOtJe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFE1606A31E;
	Fri, 27 Nov 2026 04:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W+3MOtJe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385D01F00898;
	Fri, 27 Nov 2026 04:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795755222;
	bh=bpP6apICunsjQiC2NYipCrZAuI/2x2XzovroCNJcJHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W+3MOtJeMu48yDokvdJKc8chqrBKknms/wMOt1+s2YoXX2SbTpafyNqMusWrpDbkm
	 h7qBy7K7glwgYEwIi9vDUIk8W8zC0XurpXM/gfJwvH6w57raM8oTTWR8p6dTD8WSMQ
	 SJFbVBYHp5leVeiRkjrYDqFPdPhiVd1MjfxsdDCKoeQS9lEWc6MvK+7UiFJKlNE2PN
	 qpO0uZBcrQzbbXCDDpbBs1JpaAhJocSz3axW6x9Ivs2R39oLPi7cjtk17xTcrECi6c
	 bMHc3av2we+8tkFBZTtBgkylbHzVXExo+1N/oqY+0NgN34VH+sleEMnKzpPx9Iid47
	 DZoptMrdGPkvA==
Date: Fri, 27 Nov 2026 04:53:39 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Tomasz Figa <tfiga@chromium.org>, chrome-platform@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: sensorhub: Check FIFO read reply length
Message-ID: <awkM0x7IKjAwKeOk@google.com>
References: <20261125121321.1603687-1-maoyixie.tju@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261125121321.1603687-1-maoyixie.tju@gmail.com>

On Wed, Nov 25, 2026 at 08:13:21PM +0800, Maoyi Xie wrote:
> cros_ec_sensorhub_ring_handler() processes number_data entries of the
> EC reply to MOTIONSENSE_CMD_FIFO_READ. It checks number_data against the
> FIFO count and the ring space, but not against the reply length.
> 
> A malfunctioning EC can send fewer entries than number_data. The loop
> then uses stale bytes as samples. Past max_response bytes, it reads
> beyond the message buffer.
> 
> [...]

Added <linux/overflow.h> and slightly reworded the commit message.

Applied to

    https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git for-next

[1/1] platform/chrome: sensorhub: Check FIFO read reply length
      commit: 057370d76cc261a075cd7287ab6e664dcae40377

Thanks!
