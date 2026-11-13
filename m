Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597008;
	b=db3jBVG2+9i4SE/49z2Wg7GgZqdDi0/UZTQjmwlpuH64Hs4CEs3FJNvh1UMwKKvZGVul
	 FISGx9A7Zezvjm+fz0S7iRTYvnsd6A8F9j+K61IDdsmJof869R2jXVvSARi1b+kDNueaH
	 2sT/m57flv61sAxHXLz+1HCsHFb6JtgSpy18grUGsNhsduEsOCi7tBt1YU4NtCUNlYc+v
	 CRVabwVGxKw6oHFsGG+zR5B9TEkbEIMy9KDt4TTzlxhfsZpkid+TRd9SJnfHCbg526BGA
	 FWEDtvAx8iz7ENu5+VSCBnvw/y0PHlTnSO3Z0Rhgxv5pWFKS4+7zj9mSZTtC8JVJ5TQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597008;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZqhuZnUr+S6yB6faEDwSZNNPmJzP2iZStrUcVJuCNFg=;
	b=bE4Jo6h8N4+eTRypYlkvJQSRFtNO7/gOLtJiSi8Zs8g93PblIrD24zFH3/+bOEfNHnxo
	 MgKoHMykoLhZTOVeUDiKYhuBkBUt5tlEevKvg+RjMJevOZR7My+wcUgvrdXxnA0D9uNkU
	 gOOzKIUhrFFPjHRY5fa7k4HQTxGaFQKsYUrMg/mqCVqGszhxX5q08EvEEIkteoIs/A1pA
	 4aetl/cg65Ymry1DD+cxGQEmNxfzY/CHc78mG7hI/kLjeo+Y3OTckO4UTwmAMo0ltZLpM
	 vit/I6NxBsfbMpqrxzvewZs1zO1R6i7EOds9CUyzN4lgN7BSw7nvBzONKNbKlggpoOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GdOnnhwL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC81A606A896;
	Fri, 13 Nov 2026 19:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GdOnnhwL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A3B1F000C4;
	Fri, 13 Nov 2026 19:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597008;
	bh=ZqhuZnUr+S6yB6faEDwSZNNPmJzP2iZStrUcVJuCNFg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GdOnnhwL/UVgwV2D5td5vN+up1B+6v/Ekoa7Ntxi6kWAyDEi/JJxnYAMp/zpx/8yt
	 n7lZIqO1BtcNWN8Bfm9ALi0qOvFt2w91maq27vqNFZYlygh38wegXa4/6ukzm6QCKg
	 /prsfYTSTVEcdU58M86yyuqJNCXWVryg4Xb76y8H6ompQ7t2FBbYHpwQHrMNiVUNTr
	 D9w52+xbZWVl8s8VC58CYZcc10eTcop+ujthiN/Vl7qGD53cSkaVBnPhXjHvhp1TN2
	 rpKIXer+EmK286l72BBrvs+DGA2HEPA31CogdleDJYQoP6kBJGq6mOYyRaN7I9lFqE
	 m1gdos+Fly63Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Kyle Zeng <kylebot@openai.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Bjoern Doebel <doebel@amazon.de>
Subject: Re: [PATCH 5.15.y] net/packet: check TX_RING fragments before memory accounting
Date: Fri, 13 Nov 2026 14:09:53 -0500
Message-ID: <draft-0003-redoebelpacket515@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112202311.1603376-1-doebel@amazon.de>
References: <20261112202311.1603376-1-doebel@amazon.de>
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

On Thu, Nov 12, 2026, Bjoern Doebel wrote:
> Subject: [PATCH 5.15.y] net/packet: check TX_RING fragments before memory accounting

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
