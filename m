Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792531463;
	b=YgmMD5018y5GeYCvocN2/RyMzp9fHLn6Tlv1Sq0Fw+dFtyGOCnC6Ex+mXjitBEMNzTSY
	 PBu8EZwASoTpMAZ5jixO2KyDIdG++/MRhtjjLUv0SqqsJ+2gdXIpr0ycvkeaSR07kv7Pi
	 DMFKIYvpBj/al4Xmeugv72msbz3WVZO410gczniDOpsdlq0J6KIm/VfIQW1Kt4oWcgbvx
	 SowcwatCF/C+WuqjN8h3R2yKN91goZc2lDnY9wXajKg5Si0zgSCxWL3y1+dCXHcVG3ZC3
	 h4DJa0g/WuIwuoP1iWQYv4ht9osmPfN21kxwIJ99sRqft+ef7unzQlzfUZyqTDIIuKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792531463;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=STrst9SrpXoSVAK4PC7vTr3xKXi6S1Q42DDDXCj6kpQ=;
	b=WWu2lh2qwSMCsB28EXTHel0asucy9ol00paZXY2imHqryN+znSC5x8UwnFswis7r3Kgs
	 VHjyoiLIte5D8LVEEnqKTJnYJUSWdHNzCm03/uZGQJtVID6lK6TF4TpNyWWXZPS6gVPCM
	 +A/e5AQiFUaO+E15skEOhaH4Psta5pwjq2Sbwak7Dc4OIDzVqy78siunk+yi4ACuTQctV
	 OrQrqAiUFFMMwlbnuR/XP/FgiPm8i3xOFqDAcxsFvtKqzahyKqJQhIt7XZuszxhi1vuDw
	 IcKollyy03Zx34sVmJQLUJSNeG9iSYYcfadaAaKvC6IjAsAzeO+cjYsmLLmcYLtwyTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BW0f4rtW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9468A606A319;
	Tue, 20 Oct 2026 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BW0f4rtW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2301F000C9;
	Tue, 20 Oct 2026 21:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792531463;
	bh=STrst9SrpXoSVAK4PC7vTr3xKXi6S1Q42DDDXCj6kpQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BW0f4rtW14mj7iJ5vAhav2X7ObRlhRt3sWJMfwSNGuRQr9F8etr6VD3Ipkqy6AZ1u
	 u0cTS/0Ul6YcKeAZ1MnASv+HmBySHksVrRkypmINxZxxUXFsNWodfZWSBtTZfTfsfU
	 xxu6RjTSNNQ9bY3kJxlxv3ELjqup41YfwURnTXBWXjM6FuuXiIZH8wrscaz/uU7+QQ
	 vQ6MFLi8idjaBa5JrpbbOTC6bbfIB7bZIpTLMgVI2oOHqwrua6VOfLv6cYqCHN8LQM
	 kjLtHSCctOJ/9oahQ3kFiTqDhHIGqov7/pLeEu2H+eSb64Bt2Nk2VfEVHaqvI0WK6V
	 51F4fSBr9wAFA==
Date: Tue, 20 Oct 2026 14:24:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Tao <taowei@kylinos.cn>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net/sched: cls_flow: avoid integer overflow in
 perturb_period
Message-ID: <20261020142422.7ae3e051@kernel.org>
In-Reply-To: <20261016040330.59041-1-taowei@kylinos.cn>
References: <20261016040330.59041-1-taowei@kylinos.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 12:03:30 +0800 Wei Tao wrote:
> flow_change() calculates perturb_period by directly multiplying
> nla_get_u32(tb[TCA_FLOW_PERTURB]) by HZ, without any overflow
> protection. Since perturb_period is a u32, the multiplication
> overflows when the value from netlink exceeds UINT_MAX / HZ.
> The result can be an unexpectedly short period or even zero.

Same questions / treatment as your cls_fw patch.
-- 
pw-bot: cr
