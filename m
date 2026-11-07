Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794092000;
	b=RxP5KwIhiCP0w/InJJ5wB2pxlUdw82l+WE6ZwLCw2/THfwdwckd+ipNrhpldwAMgXdoS
	 3GAwIEWostXWebc8gcK35/ey6PQQvVVmm0mJteOfZxAXffKdVi78nBV6L7g36bRaMyk1m
	 WNuT9pgYyu22V6lArCdQV8uZLfNJDjSWevVJq5s1PTqoC/Y2n1ZJI+6iS9O1rIqZLJW4m
	 LiRvg04cv9V5MZR9itnj7GUARIfX2HCGmckPMq1vf36F096nR+U/jBonZJ11eTgCHYso5
	 MIUgET1RKDdhe6gM4pahBaCqs+ALat4KmZ98o6763ZABmw+b89zRQzOeMFohFak5iRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794092000;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UasaNuCG7bL2XLnSSApRyhJdoP+i9CBZ0OCNaJkUHfQ=;
	b=0FUeVcHAG3muPEPnc7EpjE5/TbsHQvmvJs9URC6f+eOR7pmfqHmujklX6mVUOb9bNd1f
	 q/BH/Cf15T1Qw0++80wUpZhtgSqC3fD7DRG9NB9M3YYQl+f5iGEcoQHpR5smf0ilJ2W7K
	 VODZJ4UZdveNC4Y8poaRv9zAofEt4zW3s9n0c16VE+n0jTUpWym7lqhRp1qz2rF/sr/Z7
	 052MfSyVAmdAiZwpg5mri/GImxzMixblKMll6j27dXEduL8ALscMmg0z1S1KG/jBjaNTA
	 YL+huN3x8PfA/Z7swz7K3F7O2QsyUe7s/RXjykv9el4sTLVAVFCwM8DKUcG7UpHduZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MKn7ojlH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05C3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 22:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MKn7ojlH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9901F0089F;
	Sat,  7 Nov 2026 22:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794091999;
	bh=UasaNuCG7bL2XLnSSApRyhJdoP+i9CBZ0OCNaJkUHfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MKn7ojlHWkP1OpWl76DAgGOSjz/X+qnuQQeCNwBxgpwaOZfSY9uWwFUuOzhnmKWNo
	 WE2mFAMEjw1gf/2J4iWsQjf2pWlIS5RyJwcprAaJS4GMYc8SS3l+IcC99o7ONgYdfY
	 DFLAdInYxBqh6/HHqSjXloOMMcQvBzYwIB4lH0iarEIKmWujuPTiTjDucS1qZh/pQB
	 lTD3XN7PvCODU9AQqxgNzRlw0IYQa9ssI5TXx7FFTYPROedeB+aJe7auS6qyceKGeo
	 laIky9HcFL95cuH8KTZYKzeRTkzrC0B6r05c3qQNgAj8K81adQhNsXoLZ5QCXP7WNa
	 U3r/LoKHzmS/w==
From: SJ Park <sj@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	kunwu.chan@gmail.com,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm/damon/core: return an error from damos_commit_filter_arg()" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 14:53:12 -0800
Message-ID: <20261107225312.340447-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261107060426-failed-5.15-6f276422aded@kernel.org>
References: 
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

On Sat,  7 Nov 2026 06:04:26 -0500 Sasha Levin <sashal@kernel.org> wrote:

> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

This and six other patches that reported for cherry-pick failure agains 5.15
on 2026-11-07 are not really meant to picked to stable kernel.  Please ignore
those and don't pick them on 5.15.y.

[1] https://lore.kernel.org/20261107060430-failed-5.15-1d2397b2c414@kernel.org
[2] https://lore.kernel.org/20261107060433-failed-5.15-1bfb9384ae0e@kernel.org
[3] https://lore.kernel.org/20261107060436-failed-5.15-cec08aad3def@kernel.org
[4] https://lore.kernel.org/20261107060440-failed-5.15-a1c7fdaf1657@kernel.org
[5] https://lore.kernel.org/20261107060443-failed-5.15-409d2ab6d982@kernel.org
[6] https://lore.kernel.org/20261107060450-failed-5.15-1c3352282063@kernel.org


Thanks,
SJ

[...]
