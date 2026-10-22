Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634663;
	b=cr8A7jAB8xS5tJ+KyG2W4OOBsX8u+dJxLQ4+pRV/hqXhyhDt+/gT8ZXpGKSofEpvMxBJ
	 x769SKd5gTNafT1QBrvA6JSc2JwdcZYU7zbOpHCW7NueIAjwS8NSZuHkORLhmDHUCMYFv
	 TH3JRx+2iQJZl3t3rdDEnCI+cT2zM2g1NFwJ1Y4vFV0xUx5aQOHYYZGCYYTi6RyOx/z71
	 szneBOrFv8eYMjyfVoY3aK/yJ9MayMK1W4Gc1vE4DgQliC5aR9dDT12sIWyDRbYzp7iRQ
	 18UZK4HaopfLej+aZ58nFLaxOCWcLTjU0bm+IIQvnufYqCuvB5ITBAVakVrqjpMzGuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634663;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UbstUCtPVTuL7f6rY2OCj4hy2LZCAR1AFPeamSwRsrw=;
	b=0Bz/gQgGICyEy19cqPuovRLJRwLUtOEYYpNvoKN+Jy2uqAoq21WX4wMF7HOmKpKN9uz0
	 eugLDgAbb3yUWSxBeJHr8xCoBdc2vijkHNClyu+10xJgJhzsh4222hnLc6w04QTlNVl0r
	 LgcQu5mZXQIWDVSwogBNpyiHcjOvgBliAT9cfrmQNNj3G/vK2PLOt3EX0zlaNpARdC/ld
	 0uOvnWeEIaTCtSCAkM4Fs0JCZHzKCEnD8J+1WQpiO9IWiiaLC1cvhQBDu+nkEbYusZRoK
	 85exedMxP9kxrc2T6gjWvVCNw+HDCZrcEU1vmKWjmaJr8yAOTZdakOLlUXmvx/LvaNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J+gNMXEw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55422606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J+gNMXEw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA54D1F000C2;
	Thu, 22 Oct 2026 02:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634662;
	bh=UbstUCtPVTuL7f6rY2OCj4hy2LZCAR1AFPeamSwRsrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J+gNMXEwnDfiUkPyrEOWoX8sZVwbShC952vOKm5TWakyl/4/X/CVSgo1Zr9pDCGuh
	 uEz+x0Ntvlo4cmkEnS3h4LTh7LcMEs3UvuFzRI12sHY9UsQAUhjFWxYqmN638IFpu4
	 0xUPljlQLQK0Cd9eCw6Dqbuhq2JbL/lVZf7k0D2MDUbcvHD7vDEiFlDSAmxtq7LjCJ
	 gpBADO0YmG2lWkUcnCZFdaEtrt+3QVgM0H5cwt9Qd44k15VkdMI6rI+ev3rH1MSIfH
	 eSpcoairFiA06Rc061+/liVTEMM+wrOQEOdrax4XvpEGc+99UoXe38Ec6Elu3I97SW
	 bdAGtGVlsWGBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Benjamin Robin <benjamin.robin@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Paolo Abeni <pabeni@redhat.com>,
	syzbot+07a2e4a1a57118ef7355@syzkaller.appspotmail.com,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Subject: Re: [PATCH 5.10.y] sock_map: avoid race between sock_map_close and sk_psock_put
Date: Wed, 21 Oct 2026 22:03:47 -0400
Message-ID: <2026-10-21-1-daily-reply-0022-sock-map-close-5-10-bounce@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019-cve-2024-39500-v1-1-e23b37e81914@bootlin.com>
References: <20261019-cve-2024-39500-v1-1-e23b37e81914@bootlin.com>
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

> sk_psock_get will return NULL if the refcount of psock has gone to 0, which
> will happen when the last call of sk_psock_put is done. However,
> sk_psock_drop may not have finished yet, so the close callback will still
> point to sock_map_close despite psock being NULL.

The 5.10 adaptation adds sk_psock_get() to sock_map_close() but there is
no sk_psock_put() to balance it, so the psock reference, and with it the
socket, leaks whenever another holder still has a reference.

The race isn't in 5.10 anyway: its sock_map_close() never used
sk_psock_get(), because aadb2bb83ff7 ("sock_map: Fix a potential
use-after-free in sock_map_close()") is not in 5.10. The 5.10 range in
the CVE record comes from a Fixes: tag matching the 5.10 backport of
5b4a79ba65a1 ("bpf, sockmap: Don't let sock_map_{close,destroy,unhash}
call itself").

Cascardo's 8259eb0e06d8 ("bpf, sockmap: Avoid using sk_socket after free
when sending") and 6451d58a3556 ("sockmap: Fix sk_psock_drop() race vs
sock_map_{unhash,close,destroy}().") don't apply to 5.10 either.

-- 
Thanks,
Sasha
