Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792872698;
	b=cAqPz9HRnb8JjFe+nSn8FM8qM9sBVawYyd6AldEbPSFB1ZM1buAeiLPFZNMQRG3A0OMS
	 wAv/OujTq+jAd27n2WJHgTuwGRw+qxpC+w2G9nvLKWwh0LrWId6Bx75qHv2Qob6JPxMpz
	 Ds5K4A5KpwmGRtykL2X3UdtVYEIYIxo1bHuaDE/HRELLMEzGYd2fJsBk2CCIb6Sb18YeI
	 cGGzJyIpUCkP0lScgJQQjf7JVNT/7Ei8DPBycADhn47mye3nZzL+38ZPEhz+c5/rMXDWF
	 RWKVxsKAY7LDUNDHIxKjgx2ojlPO3Qt/e8AA828sZiPecRuPyQ2vzxkZoW6mk1tEkWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792872698;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=u0Ww+ebOZdeRaxZe9bJb7g9jpmRhKt5mafZdeyrbEbk=;
	b=Jo0fMc0b1EKmmHUe0ZWKzPA6p7xhMPtoNWFvtyluFuztAs3GrFGJGJAefzQtgPdYZCuy
	 H5cxDKRw0lxcDISom4lQhvBU+RdsGXq22FSLqAfb+dnLNImD9QIDSnuG6O6DlsOlC1gZ0
	 5OfwvL2RtC8BYcI6dDKHG7jt7YSqxtw80dTXWMeqDCoYxc/qyccNyt0LSjm9A3OF8j6P1
	 OSf/PWl/niy+ocZmTHHeitAm98fm3wwXRulMRTu+QRpZL/0M0SnqhubvL1b998G4ynAc9
	 2E69SUZmNBgbGDK2d3Mm2nui534CkGnTyU82CHqkER7lQzU1pqURqhbVtQ9q3/oVmkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Jq/ECZ4K";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EA4606A32F
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 20:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jq/ECZ4K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 865911F01828;
	Sat, 24 Oct 2026 20:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792872698;
	bh=u0Ww+ebOZdeRaxZe9bJb7g9jpmRhKt5mafZdeyrbEbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jq/ECZ4KhN9ptsS0aty42zz4SVeitR2ZfX2m2Ss+FGJ7X8N+IxNe6vXi8LUIGBLkD
	 ydCLaPxOJwgFbH+KjRCNHP071T+g7mccgY5Ef3kYOq7qYQexopC6nZwsj7IhYNojqw
	 21won6OrxBxLa8A94wfNsC1cmVTPIlypNvHeqtYNltyr4BHbtfExAbIvhPxRGUSpu8
	 eLvsXyOQd/9lNyVBnjjaCYK5PLr7+0gk2HTHmXLQRitFxBBBN6dMJM+Xby6LSqB+hL
	 VCaa7MGtJElDjShiVD6mvdTKrDAQq2Hw/wl0yvoLPE4l7aRoYnGpmqvHxWvUZXGemp
	 4jrEV0PaTzqGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Steffen Pfendtner <steffen.pfendtner@kernelscan.io>
Subject: Re: [PATCH 5.15.y] net: bonding: fix use-after-free in bond_xmit_broadcast()
Date: Sat, 24 Oct 2026 16:11:11 -0400
Message-ID: <2026-10-24-1-daily-reply-0013-bonding-xmit-broadcast-5-15-bounce@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024124929.5350-1-steffen.pfendtner@kernelscan.io>
References: <20261024124929.5350-1-steffen.pfendtner@kernelscan.io>
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

> [ Backport to 5.15.y: bond_xmit_broadcast() here walks the slave list,
>   not a slave array, so there is no array index or slaves_count to
>   compare. Count the list entries instead and compare against a
>   READ_ONCE() snapshot of bond->slave_cnt taken before the loop. The two
>   can match on at most one iteration, so the original skb is consumed at
>   most once even if the list changes during the RCU walk; if a slave
>   goes away mid-walk, the original skb is freed at the end as before. ]

This does not bound the walk. It still iterates the live slave list, because
5.15 does not have the all_slaves array walk from ce7a381697cb ("net: bonding:
add broadcast_neighbor option for 802.3ad") that upstream indexes into, and
the running index is only compared against the slave_cnt snapshot. If
bond_enslave() links a slave before it increments slave_cnt, or a slave is
appended mid-walk, the loop reaches the else branch after the original skb
has been used and skb_clone()s it. That is the same use-after-free, on a
path the old bond_is_last_slave() code handled.

-- 
Thanks,
Sasha
