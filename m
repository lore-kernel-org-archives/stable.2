Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794510980;
	b=5Q8URmk6UvTA46Zg6frvlX72m5A7KPq0DUIdR1JtYbVKkx2V80uQYI4Nm6apxRysRNI1
	 YFR03U2g/kJWeEhGm0tJ/TeM05j88mjjVxZVZJUVzp1plA6S4jvL59POCOy19vXt5Ril0
	 /ILg4+BfcoGo/LYb0ldvG53oaYVoEvRw6E37ZNq6N18tsJ+oVC62rYDJLadT87MXdNGz2
	 lINAuhlnR2GDjh4NKNqnenW5FQ8vO3YFJXXCq1jcDd5ZddXRNP5mgGUGO+WQmAQN0TTHT
	 ksbXb8SGCISCTv9Lz8N1keJ3S9O4JvrEFlMmvxD7Plui8mEGx1QPgsy33JAbZZYFTCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794510980;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=5I8qafzlKyx+3HTz4plEHXvJyZxM7HeqQJIVJQlIMdI=;
	b=UeJ1gCM1VZYnzIph2B+L2VphDAGoLgzKXNc8IoWdlcgOcKE4Ouar4V2EwT/fwjzWGXsp
	 7em8bYV2dIUboZM5IOxudmgApln2vjOhhoHnIjJ0vxKX+1rqtagr1/ls9hX/CBYfySaPz
	 kRZYfBijUS3kzQxKinORbMQiUhw+hLy/t5mRH+7gQqpMF7K33mQGR+Tn/+yRjLT4ghJ1B
	 48fIYTepjbOjpfZuDUwC6qa+tZPHRS11owcmvdJfpmzo+OYn5gnKv6EbzL8KW6eVAkIfF
	 Pc8eX4V1UIkn+//zW+nY/2q8oGRKcrL+oR4igKBq2hc5GSERu3WDD2vR9pspjdN23Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFDBRs92;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74EC606A882;
	Thu, 12 Nov 2026 19:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFDBRs92
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1E31F000C4;
	Thu, 12 Nov 2026 19:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794510980;
	bh=5I8qafzlKyx+3HTz4plEHXvJyZxM7HeqQJIVJQlIMdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SFDBRs92QHDYf0eltURydgpR9InQUAnq3GMXkCzw8gGV7AuZc8sAui1RZMT55ZLQ9
	 egaZmT1m3nvgkMT7wKQ+Vk1Pxt5h5Aod0hwLV61COc234bqOTAu2bZqVzNcWkbgCy9
	 KDcZImxPz3YVGcHzEmQ1gZg/3GOs85YYdvj3W7xKRgw1qBkbIJBwhskXVwo4LJKMpw
	 o6vY6q9gOHcp5IAsgshd/NeEa/3a/ylbSB3mKZj3zv49qDhNjUMmIF0Pc3caO362Sv
	 V5SwpOSN6piOTyNaexGjYNvSWFRSOLetXUaqRy7eOSx+xhBV9/2QDAZSql95TO0ClK
	 zH1F7glZy+jEw==
Date: Thu, 12 Nov 2026 11:16:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, steffen.klassert@secunet.com, Willem
 de Bruijn <willemb@google.com>, stable@vger.kernel.org, Hassan Sultan
 <hassansultan@google.com>
Subject: Re: [PATCH net] net: gso: fall back to skb_segment when fraglist
 cannot satisfy checksum
Message-ID: <20261112111619.14ff70e1@kernel.org>
In-Reply-To: <20261111221129.829218-1-willemdebruijn.kernel@gmail.com>
References: <20261111221129.829218-1-willemdebruijn.kernel@gmail.com>
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

On Wed, 11 Nov 2026 17:10:33 -0500 Willem de Bruijn wrote:
> skb_segment_list() keeps the original transport headers and checksum
> state of its frag_list members. It ignores the checksum bits in features
> and does not initialize the SKB_GSO_CB() checksum state. This breaks in
> two cases:

Does not apply?
-- 
pw-bot: cr
