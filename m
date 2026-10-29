Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793234785;
	b=utbxJ/gT9ymcCVJKvDHAk2BRqQ6QufJjZmGu2hmfGtRwnzuTwEvFJ++LdLAaPQop3x9s
	 I+acHClNnT//M3QiPNjrTkUPg7LmO1vJj6z6iusAEtk3sFihUhhE3eRmXdbnOCi6gSFdp
	 csfjhjgeWbbCdysHaIIrKIDvRaPiiDEPW5rm0lZzwKUhT7k83rFv0Q9t3adJKxC0kBGFM
	 mNGu2zkL9/ERQqAcxJVXIBEM6kgkwxzDTSvdTAecG5qdaIZIgEEmFCkDY5+7Zq+e4uLp8
	 e/3nu/g5nVsf88K3QHNygKhtb/jOJhUKrDR25gKtMRmF3EaCDonNVg/plFER3q387tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793234785;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=AWpBuD0eGWaQmRug6Na7k4hqC8NUHlBhmAS+HYM3HWI=;
	b=KpYLvj024D3mdaoBzkPkx8xmHPQToE342Uk9oQOXKa1MRahI5Y1q/TVOrqn21hHvslVP
	 YL+limTAAV3PcJ2tA3GuGm935IMTJkZ5bWk8Ckilt8GbXH2yHh+ZlG2k+jn8nwnBf396e
	 J13+iMcljxmWRF1KkczPeEzA65KGXNWvyVWtkQYqU4t+jfnnTCESE9o/VT5LgQckKYFEF
	 pp3qcyqP1G09BCKnc5KwtoY5abaMuTU6NvY6x4/ikFqM5so74xITk6HSWPv0RUZwMEIl2
	 iA6ejlXRcjsTFxmHq/LHbKy9mnuczQ/cZWyA6Bm2qCP7hoHsiUyCyhbx1gKl2rwVz7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P28EJu15;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7B4606A31A;
	Thu, 29 Oct 2026 00:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P28EJu15
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1551F01825;
	Thu, 29 Oct 2026 00:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793234784;
	bh=AWpBuD0eGWaQmRug6Na7k4hqC8NUHlBhmAS+HYM3HWI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=P28EJu15K4BpLeq0eMQkjjymvz0kCB1gPdzcfKGrzhnumpOrP/6xeNNQJzibA6k+k
	 o+pcyKK0NsnnDlEHx5W9jiANCHCGNnWHzYzTt6Es6PTMivBvVIGT0BnDB28wCDSmjo
	 gW/vllkxMmqeuct87YuNXwtPkt1uzEtT9h/6QJsXZA/Z/vfdc2HxU5cgFU2FmnyFfg
	 cnuvq4xfTsRmFoVwCLf3Hp1T1WRC+EKo4xYIBbWCH8awY51mQKZQ3hpWTPiehwIznS
	 K8gbqACdwsdOU+W4koSvMs1KfIgjuS67Dhg62mMgQiyKZpfhPae8oYvop4mmtuRztc
	 7aJM0BFhtaCfw==
Date: Wed, 28 Oct 2026 17:46:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org, Sven Eckelmann
 <sven@narfation.org>, stable@vger.kernel.org
Subject: Re: [PATCH net 08/10] batman-adv: tt: only update flags for TT
 events
Message-ID: <20261028174623.66e0024b@kernel.org>
In-Reply-To: <20261026085309.1074911-9-sw@simonwunderlich.de>
References: <20261026085309.1074911-1-sw@simonwunderlich.de>
	<20261026085309.1074911-9-sw@simonwunderlich.de>
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

On Mon, 26 Oct 2026 09:53:07 +0100 Simon Wunderlich wrote:
> Fixes: cea194d90b11 ("batman-adv: improved client announcement mechanism")

No such sha. Could you fix please? bots will scream at us if we pull as
is. Also - please drop the assisted-by tag on patch 2 - those are not
required any more and checkpatch is apparently buggy and flags it.
