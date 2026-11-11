Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434108;
	b=5X1GHiMp5bPPYajv7vIeri1s1X6nEFdUCP6nIqabX3TzpkAfSkmA8vY79jiMY7X6jldo
	 VezIJWnZQvjMvVPGNUbk4GWY70My725uxWUBiqbWGKb0z+kEL9cUH7qV5t776swiDo5un
	 0SNGwPDCr2n3sLbD0kQT9gMimu/uo3o0uuXeCKvSMk86F3Wy0oN9KqpGCMEuvqBXVpAR1
	 PfuT2pAa7vHOx/LQNGUF+AjNzROw9beucrpdWnX0VI34VeQ5SkH/c7Bvq1v85S8sIi7I6
	 ruarDBLteFEHfUjvfrRQqMRiTNIYvMtg2ET01qY2eOCYEPN5zmZc8oatLAT6wjDD7/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434108;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UbcRgDNyFh2F21x4S6JQgGB3dfqH18NzrdPOEQs1GiM=;
	b=C5LyzZk7MC4g26zsLyEfRx3rfmjBoTCoRWXTLnU+QtZ5oc3bM4C+tJhw8Vq/z5hFK1U8
	 X4VXp/i1aD1aD3xLUs2BScWgPHjrVJgSTTVmvUq6Z1A7xsiePfxSdqIMaaY5vzamSsVs1
	 fiIWIOkvrXW/oY9dskDIRXGZObXafF9HdQ74WwnbHv/GfzIHpJbknKi3iIrXBjNEV91B6
	 z3gAPJ1UmmF9wWzS8Yw9HAQJj5ARWIh77+DWx6wSFw+Bhj/kEcCrf5ehx5rjFGgB9uacl
	 Tm86X1/l59rFutGu5AejbVdGHkmvULAKWPnfjhOzvUqT8yzqODQXS1YXMK0+DK335+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0n8z6+3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A3D606A8B1
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0n8z6+3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEDD1F00A08;
	Wed, 11 Nov 2026 21:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434108;
	bh=UbcRgDNyFh2F21x4S6JQgGB3dfqH18NzrdPOEQs1GiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V0n8z6+3B3sy03CTecoveioMuXVqbOaEHM59QJq8yzLqwwf4KXkvO0n38vv8RgcSM
	 hmuyypGTRNAD6lSJ+oNuhuy+HsWhaid8nuy7jYPVTehM3vGQWg+iwMJxZ+pEY2PAM3
	 BbZ4o4axENWhbNDSw6kWDwiuE5QNnKRfyOaxUNtDHC/6zJwwd7zrhjTvB6hKonIni5
	 4Z+7MnV22pDxf2HkT2A+V4pXWkTkg45Jl1s7jIYuMsWXV35lvNhCw3wEgieUUPjQFP
	 pT87HdnUa2CAKlmOv080D77dS6tNeNQ1WaQ74RNR8CdbW89aiFCI2whn8bnXMGvhjR
	 ogSGjdYrHEY+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 6.12.y] batman-adv: tt: ignore ROAM flag of received ADD changes
Date: Wed, 11 Nov 2026 16:54:42 -0500
Message-ID: <2026-11-11-1-daily-reply-0009-c7eb754b3d704d721e03@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110190434.114342-1-sven@narfation.org>
References: <20261110190434.114342-1-sven@narfation.org>
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

> [PATCH 6.12.y] batman-adv: tt: ignore ROAM flag of received ADD changes
Queued for 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
