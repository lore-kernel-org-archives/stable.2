Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344379;
	b=SI5wCkWKxBjHUA8g0CAhFQGwLllmoOaFoKO5B/tLcHx5WZQstaJJMq9xx9NnDZNFcZbf
	 zd7Z8TDElR0TyfN6IUzvun8QR7v8d7qY7PCQ98WudRzf4BXF1D3TW3wRU84uql+1An7BJ
	 0mJAGBMIYM/3XmWC/nVtDp0YsmzDy9deyVskRZpc20W2bkxBUv/COpIi6dzyJ7lRHTpJZ
	 XDwgVZj1b+h7P1fKlCr1gNd8KAowCutIBGCQPf1MI21FdtuDcOULND47a/WSR9iGRyMgv
	 BzHgp2PaNWYOY3Ww9BKl6/dT/lVLErcW3k7tmkJALW/r+fz8NyqodL7Oo0Rz39iz9bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344379;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tLDmw/dg3Wqkro4dxp9Cal7xsLA3l8iVE2cJ1NOyLF0=;
	b=19kbY9pF7BOqhNaGqaLuT62r/WO1XAXb+WO203l/o8KKn0RvVdkjaqhRaqXWBvJ0JvlF
	 TioN2DBL3afX7Ycuc40Z6ovphoXnOSmMI7gttv7V/tmkyqmMq0okiZlI5r39x0oIMjdbT
	 5Eade3CY/xmwcEDvp8HQ/jUG54GsofzKO9jyt/6dxyU+dVQc4JItpCYDAmgMgQcEBz9Q+
	 AQ2UDxbKYBVRXOklioyL0z2cdW5fihbe+iYS7BJeebwi0PCkWLa5znf2XBdR1UivKbFQk
	 OlUNTwjRmBVSv614o7Jh2RZvdf8EBwp8ULtCKsEhez4Nmwd5W1n/RcYiMhssXSXJMJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vk3ouZKl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BC3606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vk3ouZKl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676C01F008A2;
	Tue, 10 Nov 2026 20:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344379;
	bh=tLDmw/dg3Wqkro4dxp9Cal7xsLA3l8iVE2cJ1NOyLF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vk3ouZKl6pNeylpL7dyIp6lLsqC3v7GNEOXWr/+JVdMsfsa5bw4qHcsPGYEmzRb5/
	 6xLhOi6Nalv5dRSCXXZ//d31jaL8DWwS5UGjGwCuzh2THxruwvzfJIixON88BM3eyW
	 NctfivfV385339oI9UAVL5LoHbQWyWT+DioK31yJkkAhlFBYnzDBD8eyaPhDeHIVsd
	 iuoqO0MzZDepcB9MGtnSYbtRbEk8BDV7WAVcoMdB6RremTZFabJ+WigjKuI3cjfmZJ
	 lOy551x514EQWls4V9RIxhMD+Zb6bj4HINPxi4KDfhYl6O09FQRlTWgpLIVysuPtrS
	 BqMKUL6ZQlCTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jiucheng Xu <jiucheng.xu@amlogic.com>,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 6.1.y] f2fs: force out-place update for all writes on compressed file
Date: Tue, 10 Nov 2026 15:59:02 -0500
Message-ID: <2026-11-10-1-daily-reply-0006-f2fs-compress-outplace@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110031424.1730-1-jiucheng.xu@amlogic.com>
References: <20261110031424.1730-1-jiucheng.xu@amlogic.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> f2fs: force out-place update for all writes on compressed file

Looks like we also need 2eebc31ae5f5 ("f2fs: allow pinning empty compressed
files"), which doesn't apply cleanly.

Could you resend each tree with the follow-up included?

-- 
Thanks,
Sasha
