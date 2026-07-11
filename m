Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF133A9D90
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 10:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783765262; cv=none; b=h8R04C4TY54w4f6LRhwvLX3zjY8g4z9FV7fgZnjTRK9wJZCbFTg2rLqbb5xuZhYru1V9+v97It1qg++qjeXFXnkB5hqW8Md5urDTVFtoAdQiJi/5Hs+aCC+TH45qt2ydV9sKPoPOB+Af3Q+grgHZz6pKjvDcr0PRSiCRpC3Uu9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783765262; c=relaxed/simple;
	bh=xR8ynoCxEWhOAOUflzBK1B0mn6ud3lqJ2p7N81/a23E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fHP2DQrsJ/FFCQdh6hrKNn96Iefr9rFWnmSsEMf8fh9O901HaIn5LAyflng9bMEbpE6Wa35SE1N7eIrOQ3Fa8o8fU3POZAcqPGdAzy3HIwzuvR86XyiYhkeJEvHLtyo0sg4CDHtsioppWhp1uZC65OIDLIHEMArqpxAaJMepO5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qg4UaXiL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qg4UaXiL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8591F000E9;
	Sat, 11 Jul 2026 10:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783765260;
	bh=90bufOZJD2eNeipq2T0CjdC+A8+i9udmsuErCstDj/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qg4UaXiLZ6lrlPt5/ZTWj0osKvAuzkAXODn9hUUCBY5rUmTmdCnQlCn84SSze8+zO
	 0MjWQ0Zk9zQa9FIU0E0gmrNcIRTi8uZrMPdkfdwy3D+V/34meJM/ejy1nSQglQal1E
	 qm+ZnmFMFKRJdeAU0Ws6JK3EGo+WVu0wjaRNX1WfaapO8GCRasQa9SY+G0rgXfCLDi
	 bOHbJlAdOGU4Ni0glLJI3EL01TVwJa2GXFytQvxd7wuU0TuDH92JczK9NXBuc6hy+B
	 OLcbD6NUlImNoKxLHUdghr2VH4Do4tHIommMqX/rzuzeyICuf7rttpQo+C4ZiHGjNN
	 vSCCeY9CZ6qOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Michal Kosiorek <mkosiorek121@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Mark Bundschuh <mkbund@amazon.com>
Subject: Re: [PATCH 5.10.y] xfrm: defensively unhash xfrm_state lists in __xfrm_state_delete
Date: Sat, 11 Jul 2026 06:20:55 -0400
Message-ID: <20260711061631.agent5-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710223015.3831465-1-mkbund@amazon.com>
References: <20260710223015.3831465-1-mkbund@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> From: Michal Kosiorek <mkosiorek121@gmail.com>
>
> [ Upstream commit 14acf9652e5690de3c7486c6db5fb8dafd0a32a3 ]
>
> KASAN reproduces a slab-use-after-free in __xfrm_state_delete()'s
> hlist_del_rcu calls under syzkaller load on linux-6.12.y stable

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
