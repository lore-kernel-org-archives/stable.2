Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C7840FDB6;
	Thu, 11 Jun 2026 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191591; cv=none; b=fhXamVxPB1nGghTQysDFdV+V0dRePW5n+M9g5xk24mKK4fDE58GeA3Zk8ViIZsO0YhVjciWlhqnlHpYGTC0j7U1B58DIlb6Od7am2rI3uy0xWJU6uGw3hE0XX3qHv0IUotH3ffRu7F92OVN5qPfQA+AzdplHN0DNC09AtYBREC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191591; c=relaxed/simple;
	bh=6LXrZ1aYkYPQ86R1qjEGHQtqIpJ4sdxGxcM/MDc8B7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2tI6z5GyfijuIWBa+TXvkBliW5AvUhoHGpEB0fvbLzQGYO5u+so5AozkupvVgu0YJOxXVPv/5vDDKtVRmLx3ZFrLmRgiDs+SwfcGTkSB92wafogCM4hHd50zhjWYXAzZzZZkKtHdTf99MFMJlqsVWPSr67/jIbDEKrskps3r2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKbwMp+G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKbwMp+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B80E01F00898;
	Thu, 11 Jun 2026 15:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781191590;
	bh=6LXrZ1aYkYPQ86R1qjEGHQtqIpJ4sdxGxcM/MDc8B7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bKbwMp+GLD928jlx1bO+ICAuwTGOGQjGBZenytNiE3RTXfjNV4m2i/MolfJ9/Is3G
	 Fh73XwawgD+1MUlrJS2MxpCqJyLK8xgOWbFi2SObepgpXFS3V4G3gAOdMxefCdq+dt
	 f8FmIIbegf7ozBOfr/2zpy28MuoEFI0FclNc9KBfyPigKAdPnzJ1bmB1QY6JT0i4cB
	 YD6BGzJ9/ifn9nGhD98P/qSOCMdJeQvtHS5yOwhNEIDdtMn/3ODC1aiHH0Iq3UKDUm
	 OhHFzQIeKiAwKnp8Zqao30+gAXtHq+zXnT5t1cDyzu35uEg/zg1PSJ17/Epe60VBfT
	 GVtJY4zc+FBaA==
From: Sasha Levin <sashal@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Simon Liebold <lieboldsimonpaul@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	Qi Tang <tpluszz77@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Simon Liebold <simonlie@amazon.de>
Subject: Re: [PATCH 6.12.y v2] xfrm: hold dev ref until after transport_finish NF_HOOK
Date: Thu, 11 Jun 2026 11:26:20 -0400
Message-ID: <20260611-stable-reply-0102@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611121127.3908131-1-simonlie@amazon.de>
References: <20260611121127.3908131-1-simonlie@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jun 11, 2026 at 12:11:27PM +0000, Simon Liebold wrote:
> [ Upstream commit 1c428b03840094410c5fb6a5db30640486bbbfcb ]
>
> After async crypto completes, xfrm_input_resume() calls dev_put()
> immediately on re-entry before the skb reaches transport_finish.

Queued for 6.12, thanks.

--
Thanks,
Sasha
