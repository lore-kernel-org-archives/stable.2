Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794054991;
	b=S77NBoRuFtRcIrHbT7c4SPKU3fsPa3LG0bg7ENmGJkgtf01ch2ihHAfHOM9+T5yQT+Bq
	 yH/YzQ0zWOs0OoQ7LOgXHJtnEj86+nKYfHHnIIBFZ549DXhMLbeAnBJFp5kxJ6BoUtb0l
	 Rt7SZj1CYLGECGpNfhkYhOxSpPYzGRe7/DGF/9PO+8WvtxNbfFxgHQb7TJ/eWEv1IKcBd
	 yJDxkXtey+iWslx0K3hJpuPLDDHCnqh2tPCTCB/jiUgb7MX9CjY4JUFHemPet2qKu1rKp
	 4VSu1Cy1/de+M29LIFpxtfZFZyO/b1zaYQ9dcXuUvNqubzGvg6J1AwsuXALzLTVZFHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794054991;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=nXEmEmlENrGh9d4c1giNs6lD4BUx26/Hwxc5r1zGzEI=;
	b=upI9imtPvnKgHMx2uGDGZ9uz+xkthy7+aY0O34W168n5TdA5aqNlh5namqcYfc/BB7s5
	 c7j/cejwSkyc3sB1ERaVEDp567uCKU9nfo6v4e6FvmTHUr+HKZ0OZeZKwwymVFSjkLAyn
	 h5EVzD+zaqHA7Jq3IaJUyQY0DxwwvRBthRbaOycj/lilvLSpoJvPB9ClBjddoQ/XyoN/2
	 +K3hyeorX8egwj/AdA31vN6Lvg7oUcReS6uRCTx4NQHA/WvES/5iBOqNwr3xY3IWZLoBj
	 6aARG8GUwXK88ILbzTN6HWqcfb4Gb+F2yrisMshQxpjXXo7JLErzw2rsgbo6ffjvabQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cx7bG3dD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82210606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 12:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cx7bG3dD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B8A1F0089F;
	Sat,  7 Nov 2026 12:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794054991;
	bh=nXEmEmlENrGh9d4c1giNs6lD4BUx26/Hwxc5r1zGzEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cx7bG3dD5pM3/EVv+hlWIDqoSddcLl/WprQw2r9ePpSaJ3+uYNwCablW1PdTtT7k4
	 WZdB/uJGvoaTHD9nJduRXg0SX2I+ZYDDpK2e0v8yfSxVfx6T4aLBCg+5+lWFli1MY+
	 zxPDxgwfRVOQ5s+5PGf48FYwC1IxNyE0pdHt2iitHqcUCC6RCswSMRr1D1JRR95xCi
	 votY6qyKCgx1OGHqQn/sKZ7vQYyj9MaAJkRhQGc7BbQZ3KS0kvJTbDl3/rlcLDu/OM
	 TDTSohRe/CqQZyQ+mPdzSiz4NeUhGRVj0YdmHIcUyW1qAfSQKv5qLBHPlU6aIKWlph
	 CyVQAK2dg6KEQ==
Date: Sat, 7 Nov 2026 07:36:29 -0500
From: Sasha Levin <sashal@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: ojeda@kernel.org, jpoimboe@kernel.org, peterz@infradead.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] objtool/rust: add one more `noreturn`
 Rust function for Rust 1.101.0" failed to apply to 5.15-stable tree
Message-ID: <au8bTVVLQ1inp2PL@laps>
References: <20261107061000-failed-5.15-6b704ec9007a@kernel.org>
 <CANiq72=WkJbn5v5gQove5zo5uKWYSYMNegmbNm-2GkhnW_-x-w@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=WkJbn5v5gQove5zo5uKWYSYMNegmbNm-2GkhnW_-x-w@mail.gmail.com>

On Sat, Nov 07, 2026 at 01:28:36PM +0100, Miguel Ojeda wrote:
>On Sat, Nov 7, 2026 at 12:10 PM Sasha Levin <sashal@kernel.org> wrote:
>>
>> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
>
>5.15 has no Rust, so please skip it.

Ah, we don't parse free form text too well over there. I'd suggest just
sticking to the format we define in
Documentation/process/stable-kernel-rules.rst:

	Cc: <stable@vger.kernel.org> # 6.12.x

-- 
Thanks,
Sasha
