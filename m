Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C298395ACC;
	Sat, 20 Jun 2026 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781956517; cv=none; b=hdr/3lRIbepaCtHQAdYXesrrzdl7RDC/GNnflpLjG4HXTnrhJOpRaGA8fm5t1R4Zgl54cE8D9rl1tgydlujMLgv8gdvF3MGN5E5zzy+ZvHrZuTJwjZGet/llScZfU5Lp9cuhuSlaRrBNz9Jbn+sz45Sgeu1OvweVgL4WHSGktHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781956517; c=relaxed/simple;
	bh=uRk0++eKwDhDzKQf9uz3GT6QBL8eNuwDW6TYxdUbAfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHAtfkrFTN3RJmshTG1EEgxMs2AavBmKaJtrqS3wIF54QP8MXxTn61NfGext6fSU73ISDUkREZVjn79Ic7DpgFCnEiJvAu60IpSvTxLGeekQuHl1yrkZM1YtMhfi+gb/SpGvwhcFN72Yxyt9m5tArJ2VR8PGU/sfA0Mscj8pxpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2Z4IMjX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2Z4IMjX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F801F000E9;
	Sat, 20 Jun 2026 11:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781956516;
	bh=5vuHXXZtiRg+9Qwm1NqbLzohm1WwmOSwd2xrCTaBhww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X2Z4IMjXIe7oGwWbr62/hHOmKSBWqBSYNl8EdmUW5zjUO88FVJtrIQCKM1GriYvr9
	 vb5RdD1zRTOtOonY1LoLCjVEyIpqPjfu36yhSWRqDMxNxTzIN8dl8mZ9fV6VhRQDwg
	 kjzgZLHHjPVMsmkff2LzoJj0c4n73k6DXVnjbfOQ5+XH14RzY1Sc2TDhfxALFaMAEt
	 W1S6TaC2xDZGwYD/kQ8ZuqaE6/eFeCR2SUFEMnRhUgwrD4OIV0Egld4+9QP90z6FZG
	 d85l7e26Z2lCj0s8UK/+znFsNVOL+6kLa/jHu1uVATx5zCU6y8Qx9OxJoQxV4Mv+pQ
	 P3dY+cpBTuKUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jiri Pirko <jiri@mellanox.com>,
	Ido Schimmel <idosch@mellanox.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	lvc-project@linuxtesting.org,
	Wang Yufen <wangyufen@huawei.com>
Subject: Re: [PATCH 5.10] netdevsim: Fix memory leak of nsim_dev->fa_cookie
Date: Sat, 20 Jun 2026 07:55:00 -0400
Message-ID: <20260619.0012.reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619091507.95142-1-mdmitrichenko@astralinux.ru>
References: <20260619091507.95142-1-mdmitrichenko@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [PATCH 5.10] netdevsim: Fix memory leak of nsim_dev->fa_cookie

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
