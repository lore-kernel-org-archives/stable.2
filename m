Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845208;
	b=dUaw+7CjfHvBqBk8VQUa0sPd5kDjt3yZjZOKOloQbxkSK9LmCqohPgDWFVGDPdTTvkyb
	 Tsc35sJ90iFKiEpazkkj1CH3gKrf2zEeB6hpE0E5rpTmTT9QnNDb4ah7ktMW0koNXYyaW
	 qyhvnIe901yqi9vWI4xigcEifx21qpdmXxDlrK11gvGcnI4WkT7ix/CwMbH3OroM6RFln
	 trqMaJEgISajdxjgXt8r1Fa9ZJtP6iqF4AfylZNJe9zQu3kzfA9Sg5MmsdHBgMb5ADZrb
	 TfyNaP2xH1Lpe1v4KjDRaSjD3kwTKUVrLHettZcLV6rcFWaOdOCxMlcff18yshiaKRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845208;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZX/Pyc0Djr/5FtHAyPaMf08WafPkjjFmzHrO0uPs+gk=;
	b=Gvv791uUoVICRI7QaEB9aywsoJmYc+ybD8VoYG/aAkjZPOrnSA3EhZQyyWPFhPVVtabi
	 6xGXM9cLxY0NQoGCUhlPY5ZmogE1Qqo0o+Ncf+tMrR0ZNoALghT71q3deQxZWzACkak7F
	 GPKo6OacUT1yvnv+IjCF8TwtGihThgbM8nJA3jX1ODGgfgr5Wq66ALM2HABK8cADUMFyK
	 sH4B7Wu6mNX1C0HzoFtwdVrNfI/5cofXSFTs1jsE2iVezPEGWyS3/drw5g+UlLKGtt5VF
	 U9Vje9+u9Q3+V71GFHgb7DppVn+1Ebe8XisZggNmV1bLTOQ326KcISbPgv7+YVeUlYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HwePbW2C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4403F606A322;
	Mon, 16 Nov 2026 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HwePbW2C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5622D1F000C4;
	Mon, 16 Nov 2026 16:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794845208;
	bh=ZX/Pyc0Djr/5FtHAyPaMf08WafPkjjFmzHrO0uPs+gk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HwePbW2CZTy4ui89XEeyTY6BzIPcyQvoBAzZmUESOZbsNK6g0EPoO0RhGj4Rc+g6W
	 lDQ77XrBE+I2j73ddSVgZcauYnypx2TfbgXJodP/Fx2uT1n+uBwQkQ23ZkhHYEtjRd
	 la1JqCxCx+bkp8K7EKWn28zd3CETWtdKFI3CyBoH+Yuu3dc2Dpae/ajrwDM0k2CyGG
	 YrVrYd1B3opyyHtVrIWmoiHct9xpZbHcwQnmM6XRtMjtGS0PPYKpCWC3YUIB2eWnB5
	 hNoXXIIy6XEncxI7sKSnTCdBAL3Bpjv+L283zZFBKIvz9d2rgMrUxlRDyZW9qzWpNm
	 kEN67PP1dkunA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Alan Maguire <alan.maguire@oracle.com>,
	andrii@kernel.org,
	eddyz87@gmail.com
Cc: Sasha Levin <sashal@kernel.org>,
	ast@kernel.org,
	ihor.solodrai@linux.dev,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	dwarves@vger.kernel.org,
	bpf@vger.kernel.org,
	Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH 5.10-6.18] libbpf: fix cross-endian build with newer libbpf
Date: Mon, 16 Nov 2026 11:06:37 -0500
Message-ID: <2026-11-16-1-daily-reply-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261115200505.1494710-2-asmadeus@codewreck.org>
References: <20261115200505.1494710-2-asmadeus@codewreck.org>
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

> Newer libbpf versions also properly ignore trailing data in the bswap
> case, but the patch is too intrusive to backport, just fix the header
> length comparison.

I'm holding this until there is either an ack from Alan on v1, or a v2.

-- 
Thanks,
Sasha
