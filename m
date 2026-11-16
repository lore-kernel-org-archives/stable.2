Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794800666;
	b=GL8PvnrktNKoDzFNE90HEQN1o/d9J/KUHoLy7gve+jZf3YYyCwp6MDUBcVuu04MgwR92
	 SuBljZ2mClm8wd6Q69STUGQ843sfOJPq6mh0yrNIBW3GE5BgmA8GZyTgvOQx/+4ZSQPUd
	 R5huOKM8xbuCXDem4J6RHaoQiYQYm8W0MEx8Sa/2KwPZ+k7Drrvg6Kj28qLJ2TaUE6BKG
	 /DCXbftNMLEdMLl2Uq8+lpUybabBQ/LH1gsfkcTRSdxaOXBEpJPEmNxWtlzJSw5h4Bmc2
	 6Wl8iCKOS9YjfF4rvncqaV2RzTdGQmO6RvWN0ixUSWAW8k2WQP15kbmTcCsmxpE+7jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794800666;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=v+oEFSF5FAVe57kexz+WWWyJRElN6EdjpF+6YGfbga8=;
	b=k6D9NDZnRFPRG1HsC13hNyF5EXdPr+eVRy5I9B0zOMS1ujqefVIc839JLEIAi2I4Z7wG
	 5O85e9qU4zZZ4x+qkz1VKxXdQlZVsp2wCOIkVMOo1NXBmgL6L+dGyh/ZiHvhSjB8lTigg
	 QKfIKqJKO4viLlLttQehYKznBGFgKiTxvRT+xzLYxwGy6mU3s9eKRcbDzxqrAuj7QvZ0E
	 dInULYoT3f7ZexFO5WoYUdfhP/fSZdI808RgON0iA7YBLi7tCueSVMc+eIDtASmVqb22U
	 I0XAH0svmr/5WZUOmV3ybMHHFO7iDMd9abQWqD/9M4eZeCtKVY68QH3kK9Ixlq0G4Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gxzAMH0Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008DE606A323;
	Mon, 16 Nov 2026 03:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gxzAMH0Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D4D1F000C4;
	Mon, 16 Nov 2026 03:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794800665;
	bh=v+oEFSF5FAVe57kexz+WWWyJRElN6EdjpF+6YGfbga8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gxzAMH0QhxwxxcDQXdGkGvtMG/+FCh2Ukhd4PZHrh/vMOEyXqV1TIFiEVFu4GuQ/m
	 aGD8+3JHzmMKAEBjBpV+WseVl7eKQFXeoKEq0g/Dj7PzyGmrq1wKaDNbTDcxCnplwv
	 H9V3LEtgCzyoC2VlhsjM/WWugA5j+n87rf3raC7xtTUoATVDGuO2OiTJsxPtL+7nGG
	 +dPgS/bPvrbNVqA4P2jhV5OATcWGAIJwuKeEgF4P5vrN04wQWX9A4uxwMZbxA5IF9e
	 b/1XWsfhBY76H4iftco+UHwIfZDI+wx5qeEZ0stmS6kshGlpIYelWgYQ7LPgWsALuU
	 3vBMoa4IVXsdw==
Date: Sun, 15 Nov 2026 20:44:21 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH net] qca_spi: Avoid unsequenced accesses to jiffies in
 qcaspi_netdev_tx_timeout()
Message-ID: <20261116034421.GA47691@ax162>
References: <20261114-qca_spi-wunsequenced-v1-1-6b219b906db7@kernel.org>
 <490e6ccf-0cc0-4db6-b076-5d4ac5f5b8a4@gmx.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <490e6ccf-0cc0-4db6-b076-5d4ac5f5b8a4@gmx.net>

On Sun, Nov 15, 2026 at 03:08:23PM +0100, Stefan Wahren wrote:
> In general agree, but imo the jiffies itself were not helpful to debug a
> transmit timeout in the first place, so I hope we can avoid adding a local
> variable here.
> 
> How about this:
> 
> netdev_info(qca->net_dev, "Transmit timeout, latency %ld\n",
>             jiffies -  dev_trans_start(dev));
> 
> The timestamp from netdev_info() is much more helpful.

Sure, that is totally fine with me. I will send a v2 with that shortly.

-- 
Cheers,
Nathan
