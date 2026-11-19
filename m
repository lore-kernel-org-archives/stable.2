Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104519;
	b=Rho1gS2/1BLMjCeJJLNydaQJvuqqsXVIprgHAiCKXy6oIcWALEJekaQv6goh68ypMI4m
	 mIM3HojnZzOIOX3G/ZPQbI3UGIktKmIkta7dqMnC38VFyfUwGx4HPcTCnuAQewlwfiXOp
	 3PJtlro2GLPUmWLzu22fWZCIsY0B6syJEYoS2/F7bXD9MG2/jhEFjV3+2SVg26RxY/V7s
	 fjuYiayH0p+BTOJFW7j7I3+uFY5iB2OBlkp96KLZfjQdjhTXQ/MvfpbonU0/aXQn20MmS
	 ZQY4qTrA80HFgbeT/NxoHkH6RaNquUnTJ6vwTUKf2Kgprw0VfEfmxcWqQyuwskpophQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104519;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nQzuY4eTt4o8Je2TgprHx3t3erfXmz/v+b5bATdP9VA=;
	b=3OSjakUYE4MxsW538DXdwTcaytsok+nw5WgZJKfStvtBadQxnyl1ncEfoUvCIuGdgsu0
	 cgBnXL1RNTjAYjxHYEBCiWCdvI/QCFqBzUVAMJ4TQLhpLlm3lmzOC63G3r1UAX1Nzf3Bf
	 kdap55RUv8pXWnnthNLmK5re1j0qI/FlzWMqjhbN5srKVxUzm2yrcoXAwEtFWrLbu3ynU
	 6WBbFfZvkx9kmXjCX+US55BK//lrftdR2iB8jEYxP8iyydWp5LHM6iwGjnmtIO2vPreao
	 +qV9Z7WajFSDuFw1uEHg3EI8Y25i+O5Fr9JS+ahgk2kPU1b/Ye6jDS46T23Vm6fZxmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W21dMh8B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAA860A2611;
	Thu, 19 Nov 2026 16:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W21dMh8B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79B81F000C4;
	Thu, 19 Nov 2026 16:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795104519;
	bh=nQzuY4eTt4o8Je2TgprHx3t3erfXmz/v+b5bATdP9VA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W21dMh8BL2RmTg/CRIvILQQacvJrUl/EbgVp4cLa8bbyVekW0EqN4i3RZtaIUasOr
	 pO7fyyrODBA+rkjAHxR08sjtgpb1hQsGO5qGzKZrOR/LpzkIXoD7JIRjI6ar4BKtmd
	 b52ab7Uuwe29Zo2shtz9pDfgXM9xfhS8LLTPmsw+yVPmyCOGy1Un7C64iIDl5RZp2m
	 zjV+oDVvwrkZWXisAWxzIGAka7DS0pqZZBpBazB7g1gre3t8JP3Iu5+qXs6lqJ31kK
	 n4qPAsjfMvwRn4xwFhUTJU8C8wdYRmsqYdhYXmhWn1kqxtDVPOUWkYPLTUrQGJi1wH
	 842o/k0KYpy8w==
From: Sasha Levin <sashal@kernel.org>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	James Sawyer <jamessawyer@outlook.com>
Subject: Re: Request: 44378d02c5aa and 73e08d50eb13 (virtio UDP tunnel GSO validation) for 6.18.y and 7.3.y
Date: Thu, 19 Nov 2026 11:08:07 -0500
Message-ID: <2026-11-19-1-daily-reply-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <DU4P194MB2971D02EB218B47CFBC82525A77A2@DU4P194MB2971.EURP194.PROD.OUTLOOK.COM>
References: <DU4P194MB2971D02EB218B47CFBC82525A77A2@DU4P194MB2971.EURP194.PROD.OUTLOOK.COM>
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

> Please consider these two mainline commits for 6.18.y and 7.3.y, in
> this order:
>
>   44378d02c5aa ("net: always dissect GSO packets in __virtio_net_hdr_to_skb()")
>   73e08d50eb13 ("net: virtio: validate outer protocol of UDP tunnel GSO packets")

Queued both for 6.18 and 7.3, thanks (7.3 already had the first one). I also
queued the tun skb->protocol follow-up on both.

-- 
Thanks,
Sasha
