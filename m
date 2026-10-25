Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792971002;
	b=ndSUwR1oFA3f56vQY9hOdytnFPj5jH6jLvIgZ8VDO2+7cfIQ2mNq7gKGNj6LrMLMRP4+
	 zsd4W/z+A3MHINUHMsnep71E1DSGkQTevaiU/kIFfFsEdibD+YmgAWK/dTU9IW5emk7wH
	 H3+h8YC3+P4caIsxCMO0ZErCdowBbjRMc1l7RSrF5NEPxaxWqlz0mbH5qQght3ntfVeMe
	 hmnbKw66izYvvVKHqloRVf84DVcA6IeQDVThv0LKSUCdrud/N903bk+wjMYnkosxQZg0S
	 StUzVUKfESzpctOq9a592ESQP6usePMcz/KxtIa2WS9ss/zP7XSYtAsgq/GBAFu4+vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971002;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RzQ8NbXm2CkWF1LYmRhNVZOjQUNBJaQfPUBS5cLWn0E=;
	b=wW+nqP2dP4OZMEC2cSOjF06uzik7azfGTRYXnVdXcheQjC0HgiHf7jpnNwAt95hqoQP/
	 TKTycrhU20GPsfa4x23iflDNexCcxc9GhL9K1tN6yFzHgZzfzKFwbBo4BilZc4tyMHULJ
	 rEKwsznZJNG/B2yBaGtXvCGu5Wmp37y1AIbs9ZYepElDlO8C0Hgamjr+Xg3wLZaIVEtYc
	 J+dj9UTC6HAZi37qERS0xZYNSM/jDmjQrm/IzfxsZd3qf284RK/EZ/gV2PW81sAwIrvPS
	 2Ow0B7WaOWW8lVwHQN+fUMJeWOHG6lIM9RYfYklbNWQsyALjPILVDfI+HTedFChAr1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QBj7Usn9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11405606A31D
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QBj7Usn9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F3C61F031E0;
	Sun, 25 Oct 2026 23:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792971001;
	bh=RzQ8NbXm2CkWF1LYmRhNVZOjQUNBJaQfPUBS5cLWn0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QBj7Usn9EDdaOuM3oZ63inZ6sCG63563OSWQrEyPUl2bFzCvoGf0U/XLcMprYBE6i
	 CVX/zVbsXYaDWS1PrA6hYE7ny4hessvbDEj6fNKlIJI3LIpEMjRZZKumc1ucNxB6GR
	 EODaKv4O+60ZQNalrtlXWx4nXtV044ZJ+EAwsmfAfqOpM6IAdgMpCu5ERvfYBEkmUI
	 sG9nmIDoL2L0BRIb8nFX1wol5k2PeOFM+yX5bmflwNWf0Oh6jqqMTnUNtS4ZT+gzYp
	 qx3ZKL8OZ1tnFzSQXit/kE1XHZjp5LhfWEjzsRG9gxGGXCDB7u7Dj/7EP7PdVmi3oN
	 uIA3+3ImNB6Dg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jay Vosburgh <j.vosburgh@gmail.com>,
	Andy Gospodarek <andy@greyhouse.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Steffen Pfendtner <steffen.pfendtner@kernelscan.io>
Subject: Re: [PATCH v2 5.15.y] net: bonding: fix use-after-free in bond_xmit_broadcast()
Date: Sun, 25 Oct 2026 19:29:48 -0400
Message-ID: <2026-10-25-1-daily-reply-0002-bonding-xmit-broadcast-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025084725.84254-1-steffen.pfendtner@kernelscan.io>
References: <20261025084725.84254-1-steffen.pfendtner@kernelscan.io>
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

> Happy to send the 3-patch variant (ce7a381697cb + e0caeb24f538 +
> this fix, as in 6.1.y) instead if that is preferred.

Queued for 5.15, thanks. The v2 as sent is fine, no need for the 3-patch
variant.

-- 
Thanks,
Sasha
