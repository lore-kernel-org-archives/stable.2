Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847E6386C20;
	Wed, 17 Jun 2026 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781733147; cv=none; b=NjSu2x05oajh9iQTFRK6Ldnl/y02CTOpGIJGlNrkDDwArXB5sFpMgBGe/RtrvON7Eo2Ui1J9gV9ocMcm0ri2bhXrD1LQciaA83zQCuCSwXLzRdxzroAQAm0v/p/NCn6mKFrQ0RNTFPNRmmPmjP+3PIt+SrzVUTfaASImBanl+Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781733147; c=relaxed/simple;
	bh=u91/Gr8QP7fH6w2fiW94UDBR0FPYyTtWXCVs9PXPN8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mv7jn9hTyBHFFcpIqE8n2vjvHZubPryr70N7RZq/qdxglqnxWMlEX1JDnzbk4IHWCtHYxaWlVlGZkLyf4L7PyACXJ5pcBJOhoarta99F5y+3KYySKfgo0rOu5U+B0iHpw8f87r53Qtb20f/UQrP8TrvPAKBzRYM9Mcqz80iSvvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U28s7e3v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U28s7e3v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74761F000E9;
	Wed, 17 Jun 2026 21:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781733146;
	bh=XBhULN87TTfxM8KHC3ilMiQOCnX7++hxcpXK3eSVbiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U28s7e3vr1Tib0RGPLU81tBoz9VlTgzJ9XndxETY9vLceedtJcdC2w5VUKDoTyQNn
	 +7riiQx+CuAQdhGewnNZ6pJssnCoG5cP7tVs67S8DQCxESYN6O7654PNP4bw2DTWIb
	 zf7jQ9s4BA5N6om67Gin/438ltTFd85CHX2KmfLY4c1vcCljN5Fm9lNVkdXLQpz2US
	 j/rJdnO3pZbaXiBru65m77NXt4YFnMgW9LjPJafRMUAvm9xsi8+tMc/vsOoVl/GFDE
	 5IsxmrTve1qXnFba9PYAQPqOFciuIPZ9oyMgnm9mKi8bvIVAFhs/dwRo6cXGDwoOAD
	 rVk8+4QMBVTbQ==
Date: Wed, 17 Jun 2026 17:52:24 -0400
From: Sasha Levin <sashal@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Michael Bommarito <michael.bommarito@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org, netdev@vger.kernel.org,
	stable@kernel.org
Subject: Re: [PATCH 6.6.y] rxrpc: Fix the ACK parser to extract the SACK
 table for parsing
Message-ID: <ajMXGIoyTqpZCvw-@laps>
References: <2026061543-superior-passerby-d597@gregkh>
 <20260617180410.271223-1-sashal@kernel.org>
 <20260617132704.0e1fe56b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260617132704.0e1fe56b@kernel.org>

On Wed, Jun 17, 2026 at 01:27:04PM -0700, Jakub Kicinski wrote:
>On Wed, 17 Jun 2026 14:04:10 -0400 Sasha Levin wrote:
>> Subject: [PATCH 6.6.y] rxrpc: Fix the ACK parser to extract the SACK table for parsing
>> Date: Wed, 17 Jun 2026 14:04:10 -0400
>> X-Mailer: git-send-email 2.53.0
>>
>> From: David Howells <dhowells@redhat.com>
>>
>> [ Upstream commit 333b6d5bb9f87827ac2639c737bf9613dbae7253 ]
>
>nit: you missed the "skip patchwork" header on this?

Hey Jakub,

This one is a backport crafted in response to a failed backport of a stable
tagged commit.

I followed Greg's template to sending those backports to him, but I also think
that I do want folks to review the actual backport itself.

Do you think it makes sense to add a skip patchwork header on these too?

-- 
Thanks,
Sasha
