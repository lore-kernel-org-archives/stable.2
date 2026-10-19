Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443363;
	b=D+NFkHpxapEzRRyBBfNDog8NcZbNTYso8gOJPV0/nY00BGiVKstLZE434hT5QzyFNzJI
	 pv/qvGntNjYTFVwT7wZKkFTF6rkGQaQpRG9ymNOr/EkGheLzfbX93st9gRIv9a5x3l+Xi
	 xDfKpKzrRl7uGFMBGBWwkKIwQ41+wwe33GoxzBm5zsPTXBGCpYIB+mqCOxg4r45JCO0ob
	 g2ZHGX9HdsU0HnV2czHlGynL57tXN13eZAJ5EPAXSFuIMPf2deVkGpysQKbLiPP1AriYq
	 D389IViGfQmq6FOXDyIb0/FvSJUfFIl4l5txukEgwFhjytPX23hWjJMv5kE8+PPVWHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443363;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+cwDPQTGDYxgqEr6FBr2E0CEZEj1wWLcc+t2b69rPvk=;
	b=e9EK0tKZXA2vuys9EdRnGlz96CUOQbO+yb2rm9BMY4ohUEzBn3nzxSrxjOuy0itIfI82
	 xKkstsTEQik1FjMGeQI0hE8PRSMbi2UY9/8mduum9bFUSSTkVr/ksSga1ScIyIyTBj8Aj
	 uZotsbEcxfuCHJUOFjtNQKAXsQib3FfPi1d4QClv9ggG5at7dN/P1XDVEHQNwMH4SbR1T
	 LxuVwzkiC3RR3QyPtIH1Xf97AuQoa1wLfGWtoJgTpGo8TkhIpkJQcynGXIxR7TZIZYLBi
	 8xd5yUpb6FCol6dXJZ4V6Wr74BHHsyirvfILyg3N6lPFdy58A2ZQCcwwm573YlTEiRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+RRDdvA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4D1606A320
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+RRDdvA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98671F000C4;
	Mon, 19 Oct 2026 20:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792443363;
	bh=+cwDPQTGDYxgqEr6FBr2E0CEZEj1wWLcc+t2b69rPvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M+RRDdvAK59vNbZFw41Idem0CFP1hqAcbS6w2dFy7jKhzKjSKoAJMFGt3k5kkRhJX
	 ZqWYXx8nznZC8c0b5FDxCdW0q8oXH1MqfapJGpZsZJMevNB8Esvl3MZ2TJoEehhTbT
	 0bqCbc9b0Kw6/G7O6DnTKRB9smPkVEYvM+3/YlTxRgoenHc7yk39LDrxb6CBGJD3m2
	 xKtDqgAE3jFJVAazhnRBk9uP1QCb+QryFGvwMUHBiuJ+tBXltp/zlkAVGiM5f9dcQA
	 ZdZadjxiNpC4+aCrntE6/G5DR83gJ8kUwjmzLb8Ec04X6cHuYU5XlfVKqSGZN3u8Mb
	 ngmdHFqFuLa5Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Benjamin Robin <benjamin.robin@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Johnny Hao <johnny_haocn@sina.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 5.10.y] bpf: Do mark_chain_precision for ARG_CONST_ALLOC_SIZE_OR_ZERO
Date: Mon, 19 Oct 2026 16:55:38 -0400
Message-ID: <2026-10-19-1-daily-reply-0013-bpf-mark-chain-precision-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019-cve-2022-49961-v1-1-ed1f29472e68@bootlin.com>
References: <20261019-cve-2022-49961-v1-1-ed1f29472e68@bootlin.com>
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

> Precision markers need to be propagated whenever we have an ARG_CONST_*
> style argument, as the verifier cannot consider imprecise scalars to be
> equivalent for the purposes of states_equal check when such arguments
> refine the return value (in this case, set mem_size for PTR_TO_MEM).

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
